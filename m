Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAL65DRb027393
	for <selinux@tycho.nsa.gov>; Fri, 21 Nov 2003 01:05:13 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAL64fp5026365
	for <selinux@tycho.nsa.gov>; Fri, 21 Nov 2003 06:04:41 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hAL64dt0026362
	for <selinux@tycho.nsa.gov>; Fri, 21 Nov 2003 06:04:40 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: <ZVPA2@imail.etsu.edu>
Subject: Re: Kernel panic: No init found with SE patched kernel 2.6.0-test6
Date: Fri, 21 Nov 2003 17:04:56 +1100
Cc: selinux <selinux@tycho.nsa.gov>
References: <200311202137.AA25034968@imail.etsu.edu>
In-Reply-To: <200311202137.AA25034968@imail.etsu.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200311211704.56652.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 21 Nov 2003 13:37, "Achanta, Venkata Phani" <ZVPA2@imail.etsu.edu> 
wrote:
> VFS:Mounted root(ext2 filesystem)

Here we have mounted the initrc (ext2 is the Red Hat default file system for 
the initrd).

> Red hat nash version 3.4.42 starting

Here we are running code from the initrd, nash is a small shell that's good 
for an initrd.

> Mounting /proc filesystem
> creating block devices
> creating root device
> Mounting root file system
> mount: error 19 mounting ext3

Here we are trying to mount root and failing.  The return code 19 means the 
following (see the mount man page):
       1      incorrect invocation or permissions
       2      system error (out of memory, cannot fork, no more loop devices)
       16     problems writing or locking /etc/mtab

Missing /etc/mtab is no big deal for an initrd.  Errors 2 and 1 are more 
serious and I have no idea what the cause of them may be.  For the Red Hat SE 
Linux release we will have a standard kernel, a standard initrd, and init 
will load SE Linux after root is mounted so we won't have to deal with any SE 
Linux specific issues relating to booting the system.

http://people.redhat.com/arjanv/2.5/RPMS.kernel/
I suggest you go to the above URL and download one of Arjan's kernels.  They 
have SE Linux built in and it'll be much easier than trying to compile your 
own.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
