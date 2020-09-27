# Split Mail

I like mutt.
Combined with notmuch, it's one of the best mail readers I know.
Although support for fetching and sending email has been added, at heart mutt is a great MUA.
When I started working with Qubes, one of the first things I did was to see if I could get back to the original use of mutt, and separate out the constituent parts into separate qubes.
Turns out, it's easy.

## Why?
First, it allows you to read and process mail offline in a (relatively) sealed qube.
The attack surface is small.  
Second, it allows you to easily separate fetching and sending mail streams.
You can use different Tor routes, different network interfaces, as you will.  
Third, it's fun.

## What?
Breaking down email processing is simple - first, you fetch mail, then you read or process it, then you send mail.  
So, we use one qube for each task.  
Obvoiusly we want the *mutt* qube to be offline, and we can use disposableVMs as the fetching and sending qubes.
These can be firewalled appropriately to restrict network access to omly required servers and ports.  
We can use an offline gpg qube to handle any encrypted messages, and any attachments can be opened in disposable offlineVMs.

## How?


