Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA5B457E61
	for <selinux@vger.kernel.org>; Tue,  6 Oct 2026 13:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291870; cv=none; b=BNzBRzXznApdO+WITvyz3VwG7ijUk67FpESBS71QE2jONtrXpn0EXqxNUn6MQbDx0IJQt+9NrkLf5Z0I31LRu2j2TpV6x1A8ggf704N/jvpFk1dxcoSjye3aJRcBOK0+/H1dflIN5Ba1d5l1AmzKCde3iTJdnz+nufDYXSbNhfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291870; c=relaxed/simple;
	bh=JNIU83Wg1LSvyxcj8QIunZw1Tu6nFzWO+1p6N0xwVSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BsjAo+5wgLejOB9zhrxB40I30wayNkoi0Mhb8iHZ53G8CT1LIr7Ay5uzTz/mH7bCyJdCcPZx5GIDXESZ8mDTgLGpAmmdgnDTKRnkzIRGvKpsa77A+ojQQgS8e3ZV1YyS3I+3FJKFX6D5oiBS54FUNdJ0+qzsMiFCRx8q1Wnq464=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=guYtkknS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="guYtkknS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791291866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ATwCu0WlLdZKpj1mOA94CtTFG+Wfv5XyXMi6J/5FSc=;
	b=guYtkknS2svTBoJ8bPwimo0tKM3oT0BsHsg9m1qB5G+clIuDOXZDiJoAB7vbVVBTTDJ+ko
	zcpesPC2lhD7/A0Ub3AhioosY035UBZmy/MqdU+rO80ywQEsNsfjtvMlSy1BuXBY7OSvoV
	loAfS4CLlc1sm614vBJx/E3ifyQC9v4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-NiK7b3DjOSuswUT4IK7Jnw-1; Tue,
 06 Oct 2026 09:04:23 -0400
X-MC-Unique: NiK7b3DjOSuswUT4IK7Jnw-1
X-Mimecast-MFC-AGG-ID: NiK7b3DjOSuswUT4IK7Jnw_1791291862
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 753BD19361BB;
	Tue,  6 Oct 2026 13:04:22 +0000 (UTC)
Received: from jjanasek-thinkpadt14gen5.tpbc.com (unknown [10.44.48.38])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 254FA1956047;
	Tue,  6 Oct 2026 13:04:20 +0000 (UTC)
From: jan janasek <jjanasek@redhat.com>
To: selinux@vger.kernel.org
Cc: jan janasek <jjanasek@redhat.com>,
	Juraj Marcin <juraj@jurajmarcin.com>
Subject: [RFC PATCH userspace 09/17] libsepol: add policy properties API and public constants
Date: Tue,  6 Oct 2026 15:02:07 +0200
Message-ID: <20261006130215.128405-10-jjanasek@redhat.com>
In-Reply-To: <20261006130215.128405-1-jjanasek@redhat.com>
References: <20261006130215.128405-1-jjanasek@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add sepol/constants.h re-exporting AVTAB_*, OCON_*,
SECURITY_FS_USE_*, and related policydb constants under an SEPOL_
namespace (with unprefixed aliases guarded to avoid redefinition
conflicts for callers that also include internal headers), so
consumers no longer need policydb/avtab.h or policydb/services.h just
for these values.

Add opaque-policydb properties: sepol_policydb_mls_enabled(),
sepol_policydb_compat_net(), sepol_policydb_set_permissive_flags(),
and sepol_policydb_rebuild_attr_map() for maintaining the type
attribute map after modifying type/attribute membership.

Co-developed-by: Juraj Marcin <juraj@jurajmarcin.com>
Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
Assisted-by: LLM Cursor
Signed-off-by: Jan Janasek <jjanasek@redhat.com>
---
 libsepol/include/sepol/constants.h         | 231 +++++++++++++++++++++
 libsepol/include/sepol/policydb.h          |  29 +++
 libsepol/include/sepol/policydb/avtab.h    |  33 +--
 libsepol/include/sepol/policydb/policydb.h |  68 +-----
 libsepol/include/sepol/policydb/services.h |  19 +-
 libsepol/src/policydb_public.c             | 203 ++++++++++++++++++
 6 files changed, 486 insertions(+), 97 deletions(-)
 create mode 100644 libsepol/include/sepol/constants.h

