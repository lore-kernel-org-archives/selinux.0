Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8B0NkLa012904
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 20:23:46 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8B0Njmw012973
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2003 00:23:45 GMT
Received: from smtp.vasco.com (smtp.vasco.com [62.58.124.115])
        by jazzband.ncsc.mil  with ESMTP id h8B0Ni9d012970 for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2003 00:23:44 GMT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.vasco.com (Postfix) with ESMTP id 08BBA4B9FF
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2003 02:20:37 +0200 (CEST)
Received: from smtp.vasco.com ([127.0.0.1])
 by localhost (proxy.vasco.com [127.0.0.1]) (amavisd-new, port 10024)
 with SMTP id 19646-03 for <selinux@tycho.nsa.gov>;
 Thu, 11 Sep 2003 02:20:36 +0200 (CEST)
Received: from smtp.vasco.com (vasco-exch.vasco.com [192.168.1.251])
	by smtp.vasco.com (Postfix) with ESMTP id CDF924B9BD
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2003 02:20:36 +0200 (CEST)
From: jason anderssen <jna@vasco.com>
Reply-To: jna@vasco.com
To: selinux@tycho.nsa.gov
Subject: Installation question - RH9.0 2.4.21-selinux kernel
Date: Thu, 11 Sep 2003 18:19:41 +1000
Cc: Russell Coker <russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309111819.41949.jna@vasco.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Second attempt to se-list.
Hi all,

I have decided to upgrade my old selinux to the latest.  So I went with RH9.0 
and downloaded the latest and greatest off of nsa.gov.

However,  I am a little new to the initrd style of booting, and I have 
concerns with step 7 which is as follows:

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
7) Create an initrd with load_policy, the binary policy file, and a
/linuxrc that will perform the initial policy load prior to mounting
the root filesystem.  For example, you might modify your mkinitrd
script in a similar manner to this patch for the RH9 mkinitrd script:

--- /sbin/mkinitrd-     2003-02-18 12:41:17.000000000 -0500
+++ /sbin/mkinitrd      2003-08-05 08:45:46.000000000 -0400
@@ -517,6 +517,12 @@
 inst /sbin/insmod.static "$MNTIMAGE/bin/insmod"
 ln -s /sbin/nash $MNTIMAGE/sbin/modprobe

+# Binary policy file and load_policy utility for loading it.
+mkdir -p $MNTIMAGE/selinux
+mkdir -p $MNTIMAGE/etc/security/selinux
+inst /etc/security/selinux/policy.15 
"$MNTIMAGE/etc/security/selinux/policy.15"
+inst /usr/sbin/load_policy "$MNTIMAGE/bin/load_policy"
+
 for MODULE in $MODULES; do
     cp $verbose -a /lib/modules/$kernel/$MODULE $MNTIMAGE/lib
 done
@@ -570,6 +576,11 @@
     fi
 done

+echo "echo Loading policy" >> $RCFILE
+echo "mount -t selinuxfs none /selinux" >> $RCFILE
+echo "/bin/load_policy /etc/security/selinux/policy.15" >> $RCFILE
+echo "umount /selinux" >> $RCFILE
+
 echo "echo Mounting /proc filesystem" >> $RCFILE
 echo "mount -t proc /proc /proc" >> $RCFILE
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

I find it a little confusing in the instructions, but all I think I need to 
understand is the following:

In the mkinitrd script supplied, which is the same as above, why does 
load_policy have two different paths, ie:  /usr/sbin/load_policy > 
"$MNTIMAGE/bin/load_policy"?

what is a linuxrc?

Does anyone care to eleborate this step a bit more for me, this I would very 
much appreciates.

Anyways, to cut a long story short, I stuffed my installation, so 
re-installation has begun.


Cheers
Jason
Vasco Data Security
Brisbane Australia

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
