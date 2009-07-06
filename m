Subject: [PATCH 1/4 -v2] Namespacing of security/selinux
From: Thomas Liu <tliu@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org
Content-Type: text/plain
Date: Mon, 06 Jul 2009 14:58:38 -0400
Message-Id: <1246906718.2460.12.camel@Ares>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch namespaces the functions in security/selinux, prefixing
non static functions with selinux_

Patch 1 includes namespacing of the security/selinux folder,
not including security/selinux/ss.

Added selinux_ as a prefix to non static functions, not including
functions beginning with avc_.  Swapped security_ with selinux_.

Signed-off-by: Thomas Liu <tliu@redhat.com>
---
This new set of patches no longer uses selinux_ss_ and no longer
puts the selinux_ prefix in front of avc_.

Also fixed a minor mishap with a double underscore not compiling.
 security/selinux/avc.c                 |    8 ++--
 security/selinux/exports.c             |    2 +-
 security/selinux/hooks.c               |   80 ++++++++++++++++----------------
 security/selinux/include/conditional.h |    6 +-
 security/selinux/include/netnode.h     |    2 +-
 security/selinux/include/netport.h     |    2 +-
 security/selinux/include/security.h    |   60 ++++++++++++------------
 security/selinux/netif.c               |    2 +-
 security/selinux/netlabel.c            |    8 ++--
 security/selinux/netnode.c             |   16 +++---
 security/selinux/netport.c             |    4 +-
 security/selinux/selinuxfs.c           |   62 ++++++++++++------------
 security/selinux/ss/services.c         |   78 +++++++++++++++---------------
 security/selinux/xfrm.c                |    4 +-
 14 files changed, 167 insertions(+), 167 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 236aaa2..065e615 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -203,7 +203,7 @@ static void avc_dump_query(struct audit_buffer *ab, u32 ssid, u32 tsid, u16 tcla
 	char *scontext;
 	u32 scontext_len;
 
-	rc = security_sid_to_context(ssid, &scontext, &scontext_len);
+	rc = selinux_sid_to_context(ssid, &scontext, &scontext_len);
 	if (rc)
 		audit_log_format(ab, "ssid=%d", ssid);
 	else {
@@ -211,7 +211,7 @@ static void avc_dump_query(struct audit_buffer *ab, u32 ssid, u32 tsid, u16 tcla
 		kfree(scontext);
 	}
 
-	rc = security_sid_to_context(tsid, &scontext, &scontext_len);
+	rc = selinux_sid_to_context(tsid, &scontext, &scontext_len);
 	if (rc)
 		audit_log_format(ab, " tsid=%d", tsid);
 	else {
@@ -448,7 +448,7 @@ static int avc_latest_notif_update(int seqno, int is_insert)
  * (@ssid, @tsid) and class @tclass.
  * The access vectors and the sequence number are
  * normally provided by the security server in
- * response to a security_compute_av() call.  If the
+ * response to a selinux_compute_av() call.  If the
  * sequence number @avd->seqno is not less than the latest
  * revocation notification, then the function copies
  * the access vectors into a cache entry, returns
@@ -911,7 +911,7 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
 		else
 			avd = &avd_entry;
 
-		rc = security_compute_av(ssid, tsid, tclass, requested, avd);
+		rc = selinux_compute_av(ssid, tsid, tclass, requested, avd);
 		if (rc)
 			goto out;
 		rcu_read_lock();
diff --git a/security/selinux/exports.c b/security/selinux/exports.c
index c73aeaa..6a4674e 100644
--- a/security/selinux/exports.c
+++ b/security/selinux/exports.c
@@ -28,7 +28,7 @@ extern atomic_t selinux_secmark_refcount;
 int selinux_string_to_sid(char *str, u32 *sid)
 {
 	if (selinux_enabled)
-		return security_context_to_sid(str, strlen(str), sid);
+		return selinux_context_to_sid(str, strlen(str), sid);
 	else {
 		*sid = 0;
 		return 0;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 2081055..6c4513f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -525,21 +525,21 @@ static int selinux_get_mnt_opts(const struct super_block *sb,
 
 	i = 0;
 	if (sbsec->flags & FSCONTEXT_MNT) {
-		rc = security_sid_to_context(sbsec->sid, &context, &len);
+		rc = selinux_sid_to_context(sbsec->sid, &context, &len);
 		if (rc)
 			goto out_free;
 		opts->mnt_opts[i] = context;
 		opts->mnt_opts_flags[i++] = FSCONTEXT_MNT;
 	}
 	if (sbsec->flags & CONTEXT_MNT) {
-		rc = security_sid_to_context(sbsec->mntpoint_sid, &context, &len);
+		rc = selinux_sid_to_context(sbsec->mntpoint_sid, &context, &len);
 		if (rc)
 			goto out_free;
 		opts->mnt_opts[i] = context;
 		opts->mnt_opts_flags[i++] = CONTEXT_MNT;
 	}
 	if (sbsec->flags & DEFCONTEXT_MNT) {
-		rc = security_sid_to_context(sbsec->def_sid, &context, &len);
+		rc = selinux_sid_to_context(sbsec->def_sid, &context, &len);
 		if (rc)
 			goto out_free;
 		opts->mnt_opts[i] = context;
@@ -549,7 +549,7 @@ static int selinux_get_mnt_opts(const struct super_block *sb,
 		struct inode *root = sbsec->sb->s_root->d_inode;
 		struct inode_security_struct *isec = root->i_security;
 
-		rc = security_sid_to_context(isec->sid, &context, &len);
+		rc = selinux_sid_to_context(isec->sid, &context, &len);
 		if (rc)
 			goto out_free;
 		opts->mnt_opts[i] = context;
@@ -652,7 +652,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 
 		if (flags[i] == SE_SBLABELSUPP)
 			continue;
-		rc = security_context_to_sid(mount_options[i],
+		rc = selinux_context_to_sid(mount_options[i],
 					     strlen(mount_options[i]), &sid);
 		if (rc) {
 			printk(KERN_WARNING "SELinux: security_context_to_sid"
@@ -717,9 +717,9 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 		sbsec->flags |= SE_SBPROC;
 
 	/* Determine the labeling behavior to use for this filesystem type. */
-	rc = security_fs_use((sbsec->flags & SE_SBPROC) ? "proc" : sb->s_type->name, &sbsec->behavior, &sbsec->sid);
+	rc = selinux_fs_use((sbsec->flags & SE_SBPROC) ? "proc" : sb->s_type->name, &sbsec->behavior, &sbsec->sid);
 	if (rc) {
-		printk(KERN_WARNING "%s: security_fs_use(%s) returned %d\n",
+		printk(KERN_WARNING "%s: selinux_fs_use(%s) returned %d\n",
 		       __func__, sb->s_type->name, rc);
 		goto out;
 	}
@@ -1201,7 +1201,7 @@ static int selinux_proc_get_sid(struct proc_dir_entry *de,
 		path = end;
 		de = de->parent;
 	}
-	rc = security_genfs_sid("proc", path, tclass, sid);
+	rc = selinux_genfs_sid("proc", path, tclass, sid);
 	free_page((unsigned long)buffer);
 	return rc;
 }
@@ -1318,7 +1318,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 			sid = sbsec->def_sid;
 			rc = 0;
 		} else {
-			rc = security_context_to_sid_default(context, rc, &sid,
+			rc = selinux_context_to_sid_default(context, rc, &sid,
 							     sbsec->def_sid,
 							     GFP_NOFS);
 			if (rc) {
@@ -1353,7 +1353,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 
 		/* Try to obtain a transition SID. */
 		isec->sclass = inode_mode_to_security_class(inode->i_mode);
-		rc = security_transition_sid(isec->task_sid,
+		rc = selinux_transition_sid(isec->task_sid,
 					     sbsec->sid,
 					     isec->sclass,
 					     &sid);
@@ -1630,7 +1630,7 @@ static int may_create(struct inode *dir,
 		return rc;
 
 	if (!newsid || !(sbsec->flags & SE_SBLABELSUPP)) {
-		rc = security_transition_sid(sid, dsec->sid, tclass, &newsid);
+		rc = selinux_transition_sid(sid, dsec->sid, tclass, &newsid);
 		if (rc)
 			return rc;
 	}
@@ -1966,7 +1966,7 @@ static int selinux_sysctl_get_sid(ctl_table *table, u16 tclass, u32 *sid)
 	end -= 4;
 	memcpy(end, "/sys", 4);
 	path = end;
-	rc = security_genfs_sid("proc", path, tclass, sid);
+	rc = selinux_genfs_sid("proc", path, tclass, sid);
 out_free:
 	free_page((unsigned long)buffer);
 out:
@@ -2132,7 +2132,7 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
 		new_tsec->exec_sid = 0;
 	} else {
 		/* Check for a default transition on this program. */
-		rc = security_transition_sid(old_tsec->sid, isec->sid,
+		rc = selinux_transition_sid(old_tsec->sid, isec->sid,
 					     SECCLASS_PROCESS, &new_tsec->sid);
 		if (rc)
 			return rc;
@@ -2595,7 +2595,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 	newsid = tsec->create_sid;
 
 	if (!newsid || !(sbsec->flags & SE_SBLABELSUPP)) {
-		rc = security_transition_sid(sid, dsec->sid,
+		rc = selinux_transition_sid(sid, dsec->sid,
 					     inode_mode_to_security_class(inode->i_mode),
 					     &newsid);
 		if (rc) {
@@ -2627,7 +2627,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 	}
 
 	if (value && len) {
-		rc = security_sid_to_context_force(newsid, &context, &clen);
+		rc = selinux_sid_to_context_force(newsid, &context, &clen);
 		if (rc) {
 			kfree(namep);
 			return rc;
@@ -2777,11 +2777,11 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
 	if (rc)
 		return rc;
 
-	rc = security_context_to_sid(value, size, &newsid);
+	rc = selinux_context_to_sid(value, size, &newsid);
 	if (rc == -EINVAL) {
 		if (!capable(CAP_MAC_ADMIN))
 			return rc;
-		rc = security_context_to_sid_force(value, size, &newsid);
+		rc = selinux_context_to_sid_force(value, size, &newsid);
 	}
 	if (rc)
 		return rc;
@@ -2791,7 +2791,7 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
 	if (rc)
 		return rc;
 
-	rc = security_validate_transition(isec->sid, newsid, sid,
+	rc = selinux_validate_transition(isec->sid, newsid, sid,
 					  isec->sclass);
 	if (rc)
 		return rc;
@@ -2817,7 +2817,7 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
 		return;
 	}
 
-	rc = security_context_to_sid_force(value, size, &newsid);
+	rc = selinux_context_to_sid_force(value, size, &newsid);
 	if (rc) {
 		printk(KERN_ERR "SELinux:  unable to map context to SID"
 		       "for (%s, %lu), rc=%d\n",
@@ -2880,10 +2880,10 @@ static int selinux_inode_getsecurity(const struct inode *inode, const char *name
 	error = selinux_capable(current, current_cred(), CAP_MAC_ADMIN,
 				SECURITY_CAP_NOAUDIT);
 	if (!error)
-		error = security_sid_to_context_force(isec->sid, &context,
+		error = selinux_sid_to_context_force(isec->sid, &context,
 						      &size);
 	else
-		error = security_sid_to_context(isec->sid, &context, &size);
+		error = selinux_sid_to_context(isec->sid, &context, &size);
 	if (error)
 		return error;
 	error = size;
@@ -2909,7 +2909,7 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
 	if (!value || !size)
 		return -EACCES;
 
-	rc = security_context_to_sid((void *)value, size, &newsid);
+	rc = selinux_context_to_sid((void *)value, size, &newsid);
 	if (rc)
 		return rc;
 
@@ -3619,7 +3619,7 @@ static int selinux_skb_peerlbl_sid(struct sk_buff *skb, u16 family, u32 *sid)
 	selinux_skb_xfrm_sid(skb, &xfrm_sid);
 	selinux_netlbl_skbuff_getsid(skb, family, &nlbl_type, &nlbl_sid);
 
-	err = security_net_peersid_resolve(nlbl_sid, nlbl_type, xfrm_sid, sid);
+	err = selinux_net_peersid_resolve(nlbl_sid, nlbl_type, xfrm_sid, sid);
 	if (unlikely(err)) {
 		printk(KERN_WARNING
 		       "SELinux: failure in selinux_skb_peerlbl_sid(),"
@@ -3757,7 +3757,7 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 			inet_get_local_port_range(&low, &high);
 
 			if (snum < max(PROT_SOCK, low) || snum > high) {
-				err = sel_netport_sid(sk->sk_protocol,
+				err = selinux_netport_sid(sk->sk_protocol,
 						      snum, &sid);
 				if (err)
 					goto out;
@@ -3790,7 +3790,7 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 			break;
 		}
 
-		err = sel_netnode_sid(addrp, family, &sid);
+		err = selinux_netnode_sid(addrp, family, &sid);
 		if (err)
 			goto out;
 
@@ -3846,7 +3846,7 @@ static int selinux_socket_connect(struct socket *sock, struct sockaddr *address,
 			snum = ntohs(addr6->sin6_port);
 		}
 
-		err = sel_netport_sid(sk->sk_protocol, snum, &sid);
+		err = selinux_netport_sid(sk->sk_protocol, snum, &sid);
 		if (err)
 			goto out;
 
@@ -3965,7 +3965,7 @@ static int selinux_socket_unix_stream_connect(struct socket *sock,
 	/* server child socket */
 	ssec = newsk->sk_security;
 	ssec->peer_sid = isec->sid;
-	err = security_sid_mls_copy(other_isec->sid, ssec->peer_sid, &ssec->sid);
+	err = selinux_sid_mls_copy(other_isec->sid, ssec->peer_sid, &ssec->sid);
 
 	return err;
 }
@@ -4008,7 +4008,7 @@ static int selinux_inet_sys_rcv_skb(int ifindex, char *addrp, u16 family,
 	if (err)
 		return err;
 
-	err = sel_netnode_sid(addrp, family, &node_sid);
+	err = selinux_netnode_sid(addrp, family, &node_sid);
 	if (err)
 		return err;
 	return avc_has_perm(peer_sid, node_sid,
@@ -4144,7 +4144,7 @@ static int selinux_socket_getpeersec_stream(struct socket *sock, char __user *op
 		goto out;
 	}
 
-	err = security_sid_to_context(peer_sid, &scontext, &scontext_len);
+	err = selinux_sid_to_context(peer_sid, &scontext, &scontext_len);
 
 	if (err)
 		goto out;
@@ -4256,7 +4256,7 @@ static int selinux_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 		req->secid = sksec->sid;
 		req->peer_secid = SECSID_NULL;
 	} else {
-		err = security_sid_mls_copy(sksec->sid, peersid, &newsid);
+		err = selinux_sid_mls_copy(sksec->sid, peersid, &newsid);
 		if (err)
 			return err;
 		req->secid = newsid;
@@ -4322,7 +4322,7 @@ static int selinux_nlmsg_perm(struct sock *sk, struct sk_buff *skb)
 				  "SELinux:  unrecognized netlink message"
 				  " type=%hu for sclass=%hu\n",
 				  nlh->nlmsg_type, isec->sclass);
-			if (!selinux_enforcing || security_get_allow_unknown())
+			if (!selinux_enforcing || selinux_get_allow_unknown())
 				err = 0;
 		}
 
@@ -4562,7 +4562,7 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb, int ifindex,
 				 SECCLASS_NETIF, NETIF__EGRESS, &ad))
 			return NF_DROP;
 
-		if (sel_netnode_sid(addrp, family, &node_sid))
+		if (selinux_netnode_sid(addrp, family, &node_sid))
 			return NF_DROP;
 		if (avc_has_perm(peer_sid, node_sid,
 				 SECCLASS_NODE, NODE__SENDTO, &ad))
@@ -4790,7 +4790,7 @@ static int selinux_msg_queue_msgsnd(struct msg_queue *msq, struct msg_msg *msg,
 		 * Compute new sid based on current process and
 		 * message queue this message will be stored in
 		 */
-		rc = security_transition_sid(sid, isec->sid, SECCLASS_MSG,
+		rc = selinux_transition_sid(sid, isec->sid, SECCLASS_MSG,
 					     &msec->sid);
 		if (rc)
 			return rc;
@@ -5095,7 +5095,7 @@ static int selinux_getprocattr(struct task_struct *p,
 	if (!sid)
 		return 0;
 
-	error = security_sid_to_context(sid, value, &len);
+	error = selinux_sid_to_context(sid, value, &len);
 	if (error)
 		return error;
 	return len;
@@ -5147,11 +5147,11 @@ static int selinux_setprocattr(struct task_struct *p,
 			str[size-1] = 0;
 			size--;
 		}
-		error = security_context_to_sid(value, size, &sid);
+		error = selinux_context_to_sid(value, size, &sid);
 		if (error == -EINVAL && !strcmp(name, "fscreate")) {
 			if (!capable(CAP_MAC_ADMIN))
 				return error;
-			error = security_context_to_sid_force(value, size,
+			error = selinux_context_to_sid_force(value, size,
 							      &sid);
 		}
 		if (error)
@@ -5188,7 +5188,7 @@ static int selinux_setprocattr(struct task_struct *p,
 		/* Only allow single threaded processes to change context */
 		error = -EPERM;
 		if (!is_single_threaded(p)) {
-			error = security_bounded_transition(tsec->sid, sid);
+			error = selinux_bounded_transition(tsec->sid, sid);
 			if (error)
 				goto abort_change;
 		}
@@ -5231,12 +5231,12 @@ abort_change:
 
 static int selinux_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 {
-	return security_sid_to_context(secid, secdata, seclen);
+	return selinux_sid_to_context(secid, secdata, seclen);
 }
 
 static int selinux_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 {
-	return security_context_to_sid(secdata, seclen, secid);
+	return selinux_context_to_sid(secdata, seclen, secid);
 }
 
 static void selinux_release_secctx(char *secdata, u32 seclen)
@@ -5303,7 +5303,7 @@ static int selinux_key_getsecurity(struct key *key, char **_buffer)
 	unsigned len;
 	int rc;
 
-	rc = security_sid_to_context(ksec->sid, &context, &len);
+	rc = selinux_sid_to_context(ksec->sid, &context, &len);
 	if (!rc)
 		rc = len;
 	*_buffer = context;
diff --git a/security/selinux/include/conditional.h b/security/selinux/include/conditional.h
index 67ce7a8..821a4a0 100644
--- a/security/selinux/include/conditional.h
+++ b/security/selinux/include/conditional.h
@@ -13,10 +13,10 @@
 #ifndef _SELINUX_CONDITIONAL_H_
 #define _SELINUX_CONDITIONAL_H_
 
-int security_get_bools(int *len, char ***names, int **values);
+int selinux_get_bools(int *len, char ***names, int **values);
 
-int security_set_bools(int len, int *values);
+int selinux_set_bools(int len, int *values);
 
-int security_get_bool_value(int bool);
+int selinux_get_bool_value(int bool);
 
 #endif
diff --git a/security/selinux/include/netnode.h b/security/selinux/include/netnode.h
index 1b94450..a31c65e 100644
--- a/security/selinux/include/netnode.h
+++ b/security/selinux/include/netnode.h
@@ -27,6 +27,6 @@
 #ifndef _SELINUX_NETNODE_H
 #define _SELINUX_NETNODE_H
 
-int sel_netnode_sid(void *addr, u16 family, u32 *sid);
+int selinux_netnode_sid(void *addr, u16 family, u32 *sid);
 
 #endif
diff --git a/security/selinux/include/netport.h b/security/selinux/include/netport.h
index 8991752..9d56bfb 100644
--- a/security/selinux/include/netport.h
+++ b/security/selinux/include/netport.h
@@ -26,6 +26,6 @@
 #ifndef _SELINUX_NETPORT_H
 #define _SELINUX_NETPORT_H
 
-int sel_netport_sid(u8 protocol, u16 pnum, u32 *sid);
+int selinux_netport_sid(u8 protocol, u16 pnum, u32 *sid);
 
 #endif
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index ca83579..44f1664 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -80,9 +80,9 @@ extern int selinux_policycap_openperm;
 /* limitation of boundary depth  */
 #define POLICYDB_BOUNDS_MAXDEPTH	4
 
-int security_load_policy(void *data, size_t len);
+int selinux_load_policy(void *data, size_t len);
 
-int security_policycap_supported(unsigned int req_cap);
+int selinux_policycap_supported(unsigned int req_cap);
 
 #define SEL_VEC_MAX 32
 struct av_decision {
@@ -96,58 +96,58 @@ struct av_decision {
 /* definitions of av_decision.flags */
 #define AVD_FLAGS_PERMISSIVE	0x0001
 
-int security_compute_av(u32 ssid, u32 tsid,
+int selinux_compute_av(u32 ssid, u32 tsid,
 	u16 tclass, u32 requested,
 	struct av_decision *avd);
 
-int security_transition_sid(u32 ssid, u32 tsid,
+int selinux_transition_sid(u32 ssid, u32 tsid,
 	u16 tclass, u32 *out_sid);
 
-int security_member_sid(u32 ssid, u32 tsid,
+int selinux_member_sid(u32 ssid, u32 tsid,
 	u16 tclass, u32 *out_sid);
 
-int security_change_sid(u32 ssid, u32 tsid,
+int selinux_change_sid(u32 ssid, u32 tsid,
 	u16 tclass, u32 *out_sid);
 
-int security_sid_to_context(u32 sid, char **scontext,
+int selinux_sid_to_context(u32 sid, char **scontext,
 	u32 *scontext_len);
 
-int security_sid_to_context_force(u32 sid, char **scontext, u32 *scontext_len);
+int selinux_sid_to_context_force(u32 sid, char **scontext, u32 *scontext_len);
 
-int security_context_to_sid(const char *scontext, u32 scontext_len,
+int selinux_context_to_sid(const char *scontext, u32 scontext_len,
 	u32 *out_sid);
 
-int security_context_to_sid_default(const char *scontext, u32 scontext_len,
+int selinux_context_to_sid_default(const char *scontext, u32 scontext_len,
 				    u32 *out_sid, u32 def_sid, gfp_t gfp_flags);
 
-int security_context_to_sid_force(const char *scontext, u32 scontext_len,
+int selinux_context_to_sid_force(const char *scontext, u32 scontext_len,
 				  u32 *sid);
 
-int security_get_user_sids(u32 callsid, char *username,
+int selinux_get_user_sids(u32 callsid, char *username,
 			   u32 **sids, u32 *nel);
 
-int security_port_sid(u8 protocol, u16 port, u32 *out_sid);
+int selinux_port_sid(u8 protocol, u16 port, u32 *out_sid);
 
-int security_netif_sid(char *name, u32 *if_sid);
+int selinux_netif_sid(char *name, u32 *if_sid);
 
-int security_node_sid(u16 domain, void *addr, u32 addrlen,
+int selinux_node_sid(u16 domain, void *addr, u32 addrlen,
 	u32 *out_sid);
 
-int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
+int selinux_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
 				 u16 tclass);
 
-int security_bounded_transition(u32 oldsid, u32 newsid);
+int selinux_bounded_transition(u32 oldsid, u32 newsid);
 
-int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid);
+int selinux_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid);
 
-int security_net_peersid_resolve(u32 nlbl_sid, u32 nlbl_type,
+int selinux_net_peersid_resolve(u32 nlbl_sid, u32 nlbl_type,
 				 u32 xfrm_sid,
 				 u32 *peer_sid);
 
-int security_get_classes(char ***classes, int *nclasses);
-int security_get_permissions(char *class, char ***perms, int *nperms);
-int security_get_reject_unknown(void);
-int security_get_allow_unknown(void);
+int selinux_get_classes(char ***classes, int *nclasses);
+int selinux_get_permissions(char *class, char ***perms, int *nperms);
+int selinux_get_reject_unknown(void);
+int selinux_get_allow_unknown(void);
 
 #define SECURITY_FS_USE_XATTR		1 /* use xattr */
 #define SECURITY_FS_USE_TRANS		2 /* use transition SIDs, e.g. devpts/tmpfs */
@@ -156,34 +156,34 @@ int security_get_allow_unknown(void);
 #define SECURITY_FS_USE_NONE		5 /* no labeling support */
 #define SECURITY_FS_USE_MNTPOINT	6 /* use mountpoint labeling */
 
-int security_fs_use(const char *fstype, unsigned int *behavior,
+int selinux_fs_use(const char *fstype, unsigned int *behavior,
 	u32 *sid);
 
-int security_genfs_sid(const char *fstype, char *name, u16 sclass,
+int selinux_genfs_sid(const char *fstype, char *name, u16 sclass,
 	u32 *sid);
 
 #ifdef CONFIG_NETLABEL
-int security_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
+int selinux_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
 				   u32 *sid);
 
-int security_netlbl_sid_to_secattr(u32 sid,
+int selinux_netlbl_sid_to_secattr(u32 sid,
 				   struct netlbl_lsm_secattr *secattr);
 #else
-static inline int security_netlbl_secattr_to_sid(
+static inline int selinux_netlbl_secattr_to_sid(
 					    struct netlbl_lsm_secattr *secattr,
 					    u32 *sid)
 {
 	return -EIDRM;
 }
 
-static inline int security_netlbl_sid_to_secattr(u32 sid,
+static inline int selinux_netlbl_sid_to_secattr(u32 sid,
 					   struct netlbl_lsm_secattr *secattr)
 {
 	return -ENOENT;
 }
 #endif /* CONFIG_NETLABEL */
 
-const char *security_get_initial_sid_context(u32 sid);
+const char *selinux_get_initial_sid_context(u32 sid);
 
 #endif /* _SELINUX_SECURITY_H_ */
 
diff --git a/security/selinux/netif.c b/security/selinux/netif.c
index b4e14bc..da6a8a3 100644
--- a/security/selinux/netif.c
+++ b/security/selinux/netif.c
@@ -175,7 +175,7 @@ static int sel_netif_sid_slow(int ifindex, u32 *sid)
 		ret = -ENOMEM;
 		goto out;
 	}
-	ret = security_netif_sid(dev->name, &new->nsec.sid);
+	ret = selinux_netif_sid(dev->name, &new->nsec.sid);
 	if (ret != 0)
 		goto out;
 	new->nsec.ifindex = ifindex;
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 2e98441..60a8a84 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -58,7 +58,7 @@ static int selinux_netlbl_sidlookup_cached(struct sk_buff *skb,
 {
 	int rc;
 
-	rc = security_netlbl_secattr_to_sid(secattr, sid);
+	rc = selinux_netlbl_secattr_to_sid(secattr, sid);
 	if (rc == 0 &&
 	    (secattr->flags & NETLBL_SECATTR_CACHEABLE) &&
 	    (secattr->flags & NETLBL_SECATTR_CACHE))
@@ -89,7 +89,7 @@ static struct netlbl_lsm_secattr *selinux_netlbl_sock_genattr(struct sock *sk)
 	secattr = netlbl_secattr_alloc(GFP_ATOMIC);
 	if (secattr == NULL)
 		return NULL;
-	rc = security_netlbl_sid_to_secattr(sksec->sid, secattr);
+	rc = selinux_netlbl_sid_to_secattr(sksec->sid, secattr);
 	if (rc != 0) {
 		netlbl_secattr_free(secattr);
 		return NULL;
@@ -228,7 +228,7 @@ int selinux_netlbl_skbuff_setsid(struct sk_buff *skb,
 	if (secattr == NULL) {
 		secattr = &secattr_storage;
 		netlbl_secattr_init(secattr);
-		rc = security_netlbl_sid_to_secattr(sid, secattr);
+		rc = selinux_netlbl_sid_to_secattr(sid, secattr);
 		if (rc != 0)
 			goto skbuff_setsid_return;
 	}
@@ -261,7 +261,7 @@ int selinux_netlbl_inet_conn_request(struct request_sock *req, u16 family)
 		return 0;
 
 	netlbl_secattr_init(&secattr);
-	rc = security_netlbl_sid_to_secattr(req->secid, &secattr);
+	rc = selinux_netlbl_sid_to_secattr(req->secid, &secattr);
 	if (rc != 0)
 		goto inet_conn_request_return;
 	rc = netlbl_req_setattr(req, &secattr);
diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index 7100072..f382cf1 100644
--- a/security/selinux/netnode.c
+++ b/security/selinux/netnode.c
@@ -199,7 +199,7 @@ static void sel_netnode_insert(struct sel_netnode *node)
 }
 
 /**
- * sel_netnode_sid_slow - Lookup the SID of a network address using the policy
+ * selinux_netnode_sid_slow - Lookup the SID of a network address using the policy
  * @addr: the IP address
  * @family: the address family
  * @sid: node SID
@@ -211,7 +211,7 @@ static void sel_netnode_insert(struct sel_netnode *node)
  * failure.
  *
  */
-static int sel_netnode_sid_slow(void *addr, u16 family, u32 *sid)
+static int selinux_netnode_sid_slow(void *addr, u16 family, u32 *sid)
 {
 	int ret = -ENOMEM;
 	struct sel_netnode *node;
@@ -229,12 +229,12 @@ static int sel_netnode_sid_slow(void *addr, u16 family, u32 *sid)
 		goto out;
 	switch (family) {
 	case PF_INET:
-		ret = security_node_sid(PF_INET,
+		ret = selinux_node_sid(PF_INET,
 					addr, sizeof(struct in_addr), sid);
 		new->nsec.addr.ipv4 = *(__be32 *)addr;
 		break;
 	case PF_INET6:
-		ret = security_node_sid(PF_INET6,
+		ret = selinux_node_sid(PF_INET6,
 					addr, sizeof(struct in6_addr), sid);
 		ipv6_addr_copy(&new->nsec.addr.ipv6, addr);
 		break;
@@ -252,7 +252,7 @@ out:
 	spin_unlock_bh(&sel_netnode_lock);
 	if (unlikely(ret)) {
 		printk(KERN_WARNING
-		       "SELinux: failure in sel_netnode_sid_slow(),"
+		       "SELinux: failure in selinux_netnode_sid_slow(),"
 		       " unable to determine network node label\n");
 		kfree(new);
 	}
@@ -260,7 +260,7 @@ out:
 }
 
 /**
- * sel_netnode_sid - Lookup the SID of a network address
+ * selinux_netnode_sid - Lookup the SID of a network address
  * @addr: the IP address
  * @family: the address family
  * @sid: node SID
@@ -273,7 +273,7 @@ out:
  * on failure.
  *
  */
-int sel_netnode_sid(void *addr, u16 family, u32 *sid)
+int selinux_netnode_sid(void *addr, u16 family, u32 *sid)
 {
 	struct sel_netnode *node;
 
@@ -286,7 +286,7 @@ int sel_netnode_sid(void *addr, u16 family, u32 *sid)
 	}
 	rcu_read_unlock();
 
-	return sel_netnode_sid_slow(addr, family, sid);
+	return selinux_netnode_sid_slow(addr, family, sid);
 }
 
 /**
diff --git a/security/selinux/netport.c b/security/selinux/netport.c
index fe7fba6..35b8154 100644
--- a/security/selinux/netport.c
+++ b/security/selinux/netport.c
@@ -174,7 +174,7 @@ static int sel_netport_sid_slow(u8 protocol, u16 pnum, u32 *sid)
 	new = kzalloc(sizeof(*new), GFP_ATOMIC);
 	if (new == NULL)
 		goto out;
-	ret = security_port_sid(protocol, pnum, sid);
+	ret = selinux_port_sid(protocol, pnum, sid);
 	if (ret != 0)
 		goto out;
 
@@ -207,7 +207,7 @@ out:
  * future queries.  Returns zero on success, negative values on failure.
  *
  */
-int sel_netport_sid(u8 protocol, u16 pnum, u32 *sid)
+int selinux_netport_sid(u8 protocol, u16 pnum, u32 *sid)
 {
 	struct sel_netport *port;
 
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index b4fc506..ea2367d 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -193,7 +193,7 @@ static ssize_t sel_read_handle_unknown(struct file *filp, char __user *buf,
 	ssize_t length;
 	ino_t ino = filp->f_path.dentry->d_inode->i_ino;
 	int handle_unknown = (ino == SEL_REJECT_UNKNOWN) ?
-		security_get_reject_unknown() : !security_get_allow_unknown();
+		selinux_get_reject_unknown() : !selinux_get_allow_unknown();
 
 	length = scnprintf(tmpbuf, TMPBUFLEN, "%d", handle_unknown);
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
@@ -320,7 +320,7 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	if (copy_from_user(data, buf, count) != 0)
 		goto out;
 
-	length = security_load_policy(data, count);
+	length = selinux_load_policy(data, count);
 	if (length)
 		goto out;
 
@@ -367,11 +367,11 @@ static ssize_t sel_write_context(struct file *file, char *buf, size_t size)
 	if (length)
 		return length;
 
-	length = security_context_to_sid(buf, size, &sid);
+	length = selinux_context_to_sid(buf, size, &sid);
 	if (length < 0)
 		return length;
 
-	length = security_sid_to_context(sid, &canon, &len);
+	length = selinux_sid_to_context(sid, &canon, &len);
 	if (length < 0)
 		return length;
 
@@ -515,14 +515,14 @@ static ssize_t sel_write_access(struct file *file, char *buf, size_t size)
 	if (sscanf(buf, "%s %s %hu %x", scon, tcon, &tclass, &req) != 4)
 		goto out2;
 
-	length = security_context_to_sid(scon, strlen(scon)+1, &ssid);
+	length = selinux_context_to_sid(scon, strlen(scon)+1, &ssid);
 	if (length < 0)
 		goto out2;
-	length = security_context_to_sid(tcon, strlen(tcon)+1, &tsid);
+	length = selinux_context_to_sid(tcon, strlen(tcon)+1, &tsid);
 	if (length < 0)
 		goto out2;
 
-	length = security_compute_av(ssid, tsid, tclass, req, &avd);
+	length = selinux_compute_av(ssid, tsid, tclass, req, &avd);
 	if (length < 0)
 		goto out2;
 
@@ -564,18 +564,18 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
 	if (sscanf(buf, "%s %s %hu", scon, tcon, &tclass) != 3)
 		goto out2;
 
-	length = security_context_to_sid(scon, strlen(scon)+1, &ssid);
+	length = selinux_context_to_sid(scon, strlen(scon)+1, &ssid);
 	if (length < 0)
 		goto out2;
-	length = security_context_to_sid(tcon, strlen(tcon)+1, &tsid);
+	length = selinux_context_to_sid(tcon, strlen(tcon)+1, &tsid);
 	if (length < 0)
 		goto out2;
 
-	length = security_transition_sid(ssid, tsid, tclass, &newsid);
+	length = selinux_transition_sid(ssid, tsid, tclass, &newsid);
 	if (length < 0)
 		goto out2;
 
-	length = security_sid_to_context(newsid, &newcon, &len);
+	length = selinux_sid_to_context(newsid, &newcon, &len);
 	if (length < 0)
 		goto out2;
 
@@ -623,18 +623,18 @@ static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size)
 	if (sscanf(buf, "%s %s %hu", scon, tcon, &tclass) != 3)
 		goto out2;
 
-	length = security_context_to_sid(scon, strlen(scon)+1, &ssid);
+	length = selinux_context_to_sid(scon, strlen(scon)+1, &ssid);
 	if (length < 0)
 		goto out2;
-	length = security_context_to_sid(tcon, strlen(tcon)+1, &tsid);
+	length = selinux_context_to_sid(tcon, strlen(tcon)+1, &tsid);
 	if (length < 0)
 		goto out2;
 
-	length = security_change_sid(ssid, tsid, tclass, &newsid);
+	length = selinux_change_sid(ssid, tsid, tclass, &newsid);
 	if (length < 0)
 		goto out2;
 
-	length = security_sid_to_context(newsid, &newcon, &len);
+	length = selinux_sid_to_context(newsid, &newcon, &len);
 	if (length < 0)
 		goto out2;
 
@@ -680,18 +680,18 @@ static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 	if (sscanf(buf, "%s %s", con, user) != 2)
 		goto out2;
 
-	length = security_context_to_sid(con, strlen(con)+1, &sid);
+	length = selinux_context_to_sid(con, strlen(con)+1, &sid);
 	if (length < 0)
 		goto out2;
 
-	length = security_get_user_sids(sid, user, &sids, &nsids);
+	length = selinux_get_user_sids(sid, user, &sids, &nsids);
 	if (length < 0)
 		goto out2;
 
 	length = sprintf(buf, "%u", nsids) + 1;
 	ptr = buf + length;
 	for (i = 0; i < nsids; i++) {
-		rc = security_sid_to_context(sids[i], &newcon, &len);
+		rc = selinux_sid_to_context(sids[i], &newcon, &len);
 		if (rc) {
 			length = rc;
 			goto out3;
@@ -741,18 +741,18 @@ static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
 	if (sscanf(buf, "%s %s %hu", scon, tcon, &tclass) != 3)
 		goto out2;
 
-	length = security_context_to_sid(scon, strlen(scon)+1, &ssid);
+	length = selinux_context_to_sid(scon, strlen(scon)+1, &ssid);
 	if (length < 0)
 		goto out2;
-	length = security_context_to_sid(tcon, strlen(tcon)+1, &tsid);
+	length = selinux_context_to_sid(tcon, strlen(tcon)+1, &tsid);
 	if (length < 0)
 		goto out2;
 
-	length = security_member_sid(ssid, tsid, tclass, &newsid);
+	length = selinux_member_sid(ssid, tsid, tclass, &newsid);
 	if (length < 0)
 		goto out2;
 
-	length = security_sid_to_context(newsid, &newcon, &len);
+	length = selinux_sid_to_context(newsid, &newcon, &len);
 	if (length < 0)
 		goto out2;
 
@@ -809,7 +809,7 @@ static ssize_t sel_read_bool(struct file *filep, char __user *buf,
 		goto out;
 	}
 
-	cur_enforcing = security_get_bool_value(index);
+	cur_enforcing = selinux_get_bool_value(index);
 	if (cur_enforcing < 0) {
 		ret = cur_enforcing;
 		goto out;
@@ -924,7 +924,7 @@ static ssize_t sel_commit_bools_write(struct file *filep,
 		goto out;
 
 	if (new_value && bool_pending_values)
-		security_set_bools(bool_num, bool_pending_values);
+		selinux_set_bools(bool_num, bool_pending_values);
 
 	length = count;
 
@@ -990,7 +990,7 @@ static int sel_make_bools(void)
 	if (!page)
 		return -ENOMEM;
 
-	ret = security_get_bools(&num, &names, &values);
+	ret = selinux_get_bools(&num, &names, &values);
 	if (ret != 0)
 		goto out;
 
@@ -1015,7 +1015,7 @@ static int sel_make_bools(void)
 			goto err;
 		}
 		isec = (struct inode_security_struct *)inode->i_security;
-		ret = security_genfs_sid("selinuxfs", page, SECCLASS_FILE, &sid);
+		ret = selinux_genfs_sid("selinuxfs", page, SECCLASS_FILE, &sid);
 		if (ret)
 			goto err;
 		isec->sid = sid;
@@ -1244,7 +1244,7 @@ static ssize_t sel_read_initcon(struct file *file, char __user *buf,
 
 	inode = file->f_path.dentry->d_inode;
 	sid = inode->i_ino&SEL_INO_MASK;
-	ret = security_sid_to_context(sid, &con, &len);
+	ret = selinux_sid_to_context(sid, &con, &len);
 	if (ret < 0)
 		return ret;
 
@@ -1264,7 +1264,7 @@ static int sel_make_initcon_files(struct dentry *dir)
 	for (i = 1; i <= SECINITSID_NUM; i++) {
 		struct inode *inode;
 		struct dentry *dentry;
-		dentry = d_alloc_name(dir, security_get_initial_sid_context(i));
+		dentry = d_alloc_name(dir, selinux_get_initial_sid_context(i));
 		if (!dentry) {
 			ret = -ENOMEM;
 			goto out;
@@ -1364,7 +1364,7 @@ static ssize_t sel_read_policycap(struct file *file, char __user *buf,
 	ssize_t length;
 	unsigned long i_ino = file->f_path.dentry->d_inode->i_ino;
 
-	value = security_policycap_supported(i_ino & SEL_INO_MASK);
+	value = selinux_policycap_supported(i_ino & SEL_INO_MASK);
 	length = scnprintf(tmpbuf, TMPBUFLEN, "%d", value);
 
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
@@ -1380,7 +1380,7 @@ static int sel_make_perm_files(char *objclass, int classvalue,
 	int i, rc = 0, nperms;
 	char **perms;
 
-	rc = security_get_permissions(objclass, &perms, &nperms);
+	rc = selinux_get_permissions(objclass, &perms, &nperms);
 	if (rc)
 		goto out;
 
@@ -1484,7 +1484,7 @@ static int sel_make_classes(void)
 	/* delete any existing entries */
 	sel_remove_classes();
 
-	rc = security_get_classes(&classes, &nclasses);
+	rc = selinux_get_classes(&classes, &nclasses);
 	if (rc < 0)
 		goto out;
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index ff17820..55816c0 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -635,7 +635,7 @@ out:
 	return -EPERM;
 }
 
-int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
+int selinux_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
 				 u16 tclass)
 {
 	struct context *ocontext;
@@ -718,7 +718,7 @@ out:
  * @oldsid : current security identifier
  * @newsid : destinated security identifier
  */
-int security_bounded_transition(u32 old_sid, u32 new_sid)
+int selinux_bounded_transition(u32 old_sid, u32 new_sid)
 {
 	struct context *old_context, *new_context;
 	struct type_datum *type;
@@ -805,7 +805,7 @@ out:
  * Return -%EINVAL if any of the parameters are invalid or %0
  * if the access vector decisions were computed successfully.
  */
-int security_compute_av(u32 ssid,
+int selinux_compute_av(u32 ssid,
 			u32 tsid,
 			u16 tclass,
 			u32 requested,
@@ -904,7 +904,7 @@ static int context_struct_to_string(struct context *context, char **scontext, u3
 
 #include "initial_sid_to_string.h"
 
-const char *security_get_initial_sid_context(u32 sid)
+const char *selinux_get_initial_sid_context(u32 sid)
 {
 	if (unlikely(sid > SECINITSID_NUM))
 		return NULL;
@@ -968,12 +968,12 @@ out:
  * into a dynamically allocated string of the correct size.  Set @scontext
  * to point to this string and set @scontext_len to the length of the string.
  */
-int security_sid_to_context(u32 sid, char **scontext, u32 *scontext_len)
+int selinux_sid_to_context(u32 sid, char **scontext, u32 *scontext_len)
 {
 	return security_sid_to_context_core(sid, scontext, scontext_len, 0);
 }
 
-int security_sid_to_context_force(u32 sid, char **scontext, u32 *scontext_len)
+int selinux_sid_to_context_force(u32 sid, char **scontext, u32 *scontext_len)
 {
 	return security_sid_to_context_core(sid, scontext, scontext_len, 1);
 }
@@ -1134,7 +1134,7 @@ out:
  * Returns -%EINVAL if the context is invalid, -%ENOMEM if insufficient
  * memory is available, or 0 on success.
  */
-int security_context_to_sid(const char *scontext, u32 scontext_len, u32 *sid)
+int selinux_context_to_sid(const char *scontext, u32 scontext_len, u32 *sid)
 {
 	return security_context_to_sid_core(scontext, scontext_len,
 					    sid, SECSID_NULL, GFP_KERNEL, 0);
@@ -1158,14 +1158,14 @@ int security_context_to_sid(const char *scontext, u32 scontext_len, u32 *sid)
  * Returns -%EINVAL if the context is invalid, -%ENOMEM if insufficient
  * memory is available, or 0 on success.
  */
-int security_context_to_sid_default(const char *scontext, u32 scontext_len,
+int selinux_context_to_sid_default(const char *scontext, u32 scontext_len,
 				    u32 *sid, u32 def_sid, gfp_t gfp_flags)
 {
 	return security_context_to_sid_core(scontext, scontext_len,
 					    sid, def_sid, gfp_flags, 1);
 }
 
-int security_context_to_sid_force(const char *scontext, u32 scontext_len,
+int selinux_context_to_sid_force(const char *scontext, u32 scontext_len,
 				  u32 *sid)
 {
 	return security_context_to_sid_core(scontext, scontext_len,
@@ -1353,7 +1353,7 @@ out:
  * if insufficient memory is available, or %0 if the new SID was
  * computed successfully.
  */
-int security_transition_sid(u32 ssid,
+int selinux_transition_sid(u32 ssid,
 			    u32 tsid,
 			    u16 tclass,
 			    u32 *out_sid)
@@ -1374,7 +1374,7 @@ int security_transition_sid(u32 ssid,
  * if insufficient memory is available, or %0 if the SID was
  * computed successfully.
  */
-int security_member_sid(u32 ssid,
+int selinux_member_sid(u32 ssid,
 			u32 tsid,
 			u16 tclass,
 			u32 *out_sid)
@@ -1395,7 +1395,7 @@ int security_member_sid(u32 ssid,
  * if insufficient memory is available, or %0 if the SID was
  * computed successfully.
  */
-int security_change_sid(u32 ssid,
+int selinux_change_sid(u32 ssid,
 			u32 tsid,
 			u16 tclass,
 			u32 *out_sid)
@@ -1536,7 +1536,7 @@ static int validate_classes(struct policydb *p)
 	}
 	if (print_unknown_handle)
 		printk(KERN_INFO "SELinux: the above unknown classes and permissions will be %s\n",
-			(security_get_allow_unknown() ? "allowed" : "denied"));
+			(selinux_get_allow_unknown() ? "allowed" : "denied"));
 	return 0;
 }
 
@@ -1685,7 +1685,7 @@ bad:
 	goto out;
 }
 
-static void security_load_policycaps(void)
+static void selinux_load_policycaps(void)
 {
 	selinux_policycap_netpeer = ebitmap_get_bit(&policydb.policycaps,
 						  POLICYDB_CAPABILITY_NETPEER);
@@ -1697,7 +1697,7 @@ extern void selinux_complete_init(void);
 static int security_preserve_bools(struct policydb *p);
 
 /**
- * security_load_policy - Load a security policy configuration.
+ * selinux_load_policy - Load a security policy configuration.
  * @data: binary policy data
  * @len: length of data in bytes
  *
@@ -1706,7 +1706,7 @@ static int security_preserve_bools(struct policydb *p);
  * This function will flush the access vector cache after
  * loading the new policy.
  */
-int security_load_policy(void *data, size_t len)
+int selinux_load_policy(void *data, size_t len)
 {
 	struct policydb oldpolicydb, newpolicydb;
 	struct sidtab oldsidtab, newsidtab;
@@ -1735,7 +1735,7 @@ int security_load_policy(void *data, size_t len)
 			avtab_cache_destroy();
 			return -EINVAL;
 		}
-		security_load_policycaps();
+		selinux_load_policycaps();
 		policydb_loaded_version = policydb.policyvers;
 		ss_initialized = 1;
 		seqno = ++latest_granting;
@@ -1798,7 +1798,7 @@ int security_load_policy(void *data, size_t len)
 	write_lock_irq(&policy_rwlock);
 	memcpy(&policydb, &newpolicydb, sizeof policydb);
 	sidtab_set(&sidtab, &newsidtab);
-	security_load_policycaps();
+	selinux_load_policycaps();
 	seqno = ++latest_granting;
 	policydb_loaded_version = policydb.policyvers;
 	write_unlock_irq(&policy_rwlock);
@@ -1827,7 +1827,7 @@ err:
  * @port: port number
  * @out_sid: security identifier
  */
-int security_port_sid(u8 protocol, u16 port, u32 *out_sid)
+int selinux_port_sid(u8 protocol, u16 port, u32 *out_sid)
 {
 	struct ocontext *c;
 	int rc = 0;
@@ -1866,7 +1866,7 @@ out:
  * @name: interface name
  * @if_sid: interface SID
  */
-int security_netif_sid(char *name, u32 *if_sid)
+int selinux_netif_sid(char *name, u32 *if_sid)
 {
 	int rc = 0;
 	struct ocontext *c;
@@ -1922,7 +1922,7 @@ static int match_ipv6_addrmask(u32 *input, u32 *addr, u32 *mask)
  * @addrlen: address length in bytes
  * @out_sid: security identifier
  */
-int security_node_sid(u16 domain,
+int selinux_node_sid(u16 domain,
 		      void *addrp,
 		      u32 addrlen,
 		      u32 *out_sid)
@@ -2005,7 +2005,7 @@ out:
  * number of elements in the array.
  */
 
-int security_get_user_sids(u32 fromsid,
+int selinux_get_user_sids(u32 fromsid,
 			   char *username,
 			   u32 **sids,
 			   u32 *nel)
@@ -2117,7 +2117,7 @@ out:
  * cannot support xattr or use a fixed labeling behavior like
  * transition SIDs or task SIDs.
  */
-int security_genfs_sid(const char *fstype,
+int selinux_genfs_sid(const char *fstype,
 		       char *path,
 		       u16 sclass,
 		       u32 *sid)
@@ -2177,7 +2177,7 @@ out:
  * @behavior: labeling behavior
  * @sid: SID for filesystem (superblock)
  */
-int security_fs_use(
+int selinux_fs_use(
 	const char *fstype,
 	unsigned int *behavior,
 	u32 *sid)
@@ -2205,7 +2205,7 @@ int security_fs_use(
 		}
 		*sid = c->sid[0];
 	} else {
-		rc = security_genfs_sid(fstype, "/", SECCLASS_DIR, sid);
+		rc = selinux_genfs_sid(fstype, "/", SECCLASS_DIR, sid);
 		if (rc) {
 			*behavior = SECURITY_FS_USE_NONE;
 			rc = 0;
@@ -2219,7 +2219,7 @@ out:
 	return rc;
 }
 
-int security_get_bools(int *len, char ***names, int **values)
+int selinux_get_bools(int *len, char ***names, int **values)
 {
 	int i, rc = -ENOMEM;
 
@@ -2265,7 +2265,7 @@ err:
 }
 
 
-int security_set_bools(int len, int *values)
+int selinux_set_bools(int len, int *values)
 {
 	int i, rc = 0;
 	int lenp, seqno = 0;
@@ -2314,7 +2314,7 @@ out:
 	return rc;
 }
 
-int security_get_bool_value(int bool)
+int selinux_get_bool_value(int bool)
 {
 	int rc = 0;
 	int len;
@@ -2340,7 +2340,7 @@ static int security_preserve_bools(struct policydb *p)
 	struct cond_bool_datum *booldatum;
 	struct cond_node *cur;
 
-	rc = security_get_bools(&nbools, &bnames, &bvalues);
+	rc = selinux_get_bools(&nbools, &bnames, &bvalues);
 	if (rc)
 		goto out;
 	for (i = 0; i < nbools; i++) {
@@ -2365,10 +2365,10 @@ out:
 }
 
 /*
- * security_sid_mls_copy() - computes a new sid based on the given
+ * selinux_sid_mls_copy() - computes a new sid based on the given
  * sid and the mls portion of mls_sid.
  */
-int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid)
+int selinux_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid)
 {
 	struct context *context1;
 	struct context *context2;
@@ -2452,7 +2452,7 @@ out:
  *   multiple, inconsistent labels |    -<errno>     |    SECSID_NULL
  *
  */
-int security_net_peersid_resolve(u32 nlbl_sid, u32 nlbl_type,
+int selinux_net_peersid_resolve(u32 nlbl_sid, u32 nlbl_type,
 				 u32 xfrm_sid,
 				 u32 *peer_sid)
 {
@@ -2528,7 +2528,7 @@ static int get_classes_callback(void *k, void *d, void *args)
 	return 0;
 }
 
-int security_get_classes(char ***classes, int *nclasses)
+int selinux_get_classes(char ***classes, int *nclasses)
 {
 	int rc = -ENOMEM;
 
@@ -2566,7 +2566,7 @@ static int get_permissions_callback(void *k, void *d, void *args)
 	return 0;
 }
 
-int security_get_permissions(char *class, char ***perms, int *nperms)
+int selinux_get_permissions(char *class, char ***perms, int *nperms)
 {
 	int rc = -ENOMEM, i;
 	struct class_datum *match;
@@ -2610,12 +2610,12 @@ err:
 	return rc;
 }
 
-int security_get_reject_unknown(void)
+int selinux_get_reject_unknown(void)
 {
 	return policydb.reject_unknown;
 }
 
-int security_get_allow_unknown(void)
+int selinux_get_allow_unknown(void)
 {
 	return policydb.allow_unknown;
 }
@@ -2630,7 +2630,7 @@ int security_get_allow_unknown(void)
  * supported, false (0) if it isn't supported.
  *
  */
-int security_policycap_supported(unsigned int req_cap)
+int selinux_policycap_supported(unsigned int req_cap)
 {
 	int rc;
 
@@ -2958,7 +2958,7 @@ static void security_netlbl_cache_add(struct netlbl_lsm_secattr *secattr,
  * failure.
  *
  */
-int security_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
+int selinux_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
 				   u32 *sid)
 {
 	int rc = -EIDRM;
@@ -3029,7 +3029,7 @@ netlbl_secattr_to_sid_return_cleanup:
  * Returns zero on success, negative values on failure.
  *
  */
-int security_netlbl_sid_to_secattr(u32 sid, struct netlbl_lsm_secattr *secattr)
+int selinux_netlbl_sid_to_secattr(u32 sid, struct netlbl_lsm_secattr *secattr)
 {
 	int rc;
 	struct context *ctx;
diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index 72b1845..6bd5ada 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -229,7 +229,7 @@ static int selinux_xfrm_sec_ctx_alloc(struct xfrm_sec_ctx **ctxp,
 	       uctx+1,
 	       str_len);
 	ctx->ctx_str[str_len] = 0;
-	rc = security_context_to_sid(ctx->ctx_str,
+	rc = selinux_context_to_sid(ctx->ctx_str,
 				     str_len,
 				     &ctx->ctx_sid);
 
@@ -248,7 +248,7 @@ static int selinux_xfrm_sec_ctx_alloc(struct xfrm_sec_ctx **ctxp,
 	return rc;
 
 not_from_user:
-	rc = security_sid_to_context(sid, &ctx_str, &str_len);
+	rc = selinux_sid_to_context(sid, &ctx_str, &str_len);
 	if (rc)
 		goto out;
 
-- 
1.6.2.5




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
