Return-Path: <SRS0=gk/B=V5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECF5C19759
	for <selinux@archiver.kernel.org>; Thu,  1 Aug 2019 14:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E324120838
	for <selinux@archiver.kernel.org>; Thu,  1 Aug 2019 14:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbfHAOCw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:02:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35438 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731334AbfHAOCv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Aug 2019 10:02:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id y4so73741103wrm.2
        for <selinux@vger.kernel.org>; Thu, 01 Aug 2019 07:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mJn6mUYEYLeEvyAEs0120wh2ye8ZXvWXPoyVrBnKS2s=;
        b=a82EuDSNK6xJ9od3GeB6Flik20mVS8bkEV+0XQ35e3+oGBhEgXE2EuRngkcN2Z799L
         rEegkUM2plhy7YlR/RiBMqwumEDHWYTC77jPS4F0hG8uQ3g8RoThR801Hksc9zQVl8fe
         pumkcxGiItfDNpVIbfeDt3oD8HemjBTs0yYK4jp+mojU3x+AMlk/RvgsUBHQZbIBU56b
         VX6F8oqbqZ4kOyzvdg893cPWbuxtaGBQ1eMitw8i2zgQAwu7bX0tkJVMUoAQEE5HfDp8
         xkeOVEfB6v9k8rQ9fAE2aPDg6P/IcgdD02VRWwDKTmGwIT1nRDeJVTvQqiJs49mpP9Qm
         WylA==
X-Gm-Message-State: APjAAAXUnfN3v+bCftpUAIdEY936bt/lTs+lMDnPUnRXunPrC0EdEM3e
        fg/Qqus1SmNj3Li658uc1wrNaSyrwgg=
X-Google-Smtp-Source: APXvYqycPbmdqDDFF167loGujYRAmgAcJOv7PBWaUQzfjx70b5H9CGMf56RqiPGlGFmHgztjQAPHUw==
X-Received: by 2002:adf:b64b:: with SMTP id i11mr6646495wre.205.1564668169029;
        Thu, 01 Aug 2019 07:02:49 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id z7sm69909162wrh.67.2019.08.01.07.02.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 07:02:48 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/4] dcache: introduce d_genocide_safe()
Date:   Thu,  1 Aug 2019 16:02:42 +0200
Message-Id: <20190801140243.24080-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190801140243.24080-1-omosnace@redhat.com>
References: <20190801140243.24080-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch adds a slightly modified variant of d_genocide() that works
safely on live (ramfs-like) trees. This function is needed for a safe
implementation of sel_remove_entries() in selinuxfs.

This new function differs from the original d_genocide in the following:
1. It locks the parent inode when traversing the dentries.
2. It first unhashes the dentry using __d_drop() before dropping the
   refcount and marking the dentry.
3. It does its business in the leave callback so that each dentry is
   unhashed after its children -- otherwise some dentries might never
   get traversed when d_walk() is restarted internally.

The combination of (1.) and (2.) is needed to avoid racing with
dcache_readdir(), which relies on the assumption that any
simple_positive() child dentry will not turn negative without locking
the parent inode for writing.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 fs/dcache.c            | 32 ++++++++++++++++++++++++++++++++
 include/linux/dcache.h |  1 +
 2 files changed, 33 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 70afcb6e6892..f6d667120c1e 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3142,6 +3142,38 @@ void d_genocide(struct dentry *parent)
 
 EXPORT_SYMBOL(d_genocide);
 
+static enum d_walk_ret d_genocide_safe_enter(void *data, struct dentry *dentry)
+{
+	struct dentry *root = data;
+
+	if (dentry != root && !simple_positive(dentry))
+		return D_WALK_SKIP;
+
+	return D_WALK_CONTINUE;
+}
+
+static void d_genocide_safe_leave(void *data, struct dentry *dentry)
+{
+	struct dentry *root = data;
+
+	if (dentry != root) {
+		__d_drop(dentry);
+
+		if (!(dentry->d_flags & DCACHE_GENOCIDE)) {
+			dentry->d_flags |= DCACHE_GENOCIDE;
+			dentry->d_lockref.count--;
+		}
+	}
+}
+
+void d_genocide_safe(struct dentry *parent)
+{
+	d_walk(parent, true, parent, d_genocide_safe_enter,
+	       d_genocide_safe_leave);
+}
+
+EXPORT_SYMBOL(d_genocide_safe);
+
 void d_tmpfile(struct dentry *dentry, struct inode *inode)
 {
 	inode_dec_link_count(inode);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 9451011ac014..6d787c26e901 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -253,6 +253,7 @@ extern struct dentry * d_make_root(struct inode *);
 
 /* <clickety>-<click> the ramfs-type tree */
 extern void d_genocide(struct dentry *);
+extern void d_genocide_safe(struct dentry *parent);
 
 extern void d_tmpfile(struct dentry *, struct inode *);
 
-- 
2.21.0

