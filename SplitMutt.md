# Split Mail

I like mutt.
Combined with notmuch, it's one of the best mail readers I know.
Although support for fetching and sending email has been added, at heart mutt is a great MUA.
When I started working with Qubes, one of the first things I did was to see if I could get back to the original use of mutt, and separate out the constituent parts into separate qubes.
Turns out, it's easy.

## Why?
First, it allows us to read and process mail offline in a (relatively) sealed qube.
The attack surface is small.  
Second, it allows us to easily separate fetching and sending mail streams.
We can use different Tor routes, different network interfaces, as we want.  
Third, it's fun, and we can learn a lot about the processes behind messaging, and how to organize things in Qubes.

## What?
Breaking down email processing is simple - first, you fetch mail, then you read or process it, then you send mail.  
So, we use one qube for each task.  
Obviously we want the *mutt* qube to be offline, and we can use disposableVMs as the fetching and sending qubes.
These can be firewalled appropriately to restrict network access to only required servers and ports.  
We can use an offline gpg qube to handle any encrypted messages, and any attachments can be opened in disposable offlineVMs.
This means that we protect as far as possible the mail qube from any hostile emails or attachments.
And because the mail qube is offline, we reduce the risk of our messages being leaked.

## How?
Let's start with the basics.  
Most email providers give you details of how you can collect and send mail, by specifying services with an address and port.  
For our example we will use *pop3* or *imap* to collect mail, and *smtp* to send mail.  
Our provider gives these details:  
pop3 - mail.domain.com:995
imap - mail.domain.com:993
smtp - smtp.domain.com:465

# Getting the mail

You might think of using `offlineimap` to grab the messages from the server.
There's one *huge* downside to that - it isn't possible to use offlineimap to get a subset of messages.
Although offlineimap does have `maxage`, this doesn't work with an empty Maildir.
That is, you have to sync the Maildir *first* and then run updates with the `maxage` parameter set.
And so, there will be 1 Maildir on the server, 1 copy on the "receive" qube, and another in the "mail" qube.
This seems like overkill and a waste of resources.  
You may disagree.

An alternative approach would be to use POP3 to get messages from the server.
POP3 is *often* used to delete messages from the server after they are downloaded.
This is, e.g. the default behavior in `mpop`.
This is good for us, because we don't need to worry about what's on the server: we just get the messages, and move them to the mail qube.
If we decide *not* to delete the messages, then we can limit the downloads by filtering - we get the headers, filter by date received, and then download only the recent messages.  
This is somewhat difficult, in that *all* the headers will need to be downloaded before filtering, and for messages that we **do** want to download, those headers will be downloaded twice.

Still another possibility, if one has ssh access to the server would be to use rsync on the incoming mailfile in /var/spool/mail.
This has the advantage of being absolutely straightforward, except that one cant delete the file after fetching it since there needs to be some file there for delivery to work, on the server.
It would be possible to recreate the mailfile after the rsync operation has completed.  
Of course, if the server is using maildirs, then it's simple to rsync using the `mtime` parameter, to get most recent mails.

So there are 3 different approaches: each one has its merits, and each its difficulties.
Choose the one that works best with your server, and the way you want to use/keep your mail.


Once you have the mail, you can transfer it to the mail qube, which is offline.
You could do this with a simple `qvm-move` operation.  
This will work reasonably well - you will need a global rule in the `/etc/qubes-rpc/policy/qubes.FileCopy` policy file.

An alternative would be to use qubes-sync to move the files between the receiver and the mail qube. This is a neat solution, because it allows us to place the files exactly where we want them - in the mail reader's inbox - *and* delete them from the receiver.

# Reading mail

This is easy - have mutt configured as normal, to read mail in the Maildir format (one message per file, instead of 1 mbox with all files.)  
Read the files in the "inbox" - where you have placed them after transfer from the receiver.  
You can set up multiple folders and move/copy files to them as you choose.  
Use `notmuch` to index and search your mail files.

# Sending mail

Because you are using mutt in an offline qube, when you want to send mail, you need some way of storing the messages, and then transferring them to an online qube to send them.
This is just the same as using mutt on a computer that may be offline at times, and the problem has already been solved.

You can use `msmtpqueue` to queue messages until you are ready to send them. There's a script included called msmtp-enqueue.sh which will place messages to send in a directory, (`~/.msmtpqueue`), and you need to set this as the smtp agent in the mutt configuration file.

You can look at the queued messages using `msmtp-listqueue.sh`.
Then all you need to do is copy those messages to the sending qube - you can do this using qvm-copy or (better) qubes-sync. It's good practice to examine the queue before doing this, and to retain a prompt for the mutt-sender copy action.

In the receiver qube, you configure the smtp program of your choice to send mail to your SMTP server, as usual.
The only difference is that you have configured it to pick up messages from the directory where the mails are copied.  
You can use `msmtpqueue` again for this.  
Check the files again with `msmtp-listqueue.sh`, and use the `msmtp-runqueue.sh` script to actually send them.

## Putting it all together
You are going to use these programs:
getmail - to fetch the mail
mutt    - to read it
msmtp   - to queue the files on the mutt qube, and to send them on the sender.

I prefer to use different templates for each machine, all based on a minimal template.
You can do this too, or use a single template with all the programs installed.  
For this example, I'll show the set up with different templates.

1. Clone the debian-10 minimal template to template-receiver.
2. Install network support, getmail, and qubes-sync in template-receiver.
3. Create a new `receiver` qube, and make it a template_for_dispvms
4. Configure getmail in the `receiver` qube
5. Configure qubes-sync in the `receiver` qube
6. Create a named disposableVM called `fetcher`, based on the `receiver` qube.

1. Clone the debian-10 minimal template to template-mutt.
2. Install mutt, msmtp, and qubes-sync in the new template.
3. Create a new `mutt` qube using the template.
4. Configure mutt.
5. Configure qubes-sync

1. Clone the debian-10 minimal template to template-sender.
2. Install network support,msmtp, and qubes-sync in template-sender.
3. Create a new `sender` qube, and make it a template_for_dispvms
4. Configure msmtp in the `sender` qube
5. Configure qubes-sync
6. Create a named disposableVM called `poster`, based on the `sender` qube.

1. Create the policies to allow sync between `fetcher` and `mutt`, and `mutt` and `poster`.  
Make sure that you keep the prompt for traffic between `mutt` and `poster`.
Optionally keep a prompt between `fetcher` and `mutt`.


