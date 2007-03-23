Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2NK16o3008176
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 16:01:06 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2NK15sr015740
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 20:01:05 GMT
Message-ID: <460431FA.6050101@redhat.com>
Date: Fri, 23 Mar 2007 16:00:58 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: djbdns patch
Content-Type: multipart/mixed;
 boundary="------------000708030203070400040306"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000708030203070400040306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Make     ucspitcp_service_domain optional

--------------000708030203070400040306
Content-Type: text/x-patch;
 name="djbdns.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="djbdns.patch"

--- nsaserefpolicy/policy/modules/services/djbdns.te	2007-01-02 12:57:43.000000000 -0500
+++ serefpolicy-2.5.10/policy/modules/services/djbdns.te	2007-03-22 15:06:59.000000000 -0400
@@ -44,4 +44,7 @@
 libs_use_ld_so(djbdns_axfrdns_t)
 libs_use_shared_libs(djbdns_axfrdns_t)
 
-ucspitcp_service_domain(djbdns_axfrdns_t, djbdns_axfrdns_exec_t)
+optional_policy(`
+	ucspitcp_service_domain(djbdns_axfrdns_t, djbdns_axfrdns_exec_t)
+')
+

--------------000708030203070400040306--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
