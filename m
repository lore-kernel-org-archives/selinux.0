Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8ALXSLa012252
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 17:33:28 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8ALVpLY008100
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 21:31:51 GMT
Received: from smtp.vasco.com (smtp.vasco.com [62.58.124.115])
	by jazzswing.ncsc.mil  with ESMTP id h8ALVosG008097
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 21:31:50 GMT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.vasco.com (Postfix) with ESMTP id 8F7444B9BD
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 23:30:14 +0200 (CEST)
Received: from smtp.vasco.com ([127.0.0.1])
 by localhost (proxy.vasco.com [127.0.0.1]) (amavisd-new, port 10024)
 with SMTP id 14435-02 for <selinux@tycho.nsa.gov>;
 Wed, 10 Sep 2003 23:30:14 +0200 (CEST)
Received: from smtp.vasco.com (vasco-exch.vasco.com [192.168.1.251])
	by smtp.vasco.com (Postfix) with ESMTP id 059624B937
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 23:30:14 +0200 (CEST)
From: jason anderssen <jna@vasco.com>
Reply-To: jna@vasco.com
To: selinux@tycho.nsa.gov
Subject: installing rh9 latest
Date: Thu, 11 Sep 2003 15:29:19 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200309111529.19386.jna@vasco.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

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
