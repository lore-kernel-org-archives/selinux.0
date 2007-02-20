Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1KHXEnf003505
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 12:33:15 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1KHYUQc025821
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 17:34:31 GMT
Message-ID: <45DB3124.6050905@redhat.com>
Date: Tue, 20 Feb 2007 12:34:28 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Latest bluetooth requires net_bind_service
Content-Type: multipart/mixed;
 boundary="------------090108040906020002080708"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090108040906020002080708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Also search inotify

--------------090108040906020002080708
Content-Type: text/x-patch;
 name="nsaserefpolicy_policy_modules_services_bluetooth.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="nsaserefpolicy_policy_modules_services_bluetooth.patch"

--- nsaserefpolicy/policy/modules/services/bluetooth.te	2007-01-02 12:57:43.000000000 -0500
+++ serefpolicy-2.5.4/policy/modules/services/bluetooth.te	2007-02-19 16:01:52.000000000 -0500
@@ -41,7 +41,7 @@
 # Bluetooth services local policy
 #
 
-allow bluetooth_t self:capability { net_admin net_raw sys_tty_config ipc_lock };
+allow bluetooth_t self:capability { net_bind_service net_admin net_raw sys_tty_config ipc_lock };
 dontaudit bluetooth_t self:capability sys_tty_config;
 allow bluetooth_t self:process { getsched signal_perms };
 allow bluetooth_t self:fifo_file rw_fifo_file_perms;
@@ -98,6 +98,7 @@
 
 fs_getattr_all_fs(bluetooth_t)
 fs_search_auto_mountpoints(bluetooth_t)
+fs_search_inotifyfs(bluetooth_t)
 
 term_dontaudit_use_console(bluetooth_t)
 #Handle bluetooth serial devices

--------------090108040906020002080708--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
