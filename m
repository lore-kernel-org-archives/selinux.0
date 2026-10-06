Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFBF3DDDDD
	for <selinux@vger.kernel.org>; Tue,  6 Oct 2026 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291878; cv=none; b=twxHhOAGBrk4zZriUoKQOPMJuFutivyja9yi0JjxjrnoHoEyQj0erLN9aErAgbAHaLswIeAbz6q5spppABTlY97EJO/yMH3qufHClvWt4LOfDh5pY6J+4RPGdHFXcT3f/o/STpm+jPvhi/gNJUoV+Fyk/E0NAYOmSqweBU4RVww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291878; c=relaxed/simple;
	bh=PkZVwRxyhxDDhD93GI6I/zGQsBbcoMf8NHbJhzGoqKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PX6+v09NTm5AduTUg81cYi1XLvY/3RGVSApdS0lUz9+40Cy2qIDEDytYldf56saEK1KTNixkD6lheWvDJnThroOvwtyzBPPvT/bVgaxoprxFXpXr2vjs3ve/er9rKRExObLrA/qqlx4vJWmAiRWRRD/RMPJAUoKDLn1eVZyWAGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HPmRVXo3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPmRVXo3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791291874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s0dSmu2EvnJdgqUfGCxEm2sGp9D520Wmd9WGPi4vCZ8=;
	b=HPmRVXo3ROmR2JiVhZLzJDNYk2wUw1NWKY1Li9bAs9aPK2eQSlpZDAd+WYoR+E5BE0a4dU
	pcVnSj/jRPveeIJl/cnhptSixbuHP/td1puN7smzXocJXEfUM5d7p6KpW5pQi+SfpPbSTk
	Uskf3+3p/tYYdYPNSfGppniZhc/smjY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-x6LyVFuANUuRQFyYes_ChQ-1; Tue,
 06 Oct 2026 09:04:32 -0400
X-MC-Unique: x6LyVFuANUuRQFyYes_ChQ-1
X-Mimecast-MFC-AGG-ID: x6LyVFuANUuRQFyYes_ChQ_1791291871
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 606F11955F76
	for <selinux@vger.kernel.org>; Tue,  6 Oct 2026 13:04:31 +0000 (UTC)
Received: from jjanasek-thinkpadt14gen5.tpbc.com (unknown [10.44.48.38])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E544D1956047;
	Tue,  6 Oct 2026 13:04:29 +0000 (UTC)
From: jan janasek <jjanasek@redhat.com>
To: selinux@vger.kernel.org
Cc: jan janasek <jjanasek@redhat.com>
Subject: [RFC PATCH userspace 13/17] libsepol: add ocontext iterators for initial SIDs and named contexts
Date: Tue,  6 Oct 2026 15:02:11 +0200
Message-ID: <20261006130215.128405-14-jjanasek@redhat.com>
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

Add per-kind ocontext iterators (initial SIDs, fs_use, genfscon,
netifcon, node/node6, port, ibpkey, ibendport, pirq/iomem/ioport/
pcidevice/devicetree for Xen) with context and name/address accessors,
deduplicating ~100 near-identical accessor bodies into
DEFINE_OCON_CONTEXT_GETTERS macro instances.

Extract the initial-SID name table (indexed by SID value, not stored
in the binary policy) into a shared libsepol/src/initial_sids.h, used
by both sepol_isid_iter_get_name() here and the existing
kernel_to_common.c CIL/conf writers, instead of duplicating the table.

Assisted-by: LLM Cursor
Signed-off-by: Jan Janasek <jjanasek@redhat.com>
---
 libsepol/include/sepol/ocontext.h |  513 ++++++++++++++
 libsepol/src/initial_sids.h       |   29 +
 libsepol/src/kernel_to_common.h   |   22 +-
 libsepol/src/ocontext.c           | 1058 +++++++++++++++++++++++++++++
 4 files changed, 1602 insertions(+), 20 deletions(-)
 create mode 100644 libsepol/include/sepol/ocontext.h
 create mode 100644 libsepol/src/initial_sids.h
 create mode 100644 libsepol/src/ocontext.c

