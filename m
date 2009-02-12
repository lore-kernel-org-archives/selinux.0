From: Eric Paris <eparis@redhat.com>
Subject: [PATCH -v2 1/3] SELinux: fix selinux to safely handle any bugs even
	when not CONFIG_BUG
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, paul.moore@hp.com
Date: Thu, 12 Feb 2009 15:00:59 -0500
Message-ID: <20090212200059.25810.72120.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If CONFIG_BUG is not set places in the code where BUG is called will not
end execution.  Look for places where this might result is system problems
and keep the system running.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 kernel/capability.c            |    1 +
 security/selinux/avc.c         |    9 +++++--
 security/selinux/hooks.c       |    8 +++++-
 security/selinux/netnode.c     |    3 ++
 security/selinux/ss/ebitmap.h  |   15 +++++++++--
 security/selinux/ss/services.c |   54 +++++++++++++++++++++++++++++-----------
 security/selinux/xfrm.c        |   15 +++++++++--
 7 files changed, 81 insertions(+), 24 deletions(-)

diff --git a/kernel/capability.c b/kernel/capability.c
index 4e17041..e8bec6a 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -304,6 +304,7 @@ int capable(int cap)
 	if (unlikely(!cap_valid(cap))) {
 		printk(KERN_CRIT "capable() called with invalid cap=%u\n", cap);
 		BUG();
+		return 0;
 	}
 
 	if (security_capable(cap) == 0) {
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index eb41f43..e5cda02 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -220,8 +220,13 @@ static void avc_dump_query(struct audit_buffer *ab, u32 ssid, u32 tsid, u16 tcla
 		kfree(scontext);
 	}
 
-	BUG_ON(tclass >= ARRAY_SIZE(class_to_string) || !class_to_string[tclass]);
-	audit_log_format(ab, " tclass=%s", class_to_string[tclass]);
+	if (unlikely(tclass >= ARRAY_SIZE(class_to_string) || !class_to_string[tclass])) {
+		printk(KERN_ERR "%s: with tclass=%d\n", __func__, tclass);
+		BUG();
+		audit_log_format(ab, " tclass=%d", tclass);
+	} else {
+		audit_log_format(ab, " tclass=%s", class_to_string[tclass]);
+	}
 }
 
 /**
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ae5bb64..44f2170 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -995,7 +995,11 @@ static int superblock_doinit(struct super_block *sb, void *data)
 	if (!data)
 		goto out;
 
-	BUG_ON(sb->s_type->fs_flags & FS_BINARY_MOUNTDATA);
+	if (unlikely(sb->s_type->fs_flags & FS_BINARY_MOUNTDATA)) {
+		BUG();
+		rc = -EINVAL;
+		goto out_err;
+	}
 
 	rc = selinux_parse_opts_str(options, &opts);
 	if (rc)
@@ -1042,6 +1046,7 @@ static void selinux_write_opts(struct seq_file *m,
 			continue;
 		default:
 			BUG();
+			continue;
 		};
 		/* we need a comma before each option */
 		seq_putc(m, ',');
@@ -1500,6 +1505,7 @@ static int task_has_capability(struct task_struct *tsk,
 		printk(KERN_ERR
 		       "SELinux:  out of range capability %d\n", cap);
 		BUG();
+		return -EPERM;
 	}
 
 	rc = avc_has_perm_noaudit(sid, sid, sclass, av, 0, &avd);
diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index 7100072..42cc59a 100644
--- a/security/selinux/netnode.c
+++ b/security/selinux/netnode.c
@@ -140,6 +140,7 @@ static struct sel_netnode *sel_netnode_find(const void *addr, u16 family)
 		break;
 	default:
 		BUG();
+		return NULL;
 	}
 
 	list_for_each_entry_rcu(node, &sel_netnode_hash[idx].list, list)
@@ -180,6 +181,7 @@ static void sel_netnode_insert(struct sel_netnode *node)
 		break;
 	default:
 		BUG();
+		return;
 	}
 
 	INIT_RCU_HEAD(&node->rcu);
@@ -240,6 +242,7 @@ static int sel_netnode_sid_slow(void *addr, u16 family, u32 *sid)
 		break;
 	default:
 		BUG();
