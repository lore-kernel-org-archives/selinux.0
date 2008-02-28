Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1SFBDcK001423
	for <selinux@tycho.nsa.gov>; Thu, 28 Feb 2008 10:11:13 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1SFB93D013293
	for <selinux@tycho.nsa.gov>; Thu, 28 Feb 2008 15:11:09 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m1SF9uSB017723
	for <selinux@tycho.nsa.gov>; Thu, 28 Feb 2008 10:09:56 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m1SF9tg6002595
	for <selinux@tycho.nsa.gov>; Thu, 28 Feb 2008 10:09:55 -0500
Received: from [10.11.14.203] (vpn-14-203.rdu.redhat.com [10.11.14.203])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m1SF9tS8013000
	for <selinux@tycho.nsa.gov>; Thu, 28 Feb 2008 10:09:55 -0500
Subject: [PATCH] libsepol: new capability to support open permissions
From: Eric Paris <eparis@redhat.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 28 Feb 2008 10:09:54 -0500
Message-Id: <1204211394.3206.67.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds support for the new open_perms policy capability.
Simple yet true.  I would like to point out that after this change
checkpolicy will also need to be rebuilt with the new libsepol-static
installed.

-Eric

---

diff -Naupr libsepol-2.0.21/include/sepol/policydb/polcaps.h libsepol-2.0.21.new/include/sepol/policydb/polcaps.h
--- libsepol-2.0.21/include/sepol/policydb/polcaps.h	2008-02-20 13:47:52.000000000 -0500
+++ libsepol-2.0.21.new/include/sepol/policydb/polcaps.h	2008-02-26 18:58:23.000000000 -0500
@@ -4,6 +4,7 @@
 /* Policy capabilities */
 enum {
 	POLICYDB_CAPABILITY_NETPEER,
+	POLICYDB_CAPABILITY_OPENPERM,
 	__POLICYDB_CAPABILITY_MAX
 };
 #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
diff -Naupr libsepol-2.0.21/src/polcaps.c libsepol-2.0.21.new/src/polcaps.c
--- libsepol-2.0.21/src/polcaps.c	2008-02-20 13:47:51.000000000 -0500
+++ libsepol-2.0.21.new/src/polcaps.c	2008-02-26 18:57:56.000000000 -0500
@@ -7,6 +7,7 @@
 
 static const char *polcap_names[] = {
 	"network_peer_controls",	/* POLICYDB_CAPABILITY_NETPEER */
+	"open_perms",			/* POLICYDB_CAPABILITY_OPENPERM */
 	NULL
 };
 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