diff --git a/libsepol/include/sepol/ocontext.h b/libsepol/include/sepol/ocontext.h
new file mode 100644
index 00000000..195359fa
--- /dev/null
+++ b/libsepol/include/sepol/ocontext.h
@@ -0,0 +1,513 @@
+#ifndef _SEPOL_OCONTEXT_H_
+#define _SEPOL_OCONTEXT_H_
+
+#include <sepol/cat_set.h>
+#include <sepol/handle.h>
+#include <sepol/policydb.h>
+#include <stdint.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/*
+ * NOTE on every sepol_cat_set_iter_t **cat_iter parameter below: see the
+ * ownership contract documented in cat_set.h. In short, the callee always
+ * allocates a new, caller-owned iterator that must be freed with
+ * sepol_cat_set_iter_destroy() -- do not skip destroying it just because
+ * the underlying category set turned out to be empty.
+ *
+ * NOTE on every `const char **`/`const uint32_t **` out-parameter
+ * populated by an `_iter_next()` function below (e.g. fsuse's name,
+ * genfscon's fstype/path, netifcon's name, ibendportcon's dev_name,
+ * devicetreecon's path, nodecon6's addr/mask): the returned pointer is
+ * borrowed from the policydb. It remains valid only until the next call
+ * on the same iterator (`_iter_next()` or `_destroy()`) and must not be
+ * freed by the caller.
+ */
+
+/* Initial SID iterator */
+
+typedef struct sepol_isid_iter sepol_isid_iter_t;
+
+extern int sepol_isid_iter_create(sepol_handle_t *handle,
+				  const sepol_policydb_t *p,
+				  sepol_isid_iter_t **iter);
+
+extern void sepol_isid_iter_destroy(sepol_isid_iter_t *iter);
+
+extern int sepol_isid_iter_next(sepol_handle_t *handle, sepol_isid_iter_t *iter,
+				uint32_t *sid);
+
+extern uint32_t sepol_isid_iter_get_context_user(const sepol_isid_iter_t *iter);
+extern uint32_t sepol_isid_iter_get_context_role(const sepol_isid_iter_t *iter);
+extern uint32_t sepol_isid_iter_get_context_type(const sepol_isid_iter_t *iter);
+extern uint32_t
+sepol_isid_iter_get_mls_range_low_sens(const sepol_isid_iter_t *iter);
+extern uint32_t
+sepol_isid_iter_get_mls_range_high_sens(const sepol_isid_iter_t *iter);
+extern int
+sepol_isid_iter_get_mls_range_low_cat(const sepol_isid_iter_t *iter,
+				      sepol_cat_set_iter_t **cat_iter);
+extern int
+sepol_isid_iter_get_mls_range_high_cat(const sepol_isid_iter_t *iter,
+				       sepol_cat_set_iter_t **cat_iter);
+
+/* Returns the initial SID name.
+ * The pointer is borrowed from the policydb; do not free. */
+extern const char *sepol_isid_iter_get_name(const sepol_isid_iter_t *iter);
+
+/* fs_use iterator */
+
+typedef struct sepol_fsuse_iter sepol_fsuse_iter_t;
+
+extern int sepol_fsuse_iter_create(sepol_handle_t *handle,
+				   const sepol_policydb_t *p,
+				   sepol_fsuse_iter_t **iter);
+
+extern void sepol_fsuse_iter_destroy(sepol_fsuse_iter_t *iter);
+
+extern int sepol_fsuse_iter_next(sepol_handle_t *handle,
+				 sepol_fsuse_iter_t *iter, const char **name,
+				 uint32_t *behavior);
+
+extern uint32_t
+sepol_fsuse_iter_get_context_user(const sepol_fsuse_iter_t *iter);
+extern uint32_t
+sepol_fsuse_iter_get_context_role(const sepol_fsuse_iter_t *iter);
+extern uint32_t
+sepol_fsuse_iter_get_context_type(const sepol_fsuse_iter_t *iter);
+extern uint32_t
+sepol_fsuse_iter_get_mls_range_low_sens(const sepol_fsuse_iter_t *iter);
+extern uint32_t
+sepol_fsuse_iter_get_mls_range_high_sens(const sepol_fsuse_iter_t *iter);
+extern int
+sepol_fsuse_iter_get_mls_range_low_cat(const sepol_fsuse_iter_t *iter,
+				       sepol_cat_set_iter_t **cat_iter);
+extern int
+sepol_fsuse_iter_get_mls_range_high_cat(const sepol_fsuse_iter_t *iter,
+					sepol_cat_set_iter_t **cat_iter);
+
+/* genfscon iterator */
+
+typedef struct sepol_genfscon_iter sepol_genfscon_iter_t;
+
+extern int sepol_genfscon_iter_create(sepol_handle_t *handle,
+				      const sepol_policydb_t *p,
+				      sepol_genfscon_iter_t **iter);
+
+extern void sepol_genfscon_iter_destroy(sepol_genfscon_iter_t *iter);
+
+extern int sepol_genfscon_iter_next(sepol_handle_t *handle,
+				    sepol_genfscon_iter_t *iter,
+				    const char **fstype, const char **path,
+				    uint32_t *sclass);
+
+extern uint32_t
+sepol_genfscon_iter_get_context_user(const sepol_genfscon_iter_t *iter);
+extern uint32_t
+sepol_genfscon_iter_get_context_role(const sepol_genfscon_iter_t *iter);
+extern uint32_t
+sepol_genfscon_iter_get_context_type(const sepol_genfscon_iter_t *iter);
+extern uint32_t
+sepol_genfscon_iter_get_mls_range_low_sens(const sepol_genfscon_iter_t *iter);
+extern uint32_t
+sepol_genfscon_iter_get_mls_range_high_sens(const sepol_genfscon_iter_t *iter);
+extern int
+sepol_genfscon_iter_get_mls_range_low_cat(const sepol_genfscon_iter_t *iter,
+					  sepol_cat_set_iter_t **cat_iter);
+extern int
+sepol_genfscon_iter_get_mls_range_high_cat(const sepol_genfscon_iter_t *iter,
+					   sepol_cat_set_iter_t **cat_iter);
+
+/* portcon iterator */
+
+typedef struct sepol_portcon_iter sepol_portcon_iter_t;
+
+extern int sepol_portcon_iter_create(sepol_handle_t *handle,
+				     const sepol_policydb_t *p,
+				     sepol_portcon_iter_t **iter);
+
+extern void sepol_portcon_iter_destroy(sepol_portcon_iter_t *iter);
+
+/* has_next is set to 0 once iteration is exhausted; the other
+ * out-parameters cannot be used to detect end-of-iteration since 0
+ * is a valid port value. */
+extern int sepol_portcon_iter_next(sepol_handle_t *handle,
+				   sepol_portcon_iter_t *iter,
+				   uint8_t *protocol, uint16_t *low_port,
+				   uint16_t *high_port, int *has_next);
+
+extern uint32_t
+sepol_portcon_iter_get_context_user(const sepol_portcon_iter_t *iter);
+extern uint32_t
+sepol_portcon_iter_get_context_role(const sepol_portcon_iter_t *iter);
+extern uint32_t
+sepol_portcon_iter_get_context_type(const sepol_portcon_iter_t *iter);
+extern uint32_t
+sepol_portcon_iter_get_mls_range_low_sens(const sepol_portcon_iter_t *iter);
+extern uint32_t
+sepol_portcon_iter_get_mls_range_high_sens(const sepol_portcon_iter_t *iter);
+extern int
+sepol_portcon_iter_get_mls_range_low_cat(const sepol_portcon_iter_t *iter,
+					 sepol_cat_set_iter_t **cat_iter);
+extern int
+sepol_portcon_iter_get_mls_range_high_cat(const sepol_portcon_iter_t *iter,
+					  sepol_cat_set_iter_t **cat_iter);
+
+/* netifcon iterator */
+
+typedef struct sepol_netifcon_iter sepol_netifcon_iter_t;
+
+extern int sepol_netifcon_iter_create(sepol_handle_t *handle,
+				      const sepol_policydb_t *p,
+				      sepol_netifcon_iter_t **iter);
+
+extern void sepol_netifcon_iter_destroy(sepol_netifcon_iter_t *iter);
+
+extern int sepol_netifcon_iter_next(sepol_handle_t *handle,
+				    sepol_netifcon_iter_t *iter,
+				    const char **name);
+
+extern uint32_t
+sepol_netifcon_iter_get_context_user(const sepol_netifcon_iter_t *iter);
+extern uint32_t
+sepol_netifcon_iter_get_context_role(const sepol_netifcon_iter_t *iter);
+extern uint32_t
+sepol_netifcon_iter_get_context_type(const sepol_netifcon_iter_t *iter);
+extern uint32_t
+sepol_netifcon_iter_get_mls_range_low_sens(const sepol_netifcon_iter_t *iter);
+extern uint32_t
+sepol_netifcon_iter_get_mls_range_high_sens(const sepol_netifcon_iter_t *iter);
+extern int
+sepol_netifcon_iter_get_mls_range_low_cat(const sepol_netifcon_iter_t *iter,
+					  sepol_cat_set_iter_t **cat_iter);
+extern int
+sepol_netifcon_iter_get_mls_range_high_cat(const sepol_netifcon_iter_t *iter,
+					   sepol_cat_set_iter_t **cat_iter);
+
+extern uint32_t
+sepol_netifcon_iter_get_msg_context_user(const sepol_netifcon_iter_t *iter);
+extern uint32_t
+sepol_netifcon_iter_get_msg_context_role(const sepol_netifcon_iter_t *iter);
+extern uint32_t
+sepol_netifcon_iter_get_msg_context_type(const sepol_netifcon_iter_t *iter);
+extern uint32_t sepol_netifcon_iter_get_msg_mls_range_low_sens(
+	const sepol_netifcon_iter_t *iter);
+extern uint32_t sepol_netifcon_iter_get_msg_mls_range_high_sens(
+	const sepol_netifcon_iter_t *iter);
+extern int
+sepol_netifcon_iter_get_msg_mls_range_low_cat(const sepol_netifcon_iter_t *iter,
+					      sepol_cat_set_iter_t **cat_iter);
+extern int sepol_netifcon_iter_get_msg_mls_range_high_cat(
+	const sepol_netifcon_iter_t *iter, sepol_cat_set_iter_t **cat_iter);
+
+/* nodecon IPv4 iterator */
+
+typedef struct sepol_nodecon_iter sepol_nodecon_iter_t;
+
+extern int sepol_nodecon_iter_create(sepol_handle_t *handle,
+				     const sepol_policydb_t *p,
+				     sepol_nodecon_iter_t **iter);
+
+extern void sepol_nodecon_iter_destroy(sepol_nodecon_iter_t *iter);
+
+/* has_next is set to 0 once iteration is exhausted; addr/mask cannot
+ * be used to detect end-of-iteration since 0.0.0.0/0.0.0.0 is a
+ * valid nodecon entry. addr and mask are each a single IPv4 address
+ * or mask in network byte order (big-endian), as they appear in the
+ * policy source (e.g. "nodecon 192.168.1.0 255.255.255.0 ..."). */
+extern int sepol_nodecon_iter_next(sepol_handle_t *handle,
+				   sepol_nodecon_iter_t *iter, uint32_t *addr,
+				   uint32_t *mask, int *has_next);
+
+extern uint32_t
+sepol_nodecon_iter_get_context_user(const sepol_nodecon_iter_t *iter);
+extern uint32_t
+sepol_nodecon_iter_get_context_role(const sepol_nodecon_iter_t *iter);
+extern uint32_t
+sepol_nodecon_iter_get_context_type(const sepol_nodecon_iter_t *iter);
+extern uint32_t
+sepol_nodecon_iter_get_mls_range_low_sens(const sepol_nodecon_iter_t *iter);
+extern uint32_t
+sepol_nodecon_iter_get_mls_range_high_sens(const sepol_nodecon_iter_t *iter);
+extern int
+sepol_nodecon_iter_get_mls_range_low_cat(const sepol_nodecon_iter_t *iter,
+					 sepol_cat_set_iter_t **cat_iter);
+extern int
+sepol_nodecon_iter_get_mls_range_high_cat(const sepol_nodecon_iter_t *iter,
+					  sepol_cat_set_iter_t **cat_iter);
+
+/* nodecon6 IPv6 iterator */
+
+typedef struct sepol_nodecon6_iter sepol_nodecon6_iter_t;
+
+extern int sepol_nodecon6_iter_create(sepol_handle_t *handle,
+				      const sepol_policydb_t *p,
+				      sepol_nodecon6_iter_t **iter);
+
+extern void sepol_nodecon6_iter_destroy(sepol_nodecon6_iter_t *iter);
+
+/* addr and mask are each set to point at a borrowed, 4-element array
+ * of uint32_t (the 128-bit IPv6 address or mask split into four
+ * 32-bit words, each in network byte order (big-endian)), matching
+ * struct ocontext_t's u.node6.addr / u.node6.mask. The pointers are
+ * valid only until the next call on this iterator. */
+extern int sepol_nodecon6_iter_next(sepol_handle_t *handle,
+				    sepol_nodecon6_iter_t *iter,
+				    const uint32_t **addr,
+				    const uint32_t **mask);
+
+extern uint32_t
+sepol_nodecon6_iter_get_context_user(const sepol_nodecon6_iter_t *iter);
+extern uint32_t
+sepol_nodecon6_iter_get_context_role(const sepol_nodecon6_iter_t *iter);
+extern uint32_t
+sepol_nodecon6_iter_get_context_type(const sepol_nodecon6_iter_t *iter);
+extern uint32_t
+sepol_nodecon6_iter_get_mls_range_low_sens(const sepol_nodecon6_iter_t *iter);
+extern uint32_t
+sepol_nodecon6_iter_get_mls_range_high_sens(const sepol_nodecon6_iter_t *iter);
+extern int
+sepol_nodecon6_iter_get_mls_range_low_cat(const sepol_nodecon6_iter_t *iter,
+					  sepol_cat_set_iter_t **cat_iter);
+extern int
+sepol_nodecon6_iter_get_mls_range_high_cat(const sepol_nodecon6_iter_t *iter,
+					   sepol_cat_set_iter_t **cat_iter);
+
+/* ibpkeycon iterator */
+
+typedef struct sepol_ibpkeycon_iter sepol_ibpkeycon_iter_t;
+
+extern int sepol_ibpkeycon_iter_create(sepol_handle_t *handle,
+				       const sepol_policydb_t *p,
+				       sepol_ibpkeycon_iter_t **iter);
+
+extern void sepol_ibpkeycon_iter_destroy(sepol_ibpkeycon_iter_t *iter);
+
+/* has_next is set to 0 once iteration is exhausted; the other
+ * out-parameters cannot be used to detect end-of-iteration since 0
+ * is a valid pkey value. */
+extern int sepol_ibpkeycon_iter_next(sepol_handle_t *handle,
+				     sepol_ibpkeycon_iter_t *iter,
+				     uint64_t *subnet_prefix,
+				     uint16_t *low_pkey, uint16_t *high_pkey,
+				     int *has_next);
+
+extern uint32_t
+sepol_ibpkeycon_iter_get_context_user(const sepol_ibpkeycon_iter_t *iter);
+extern uint32_t
+sepol_ibpkeycon_iter_get_context_role(const sepol_ibpkeycon_iter_t *iter);
+extern uint32_t
+sepol_ibpkeycon_iter_get_context_type(const sepol_ibpkeycon_iter_t *iter);
+extern uint32_t
+sepol_ibpkeycon_iter_get_mls_range_low_sens(const sepol_ibpkeycon_iter_t *iter);
+extern uint32_t sepol_ibpkeycon_iter_get_mls_range_high_sens(
+	const sepol_ibpkeycon_iter_t *iter);
+extern int
+sepol_ibpkeycon_iter_get_mls_range_low_cat(const sepol_ibpkeycon_iter_t *iter,
+					   sepol_cat_set_iter_t **cat_iter);
+extern int
+sepol_ibpkeycon_iter_get_mls_range_high_cat(const sepol_ibpkeycon_iter_t *iter,
+					    sepol_cat_set_iter_t **cat_iter);
+
+/* ibendportcon iterator */
+
+typedef struct sepol_ibendportcon_iter sepol_ibendportcon_iter_t;
+
+extern int sepol_ibendportcon_iter_create(sepol_handle_t *handle,
+					  const sepol_policydb_t *p,
+					  sepol_ibendportcon_iter_t **iter);
+
+extern void sepol_ibendportcon_iter_destroy(sepol_ibendportcon_iter_t *iter);
+
+extern int sepol_ibendportcon_iter_next(sepol_handle_t *handle,
+					sepol_ibendportcon_iter_t *iter,
+					const char **dev_name, uint8_t *port);
+
+extern uint32_t
+sepol_ibendportcon_iter_get_context_user(const sepol_ibendportcon_iter_t *iter);
+extern uint32_t
+sepol_ibendportcon_iter_get_context_role(const sepol_ibendportcon_iter_t *iter);
+extern uint32_t
+sepol_ibendportcon_iter_get_context_type(const sepol_ibendportcon_iter_t *iter);
+extern uint32_t sepol_ibendportcon_iter_get_mls_range_low_sens(
+	const sepol_ibendportcon_iter_t *iter);
+extern uint32_t sepol_ibendportcon_iter_get_mls_range_high_sens(
+	const sepol_ibendportcon_iter_t *iter);
+extern int sepol_ibendportcon_iter_get_mls_range_low_cat(
+	const sepol_ibendportcon_iter_t *iter, sepol_cat_set_iter_t **cat_iter);
+extern int sepol_ibendportcon_iter_get_mls_range_high_cat(
+	const sepol_ibendportcon_iter_t *iter, sepol_cat_set_iter_t **cat_iter);
+
+/* Xen pirqcon iterator */
+
+typedef struct sepol_pirqcon_iter sepol_pirqcon_iter_t;
+
+extern int sepol_pirqcon_iter_create(sepol_handle_t *handle,
+				     const sepol_policydb_t *p,
+				     sepol_pirqcon_iter_t **iter);
+
+extern void sepol_pirqcon_iter_destroy(sepol_pirqcon_iter_t *iter);
+
+/* has_next is set to 0 once iteration is exhausted; irq cannot be
+ * used to detect end-of-iteration since 0 is a valid IRQ value. */
+extern int sepol_pirqcon_iter_next(sepol_handle_t *handle,
+				   sepol_pirqcon_iter_t *iter, uint32_t *irq,
+				   int *has_next);
+
+extern uint32_t
+sepol_pirqcon_iter_get_context_user(const sepol_pirqcon_iter_t *iter);
+extern uint32_t
+sepol_pirqcon_iter_get_context_role(const sepol_pirqcon_iter_t *iter);
+extern uint32_t
+sepol_pirqcon_iter_get_context_type(const sepol_pirqcon_iter_t *iter);
+extern uint32_t
+sepol_pirqcon_iter_get_mls_range_low_sens(const sepol_pirqcon_iter_t *iter);
+extern uint32_t
+sepol_pirqcon_iter_get_mls_range_high_sens(const sepol_pirqcon_iter_t *iter);
+extern int
+sepol_pirqcon_iter_get_mls_range_low_cat(const sepol_pirqcon_iter_t *iter,
+					 sepol_cat_set_iter_t **cat_iter);
+extern int
+sepol_pirqcon_iter_get_mls_range_high_cat(const sepol_pirqcon_iter_t *iter,
+					  sepol_cat_set_iter_t **cat_iter);
+
+/* Xen iomemcon iterator */
+
+typedef struct sepol_iomemcon_iter sepol_iomemcon_iter_t;
+
+extern int sepol_iomemcon_iter_create(sepol_handle_t *handle,
+				      const sepol_policydb_t *p,
+				      sepol_iomemcon_iter_t **iter);
+
+extern void sepol_iomemcon_iter_destroy(sepol_iomemcon_iter_t *iter);
+
+/* has_next is set to 0 once iteration is exhausted; low_iomem/
+ * high_iomem cannot be used to detect end-of-iteration since 0 is a
+ * valid address value. */
+extern int sepol_iomemcon_iter_next(sepol_handle_t *handle,
+				    sepol_iomemcon_iter_t *iter,
+				    uint64_t *low_iomem, uint64_t *high_iomem,
+				    int *has_next);
+
+extern uint32_t
+sepol_iomemcon_iter_get_context_user(const sepol_iomemcon_iter_t *iter);
+extern uint32_t
+sepol_iomemcon_iter_get_context_role(const sepol_iomemcon_iter_t *iter);
+extern uint32_t
+sepol_iomemcon_iter_get_context_type(const sepol_iomemcon_iter_t *iter);
+extern uint32_t
+sepol_iomemcon_iter_get_mls_range_low_sens(const sepol_iomemcon_iter_t *iter);
+extern uint32_t
+sepol_iomemcon_iter_get_mls_range_high_sens(const sepol_iomemcon_iter_t *iter);
+extern int
+sepol_iomemcon_iter_get_mls_range_low_cat(const sepol_iomemcon_iter_t *iter,
+					  sepol_cat_set_iter_t **cat_iter);
+extern int
+sepol_iomemcon_iter_get_mls_range_high_cat(const sepol_iomemcon_iter_t *iter,
+					   sepol_cat_set_iter_t **cat_iter);
+
+/* Xen ioportcon iterator */
+
+typedef struct sepol_ioportcon_iter sepol_ioportcon_iter_t;
+
+extern int sepol_ioportcon_iter_create(sepol_handle_t *handle,
+				       const sepol_policydb_t *p,
+				       sepol_ioportcon_iter_t **iter);
+
+extern void sepol_ioportcon_iter_destroy(sepol_ioportcon_iter_t *iter);
+
+/* has_next is set to 0 once iteration is exhausted; low_ioport/
+ * high_ioport cannot be used to detect end-of-iteration since 0 is
+ * a valid address value. */
+extern int sepol_ioportcon_iter_next(sepol_handle_t *handle,
+				     sepol_ioportcon_iter_t *iter,
+				     uint32_t *low_ioport,
+				     uint32_t *high_ioport, int *has_next);
+
+extern uint32_t
+sepol_ioportcon_iter_get_context_user(const sepol_ioportcon_iter_t *iter);
+extern uint32_t
+sepol_ioportcon_iter_get_context_role(const sepol_ioportcon_iter_t *iter);
+extern uint32_t
+sepol_ioportcon_iter_get_context_type(const sepol_ioportcon_iter_t *iter);
+extern uint32_t
+sepol_ioportcon_iter_get_mls_range_low_sens(const sepol_ioportcon_iter_t *iter);
+extern uint32_t sepol_ioportcon_iter_get_mls_range_high_sens(
+	const sepol_ioportcon_iter_t *iter);
+extern int
+sepol_ioportcon_iter_get_mls_range_low_cat(const sepol_ioportcon_iter_t *iter,
+					   sepol_cat_set_iter_t **cat_iter);
+extern int
+sepol_ioportcon_iter_get_mls_range_high_cat(const sepol_ioportcon_iter_t *iter,
+					    sepol_cat_set_iter_t **cat_iter);
+
+/* Xen pcidevicecon iterator */
+
+typedef struct sepol_pcidevicecon_iter sepol_pcidevicecon_iter_t;
+
+extern int sepol_pcidevicecon_iter_create(sepol_handle_t *handle,
+					  const sepol_policydb_t *p,
+					  sepol_pcidevicecon_iter_t **iter);
+
+extern void sepol_pcidevicecon_iter_destroy(sepol_pcidevicecon_iter_t *iter);
+
+/* has_next is set to 0 once iteration is exhausted; device cannot
+ * be used to detect end-of-iteration since 0 is a valid device
+ * value. */
+extern int sepol_pcidevicecon_iter_next(sepol_handle_t *handle,
+					sepol_pcidevicecon_iter_t *iter,
+					uint32_t *device, int *has_next);
+
+extern uint32_t
+sepol_pcidevicecon_iter_get_context_user(const sepol_pcidevicecon_iter_t *iter);
+extern uint32_t
+sepol_pcidevicecon_iter_get_context_role(const sepol_pcidevicecon_iter_t *iter);
+extern uint32_t
+sepol_pcidevicecon_iter_get_context_type(const sepol_pcidevicecon_iter_t *iter);
+extern uint32_t sepol_pcidevicecon_iter_get_mls_range_low_sens(
+	const sepol_pcidevicecon_iter_t *iter);
+extern uint32_t sepol_pcidevicecon_iter_get_mls_range_high_sens(
+	const sepol_pcidevicecon_iter_t *iter);
+extern int sepol_pcidevicecon_iter_get_mls_range_low_cat(
+	const sepol_pcidevicecon_iter_t *iter, sepol_cat_set_iter_t **cat_iter);
+extern int sepol_pcidevicecon_iter_get_mls_range_high_cat(
+	const sepol_pcidevicecon_iter_t *iter, sepol_cat_set_iter_t **cat_iter);
+
+/* Xen devicetreecon iterator */
+
+typedef struct sepol_devicetreecon_iter sepol_devicetreecon_iter_t;
+
+extern int sepol_devicetreecon_iter_create(sepol_handle_t *handle,
+					   const sepol_policydb_t *p,
+					   sepol_devicetreecon_iter_t **iter);
+
+extern void sepol_devicetreecon_iter_destroy(sepol_devicetreecon_iter_t *iter);
+
+extern int sepol_devicetreecon_iter_next(sepol_handle_t *handle,
+					 sepol_devicetreecon_iter_t *iter,
+					 const char **path);
+
+extern uint32_t sepol_devicetreecon_iter_get_context_user(
+	const sepol_devicetreecon_iter_t *iter);
+extern uint32_t sepol_devicetreecon_iter_get_context_role(
+	const sepol_devicetreecon_iter_t *iter);
+extern uint32_t sepol_devicetreecon_iter_get_context_type(
+	const sepol_devicetreecon_iter_t *iter);
+extern uint32_t sepol_devicetreecon_iter_get_mls_range_low_sens(
+	const sepol_devicetreecon_iter_t *iter);
+extern uint32_t sepol_devicetreecon_iter_get_mls_range_high_sens(
+	const sepol_devicetreecon_iter_t *iter);
+extern int sepol_devicetreecon_iter_get_mls_range_low_cat(
+	const sepol_devicetreecon_iter_t *iter,
+	sepol_cat_set_iter_t **cat_iter);
+extern int sepol_devicetreecon_iter_get_mls_range_high_cat(
+	const sepol_devicetreecon_iter_t *iter,
+	sepol_cat_set_iter_t **cat_iter);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/libsepol/src/initial_sids.h b/libsepol/src/initial_sids.h
new file mode 100644
index 00000000..dfab9907
--- /dev/null
+++ b/libsepol/src/initial_sids.h
@@ -0,0 +1,29 @@
+#ifndef _SEPOL_INITIAL_SIDS_H_
+#define _SEPOL_INITIAL_SIDS_H_
+
+/*
+ * Initial SID (isid) name tables, indexed by SID value. Initial SID names
+ * aren't actually stored in the binary/pp policy files, so callers that
+ * need to print or look up an initial SID by name (kernel_to_common.c's
+ * CIL/conf writers, and the sepol_isid_iter_t public API in ocontext.c)
+ * share this single mapping, taken from the Linux kernel.
+ */
+static const char *const selinux_sid_to_str[] = {
+	NULL,	"kernel", "security",	"unlabeled", NULL,    "file",
+	NULL,	"init",	  "any_socket", "port",	     "netif", "netmsg",
+	"node", NULL,	  NULL,		NULL,	     NULL,    NULL,
+	NULL,	NULL,	  NULL,		NULL,	     NULL,    NULL,
+	NULL,	NULL,	  NULL,		"devnull",
+};
+
+#define SELINUX_SID_SZ \
+	(sizeof(selinux_sid_to_str) / sizeof(selinux_sid_to_str[0]))
+
+static const char *const xen_sid_to_str[] = {
+	"null",	  "xen",   "dom0", "domio",  "domxen", "unlabeled", "security",
+	"ioport", "iomem", "irq",  "device", "domU",   "domDM",
+};
+
+#define XEN_SID_SZ (sizeof(xen_sid_to_str) / sizeof(xen_sid_to_str[0]))
+
+#endif /* _SEPOL_INITIAL_SIDS_H_ */
diff --git a/libsepol/src/kernel_to_common.h b/libsepol/src/kernel_to_common.h
index f319ea50..5adf9d75 100644
--- a/libsepol/src/kernel_to_common.h
+++ b/libsepol/src/kernel_to_common.h
@@ -12,30 +12,12 @@
 #include <sepol/policydb/avtab.h>
 #include <sepol/policydb/policydb.h>
 
