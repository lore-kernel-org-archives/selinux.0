Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l71FqWkV006855
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 11:52:32 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l71FqUKI000992
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 15:52:30 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l71FqTWa014560
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 11:52:29 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l71FqTkX004267
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 11:52:29 -0400
Received: from [10.11.14.155] (vpn-14-155.rdu.redhat.com [10.11.14.155])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l71FqSWo019385
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 11:52:28 -0400
Subject: [PATCH] libsepol: support the handle_unknown config flag
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Wed, 01 Aug 2007 11:52:28 -0400
Message-Id: <1185983548.3673.21.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Update the policydb definition to contain a handle_unknown flag.  Change
libsepol to copy the handle_unknown config flag from the base policy to
the final binary policy.  Also makes libsepol properly read and write
the flag which dealing with policy modules.

Signed-off-by: Eric Paris <eparis@redhat.com>

diff -Naupr libsepol-2.0.4/include/sepol/policydb/policydb.h libsepol-2.0.4.new/include/sepol/policydb/policydb.h
--- libsepol-2.0.4/include/sepol/policydb/policydb.h	2007-06-21 05:17:02.000000000 -0400
+++ libsepol-2.0.4.new/include/sepol/policydb/policydb.h	2007-07-31 16:14:13.000000000 -0400
@@ -469,6 +469,8 @@ typedef struct policydb {
 	ebitmap_t *attr_type_map;	/* not saved in the binary policy */
 
 	unsigned policyvers;
+
+	unsigned handle_unknown;
 } policydb_t;
 
 struct sepol_policydb {
@@ -599,6 +601,13 @@ extern int policydb_write(struct policyd
 
 #define POLICYDB_CONFIG_MLS    1
 
+/* the config flags related to unknown classes/perms are bits 2 and 3 */
+#define DENY_UNKNOWN	0x00000000
+#define REJECT_UNKNOWN	0x00000002
+#define ALLOW_UNKNOWN 	0x00000004
+
+#define POLICYDB_CONFIG_UNKNOWN_MASK	(DENY_UNKNOWN | REJECT_UNKNOWN | ALLOW_UNKNOWN)
+
 #define OBJECT_R "object_r"
 #define OBJECT_R_VAL 1
 
diff -Naupr libsepol-2.0.4/src/expand.c libsepol-2.0.4.new/src/expand.c
--- libsepol-2.0.4/src/expand.c	2007-06-21 05:17:01.000000000 -0400
+++ libsepol-2.0.4.new/src/expand.c	2007-07-27 18:32:39.000000000 -0400
@@ -2248,6 +2248,7 @@ int expand_module(sepol_handle_t * handl
 
 	/* Copy mls state from base to out */
 	out->mls = base->mls;
+	out->handle_unknown = base->handle_unknown;
 
 	if ((state.typemap =
 	     (uint32_t *) calloc(state.base->p_types.nprim,
diff -Naupr libsepol-2.0.4/src/policydb.c libsepol-2.0.4.new/src/policydb.c
--- libsepol-2.0.4/src/policydb.c	2007-06-21 05:17:01.000000000 -0400
+++ libsepol-2.0.4.new/src/policydb.c	2007-07-31 16:17:53.000000000 -0400
@@ -3057,6 +3057,8 @@ int policydb_read(policydb_t * p, struct
 		p->mls = 0;
 	}
 
+	p->handle_unknown = buf[bufindex] & POLICYDB_CONFIG_UNKNOWN_MASK;
+
 	bufindex++;
 
 	info = policydb_lookup_compat(r_policyvers, policy_type);
diff -Naupr libsepol-2.0.4/src/write.c libsepol-2.0.4.new/src/write.c
--- libsepol-2.0.4/src/write.c	2007-06-21 05:17:01.000000000 -0400
+++ libsepol-2.0.4.new/src/write.c	2007-07-31 16:18:49.000000000 -0400
@@ -1534,6 +1534,8 @@ int policydb_write(policydb_t * p, struc
 	if (p->mls)
 		config |= POLICYDB_CONFIG_MLS;
 
+	config |= (POLICYDB_CONFIG_UNKNOWN_MASK & p->handle_unknown);
+
 	/* Write the magic number and string identifiers. */
 	items = 0;
 	if (p->policy_type == POLICY_KERN) {



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
