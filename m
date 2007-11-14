Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAEHqAOi002019
	for <selinux@tycho.nsa.gov>; Wed, 14 Nov 2007 12:52:10 -0500
Received: from vidle.i.cz (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAEHq5Et002952
	for <selinux@tycho.nsa.gov>; Wed, 14 Nov 2007 17:52:06 GMT
Received: from ns.i.cz (brana.i.cz [193.179.36.134])
	by vidle.i.cz (Postfix) with ESMTP id A3E091CD7F
	for <selinux@tycho.nsa.gov>; Wed, 14 Nov 2007 17:54:47 +0100 (CET)
Received: from bobek.localdomain (bobek.pm.i.cz [192.168.64.71])
	by ns.i.cz (Postfix) with ESMTP id 7EBB95C06
	for <selinux@tycho.nsa.gov>; Wed, 14 Nov 2007 17:54:47 +0100 (CET)
Received: from zito by bobek.localdomain with local (Exim 4.63)
	(envelope-from <vaclav.ovsik@i.cz>)
	id 1IsLVn-0005OV-7g
	for selinux@tycho.nsa.gov; Wed, 14 Nov 2007 17:54:47 +0100
Date: Wed, 14 Nov 2007 17:54:47 +0100
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: selinux@tycho.nsa.gov
Subject: duplicit fc on Debian for /lib/usb/devices
Message-ID: <20071114165447.GA20094@bobek.pm.i.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,
I'm starting to experiment with the refpolicy 20070928 on Debian Etch.
First thing I noticed (beside many many other messages :-) is

/etc/selinux/refpolicy-strict/contexts/files/file_contexts: Multiple same specifications for /lib/udev/devices.


diff --git a/policy/modules/kernel/devices.fc b/policy/modules/kernel/devices.fc
index 12a7d22..1489e16 100644
--- a/policy/modules/kernel/devices.fc
+++ b/policy/modules/kernel/devices.fc
@@ -125,11 +125,6 @@ ifdef(`distro_suse', `
 
 /lib/udev/devices -d	gen_context(system_u:object_r:device_t,s0)
 
-ifdef(`distro_debian',`
-# used by udev init script as temporary mount point
-/lib/udev/devices	-d		gen_context(system_u:object_r:device_t,s0)
-')
-
 ifdef(`distro_gentoo',`
 # used by init scripts to initally populate udev /dev
 /lib/udev/devices/null	-c	gen_context(system_u:object_r:null_device_t,s0)


Regards
-- 
Zito

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
