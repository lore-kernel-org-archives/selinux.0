Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAJDf3Rb017753
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 08:41:03 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAJDf1qY029704
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 13:41:01 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id hAJDet0o029695 for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 13:41:01 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "samwun" <samwun@hgcbroadband.com>, "'SELinux ML'" <selinux@tycho.nsa.gov>
Subject: Re: where to download LSM-patched 2.4
Date: Thu, 20 Nov 2003 00:40:43 +1100
References: <013601c3ae97$e658a650$5801a8c0@samgpj2wzuimme>
In-Reply-To: <013601c3ae97$e658a650$5801a8c0@samgpj2wzuimme>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200311200040.43270.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 19 Nov 2003 23:23, "samwun" <samwun@hgcbroadband.com> wrote:
> Before I used LSM 2.4 selinux source, I encountered problem when I was
> trying to install SELinux.
> The problem is the SELinux kernel is able to loaded up after a reboot,
> but
> whenever issuing a command
> "ls --context" or whatever other SELinx related command options, it
> always
> said that the command ooptions needs SELinux kernel to support,  but I
> have

The most likely explanation for this is that the version of the SE Linux 
kernel code and the version of the user-space code does not match.  There are 
two major versions of SE Linux in use, the old SE Linux has 52 system calls 
multiplexed over the LSM system call.  The new SE Linux uses XATTR's and file 
read/write operations on selinuxfs and /proc/pid/attr/*.  As the operation of 
these versions of SE Linux is very different there are no programs that can 
support both (it would be possible to write a program that supports both, but 
no-one has done so).

Does /proc/filesystems have an entry for "selinuxfs"?  If so you are running 
the kernel for the new SE Linux, if not then you are running the old SE 
Linux.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
