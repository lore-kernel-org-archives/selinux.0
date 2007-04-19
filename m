Subject: [PATCH][RFC] selinux: preserve boolean values across policy reloads
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>
Content-Type: text/plain
Date: Thu, 19 Apr 2007 14:16:19 -0400
Message-Id: <1177006579.27654.169.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

At present, the userland policy loading code has to go through contortions to preserve
boolean values across policy reloads, and cannot do so atomically.  
As this is what we always want to do for reloads, let the kernel preserve them instead.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

---

 security/selinux/ss/services.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1249,6 +1249,7 @@ bad:
 }
 
 extern void selinux_complete_init(void);
+static int security_preserve_bools(struct policydb *p);
 
 /**
  * security_load_policy - Load a security policy configuration.
@@ -1325,6 +1326,12 @@ int security_load_policy(void *data, size_t len)
 		goto err;
 	}
 
+	rc = security_preserve_bools(&newpolicydb);
+	if (rc) {
+		printk(KERN_ERR "security:  unable to preserve booleans\n");
+		goto err;
+	}
+
 	/* Clone the SID table. */
 	sidtab_shutdown(&sidtab);
 	if (sidtab_map(&sidtab, clone_sid, &newsidtab)) {
@@ -1882,6 +1889,37 @@ out:
 	return rc;
 }
 
+static int security_preserve_bools(struct policydb *p)
+{
+	int rc, nbools = 0, *bvalues = NULL, i;
+	char **bnames = NULL;
+	struct cond_bool_datum *booldatum;
+	struct cond_node *cur;
+
+	rc = security_get_bools(&nbools, &bnames, &bvalues);
+	if (rc)
+		goto out;
+	for (i = 0; i < nbools; i++) {
+		booldatum = hashtab_search(p->p_bools.table, bnames[i]);
+		if (booldatum)
+			booldatum->state = bvalues[i];
+	}
+	for (cur = p->cond_list; cur != NULL; cur = cur->next) {
+		rc = evaluate_cond_node(p, cur);
+		if (rc)
+			goto out;
+	}
+
+out:
+	if (bnames) {
+		for (i = 0; i < nbools; i++)
+			kfree(bnames[i]);
+	}
+	kfree(bnames);
+	kfree(bvalues);
+	return rc;
+}
+
 /*
  * security_sid_mls_copy() - computes a new sid based on the given
  * sid and the mls portion of mls_sid.


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