+		ret = -EPROTONOSUPPORT;
 	}
 	if (ret != 0)
 		goto out;
diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/ss/ebitmap.h
index f283b43..3ef8c94 100644
--- a/security/selinux/ss/ebitmap.h
+++ b/security/selinux/ss/ebitmap.h
@@ -85,7 +85,10 @@ static inline int ebitmap_node_get_bit(struct ebitmap_node *n,
 	unsigned int index = EBITMAP_NODE_INDEX(n, bit);
 	unsigned int ofs = EBITMAP_NODE_OFFSET(n, bit);
 
-	BUG_ON(index >= EBITMAP_UNIT_NUMS);
+	if (unlikely((index >= EBITMAP_UNIT_NUMS))) {
+		panic("index >= EBITMAP_UNIT_NUMS");
+		return 0;
+	}
 	if ((n->maps[index] & (EBITMAP_BIT << ofs)))
 		return 1;
 	return 0;
@@ -97,7 +100,10 @@ static inline void ebitmap_node_set_bit(struct ebitmap_node *n,
 	unsigned int index = EBITMAP_NODE_INDEX(n, bit);
 	unsigned int ofs = EBITMAP_NODE_OFFSET(n, bit);
 
-	BUG_ON(index >= EBITMAP_UNIT_NUMS);
+	if (unlikely((index >= EBITMAP_UNIT_NUMS))) {
+		panic("index >= EBITMAP_UNIT_NUMS");
+		return;
+	}
 	n->maps[index] |= (EBITMAP_BIT << ofs);
 }
 
@@ -107,7 +113,10 @@ static inline void ebitmap_node_clr_bit(struct ebitmap_node *n,
 	unsigned int index = EBITMAP_NODE_INDEX(n, bit);
 	unsigned int ofs = EBITMAP_NODE_OFFSET(n, bit);
 
-	BUG_ON(index >= EBITMAP_UNIT_NUMS);
+	if (unlikely((index >= EBITMAP_UNIT_NUMS))) {
+		panic("index >= EBITMAP_UNIT_NUMS");
+		return;
+	}
 	n->maps[index] &= ~(EBITMAP_BIT << ofs);
 }
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index c65e4fe..6e0651a 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -120,16 +120,25 @@ static int constraint_expr_eval(struct context *scontext,
 	for (e = cexpr; e; e = e->next) {
 		switch (e->expr_type) {
 		case CEXPR_NOT:
-			BUG_ON(sp < 0);
+			if (unlikely(sp < 0)) {
+				panic("CEXPR_NOT with sp < 0\n");
+				return 0;
+			}
 			s[sp] = !s[sp];
 			break;
 		case CEXPR_AND:
-			BUG_ON(sp < 1);
+			if (unlikely(sp < 1)) {
+				panic("CEXPR_AND with sp < 1\n");
+				return 0;
+			}
 			sp--;
 			s[sp] &= s[sp+1];
 			break;
 		case CEXPR_OR:
-			BUG_ON(sp < 1);
+			if (unlikely(sp < 1)) {
+				panic("CEXPR_OR with sp < 1\n");
+				return 0;
+			}
 			sp--;
 			s[sp] |= s[sp+1];
 			break;
@@ -211,12 +220,12 @@ mls_ops:
 				s[++sp] = mls_level_incomp(l2, l1);
 				continue;
 			default:
-				BUG();
+				panic("CEXPR_ATTR: mls_ops, unknown e->op\n");
 				return 0;
 			}
 			break;
 			default:
-				BUG();
+				panic("CEXPR_ATTR: unknown e->attr\n");
 				return 0;
 			}
 
@@ -228,7 +237,7 @@ mls_ops:
 				s[++sp] = (val1 != val2);
 				break;
 			default:
-				BUG();
+				panic("CEXPR_ATTR: not mls_ops, unknown e->op\n");
 				return 0;
 			}
 			break;
@@ -241,7 +250,7 @@ mls_ops:
 			else if (e->attr & CEXPR_XTARGET) {
 				c = xcontext;
 				if (!c) {
-					BUG();
+					panic("CEXPR_NAMES: e->attr & CEXPR_XTARGET yet xcontext==NULL\n");
 					return 0;
 				}
 			}
@@ -252,7 +261,7 @@ mls_ops:
 			else if (e->attr & CEXPR_TYPE)
 				val1 = c->type;
 			else {
-				BUG();
+				panic("CEXPR_NAMES: e->attr unknown\n");
 				return 0;
 			}
 
@@ -264,17 +273,17 @@ mls_ops:
 				s[++sp] = !ebitmap_get_bit(&e->names, val1 - 1);
 				break;
 			default:
-				BUG();
+				panic("CEXPR_NAMES: e->op unknown\n");
 				return 0;
 			}
 			break;
 		default:
