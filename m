Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3L5UXI4018727
	for <selinux@tycho.nsa.gov>; Mon, 21 Apr 2003 01:30:34 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3L5UUVf013222
	for <selinux@tycho.nsa.gov>; Mon, 21 Apr 2003 05:30:30 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h3L5UR4D013219
	for <selinux@tycho.nsa.gov>; Mon, 21 Apr 2003 05:30:28 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Joshua Brindle" <JBrindle@snu.edu>, <lms@ispgaya.pt>,
   <selinux@tycho.nsa.gov>
Subject: Re: SELinux ISO...
Date: Mon, 21 Apr 2003 15:30:27 +1000
References: <sea32d76.091@atlas.snu.edu>
In-Reply-To: <sea32d76.091@atlas.snu.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200304211530.27850.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 21 Apr 2003 14:29, Joshua Brindle wrote:
> http://sourceforge.net/project/showfiles.php?group_id=21266&release_id=1221
>17 there are iso's available there, i think they are based off redhat and
> they are sorta old

Have you tried them out?

AFAIK no-one has yet solved all the issues involved in having a full SE Linux 
installation process with all files being labeled all the time.  This would 
require that the root media for the installation (floppy disk image or 
CD-ROM) have all it's files labeled with PSID's so that all programs get the 
right type.

A CD-ROM that just does a regular Linux install with a SE kernel isn't 
particularly exciting.

I did some work that leads toward this when the SE Linux kernel code 
initialised itself on loading the initrd, and I had an initrd with a mini 
policy installed (about 30K compressed from memory) to ensure that everything 
it did was in the correct context.  Some policy changes related to this were 
incorporated in the main policy for init.te, kernel.te, and the sysadm_t and 
user_t policies.  I posted one patch about this on 2002/Sep/10, and some 
other small patches went in around that time.

> --
> I think there is a commercial effort to provide these called Westcam(?)
> I can't
> find their url offhand but if you search the archives of this list you
> should find
> them.

Mark Westerman.

> SELinux on Gentoo isn't yet usable without the kernel in development
> mode, but
> it's quickly getting there, I'll make some sort of announcement when
> it's really ready.

What problems are you having?  Post here and I'm sure we can offer some useful 
advice.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
