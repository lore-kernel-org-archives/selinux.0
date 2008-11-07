Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mA7Ebsc6009701
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 09:37:54 -0500
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mA7EaDQi009156
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 14:36:13 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id mA7EbrDr003374
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 09:37:53 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id mA7EbqCu031563
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 09:37:53 -0500
Received: from holycross.boston.devel.redhat.com (holycross.boston.devel.redhat.com [10.16.60.79])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id mA7EbqPL015047
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 09:37:52 -0500
Message-ID: <491452C0.9080106@redhat.com>
Date: Fri, 07 Nov 2008 09:37:52 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: newrole error message corrections.
Content-Type: multipart/mixed;
 boundary="------------090503000507080700070404"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090503000507080700070404
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------090503000507080700070404
Content-Type: text/plain;
 name="newrole.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="newrole.patch"

--- nsapolicycoreutils/newrole/newrole.c	2008-08-28 09:34:24.000000000 -0400
+++ policycoreutils-2.0.57/newrole/newrole.c	2008-10-17 16:43:52.000000000 -0400
@@ -553,7 +553,7 @@
 	new_caps = cap_init();
 	tmp_caps = cap_init();
 	if (!new_caps || !tmp_caps) {
-		fprintf(stderr, _("Error initing capabilities, aborting.\n"));
+		fprintf(stderr, _("Error initializing capabilities, aborting.\n"));
 		return -1;
 	}
 	rc |= cap_set_flag(new_caps, CAP_PERMITTED, 1, cap_list, CAP_SET);
@@ -631,7 +631,7 @@
 	/* Non-root caller, suid root path */
 	new_caps = cap_init();
 	if (!new_caps) {
-		fprintf(stderr, _("Error initing capabilities, aborting.\n"));
+		fprintf(stderr, _("Error initializing capabilities, aborting.\n"));
 		return -1;
 	}
 	rc |= cap_set_flag(new_caps, CAP_PERMITTED, 6, cap_list, CAP_SET);

--------------090503000507080700070404
Content-Type: application/octet-stream;
 name="newrole.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="newrole.patch.sig"

iEYEABECAAYFAkkUUsAACgkQrlYvE4MpobN+PgCfXCDNxXP4MzUBq7Surl5MVN9U1IQAoKBo
OreCm5O4LcwQ7+xVgDHPUWdP
--------------090503000507080700070404--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
