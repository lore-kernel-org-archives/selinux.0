Message-Id: <se502174.064@atlas.snu.edu>
Date: Sun, 16 Feb 2003 23:40:01 -0600
From: "Joshua Brindle" <JBrindle@snu.edu>
To: <kayo@pyra.ca>, <bam@snoopy.apana.org.au>
Cc: <SELinux@tycho.nsa.gov>
Subject: Re: user transparent encryption
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've pondered this myself, suppose you have a great selinux setup
very secure, no easy way to compromise it, but the machine itself
was in a hostile environment (not able to be protected from others
well). What is to stop someone from booting up a non-selinux kernel
and having at it with your filesystems? Nothing. I've often wondered
if there is a way to lock down the drive contents so it is not
accessible 
(at least easily) by a non-selinux kernel, or even the encrypted fs
where the key is compiled securely into a selinux-enabled kernel
so that with a new (possible non-selinux) kernel the filesystem would
not be readable. Do you guys think this is possible? granted it would
make system recovery next to impossible but maybe it would be a 
good option for folks with malicious or ignorant users/-co admins?

Joshua Brindle
UNIX Administrator
Southern Nazarene University

>>> Brian May <bam@snoopy.apana.org.au> 02/16/03 08:43PM >>>
On Sun, Feb 16, 2003 at 08:18:16PM -0600, kayo wrote:
> I am wondering if any of you have heard of a file system encryption
> service that is or close to transparent to users in which couldnt be
> easily compramised even if root was. Or have any ideas on how this
could
> be done. I know using a loopback type scheam that once mounted or
while
> mounting root could steal the key or the data that should be
private.
> Has any one heard of a group that are brainstorming simular
concepts?

What type of attack are you trying to protect your data from?

If you don't trust the adminstrator, there is nothing you can do, root
needs to access the entire system for adminstration. He/she can
commands
like run "su userid" for instance to become your UID. Even SE-Linux
policy won't help, and presumably it is the adminstrator who sets the
policy.

If on the otherhand, you are more concerned about a program running
as root which could be compromised and allow access to private files,
SE-Linux can help by limiting the prvileges that these programs have.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing
list.
If you no longer wish to subscribe, send mail to
majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
