Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h97FU6Wt012182
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 11:30:06 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h97FU40p007950
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 15:30:04 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
	by jazzswing.ncsc.mil  with ESMTP id h97FU3r7007938
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 15:30:03 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: /selinux/enforce permissions
Date: Wed, 8 Oct 2003 01:29:48 +1000
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
References: <200310080000.51892.russell@coker.com.au> <1065536810.3919.221.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1065536810.3919.221.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310080129.48815.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 8 Oct 2003 00:26, Stephen Smalley wrote:
> On Tue, 2003-10-07 at 10:00, Russell Coker wrote:
> > Wouldn't it make sense to have the permissions 0644 for /selinux/enforce?
> >
> > Or maybe even 0666 would do?  After all either SE Linux is controlling
> > it, or it doesn't matter too much...
>
> What rationale do you have for opening up access to it further?  Least
> privilege and defense in depth suggest that 0600 is the right mode for
> /selinux/enforce and /selinux/load, even though you also have to pass
> the SELinux permission checks as well.

The old SE Linux allowed the avc_enforcing() system call from any context, and 
when the machine was not in enforcing mode avc_toggle() could be run from any 
UID.  If we want to preserve the same functionality as old SE Linux then we 
want mode 0644.

Detecting whether SE Linux is in enforcing mode is quite easy, you can try 
dmesg, if it can't do anything then you are enforcing mode.  If dmesg does 
work then it will usually tell you enough to either determine whether it's in 
enforcing mode or the tests you need to perform to determine whether you are 
in enforcing mode.  So 0644 does not seem to give away anything that can't be 
obtained in other ways.

I wasn't entirely serious about mode 0666, although that would be required to 
give the same functionality as the old SE Linux.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
