Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1KHVmDF003449
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 12:31:48 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1KHX4lw017627
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 17:33:05 GMT
Message-ID: <45DB30CE.5090406@redhat.com>
Date: Tue, 20 Feb 2007 12:33:02 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: mls_trusted_object(cupsd_var_run_t) defined twice.
Content-Type: multipart/mixed;
 boundary="------------050608080102060107020002"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050608080102060107020002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------050608080102060107020002
Content-Type: text/x-patch;
 name="nsaserefpolicy_policy_modules_services_cups.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nsaserefpolicy_policy_modules_services_cups.patch"

--- nsaserefpolicy/policy/modules/services/cups.te	2007-02-19 11:32:53.000000000 -0500
+++ serefpolicy-2.5.4/policy/modules/services/cups.te	2007-02-20 10:37:09.000000000 -0500
@@ -72,7 +72,6 @@
 ifdef(`enable_mls',`
 	init_ranged_daemon_domain(cupsd_t,cupsd_exec_t,mls_systemhigh)
 
-	mls_trusted_object(cupsd_var_run_t)
 ')
 
 ########################################

--------------050608080102060107020002--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
