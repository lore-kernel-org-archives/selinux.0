From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Joseph A Nagy Jr <joseph_a_nagy_jr@charter.net>,
   "'SELinux@tycho.nsa.gov'" <SELinux@tycho.nsa.gov>
Subject: Re: Linux Wipe Disk Utility
Date: Thu, 14 Aug 2003 09:45:15 +1000
References: <E2462F68A99DB74D8AEDF13B261B1BDD02A69594@Larry.widevine.com> <200308131757.18235.joseph_a_nagy_jr@charter.net>
In-Reply-To: <200308131757.18235.joseph_a_nagy_jr@charter.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308140945.15801.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 14 Aug 2003 08:57, Joseph A Nagy Jr wrote:
> Unless I'm mistaken, files on ext3 have their inodes automatically
> zeroed out upon file deletion. If this is the case, the above solutions
> are entirely unneccessary (at least the linux ones).

This has little to do with SE Linux, but your message above may mislead people 
so I think I need to respond.

Inodes are not blanked on "deletion".  In Unix Inodes are not deallocated 
while a process is using them, so often an Inode stays around until shutdown 
time because one process is using it (this is the cause of "df reports no 
free disk space but du says hardly any space is used" which confuses so many 
people).

If a process runs in the background and keeps a file open then it is possible 
that fsck will resurrect the file in lost+found if reset is pressed (if a 
machine is hacked it's strongly recommended that you pull the plug so you can 
force this to happen with debugfs).

Even when the Inode is cleared your troubles aren't over, the data blocks on 
disk are not cleared so inspecting the raw disk contents can reveal the data 
(there are many companies that specialise in such work, I can recommend a 
friend off-list if people need such work).

On ext3 the "s" attribute allows zeroing a file on deletion, but recall that 
such deletion does not happen while a file is in use.  Also the "s" attribute 
has to get applied to all the things you want it applied to (which may be 
difficult).

There is a need for doing better things for data protection on Linux than just 
relying on the base OS functionality.  Setting the "s" attribute and using an 
encrypted file system with the key stored on removable media may do the job.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
