Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4UDMVNm015451
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2012 09:22:31 -0400
From: Chris PeBenito <cpebenito@tresys.com>
To: <selinux@tycho.nsa.gov>
CC: Chris PeBenito <cpebenito@tresys.com>
Subject: [PATCH 1/1] libsepol: Add always_check_packets policy capability
Date: Wed, 30 May 2012 09:22:26 -0400
Message-ID: <1338384146-14187-1-git-send-email-cpebenito@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently the packet class in SELinux is not checked if there are no
SECMARK rules in the security or mangle netfilter tables.  Some systems
prefer that packets are always checked, for example, to protect the system
should the netfilter rules fail to load or if the nefilter rules
were maliciously flushed.

Add the always_check_packets policy capability which, when enabled, treats
SECMARK as enabled, even if there are no netfilter SECMARK rules.

Signed-off-by: Chris PeBenito <cpebenito@tresys.com>
---
 libsepol/include/sepol/policydb/polcaps.h |    1 +
 libsepol/src/polcaps.c                    |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include/sepol/policydb/polcaps.h
index 40c0a48..c4a05c6 100644
--- a/libsepol/include/sepol/policydb/polcaps.h
+++ b/libsepol/include/sepol/policydb/polcaps.h
@@ -5,6 +5,7 @@
 enum {
 	POLICYDB_CAPABILITY_NETPEER,
 	POLICYDB_CAPABILITY_OPENPERM,
+	POLICYDB_CAPABILITY_ALWAYSPACKET,
 	__POLICYDB_CAPABILITY_MAX
 };
 #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
index 71970b1..2667081 100644
--- a/libsepol/src/polcaps.c
+++ b/libsepol/src/polcaps.c
@@ -8,6 +8,7 @@
 static const char *polcap_names[] = {
 	"network_peer_controls",	/* POLICYDB_CAPABILITY_NETPEER */
 	"open_perms",			/* POLICYDB_CAPABILITY_OPENPERM */
+	"always_check_packets",		/* POLICYDB_CAPABILITY_ALWAYSPACKET */
 	NULL
 };
 
-- 
1.7.8.6


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
