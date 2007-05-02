Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l42LPUlu021223
	for <selinux@tycho.nsa.gov>; Wed, 2 May 2007 17:25:30 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l42LPT38029005
	for <selinux@tycho.nsa.gov>; Wed, 2 May 2007 21:25:29 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l42LPTv8012526
	for <selinux@tycho.nsa.gov>; Wed, 2 May 2007 17:25:29 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l42LPTwG002048
	for <selinux@tycho.nsa.gov>; Wed, 2 May 2007 17:25:29 -0400
Received: from [172.16.59.235] (dhcp59-235.rdu.redhat.com [172.16.59.235])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l42LPS7t008732
	for <selinux@tycho.nsa.gov>; Wed, 2 May 2007 17:25:28 -0400
Subject: Where to specific the handling of unknown kernel classes and perms
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Wed, 02 May 2007 17:25:28 -0400
Message-Id: <1178141128.3897.33.camel@dhcp59-235.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I just sent out a kernel patch with the tristate flag to change kernel
handling of unknown classes and permissions.  The idea is that when the
policy is created someone can set the flag to any of the three options
(deny/reject/allow) and the kernel will act accordingly.  My problem is
I don't understand the userspace tools which create policy.  I patched
libsepol to support this new flag when it reads or writes a policydb,
which allows me to edit my policy.21 by hand in hex and then call
load_policy to test my kernel.  My problem now is that I don't know
where a user should be specifying how they want the flags to be set.  To
be perfectly honest after a bit of searching I'm not even sure where
policy.21 gets created when I build a policy.

So really I'm just looking for a pointer on what now-a-days creates that
policy.21 which gets loaded on boot up and where in the whole policy
build process would be the best place to specify how the policy should
handle unknowns.  I figure somewhere on some command line I need to add
some --handle-unknown=accept (or other such option) to the build
process, but I don't even know what program would be the right one to
process that input.....

-Eric

(patch for libsepol below)

diff -Naupr libsepol-2.0.3/include/sepol/policydb/policydb.h libsepol-2.0.3.handle_unknown/include/sepol/policydb/policydb.h
--- libsepol-2.0.3/include/sepol/policydb/policydb.h	2007-04-17 08:34:08.000000000 -0400
+++ libsepol-2.0.3.handle_unknown/include/sepol/policydb/policydb.h	2007-04-27 15:29:30.000000000 -0400
@@ -469,6 +469,8 @@ typedef struct policydb {
 	ebitmap_t *attr_type_map;	/* not saved in the binary policy */
 
 	unsigned policyvers;
+
+	unsigned handle_unknown;
 } policydb_t;
 
 struct sepol_policydb {
@@ -599,6 +601,15 @@ extern int policydb_write(struct policyd
 
 #define POLICYDB_CONFIG_MLS    1
 
+/* the config flags related to unknown classes/perms are bits 2 and 3 */
+#define POLICYDB_CONFIG_UNKNOWN_MASK   6
+#define POLICYDB_CONFIG_UNKNOWN_SHIFT  1
+
+enum policy_with_unknown_perms {
+	 DENY_UNKNOWN = 0,
+	 REJECT_UNKNOWN = 1,
+	 ALLOW_UNKNOWN = 2
+};
 #define OBJECT_R "object_r"
 #define OBJECT_R_VAL 1
 
--- libsepol-2.0.3/src/policydb.c	2007-04-17 08:34:08.000000000 -0400
+++ libsepol-2.0.3.handle_unknown/src/policydb.c	2007-05-02 14:35:13.000000000 -0400
@@ -3057,6 +3057,9 @@ int policydb_read(policydb_t * p, struct
 		p->mls = 0;
 	}
 
+	p->handle_unknown = buf[bufindex] & POLICYDB_CONFIG_UNKNOWN_MASK;
+	p->handle_unknown = p->handle_unknown >>= POLICYDB_CONFIG_UNKNOWN_SHIFT;
+
 	bufindex++;
 
 	info = policydb_lookup_compat(r_policyvers, policy_type);
diff -Naupr libsepol-2.0.3/src/write.c libsepol-2.0.3.handle_unknown/src/write.c
--- libsepol-2.0.3/src/write.c	2007-04-17 08:34:08.000000000 -0400
+++ libsepol-2.0.3.handle_unknown/src/write.c	2007-04-27 15:41:17.000000000 -0400
@@ -1533,6 +1533,9 @@ int policydb_write(policydb_t * p, struc
 	config = 0;
 	if (p->mls)
 		config |= POLICYDB_CONFIG_MLS;
+	i = POLICYDB_CONFIG_UNKNOWN_MASK & (p->handle_unknown << POLICYDB_CONFIG_UNKNOWN_SHIFT);
+	if (i)
+		config |= i;
 
 	/* Write the magic number and string identifiers. */
 	items = 0;



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
