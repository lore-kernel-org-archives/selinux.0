Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D0A248F5F;
	Tue, 10 Jun 2025 17:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576200; cv=none; b=ss8Uf/fbq82uqgOkzGSySofCxoeEnCtb7glftUbaOt17LsM2KI0nG2h76c2QCNrbtMLkJdcakhCfepPFQB8wxxOyt4vZMrADPeCm5rzmCl0kKwv4YO1dMJHgKsc9TOEEs3Ge4wXUmBAWMYVp70k/Y4d7x0VluMxzIElkNEynhNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576200; c=relaxed/simple;
	bh=LnlMFaqj67dZi3xtkNO5hk6J6aMMHZWKOiw1ZY1xfvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAErmOn88RGhf0Khe1fRhCr58WU7y693O0eMlWYQh8VZanhsZeztZrsb6qL5M+DhLMP4iNK/DuDZDzDh0lIoQCTbSJgw8pnVH4n76yrgPHJ/ltvWPcVWFbYpqx7996tFL2nWndN3eyn/r+revwNGagY1MfBri7gEIQOfHnsp4SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDLlAt9/; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDLlAt9/"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7d20451c016so309480385a.1;
        Tue, 10 Jun 2025 10:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576197; x=1750180997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEiI1N/u8blT3B5QSlVjcgSZiBtln3u63yEm8iNWD7g=;
        b=jDLlAt9/uGYZlNeUT+hgVIujWmsnNmKXQ25t6JICq8YTzEMM08y8xnfl6MRve3KzzU
         jZHU8PWRsNf2VIMh3QEbBquSCALVmbqOyZIyhdasAge+I5fU0Us/vrkcbt+Im9JImavV
         ZYG1yl8X4j2qu9dIQPNCEhHVb7VQh/GXTl8IznqzOd0aGFMBn2ir0t7x7SieZQIsK/VP
         wWZwyzkaskfUuqnDm2j2v5gGsxJfa0+VRB+6MS6M6VDWJWMhErk2rPSdAafFfjjgAsHb
         NS1sYkKEG6vfWFrFqzRelKWT4wzr5UhtmhVQ8ydGlCREdmrB8eFqgNDhxO/usk5o96IL
         oqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576197; x=1750180997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fEiI1N/u8blT3B5QSlVjcgSZiBtln3u63yEm8iNWD7g=;
        b=wnSZTh5oTs5D8QfhfYLzAV5MbCZHK//Hfqn9yauyFc06UtepQSUlttn1Eicn+0et05
         FWHVLNpLU241vAsMxXWiaAeXlx9A+id5MmypgHAHViaUl2D6QmvoqYvny4j4HEFB71vN
         f3CoI2mtDonZOQ2zagAc4EU855Yt9ipK20NgXrIqtK7FhEsxTTllswktitjwMMpL3qTh
         hvD3nehWFdV6hJ7S52DbkzY+TaSsVHh2opaO2cqMsDY8BNfObkb6aj0HsyzUvmkZ9/9P
         61v17g01sXqmENzxl8bo6s36uAGEg59s0O8aKdIobEoiNz+BIu9Hb+tzdUExvy4hy73H
         1nNw==
X-Forwarded-Encrypted: i=1; AJvYcCXEKvZa4YqMibtEBZjYmqOVvYhtEtvfnIkq/2+nx1mOZaNMTmuCo03k4mURy6k7yDmMpyumUrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+HaiSr1dX8UKJ+5mMqQ2l24BK0YB4L7uzntLBK2fid7VISqNQ
	qbUrzddibjSn251hv16AbHDr6ELF1VGH5ohZWfNt8Prg8T1aof/w6bn/s66paw==
X-Gm-Gg: ASbGncupkYCUj2JvSvocoMrWqjNi4bLmOJlOPIkz+NxWrz92dnqAcfhQzThn+BKWs4q
	qAqqszQ+0usqvnPoEe2Lwqmxcx69uOYRle/M12HX16Ho9dLhTlnajMTpc6nQlJSg37zwWDEPZlQ
	lr/Ye53a97PU+NaQgL2ovrZwcNdDvYuXDJVTzNroSioFGgiEytCgYeDNM+yo/xHp/uOU2xZA7fA
	F7Q5vUzd3lrzhWCLV2NFqr4drGvzxo0A18/2GrqVNcu80mYTWS2sUMGltZSEXg4nhGKClDE9WyI
	GTmSAR4Gv+dpbay+kqQP5Xi9HkJJNokjy4HkkDJI+4kCa3F85dRcg41gq2XpzZvyhBhsQMA3aPE
	7FStyJ7XdQzKZFQQN/gyqs60+Sb44N4GcTklIqGcZ07TUWVe6uMvvyJghE5bIxOQ5ng==
