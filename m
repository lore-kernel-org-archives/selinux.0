Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k08AfkXf017126
	for <selinux@tycho.nsa.gov>; Sun, 8 Jan 2006 05:42:04 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k08AfSqt029519
	for <selinux@tycho.nsa.gov>; Sun, 8 Jan 2006 10:41:34 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 0FE5D61B01
	for <selinux@tycho.nsa.gov>; Sun,  8 Jan 2006 21:41:24 +1100 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 22725-01 for <selinux@tycho.nsa.gov>;
	Sun, 8 Jan 2006 21:41:20 +1100 (EST)
Received: from temp.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 3056E61AFF
	for <selinux@tycho.nsa.gov>; Sun,  8 Jan 2006 21:41:20 +1100 (EST)
Received: from temp (temp [127.0.0.1])
	by temp.coker.com.au (Postfix) with ESMTP id 2E7CAC8064
	for <selinux@tycho.nsa.gov>; Sun,  8 Jan 2006 21:41:16 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: file contexts patch for performance
Date: Sun, 8 Jan 2006 21:41:02 +1100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_KxOwDyjINBp5F13"
Message-Id: <200601082141.14437.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_KxOwDyjINBp5F13
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch applies against selinux-policy-targeted-2.1.7-3.  The main 
part of the patch is to change "/foo(/.*)?/whatever" to "/foo/(.*/)?whatever" 
and "/foo(/.*)?" to "/foo -d" and "/foo/.*", the second part is to replace 
"/lib(64?)/" with separate entries for "/lib/" and "/lib64/".  These changes 
allow more effective use of stem compression.  Before this change on my test 
machine an average of 81.49 seconds of user CPU time was taken for an 
autorelabel operation with a minimal install of rawhide, afterwards the 
average was 79.28 which gives an average of 2.21 seconds of time saved (or 
2.7% performance increase).

This is only a small increase.  My next attempt at improving performance of 
setfiles/restorecon will be to try two levels of stem compression in 
matchpathcon etc.  I believe that this change will provide more benefit when 
combined with two level stem compression than it currently does.  In any case 
it's a simple change and also serves as an example to other people writing 
policy so I believe it's worth including.

At some future time I plan to make setfiles/restorecon take advantage of 
multiple CPUs on SMP machines.  As Intel has announced plans to make all CPUs 
multi-core and appear to be focussing on multi-core and hypter-threading 
rather than clock speed it seems that SMP aware versions of these utilities 
will be needed to take advantage of future hardware.  But I don't plan on 
working on that for a while, among other things my only SMP machine won't 
boot a Fedora kernel.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_KxOwDyjINBp5F13
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