diff --git a/libsepol/include/sepol/constants.h b/libsepol/include/sepol/constants.h
new file mode 100644
index 00000000..69d29537
--- /dev/null
+++ b/libsepol/include/sepol/constants.h
@@ -0,0 +1,231 @@
+#ifndef _SEPOL_CONSTANTS_H_
+#define _SEPOL_CONSTANTS_H_
+
+/*
+ * Policy interpretation constants shared across libsepol and consumers
+ * (e.g. SETools) that need stable numeric tokens without pulling in full
+ * policydb, avtab, or service API headers.
+ *
+ * Values match the kernel / policy binary format and must stay in sync
+ * with libsepol's internal policy representation.
+ *
+ * Public API consumers should prefer the SEPOL_-prefixed aliases below.
+ * The unprefixed forms are provided for source compatibility with code
+ * that also includes internal policydb headers; #ifndef guards prevent
+ * redefinition conflicts.
+ */
+
+#include <stdint.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/* --- Namespace-safe constants for public API consumers --- */
+
+#define SEPOL_AVTAB_ALLOWED 0x0001
+#define SEPOL_AVTAB_AUDITALLOW 0x0002
+#define SEPOL_AVTAB_AUDITDENY 0x0004
+#define SEPOL_AVTAB_NEVERALLOW 0x0080
+#define SEPOL_AVTAB_AV \
+	(SEPOL_AVTAB_ALLOWED | SEPOL_AVTAB_AUDITALLOW | SEPOL_AVTAB_AUDITDENY)
+#define SEPOL_AVTAB_TRANSITION 0x0010
+#define SEPOL_AVTAB_MEMBER 0x0020
+#define SEPOL_AVTAB_CHANGE 0x0040
+#define SEPOL_AVTAB_TYPE \
+	(SEPOL_AVTAB_TRANSITION | SEPOL_AVTAB_MEMBER | SEPOL_AVTAB_CHANGE)
+#define SEPOL_AVTAB_XPERMS_ALLOWED 0x0100
+#define SEPOL_AVTAB_XPERMS_AUDITALLOW 0x0200
+#define SEPOL_AVTAB_XPERMS_DONTAUDIT 0x0400
+#define SEPOL_AVTAB_XPERMS_NEVERALLOW 0x0800
+#define SEPOL_AVTAB_XPERMS                                            \
+	(SEPOL_AVTAB_XPERMS_ALLOWED | SEPOL_AVTAB_XPERMS_AUDITALLOW | \
+	 SEPOL_AVTAB_XPERMS_DONTAUDIT)
+#define SEPOL_AVTAB_ENABLED_OLD 0x80000000
+#define SEPOL_AVTAB_ENABLED 0x8000
+
+#define SEPOL_AVTAB_XPERMS_IOCTLFUNCTION 0x01
+#define SEPOL_AVTAB_XPERMS_IOCTLDRIVER 0x02
+#define SEPOL_AVTAB_XPERMS_NLMSG 0x03
+
+#define SEPOL_AVRULE_ALLOWED SEPOL_AVTAB_ALLOWED
+#define SEPOL_AVRULE_AUDITALLOW SEPOL_AVTAB_AUDITALLOW
+#define SEPOL_AVRULE_AUDITDENY SEPOL_AVTAB_AUDITDENY
+#define SEPOL_AVRULE_DONTAUDIT 0x0008
+#define SEPOL_AVRULE_NEVERALLOW SEPOL_AVTAB_NEVERALLOW
+#define SEPOL_AVRULE_AV                                    \
+	(SEPOL_AVRULE_ALLOWED | SEPOL_AVRULE_AUDITALLOW |  \
+	 SEPOL_AVRULE_AUDITDENY | SEPOL_AVRULE_DONTAUDIT | \
+	 SEPOL_AVRULE_NEVERALLOW)
+#define SEPOL_AVRULE_TRANSITION SEPOL_AVTAB_TRANSITION
+#define SEPOL_AVRULE_MEMBER SEPOL_AVTAB_MEMBER
+#define SEPOL_AVRULE_CHANGE SEPOL_AVTAB_CHANGE
+#define SEPOL_AVRULE_TYPE \
+	(SEPOL_AVRULE_TRANSITION | SEPOL_AVRULE_MEMBER | SEPOL_AVRULE_CHANGE)
+#define SEPOL_AVRULE_XPERMS_ALLOWED SEPOL_AVTAB_XPERMS_ALLOWED
+#define SEPOL_AVRULE_XPERMS_AUDITALLOW SEPOL_AVTAB_XPERMS_AUDITALLOW
+#define SEPOL_AVRULE_XPERMS_DONTAUDIT SEPOL_AVTAB_XPERMS_DONTAUDIT
+#define SEPOL_AVRULE_XPERMS_NEVERALLOW SEPOL_AVTAB_XPERMS_NEVERALLOW
+#define SEPOL_AVRULE_XPERMS                                             \
+	(SEPOL_AVRULE_XPERMS_ALLOWED | SEPOL_AVRULE_XPERMS_AUDITALLOW | \
+	 SEPOL_AVRULE_XPERMS_DONTAUDIT | SEPOL_AVRULE_XPERMS_NEVERALLOW)
+#define SEPOL_AVRULE_XPERMS_IOCTLFUNCTION SEPOL_AVTAB_XPERMS_IOCTLFUNCTION
+#define SEPOL_AVRULE_XPERMS_IOCTLDRIVER SEPOL_AVTAB_XPERMS_IOCTLDRIVER
+#define SEPOL_AVRULE_XPERMS_NLMSG SEPOL_AVTAB_XPERMS_NLMSG
+
+#define SEPOL_RULE_SELF (1U << 0)
+#define SEPOL_RULE_NOTSELF (1U << 1)
+
+#define SEPOL_SECURITY_FS_USE_XATTR 1
+#define SEPOL_SECURITY_FS_USE_TRANS 2
+#define SEPOL_SECURITY_FS_USE_TASK 3
+#define SEPOL_SECURITY_FS_USE_GENFS 4
+#define SEPOL_SECURITY_FS_USE_NONE 5
+
+#define SEPOL_SYM_COMMONS 0
+#define SEPOL_SYM_CLASSES 1
+#define SEPOL_SYM_ROLES 2
+#define SEPOL_SYM_TYPES 3
+#define SEPOL_SYM_USERS 4
+#define SEPOL_SYM_BOOLS 5
+#define SEPOL_SYM_LEVELS 6
+#define SEPOL_SYM_CATS 7
+#define SEPOL_SYM_NUM 8
+
+#define SEPOL_OCON_ISID 0
+#define SEPOL_OCON_FS 1
+#define SEPOL_OCON_PORT 2
+#define SEPOL_OCON_NETIF 3
+#define SEPOL_OCON_NODE 4
+#define SEPOL_OCON_FSUSE 5
+#define SEPOL_OCON_NODE6 6
+#define SEPOL_OCON_IBPKEY 7
+#define SEPOL_OCON_IBENDPORT 8
+#define SEPOL_OCON_XEN_ISID 0
+#define SEPOL_OCON_XEN_PIRQ 1
+#define SEPOL_OCON_XEN_IOPORT 2
+#define SEPOL_OCON_XEN_IOMEM 3
+#define SEPOL_OCON_XEN_PCIDEVICE 4
+#define SEPOL_OCON_XEN_DEVICETREE 5
+#define SEPOL_OCON_NUM 9
+
+#define SEPOL_EXTENDED_PERMS_LEN 8
+#define SEPOL_MAX_AVTAB_HASH_BITS 20
+#define SEPOL_MAX_AVTAB_HASH_BUCKETS (1 << SEPOL_MAX_AVTAB_HASH_BITS)
+#define SEPOL_MAX_AVTAB_SIZE (SEPOL_MAX_AVTAB_HASH_BUCKETS << 1)
+
+/*
+ * Unprefixed forms for backward compatibility with code that mixes
+ * public and internal headers.  Guarded to avoid redefinition warnings
+ * when policydb/avtab.h or similar internal headers are also included.
+ */
+
+#ifndef AVTAB_ALLOWED
+#define AVTAB_ALLOWED SEPOL_AVTAB_ALLOWED
+#define AVTAB_AUDITALLOW SEPOL_AVTAB_AUDITALLOW
+#define AVTAB_AUDITDENY SEPOL_AVTAB_AUDITDENY
+#define AVTAB_NEVERALLOW SEPOL_AVTAB_NEVERALLOW
+#define AVTAB_AV SEPOL_AVTAB_AV
+#define AVTAB_TRANSITION SEPOL_AVTAB_TRANSITION
+#define AVTAB_MEMBER SEPOL_AVTAB_MEMBER
+#define AVTAB_CHANGE SEPOL_AVTAB_CHANGE
+#define AVTAB_TYPE SEPOL_AVTAB_TYPE
+#define AVTAB_XPERMS_ALLOWED SEPOL_AVTAB_XPERMS_ALLOWED
+#define AVTAB_XPERMS_AUDITALLOW SEPOL_AVTAB_XPERMS_AUDITALLOW
+#define AVTAB_XPERMS_DONTAUDIT SEPOL_AVTAB_XPERMS_DONTAUDIT
+#define AVTAB_XPERMS_NEVERALLOW SEPOL_AVTAB_XPERMS_NEVERALLOW
+#define AVTAB_XPERMS SEPOL_AVTAB_XPERMS
+#define AVTAB_ENABLED_OLD SEPOL_AVTAB_ENABLED_OLD
+#define AVTAB_ENABLED SEPOL_AVTAB_ENABLED
+#define AVTAB_XPERMS_IOCTLFUNCTION SEPOL_AVTAB_XPERMS_IOCTLFUNCTION
+#define AVTAB_XPERMS_IOCTLDRIVER SEPOL_AVTAB_XPERMS_IOCTLDRIVER
+#define AVTAB_XPERMS_NLMSG SEPOL_AVTAB_XPERMS_NLMSG
+#endif
+
+#ifndef AVRULE_ALLOWED
+#define AVRULE_ALLOWED SEPOL_AVRULE_ALLOWED
+#define AVRULE_AUDITALLOW SEPOL_AVRULE_AUDITALLOW
+#define AVRULE_AUDITDENY SEPOL_AVRULE_AUDITDENY
+#define AVRULE_DONTAUDIT SEPOL_AVRULE_DONTAUDIT
+#define AVRULE_NEVERALLOW SEPOL_AVRULE_NEVERALLOW
+#define AVRULE_AV SEPOL_AVRULE_AV
+#define AVRULE_TRANSITION SEPOL_AVRULE_TRANSITION
+#define AVRULE_MEMBER SEPOL_AVRULE_MEMBER
+#define AVRULE_CHANGE SEPOL_AVRULE_CHANGE
+#define AVRULE_TYPE SEPOL_AVRULE_TYPE
+#define AVRULE_XPERMS_ALLOWED SEPOL_AVRULE_XPERMS_ALLOWED
+#define AVRULE_XPERMS_AUDITALLOW SEPOL_AVRULE_XPERMS_AUDITALLOW
+#define AVRULE_XPERMS_DONTAUDIT SEPOL_AVRULE_XPERMS_DONTAUDIT
+#define AVRULE_XPERMS_NEVERALLOW SEPOL_AVRULE_XPERMS_NEVERALLOW
+#define AVRULE_XPERMS SEPOL_AVRULE_XPERMS
+#define AVRULE_XPERMS_IOCTLFUNCTION SEPOL_AVRULE_XPERMS_IOCTLFUNCTION
+#define AVRULE_XPERMS_IOCTLDRIVER SEPOL_AVRULE_XPERMS_IOCTLDRIVER
+#define AVRULE_XPERMS_NLMSG SEPOL_AVRULE_XPERMS_NLMSG
+#endif
+
+#ifndef RULE_SELF
+#define RULE_SELF SEPOL_RULE_SELF
+#define RULE_NOTSELF SEPOL_RULE_NOTSELF
+#endif
+
+#ifndef SECURITY_FS_USE_XATTR
+#define SECURITY_FS_USE_XATTR SEPOL_SECURITY_FS_USE_XATTR
+#define SECURITY_FS_USE_TRANS SEPOL_SECURITY_FS_USE_TRANS
+#define SECURITY_FS_USE_TASK SEPOL_SECURITY_FS_USE_TASK
+#define SECURITY_FS_USE_GENFS SEPOL_SECURITY_FS_USE_GENFS
+#define SECURITY_FS_USE_NONE SEPOL_SECURITY_FS_USE_NONE
+#endif
+
+#ifndef SYM_COMMONS
+#define SYM_COMMONS SEPOL_SYM_COMMONS
+#define SYM_CLASSES SEPOL_SYM_CLASSES
+#define SYM_ROLES SEPOL_SYM_ROLES
+#define SYM_TYPES SEPOL_SYM_TYPES
+#define SYM_USERS SEPOL_SYM_USERS
+#define SYM_BOOLS SEPOL_SYM_BOOLS
+#define SYM_LEVELS SEPOL_SYM_LEVELS
+#define SYM_CATS SEPOL_SYM_CATS
+#define SYM_NUM SEPOL_SYM_NUM
+#endif
+
+#ifndef OCON_ISID
+#define OCON_ISID SEPOL_OCON_ISID
+#define OCON_FS SEPOL_OCON_FS
+#define OCON_PORT SEPOL_OCON_PORT
+#define OCON_NETIF SEPOL_OCON_NETIF
+#define OCON_NODE SEPOL_OCON_NODE
+#define OCON_FSUSE SEPOL_OCON_FSUSE
+#define OCON_NODE6 SEPOL_OCON_NODE6
+#define OCON_IBPKEY SEPOL_OCON_IBPKEY
+#define OCON_IBENDPORT SEPOL_OCON_IBENDPORT
+#define OCON_XEN_ISID SEPOL_OCON_XEN_ISID
+#define OCON_XEN_PIRQ SEPOL_OCON_XEN_PIRQ
+#define OCON_XEN_IOPORT SEPOL_OCON_XEN_IOPORT
+#define OCON_XEN_IOMEM SEPOL_OCON_XEN_IOMEM
+#define OCON_XEN_PCIDEVICE SEPOL_OCON_XEN_PCIDEVICE
+#define OCON_XEN_DEVICETREE SEPOL_OCON_XEN_DEVICETREE
+#define OCON_NUM SEPOL_OCON_NUM
+#endif
+
+#ifndef EXTENDED_PERMS_LEN
+#define EXTENDED_PERMS_LEN SEPOL_EXTENDED_PERMS_LEN
+#endif
+
+#ifndef xperm_test
+#define xperm_test(x, p) (1U & ((p)[(x) >> 5] >> ((x) & 0x1f)))
+#define xperm_set(x, p) ((p)[(x) >> 5] |= (1U << ((x) & 0x1f)))
+#define xperm_clear(x, p) ((p)[(x) >> 5] &= ~(1U << ((x) & 0x1f)))
+#endif
+
+#ifndef MAX_AVTAB_HASH_BITS
+#define MAX_AVTAB_HASH_BITS SEPOL_MAX_AVTAB_HASH_BITS
+#define MAX_AVTAB_HASH_BUCKETS SEPOL_MAX_AVTAB_HASH_BUCKETS
+#define MAX_AVTAB_HASH_MASK (MAX_AVTAB_HASH_BUCKETS - 1)
+#define MAX_AVTAB_SIZE SEPOL_MAX_AVTAB_SIZE
+#endif
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* _SEPOL_CONSTANTS_H_ */
diff --git a/libsepol/include/sepol/policydb.h b/libsepol/include/sepol/policydb.h
index 98357ee4..967bce3d 100644
--- a/libsepol/include/sepol/policydb.h
+++ b/libsepol/include/sepol/policydb.h
@@ -87,6 +87,11 @@ extern int sepol_policydb_set_typevers(sepol_policydb_t *p, unsigned int type);
  */
 extern int sepol_policydb_set_vers(sepol_policydb_t *p, unsigned int vers);
 
