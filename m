Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAQEjqmT006415
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 09:45:52 -0500
Received: from vidle.i.cz (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAQEjnKq012346
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 14:45:50 GMT
Received: from ns.i.cz (brana.i.cz [193.179.36.134])
	by vidle.i.cz (Postfix) with ESMTP id 936F71CDDD
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 15:45:48 +0100 (CET)
Received: from bobek.localdomain (bobek.pm.i.cz [192.168.64.71])
	by ns.i.cz (Postfix) with ESMTP id 6C4AC5C05
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 15:45:48 +0100 (CET)
Received: from zito by bobek.localdomain with local (Exim 4.63)
	(envelope-from <vaclav.ovsik@i.cz>)
	id 1IwfDX-0000C6-JB
	for selinux@tycho.nsa.gov; Mon, 26 Nov 2007 15:45:47 +0100
Date: Mon, 26 Nov 2007 15:45:47 +0100
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: selinux@tycho.nsa.gov
Subject: refpolicy HEAD, Debian, patch for udev.te
Message-ID: <20071126144547.GA334@bobek.pm.i.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
Debian Etch, refpolicy HEAD, udev produces during startup (udevsettle)
wile creating symlinks into /dev/disk/by-uuid/...
following:

audit(1195744042.060:3): avc:  denied  { relabelfrom } for  pid=836 comm="udevd" name="44517f56-2445-4330-bce7-5168aa534c1c" dev=tmpfs ino=1646 scontext=system_u:system_r:udev_t:s0-s0:c0.c1023 tcontext=system_u:object_r:device_t:s0 tclass=lnk_file
audit(1195744042.060:4): avc:  denied  { relabelto } for  pid=836 comm="udevd" name="44517f56-2445-4330-bce7-5168aa534c1c" dev=tmpfs ino=1646 scontext=system_u:system_r:udev_t:s0-s0:c0.c1023 tcontext=system_u:object_r:device_t:s0 tclass=lnk_file

Attached patch solves this.
Can be merged into refpolicy please?
-- 
Zito

--huq684BweRXVnRxX
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="udev.te.debian.patch"

Index: policy/modules/system/udev.te
===================================================================
--- policy/modules/system/udev.te	(revision 2530)
+++ policy/modules/system/udev.te	(working copy)
@@ -96,6 +96,7 @@
 dev_delete_generic_files(udev_t)
 dev_search_usbfs(udev_t)
 dev_relabel_all_dev_nodes(udev_t)
+dev_relabel_generic_symlinks(udev_t)
 
 domain_read_all_domains_state(udev_t)
 domain_dontaudit_ptrace_all_domains(udev_t) #pidof triggers these 

--huq684BweRXVnRxX--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
