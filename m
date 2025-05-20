Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7065C2857F6;
	Tue, 20 May 2025 12:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742496; cv=none; b=euoizckTdYi6k5JkAcaWoHAhx1/J+PAbe7Us7RUe8t2XHpHjB8jNAqPqhtfBQENzjPox5Dnx7W4hNGDH9fkNlD9VDNdvmFE5jKKjWD6bV+XkQQhZyPkXQaAcy9jT2jhu315fcFy0zd276wMb9r4LV32wFE4JcKKr3O/PNmtKKFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742496; c=relaxed/simple;
	bh=g3dG/1PspVIHIDtkH/c93RLoP4ySV8UyvgbXD7k39No=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMmzZkS7BMkLwa3/sF/SSa9CycQG2+zdbox0rLLHqUIcQcph/LeYiRIRmfOaawwGKZFubowrMJ8E+IG/ikQzueMkhutjLsUuF+r6s7FOByKAf4WnS4AWOKdKk7SONfJ9QmprwCyzMJPuwze/U0red5d/bG5yfqHpouA1VH03FRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lthkRC75; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lthkRC75"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso6287721b3a.2;
        Tue, 20 May 2025 05:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742493; x=1748347293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8uEhK5eKQlVMmeJ8s7BLUBIEXaxMqeVPrh3dUbHpx8=;
        b=lthkRC75TH2Yk9vESmSaDrCGEbnWiz8lZ0T0CFps7NQwU22FosX8DX9ul8GQWzU5/A
         mxDSrMlybPMIBkM5oa6rQPZzLc0gGq2By0H121JBflGRSyU9O3I1283WsfLyZFN7vVgj
         2vnUvYUab663QkpKk20rCtaOaI9lmSNkvDJE1LOPa/t1G7RAHi4jYCwoQPXvq9CigmnV
         eQo9gm8TgpMVKp1ZO3966MKtTh0yFU14+euMPq/1Y+gQ45udCVp30Kx3Gk6A/fw2vwKA
         h1bouX/B6oySTCtTgfE8m0GSvhIH+walGyxKiCSsljIWIKMC4wjKnl7T71Ynez/XDAad
         yKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742493; x=1748347293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8uEhK5eKQlVMmeJ8s7BLUBIEXaxMqeVPrh3dUbHpx8=;
        b=aocHnOzxM3NOsMpCxX+XytOzUtA/A2YIEPplglBkilqevpxa69Z298UnoZDCXrZJ2r
         QCbqMceAQi1/DyXe2TTFmjzrYra7jNAZGsYECaSfIjJQKrFmVLgRje7vvK+vpyZUe7dA
         JE9jaU0W8gAVL+frX5uGA2dnUkP5FI4XH6RYZcYA3WjX4VVioCOY2jH0dNteDTkTZEA5
         SVTUBoS/l7555ZN6ERGa3Xg+1J8jRT/n0W4yKprTYGblro0GH580g6nQijPr6C9kfZLp
         c/V8CSCgMVdcygIod1MbkewNPBrQAz9dHbrxTgxv6vnSALeiOjGLj0g0DxY1bRazVR1y
         qKOA==
X-Forwarded-Encrypted: i=1; AJvYcCW23qCUlg/EpgKx6QWVsq+CeSfmfGFbkVqE6uW0oBRxUxsY+mTURjmJ1f6AnSiC0hXnVYqNEN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrxI2OKC0L0SQhxQp0puZ1eD/sdyuR33U/qgCDuVLLE0ap/gYE
	gb9ir0AdTMBe/6ENTjBvtze/jQlp5aVbqoYdZ0j0rfaFrEMrjDhIF0NzaqD39A==
X-Gm-Gg: ASbGnctR87pYYVIJ6w/P+QYL+fGyWlGz9wpsAVxs+1UcQGQdonGxaHx3VNYUKV7X0Ct
	5tsRaNKPma1nx5p3A2t/ffg7xPF4v3jUYf+q1vZZtgQfEpD0gAdFEz9LyeL4TWmiEmoJ1WG3RMZ
	3scvKvYuqgZdyRdO+A0WawXwpAu5fPjGn3zy5XMUf5BvafoiCUThK/t/zxi6GWXvzVntro8JRit
	aGquyHOPwTakZ/nSxTb8j3SGupp/O9chE+07SxjkHnKE8u/+9i9ynOFbWnhDzM1FReq4+MIgYPm
	Gsq25RTW6xYERdrLdVbihkn5PhVDnllalVyoz0bH5UTlGHcMZTJg0UIZNfrxi0X54tzHpf1wTD7
	1ETGdCcdkPrlgnQaSPDcrALVJkD999K8A7cTir0QUAJAnyjAveB5fw5G668dD1rer
X-Google-Smtp-Source: AGHT+IGmPB5NJ5yMPgz6nu1p53CMPh5ethPiOz9s/8Jk2eTV/szB6htOYJ0CU8wX2r4tSVNGI636uQ==
X-Received: by 2002:a05:620a:4441:b0:7c7:97ff:ca42 with SMTP id af79cd13be357-7cd46780414mr2296422885a.41.1747742482405;
        Tue, 20 May 2025 05:01:22 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:01:21 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 18/42] selinux: eliminate global SID table if !CONFIG_SECURITY_SELINUX_NS
Date: Tue, 20 May 2025 07:59:16 -0400
Message-ID: <20250520120000.25501-20-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
References: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
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
index fed55b183480..764023bb0340 100644
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

