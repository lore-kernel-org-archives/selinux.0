Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i78MaOrT021722
	for <selinux@tycho.nsa.gov>; Sun, 8 Aug 2004 18:36:24 -0400 (EDT)
Received: from smtp810.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i78MZkDs002080
	for <selinux@tycho.nsa.gov>; Sun, 8 Aug 2004 22:35:47 GMT
Date: Sun, 8 Aug 2004 23:47:37 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>,
   Linux Hotplug Dev List <linux-hotplug-devel@lists.sourceforge.net>
Subject: udev
Message-ID: <20040808224737.GA3825@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+QahgC5+KEYLbs62"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

okay, combination of patches and mods.

1) xattr one which is  up on http://hands.com/~lkcl/selinux/2.6.6

2) remove stuff which tells mount 'fscontext=' option to bog off
   if it supports xattrs.

   don't know if this patch is needed, don't care either. 
   ItWorksForMe(tm) hey for all i know i missed out an option
   which makes it unnecessary to stop fscontext=....device_t
   from working.

3) make mount take option fscontext=....device_t   .... /dev

4) patch /etc/init.d/udev _and_ /etc/init.d/modutils to call a
   little program /sbin/restoredevicefiles.

   the horrible hack to make extra nodes in /dev needs to have
   a restorecon done on each node so created: quickest way is
   to do them all at once.

5) restoredevicefiles greps everything in /dev hey i just noticed
   it only does /dev/* not /dev/*/* oh well.

   i also had to copy /usr/bin/cut to /bin/cut hey there's probably
   a way to do it with sed or something.
 

okayyy...

so, one this isn't going to deal with is drivers that don't do
/sys yet: those nodes aren't going to be generating hotplug events
and so consequently their contexts will be wrong.

e.g. /dev/nvidiactl with nvidia's 2.6 driver: i got away with this
one by putting it in /etc/modutils, hence /sbin/restoredevicefiles
catches it.

e.g. /dev/ppp does something weird:
pon a.usb.converter.with.serial.modem.on.it requests that i manually
do a mknod /dev/ppp, even though this is a 2.6.7 driver!

apparently this is a possible race condition unrelated to selinux.


i think that's it.

l.


-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility if acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=g

--- /etc/init.d/modutils.orig	2004-08-08 23:37:21.000000000 +0100
+++ /etc/init.d/modutils	2004-08-08 23:37:26.000000000 +0100
@@ -37,5 +37,10 @@
         modprobe -a -t boot \*
 fi
 
+# all devices created we must do the security contexts on them, oh dear.
+if [ -x /sbin/restoredevicefiles ]; then
+	/sbin/restoredevicefiles
+fi
+
 exit 0
 
--- /etc/init.d/udev.orig	2004-08-08 23:30:25.000000000 +0100
+++ /etc/init.d/udev	2004-08-08 23:39:22.000000000 +0100
@@ -57,7 +57,7 @@
   [ -d /.dev ] && mount --bind /dev /.dev
 
   echo -n "Mounting a tmpfs over /dev..."
-  mount -n -o size=$tmpfs_size,mode=0755 -t tmpfs none /dev
+  mount -n -o fscontext=system_u:object_r:device_t,size=$tmpfs_size,mode=0755 -t tmpfs none /dev
   echo "done."
 }
 
@@ -96,6 +96,11 @@
     echo -n "Creating initial device nodes..."
     $UDEVSTART
     make_extra_nodes
+    # all extra nodes created we must do the security contexts on them, oh dear.
+    if [ -x /sbin/restoredevicefiles ]; then
+      /sbin/restoredevicefiles
+    fi
+
     echo "done."
     ;;
   remove)
@@ -133,3 +138,4 @@
 
 exit 0
 
+ 

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="selinux-hooks.patch"

Index: security/selinux/hooks.c
===================================================================
RCS file: /cvsroot/selinux/nsa/linux-2.6/security/selinux/hooks.c,v
retrieving revision 1.15
diff -u -u -r1.15 hooks.c
--- security/selinux/hooks.c	27 Jul 2004 17:43:11 -0000	1.15
+++ security/selinux/hooks.c	8 Aug 2004 21:39:46 -0000
@@ -385,6 +385,14 @@
 				break;
 
 			case Opt_fscontext:
+				/* lkcl: allow fscontext on file systems with xattr
+				 *       in order to be able to mount an xattr-enabled tmpfs
+				 *       on /dev with a different fscontext.
+				 *       reason: shmfs and tmpfs are mapped to two types
+				 *       but we need a third (e.g. udevfs_t) in order to
+				 *       not interfere with / have-to-add-to either tmp_t
+				 *       or shmfs_t
+				 *
 				if (sbsec->behavior != SECURITY_FS_USE_XATTR) {
 					rc = -EINVAL;
 					printk(KERN_WARNING "SELinux:  "
@@ -392,6 +400,7 @@
 					       " this filesystem type\n");
 					goto out_free;
 				}
+				*/
 				if (seen & (Opt_context|Opt_fscontext)) {
 					rc = -EINVAL;
 					printk(KERN_WARNING SEL_MOUNT_FAIL_MSG);

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=restoredevicefiles

#!/bin/sh
#
# lkcl 2004aug08
#
# restore contexts on anything in /dev which has the default device_t
# file context.
#
# some things are meant to have device_t: hey, we set them too, makes
# no odds.
# 
# we pass all of the devs to restorecon on one line because restorecon
# caches the lookups of the filecontexts: doing a restorecon one at a
# time takes 1/4 sec per device/dir/symlink...

devs=''
#for x in `ls -altrZ /dev/ | grep -v initctl | grep device_t | grep -v "_device_t" | cut -c64-`; do
for x in `ls -altrZ /dev/ | grep device_t | grep -v "_device_t" | cut -c64-`; do
	echo $x
	devs="$devs /dev/$x"
done;
echo $devs
/sbin/restorecon $devs

--+QahgC5+KEYLbs62--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