-			BUG();
+			panic("e->expr_type unknown\n");
 			return 0;
 		}
 	}
 
-	BUG_ON(sp != 0);
+	panic("sp != 0");
 	return s[0];
 }
 
@@ -541,7 +550,11 @@ int security_permissive_sid(u32 sid)
 	read_lock(&policy_rwlock);
 
 	context = sidtab_search(&sidtab, sid);
-	BUG_ON(!context);
+	if (unlikely(!context)) {
+		BUG();
+		rc = 0;
+		goto out;
+	}
 
 	type = context->type;
 	/*
@@ -550,6 +563,7 @@ int security_permissive_sid(u32 sid)
 	 */
 	rc = ebitmap_get_bit(&policydb.permissive_map, type);
 
+out:
 	read_unlock(&policy_rwlock);
 	return rc;
 }
@@ -697,7 +711,11 @@ int security_bounded_transition(u32 old_sid, u32 new_sid)
 	index = new_context->type;
 	while (true) {
 		type = policydb.type_val_to_struct[index - 1];
-		BUG_ON(!type);
+		if (unlikely(!type)) {
+			BUG();
+			rc = -EPERM;
+			goto out;
+		}
 
 		/* not bounded anymore */
 		if (!type->bounds) {
@@ -1381,7 +1399,10 @@ static int validate_classes(struct policydb *p)
 			continue;
 		pol_class = p->p_class_val_to_name[class_val-1];
 		cladatum = hashtab_search(p->p_classes.table, pol_class);
-		BUG_ON(!cladatum);
+		if (unlikely(!cladatum)) {
+			BUG();
+			return -EINVAL;
+		}
 		perms = &cladatum->permissions;
 		nprim = 1 << (perms->nprim - 1);
 		if (perm_val > nprim) {
@@ -1416,7 +1437,10 @@ static int validate_classes(struct policydb *p)
 			continue;
 		pol_class = p->p_class_val_to_name[class_val-1];
 		cladatum = hashtab_search(p->p_classes.table, pol_class);
-		BUG_ON(!cladatum);
+		if (unlikely(!cladatum)) {
+			BUG();
+			return -EINVAL;
+		}
 		if (!cladatum->comdatum) {
 			printk(KERN_ERR
 			       "SELinux:  class %s should have an inherits clause but does not\n",
diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index c0eb720..22413ec 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -202,7 +202,10 @@ static int selinux_xfrm_sec_ctx_alloc(struct xfrm_sec_ctx **ctxp,
 	char *ctx_str = NULL;
 	u32 str_len;
 
-	BUG_ON(uctx && sid);
+	if (unlikely(ctx && sid)) {
+		BUG();
+		return -EINVAL;
+	}
 
 	if (!uctx)
 		goto not_from_user;
@@ -288,7 +291,10 @@ int selinux_xfrm_policy_alloc(struct xfrm_sec_ctx **ctxp,
 {
 	int err;
 
-	BUG_ON(!uctx);
+	if (unlikely(!uctx)) {
+		BUG();
+		return -EINVAL;
+	}
 
 	err = selinux_xfrm_sec_ctx_alloc(ctxp, uctx, 0);
 	if (err == 0)
@@ -356,7 +362,10 @@ int selinux_xfrm_state_alloc(struct xfrm_state *x, struct xfrm_user_sec_ctx *uct
 {
 	int err;
 
-	BUG_ON(!x);
+	if (unlikely(!x)) {
+		BUG();
+		return -EINVAL;
+	}
 
 	err = selinux_xfrm_sec_ctx_alloc(&x->security, uctx, secid);
 	if (err == 0)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