+/*
+ * Get the policy version.
+ */
+extern unsigned int sepol_policydb_get_vers(const sepol_policydb_t *p);
+
 /* Set how to handle unknown class/perms. */
 #define SEPOL_DENY_UNKNOWN 0
 #define SEPOL_REJECT_UNKNOWN 2
@@ -94,12 +99,19 @@ extern int sepol_policydb_set_vers(sepol_policydb_t *p, unsigned int vers);
 extern int sepol_policydb_set_handle_unknown(sepol_policydb_t *p,
 					     unsigned int handle_unknown);
 
+/* Get how to handle unknown class/perms. */
+extern unsigned int
+sepol_policydb_get_handle_unknown(const sepol_policydb_t *p);
+
 /* Set the target platform */
 #define SEPOL_TARGET_SELINUX 0
 #define SEPOL_TARGET_XEN 1
 extern int sepol_policydb_set_target_platform(sepol_policydb_t *p,
 					      int target_platform);
 
+/* Get the target platform. */
+extern int sepol_policydb_get_target_platform(const sepol_policydb_t *p);
+
 /*
  * Optimize the policy by removing redundant rules.
  */
@@ -148,6 +160,23 @@ extern int sepol_policydb_mls_enabled(const sepol_policydb_t *p);
  */
 extern int sepol_policydb_compat_net(const sepol_policydb_t *p);
 