diff -ru serefpolicy-2.1.7.orig/policy/modules/kernel/bootloader.fc serefpolicy-2.1.7/policy/modules/kernel/bootloader.fc
--- serefpolicy-2.1.7.orig/policy/modules/kernel/bootloader.fc	2006-01-06 03:12:16.000000000 +1100
+++ serefpolicy-2.1.7/policy/modules/kernel/bootloader.fc	2006-01-08 15:55:11.000000000 +1100
@@ -1,8 +1,11 @@
-
+ifdef(`distro_debian', `
 /vmlinuz.*		-l	gen_context(system_u:object_r:boot_t,s0)
 /initrd\.img.*		-l	gen_context(system_u:object_r:boot_t,s0)
+/usr/sbin/mkinitramfs	--	gen_context(system_u:object_r:bootloader_exec_t,s0)
+')
 
-/boot(/.*)?			gen_context(system_u:object_r:boot_t,s0)
+/boot			-d	gen_context(system_u:object_r:boot_t,s0)
+/boot/.*			gen_context(system_u:object_r:boot_t,s0)
 /boot/System\.map(-.*)?	--	gen_context(system_u:object_r:system_map_t,s0)
 
 /etc/lilo\.conf.*	--	gen_context(system_u:object_r:bootloader_etc_t,s0)
@@ -10,7 +13,8 @@
 
 /etc/mkinitrd/scripts/.* --	gen_context(system_u:object_r:bootloader_exec_t,s0)
 
-/lib(64)?/modules(/.*)?		gen_context(system_u:object_r:modules_object_t,s0)
+/lib/modules(/.*)?		gen_context(system_u:object_r:modules_object_t,s0)
+/lib64/modules(/.*)?		gen_context(system_u:object_r:modules_object_t,s0)
 
 /usr/sbin/mkinitrd	--	gen_context(system_u:object_r:bootloader_exec_t,s0)
 
diff -ru serefpolicy-2.1.7.orig/policy/modules/kernel/corecommands.fc serefpolicy-2.1.7/policy/modules/kernel/corecommands.fc
--- serefpolicy-2.1.7.orig/policy/modules/kernel/corecommands.fc	2006-01-06 03:12:16.000000000 +1100
+++ serefpolicy-2.1.7/policy/modules/kernel/corecommands.fc	2006-01-08 15:57:58.000000000 +1100
@@ -2,7 +2,8 @@
 #
 # /bin
 #
-/bin(/.*)?				gen_context(system_u:object_r:bin_t,s0)
+/bin				-d	gen_context(system_u:object_r:bin_t,s0)
+/bin/.*					gen_context(system_u:object_r:bin_t,s0)
 /bin/d?ash			--	gen_context(system_u:object_r:shell_exec_t,s0)
 /bin/bash			--	gen_context(system_u:object_r:shell_exec_t,s0)
 /bin/bash2			--	gen_context(system_u:object_r:shell_exec_t,s0)
@@ -71,27 +72,28 @@
 #
 # /sbin
 #
-/sbin(/.*)?				gen_context(system_u:object_r:sbin_t,s0)
+/sbin				-d	gen_context(system_u:object_r:sbin_t,s0)
+/sbin/.*				gen_context(system_u:object_r:sbin_t,s0)
 /sbin/mkfs\.cramfs		--	gen_context(system_u:object_r:sbin_t,s0)
 /sbin/insmod_ksymoops_clean	--	gen_context(system_u:object_r:sbin_t,s0)
 
 #
 # /opt
 #
-/opt(/.*)?/bin(/.*)?			gen_context(system_u:object_r:bin_t,s0)
+/opt/(.*/)?bin(/.*)?			gen_context(system_u:object_r:bin_t,s0)
 
-/opt(/.*)?/libexec(/.*)?		gen_context(system_u:object_r:bin_t,s0)
+/opt/(.*/)?libexec(/.*)?		gen_context(system_u:object_r:bin_t,s0)
 
-/opt(/.*)?/sbin(/.*)?			gen_context(system_u:object_r:sbin_t,s0)
+/opt/(.*/)?sbin(/.*)?			gen_context(system_u:object_r:sbin_t,s0)
 
 #
 # /usr
 #
-/usr(/.*)?/Bin(/.*)?			gen_context(system_u:object_r:bin_t,s0)
+/usr/(.*/)?Bin(/.*)?			gen_context(system_u:object_r:bin_t,s0)
 
-/usr(/.*)?/bin(/.*)?			gen_context(system_u:object_r:bin_t,s0)
+/usr/(.*/)?bin(/.*)?			gen_context(system_u:object_r:bin_t,s0)
 
-/usr(/.*)?/sbin(/.*)?			gen_context(system_u:object_r:sbin_t,s0)
+/usr/(.*/)?sbin(/.*)?			gen_context(system_u:object_r:sbin_t,s0)
 
 /usr/lib/ccache/bin(/.*)?		gen_context(system_u:object_r:bin_t,s0)
 /usr/lib/pgsql/test/regress/.*\.sh --	gen_context(system_u:object_r:bin_t,s0)
diff -ru serefpolicy-2.1.7.orig/policy/modules/kernel/devices.fc serefpolicy-2.1.7/policy/modules/kernel/devices.fc
--- serefpolicy-2.1.7.orig/policy/modules/kernel/devices.fc	2006-01-08 16:27:56.000000000 +1100
+++ serefpolicy-2.1.7/policy/modules/kernel/devices.fc	2006-01-08 16:27:18.000000000 +1100
@@ -1,5 +1,6 @@
 
-/dev(/.*)?			gen_context(system_u:object_r:device_t,s0)
+/dev			-d	gen_context(system_u:object_r:device_t,s0)
+/dev/.*				gen_context(system_u:object_r:device_t,s0)
 
 /dev/.*mouse.*		-c	gen_context(system_u:object_r:mouse_device_t,s0)
 /dev/adsp		-c	gen_context(system_u:object_r:sound_device_t,s0)
diff -ru serefpolicy-2.1.7.orig/policy/modules/kernel/files.fc serefpolicy-2.1.7/policy/modules/kernel/files.fc
--- serefpolicy-2.1.7.orig/policy/modules/kernel/files.fc	2006-01-08 16:27:56.000000000 +1100
+++ serefpolicy-2.1.7/policy/modules/kernel/files.fc	2006-01-08 16:27:18.000000000 +1100
@@ -32,13 +32,15 @@
 #
 
 ifdef(`distro_redhat',`
-/emul(/.*)?			gen_context(system_u:object_r:usr_t,s0)
+/emul			-d	gen_context(system_u:object_r:usr_t,s0)
+/emul/.*			gen_context(system_u:object_r:usr_t,s0)
 ')
 
 #
 # /etc
 #
-/etc(/.*)?			gen_context(system_u:object_r:etc_t,s0)
+/etc			-d	gen_context(system_u:object_r:etc_t,s0)
+/etc/.*				gen_context(system_u:object_r:etc_t,s0)
 /etc/\.fstab\.hal\..+	--	gen_context(system_u:object_r:etc_runtime_t,s0)
 /etc/asound\.state	--	gen_context(system_u:object_r:etc_runtime_t,s0)
 /etc/blkid\.tab.*	--	gen_context(system_u:object_r:etc_runtime_t,s0)
@@ -123,29 +125,34 @@
 #
 # /opt
 #
-/opt(/.*)?			gen_context(system_u:object_r:usr_t,s0)
+/opt			-d	gen_context(system_u:object_r:usr_t,s0)
+/opt/.*				gen_context(system_u:object_r:usr_t,s0)
 
-/opt(/.*)?/var/lib(64)?(/.*)?	gen_context(system_u:object_r:var_lib_t,s0)
+/opt/(.*/)?var/lib(64)?(/.*)?	gen_context(system_u:object_r:var_lib_t,s0)
 
 #
 # /proc
 #
-/proc(/.*)?                     <<none>>
+/proc			-d	<<none>>
+/proc/.*			<<none>>
 
 #
 # /selinux
 #
-/selinux(/.*)?                  <<none>>
+/selinux		-d	<<none>>
+/selinux/.*			<<none>>
 
 #
 # /srv
 #
-/srv(/.*)?			gen_context(system_u:object_r:var_t,s0)
+/srv			-d	gen_context(system_u:object_r:var_t,s0)
+/srv/.*				gen_context(system_u:object_r:var_t,s0)
 
 #
 # /sys
 #
-/sys(/.*)?                      <<none>>
+/sys			-d	<<none>>
+/sys/.*				<<none>>
 
 #
 # /tmp
@@ -160,7 +167,8 @@
 #
 # /usr
 #
-/usr(/.*)?			gen_context(system_u:object_r:usr_t,s0)
+/usr			-d	gen_context(system_u:object_r:usr_t,s0)
+/usr/.*				gen_context(system_u:object_r:usr_t,s0)
 /usr/\.journal			<<none>>
 
 /usr/etc(/.*)?			gen_context(system_u:object_r:etc_t,s0)
@@ -189,7 +197,8 @@
 #
 # /var
 #
-/var(/.*)?			gen_context(system_u:object_r:var_t,s0)
+/var			-d	gen_context(system_u:object_r:var_t,s0)
+/var/.*				gen_context(system_u:object_r:var_t,s0)
 /var/\.journal			<<none>>
 
 /var/db/.*\.db		--	gen_context(system_u:object_r:etc_t,s0)
diff -ru serefpolicy-2.1.7.orig/policy/modules/services/tftp.fc serefpolicy-2.1.7/policy/modules/services/tftp.fc
--- serefpolicy-2.1.7.orig/policy/modules/services/tftp.fc	2006-01-06 03:12:16.000000000 +1100
+++ serefpolicy-2.1.7/policy/modules/services/tftp.fc	2006-01-08 16:22:29.000000000 +1100
@@ -2,4 +2,5 @@
 /usr/sbin/atftpd	--	gen_context(system_u:object_r:tftpd_exec_t,s0)
 /usr/sbin/in\.tftpd	--	gen_context(system_u:object_r:tftpd_exec_t,s0)
 
-/tftpboot(/.*)?			gen_context(system_u:object_r:tftpdir_t,s0)
+/tftpboot		-d	gen_context(system_u:object_r:tftpdir_t,s0)
+/tftpboot/.*			gen_context(system_u:object_r:tftpdir_t,s0)
diff -ru serefpolicy-2.1.7.orig/policy/modules/system/authlogin.fc serefpolicy-2.1.7/policy/modules/system/authlogin.fc
--- serefpolicy-2.1.7.orig/policy/modules/system/authlogin.fc	2006-01-06 03:12:15.000000000 +1100
+++ serefpolicy-2.1.7/policy/modules/system/authlogin.fc	2006-01-08 16:24:49.000000000 +1100
@@ -7,7 +7,8 @@
 /etc/passwd\.lock	--	gen_context(system_u:object_r:shadow_t,s0)
 /etc/shadow.*		--	gen_context(system_u:object_r:shadow_t,s0)
 
-/lib(64)?/security/pam_krb5/pam_krb5_storetmp -- gen_context(system_u:object_r:pam_exec_t,s0)
+/lib/security/pam_krb5/pam_krb5_storetmp -- gen_context(system_u:object_r:pam_exec_t,s0)
+/lib64/security/pam_krb5/pam_krb5_storetmp -- gen_context(system_u:object_r:pam_exec_t,s0)
 
 /sbin/pam_console_apply	 --	gen_context(system_u:object_r:pam_console_exec_t,s0)
 /sbin/pam_timestamp_check --	gen_context(system_u:object_r:pam_exec_t,s0)
diff -ru serefpolicy-2.1.7.orig/policy/modules/system/libraries.fc serefpolicy-2.1.7/policy/modules/system/libraries.fc
--- serefpolicy-2.1.7.orig/policy/modules/system/libraries.fc	2006-01-08 16:27:56.000000000 +1100
+++ serefpolicy-2.1.7/policy/modules/system/libraries.fc	2006-01-08 16:34:24.000000000 +1100
@@ -25,17 +25,22 @@
 /etc/ppp/plugins/rp-pppoe\.so 		--	gen_context(system_u:object_r:shlib_t,s0)
 
 #
-# /lib(64)?
+# /lib and /lib64
 #
-/lib(64)?(/.*)?					gen_context(system_u:object_r:lib_t,s0)
-/lib(64)?/.*\.so(\.[^/]*)*		--	gen_context(system_u:object_r:shlib_t,s0)
-/lib(64)?(/.*)?/ld-[^/]*\.so(\.[^/]*)*	--	gen_context(system_u:object_r:ld_so_t,s0)
+/lib				-d	gen_context(system_u:object_r:lib_t,s0)
+/lib/.*					gen_context(system_u:object_r:lib_t,s0)
+/lib64				-d	gen_context(system_u:object_r:lib_t,s0)
+/lib64/.*				gen_context(system_u:object_r:lib_t,s0)
+/lib/.*\.so(\.[^/]*)*		--	gen_context(system_u:object_r:shlib_t,s0)
+/lib64/.*\.so(\.[^/]*)*		--	gen_context(system_u:object_r:shlib_t,s0)
+/lib/(.*/)?ld-[^/]*\.so(\.[^/]*)*	--	gen_context(system_u:object_r:ld_so_t,s0)
+/lib64/(.*/)?ld-[^/]*\.so(\.[^/]*)*	--	gen_context(system_u:object_r:ld_so_t,s0)
 
 #
 # /opt
 #
-/opt(/.*)?/lib(64)?(/.*)?			gen_context(system_u:object_r:lib_t,s0)
-/opt(/.*)?/lib(64)?/.*\.so(\.[^/]*)*	--	gen_context(system_u:object_r:shlib_t,s0)
+/opt/(.*/)?lib(64)?(/.*)?			gen_context(system_u:object_r:lib_t,s0)
+/opt/(.*/)?lib(64)?/.*\.so(\.[^/]*)*	--	gen_context(system_u:object_r:shlib_t,s0)
 
 #
 # /sbin
@@ -45,18 +50,18 @@
 #
 # /usr
 #
-/usr(/.*)?/HelixPlayer/.*\.so(\.[^/]*)*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/(.*/)?HelixPlayer/.*\.so(\.[^/]*)*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
-/usr(/.*)?/java/.*\.so(\.[^/]*)*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr(/.*)?/java/.*\.jar			--	gen_context(system_u:object_r:shlib_t,s0)
-/usr(/.*)?/java/.*\.jsa			--	gen_context(system_u:object_r:shlib_t,s0)
+/usr/(.*/)?java/.*\.so(\.[^/]*)*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/(.*/)?java/.*\.jar			--	gen_context(system_u:object_r:shlib_t,s0)
+/usr/(.*/)?java/.*\.jsa			--	gen_context(system_u:object_r:shlib_t,s0)
 
-/usr(/.*)?/lib(64)?(/.*)?			gen_context(system_u:object_r:lib_t,s0)
-/usr(/.*)?/lib(64)?/.*\.so(\.[^/]*)*	--	gen_context(system_u:object_r:shlib_t,s0)
+/usr/(.*/)?lib(64)?(/.*)?			gen_context(system_u:object_r:lib_t,s0)
+/usr/(.*/)?lib(64)?/.*\.so(\.[^/]*)*	--	gen_context(system_u:object_r:shlib_t,s0)
 
-/usr(/.*)?/lib(64)?(/.*)?/ld-[^/]*\.so(\.[^/]*)* gen_context(system_u:object_r:ld_so_t,s0)
+/usr/(.*/)?lib(64)?(/.*)?/ld-[^/]*\.so(\.[^/]*)* gen_context(system_u:object_r:ld_so_t,s0)
 
-/usr(/.*)?/nvidia/.*\.so(\..*)?		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/(.*/)?nvidia/.*\.so(\..*)?		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 /usr/lib(64)?/pgsql/test/regress/.*\.so 	--	gen_context(system_u:object_r:shlib_t,s0)
 
@@ -117,7 +122,7 @@
 /usr/lib(64)?/.*/program/libsvx680li\.so --	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/.*/program/libcomphelp4gcc3\.so -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/.*/program/libsoffice\.so  --	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr(/.*)?/pcsc/drivers(/.*)?/lib(cm2020|cm4000|SCR24x)\.so(\.[^/]*)*  		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/(.*/)?pcsc/drivers(/.*)?/lib(cm2020|cm4000|SCR24x)\.so(\.[^/]*)*  		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 /usr/lib(64)?/firefox.*\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/mozilla.*\.so		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
@@ -171,10 +176,10 @@
 # Java, Sun Microsystems (JPackage SRPM)
 /usr/.*/jre/lib/i386/libdeploy.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
-/usr(/.*)?/Reader/intellinux/plug_ins/.*\.api -- gen_context(system_u:object_r:shlib_t,s0)
-/usr(/.*)?/Reader/intellinux/plug_ins/AcroForm\.api -- gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr(/.*)?/Reader/intellinux/plug_ins/EScript\.api -- gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr(/.*)?/Reader/intellinux/SPPlugins/ADMPlugin\.apl -- gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/(.*/)?Reader/intellinux/plug_ins/.*\.api -- gen_context(system_u:object_r:shlib_t,s0)
+/usr/(.*/)?Reader/intellinux/plug_ins/AcroForm\.api -- gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/(.*/)?Reader/intellinux/plug_ins/EScript\.api -- gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/(.*/)?Reader/intellinux/SPPlugins/ADMPlugin\.apl -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 ') dnl end distro_redhat
 
 ifdef(`distro_suse',`
diff -ru serefpolicy-2.1.7.orig/policy/modules/system/miscfiles.fc serefpolicy-2.1.7/policy/modules/system/miscfiles.fc
--- serefpolicy-2.1.7.orig/policy/modules/system/miscfiles.fc	2006-01-06 03:12:16.000000000 +1100
+++ serefpolicy-2.1.7/policy/modules/system/miscfiles.fc	2006-01-08 16:12:42.000000000 +1100
@@ -7,7 +7,7 @@
 #
 # /opt
 #
-/opt(/.*)?/man(/.*)?		gen_context(system_u:object_r:man_t,s0)
+/opt/(.*/)?man(/.*)?		gen_context(system_u:object_r:man_t,s0)
 
 #
 # /srv
diff -ru serefpolicy-2.1.7.orig/policy/modules/system/modutils.fc serefpolicy-2.1.7/policy/modules/system/modutils.fc
--- serefpolicy-2.1.7.orig/policy/modules/system/modutils.fc	2006-01-06 03:12:15.000000000 +1100
+++ serefpolicy-2.1.7/policy/modules/system/modutils.fc	2006-01-08 16:24:34.000000000 +1100
@@ -2,9 +2,11 @@
 /etc/modules\.conf.*	--	gen_context(system_u:object_r:modules_conf_t,s0)
 /etc/modprobe\.conf.*	--	gen_context(system_u:object_r:modules_conf_t,s0)
 
-/lib(64)?/modules/[^/]+/modules\..+ -- gen_context(system_u:object_r:modules_dep_t,s0)
+/lib/modules/[^/]+/modules\..+ -- gen_context(system_u:object_r:modules_dep_t,s0)
+/lib64/modules/[^/]+/modules\..+ -- gen_context(system_u:object_r:modules_dep_t,s0)
 
-/lib(64)?/modules/modprobe\.conf -- gen_context(system_u:object_r:modules_conf_t,s0)
+/lib/modules/modprobe\.conf -- gen_context(system_u:object_r:modules_conf_t,s0)
+/lib64/modules/modprobe\.conf -- gen_context(system_u:object_r:modules_conf_t,s0)
 
 /sbin/depmod.*		--	gen_context(system_u:object_r:depmod_exec_t,s0)
 /sbin/generate-modprobe\.conf -- gen_context(system_u:object_r:update_modules_exec_t,s0)

--Boundary-00=_KxOwDyjINBp5F13--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
