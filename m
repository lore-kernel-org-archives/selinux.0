Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1KHJ0kq002851
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 12:19:01 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1KHKGlw014682
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 17:20:17 GMT
Message-ID: <45DB2DC9.40001@redhat.com>
Date: Tue, 20 Feb 2007 12:20:09 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: smartmon needs to be able to write to physical devices.
Content-Type: multipart/mixed;
 boundary="------------050709040302050702050307"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050709040302050702050307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Needs to write to SystemLow, for logs, tmp files.

--------------050709040302050702050307
Content-Type: text/x-patch;
 name="nsaserefpolicy_policy_modules_services_smartmon.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="nsaserefpolicy_policy_modules_services_smartmon.patch"

--- nsaserefpolicy/policy/modules/services/smartmon.te	2007-01-02 12:57:43.000000000 -0500
+++ serefpolicy-2.5.4/policy/modules/services/smartmon.te	2007-02-19 16:01:52.000000000 -0500
@@ -60,6 +60,7 @@
 fs_search_auto_mountpoints(fsdaemon_t)
 
 mls_file_read_up(fsdaemon_t)
+mls_file_write_down(fsdaemon_t)
 
 storage_raw_read_fixed_disk(fsdaemon_t)
 storage_raw_write_fixed_disk(fsdaemon_t)

--------------050709040302050702050307--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
