Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i91HiCrT003348
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 13:44:13 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i91Hi9EZ008715
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 17:44:10 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: jwcart2@epoch.ncsc.mil
Subject: Re: policy patches
Date: Sat, 2 Oct 2004 03:44:04 +1000
Cc: SELinux <selinux@tycho.nsa.gov>
References: <200409292354.15227.russell@coker.com.au> <200409300620.41527.russell@coker.com.au> <1096648965.13366.35.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1096648965.13366.35.camel@moss-lions.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_kdZXBg95O3VQrl3"
Message-Id: <200410020344.04225.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_kdZXBg95O3VQrl3
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, 2 Oct 2004 02:42, James Carter <jwcart2@epoch.ncsc.mil> wrote:
> Mostly merged with the corrections.
>
> These two lines caused things to break, so I held off merging these for
> now.
> +/sbin/kmodule  --      system_u:object_r:kudzu_exec_t
> +/sbin/start_udev --    system_u:object_r:udev_exec_t
>
> These are the denials I am seeing:
> avc:  denied  { unlink } for  pid=705 exe=/bin/rm name=.udev.tdb dev=tmpfs
> ino=927 scontext=system_u:system_r:udev_t

Version 7.85-1 of the initscripts package fixes the restorecon command to use 
the -R option to label all of /dev.  If you upgrade to the latest rawhide 
then the start_udev labelling should work.  NB  I sent the patch to you 
before rawhide was fixed, this was intentional as neither patch worked well 
without the other so there was no benefit in delaying.

> avc:  denied  { search } for  pid=856 exe=/sbin/kmodule
> name=usr dev=hda2 ino=162881 scontext=system_u:system_r:kudzu_t
> tcontext=user_u:object_r:file_t tclass=dir

Looks like either mis-labelling or you have /usr on a different file system.  
I guess we have to add a dontaudit rule for that for when /usr (or /var or 
whatever else it may access that isn't on the root fs).

> avc:  denied  { getattr } for  
> pid=856 exe=/sbin/kmodule path=/lib/modules/2.6.8-1.541/kernel dev=hda2
> ino=930725 scontext=system_u:system_r:kudzu_t
> tcontext=system_u:object_r:modules_object_t tclass=dir

I've attached kudzu.diff to deal with this issue and the above.  Please try 
including those file contexts changes, with kudzu.diff and the latest 
initscripts it should be fine.

> avc:  denied  { 
> setattr } for  pid=2402 exe=/usr/X11R6/bin/Xorg name=dri dev=tmpfs ino=7757
> scontext=system_u:system_r:xdm_xserver_t
> tcontext=system_u:object_r:device_t tclass=dir

I think that Dan's latest patch allowed that one.

> The xdm_xserver_t device_t:dir setattr denial is not due to this patch.
> It is the only denial that I have been seeing lately; I just haven't had
> an opportunity to look into it more.  It doesn't appear to cause any
> problems though.

Long term udev has to deal with that too.  The X server should not be creating 
device nodes.  Quite a bit of work has recently gone into reducing /dev/mem 
access but allowing arbitrary device node creation wastes that.  It'll be 
fixed eventually (but at the moment we are already busy enough with udev 
issues).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_kdZXBg95O3VQrl3
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="kudzu.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="kudzu.diff"

--- /usr/src/se/policy/domains/program/unused/kudzu.te	2004-10-02 03:36:11.000000000 +1000
+++ domains/program/unused/kudzu.te	2004-10-02 03:40:37.000000000 +1000
@@ -15,7 +15,7 @@
 allow kudzu_t etc_t:file { getattr read };
 allow kudzu_t self:capability { dac_override sys_admin sys_rawio net_admin sys_tty_config };
 allow kudzu_t modules_conf_t:file { getattr read };
-allow kudzu_t modules_object_t:dir { search };
+allow kudzu_t modules_object_t:dir { getattr search };
 allow kudzu_t modules_dep_t:file { getattr read };
 allow kudzu_t mouse_device_t:chr_file { read write };
 allow kudzu_t proc_t:file { getattr read };
@@ -81,3 +81,6 @@
 file_type_auto_trans(kudzu_t, etc_t, etc_runtime_t, file)
 allow kudzu_t tape_device_t:chr_file r_file_perms;
 allow kudzu_t tmp_t:dir { search };
+
+# for file systems that are not yet mounted
+dontaudit kudzu_t file_t:dir search;

--Boundary-00=_kdZXBg95O3VQrl3--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
