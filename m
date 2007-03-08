Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l28EoAvR004990
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 09:50:10 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l28Eo8ko005879
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 14:50:08 GMT
Message-ID: <45F0229E.6090100@redhat.com>
Date: Thu, 08 Mar 2007 09:50:06 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: using the xdm_t:fifo_file sometimes requires ioctl
Content-Type: multipart/mixed;
 boundary="------------040308030101020800090902"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040308030101020800090902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Also needs to communicate with consolekit via dbus.

--------------040308030101020800090902
Content-Type: text/x-patch;
 name="nsaserefpolicy_policy_modules_services_xserver.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="nsaserefpolicy_policy_modules_services_xserver.patch"

--- nsaserefpolicy/policy/modules/services/xserver.if	2007-02-19 11:32:53.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/services/xserver.if	2007-03-08 08:42:37.000000000 -0500
@@ -826,7 +826,7 @@
 		type xdm_t;
 	')
 
-	dontaudit $1 xdm_t:fifo_file { getattr read write }; 
+	dontaudit $1 xdm_t:fifo_file rw_fifo_file_perms; 
 ')
 
 ########################################
--- nsaserefpolicy/policy/modules/services/xserver.te	2007-02-19 11:32:53.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/services/xserver.te	2007-03-08 08:42:37.000000000 -0500
@@ -345,6 +345,10 @@
 ')
 
 optional_policy(`
+	consolekit_dbus_chat(xdm_t)
+')
+
+optional_policy(`
 	userhelper_dontaudit_search_config(xdm_t)
 ')
 

--------------040308030101020800090902--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
