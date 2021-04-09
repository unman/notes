To use a repository you will need to get my Qubes OS signing key, validate it
against sources in the mailing list, Forum, at GitHub, or against different
downloads via Tor.

My signing key is available at https://github.com/unman/unman  
In some circularity, the repository is signed with that key **but** the fingerprint is recorded in the file `gpg-keys.asc`.
**That** file is signed with my mail key, which is available from https://www.qubes-os.org/team.

# Outline
The general process is:  
1. Get a copy of my Qubes OS Signing key
2. Validate the key
3. Copy the key to a template
4. Import the key to the package manager
5. Add repostory definitions
6. Update the package lists
7. Start using the repository

# Detailed instructions

1. Open a disposableVM and get a few copies of my key - use GitHub, some keyservers, etc.  
If you download from a web page remember that you need a text version (not HTML) and you may need to edit the file to remove extra material.  

2. Validate the key:  
`gpg --with-fingerprint unman.asc` , or  
`gpg2 -n -q --import --import-options import-show unman.asc`

This will show the fingerprint which you can check against the fingerprint from a few places.

3. Copy to a template  
`qvm-copy unman.asc` and select the template you want to use.

qvm-copy the key in to the Fedora template.