X-Google-Smtp-Source: AGHT+IE0a09djOTuykIeJlW8N81OvJFlaz7ghXBsk/AlzetRN9PBglb2hU569Rnof2rj00RwQTfpzA==
X-Received: by 2002:a05:620a:3186:b0:7c5:65ab:5001 with SMTP id af79cd13be357-7d3a88da10emr29358485a.39.1749576196743;
        Tue, 10 Jun 2025 10:23:16 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a608d19sm716491185a.63.2025.06.10.10.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:23:16 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 19/42] selinux: eliminate global SID table if !CONFIG_SECURITY_SELINUX_NS
Date: Tue, 10 Jun 2025 13:21:50 -0400
Message-ID: <20250610172226.1470741-20-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
References: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Completely eliminate the global SID table and its wrapper functions
when CONFIG_SECURITY_SELINUX_NS=n to avoid imposing overhead on
systems that do not enable SELinux namespaces.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/Makefile                |   3 +-
 security/selinux/include/audit.h         |   8 +
 security/selinux/include/global_sidtab.h |   7 +
 security/selinux/include/security.h      | 213 ++++++++++++++++++++++-
 security/selinux/include/sidtab.h        |   4 +
 security/selinux/ss/sidtab.c             |   8 +
 6 files changed, 241 insertions(+), 2 deletions(-)

diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index fe5f6f4bb0ea..e6b9628ab800 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -15,7 +15,7 @@ ccflags-y := -I$(srctree)/security/selinux -I$(srctree)/security/selinux/include
 ccflags-$(CONFIG_SECURITY_SELINUX_DEBUG) += -DDEBUG
 
 selinux-y := avc.o hooks.o selinuxfs.o netlink.o nlmsgtab.o netif.o \
-	     netnode.o netport.o status.o global_sidtab.o \
+	     netnode.o netport.o status.o \
 	     ss/ebitmap.o ss/hashtab.o ss/symtab.o ss/sidtab.o ss/avtab.o \
 	     ss/policydb.o ss/services.o ss/conditional.o ss/mls.o ss/context.o
 
@@ -23,6 +23,7 @@ selinux-$(CONFIG_SECURITY_NETWORK_XFRM) += xfrm.o
 selinux-$(CONFIG_NETLABEL) += netlabel.o
 selinux-$(CONFIG_SECURITY_INFINIBAND) += ibpkey.o
 selinux-$(CONFIG_IMA) += ima.o
+selinux-$(CONFIG_SECURITY_SELINUX_NS) += global_sidtab.o
 
 genhdrs := flask.h av_permissions.h
 
diff --git a/security/selinux/include/audit.h b/security/selinux/include/audit.h
index d5b0425055e4..9dbddc6262c3 100644
--- a/security/selinux/include/audit.h
+++ b/security/selinux/include/audit.h
@@ -49,8 +49,16 @@ void selinux_audit_rule_free(void *rule);
  * Returns 1 if the context id matches the rule, 0 if it does not, and
  * -errno on failure.
  */
+#ifdef CONFIG_SECURITY_SELINUX_NS
 int selinux_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op,
 			     void *rule);
