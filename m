Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0HBrpIi014584
	for <selinux@tycho.nsa.gov>; Mon, 17 Jan 2005 06:53:51 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0HBpn4X027974
	for <selinux@tycho.nsa.gov>; Mon, 17 Jan 2005 11:51:51 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: kernel error
Date: Mon, 17 Jan 2005 22:53:42 +1100
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <200501102205.36386.russell@coker.com.au> <1105548548.22495.131.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1105548548.22495.131.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Gd66Brg/AVyzCjE"
Message-Id: <200501172253.43350.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_Gd66Brg/AVyzCjE
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 13 January 2005 03:49, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> On Mon, 2005-01-10 at 06:05, Russell Coker wrote:
> > I am getting the attached kernel error repeatedly when trying to install
> > a new kernel package on a Debian 2.6.10 system (stock kernel.org kernel
> > with no patches).  This error happens in enforcing mode but not in
> > permissive mode.
>
> Looks like it might be triggered by a revocation of the controlling
> tty.  If you do a make enableaudit load and then try it again, do you
> see any relevant audit messages for the controlling tty?

I've attached some relevant sections of the messages logged by klogd.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_Gd66Brg/AVyzCjE
Content-Type: text/plain;
  charset="utf-8";
  name="log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="log"

Jan 17 13:45:43 lyta kernel: audit(1105929943.164:0): avc:  denied  { search } for  pid=30322 exe=/bin/bash name=/ dev=devpts ino=1 scontext=system_u:system_r:bootloader_t tcontext=system_u:object_r:devpts_t tclass=dir
Jan 17 13:45:43 lyta kernel: idr_remove called for id=0 which is not allocated.
Jan 17 13:45:43 lyta kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jan 17 13:45:43 lyta kernel:  [sub_remove+233/240] sub_remove+0xe9/0xf0
Jan 17 13:45:43 lyta kernel:  [idr_remove+35/144] idr_remove+0x23/0x90
Jan 17 13:45:43 lyta kernel:  [release_dev+1636/1968] release_dev+0x664/0x7b0
Jan 17 13:45:43 lyta kernel:  [tty_open+254/656] tty_open+0xfe/0x290
Jan 17 13:45:43 lyta kernel:  [chrdev_open+258/496] chrdev_open+0x102/0x1f0
Jan 17 13:45:43 lyta kernel:  [dentry_open+342/576] dentry_open+0x156/0x240
Jan 17 13:45:43 lyta kernel:  [filp_open+77/80] filp_open+0x4d/0x50
Jan 17 13:45:43 lyta kernel:  [sys_open+60/160] sys_open+0x3c/0xa0
Jan 17 13:45:43 lyta kernel:  [sysenter_past_esp+82/117] sysenter_past_esp+0x52/0x75
Jan 17 13:45:43 lyta kernel: audit(1105929943.347:0): avc:  denied  { search } for  pid=30322 exe=/bin/bash name=/ dev=devpts ino=1 scontext=system_u:system_r:bootloader_t tcontext=system_u:object_r:devpts_t tclass=dir
Jan 17 13:45:43 lyta kernel: audit(1105929943.425:0): avc:  denied  { search } for  pid=30328 exe=/usr/bin/stat name=run dev=dm-2 ino=597921 scontext=system_u:system_r:bootloader_t tcontext=system_u:object_r:var_run_t tclass=dir
Jan 17 13:45:43 lyta kernel: audit(1105929943.486:0): avc:  denied  { search } for  pid=30328 exe=/usr/bin/stat name=run dev=dm-2 ino=597921 scontext=system_u:system_r:bootloader_t tcontext=system_u:object_r:var_run_t tclass=dir
Jan 17 13:45:43 lyta kernel: audit(1105929943.563:0): avc:  denied  { search } for  pid=30333 exe=/bin/bash name=/ dev=devpts ino=1 scontext=system_u:system_r:bootloader_t tcontext=system_u:object_r:devpts_t tclass=dir
Jan 17 13:45:43 lyta kernel: idr_remove called for id=0 which is not allocated.
Jan 17 13:45:43 lyta kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jan 17 13:45:43 lyta kernel:  [sub_remove+233/240] sub_remove+0xe9/0xf0
Jan 17 13:45:43 lyta kernel:  [idr_remove+35/144] idr_remove+0x23/0x90
Jan 17 13:45:43 lyta kernel:  [release_dev+1636/1968] release_dev+0x664/0x7b0
Jan 17 13:45:43 lyta kernel:  [tty_open+254/656] tty_open+0xfe/0x290
Jan 17 13:45:43 lyta kernel:  [chrdev_open+258/496] chrdev_open+0x102/0x1f0
Jan 17 13:45:43 lyta kernel:  [dentry_open+342/576] dentry_open+0x156/0x240
Jan 17 13:45:43 lyta kernel:  [filp_open+77/80] filp_open+0x4d/0x50
Jan 17 13:45:43 lyta kernel:  [sys_open+60/160] sys_open+0x3c/0xa0
Jan 17 13:45:43 lyta kernel:  [sysenter_past_esp+82/117] sysenter_past_esp+0x52/0x75
Jan 17 13:45:43 lyta kernel: audit(1105929943.713:0): avc:  denied  { search } for  pid=30333 exe=/bin/bash name=/ dev=devpts ino=1 scontext=system_u:system_r:bootloader_t tcontext=system_u:object_r:devpts_t tclass=dir
Jan 17 13:45:43 lyta kernel: audit(1105929943.785:0): avc:  denied  { search } for  pid=30337 exe=/bin/bash name=/ dev=devpts ino=1 scontext=system_u:system_r:bootloader_t tcontext=system_u:object_r:devpts_t tclass=dir
Jan 17 13:45:43 lyta kernel: idr_remove called for id=0 which is not allocated.
Jan 17 13:45:43 lyta kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jan 17 13:45:43 lyta kernel:  [sub_remove+233/240] sub_remove+0xe9/0xf0
Jan 17 13:45:43 lyta kernel:  [idr_remove+35/144] idr_remove+0x23/0x90
Jan 17 13:45:43 lyta kernel:  [release_dev+1636/1968] release_dev+0x664/0x7b0
Jan 17 13:45:43 lyta kernel:  [tty_open+254/656] tty_open+0xfe/0x290
Jan 17 13:45:43 lyta kernel:  [chrdev_open+258/496] chrdev_open+0x102/0x1f0
Jan 17 13:45:43 lyta kernel:  [dentry_open+342/576] dentry_open+0x156/0x240
Jan 17 13:45:43 lyta kernel:  [filp_open+77/80] filp_open+0x4d/0x50
Jan 17 13:45:43 lyta kernel:  [sys_open+60/160] sys_open+0x3c/0xa0
Jan 17 13:45:43 lyta kernel:  [sysenter_past_esp+82/117] sysenter_past_esp+0x52/0x75
Jan 17 13:45:43 lyta kernel: audit(1105929943.902:0): avc:  denied  { search } for  pid=30337 exe=/bin/bash name=/ dev=devpts ino=1 scontext=system_u:system_r:bootloader_t tcontext=system_u:object_r:devpts_t tclass=dir
Jan 17 13:45:44 lyta kernel: audit(1105929943.967:0): avc:  denied  { search } for  pid=30341 exe=/bin/bash name=/ dev=devpts ino=1 scontext=system_u:system_r:bootloader_t tcontext=system_u:object_r:devpts_t tclass=dir
Jan 17 13:45:44 lyta kernel: idr_remove called for id=0 which is not allocated.
Jan 17 13:45:44 lyta kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jan 17 13:45:44 lyta kernel:  [sub_remove+233/240] sub_remove+0xe9/0xf0
Jan 17 13:45:44 lyta kernel:  [idr_remove+35/144] idr_remove+0x23/0x90
Jan 17 13:45:44 lyta kernel:  [release_dev+1636/1968] release_dev+0x664/0x7b0
Jan 17 13:45:44 lyta kernel:  [tty_open+254/656] tty_open+0xfe/0x290
Jan 17 13:45:44 lyta kernel:  [chrdev_open+258/496] chrdev_open+0x102/0x1f0
Jan 17 13:45:44 lyta kernel:  [dentry_open+342/576] dentry_open+0x156/0x240
Jan 17 13:45:44 lyta kernel:  [filp_open+77/80] filp_open+0x4d/0x50
Jan 17 13:45:44 lyta kernel:  [sys_open+60/160] sys_open+0x3c/0xa0
Jan 17 13:45:44 lyta kernel:  [sysenter_past_esp+82/117] sysenter_past_esp+0x52/0x75
Jan 17 13:45:44 lyta kernel: audit(1105929944.072:0): avc:  denied  { search } for  pid=30341 exe=/bin/bash name=/ dev=devpts ino=1 scontext=system_u:system_r:bootloader_t tcontext=system_u:object_r:devpts_t tclass=dir
Jan 17 13:45:44 lyta kernel: audit(1105929944.150:0): avc:  denied  { search } for  pid=30345 exe=/bin/bash name=/ dev=devpts ino=1 scontext=system_u:system_r:bootloader_t tcontext=system_u:object_r:devpts_t tclass=dir
Jan 17 13:45:44 lyta kernel: idr_remove called for id=0 which is not allocated.
Jan 17 13:45:44 lyta kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jan 17 13:45:44 lyta kernel:  [sub_remove+233/240] sub_remove+0xe9/0xf0
Jan 17 13:45:44 lyta kernel:  [idr_remove+35/144] idr_remove+0x23/0x90
Jan 17 13:45:44 lyta kernel:  [release_dev+1636/1968] release_dev+0x664/0x7b0
Jan 17 13:45:44 lyta kernel:  [tty_open+254/656] tty_open+0xfe/0x290
Jan 17 13:45:44 lyta kernel:  [chrdev_open+258/496] chrdev_open+0x102/0x1f0
Jan 17 13:45:44 lyta kernel:  [dentry_open+342/576] dentry_open+0x156/0x240
Jan 17 13:45:44 lyta kernel:  [filp_open+77/80] filp_open+0x4d/0x50
Jan 17 13:45:44 lyta kernel:  [sys_open+60/160] sys_open+0x3c/0xa0
Jan 17 13:45:44 lyta kernel:  [sysenter_past_esp+82/117] sysenter_past_esp+0x52/0x75

--Boundary-00=_Gd66Brg/AVyzCjE--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
