From: Guido Trentalancia <guido@trentalancia.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "selinux@tycho.nsa.gov ; Eric Paris" <eparis@parisplace.org>,
        "; James Morris" <jmorris@namei.org>
Content-Type: text/plain
Message-Id: <1265213161.3013.21.camel@tesla.lan>
Mime-Version: 1.0
Subject: [PATCH] Load the initial SIDs upon every policy load
Date: Wed, 03 Feb 2010 12:59:13 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Author: Guido Trentalancia <guido@trentalancia.com>
Date:   Mon Feb 03 17:03:32 2010 +0100

    Always load the initial SIDs, even in the case of a policy
    reload and not just at the initial policy load. This comes
    particularly handy after the introduction of a recent
    patch for enabling runtime switching between different
    policy types, although this patch is in theory independent
    from that feature.

    Signed-off-by: Guido Trentalancia <guido@trentalancia.com>

---

 security/selinux/ss/services.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- security-testing-2.6/security/selinux/ss/services.c	2010-01-29 02:02:47.742042805 +0100
+++ security-testing-2.6-isids/security/selinux/ss/services.c	2010-02-03 17:01:55.594310767 +0100
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
 
@@ -1712,9 +1718,11 @@ int security_load_policy(void *data, siz
 	if (policydb_read(&newpolicydb, fp))
 		return -EINVAL;
 
-	if (sidtab_init(&newsidtab)) {
+	rc = policydb_load_isids(&newpolicydb, &newsidtab);
+	if (rc) {
+		printk(KERN_ERR "SELinux:  unable to load the initial SIDs\n");
 		policydb_destroy(&newpolicydb);
-		return -ENOMEM;
+		return rc;
 	}
 
 	if (selinux_set_mapping(&newpolicydb, secclass_map,



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
