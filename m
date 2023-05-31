Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABC0C7EE23
	for <selinux@archiver.kernel.org>; Wed, 31 May 2023 11:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjEaLcs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 May 2023 07:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbjEaLcr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 May 2023 07:32:47 -0400
Received: from sender11-of-o52.zoho.eu (sender11-of-o52.zoho.eu [31.186.226.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C411AD9
        for <selinux@vger.kernel.org>; Wed, 31 May 2023 04:32:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685532759; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=FtbCLt2HpMqnTdXWJdcf8uM01mIXEglozwUj7t2mLF/+Q3nwi3AzBJZTell/9QIpHBKGPPS170qDNtFT+N1uwjJ2z/vgyHzlze47Rm2EMIGuWFv+FQ5b0H+oIAjX+w5x7BPOO/inO3RLiE1HQG1uz7epCGZOoBEWIM76eiO7Uu0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1685532759; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=S0Rw2G6uUE+JDBv41Op8AYbpCmnktaHD6YPPMxxPOTQ=; 
        b=T46fP1qw/9XphDXxmjdfuIWv2SLV/B26OY9J/1ofRzOTlPPR9NKsOdnF6a7AJoxIbaueteigkZ93eZJqsbS9BU4dFzp/mlEkgj9RvHcBXp8npUPzCCv1wEGjv/TdQEGkfn5B0QNZdem6bh45ajDHgKisBS6+sKIA+fzXz437H9k=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=jurajmarcin.com;
        spf=pass  smtp.mailfrom=juraj@jurajmarcin.com;
        dmarc=pass header.from=<juraj@jurajmarcin.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1685532759;
        s=zoho; d=jurajmarcin.com; i=juraj@jurajmarcin.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=S0Rw2G6uUE+JDBv41Op8AYbpCmnktaHD6YPPMxxPOTQ=;
        b=P7rT6kwofFjql0pXoWZrhNQew0/lFv2aqijJiUuOdqJH/MGI+JWrky6FTRLhBoic
        3gj8sBp36ShYAsHnFIBK1bvrp5tpBpOd+UCJs6vwxj7pIrOH5adyXPYdenmn4zhcWm8
        ISBBnK59m8uQZcFo+cbCVyBHT3LXLM29jO1WVfE8=
Received: from morty01.jurajmarcin.com (129.159.244.31 [129.159.244.31]) by mx.zoho.eu
        with SMTPS id 1685532756354542.3961958356815; Wed, 31 May 2023 13:32:36 +0200 (CEST)
Received: from jmarcin-t14s-01.redhat.com (unknown [147.251.183.113])
        by morty01.jurajmarcin.com (Postfix) with ESMTPSA id B50C62081F76;
        Wed, 31 May 2023 11:32:35 +0000 (UTC)
From:   Juraj Marcin <juraj@jurajmarcin.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH 4/5] selinux: filename transitions move tests
Date:   Wed, 31 May 2023 13:29:27 +0200
Message-Id: <20230531112927.1957093-5-juraj@jurajmarcin.com>
In-Reply-To: <20230531112927.1957093-1-juraj@jurajmarcin.com>
References: <20230531112927.1957093-1-juraj@jurajmarcin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch adds a set of simple tests that test if the functions for
reading and writing filename transitions in avtab work properly.

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
---
 security/selinux/Kconfig         |  17 +
 security/selinux/Makefile        |   2 +
 security/selinux/ss/avtab.c      |  20 +
 security/selinux/ss/avtab_test.c | 729 +++++++++++++++++++++++++++++++
 security/selinux/ss/symtab.c     |   3 +
 5 files changed, 771 insertions(+)
 create mode 100644 security/selinux/ss/avtab_test.c

diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 95a186ec0fcb..78cdc8d4232d 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -68,3 +68,20 @@ config SECURITY_SELINUX_SID2STR_CACHE_SIZE
 	  conversion.  Setting this option to 0 disables the cache completely.
=20
 	  If unsure, keep the default value.
+
+config SECURITY_SELINUX_KUNIT_TEST
+	tristate "Tests for SELinux" if !KUNIT_ALL_TESTS
+	depends on KUNIT && SECURITY_SELINUX
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the SELinux KUnit tests.
+
+	  KUnit tests run during boot and output the results to the debug log
+	  in TAP format (https://testanything.org/). Only useful for kernel dev=
s
+	  running KUnit test harness and are not for inclusion into a
+	  production build.
+
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index ab8c3093d5fd..d3d63b28edcf 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -27,3 +27,5 @@ quiet_cmd_genhdrs =3D GEN     $(addprefix $(obj)/,$(gen=
hdrs))
 targets +=3D $(genhdrs)
 $(addprefix $(obj)/,$(genhdrs)) &: scripts/selinux/genheaders/genheaders=
 FORCE
 	$(call if_changed,genhdrs)
+
+obj-$(CONFIG_SECURITY_SELINUX_KUNIT_TEST) +=3D ss/avtab_test.o
diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 2cd9eabf796c..db7123670ef8 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -223,6 +223,9 @@ struct avtab_datum *avtab_search(struct avtab *h, con=
st struct avtab_key *key)
 	return NULL;
 }
=20
+/* Export for avtab KUnit tests */
+EXPORT_SYMBOL_GPL(avtab_search);
+
 /* This search function returns a node pointer, and can be used in
  * conjunction with avtab_search_next_node()
  */
@@ -331,6 +334,9 @@ void avtab_destroy(struct avtab *h)
 	h->mask =3D 0;
 }
