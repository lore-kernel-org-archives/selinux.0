Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2NK2EJ7008263
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 16:02:14 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2NK2Csr015969
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 20:02:12 GMT
Message-ID: <46043239.4080205@redhat.com>
Date: Fri, 23 Mar 2007 16:02:01 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: cyrus sends mail and uses kerberos
Content-Type: multipart/mixed;
 boundary="------------000303080906000900020804"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000303080906000900020804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------000303080906000900020804
Content-Type: text/x-patch;
 name="cyrus.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cyrus.patch"

--- nsaserefpolicy/policy/modules/services/cyrus.te	2007-03-20 23:38:13.000000000 -0400
+++ serefpolicy-2.5.10/policy/modules/services/cyrus.te	2007-03-22 15:06:59.000000000 -0400
@@ -111,6 +111,7 @@
 userdom_use_sysadm_ptys(cyrus_t)
 
 mta_manage_spool(cyrus_t)
+mta_send_mail(cyrus_t)
 
 ifdef(`targeted_policy',`
 	term_dontaudit_use_unallocated_ttys(cyrus_t)
@@ -123,6 +124,10 @@
 ')
 
 optional_policy(`
+	kerberos_use(cyrus_t)
+')
+
+optional_policy(`
 	ldap_stream_connect(cyrus_t)
 ')
 

--------------000303080906000900020804--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