+/*
+ * Set permissive flags on types marked as permissive in the policy.
+ * Must be called after policy load to enable permissive type enforcement.
+ */
+extern int sepol_policydb_set_permissive_flags(sepol_handle_t *handle,
+					       sepol_policydb_t *p);
+
+/*
+ * Rebuild the type attribute mapping. Call after modifying type attributes
+ * to ensure consistency.
+ *
+ * On out-of-memory, returns -1; the map may be only partially rebuilt in
+ * that case, but the policydb is left in a self-consistent, usable state.
+ */
+extern int sepol_policydb_rebuild_attr_map(sepol_handle_t *handle,
+					   sepol_policydb_t *p);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/libsepol/include/sepol/policydb/avtab.h b/libsepol/include/sepol/policydb/avtab.h
index 83e1033f..eb76c43c 100644
--- a/libsepol/include/sepol/policydb/avtab.h
+++ b/libsepol/include/sepol/policydb/avtab.h
@@ -43,6 +43,8 @@
 #include <sys/types.h>
 #include <stdint.h>
 
+#include <sepol/constants.h>
+
 #ifdef __cplusplus
 extern "C" {
 #endif
@@ -51,32 +53,11 @@ typedef struct avtab_key {
 	uint16_t source_type;
 	uint16_t target_type;
 	uint16_t target_class;
-#define AVTAB_ALLOWED 0x0001
-#define AVTAB_AUDITALLOW 0x0002
-#define AVTAB_AUDITDENY 0x0004
-#define AVTAB_NEVERALLOW 0x0080
-#define AVTAB_AV (AVTAB_ALLOWED | AVTAB_AUDITALLOW | AVTAB_AUDITDENY)
-#define AVTAB_TRANSITION 0x0010
-#define AVTAB_MEMBER 0x0020
-#define AVTAB_CHANGE 0x0040
-#define AVTAB_TYPE (AVTAB_TRANSITION | AVTAB_MEMBER | AVTAB_CHANGE)
-#define AVTAB_XPERMS_ALLOWED 0x0100
-#define AVTAB_XPERMS_AUDITALLOW 0x0200
-#define AVTAB_XPERMS_DONTAUDIT 0x0400
-#define AVTAB_XPERMS_NEVERALLOW 0x0800
-#define AVTAB_XPERMS                                      \
-	(AVTAB_XPERMS_ALLOWED | AVTAB_XPERMS_AUDITALLOW | \
-	 AVTAB_XPERMS_DONTAUDIT)
-#define AVTAB_ENABLED_OLD 0x80000000
-#define AVTAB_ENABLED 0x8000 /* reserved for used in cond_avtab */
-	uint16_t specified; /* what fields are specified */
+	uint16_t specified; /* what fields are specified; see AVTAB_* in sepol/constants.h */
 } avtab_key_t;
 
 typedef struct avtab_extended_perms {
-#define AVTAB_XPERMS_IOCTLFUNCTION 0x01
-#define AVTAB_XPERMS_IOCTLDRIVER 0x02
-#define AVTAB_XPERMS_NLMSG 0x03
-	/* extension of the avtab_key specified */
+	/* extension of the avtab_key specified; see AVTAB_XPERMS_* in sepol/constants.h */
 	uint8_t specified;
 	uint8_t driver;
 	uint32_t perms[8];
@@ -139,12 +120,6 @@ extern avtab_ptr_t avtab_search_node(avtab_t *h, avtab_key_t *key);
 
 extern avtab_ptr_t avtab_search_node_next(avtab_ptr_t node, int specified);
 
-#define MAX_AVTAB_HASH_BITS 20
-#define MAX_AVTAB_HASH_BUCKETS (1 << MAX_AVTAB_HASH_BITS)
-#define MAX_AVTAB_HASH_MASK (MAX_AVTAB_HASH_BUCKETS - 1)
-/* avtab_alloc uses one bucket per 2-4 elements, so adjust to get maximum buckets */
-#define MAX_AVTAB_SIZE (MAX_AVTAB_HASH_BUCKETS << 1)
-
 #ifdef __cplusplus
 }
 #endif
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index ae125fd5..5288af4e 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -57,6 +57,7 @@
 #include <sepol/policydb.h>
 
 #include <sepol/policydb/flask_types.h>
+#include <sepol/constants.h>
 #include <sepol/policydb/symtab.h>
 #include <sepol/policydb/avtab.h>
 #include <sepol/policydb/context.h>
@@ -252,15 +253,9 @@ typedef struct class_perm_node {
 	struct class_perm_node *next;
 } class_perm_node_t;
 
-#define xperm_test(x, p) (UINT32_C(1) & ((p)[(x) >> 5] >> ((x) & 0x1f)))
-#define xperm_set(x, p) ((p)[(x) >> 5] |= (UINT32_C(1) << ((x) & 0x1f)))
-#define xperm_clear(x, p) ((p)[(x) >> 5] &= ~(UINT32_C(1) << ((x) & 0x1f)))
-#define EXTENDED_PERMS_LEN 8
+/* xperm_*, EXTENDED_PERMS_LEN, AVRULE_*, RULE_*: <sepol/constants.h> */
 
 typedef struct av_extended_perms {
-#define AVRULE_XPERMS_IOCTLFUNCTION 0x01
-#define AVRULE_XPERMS_IOCTLDRIVER 0x02
-#define AVRULE_XPERMS_NLMSG 0x03
 	uint8_t specified;
 	uint8_t driver;
 	/* 256 bits of permissions */
@@ -268,30 +263,8 @@ typedef struct av_extended_perms {
 } av_extended_perms_t;
 
 typedef struct avrule {
-/* these typedefs are almost exactly the same as those in avtab.h - they are
- * here because of the need to include neverallow and dontaudit messages */
-#define AVRULE_ALLOWED AVTAB_ALLOWED
-#define AVRULE_AUDITALLOW AVTAB_AUDITALLOW
-#define AVRULE_AUDITDENY AVTAB_AUDITDENY
-#define AVRULE_DONTAUDIT 0x0008
-#define AVRULE_NEVERALLOW AVTAB_NEVERALLOW
-#define AVRULE_AV                                                \
-	(AVRULE_ALLOWED | AVRULE_AUDITALLOW | AVRULE_AUDITDENY | \
-	 AVRULE_DONTAUDIT | AVRULE_NEVERALLOW)
-#define AVRULE_TRANSITION AVTAB_TRANSITION
-#define AVRULE_MEMBER AVTAB_MEMBER
-#define AVRULE_CHANGE AVTAB_CHANGE
-#define AVRULE_TYPE (AVRULE_TRANSITION | AVRULE_MEMBER | AVRULE_CHANGE)
-#define AVRULE_XPERMS_ALLOWED AVTAB_XPERMS_ALLOWED
-#define AVRULE_XPERMS_AUDITALLOW AVTAB_XPERMS_AUDITALLOW
-#define AVRULE_XPERMS_DONTAUDIT AVTAB_XPERMS_DONTAUDIT
-#define AVRULE_XPERMS_NEVERALLOW AVTAB_XPERMS_NEVERALLOW
-#define AVRULE_XPERMS                                       \
-	(AVRULE_XPERMS_ALLOWED | AVRULE_XPERMS_AUDITALLOW | \
-	 AVRULE_XPERMS_DONTAUDIT | AVRULE_XPERMS_NEVERALLOW)
+	/* specified: AVRULE_* (same bits as AVTAB_*); flags: RULE_* - sepol/constants.h */
 	uint32_t specified;
-#define RULE_SELF (1U << 0)
-#define RULE_NOTSELF (1U << 1)
 	uint32_t flags;
 	type_set_t stypes;
 	type_set_t ttypes;
@@ -395,38 +368,7 @@ typedef struct genfs {
 	struct genfs *next;
 } genfs_t;
 
-/* symbol table array indices */
-#define SYM_COMMONS 0
-#define SYM_CLASSES 1
-#define SYM_ROLES 2
-#define SYM_TYPES 3
-#define SYM_USERS 4
-#define SYM_BOOLS 5
-#define SYM_LEVELS 6
-#define SYM_CATS 7
-#define SYM_NUM 8
-
-/* object context array indices */
-#define OCON_ISID 0 /* initial SIDs */
-#define OCON_FS 1 /* unlabeled file systems */
-#define OCON_PORT 2 /* TCP and UDP port numbers */
-#define OCON_NETIF 3 /* network interfaces */
-#define OCON_NODE 4 /* nodes */
-#define OCON_FSUSE 5 /* fs_use */
-#define OCON_NODE6 6 /* IPv6 nodes */
-#define OCON_IBPKEY 7 /* Infiniband PKEY */
-#define OCON_IBENDPORT 8 /* Infiniband End Port */
-
-/* object context array indices for Xen */
-#define OCON_XEN_ISID 0 /* initial SIDs */
-#define OCON_XEN_PIRQ 1 /* physical irqs */
-#define OCON_XEN_IOPORT 2 /* io ports */
-#define OCON_XEN_IOMEM 3 /* io memory */
-#define OCON_XEN_PCIDEVICE 4 /* pci devices */
-#define OCON_XEN_DEVICETREE 5 /* device tree node */
-
-/* OCON_NUM needs to be the largest index in any platform's ocontext array */
-#define OCON_NUM 9
+/* SYM_*, OCON_*, OCON_NUM: <sepol/constants.h> */
 
 /* section: module information */
 
@@ -627,7 +569,7 @@ typedef struct policydb {
 	sepol_access_vector_t process_trans;
 	sepol_access_vector_t process_trans_dyntrans;
 
-	/* avrules whose line markes will be printed. Defaults to neverallow and
+	/* avrules whose line markers will be printed. Defaults to neverallow and
 	   neverallowxperm */
 	uint32_t line_marker_avrules;
 
diff --git a/libsepol/include/sepol/policydb/services.h b/libsepol/include/sepol/policydb/services.h
index 4534c183..670bc1ab 100644
--- a/libsepol/include/sepol/policydb/services.h
+++ b/libsepol/include/sepol/policydb/services.h
@@ -12,6 +12,9 @@
  * Security server interface.
  */
 
+#include <sepol/constants.h>
+#include <sepol/context_record.h>
+#include <sepol/handle.h>
 #include <sepol/policydb/flask_types.h>
 #include <sepol/policydb/policydb.h>
 #include <stddef.h>
@@ -146,6 +149,16 @@ extern int sepol_sid_to_context(sepol_security_id_t sid, /* IN */
 				sepol_security_context_t *scontext, /* OUT */
 				size_t *scontext_len); /* OUT */
 
+/*
+ * Allocate and return a new sepol_context_t with the context associated
+ * with `sid'. The caller owns *record and must free it with
+ * sepol_context_free().
+ * Requires an active policydb and sidtab (see sepol_set_policydb / sepol_set_sidtab).
+ */
+extern int sepol_sid_to_context_record(sepol_handle_t *handle,
+				       sepol_security_id_t sid,
+				       sepol_context_t **record);
+
 /*
  * Return a SID associated with the security context that
  * has the string representation specified by `scontext'.
@@ -220,12 +233,8 @@ extern int sepol_node_sid(uint16_t domain, void *addr, size_t addrlen,
  * Return a value indicating how to handle labeling for the
  * the specified filesystem type, and optionally return a SID
  * for the filesystem object.  
+ * (SECURITY_FS_USE_* constants are in <sepol/constants.h>.)
  */
-#define SECURITY_FS_USE_XATTR 1 /* use xattr */
-#define SECURITY_FS_USE_TRANS 2 /* use transition SIDs, e.g. devpts/tmpfs */
-#define SECURITY_FS_USE_TASK 3 /* use task SIDs, e.g. pipefs/sockfs */
-#define SECURITY_FS_USE_GENFS 4 /* use the genfs support */
-#define SECURITY_FS_USE_NONE 5 /* no labeling support */
 extern int sepol_fs_use(const char *fstype, /* IN */
 			unsigned int *behavior, /* OUT */
 			sepol_security_id_t *sid); /* OUT  */
diff --git a/libsepol/src/policydb_public.c b/libsepol/src/policydb_public.c
index e45e1a70..21211bb5 100644
--- a/libsepol/src/policydb_public.c
+++ b/libsepol/src/policydb_public.c
@@ -1,8 +1,12 @@
+#include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 
 #include "debug.h"
+#include <sepol/policydb/ebitmap.h>
 #include <sepol/policydb/policydb.h>
 #include "policydb_internal.h"
+#include "sepol/policydb.h"
 
 /* Policy file interfaces. */
 
@@ -130,6 +134,11 @@ int sepol_policydb_set_vers(sepol_policydb_t *sp, unsigned int vers)
 	return 0;
 }
 
+unsigned int sepol_policydb_get_vers(const sepol_policydb_t *sp)
+{
+	return sp ? sp->p.policyvers : 0;
+}
+
 int sepol_policydb_set_handle_unknown(sepol_policydb_t *sp,
 				      unsigned int handle_unknown)
 {
@@ -148,6 +157,11 @@ int sepol_policydb_set_handle_unknown(sepol_policydb_t *sp,
 	return 0;
 }
 
+unsigned int sepol_policydb_get_handle_unknown(const sepol_policydb_t *sp)
+{
+	return sp ? sp->p.handle_unknown : 0;
+}
+
 int sepol_policydb_set_target_platform(sepol_policydb_t *sp,
 				       int target_platform)
 {
@@ -165,6 +179,11 @@ int sepol_policydb_set_target_platform(sepol_policydb_t *sp,
 	return 0;
 }
 
+int sepol_policydb_get_target_platform(const sepol_policydb_t *sp)
+{
+	return sp ? sp->p.target_platform : SEPOL_TARGET_SELINUX;
+}
+
 int sepol_policydb_optimize(sepol_policydb_t *p)
 {
 	return policydb_optimize(&p->p);
@@ -194,6 +213,8 @@ int sepol_policydb_to_image(sepol_handle_t *handle, sepol_policydb_t *p,
 
 int sepol_policydb_mls_enabled(const sepol_policydb_t *p)
 {
+	if (!p)
+		return 0;
 	return p->p.mls;
 }
 
@@ -204,6 +225,188 @@ int sepol_policydb_mls_enabled(const sepol_policydb_t *p)
 #define PACKET_CLASS_NAME "packet"
 int sepol_policydb_compat_net(const sepol_policydb_t *p)
 {
+	if (!p)
+		return 0;
 	return (hashtab_search(p->p.p_classes.table, PACKET_CLASS_NAME) ==
 		NULL);
 }
+
+int sepol_policydb_set_permissive_flags(sepol_handle_t *handle
+					__attribute__((unused)),
+					sepol_policydb_t *p)
+{
+	if (!p)
+		return -1;
+	policydb_t *pdb = &p->p;
+	ebitmap_node_t *node;
+	unsigned int bit;
+
+	ebitmap_for_each_positive_bit(&pdb->permissive_map, node, bit) {
+		if (bit < 1 || bit > pdb->p_types.nprim)
+			continue;
+		if (!pdb->type_val_to_struct[bit - 1])
+			continue;
+		pdb->type_val_to_struct[bit - 1]->flags |=
+			TYPE_FLAGS_PERMISSIVE;
+	}
+
+	return 0;
+}
+
+int sepol_policydb_rebuild_attr_map(sepol_handle_t *handle, sepol_policydb_t *p)
+{
+	if (!p)
+		return -1;
+	policydb_t *pdb = &p->p;
+	uint32_t nprim = pdb->p_types.nprim;
+	uint32_t i;
+	ebitmap_node_t *node;
+	unsigned int bit;
+	int rc = 0;
+
+	if (!pdb->attr_type_map)
+		return 0;
+
+	/*
+	 * Pass 1: pre-allocate synthetic names for unnamed attributes
+	 * before touching any ebitmaps.  Name installation is additive
+	 * (NULL -> non-NULL) and harmless, so early return on OOM here
+	 * leaves the policy in a consistent state.
+	 *
+	 * The synthetic name is inserted into p_types.table as the real
+	 * hashtab key for the attribute, and p_type_val_to_name[i] is set
+	 * to alias that same key -- exactly like every ordinarily-named
+	 * type/attribute (see type_datum insertion in policydb.c). This
+	 * way the name is freed exactly once, by the normal symtab
+	 * teardown in policydb_destroy(), instead of leaking (writing a
+	 * separately-owned allocation directly into p_type_val_to_name[]
+	 * would never be freed, since that array only ever holds borrowed
+	 * pointers into the hashtab).
+	 */
+	for (i = 0; i < nprim; i++) {
+		type_datum_t *datum = pdb->type_val_to_struct[i];
+		if (!datum || datum->flavor != TYPE_ATTRIB)
+			continue;
+		if (pdb->p_type_val_to_name[i])
+			continue;
+
+		char *synth = malloc(16);
+		if (!synth) {
+			ERR(handle, "out of memory");
+			return -1;
+		}
+		snprintf(synth, 16, "@ttr%010u", i + 1);
+		int hrc = hashtab_insert(pdb->p_types.table, synth,
+					 (hashtab_datum_t)datum);
+		if (hrc < 0) {
+			free(synth);
+			if (hrc == SEPOL_EEXIST)
+				ERR(handle,
+				    "synthetic attribute name already exists");
+			else
+				ERR(handle, "out of memory");
+			return -1;
+		}
+		pdb->p_type_val_to_name[i] = synth;
+	}
+
+	/*
+	 * Pass 2: clear every existing reverse-mapping entry first, so this
+	 * rebuild recomputes type_attr_map[] from scratch based solely on
+	 * the *current* attr_type_map[] contents, rather than monotonically
+	 * unioning in new bits on top of whatever a previous rebuild (or the
+	 * initial policy load) left behind. Without this, removing a type
+	 * from an attribute (or removing an attribute's last member) would
+	 * leave a stale bit in type_attr_map[] -- and since services.c's AV
+	 * computation reads type_attr_map[] directly to resolve a type's
+	 * attribute membership, a stale bit there is a real policy
+	 * correctness/security issue, not just an API bookkeeping nit.
+	 */
+	for (i = 0; i < nprim; i++)
+		ebitmap_destroy(&pdb->type_attr_map[i]);
+
+	/*
+	 * Pass 3: restore the mandatory "type/attribute is a member of
+	 * itself" bit that Pass 2 above just destroyed for every entry.
+	 * This mirrors policydb_read()'s "add the type itself as the
+	 * degenerate case" step, which unconditionally sets this bit for
+	 * every valid type_val_to_struct[i] (type *or* attribute) when a
+	 * kernel policy is first loaded (see policydb.c). It is not
+	 * optional bookkeeping: services.c's AV-decision hot path reads
+	 * type_attr_map[] directly to expand a context's type value into
+	 * every {type,attribute} value that can appear as an avtab key's
+	 * source/target, so without this bit any allow rule written
+	 * against a literal type (rather than through an attribute) would
+	 * silently stop matching after this rebuild -- and a type that is
+	 * not a member of any attribute at all would lose *all* direct AV
+	 * matches for it. Must run before Pass 4 below, so a type that is
+	 * also an attribute member still ends up with both bits set.
+	 */
+	for (i = 0; i < nprim; i++) {
+		if (!pdb->type_val_to_struct[i])
+			continue;
+		if (ebitmap_set_bit(&pdb->type_attr_map[i], i, 1) < 0) {
+			ERR(handle,
+			    "out of memory restoring self-membership bit");
+			rc = -1;
+		}
+	}
+
+	/*
+	 * Pass 4: copy (never move) the forward maps from attr_type_map
+	 * into datum->types and build reverse mappings. attr_type_map[i]
+	 * must remain intact afterwards: type_datum_to_record() reads
+	 * directly from p->attr_type_map/p->type_attr_map for a
+	 * POLICY_KERN policydb (the only policy_type for which this
+	 * function's early "!attr_type_map" guard lets it run at all),
+	 * so destructively moving the bitmap out of attr_type_map here
+	 * would silently zero out every subsequent
+	 * sepol_type_query()/sepol_type_query_by_value() result for
+	 * this attribute. Likewise, the reverse (type -> its attributes)
+	 * mapping consulted by type_datum_to_record() for a regular
+	 * type in POLICY_KERN mode is p->type_attr_map[], not that
+	 * type's own type_datum->types field (which is dead data for
+	 * POLICY_KERN) -- so the reverse map must be written into
+	 * type_attr_map[bit], not type_val_to_struct[bit]->types. If
+	 * ebitmap_cpy/ebitmap_set_bit fails (OOM), log the error but
+	 * continue to leave the policy in the most complete state
+	 * possible rather than returning mid-loop with some attributes
+	 * migrated and others not.
+	 *
+	 * datum->types is always reset first (even when attr_type_map[i]
+	 * is now empty) so an attribute that lost its last member ends up
+	 * with an accurately-empty membership set instead of retaining
+	 * stale entries from before the removal.
+	 */
+	for (i = 0; i < nprim; i++) {
+		type_datum_t *datum = pdb->type_val_to_struct[i];
+		if (!datum || datum->flavor != TYPE_ATTRIB)
+			continue;
+
+		ebitmap_destroy(&datum->types);
+
+		if (ebitmap_length(&pdb->attr_type_map[i]) == 0)
+			continue;
+
+		if (ebitmap_cpy(&datum->types, &pdb->attr_type_map[i]) < 0) {
+			ERR(handle, "out of memory copying attribute map");
+			rc = -1;
+			continue;
+		}
+
+		ebitmap_for_each_positive_bit(&datum->types, node, bit) {
+			if (bit >= nprim)
+				continue;
+			if (!pdb->type_val_to_struct[bit])
+				continue;
+			if (ebitmap_set_bit(&pdb->type_attr_map[bit], i, 1) <
+			    0) {
+				ERR(handle,
+				    "out of memory building reverse attr map");
+				rc = -1;
+			}
+		}
+	}
+
+	return rc;
+}
-- 
2.55.0

