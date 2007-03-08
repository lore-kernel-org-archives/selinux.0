Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l28EqMWR005099
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 09:52:22 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l28EqLHa008764
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 14:52:21 GMT
Message-ID: <45F02323.5060503@redhat.com>
Date: Thu, 08 Mar 2007 09:52:19 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: systat needs to read sysfs
Content-Type: multipart/mixed;
 boundary="------------060700090404070406060508"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060700090404070406060508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------060700090404070406060508
Content-Type: text/x-patch;
 name="nsaserefpolicy_policy_modules_services_sysstat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="nsaserefpolicy_policy_modules_services_sysstat.patch"

--- nsaserefpolicy/policy/modules/services/sysstat.te	2007-01-02 12:57:43.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/services/sysstat.te	2007-03-08 08:42:37.000000000 -0500
@@ -39,6 +39,7 @@
 corecmd_exec_bin(sysstat_t)
 
 dev_read_urand(sysstat_t)
+dev_read_sysfs(sysstat_t)
 
 files_search_var(sysstat_t)
 # for mtab

--------------060700090404070406060508--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