+#include "initial_sids.h"
+
 #define STACK_SIZE 16
 #define DEFAULT_LEVEL "systemlow"
 #define DEFAULT_OBJECT "object_r"
 
-// initial sid names aren't actually stored in the pp files, need to a have
-// a mapping, taken from the linux kernel
-static const char *const selinux_sid_to_str[] = {
-	NULL,	"kernel", "security",	"unlabeled", NULL,    "file",
-	NULL,	"init",	  "any_socket", "port",	     "netif", "netmsg",
-	"node", NULL,	  NULL,		NULL,	     NULL,    NULL,
-	NULL,	NULL,	  NULL,		NULL,	     NULL,    NULL,
-	NULL,	NULL,	  NULL,		"devnull",
-};
-
-#define SELINUX_SID_SZ \
-	(sizeof(selinux_sid_to_str) / sizeof(selinux_sid_to_str[0]))
-
-static const char *const xen_sid_to_str[] = {
-	"null",	  "xen",   "dom0", "domio",  "domxen", "unlabeled", "security",
-	"ioport", "iomem", "irq",  "device", "domU",   "domDM",
-};
-
-#define XEN_SID_SZ (sizeof(xen_sid_to_str) / sizeof(xen_sid_to_str[0]))
-
 static const uint32_t avtab_flavors[] = {
 	AVTAB_ALLOWED,
 	AVTAB_AUDITALLOW,
diff --git a/libsepol/src/ocontext.c b/libsepol/src/ocontext.c
new file mode 100644
index 00000000..b3b5ccab
--- /dev/null
+++ b/libsepol/src/ocontext.c
@@ -0,0 +1,1058 @@
+#include <sepol/ocontext.h>
+
+#include <sepol/policydb/context.h>
+#include <sepol/policydb/policydb.h>
+#include <stdlib.h>
+
+#include "cat_set_internal.h"
+#include "debug.h"
+#include "initial_sids.h"
+
+/*
+ * Macro to stamp out the seven standard context accessor functions for
+ * an ocontext iterator.  Each ocontext node carries context[0] (and
+ * context[1] for the netifcon message context).  The generated functions
+ * return user/role/type values, MLS sensitivity values, and category-set
+ * iterators from the context at index CTX_IDX of the most recently
+ * yielded ocontext node (iter->last).
+ *
+ * FN_PREFIX is pasted before _context_user, _context_role, etc.
+ * Example: FN_PREFIX = sepol_isid_iter_get
+ *      =>  sepol_isid_iter_get_context_user, ...
+ */
+#define DEFINE_OCON_CONTEXT_GETTERS(FN_PREFIX, ITER_TYPE, CTX_IDX)          \
+                                                                            \
+	uint32_t FN_PREFIX##_context_user(const ITER_TYPE *iter)            \
+	{                                                                   \
+		if (!iter || !iter->last)                                   \
+			return 0;                                           \
+		return iter->last->context[CTX_IDX].user;                   \
+	}                                                                   \
+                                                                            \
+	uint32_t FN_PREFIX##_context_role(const ITER_TYPE *iter)            \
+	{                                                                   \
+		if (!iter || !iter->last)                                   \
+			return 0;                                           \
+		return iter->last->context[CTX_IDX].role;                   \
+	}                                                                   \
+                                                                            \
+	uint32_t FN_PREFIX##_context_type(const ITER_TYPE *iter)            \
+	{                                                                   \
+		if (!iter || !iter->last)                                   \
+			return 0;                                           \
+		return iter->last->context[CTX_IDX].type;                   \
+	}                                                                   \
+                                                                            \
+	uint32_t FN_PREFIX##_mls_range_low_sens(const ITER_TYPE *iter)      \
+	{                                                                   \
+		if (!iter || !iter->last)                                   \
+			return 0;                                           \
+		return iter->last->context[CTX_IDX].range.level[0].sens;    \
+	}                                                                   \
+                                                                            \
+	uint32_t FN_PREFIX##_mls_range_high_sens(const ITER_TYPE *iter)     \
+	{                                                                   \
+		if (!iter || !iter->last)                                   \
+			return 0;                                           \
+		return iter->last->context[CTX_IDX].range.level[1].sens;    \
+	}                                                                   \
+                                                                            \
+	int FN_PREFIX##_mls_range_low_cat(const ITER_TYPE *iter,            \
+					  sepol_cat_set_iter_t **cat_iter)  \
+	{                                                                   \
+		if (!cat_iter)                                              \
+			return STATUS_ERR;                                  \
+		if (!iter || !iter->last) {                                 \
+			*cat_iter = NULL;                                   \
+			return STATUS_SUCCESS;                              \
+		}                                                           \
+		return cat_set_iter_create_from_ebitmap(                    \
+			&iter->last->context[CTX_IDX].range.level[0].cat,   \
+			cat_iter);                                          \
+	}                                                                   \
+                                                                            \
+	int FN_PREFIX##_mls_range_high_cat(const ITER_TYPE *iter,           \
+					   sepol_cat_set_iter_t **cat_iter) \
+	{                                                                   \
+		if (!cat_iter)                                              \
+			return STATUS_ERR;                                  \
+		if (!iter || !iter->last) {                                 \
+			*cat_iter = NULL;                                   \
+			return STATUS_SUCCESS;                              \
+		}                                                           \
+		return cat_set_iter_create_from_ebitmap(                    \
+			&iter->last->context[CTX_IDX].range.level[1].cat,   \
+			cat_iter);                                          \
+	}
+
+/* ---- Initial SID iterator ---- */
+
+struct sepol_isid_iter {
+	const ocontext_t *cur;
+	const ocontext_t *last;
+	int target_platform;
+};
+
+int sepol_isid_iter_create(sepol_handle_t *handle, const sepol_policydb_t *p,
+			   sepol_isid_iter_t **iter)
+{
+	if (!iter)
+		return STATUS_ERR;
+	if (!handle || !p) {
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_isid_iter_t *tmp = malloc(sizeof(*tmp));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	tmp->cur = p->p.ocontexts[OCON_ISID];
+	tmp->last = NULL;
+	tmp->target_platform = p->p.target_platform;
+
+	*iter = tmp;
+	return STATUS_SUCCESS;
+}
+
+void sepol_isid_iter_destroy(sepol_isid_iter_t *iter)
+{
+	free(iter);
+}
+
+int sepol_isid_iter_next(sepol_handle_t *handle __attribute__((unused)),
+			 sepol_isid_iter_t *iter, uint32_t *sid)
+{
+	if (!iter || !sid)
+		return STATUS_ERR;
+
+	if (!iter->cur) {
+		iter->last = NULL;
+		*sid = 0;
+		return STATUS_SUCCESS;
+	}
+
+	iter->last = iter->cur;
+	*sid = iter->cur->sid[0];
+	iter->cur = iter->cur->next;
+
+	return STATUS_SUCCESS;
+}
+
+DEFINE_OCON_CONTEXT_GETTERS(sepol_isid_iter_get, sepol_isid_iter_t, 0)
+
+const char *sepol_isid_iter_get_name(const sepol_isid_iter_t *iter)
+{
+	uint32_t sid;
+
+	if (!iter || !iter->last)
+		return NULL;
+
+	sid = iter->last->sid[0];
+
+	if (iter->target_platform == SEPOL_TARGET_XEN) {
+		if (sid < XEN_SID_SZ)
+			return xen_sid_to_str[sid];
+		return NULL;
+	}
+
+	if (sid < SELINUX_SID_SZ)
+		return selinux_sid_to_str[sid];
+	return NULL;
+}
+
+/* ---- fs_use iterator ---- */
+
+struct sepol_fsuse_iter {
+	const ocontext_t *cur;
+	const ocontext_t *last;
+};
+
+int sepol_fsuse_iter_create(sepol_handle_t *handle, const sepol_policydb_t *p,
+			    sepol_fsuse_iter_t **iter)
+{
+	if (!iter)
+		return STATUS_ERR;
+	if (!handle || !p) {
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	if (p->p.target_platform == SEPOL_TARGET_XEN) {
+		ERR(handle, "fsuse requires a SELinux policy");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_fsuse_iter_t *tmp = malloc(sizeof(*tmp));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	tmp->cur = p->p.ocontexts[OCON_FSUSE];
+	tmp->last = NULL;
+
+	*iter = tmp;
+	return STATUS_SUCCESS;
+}
+
+void sepol_fsuse_iter_destroy(sepol_fsuse_iter_t *iter)
+{
+	free(iter);
+}
+
+int sepol_fsuse_iter_next(sepol_handle_t *handle __attribute__((unused)),
+			  sepol_fsuse_iter_t *iter, const char **name,
+			  uint32_t *behavior)
+{
+	if (!iter || !name || !behavior)
+		return STATUS_ERR;
+
+	if (!iter->cur) {
+		iter->last = NULL;
+		*name = NULL;
+		*behavior = 0;
+		return STATUS_SUCCESS;
+	}
+
+	iter->last = iter->cur;
+	*name = iter->cur->u.name;
+	*behavior = iter->cur->v.behavior;
+	iter->cur = iter->cur->next;
+
+	return STATUS_SUCCESS;
+}
+
+DEFINE_OCON_CONTEXT_GETTERS(sepol_fsuse_iter_get, sepol_fsuse_iter_t, 0)
+
+/* ---- genfscon iterator ---- */
+
+struct sepol_genfscon_iter {
+	const genfs_t *cur_genfs;
+	const ocontext_t *cur_ocon;
+	const ocontext_t *last;
+};
+
+int sepol_genfscon_iter_create(sepol_handle_t *handle,
+			       const sepol_policydb_t *p,
+			       sepol_genfscon_iter_t **iter)
+{
+	if (!iter)
+		return STATUS_ERR;
+	if (!handle || !p) {
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_genfscon_iter_t *tmp = malloc(sizeof(*tmp));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	tmp->cur_genfs = p->p.genfs;
+	while (tmp->cur_genfs && !tmp->cur_genfs->head)
+		tmp->cur_genfs = tmp->cur_genfs->next;
+	tmp->cur_ocon = tmp->cur_genfs ? tmp->cur_genfs->head : NULL;
+	tmp->last = NULL;
+
+	*iter = tmp;
+	return STATUS_SUCCESS;
+}
+
+void sepol_genfscon_iter_destroy(sepol_genfscon_iter_t *iter)
+{
+	free(iter);
+}
+
+int sepol_genfscon_iter_next(sepol_handle_t *handle __attribute__((unused)),
+			     sepol_genfscon_iter_t *iter, const char **fstype,
+			     const char **path, uint32_t *sclass)
+{
+	if (!iter || !fstype || !path || !sclass)
+		return STATUS_ERR;
+
+	if (!iter->cur_ocon) {
+		iter->last = NULL;
+		*fstype = NULL;
+		*path = NULL;
+		*sclass = 0;
+		return STATUS_SUCCESS;
+	}
+
+	iter->last = iter->cur_ocon;
+	*fstype = iter->cur_genfs->fstype;
+	*path = iter->cur_ocon->u.name;
+	*sclass = iter->cur_ocon->v.sclass;
+
+	iter->cur_ocon = iter->cur_ocon->next;
+	if (!iter->cur_ocon) {
+		iter->cur_genfs = iter->cur_genfs->next;
+		while (iter->cur_genfs && !iter->cur_genfs->head)
+			iter->cur_genfs = iter->cur_genfs->next;
+		if (iter->cur_genfs)
+			iter->cur_ocon = iter->cur_genfs->head;
+	}
+
+	return STATUS_SUCCESS;
+}
+
+DEFINE_OCON_CONTEXT_GETTERS(sepol_genfscon_iter_get, sepol_genfscon_iter_t, 0)
+
+/* ---- Xen pirqcon iterator ---- */
+
+struct sepol_pirqcon_iter {
+	const ocontext_t *cur;
+	const ocontext_t *last;
+};
+
+int sepol_pirqcon_iter_create(sepol_handle_t *handle, const sepol_policydb_t *p,
+			      sepol_pirqcon_iter_t **iter)
+{
+	if (!iter)
+		return STATUS_ERR;
+	if (!handle || !p) {
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	if (p->p.target_platform != SEPOL_TARGET_XEN) {
+		ERR(handle, "pirqcon requires a Xen policy");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_pirqcon_iter_t *tmp = malloc(sizeof(*tmp));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	tmp->cur = p->p.ocontexts[OCON_XEN_PIRQ];
+	tmp->last = NULL;
+
+	*iter = tmp;
+	return STATUS_SUCCESS;
+}
+
+void sepol_pirqcon_iter_destroy(sepol_pirqcon_iter_t *iter)
+{
+	free(iter);
+}
+
+int sepol_pirqcon_iter_next(sepol_handle_t *handle __attribute__((unused)),
+			    sepol_pirqcon_iter_t *iter, uint32_t *irq,
+			    int *has_next)
+{
+	if (!iter || !irq || !has_next)
+		return STATUS_ERR;
+
+	if (!iter->cur) {
+		iter->last = NULL;
+		*irq = 0;
+		*has_next = 0;
+		return STATUS_SUCCESS;
+	}
+
+	iter->last = iter->cur;
+	*irq = iter->cur->u.pirq;
+	iter->cur = iter->cur->next;
+	*has_next = 1;
+
+	return STATUS_SUCCESS;
+}
+
+DEFINE_OCON_CONTEXT_GETTERS(sepol_pirqcon_iter_get, sepol_pirqcon_iter_t, 0)
+
+/* ---- Xen iomemcon iterator ---- */
+
+struct sepol_iomemcon_iter {
+	const ocontext_t *cur;
+	const ocontext_t *last;
+};
+
+int sepol_iomemcon_iter_create(sepol_handle_t *handle,
+			       const sepol_policydb_t *p,
+			       sepol_iomemcon_iter_t **iter)
+{
+	if (!iter)
+		return STATUS_ERR;
+	if (!handle || !p) {
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	if (p->p.target_platform != SEPOL_TARGET_XEN) {
+		ERR(handle, "iomemcon requires a Xen policy");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_iomemcon_iter_t *tmp = malloc(sizeof(*tmp));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	tmp->cur = p->p.ocontexts[OCON_XEN_IOMEM];
+	tmp->last = NULL;
+
+	*iter = tmp;
+	return STATUS_SUCCESS;
+}
+
+void sepol_iomemcon_iter_destroy(sepol_iomemcon_iter_t *iter)
+{
+	free(iter);
+}
+
+int sepol_iomemcon_iter_next(sepol_handle_t *handle __attribute__((unused)),
+			     sepol_iomemcon_iter_t *iter, uint64_t *low_iomem,
+			     uint64_t *high_iomem, int *has_next)
+{
+	if (!iter || !low_iomem || !high_iomem || !has_next)
+		return STATUS_ERR;
+
+	if (!iter->cur) {
+		iter->last = NULL;
+		*low_iomem = 0;
+		*high_iomem = 0;
+		*has_next = 0;
+		return STATUS_SUCCESS;
+	}
+
+	iter->last = iter->cur;
+	*low_iomem = iter->cur->u.iomem.low_iomem;
+	*high_iomem = iter->cur->u.iomem.high_iomem;
+	iter->cur = iter->cur->next;
+	*has_next = 1;
+
+	return STATUS_SUCCESS;
+}
+
+DEFINE_OCON_CONTEXT_GETTERS(sepol_iomemcon_iter_get, sepol_iomemcon_iter_t, 0)
+
+/* ---- Xen ioportcon iterator ---- */
+
+struct sepol_ioportcon_iter {
+	const ocontext_t *cur;
+	const ocontext_t *last;
+};
+
+int sepol_ioportcon_iter_create(sepol_handle_t *handle,
+				const sepol_policydb_t *p,
+				sepol_ioportcon_iter_t **iter)
+{
+	if (!iter)
+		return STATUS_ERR;
+	if (!handle || !p) {
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	if (p->p.target_platform != SEPOL_TARGET_XEN) {
+		ERR(handle, "ioportcon requires a Xen policy");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_ioportcon_iter_t *tmp = malloc(sizeof(*tmp));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	tmp->cur = p->p.ocontexts[OCON_XEN_IOPORT];
+	tmp->last = NULL;
+
+	*iter = tmp;
+	return STATUS_SUCCESS;
+}
+
+void sepol_ioportcon_iter_destroy(sepol_ioportcon_iter_t *iter)
+{
+	free(iter);
+}
+
+int sepol_ioportcon_iter_next(sepol_handle_t *handle __attribute__((unused)),
+			      sepol_ioportcon_iter_t *iter,
+			      uint32_t *low_ioport, uint32_t *high_ioport,
+			      int *has_next)
+{
+	if (!iter || !low_ioport || !high_ioport || !has_next)
+		return STATUS_ERR;
+
+	if (!iter->cur) {
+		iter->last = NULL;
+		*low_ioport = 0;
+		*high_ioport = 0;
+		*has_next = 0;
+		return STATUS_SUCCESS;
+	}
+
+	iter->last = iter->cur;
+	*low_ioport = iter->cur->u.ioport.low_ioport;
+	*high_ioport = iter->cur->u.ioport.high_ioport;
+	iter->cur = iter->cur->next;
+	*has_next = 1;
+
+	return STATUS_SUCCESS;
+}
+
+DEFINE_OCON_CONTEXT_GETTERS(sepol_ioportcon_iter_get, sepol_ioportcon_iter_t, 0)
+
+/* ---- Xen pcidevicecon iterator ---- */
+
+struct sepol_pcidevicecon_iter {
+	const ocontext_t *cur;
+	const ocontext_t *last;
+};
+
+int sepol_pcidevicecon_iter_create(sepol_handle_t *handle,
+				   const sepol_policydb_t *p,
+				   sepol_pcidevicecon_iter_t **iter)
+{
+	if (!iter)
+		return STATUS_ERR;
+	if (!handle || !p) {
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	if (p->p.target_platform != SEPOL_TARGET_XEN) {
+		ERR(handle, "pcidevicecon requires a Xen policy");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_pcidevicecon_iter_t *tmp = malloc(sizeof(*tmp));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	tmp->cur = p->p.ocontexts[OCON_XEN_PCIDEVICE];
+	tmp->last = NULL;
+
+	*iter = tmp;
+	return STATUS_SUCCESS;
+}
+
+void sepol_pcidevicecon_iter_destroy(sepol_pcidevicecon_iter_t *iter)
+{
+	free(iter);
+}
+
+int sepol_pcidevicecon_iter_next(sepol_handle_t *handle __attribute__((unused)),
+				 sepol_pcidevicecon_iter_t *iter,
+				 uint32_t *device, int *has_next)
+{
+	if (!iter || !device || !has_next)
+		return STATUS_ERR;
+
+	if (!iter->cur) {
+		iter->last = NULL;
+		*device = 0;
+		*has_next = 0;
+		return STATUS_SUCCESS;
+	}
+
+	iter->last = iter->cur;
+	*device = iter->cur->u.device;
+	iter->cur = iter->cur->next;
+	*has_next = 1;
+
+	return STATUS_SUCCESS;
+}
+
+DEFINE_OCON_CONTEXT_GETTERS(sepol_pcidevicecon_iter_get,
+			    sepol_pcidevicecon_iter_t, 0)
+
+/* ---- Xen devicetreecon iterator ---- */
+
+struct sepol_devicetreecon_iter {
+	const ocontext_t *cur;
+	const ocontext_t *last;
+};
+
+int sepol_devicetreecon_iter_create(sepol_handle_t *handle,
+				    const sepol_policydb_t *p,
+				    sepol_devicetreecon_iter_t **iter)
+{
+	if (!iter)
+		return STATUS_ERR;
+	if (!handle || !p) {
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	if (p->p.target_platform != SEPOL_TARGET_XEN) {
+		ERR(handle, "devicetreecon requires a Xen policy");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_devicetreecon_iter_t *tmp = malloc(sizeof(*tmp));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	tmp->cur = p->p.ocontexts[OCON_XEN_DEVICETREE];
+	tmp->last = NULL;
+
+	*iter = tmp;
+	return STATUS_SUCCESS;
+}
+
+void sepol_devicetreecon_iter_destroy(sepol_devicetreecon_iter_t *iter)
+{
+	free(iter);
+}
+
+int sepol_devicetreecon_iter_next(sepol_handle_t *handle
+				  __attribute__((unused)),
+				  sepol_devicetreecon_iter_t *iter,
+				  const char **path)
+{
+	if (!iter || !path)
+		return STATUS_ERR;
+
+	if (!iter->cur) {
+		iter->last = NULL;
+		*path = NULL;
+		return STATUS_SUCCESS;
+	}
+
+	iter->last = iter->cur;
+	*path = iter->cur->u.name;
+	iter->cur = iter->cur->next;
+
+	return STATUS_SUCCESS;
+}
+
+DEFINE_OCON_CONTEXT_GETTERS(sepol_devicetreecon_iter_get,
+			    sepol_devicetreecon_iter_t, 0)
+
+/* ---- portcon iterator ---- */
+
+struct sepol_portcon_iter {
+	const ocontext_t *cur;
+	const ocontext_t *last;
+};
+
+int sepol_portcon_iter_create(sepol_handle_t *handle, const sepol_policydb_t *p,
+			      sepol_portcon_iter_t **iter)
+{
+	if (!iter)
+		return STATUS_ERR;
+	if (!handle || !p) {
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	if (p->p.target_platform == SEPOL_TARGET_XEN) {
+		ERR(handle, "portcon requires a SELinux policy");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_portcon_iter_t *tmp = malloc(sizeof(*tmp));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	tmp->cur = p->p.ocontexts[OCON_PORT];
+	tmp->last = NULL;
+
+	*iter = tmp;
+	return STATUS_SUCCESS;
+}
+
+void sepol_portcon_iter_destroy(sepol_portcon_iter_t *iter)
+{
+	free(iter);
+}
+
+int sepol_portcon_iter_next(sepol_handle_t *handle __attribute__((unused)),
+			    sepol_portcon_iter_t *iter, uint8_t *protocol,
+			    uint16_t *low_port, uint16_t *high_port,
+			    int *has_next)
+{
+	if (!iter || !protocol || !low_port || !high_port || !has_next)
+		return STATUS_ERR;
+
+	if (!iter->cur) {
+		iter->last = NULL;
+		*protocol = 0;
+		*low_port = 0;
+		*high_port = 0;
+		*has_next = 0;
+		return STATUS_SUCCESS;
+	}
+
+	iter->last = iter->cur;
+	*protocol = iter->cur->u.port.protocol;
+	*low_port = iter->cur->u.port.low_port;
+	*high_port = iter->cur->u.port.high_port;
+	iter->cur = iter->cur->next;
+	*has_next = 1;
+
+	return STATUS_SUCCESS;
+}
+
+DEFINE_OCON_CONTEXT_GETTERS(sepol_portcon_iter_get, sepol_portcon_iter_t, 0)
+
+/* ---- netifcon iterator ---- */
+
+struct sepol_netifcon_iter {
+	const ocontext_t *cur;
+	const ocontext_t *last;
+};
+
+int sepol_netifcon_iter_create(sepol_handle_t *handle,
+			       const sepol_policydb_t *p,
+			       sepol_netifcon_iter_t **iter)
+{
+	if (!iter)
+		return STATUS_ERR;
+	if (!handle || !p) {
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	if (p->p.target_platform == SEPOL_TARGET_XEN) {
+		ERR(handle, "netifcon requires a SELinux policy");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_netifcon_iter_t *tmp = malloc(sizeof(*tmp));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	tmp->cur = p->p.ocontexts[OCON_NETIF];
+	tmp->last = NULL;
+
+	*iter = tmp;
+	return STATUS_SUCCESS;
+}
+
+void sepol_netifcon_iter_destroy(sepol_netifcon_iter_t *iter)
+{
+	free(iter);
+}
+
+int sepol_netifcon_iter_next(sepol_handle_t *handle __attribute__((unused)),
+			     sepol_netifcon_iter_t *iter, const char **name)
+{
+	if (!iter || !name)
+		return STATUS_ERR;
+
+	if (!iter->cur) {
+		iter->last = NULL;
+		*name = NULL;
+		return STATUS_SUCCESS;
+	}
+
+	iter->last = iter->cur;
+	*name = iter->cur->u.name;
+	iter->cur = iter->cur->next;
+
+	return STATUS_SUCCESS;
+}
+
+DEFINE_OCON_CONTEXT_GETTERS(sepol_netifcon_iter_get, sepol_netifcon_iter_t, 0)
+DEFINE_OCON_CONTEXT_GETTERS(sepol_netifcon_iter_get_msg, sepol_netifcon_iter_t,
+			    1)
+
+/* ---- nodecon IPv4 iterator ---- */
+
+struct sepol_nodecon_iter {
+	const ocontext_t *cur;
+	const ocontext_t *last;
+};
+
+int sepol_nodecon_iter_create(sepol_handle_t *handle, const sepol_policydb_t *p,
+			      sepol_nodecon_iter_t **iter)
+{
+	if (!iter)
+		return STATUS_ERR;
+	if (!handle || !p) {
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	if (p->p.target_platform == SEPOL_TARGET_XEN) {
+		ERR(handle, "nodecon requires a SELinux policy");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_nodecon_iter_t *tmp = malloc(sizeof(*tmp));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	tmp->cur = p->p.ocontexts[OCON_NODE];
+	tmp->last = NULL;
+
+	*iter = tmp;
+	return STATUS_SUCCESS;
+}
+
+void sepol_nodecon_iter_destroy(sepol_nodecon_iter_t *iter)
+{
+	free(iter);
+}
+
+int sepol_nodecon_iter_next(sepol_handle_t *handle __attribute__((unused)),
+			    sepol_nodecon_iter_t *iter, uint32_t *addr,
+			    uint32_t *mask, int *has_next)
+{
+	if (!iter || !addr || !mask || !has_next)
+		return STATUS_ERR;
+
+	if (!iter->cur) {
+		iter->last = NULL;
+		*addr = 0;
+		*mask = 0;
+		*has_next = 0;
+		return STATUS_SUCCESS;
+	}
+
+	iter->last = iter->cur;
+	*addr = iter->cur->u.node.addr;
+	*mask = iter->cur->u.node.mask;
+	iter->cur = iter->cur->next;
+	*has_next = 1;
+
+	return STATUS_SUCCESS;
+}
+
+DEFINE_OCON_CONTEXT_GETTERS(sepol_nodecon_iter_get, sepol_nodecon_iter_t, 0)
+
+/* ---- nodecon6 IPv6 iterator ---- */
+
+struct sepol_nodecon6_iter {
+	const ocontext_t *cur;
+	const ocontext_t *last;
+};
+
+int sepol_nodecon6_iter_create(sepol_handle_t *handle,
+			       const sepol_policydb_t *p,
+			       sepol_nodecon6_iter_t **iter)
+{
+	if (!iter)
+		return STATUS_ERR;
+	if (!handle || !p) {
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	if (p->p.target_platform == SEPOL_TARGET_XEN) {
+		ERR(handle, "nodecon6 requires a SELinux policy");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_nodecon6_iter_t *tmp = malloc(sizeof(*tmp));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	tmp->cur = p->p.ocontexts[OCON_NODE6];
+	tmp->last = NULL;
+
+	*iter = tmp;
+	return STATUS_SUCCESS;
+}
+
+void sepol_nodecon6_iter_destroy(sepol_nodecon6_iter_t *iter)
+{
+	free(iter);
+}
+
+int sepol_nodecon6_iter_next(sepol_handle_t *handle __attribute__((unused)),
+			     sepol_nodecon6_iter_t *iter, const uint32_t **addr,
+			     const uint32_t **mask)
+{
+	if (!iter || !addr || !mask)
+		return STATUS_ERR;
+
+	if (!iter->cur) {
+		iter->last = NULL;
+		*addr = NULL;
+		*mask = NULL;
+		return STATUS_SUCCESS;
+	}
+
+	iter->last = iter->cur;
+	*addr = iter->cur->u.node6.addr;
+	*mask = iter->cur->u.node6.mask;
+	iter->cur = iter->cur->next;
+
+	return STATUS_SUCCESS;
+}
+
+DEFINE_OCON_CONTEXT_GETTERS(sepol_nodecon6_iter_get, sepol_nodecon6_iter_t, 0)
+
+/* ---- ibpkeycon iterator ---- */
+
+struct sepol_ibpkeycon_iter {
+	const ocontext_t *cur;
+	const ocontext_t *last;
+};
+
+int sepol_ibpkeycon_iter_create(sepol_handle_t *handle,
+				const sepol_policydb_t *p,
+				sepol_ibpkeycon_iter_t **iter)
+{
+	if (!iter)
+		return STATUS_ERR;
+	if (!handle || !p) {
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	if (p->p.target_platform == SEPOL_TARGET_XEN) {
+		ERR(handle, "ibpkeycon requires a SELinux policy");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_ibpkeycon_iter_t *tmp = malloc(sizeof(*tmp));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	tmp->cur = p->p.ocontexts[OCON_IBPKEY];
+	tmp->last = NULL;
+
+	*iter = tmp;
+	return STATUS_SUCCESS;
+}
+
+void sepol_ibpkeycon_iter_destroy(sepol_ibpkeycon_iter_t *iter)
+{
+	free(iter);
+}
+
+int sepol_ibpkeycon_iter_next(sepol_handle_t *handle __attribute__((unused)),
+			      sepol_ibpkeycon_iter_t *iter,
+			      uint64_t *subnet_prefix, uint16_t *low_pkey,
+			      uint16_t *high_pkey, int *has_next)
+{
+	if (!iter || !subnet_prefix || !low_pkey || !high_pkey || !has_next)
+		return STATUS_ERR;
+
+	if (!iter->cur) {
+		iter->last = NULL;
+		*subnet_prefix = 0;
+		*low_pkey = 0;
+		*high_pkey = 0;
+		*has_next = 0;
+		return STATUS_SUCCESS;
+	}
+
+	iter->last = iter->cur;
+	*subnet_prefix = iter->cur->u.ibpkey.subnet_prefix;
+	*low_pkey = iter->cur->u.ibpkey.low_pkey;
+	*high_pkey = iter->cur->u.ibpkey.high_pkey;
+	iter->cur = iter->cur->next;
+	*has_next = 1;
+
+	return STATUS_SUCCESS;
+}
+
+DEFINE_OCON_CONTEXT_GETTERS(sepol_ibpkeycon_iter_get, sepol_ibpkeycon_iter_t, 0)
+
+/* ---- ibendportcon iterator ---- */
+
+struct sepol_ibendportcon_iter {
+	const ocontext_t *cur;
+	const ocontext_t *last;
+};
+
+int sepol_ibendportcon_iter_create(sepol_handle_t *handle,
+				   const sepol_policydb_t *p,
+				   sepol_ibendportcon_iter_t **iter)
+{
+	if (!iter)
+		return STATUS_ERR;
+	if (!handle || !p) {
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	if (p->p.target_platform == SEPOL_TARGET_XEN) {
+		ERR(handle, "ibendportcon requires a SELinux policy");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	sepol_ibendportcon_iter_t *tmp = malloc(sizeof(*tmp));
+	if (!tmp) {
+		ERR(handle, "out of memory");
+		*iter = NULL;
+		return STATUS_ERR;
+	}
+
+	tmp->cur = p->p.ocontexts[OCON_IBENDPORT];
+	tmp->last = NULL;
+
+	*iter = tmp;
+	return STATUS_SUCCESS;
+}
+
+void sepol_ibendportcon_iter_destroy(sepol_ibendportcon_iter_t *iter)
+{
+	free(iter);
+}
+
+int sepol_ibendportcon_iter_next(sepol_handle_t *handle __attribute__((unused)),
+				 sepol_ibendportcon_iter_t *iter,
+				 const char **dev_name, uint8_t *port)
+{
+	if (!iter || !dev_name || !port)
+		return STATUS_ERR;
+
+	if (!iter->cur) {
+		iter->last = NULL;
+		*dev_name = NULL;
+		*port = 0;
+		return STATUS_SUCCESS;
+	}
+
+	iter->last = iter->cur;
+	*dev_name = iter->cur->u.ibendport.dev_name;
+	*port = iter->cur->u.ibendport.port;
+	iter->cur = iter->cur->next;
+
+	return STATUS_SUCCESS;
+}
+
+DEFINE_OCON_CONTEXT_GETTERS(sepol_ibendportcon_iter_get,
+			    sepol_ibendportcon_iter_t, 0)
-- 
2.55.0

