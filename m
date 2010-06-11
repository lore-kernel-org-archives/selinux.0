From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 1/4] SELinux: seperate range transition rules to a seperate
	function
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Date: Fri, 11 Jun 2010 12:37:05 -0400
Message-ID: <20100611163705.18445.78022.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Move the range transition rule to a separate function, range_read(), rather
than doing it all in policydb_read()

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/ss/policydb.c |  139 ++++++++++++++++++++++------------------
 1 files changed, 75 insertions(+), 64 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index c57802a..a39d38a 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1701,6 +1701,78 @@ u32 string_to_av_perm(struct policydb *p, u16 tclass, const char *name)
 	return 1U << (perdatum->value-1);
 }
 
+static int range_read(struct policydb *p, void *fp)
+{
+	struct range_trans *rt = NULL;
+	struct mls_range *r = NULL;
+	int i, rc;
+	__le32 buf[2];
+	u32 nel;
+
+	if (p->policyvers < POLICYDB_VERSION_MLS)
+		return 0;
+
+	rc = next_entry(buf, fp, sizeof(u32));
+	if (rc)
+		goto out;
+
+	nel = le32_to_cpu(buf[0]);
+	for (i = 0; i < nel; i++) {
+		rc = -ENOMEM;
+		rt = kzalloc(sizeof(*rt), GFP_KERNEL);
+		if (!rt)
+			goto out;
+
+		rc = next_entry(buf, fp, (sizeof(u32) * 2));
+		if (rc)
+			goto out;
+
+		rt->source_type = le32_to_cpu(buf[0]);
+		rt->target_type = le32_to_cpu(buf[1]);
+		if (p->policyvers >= POLICYDB_VERSION_RANGETRANS) {
+			rc = next_entry(buf, fp, sizeof(u32));
+			if (rc)
+				goto out;
+			rt->target_class = le32_to_cpu(buf[0]);
+		} else
+			rt->target_class = p->process_class;
+
+		rc = -EINVAL;
+		if (!policydb_type_isvalid(p, rt->source_type) ||
+		    !policydb_type_isvalid(p, rt->target_type) ||
+		    !policydb_class_isvalid(p, rt->target_class))
+			goto out;
+
+		rc = -ENOMEM;
+		r = kzalloc(sizeof(*r), GFP_KERNEL);
+		if (!r)
+			goto out;
+
+		rc = mls_read_range_helper(r, fp);
+		if (rc)
+			goto out;
+
+		rc = -EINVAL;
+		if (!mls_range_isvalid(p, r)) {
+			printk(KERN_WARNING "SELinux:  rangetrans:  invalid range\n");
+			goto out;
+		}
+
+		rc = hashtab_insert(p->range_tr, rt, r);
+		if (rc)
+			goto out;
+
+		rt = NULL;
+		r = NULL;
+	}
+	rangetr_hash_eval(p->range_tr);
+	rc = 0;
+out:
+	kfree(rt);
+	kfree(r);
+	return rc;
+}
+
 /*
  * Read the configuration data from a policy database binary
  * representation file into a policy database structure.
@@ -1717,8 +1789,6 @@ int policydb_read(struct policydb *p, void *fp)
 	u32 len, len2, nprim, nel, nel2;
 	char *policydb_str;
 	struct policydb_compat_info *info;
-	struct range_trans *rt;
-	struct mls_range *r;
 
 	rc = policydb_init(p);
 	if (rc)
@@ -2131,68 +2201,9 @@ int policydb_read(struct policydb *p, void *fp)
 		}
 	}
 
-	if (p->policyvers >= POLICYDB_VERSION_MLS) {
-		int new_rangetr = p->policyvers >= POLICYDB_VERSION_RANGETRANS;
-		rc = next_entry(buf, fp, sizeof(u32));
-		if (rc < 0)
-			goto bad;
-		nel = le32_to_cpu(buf[0]);
-		for (i = 0; i < nel; i++) {
-			rt = kzalloc(sizeof(*rt), GFP_KERNEL);
-			if (!rt) {
-				rc = -ENOMEM;
-				goto bad;
-			}
-			rc = next_entry(buf, fp, (sizeof(u32) * 2));
-			if (rc < 0) {
-				kfree(rt);
-				goto bad;
-			}
-			rt->source_type = le32_to_cpu(buf[0]);
-			rt->target_type = le32_to_cpu(buf[1]);
-			if (new_rangetr) {
-				rc = next_entry(buf, fp, sizeof(u32));
-				if (rc < 0) {
-					kfree(rt);
-					goto bad;
-				}
-				rt->target_class = le32_to_cpu(buf[0]);
-			} else
-				rt->target_class = p->process_class;
-			if (!policydb_type_isvalid(p, rt->source_type) ||
-			    !policydb_type_isvalid(p, rt->target_type) ||
-			    !policydb_class_isvalid(p, rt->target_class)) {
-				kfree(rt);
-				rc = -EINVAL;
-				goto bad;
-			}
-			r = kzalloc(sizeof(*r), GFP_KERNEL);
-			if (!r) {
-				kfree(rt);
-				rc = -ENOMEM;
-				goto bad;
-			}
-			rc = mls_read_range_helper(r, fp);
-			if (rc) {
-				kfree(rt);
-				kfree(r);
-				goto bad;
-			}
-			if (!mls_range_isvalid(p, r)) {
-				printk(KERN_WARNING "SELinux:  rangetrans:  invalid range\n");
-				kfree(rt);
-				kfree(r);
-				goto bad;
-			}
-			rc = hashtab_insert(p->range_tr, rt, r);
-			if (rc) {
-				kfree(rt);
-				kfree(r);
-				goto bad;
-			}
-		}
-		rangetr_hash_eval(p->range_tr);
-	}
+	rc = range_read(p, fp);
+	if (rc)
+		goto bad;
 
 	p->type_attr_map = kmalloc(p->p_types.nprim * sizeof(struct ebitmap), GFP_KERNEL);
 	if (!p->type_attr_map)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
