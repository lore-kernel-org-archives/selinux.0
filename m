Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2FJ1qql015296
	for <selinux@tycho.nsa.gov>; Mon, 15 Mar 2010 15:01:52 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o2FJ1V2k012236
	for <selinux@tycho.nsa.gov>; Mon, 15 Mar 2010 19:01:31 GMT
Received: from int-mx04.intmail.prod.int.phx2.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.17])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o2FJ1oNk028189
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Mon, 15 Mar 2010 15:01:51 -0400
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.16.60.53])
	by int-mx04.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o2FJ1oA8017499
	for <selinux@tycho.nsa.gov>; Mon, 15 Mar 2010 15:01:50 -0400
Message-ID: <4B9E841D.6040406@redhat.com>
Date: Mon, 15 Mar 2010 15:01:49 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: Colin Walters asked for this patch to be added to libselinux
Content-Type: multipart/mixed;
 boundary="------------070804070805020001000201"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070804070805020001000201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fixes error message.

--------------070804070805020001000201
Content-Type: text/plain;
 name="libselinux_avc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libselinux_avc.patch"

--- libselinux-2.0.92/src/avc.c	2010-03-07 07:34:44.000000000 -0500
+++ libselinux-2.0.92.patched/src/avc.c	2010-03-12 16:50:05.000000000 -0500
@@ -215,8 +215,9 @@
 		rc = security_getenforce();
 		if (rc < 0) {
 			avc_log(SELINUX_ERROR,
-				"%s:  could not determine enforcing mode\n",
-				avc_prefix);
+				"%s:  could not determine enforcing mode: %s\n",
+				avc_prefix,
+				strerror(errno));
 			goto out;
 		}
 		avc_enforcing = rc;

--------------070804070805020001000201--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