=20
+/* Export for avtab KUnit tests */
+EXPORT_SYMBOL_GPL(avtab_destroy);
+
 void avtab_init(struct avtab *h)
 {
 	h->htable =3D NULL;
@@ -378,6 +384,9 @@ int avtab_alloc(struct avtab *h, u32 nrules)
 	return 0;
 }
=20
+/* Export for avtab KUnit tests */
+EXPORT_SYMBOL_GPL(avtab_alloc);
+
 int avtab_alloc_dup(struct avtab *new, const struct avtab *orig)
 {
 	return avtab_alloc_common(new, orig->nslot);
@@ -766,6 +775,9 @@ int avtab_read(struct avtab *a, void *fp, struct poli=
cydb *pol)
 	goto out;
 }
=20
+/* Export for avtab KUnit tests */
+EXPORT_SYMBOL_GPL(avtab_read);
+
 static int avtab_trans_write_helper(void *k, void *d, void *fp)
 {
 	char *name =3D k;
@@ -900,6 +912,9 @@ int avtab_write(struct policydb *p, struct avtab *a, =
void *fp)
 	return rc;
 }
=20
+/* Export for avtab KUnit tests */
+EXPORT_SYMBOL_GPL(avtab_write);
+
 void __init avtab_cache_init(void)
 {
 	avtab_node_cachep =3D kmem_cache_create("avtab_node",
@@ -1105,6 +1120,8 @@ int avtab_filename_trans_read(struct avtab *a, void=
 *fp, struct policydb *p)
 	return 0;
 }
=20
+/* Export for avtab KUnit tests */
+EXPORT_SYMBOL_GPL(avtab_filename_trans_read);
=20
 struct filenametr_write_args {
 	void *fp;
@@ -1406,3 +1423,6 @@ int avtab_filename_trans_write(struct policydb *p, =
struct avtab *a, void *fp)
=20
 	return rc;
 }
+
+/* Export for avtab KUnit tests */
+EXPORT_SYMBOL_GPL(avtab_filename_trans_write);
diff --git a/security/selinux/ss/avtab_test.c b/security/selinux/ss/avtab=
_test.c
new file mode 100644
index 000000000000..daa8e4cfaeb2
--- /dev/null
+++ b/security/selinux/ss/avtab_test.c
@@ -0,0 +1,729 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KUnit tests for access vector table type Implementation
+ *
+ * Author: Juraj Marcin <juraj@jurajmarcin.com>
+ */
+
+#include <kunit/test.h>
+#include "policydb.h"
+#include "security.h"
+#include "avtab.h"
+
+static void filename_trans_read__pre_filename_trans(struct kunit *test)
+{
+	struct policydb p =3D {
+		.te_avtab =3D {0},
+		.policyvers =3D POLICYDB_VERSION_FILENAME_TRANS - 1,
+	};
+	struct policy_file fp =3D {
+		.data =3D NULL,
+		.len =3D 0,
+	};
+
+	p.p_types.nprim =3D 54;
+	p.p_classes.nprim =3D 49;
+
+	KUNIT_EXPECT_EQ(test, 0,
+			avtab_filename_trans_read(&p.te_avtab, &fp, &p));
+	KUNIT_EXPECT_EQ(test, 0, p.te_avtab.nel);
+	KUNIT_EXPECT_EQ(test, 0, fp.len);
+}
+
+static void filename_trans_read__empty(struct kunit *test)
+{
+	char data[] =3D {0, 0, 0, 0};
+	struct policydb p =3D {
+		.te_avtab =3D {0},
+		.policyvers =3D POLICYDB_VERSION_FILENAME_TRANS,
+	};
+	struct policy_file fp =3D {
+		.data =3D data,
+		.len =3D sizeof(data),
+	};
+
+	p.p_types.nprim =3D 54;
+	p.p_classes.nprim =3D 49;
+
+	KUNIT_EXPECT_EQ(test, 0,
+			avtab_filename_trans_read(&p.te_avtab, &fp, &p));
+	KUNIT_EXPECT_EQ(test, 0, p.te_avtab.nel);
+	KUNIT_EXPECT_EQ(test, 0, fp.len);
+}
+
+static void filename_trans_read__comp_empty(struct kunit *test)
+{
+	char data[] =3D {0, 0, 0, 0};
+	struct policydb p =3D {
+		.te_avtab =3D {0},
+		.policyvers =3D POLICYDB_VERSION_COMP_FTRANS,
+	};
+	struct policy_file fp =3D {
+		.data =3D data,
+		.len =3D sizeof(data),
+	};
+
+	p.p_types.nprim =3D 54;
+	p.p_classes.nprim =3D 49;
+
+	KUNIT_EXPECT_EQ(test, 0,
+			avtab_filename_trans_read(&p.te_avtab, &fp, &p));
+	KUNIT_EXPECT_EQ(test, 0, p.te_avtab.nel);
+	KUNIT_EXPECT_EQ(test, 0, fp.len);
+}
+
+static void filename_trans_read__simple(struct kunit *test)
+{
+	char data[] =3D {
+		3, 0, 0, 0,	/* count */
+
+		5, 0, 0, 0,			/* entry 1 name len */
+		'f', 'i', 'l', 'e', '1',	/* entry 1 name */
+		42, 0, 0, 0,			/* entry 1 stype */
+		43, 0, 0, 0,			/* entry 1 ttype */
+		44, 0, 0, 0,			/* entry 1 tclass */
+		45, 0, 0, 0,			/* entry 1 otype */
+
+		5, 0, 0, 0,			/* entry 2 name len */
+		'f', 'i', 'l', 'e', '2',	/* entry 2 name */
+		46, 0, 0, 0,			/* entry 2 stype */
+		47, 0, 0, 0,			/* entry 2 ttype */
+		48, 0, 0, 0,			/* entry 2 tclass */
+		49, 0, 0, 0,			/* entry 2 otype */
+
+		5, 0, 0, 0,			/* entry 3 name len */
+		'f', 'i', 'l', 'e', '3',	/* entry 3 name */
+		46, 0, 0, 0,			/* entry 3 stype */
+		47, 0, 0, 0,			/* entry 3 ttype */
+		48, 0, 0, 0,			/* entry 3 tclass */
+		53, 0, 0, 0,			/* entry 3 otype */
+	};
+	struct policydb p =3D {
+		.te_avtab =3D {0},
+		.policyvers =3D POLICYDB_VERSION_FILENAME_TRANS,
+	};
+	struct policy_file fp =3D {
+		.data =3D data,
+		.len =3D sizeof(data),
+	};
+	struct avtab_key key;
+	struct avtab_datum *node;
+	u32 *otype;
+
+	p.p_types.nprim =3D 54;
+	p.p_classes.nprim =3D 49;
+	KUNIT_ASSERT_EQ(test, 0, avtab_alloc(&p.te_avtab, 3));
+
+	KUNIT_ASSERT_EQ(test, 0,
+			avtab_filename_trans_read(&p.te_avtab, &fp, &p));
+	KUNIT_EXPECT_EQ(test, 2, p.te_avtab.nel);
+	KUNIT_EXPECT_EQ(test, 0, fp.len);
+
+	key =3D (struct avtab_key){42, 43, 44, AVTAB_TRANSITION};
+	node =3D avtab_search(&p.te_avtab, &key);
+	KUNIT_ASSERT_NOT_NULL(test, node);
+	KUNIT_EXPECT_EQ(test, 0, node->u.trans->otype);
+	KUNIT_EXPECT_EQ(test, 1, node->u.trans->name_trans.table.nel);
+
+	otype =3D symtab_search(&node->u.trans->name_trans, "file1");
+	KUNIT_ASSERT_NOT_NULL(test, otype);
+	KUNIT_EXPECT_EQ(test, 45, *otype);
+
+	key =3D (struct avtab_key){46, 47, 48, AVTAB_TRANSITION};
+	node =3D avtab_search(&p.te_avtab, &key);
+	KUNIT_ASSERT_NOT_NULL(test, node);
+	KUNIT_EXPECT_EQ(test, 0, node->u.trans->otype);
+	KUNIT_EXPECT_EQ(test, 2, node->u.trans->name_trans.table.nel);
+
+	otype =3D symtab_search(&node->u.trans->name_trans, "file2");
+	KUNIT_ASSERT_NOT_NULL(test, otype);
+	KUNIT_EXPECT_EQ(test, 49, *otype);
+
+	otype =3D symtab_search(&node->u.trans->name_trans, "file3");
+	KUNIT_ASSERT_NOT_NULL(test, otype);
+	KUNIT_EXPECT_EQ(test, 53, *otype);
+
+	avtab_destroy(&p.te_avtab);
+}
+
+static void filename_trans_read__comp_simple(struct kunit *test)
+{
+	char data[] =3D {
+		3, 0, 0, 0,	/* count */
+
+		5, 0, 0, 0,			/* entry 1 name len */
+		'f', 'i', 'l', 'e', '1',	/* entry 1 name */
+		43, 0, 0, 0,			/* entry 1 ttype */
+		44, 0, 0, 0,			/* entry 1 tclass */
+		1, 0, 0, 0,			/* entry 1 ndatum */
+		64, 0, 0, 0,			/* entry 1 datum 1 stypes */
+		64, 0, 0, 0,
+		1, 0, 0, 0,
+		0, 0, 0, 0,
+		0, 0, 0, 0, 0, 2, 0, 0,
+		45, 0, 0, 0,			/* entry 1 otype */
+
+		5, 0, 0, 0,			/* entry 2 name len */
+		'f', 'i', 'l', 'e', '2',	/* entry 2 name */
+		47, 0, 0, 0,			/* entry 2 ttype */
+		48, 0, 0, 0,			/* entry 2 tclass */
+		1, 0, 0, 0,			/* entry 2 ndatum */
+		64, 0, 0, 0,			/* entry 2 datum 1 stypes */
+		64, 0, 0, 0,
+		1, 0, 0, 0,
+		0, 0, 0, 0,
+		0, 0, 0, 0, 0, 32, 0, 0,
+		49, 0, 0, 0,			/* entry 2 otype */
+
+		5, 0, 0, 0,			/* entry 3 name len */
+		'f', 'i', 'l', 'e', '3',	/* entry 3 name */
+		47, 0, 0, 0,			/* entry 3 ttype */
+		48, 0, 0, 0,			/* entry 3 tclass */
+		1, 0, 0, 0,			/* entry 2 ndatum */
+		64, 0, 0, 0,			/* entry 2 datum 1 stypes */
+		64, 0, 0, 0,
+		1, 0, 0, 0,
+		0, 0, 0, 0,
+		0, 0, 0, 0, 0, 32, 0, 0,
+		53, 0, 0, 0,			/* entry 3 otype */
+	};
+	struct policydb p =3D {
+		.te_avtab =3D {0},
+		.policyvers =3D POLICYDB_VERSION_COMP_FTRANS,
+	};
+	struct policy_file fp =3D {
+		.data =3D data,
+		.len =3D sizeof(data),
+	};
+	struct avtab_key key;
+	struct avtab_datum *node;
+	u32 *otype;
+
+	p.p_types.nprim =3D 54;
+	p.p_classes.nprim =3D 49;
+	KUNIT_ASSERT_EQ(test, 0, avtab_alloc(&p.te_avtab, 3));
+
+	KUNIT_ASSERT_EQ(test, 0,
+			avtab_filename_trans_read(&p.te_avtab, &fp, &p));
+	KUNIT_EXPECT_EQ(test, 2, p.te_avtab.nel);
+	KUNIT_EXPECT_EQ(test, 0, fp.len);
+
+	key =3D (struct avtab_key){42, 43, 44, AVTAB_TRANSITION};
+	node =3D avtab_search(&p.te_avtab, &key);
+	KUNIT_ASSERT_NOT_NULL(test, node);
+	KUNIT_EXPECT_EQ(test, 0, node->u.trans->otype);
+	KUNIT_EXPECT_EQ(test, 1, node->u.trans->name_trans.table.nel);
+
+	otype =3D symtab_search(&node->u.trans->name_trans, "file1");
+	KUNIT_ASSERT_NOT_NULL(test, otype);
+	KUNIT_EXPECT_EQ(test, 45, *otype);
+
+	key =3D (struct avtab_key){46, 47, 48, AVTAB_TRANSITION};
+	node =3D avtab_search(&p.te_avtab, &key);
+	KUNIT_ASSERT_NOT_NULL(test, node);
+	KUNIT_EXPECT_EQ(test, 0, node->u.trans->otype);
+	KUNIT_EXPECT_EQ(test, 2, node->u.trans->name_trans.table.nel);
+
+	otype =3D symtab_search(&node->u.trans->name_trans, "file2");
+	KUNIT_ASSERT_NOT_NULL(test, otype);
+	KUNIT_EXPECT_EQ(test, 49, *otype);
+
+	otype =3D symtab_search(&node->u.trans->name_trans, "file3");
+	KUNIT_ASSERT_NOT_NULL(test, otype);
+	KUNIT_EXPECT_EQ(test, 53, *otype);
+
+	avtab_destroy(&p.te_avtab);
+}
+
+static void filename_trans_write__pre_filename_trans(struct kunit *test)
+{
+	struct policydb p =3D {
+		.te_avtab =3D {0},
+		.policyvers =3D POLICYDB_VERSION_FILENAME_TRANS - 1,
+	};
+	struct policy_file fp =3D {
+		.data =3D NULL,
+		.len =3D 0,
+	};
+
+	p.p_types.nprim =3D 54;
+	p.p_classes.nprim =3D 49;
+
+	KUNIT_EXPECT_EQ(test, 0,
+			avtab_filename_trans_write(&p, &p.te_avtab, &fp));
+	KUNIT_EXPECT_EQ(test, 0, fp.len);
+}
+
+static void filename_trans_write__empty(struct kunit *test)
+{
+	char expected_data[] =3D {0, 0, 0, 0};
+	char data[sizeof(expected_data)] =3D {0};
+	struct policydb p =3D {
+		.te_avtab =3D {0},
+		.policyvers =3D POLICYDB_VERSION_FILENAME_TRANS,
+	};
+	struct policy_file fp =3D {
+		.data =3D data,
+		.len =3D sizeof(data),
+	};
+
+	p.p_types.nprim =3D 54;
+	p.p_classes.nprim =3D 49;
+
+	KUNIT_ASSERT_EQ(test, 0,
+			avtab_filename_trans_write(&p, &p.te_avtab, &fp));
+
+	KUNIT_EXPECT_EQ(test, 0, fp.len);
+	KUNIT_EXPECT_TRUE(test,
+			  !memcmp(expected_data, data, sizeof(expected_data)));
+}
+
+static void filename_trans_write__comp_empty(struct kunit *test)
+{
+	char expected_data[] =3D {0, 0, 0, 0};
+	char data[sizeof(expected_data)] =3D {0};
+	struct policydb p =3D {
+		.te_avtab =3D {0},
+		.policyvers =3D POLICYDB_VERSION_COMP_FTRANS,
+	};
+	struct policy_file fp =3D {
+		.data =3D data,
+		.len =3D sizeof(data),
+	};
+
+	p.p_types.nprim =3D 54;
+	p.p_classes.nprim =3D 49;
+
+	KUNIT_ASSERT_EQ(test, 0,
+			avtab_filename_trans_write(&p, &p.te_avtab, &fp));
+
+	KUNIT_EXPECT_EQ(test, 0, fp.len);
+	KUNIT_EXPECT_TRUE(test,
+			  !memcmp(expected_data, data, sizeof(expected_data)));
+}
+
+static void filename_trans_write__simple(struct kunit *test)
+{
+	char expected_data[] =3D {
+		3, 0, 0, 0,	/* count */
+
+		5, 0, 0, 0,			/* entry 1 name len */
+		'f', 'i', 'l', 'e', '1',	/* entry 1 name */
+		42, 0, 0, 0,			/* entry 1 stype */
+		43, 0, 0, 0,			/* entry 1 ttype */
+		44, 0, 0, 0,			/* entry 1 tclass */
+		45, 0, 0, 0,			/* entry 1 otype */
+
+		5, 0, 0, 0,			/* entry 2 name len */
+		'f', 'i', 'l', 'e', '2',	/* entry 2 name */
+		46, 0, 0, 0,			/* entry 2 stype */
+		47, 0, 0, 0,			/* entry 2 ttype */
+		48, 0, 0, 0,			/* entry 2 tclass */
+		49, 0, 0, 0,			/* entry 2 otype */
+
+		5, 0, 0, 0,			/* entry 3 name len */
+		'f', 'i', 'l', 'e', '3',	/* entry 3 name */
+		46, 0, 0, 0,			/* entry 3 stype */
+		47, 0, 0, 0,			/* entry 3 ttype */
+		48, 0, 0, 0,			/* entry 3 tclass */
+		53, 0, 0, 0,			/* entry 3 otype */
+	};
+	char data[sizeof(expected_data)] =3D {0};
+	struct policydb p =3D {
+		.te_avtab =3D {0},
+		.policyvers =3D POLICYDB_VERSION_FILENAME_TRANS,
+	};
+	struct policy_file fp =3D {
+		.data =3D data,
+		.len =3D sizeof(data),
+	};
+	u32 otypes[] =3D {45, 49, 53};
+	struct hashtab_node nhnodes[] =3D {
+		{"file1", &otypes[0], NULL},
+		{"file2", &otypes[1], &nhnodes[2]},
+		{"file3", &otypes[2], NULL},
+	};
+	struct hashtab_node *nhtable[] =3D {&nhnodes[0], &nhnodes[1]};
+	struct avtab_trans transs[] =3D {
+		{0, {{&nhtable[0], 1, 1}, 0}},
+		{0, {{&nhtable[1], 1, 2}, 0}},
+	};
+	struct avtab_node nodes[] =3D {
+		{{42, 43, 44, AVTAB_TRANSITION},
+			{.u.trans =3D &transs[0]}, NULL},
+		{{46, 47, 48, AVTAB_TRANSITION},
+			{.u.trans =3D &transs[1]}, NULL},
+	};
+	struct avtab_node *htable[] =3D {&nodes[0], &nodes[1]};
+
+	p.p_types.nprim =3D 54;
+	p.p_classes.nprim =3D 49;
+	p.te_avtab.htable =3D htable;
+	p.te_avtab.nslot =3D 2;
+	p.te_avtab.nel =3D 2;
+
+	KUNIT_ASSERT_EQ(test, 0,
+			avtab_filename_trans_write(&p, &p.te_avtab, &fp));
+
+	KUNIT_ASSERT_EQ(test, 0, fp.len);
+	KUNIT_EXPECT_TRUE(test,
+			  !memcmp(expected_data, data, sizeof(expected_data)));
+}
+
+static void filename_trans_write__comp_simple(struct kunit *test)
+{
+	char expected_data[] =3D {
+		3, 0, 0, 0,	/* count */
+
+		5, 0, 0, 0,			/* entry 1 name len */
+		'f', 'i', 'l', 'e', '1',	/* entry 1 name */
+		43, 0, 0, 0,			/* entry 1 ttype */
+		44, 0, 0, 0,			/* entry 1 tclass */
+		1, 0, 0, 0,			/* entry 1 ndatum */
+		64, 0, 0, 0,			/* entry 1 datum 1 stypes */
+		64, 0, 0, 0,
+		1, 0, 0, 0,
+		0, 0, 0, 0,
+		0, 0, 0, 0, 0, 2, 0, 0,
+		45, 0, 0, 0,			/* entry 1 otype */
+
+		5, 0, 0, 0,			/* entry 2 name len */
+		'f', 'i', 'l', 'e', '2',	/* entry 2 name */
+		47, 0, 0, 0,			/* entry 2 ttype */
+		48, 0, 0, 0,			/* entry 2 tclass */
+		1, 0, 0, 0,			/* entry 2 ndatum */
+		64, 0, 0, 0,			/* entry 2 datum 1 stypes */
+		64, 0, 0, 0,
+		1, 0, 0, 0,
+		0, 0, 0, 0,
+		0, 0, 0, 0, 0, 32, 0, 0,
+		49, 0, 0, 0,			/* entry 2 otype */
+
+		5, 0, 0, 0,			/* entry 3 name len */
+		'f', 'i', 'l', 'e', '3',	/* entry 3 name */
+		47, 0, 0, 0,			/* entry 3 ttype */
+		48, 0, 0, 0,			/* entry 3 tclass */
+		1, 0, 0, 0,			/* entry 2 ndatum */
+		64, 0, 0, 0,			/* entry 2 datum 1 stypes */
+		64, 0, 0, 0,
+		1, 0, 0, 0,
+		0, 0, 0, 0,
+		0, 0, 0, 0, 0, 32, 0, 0,
+		53, 0, 0, 0,			/* entry 3 otype */
+	};
+	char data[sizeof(expected_data)] =3D {0};
+	struct policydb p =3D {
+		.te_avtab =3D {0},
+		.policyvers =3D POLICYDB_VERSION_COMP_FTRANS,
+	};
+	struct policy_file fp =3D {
+		.data =3D data,
+		.len =3D sizeof(data),
+	};
+	u32 otypes[] =3D {45, 49, 53};
+	struct hashtab_node nhnodes[] =3D {
+		{"file1", &otypes[0], NULL},
+		{"file2", &otypes[1], &nhnodes[2]},
+		{"file3", &otypes[2], NULL},
+	};
+	struct hashtab_node *nhtable[] =3D {&nhnodes[0], &nhnodes[1]};
+	struct avtab_trans transs[] =3D {
+		{0, {{&nhtable[0], 1, 1}, 0}},
+		{0, {{&nhtable[1], 1, 2}, 0}},
+	};
+	struct avtab_node nodes[] =3D {
+		{{42, 43, 44, AVTAB_TRANSITION},
+			{.u.trans =3D &transs[0]}, NULL},
+		{{46, 47, 48, AVTAB_TRANSITION},
+			{.u.trans =3D &transs[1]}, NULL},
+	};
+	struct avtab_node *htable[] =3D {&nodes[0], &nodes[1]};
+
+	p.p_types.nprim =3D 54;
+	p.p_classes.nprim =3D 49;
+	p.te_avtab.htable =3D htable;
+	p.te_avtab.nslot =3D 2;
+	p.te_avtab.nel =3D 2;
+
+	KUNIT_ASSERT_EQ(test, 0,
+			avtab_filename_trans_write(&p, &p.te_avtab, &fp));
+
+	KUNIT_ASSERT_EQ(test, 0, fp.len);
+	KUNIT_EXPECT_TRUE(test,
+			  !memcmp(expected_data, data, sizeof(expected_data)));
+}
+
+static void read__pre_avtab_ftrans(struct kunit *test)
+{
+	char data[] =3D {
+		2, 0, 0, 0,	/* nel */
+
+		42, 0,			/* entry 1 source type */
+		43, 0,			/* entry 1 target type */
+		44, 0,			/* entry 1 target class */
+		AVTAB_TRANSITION, 0,	/* entry 1 specified */
+		45, 0, 0, 0,		/* entry 1 otype */
+
+		46, 0,			/* entry 2 source type */
+		47, 0,			/* entry 2 target type */
+		48, 0,			/* entry 2 target class */
+		AVTAB_TRANSITION, 0,	/* entry 2 specified */
+		49, 0, 0, 0,		/* entry 2 otype */
+	};
+	struct policydb p =3D {
+		.te_avtab =3D {0},
+		.policyvers =3D POLICYDB_VERSION_COMP_FTRANS,
+	};
+	struct policy_file fp =3D {
+		.data =3D data,
+		.len =3D sizeof(data),
+	};
+	struct avtab_key key;
+	struct avtab_datum *node;
+
+	p.p_types.nprim =3D 54;
+	p.p_classes.nprim =3D 49;
+	KUNIT_ASSERT_EQ(test, 0,
+			avtab_read(&p.te_avtab, &fp, &p));
+	KUNIT_EXPECT_EQ(test, 2, p.te_avtab.nel);
+	KUNIT_EXPECT_EQ(test, 0, fp.len);
+
+	key =3D (struct avtab_key){42, 43, 44, AVTAB_TRANSITION};
+	node =3D avtab_search(&p.te_avtab, &key);
+	KUNIT_ASSERT_NOT_NULL(test, node);
+	KUNIT_EXPECT_EQ(test, 45, node->u.trans->otype);
+	KUNIT_EXPECT_EQ(test, 0, node->u.trans->name_trans.table.nel);
+
+	key =3D (struct avtab_key){46, 47, 48, AVTAB_TRANSITION};
+	node =3D avtab_search(&p.te_avtab, &key);
+	KUNIT_ASSERT_NOT_NULL(test, node);
+	KUNIT_EXPECT_EQ(test, 49, node->u.trans->otype);
+	KUNIT_EXPECT_EQ(test, 0, node->u.trans->name_trans.table.nel);
+
+	avtab_destroy(&p.te_avtab);
+}
+
+static void read__simple(struct kunit *test)
+{
+	char data[] =3D {
+		2, 0, 0, 0,	/* nel */
+
+		42, 0,			/* entry 1 source type */
+		43, 0,			/* entry 1 target type */
+		44, 0,			/* entry 1 target class */
+		AVTAB_TRANSITION, 0,	/* entry 1 specified */
+		41, 0, 0, 0,		/* entry 1 otype */
+		1, 0, 0, 0,		/* entry 1 nfnts */
+		45, 0, 0, 0,			/* entry 1 fnt 1 otype */
+		5, 0, 0, 0,			/* entry 1 fnt 1 name len */
+		'f', 'i', 'l', 'e', '1',	/* entry 1 fnt 1 name */
+
+		46, 0,			/* entry 2 source type */
+		47, 0,			/* entry 2 target type */
+		48, 0,			/* entry 2 target class */
+		AVTAB_TRANSITION, 0,	/* entry 2 specified */
+		40, 0, 0, 0,		/* entry 2 otype */
+		2, 0, 0, 0,		/* entry 2 nfnts */
+		49, 0, 0, 0,			/* entry 2 fnt 1 otype */
+		5, 0, 0, 0,			/* entry 2 fnt 1 name len */
+		'f', 'i', 'l', 'e', '2',	/* entry 2 fnt 1 name */
+		50, 0, 0, 0,			/* entry 2 fnt 2 otype */
+		5, 0, 0, 0,			/* entry 2 fnt 2 name len */
+		'f', 'i', 'l', 'e', '3',	/* entry 2 fnt 2 name */
+	};
+	struct policydb p =3D {
+		.te_avtab =3D {0},
+		.policyvers =3D POLICYDB_VERSION_AVTAB_FTRANS,
+	};
+	struct policy_file fp =3D {
+		.data =3D data,
+		.len =3D sizeof(data),
+	};
+	struct avtab_key key;
+	struct avtab_datum *node;
+	u32 *otype;
+
+	p.p_types.nprim =3D 54;
+	p.p_classes.nprim =3D 49;
+	KUNIT_ASSERT_EQ(test, 0,
+			avtab_read(&p.te_avtab, &fp, &p));
+	KUNIT_EXPECT_EQ(test, 2, p.te_avtab.nel);
+	KUNIT_EXPECT_EQ(test, 0, fp.len);
+
+	key =3D (struct avtab_key){42, 43, 44, AVTAB_TRANSITION};
+	node =3D avtab_search(&p.te_avtab, &key);
+	KUNIT_ASSERT_NOT_NULL(test, node);
+	KUNIT_EXPECT_EQ(test, 41, node->u.trans->otype);
+	KUNIT_EXPECT_EQ(test, 1, node->u.trans->name_trans.table.nel);
+
+	otype =3D symtab_search(&node->u.trans->name_trans, "file1");
+	KUNIT_ASSERT_NOT_NULL(test, otype);
+	KUNIT_EXPECT_EQ(test, 45, *otype);
+
+	key =3D (struct avtab_key){46, 47, 48, AVTAB_TRANSITION};
+	node =3D avtab_search(&p.te_avtab, &key);
+	KUNIT_ASSERT_NOT_NULL(test, node);
+	KUNIT_EXPECT_EQ(test, 40, node->u.trans->otype);
+	KUNIT_EXPECT_EQ(test, 2, node->u.trans->name_trans.table.nel);
+
+	otype =3D symtab_search(&node->u.trans->name_trans, "file2");
+	KUNIT_ASSERT_NOT_NULL(test, otype);
+	KUNIT_EXPECT_EQ(test, 49, *otype);
+
+	otype =3D symtab_search(&node->u.trans->name_trans, "file3");
+	KUNIT_ASSERT_NOT_NULL(test, otype);
+	KUNIT_EXPECT_EQ(test, 50, *otype);
+
+	avtab_destroy(&p.te_avtab);
+}
+
+static void write__pre_avtab_ftrans(struct kunit *test)
+{
+	char expected_data[] =3D {
+		1, 0, 0, 0,	/* nel */
+
+		46, 0,			/* entry 2 source type */
+		47, 0,			/* entry 2 target type */
+		48, 0,			/* entry 2 target class */
+		AVTAB_TRANSITION, 0,	/* entry 2 specified */
+		40, 0, 0, 0,		/* entry 2 otype */
+	};
+	char data[sizeof(expected_data)] =3D {0};
+	struct policydb p =3D {
+		.te_avtab =3D {0},
+		.policyvers =3D POLICYDB_VERSION_COMP_FTRANS,
+	};
+	struct policy_file fp =3D {
+		.data =3D data,
+		.len =3D sizeof(data),
+	};
+	u32 otypes[] =3D {45, 49, 53};
+	struct hashtab_node nhnodes[] =3D {
+		{"file1", &otypes[0], NULL},
+		{"file2", &otypes[1], &nhnodes[2]},
+		{"file3", &otypes[2], NULL},
+	};
+	struct hashtab_node *nhtable[] =3D {&nhnodes[0], &nhnodes[1]};
+	struct avtab_trans transs[] =3D {
+		{0, {{&nhtable[0], 1, 1}, 0}},
+		{40, {{&nhtable[1], 1, 2}, 0}},
+	};
+	struct avtab_node nodes[] =3D {
+		{{42, 43, 44, AVTAB_TRANSITION},
+			{.u.trans =3D &transs[0]}, NULL},
+		{{46, 47, 48, AVTAB_TRANSITION},
+			{.u.trans =3D &transs[1]}, NULL},
+	};
+	struct avtab_node *htable[] =3D {&nodes[0], &nodes[1]};
+
+	p.p_types.nprim =3D 54;
+	p.p_classes.nprim =3D 49;
+	p.te_avtab.htable =3D htable;
+	p.te_avtab.nslot =3D 2;
+	p.te_avtab.nel =3D 2;
+
+	KUNIT_ASSERT_EQ(test, 0, avtab_write(&p, &p.te_avtab, &fp));
+
+	KUNIT_ASSERT_EQ(test, 0, fp.len);
+	KUNIT_EXPECT_TRUE(test,
+			  !memcmp(expected_data, data, sizeof(expected_data)));
+}
+
+static void write__simple(struct kunit *test)
+{
+	char expected_data[] =3D {
+		2, 0, 0, 0,	/* nel */
+
+		42, 0,			/* entry 1 source type */
+		43, 0,			/* entry 1 target type */
+		44, 0,			/* entry 1 target class */
+		AVTAB_TRANSITION, 0,	/* entry 1 specified */
+		41, 0, 0, 0,		/* entry 1 otype */
+		1, 0, 0, 0,		/* entry 1 nfnts */
+		45, 0, 0, 0,			/* entry 1 fnt 1 otype */
+		5, 0, 0, 0,			/* entry 1 fnt 1 name len */
+		'f', 'i', 'l', 'e', '1',	/* entry 1 fnt 1 name */
+
+		46, 0,			/* entry 2 source type */
+		47, 0,			/* entry 2 target type */
+		48, 0,			/* entry 2 target class */
+		AVTAB_TRANSITION, 0,	/* entry 2 specified */
+		40, 0, 0, 0,		/* entry 2 otype */
+		2, 0, 0, 0,		/* entry 2 nfnts */
+		49, 0, 0, 0,			/* entry 1 fnt 1 otype */
+		5, 0, 0, 0,			/* entry 1 fnt 1 name len */
+		'f', 'i', 'l', 'e', '2',	/* entry 1 fnt 1 name */
+		50, 0, 0, 0,			/* entry 1 fnt 1 otype */
+		5, 0, 0, 0,			/* entry 1 fnt 1 name len */
+		'f', 'i', 'l', 'e', '3',	/* entry 1 fnt 1 name */
+	};
+	char data[sizeof(expected_data)] =3D {0};
+	struct policydb p =3D {
+		.te_avtab =3D {0},
+		.policyvers =3D POLICYDB_VERSION_AVTAB_FTRANS,
+	};
+	struct policy_file fp =3D {
+		.data =3D data,
+		.len =3D sizeof(data),
+	};
+	u32 otypes[] =3D {45, 49, 50};
+	struct hashtab_node nhnodes[] =3D {
+		{"file1", &otypes[0], NULL},
+		{"file2", &otypes[1], &nhnodes[2]},
+		{"file3", &otypes[2], NULL},
+	};
+	struct hashtab_node *nhtable[] =3D {&nhnodes[0], &nhnodes[1]};
+	struct avtab_trans transs[] =3D {
+		{41, {{&nhtable[0], 1, 1}, 0}},
+		{40, {{&nhtable[1], 1, 2}, 0}},
+	};
+	struct avtab_node nodes[] =3D {
+		{{42, 43, 44, AVTAB_TRANSITION},
+			{.u.trans =3D &transs[0]}, NULL},
+		{{46, 47, 48, AVTAB_TRANSITION},
+			{.u.trans =3D &transs[1]}, NULL},
+	};
+	struct avtab_node *htable[] =3D {&nodes[0], &nodes[1]};
+
+	p.p_types.nprim =3D 54;
+	p.p_classes.nprim =3D 49;
+	p.te_avtab.htable =3D htable;
+	p.te_avtab.nslot =3D 2;
+	p.te_avtab.nel =3D 2;
+
+	KUNIT_ASSERT_EQ(test, 0, avtab_write(&p, &p.te_avtab, &fp));
+
+	KUNIT_ASSERT_EQ(test, 0, fp.len);
+	KUNIT_EXPECT_TRUE(test,
+			  !memcmp(expected_data, data, sizeof(expected_data)));
+}
+
+static struct kunit_case avtab_test_cases[] =3D {
+	KUNIT_CASE(filename_trans_read__pre_filename_trans),
+	KUNIT_CASE(filename_trans_read__empty),
+	KUNIT_CASE(filename_trans_read__comp_empty),
+	KUNIT_CASE(filename_trans_read__simple),
+	KUNIT_CASE(filename_trans_read__comp_simple),
+
+	KUNIT_CASE(filename_trans_write__pre_filename_trans),
+	KUNIT_CASE(filename_trans_write__empty),
+	KUNIT_CASE(filename_trans_write__comp_empty),
+	KUNIT_CASE(filename_trans_write__simple),
+	KUNIT_CASE(filename_trans_write__comp_simple),
+
+	KUNIT_CASE(read__pre_avtab_ftrans),
+	KUNIT_CASE(read__simple),
+
+	KUNIT_CASE(write__pre_avtab_ftrans),
+	KUNIT_CASE(write__simple),
+	{0},
+};
+
+static struct kunit_suite avtab_test_suite =3D {
+	.name =3D "security-selinux-avtab",
+	.test_cases =3D avtab_test_cases,
+};
+
+kunit_test_suite(avtab_test_suite);
+
+MODULE_LICENSE("GPL");
diff --git a/security/selinux/ss/symtab.c b/security/selinux/ss/symtab.c
index c42a6648a07d..c53863d5ed40 100644
--- a/security/selinux/ss/symtab.c
+++ b/security/selinux/ss/symtab.c
@@ -52,3 +52,6 @@ void *symtab_search(struct symtab *s, const char *name)
 {
 	return hashtab_search(&s->table, name, symtab_key_params);
 }
+
+/* Export for avtab KUnit tests */
+EXPORT_SYMBOL_GPL(symtab_search);
--=20
2.40.0

