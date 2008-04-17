Subject: [PATCH] SELinux: clean up printks
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Content-Type: text/plain
Date: Thu, 17 Apr 2008 11:52:44 -0400
Message-Id: <1208447564.2985.19.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Make sure all printk start with KERN_*
Make sure all printk end with \n
Make sure all printk have the word 'selinux' in them
Change "function name" to "%s", __func__ (found 2 wrong)

Signed-off-by: Eric Paris <eparis@redhat.com>

---

 security/selinux/avc.c            |    2 +-
 security/selinux/hooks.c          |   17 +++++-----
 security/selinux/selinuxfs.c      |   15 +++++----
 security/selinux/ss/avtab.c       |   27 +++++++--------
 security/selinux/ss/conditional.c |   14 ++++----
 security/selinux/ss/policydb.c    |   17 +++++-----
 security/selinux/ss/services.c    |   63 ++++++++++++++++++-------------------
 7 files changed, 78 insertions(+), 77 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index a4fc6e6..a628e11 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -426,7 +426,7 @@ static int avc_latest_notif_update(int seqno, int is_insert)
 	spin_lock_irqsave(&notif_lock, flag);
 	if (is_insert) {
 		if (seqno < avc_cache.latest_notif) {
-			printk(KERN_WARNING "avc:  seqno %d < latest_notif %d\n",
+			printk(KERN_WARNING "SELinux: avc:  seqno %d < latest_notif %d\n",
 			       seqno, avc_cache.latest_notif);
 			ret = -EAGAIN;
 		}
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 213c136..93cbefe 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -580,8 +580,8 @@ static int selinux_set_mnt_opts(struct super_block *sb, char **mount_options,
 			goto out;
 		}
 		rc = -EINVAL;
-		printk(KERN_WARNING "Unable to set superblock options before "
-		       "the security server is initialized\n");
+		printk(KERN_WARNING "SELinux: Unable to set superblock options "
+			"before the security server is initialized\n");
 		goto out;
 	}
 
@@ -1115,7 +1115,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 			dentry = d_find_alias(inode);
 		}
 		if (!dentry) {
-			printk(KERN_WARNING "%s:  no dentry for dev=%s "
+			printk(KERN_WARNING "SELinux: %s:  no dentry for dev=%s "
 			       "ino=%ld\n", __func__, inode->i_sb->s_id,
 			       inode->i_ino);
 			goto out_unlock;
@@ -1153,7 +1153,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 		dput(dentry);
 		if (rc < 0) {
 			if (rc != -ENODATA) {
-				printk(KERN_WARNING "%s:  getxattr returned "
+				printk(KERN_WARNING "SELinux: %s:  getxattr returned "
 				       "%d for dev=%s ino=%ld\n", __func__,
 				       -rc, inode->i_sb->s_id, inode->i_ino);
 				kfree(context);
@@ -1166,7 +1166,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 			rc = security_context_to_sid_default(context, rc, &sid,
 			                                     sbsec->def_sid);
 			if (rc) {
-				printk(KERN_WARNING "%s:  context_to_sid(%s) "
+				printk(KERN_WARNING "SELinux: %s:  context_to_sid(%s) "
 				       "returned %d for dev=%s ino=%ld\n",
 				       __func__, context, -rc,
 				       inode->i_sb->s_id, inode->i_ino);
@@ -1489,7 +1489,8 @@ static int may_link(struct inode *dir,
 		av = DIR__RMDIR;
 		break;
 	default:
-		printk(KERN_WARNING "may_link:  unrecognized kind %d\n", kind);
+		printk(KERN_WARNING "SELinux: %s:  unrecognized kind %d\n",
+			__func__, kind);
 		return 0;
 	}
 
@@ -1619,8 +1620,8 @@ static inline u32 open_file_mask_to_av(int mode, int mask)
 		else if (S_ISDIR(mode))
 			av |= DIR__OPEN;
 		else
-			printk(KERN_ERR "SELinux: WARNING: inside open_file_to_av "
-				"with unknown mode:%x\n", mode);
+			printk(KERN_ERR "SELinux: WARNING: inside %s with "
+				"unknown mode:%x\n", __func__, mode);
 	}
 	return av;
 }
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 26fabad..6c05e30 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -391,8 +391,8 @@ static ssize_t sel_write_context(struct file * file, char *buf, size_t size)
 		return length;
 
 	if (len > SIMPLE_TRANSACTION_LIMIT) {
-		printk(KERN_ERR "%s:  context size (%u) exceeds payload "
-		       "max\n", __func__, len);
+		printk(KERN_ERR "SELinux: %s:  context size (%u) exceeds "
+			"payload max\n", __func__, len);
 		length = -ERANGE;
 		goto out;
 	}
@@ -644,8 +644,8 @@ static ssize_t sel_write_create(struct file * file, char *buf, size_t size)
 		goto out2;
 
 	if (len > SIMPLE_TRANSACTION_LIMIT) {
-		printk(KERN_ERR "%s:  context size (%u) exceeds payload "
-		       "max\n", __func__, len);
+		printk(KERN_ERR "SELinux: %s:  context size (%u) exceeds "
+			"payload max\n", __func__, len);
 		length = -ERANGE;
 		goto out3;
 	}
@@ -821,8 +821,8 @@ static ssize_t sel_write_member(struct file * file, char *buf, size_t size)
 		goto out2;
 
 	if (len > SIMPLE_TRANSACTION_LIMIT) {
-		printk(KERN_ERR "%s:  context size (%u) exceeds payload "
-		       "max\n", __func__, len);
+		printk(KERN_ERR "SELinux: %s:  context size (%u) exceeds "
+			"payload max\n", __func__, len);
 		length = -ERANGE;
 		goto out3;
 	}
@@ -1761,7 +1761,8 @@ static int sel_fill_super(struct super_block * sb, void * data, int silent)
 out:
 	return ret;
 err:
-	printk(KERN_ERR "%s:  failed while creating inodes\n", __func__);
+	printk(KERN_ERR "SELinux: %s:  failed while creating inodes\n",
+		__func__);
 	goto out;
 }
 
diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 916e73a..260a06b 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -310,8 +310,8 @@ void avtab_hash_eval(struct avtab *h, char *tag)
 		}
 	}
 
-	printk(KERN_DEBUG "%s:  %d entries and %d/%d buckets used, longest "
-	       "chain length %d sum of chain length^2 %Lu\n",
+	printk(KERN_DEBUG "SELinux: %s:  %d entries and %d/%d buckets used, "
+	       "longest chain length %d sum of chain length^2 %Lu\n",
 	       tag, h->nel, slots_used, h->nslot, max_chain_len,
 	       chain2_len_sum);
 }
@@ -364,19 +364,19 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 		val = le32_to_cpu(buf32[items++]);
 		key.source_type = (u16)val;
 		if (key.source_type != val) {
-			printk("SELinux: avtab: truncated source type\n");
+			printk(KERN_ERR "SELinux: avtab: truncated source type\n");
 			return -1;
 		}
 		val = le32_to_cpu(buf32[items++]);
 		key.target_type = (u16)val;
 		if (key.target_type != val) {
-			printk("SELinux: avtab: truncated target type\n");
+			printk(KERN_ERR "SELinux: avtab: truncated target type\n");
 			return -1;
 		}
 		val = le32_to_cpu(buf32[items++]);
 		key.target_class = (u16)val;
 		if (key.target_class != val) {
-			printk("SELinux: avtab: truncated target class\n");
+			printk(KERN_ERR "SELinux: avtab: truncated target class\n");
 			return -1;
 		}
 
@@ -384,12 +384,12 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 		enabled = (val & AVTAB_ENABLED_OLD) ? AVTAB_ENABLED : 0;
 
 		if (!(val & (AVTAB_AV | AVTAB_TYPE))) {
-			printk("SELinux: avtab: null entry\n");
+			printk(KERN_ERR "SELinux: avtab: null entry\n");
 			return -1;
 		}
 		if ((val & AVTAB_AV) &&
 		    (val & AVTAB_TYPE)) {
-			printk("SELinux: avtab: entry has both access vectors and types\n");
+			printk(KERN_ERR "SELinux: avtab: entry has both access vectors and types\n");
 			return -1;
 		}
 
@@ -403,7 +403,7 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 		}
 
 		if (items != items2) {
-			printk("SELinux: avtab: entry only had %d items, expected %d\n", items2, items);
+			printk(KERN_ERR "SELinux: avtab: entry only had %d items, expected %d\n", items2, items);
 			return -1;
 		}
 		return 0;
@@ -411,7 +411,7 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 
 	rc = next_entry(buf16, fp, sizeof(u16)*4);
 	if (rc < 0) {
-		printk("SELinux: avtab: truncated entry\n");
+		printk(KERN_ERR "SELinux: avtab: truncated entry\n");
 		return -1;
 	}
 
@@ -424,7 +424,7 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 	if (!policydb_type_isvalid(pol, key.source_type) ||
 	    !policydb_type_isvalid(pol, key.target_type) ||
 	    !policydb_class_isvalid(pol, key.target_class)) {
-		printk(KERN_WARNING "SELinux: avtab: invalid type or class\n");
+		printk(KERN_ERR "SELinux: avtab: invalid type or class\n");
 		return -1;
 	}
 
@@ -434,20 +434,19 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 			set++;
 	}
 	if (!set || set > 1) {
-		printk(KERN_WARNING
-			"SELinux:  avtab:  more than one specifier\n");
+		printk(KERN_ERR "SELinux:  avtab:  more than one specifier\n");
 		return -1;
 	}
 
 	rc = next_entry(buf32, fp, sizeof(u32));
 	if (rc < 0) {
-		printk("SELinux: avtab: truncated entry\n");
+		printk(KERN_ERR "SELinux: avtab: truncated entry\n");
 		return -1;
 	}
 	datum.data = le32_to_cpu(*buf32);
 	if ((key.specified & AVTAB_TYPE) &&
 	    !policydb_type_isvalid(pol, datum.data)) {
-		printk(KERN_WARNING "SELinux: avtab: invalid type\n");
+		printk(KERN_ERR "SELinux: avtab: invalid type\n");
 		return -1;
 	}
 	return insertf(a, &key, &datum, p);
diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index a996cf1..df33aea 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -276,7 +276,7 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
 	 */
 	if (k->specified & AVTAB_TYPE) {
 		if (avtab_search(&p->te_avtab, k)) {
-			printk("SELinux: type rule already exists outside of a conditional.");
+			printk(KERN_ERR "SELinux: type rule already exists outside of a conditional.\n");
 			goto err;
 		}
 		/*
@@ -291,7 +291,7 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
 			node_ptr = avtab_search_node(&p->te_cond_avtab, k);
 			if (node_ptr) {
 				if (avtab_search_node_next(node_ptr, k->specified)) {
-					printk("SELinux: too many conflicting type rules.");
+					printk(KERN_ERR "SELinux: too many conflicting type rules.\n");
 					goto err;
 				}
 				found = 0;
@@ -302,13 +302,13 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
 					}
 				}
 				if (!found) {
-					printk("SELinux: conflicting type rules.\n");
+					printk(KERN_ERR "SELinux: conflicting type rules.\n");
 					goto err;
 				}
 			}
 		} else {
 			if (avtab_search(&p->te_cond_avtab, k)) {
-				printk("SELinux: conflicting type rules when adding type rule for true.\n");
+				printk(KERN_ERR "SELinux: conflicting type rules when adding type rule for true.\n");
 				goto err;
 			}
 		}
@@ -316,7 +316,7 @@ static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum
 
 	node_ptr = avtab_insert_nonunique(&p->te_cond_avtab, k, d);
 	if (!node_ptr) {
-		printk("SELinux: could not insert rule.");
+		printk(KERN_ERR "SELinux: could not insert rule.\n");
 		goto err;
 	}
 
@@ -376,12 +376,12 @@ static int cond_read_av_list(struct policydb *p, void *fp, struct cond_av_list *
 static int expr_isvalid(struct policydb *p, struct cond_expr *expr)
 {
 	if (expr->expr_type <= 0 || expr->expr_type > COND_LAST) {
-		printk("SELinux: conditional expressions uses unknown operator.\n");
+		printk(KERN_ERR "SELinux: conditional expressions uses unknown operator.\n");
 		return 0;
 	}
 
 	if (expr->bool > p->p_bools.nprim) {
-		printk("SELinux: conditional expressions uses unknown bool.\n");
+		printk(KERN_ERR "SELinux: conditional expressions uses unknown bool.\n");
 		return 0;
 	}
 	return 1;
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 6bdb0ff..891c2d0 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -390,7 +390,7 @@ static void symtab_hash_eval(struct symtab *s)
 		struct hashtab_info info;
 
 		hashtab_stat(h, &info);
-		printk(KERN_DEBUG "%s:  %d entries and %d/%d buckets used, "
+		printk(KERN_DEBUG "SELinux: %s:  %d entries and %d/%d buckets used, "
 		       "longest chain length %d\n", symtab_name[i], h->nel,
 		       info.slots_used, h->size, info.max_chain_len);
 	}
@@ -1215,7 +1215,7 @@ static int role_read(struct policydb *p, struct hashtab *h, void *fp)
 
 	if (strcmp(key, OBJECT_R) == 0) {
 		if (role->value != OBJECT_R_VAL) {
-			printk(KERN_ERR "Role %s has wrong value %d\n",
+			printk(KERN_ERR "SELinux: Role %s has wrong value %d\n",
 			       OBJECT_R, role->value);
 			rc = -EINVAL;
 			goto bad;
@@ -1551,22 +1551,23 @@ int policydb_read(struct policydb *p, void *fp)
 
 	if ((le32_to_cpu(buf[1]) & POLICYDB_CONFIG_MLS)) {
 		if (ss_initialized && !selinux_mls_enabled) {
-			printk(KERN_ERR "Cannot switch between non-MLS and MLS "
-			       "policies\n");
+			printk(KERN_ERR "SELinux: Cannot switch between non-MLS"
+				" and MLS policies\n");
 			goto bad;
 		}
 		selinux_mls_enabled = 1;
 		config |= POLICYDB_CONFIG_MLS;
 
 		if (p->policyvers < POLICYDB_VERSION_MLS) {
-			printk(KERN_ERR "security policydb version %d (MLS) "
-			       "not backwards compatible\n", p->policyvers);
+			printk(KERN_ERR "SELinux: security policydb version %d "
+				"(MLS) not backwards compatible\n",
+				p->policyvers);
 			goto bad;
 		}
 	} else {
 		if (ss_initialized && selinux_mls_enabled) {
-			printk(KERN_ERR "Cannot switch between MLS and non-MLS "
-			       "policies\n");
+			printk(KERN_ERR "SELinux: Cannot switch between MLS and"
+				" non-MLS policies\n");
 			goto bad;
 		}
 	}
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 1670405..0079889 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -414,7 +414,8 @@ static int context_struct_compute_av(struct context *scontext,
 	return 0;
 
 inval_class:
-	printk(KERN_ERR "%s:  unrecognized class %d\n", __func__, tclass);
+	printk(KERN_ERR "SELinux: %s:  unrecognized class %d\n", __func__,
+		tclass);
 	return -EINVAL;
 }
 
@@ -498,8 +499,8 @@ int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
 			tclass = SECCLASS_NETLINK_SOCKET;
 
 	if (!tclass || tclass > policydb.p_classes.nprim) {
-		printk(KERN_ERR "security_validate_transition:  "
-		       "unrecognized class %d\n", tclass);
+		printk(KERN_ERR "SELinux: %s:  unrecognized class %d\n",
+			__func__, tclass);
 		rc = -EINVAL;
 		goto out;
 	}
@@ -507,24 +508,24 @@ int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
 
 	ocontext = sidtab_search(&sidtab, oldsid);
 	if (!ocontext) {
-		printk(KERN_ERR "security_validate_transition: "
-		       " unrecognized SID %d\n", oldsid);
+		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
+			__func__, oldsid);
 		rc = -EINVAL;
 		goto out;
 	}
 
 	ncontext = sidtab_search(&sidtab, newsid);
 	if (!ncontext) {
-		printk(KERN_ERR "security_validate_transition: "
-		       " unrecognized SID %d\n", newsid);
+		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
+			__func__, newsid);
 		rc = -EINVAL;
 		goto out;
 	}
 
 	tcontext = sidtab_search(&sidtab, tasksid);
 	if (!tcontext) {
-		printk(KERN_ERR "security_validate_transition: "
-		       " unrecognized SID %d\n", tasksid);
+		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
+			__func__, tasksid);
 		rc = -EINVAL;
 		goto out;
 	}
@@ -580,15 +581,15 @@ int security_compute_av(u32 ssid,
 
 	scontext = sidtab_search(&sidtab, ssid);
 	if (!scontext) {
-		printk(KERN_ERR "security_compute_av:  unrecognized SID %d\n",
-		       ssid);
+		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
+		       __func__, ssid);
 		rc = -EINVAL;
 		goto out;
 	}
 	tcontext = sidtab_search(&sidtab, tsid);
 	if (!tcontext) {
-		printk(KERN_ERR "security_compute_av:  unrecognized SID %d\n",
-		       tsid);
+		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
+		       __func__, tsid);
 		rc = -EINVAL;
 		goto out;
 	}
@@ -686,16 +687,16 @@ int security_sid_to_context(u32 sid, char **scontext, u32 *scontext_len)
 			*scontext = scontextp;
 			goto out;
 		}
-		printk(KERN_ERR "security_sid_to_context:  called before initial "
-		       "load_policy on unknown SID %d\n", sid);
+		printk(KERN_ERR "SELinux: %s:  called before initial "
+		       "load_policy on unknown SID %d\n", __func__, sid);
 		rc = -EINVAL;
 		goto out;
 	}
 	POLICY_RDLOCK;
 	context = sidtab_search(&sidtab, sid);
 	if (!context) {
-		printk(KERN_ERR "security_sid_to_context:  unrecognized SID "
-		       "%d\n", sid);
+		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
+			__func__, sid);
 		rc = -EINVAL;
 		goto out_unlock;
 	}
@@ -923,15 +924,15 @@ static int security_compute_sid(u32 ssid,
 
 	scontext = sidtab_search(&sidtab, ssid);
 	if (!scontext) {
-		printk(KERN_ERR "security_compute_sid:  unrecognized SID %d\n",
-		       ssid);
+		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
+		       __func__, ssid);
 		rc = -EINVAL;
 		goto out_unlock;
 	}
 	tcontext = sidtab_search(&sidtab, tsid);
 	if (!tcontext) {
-		printk(KERN_ERR "security_compute_sid:  unrecognized SID %d\n",
-		       tsid);
+		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
+		       __func__, tsid);
 		rc = -EINVAL;
 		goto out_unlock;
 	}
@@ -2039,16 +2040,16 @@ int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid)
 	POLICY_RDLOCK;
 	context1 = sidtab_search(&sidtab, sid);
 	if (!context1) {
-		printk(KERN_ERR "security_sid_mls_copy:  unrecognized SID "
-		       "%d\n", sid);
+		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
+			__func__, sid);
 		rc = -EINVAL;
 		goto out_unlock;
 	}
 
 	context2 = sidtab_search(&sidtab, mls_sid);
 	if (!context2) {
-		printk(KERN_ERR "security_sid_mls_copy:  unrecognized SID "
-		       "%d\n", mls_sid);
+		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
+			__func__, mls_sid);
 		rc = -EINVAL;
 		goto out_unlock;
 	}
@@ -2139,17 +2140,15 @@ int security_net_peersid_resolve(u32 nlbl_sid, u32 nlbl_type,
 
 	nlbl_ctx = sidtab_search(&sidtab, nlbl_sid);
 	if (!nlbl_ctx) {
-		printk(KERN_ERR
-		       "security_sid_mls_cmp:  unrecognized SID %d\n",
-		       nlbl_sid);
+		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
+		       __func__, nlbl_sid);
 		rc = -EINVAL;
 		goto out_slowpath;
 	}
 	xfrm_ctx = sidtab_search(&sidtab, xfrm_sid);
 	if (!xfrm_ctx) {
-		printk(KERN_ERR
-		       "security_sid_mls_cmp:  unrecognized SID %d\n",
-		       xfrm_sid);
+		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
+		       __func__, xfrm_sid);
 		rc = -EINVAL;
 		goto out_slowpath;
 	}
@@ -2229,7 +2228,7 @@ int security_get_permissions(char *class, char ***perms, int *nperms)
 
 	match = hashtab_search(policydb.p_classes.table, class);
 	if (!match) {
-		printk(KERN_ERR "%s:  unrecognized class %s\n",
+		printk(KERN_ERR "SELinux: %s:  unrecognized class %s\n",
 			__func__, class);
 		rc = -EINVAL;
 		goto out;



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