+#else
+static inline int selinux_audit_rule_match(struct lsm_prop *prop, u32 field,
+					   u32 op, void *rule)
+{
+	return selinux_ss_audit_rule_match(prop, field, op, rule);
+}
+#endif
 
 /**
  * selinux_audit_rule_known - check to see if rule contains selinux fields.
diff --git a/security/selinux/include/global_sidtab.h b/security/selinux/include/global_sidtab.h
index a47cebecc944..2e06bb865326 100644
--- a/security/selinux/include/global_sidtab.h
+++ b/security/selinux/include/global_sidtab.h
@@ -7,6 +7,13 @@
 #ifndef _GLOBAL_SIDTAB_H_
 #define _GLOBAL_SIDTAB_H_
 
+#ifdef CONFIG_SECURITY_SELINUX_NS
 extern int global_sidtab_init(void);
+#else
+static inline int global_sidtab_init(void)
+{
+	return 0;
+}
+#endif /* CONFIG_SECURITY_SELINUX_NS */
 
 #endif /* _GLOBAL_SIDTAB_H_ */
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 4851f2d4ab9a..572d9ea9cef6 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -348,6 +348,8 @@ struct extended_perms {
 /* definitions of av_decision.flags */
 #define AVD_FLAGS_PERMISSIVE 0x0001
 
+#ifdef CONFIG_SECURITY_SELINUX_NS
+
 void security_compute_av(struct selinux_state *state, u32 ssid, u32 tsid,
 			 u16 tclass, struct av_decision *avd,
 			 struct extended_perms *xperms);
@@ -413,6 +415,160 @@ int security_sid_mls_copy(struct selinux_state *state, u32 sid, u32 mls_sid,
 int security_net_peersid_resolve(struct selinux_state *state, u32 nlbl_sid,
 				 u32 nlbl_type, u32 xfrm_sid, u32 *peer_sid);
 
+#else
+
+#include "selinux_ss.h"
+
+static inline void security_compute_av(struct selinux_state *state, u32 ssid,
+				       u32 tsid, u16 tclass,
+				       struct av_decision *avd,
+				       struct extended_perms *xperms)
+{
+	selinux_ss_compute_av(state, ssid, tsid, tclass, avd, xperms);
+}
+
+static inline void
+security_compute_xperms_decision(struct selinux_state *state, u32 ssid,
+				 u32 tsid, u16 tclass, u8 driver, u8 base_perm,
+				 struct extended_perms_decision *xpermd)
+{
+	selinux_ss_compute_xperms_decision(state, ssid, tsid, tclass, driver,
+					   base_perm, xpermd);
+}
+
+static inline int security_transition_sid(struct selinux_state *state, u32 ssid,
+					  u32 tsid, u16 tclass,
+					  const struct qstr *qstr, u32 *out_sid)
+{
+	return selinux_ss_transition_sid(state, ssid, tsid, tclass, qstr,
+					 out_sid);
+}
+
+static inline int security_sid_to_context(struct selinux_state *state, u32 sid,
+					  char **scontext, u32 *scontext_len)
+{
+	return selinux_ss_sid_to_context(state, sid, scontext, scontext_len);
+}
+
+static inline int security_sid_to_context_valid(struct selinux_state *state,
+						u32 sid, char **scontext,
+						u32 *scontext_len)
+{
+	return selinux_ss_sid_to_context(state, sid, scontext, scontext_len);
+}
+
+static inline int security_sid_to_context_force(struct selinux_state *state,
+						u32 sid, char **scontext,
+						u32 *scontext_len)
+{
+	return selinux_ss_sid_to_context_force(state, sid, scontext,
+					       scontext_len);
+}
+
+static inline int security_sid_to_context_inval(struct selinux_state *state,
+						u32 sid, char **scontext,
+						u32 *scontext_len)
+{
+	return selinux_ss_sid_to_context_inval(state, sid, scontext,
+					       scontext_len);
+}
+
+static inline int security_context_to_sid(struct selinux_state *state,
+					  const char *scontext,
+					  u32 scontext_len, u32 *out_sid,
+					  gfp_t gfp)
+{
+	return selinux_ss_context_to_sid(state, scontext, scontext_len, out_sid,
+					 gfp);
+}
+
+static inline int security_context_str_to_sid(struct selinux_state *state,
+					      const char *scontext,
+					      u32 *out_sid, gfp_t gfp)
+{
+	return selinux_ss_context_str_to_sid(state, scontext, out_sid, gfp);
+}
+
+static inline int security_context_to_sid_default(struct selinux_state *state,
+						  const char *scontext,
+						  u32 scontext_len,
+						  u32 *out_sid, u32 def_sid,
+						  gfp_t gfp_flags)
+{
+	return selinux_ss_context_to_sid_default(state, scontext, scontext_len,
+						 out_sid, def_sid, gfp_flags);
+}
+
+static inline int security_context_to_sid_force(struct selinux_state *state,
+						const char *scontext,
+						u32 scontext_len, u32 *sid)
+{
+	return selinux_ss_context_to_sid_force(state, scontext, scontext_len,
+					       sid, GFP_KERNEL);
+}
+
+static inline int security_port_sid(struct selinux_state *state, u8 protocol,
+				    u16 port, u32 *out_sid)
+{
+	return selinux_ss_port_sid(state, protocol, port, out_sid);
+}
+
+static inline int security_ib_pkey_sid(struct selinux_state *state,
+				       u64 subnet_prefix, u16 pkey_num,
+				       u32 *out_sid)
+{
+	return selinux_ss_ib_pkey_sid(state, subnet_prefix, pkey_num, out_sid);
+}
+
+static inline int security_ib_endport_sid(struct selinux_state *state,
+					  const char *dev_name, u8 port_num,
+					  u32 *out_sid)
+{
+	return selinux_ss_ib_endport_sid(state, dev_name, port_num, out_sid);
+}
+
+static inline int security_netif_sid(struct selinux_state *state,
+				     const char *name, u32 *if_sid)
+{
+	return selinux_ss_netif_sid(state, name, if_sid);
+}
+
+static inline int security_node_sid(struct selinux_state *state, u16 domain,
+				    const void *addr, u32 addrlen, u32 *out_sid)
+{
+	return selinux_ss_node_sid(state, domain, addr, addrlen, out_sid);
+}
+
+static inline int security_validate_transition(struct selinux_state *state,
+					       u32 oldsid, u32 newsid,
+					       u32 tasksid, u16 tclass)
+{
+	return selinux_ss_validate_transition(state, oldsid, newsid, tasksid,
+					      tclass);
+}
+
+static inline int security_bounded_transition(struct selinux_state *state,
+					      u32 old_sid, u32 new_sid)
+{
+	return selinux_ss_bounded_transition(state, old_sid, new_sid);
+}
+
+static inline int security_sid_mls_copy(struct selinux_state *state, u32 sid,
+					u32 mls_sid, u32 *new_sid)
+{
+	return selinux_ss_sid_mls_copy(state, sid, mls_sid, new_sid);
+}
+
+static inline int security_net_peersid_resolve(struct selinux_state *state,
+					       u32 nlbl_sid, u32 nlbl_type,
+					       u32 xfrm_sid, u32 *peer_sid)
+{
+	return selinux_ss_net_peersid_resolve(state, nlbl_sid, nlbl_type,
+					      xfrm_sid, peer_sid);
+}
+
+#endif /* CONFIG_SECURITY_SELINUX_NS */
+
 int security_get_classes(struct selinux_policy *policy, char ***classes,
 			 u32 *nclasses);
 int security_get_permissions(struct selinux_policy *policy, const char *class,
@@ -429,6 +585,7 @@ int security_get_allow_unknown(struct selinux_state *state);
 #define SECURITY_FS_USE_NATIVE	 7 /* use native label support */
 #define SECURITY_FS_USE_MAX	 7 /* Highest SECURITY_FS_USE_XXX */
 
+#ifdef CONFIG_SECURITY_SELINUX_NS
 int security_fs_use(struct selinux_state *state, const char *fstype,
 		    unsigned short *behavior, u32 *sid);
 
@@ -437,15 +594,69 @@ int security_genfs_sid(struct selinux_state *state, const char *fstype,
 
 int selinux_policy_genfs_sid(struct selinux_policy *policy, const char *fstype,
 			     const char *path, u16 sclass, u32 *sid);
+#else
+static inline int security_fs_use(struct selinux_state *state,
+				  const char *fstype, unsigned short *behavior,
+				  u32 *sid)
+{
+	return selinux_ss_fs_use(state, fstype, behavior, sid);
+}
+
+static inline int security_genfs_sid(struct selinux_state *state,
+				     const char *fstype, const char *path,
+				     u16 sclass, u32 *sid)
+{
+	return selinux_ss_genfs_sid(state, fstype, path, sclass, sid);
+}
+
+static inline int selinux_policy_genfs_sid(struct selinux_policy *policy,
+					   const char *fstype, const char *path,
+					   u16 sclass, u32 *sid)
+{
+	return selinux_ss_policy_genfs_sid(policy, fstype, path, sclass, sid);
+}
+#endif
 
 #ifdef CONFIG_NETLABEL
+#ifdef CONFIG_SECURITY_SELINUX_NS
 int security_netlbl_secattr_to_sid(struct selinux_state *state,
 				   struct netlbl_lsm_secattr *secattr,
 				   u32 *sid);
 
 int security_netlbl_sid_to_secattr(struct selinux_state *state, u32 sid,
 				   struct netlbl_lsm_secattr *secattr);
-#else
+#else /* CONFIG_SECURITY_SELINUX_NS */
+#include <net/netlabel.h>
+
+static inline int
+security_netlbl_secattr_to_sid(struct selinux_state *state,
+			       struct netlbl_lsm_secattr *secattr, u32 *sid)
+{
+	if (secattr->flags & NETLBL_SECATTR_SECID) {
+		*sid = secattr->attr.secid;
+		return 0;
+	}
+
+	return selinux_ss_netlbl_secattr_to_sid(state, secattr, sid);
+}
+
+static inline int
+security_netlbl_sid_to_secattr(struct selinux_state *state, u32 sid,
+			       struct netlbl_lsm_secattr *secattr)
+{
+	int rc;
+
+	rc = selinux_ss_netlbl_sid_to_secattr(state, sid, secattr);
+	if (rc)
+		return rc;
+
+	secattr->attr.secid = sid;
+	secattr->flags |= NETLBL_SECATTR_SECID;
+	return 0;
+}
+
+#endif /* CONFIG_SECURITY_SELINUX_NS */
+#else /* CONFIG_NETLABEL */
 static inline int
 security_netlbl_secattr_to_sid(struct selinux_state *state,
 			       struct netlbl_lsm_secattr *secattr, u32 *sid)
diff --git a/security/selinux/include/sidtab.h b/security/selinux/include/sidtab.h
index 1d40e1a7fa42..61389c588775 100644
--- a/security/selinux/include/sidtab.h
+++ b/security/selinux/include/sidtab.h
@@ -26,8 +26,10 @@ struct sidtab_entry {
 	struct sidtab_str_cache __rcu *cache;
 #endif
 	struct hlist_node list;
+#ifdef CONFIG_SECURITY_SELINUX_NS
 	u32 ss_sid; // global SID table only
 	struct selinux_state *state; // global SID table only
+#endif
 };
 
 union sidtab_entry_inner {
@@ -136,8 +138,10 @@ void sidtab_freeze_end(struct sidtab *s, unsigned long *flags)
 
 int sidtab_context_to_sid(struct sidtab *s, struct context *context, u32 *sid);
 
+#ifdef CONFIG_SECURITY_SELINUX_NS
 int sidtab_context_ss_to_sid(struct sidtab *s, struct context *context,
 			     struct selinux_state *state, u32 ss_sid, u32 *sid);
+#endif
 
 void sidtab_destroy(struct sidtab *s);
 
diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index da8d19ce5866..19991f01cd20 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -265,8 +265,12 @@ struct sidtab_entry *sidtab_search_entry_force(struct sidtab *s, u32 sid)
 	return sidtab_search_core(s, sid, 1);
 }
 
+#ifdef CONFIG_SECURITY_SELINUX_NS
 int sidtab_context_ss_to_sid(struct sidtab *s, struct context *context,
 			     struct selinux_state *state, u32 ss_sid, u32 *sid)
+#else
+int sidtab_context_to_sid(struct sidtab *s, struct context *context, u32 *sid)
+#endif
 {
 	unsigned long flags;
 	u32 count, hash = context_compute_hash(context);
@@ -309,8 +313,10 @@ int sidtab_context_ss_to_sid(struct sidtab *s, struct context *context,
 		goto out_unlock;
 
 	dst->sid = index_to_sid(count);
+#ifdef CONFIG_SECURITY_SELINUX_NS
 	dst->state = state;
 	dst->ss_sid = ss_sid;
+#endif
 	dst->hash = hash;
 
 	rc = context_cpy(&dst->context, context);
@@ -359,10 +365,12 @@ int sidtab_context_ss_to_sid(struct sidtab *s, struct context *context,
 	return rc;
 }
 
+#ifdef CONFIG_SECURITY_SELINUX_NS
 int sidtab_context_to_sid(struct sidtab *s, struct context *context, u32 *sid)
 {
 	return sidtab_context_ss_to_sid(s, context, NULL, 0, sid);
 }
+#endif
 
 static void sidtab_convert_hashtable(struct sidtab *s, u32 count)
 {
-- 
2.49.0

