Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1KHNBAR003083
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 12:23:11 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1KHORlw015475
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 17:24:28 GMT
Message-ID: <45DB2EC4.7080507@redhat.com>
Date: Tue, 20 Feb 2007 12:24:20 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: clamd wants to read kernerl sysctls.
Content-Type: multipart/mixed;
 boundary="------------070500010803000705030506"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070500010803000705030506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------070500010803000705030506
Content-Type: text/x-patch;
 name="nsaserefpolicy_policy_modules_services_clamav.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nsaserefpolicy_policy_modules_services_clamav.patch"

--- nsaserefpolicy/policy/modules/services/clamav.te	2007-01-02 12:57:43.000000000 -0500
+++ serefpolicy-2.5.4/policy/modules/services/clamav.te	2007-02-19 16:01:52.000000000 -0500
@@ -86,6 +86,8 @@
 kernel_dontaudit_list_proc(clamd_t)
 kernel_read_sysctl(clamd_t)
 
+kernel_read_sysctl(clamd_t)
+
 corenet_non_ipsec_sendrecv(clamd_t)
 corenet_tcp_sendrecv_all_if(clamd_t)
 corenet_tcp_sendrecv_all_nodes(clamd_t)

--------------070500010803000705030506--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
