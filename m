Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA16127
	for <selinux@tycho.nsa.gov>; Mon, 20 Jan 2003 08:58:15 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA25147
	for <selinux@tycho.nsa.gov>; Mon, 20 Jan 2003 13:55:27 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id NAA25143
	for <selinux@tycho.nsa.gov>; Mon, 20 Jan 2003 13:55:26 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, selinux@tycho.nsa.gov
Subject: Re: Debian Kernel Images
Date: Mon, 20 Jan 2003 14:57:53 +0100
References: <20030120124808.A28400@lemuria.org>
In-Reply-To: <20030120124808.A28400@lemuria.org>
Cc: bam@snoopy.apana.org.au
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hBAL+Qihtvknp06"
Message-Id: <200301201457.53609.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_hBAL+Qihtvknp06
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, 20 Jan 2003 12:48, Tom wrote:
> Jan 20 13:33:16 nsa3 kernel:
> SELinux: initialized (dev 00:00, type rootfs), not configured for labeling
> Jan 20 13:33:16 nsa3 kernel:
> Jan 20 13:33:16 nsa3 kernel: avc:  denied  { read } for  pid=1
> exe=/sbin/init path=/ dev=00:00 ino=1 scontext=system_u:system_r:init_t
> tcontext=system_u:object_r:unlabeled_t tclass=dir

OK, so what you are seeing is a rootfs access due to the kernel 
inappropriately failing to close some file handles in a kernel thread.

I have attached a patch to fix this, Brian please include it in your next 
kernel build.  Also are you using the Debian kernel-source package?  If so 
then a bug should be filed against it requesting the patch to be included.  I 
intentionally removed the patch in question when Steve added it to a LSM 
patch because I believe that as it is not an LSM issue (just a general kernel 
bug) it is not required in an LSM system (it is less necessary in a LSM 
system than in a non-LSM system) and therefore is best avoided so that it 
doesn't needlessly cause patch conflicts.

Please note that as far as I am aware I was the first person to discover this 
2.4.20 kernel bug, and I did so through SE Linux blocking (and logging) the 
inappropriate access.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_hBAL+Qihtvknp06
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="initrd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="initrd.patch"

--- linux-2.4.20.lsm-old/init/do_mounts.c	2002-12-13 19:33:23.000000000 +0100
+++ linux-2.4.20.lsm/init/do_mounts.c	2002-12-13 19:36:48.000000000 +0100
@@ -812,6 +812,8 @@
 	/* switch root and cwd back to / of rootfs */
 	sys_fchdir(root_fd);
 	sys_chroot(".");
+	close(old_fd);
+	close(root_fd);
 	sys_umount("/old/dev", 0);
 
 	if (real_root_dev == ram0) {

--Boundary-00=_hBAL+Qihtvknp06--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
