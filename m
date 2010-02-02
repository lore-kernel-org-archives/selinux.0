Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o12MaWFb017476
	for <selinux@tycho.nsa.gov>; Tue, 2 Feb 2010 17:36:32 -0500
Received: from authsmtp.register.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o12MaKgF028265
	for <selinux@tycho.nsa.gov>; Tue, 2 Feb 2010 22:36:21 GMT
Subject: [PATCH] Load the initial SIDs upon every policy load
From: Guido Trentalancia <guido@trentalancia.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-u6XAlnPEUWbgVMdQNMaN"
Date: Tue, 02 Feb 2010 23:36:21 +0100
Message-Id: <1265150181.3605.23.camel@tesla.lan>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-u6XAlnPEUWbgVMdQNMaN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Stephen,

attached please find the tiny patch for always loading the initial SIDs.
Should I say "for review" ? It relies on SECINITSID_NUM which at the
moment is statically defined in flask.h (and represents the maximum
initial SID).

Author: Guido Trentalancia <guido@trentalancia.com>
Date:   Mon Feb 02 22:11:05 2010 +0100

    Always load the initial SIDs, even in the case of a policy
    reload and not just at the initial policy load. This comes
    particularly handy after the introduction of a recent
    patch for enabling runtime switching between different
    policy types, although this patch is in theory independent
    from that feature.

    Signed-off-by: Guido Trentalancia <guido@trentalancia.com>

---

 security/selinux/ss/services.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- security-testing-2.6/security/selinux/ss/services.c	2010-01-29 02:02:47.742042805 +0100
+++ security-testing-2.6-isids/security/selinux/ss/services.c	2010-02-02 22:09:47.809993219 +0100
@@ -1506,7 +1506,10 @@ static int clone_sid(u32 sid,
 {
 	struct sidtab *s = arg;
 
-	return sidtab_insert(s, sid, context);
+	if (sid > SECINITSID_NUM)
+		return sidtab_insert(s, sid, context);
+	else
+		return 0;
 }
 
 static inline int convert_context_handle_invalid_context(struct context *context)
@@ -1552,7 +1555,10 @@ static int convert_context(u32 key,
 	struct user_datum *usrdatum;
 	char *s;
 	u32 len;
-	int rc;
+	int rc = 0;
+
+	if (key <= SECINITSID_NUM)
+		goto out;
 
 	args = p;
 
@@ -1712,9 +1718,9 @@ int security_load_policy(void *data, siz
 	if (policydb_read(&newpolicydb, fp))
 		return -EINVAL;
 
-	if (sidtab_init(&newsidtab)) {
+	if (policydb_load_isids(&newpolicydb, &newsidtab)) {
 		policydb_destroy(&newpolicydb);
-		return -ENOMEM;
+		return -EINVAL;
 	}
 
 	if (selinux_set_mapping(&newpolicydb, secclass_map,


--=-u6XAlnPEUWbgVMdQNMaN
Content-Disposition: attachment; filename="always_load_initial_sids.patch"
Content-Type: text/x-patch; name="always_load_initial_sids.patch"; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Author: Guido Trentalancia <guido@trentalancia.com>
Date:   Mon Feb 02 22:11:05 2010 +0100

    Always load the initial SIDs, even in the case of a policy
    reload and not just at the initial policy load. This comes
    particularly handy after the introduction of a recent
    patch for enabling runtime switching between different
    policy types, although this patch is in theory independent
    from that feature.

    Signed-off-by: Guido Trentalancia <guido@trentalancia.com>

---

 security/selinux/ss/services.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- security-testing-2.6/security/selinux/ss/services.c	2010-01-29 02:02:47.742042805 +0100
+++ security-testing-2.6-isids/security/selinux/ss/services.c	2010-02-02 22:09:47.809993219 +0100
@@ -1506,7 +1506,10 @@ static int clone_sid(u32 sid,
 {
 	struct sidtab *s = arg;
 
-	return sidtab_insert(s, sid, context);
+	if (sid > SECINITSID_NUM)
+		return sidtab_insert(s, sid, context);
+	else
+		return 0;
 }
 
 static inline int convert_context_handle_invalid_context(struct context *context)
@@ -1552,7 +1555,10 @@ static int convert_context(u32 key,
 	struct user_datum *usrdatum;
 	char *s;
 	u32 len;
-	int rc;
+	int rc = 0;
+
+	if (key <= SECINITSID_NUM)
+		goto out;
 
 	args = p;
 
@@ -1712,9 +1718,9 @@ int security_load_policy(void *data, siz
 	if (policydb_read(&newpolicydb, fp))
 		return -EINVAL;
 
-	if (sidtab_init(&newsidtab)) {
+	if (policydb_load_isids(&newpolicydb, &newsidtab)) {
 		policydb_destroy(&newpolicydb);
-		return -ENOMEM;
+		return -EINVAL;
 	}
 
 	if (selinux_set_mapping(&newpolicydb, secclass_map,

--=-u6XAlnPEUWbgVMdQNMaN--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
