Return-Path: <SRS0=EIhe=3R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84277C2D0DB
	for <selinux@archiver.kernel.org>; Tue, 28 Jan 2020 19:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54CF62173E
	for <selinux@archiver.kernel.org>; Tue, 28 Jan 2020 19:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JB+V0lKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgA1TRj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Jan 2020 14:17:39 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35942 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgA1TRi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Jan 2020 14:17:38 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so17414470wru.3;
        Tue, 28 Jan 2020 11:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WsY0o1WCtR1XmaldyV3SQwecjlyaZIqArEZxV+TtXA4=;
        b=JB+V0lKVuyeZ0hCcwVapGgSN7/biYqKjzXDYuqAUFKIEpMUBwihS4nzYko5HXyjtLQ
         ygl3I6hGJ10ju+njtm8p+wAdamPzxigr5iz7U1oV12ID6UruxNdh3KIU7MO4N3b8gZhP
         Gmy0WE5TYTqb5UotTpimd3X6BysE8AyiLmBPrQhNNONZn6ees1/rxfvhWYJMi9l3sGzV
         /pbMs2H3i0Ihde6q1SjICiGzFUSABY5/WUMtBnWzw7K+oxqqxMk6kcVOWVa7k8qGPu3w
         RHI2TppZE3IOvL7WOU5TAD4M17V/Id5c/14Frf6mFLnavy3hJJwKGSkTgLsGG4A9F9xb
         YyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WsY0o1WCtR1XmaldyV3SQwecjlyaZIqArEZxV+TtXA4=;
        b=YtBDsbBpBOEImMkPEFoMyc9A68NozdMUjtpj3qUKPhNTW52xwpWfE4Evz8tNxbMJ6U
         SeB0brDxCDmX1ayVkac1H1JHs9i8rfNPAKLN1i+Xsha6b3QpUmrAUHHlxSP77MkH8JCL
         e8KHJFqHyZlBZ1ovI48Akr4WvE/8MzjJYkU58qUoxuTjy+VGl/txUz9VvrFjZ3Tk5OkZ
         Y6mkfIitL72nWHdYD9S6/DX4ywPydqx0N/q7k5CH5JKQ/9DrQ3kbcSUjss/oaNQHbeDL
         XvX0e1/1B5dnNyt4V5/RhH49lLnheFT47XG4dBDNNMoymCCs5ZfaVKGH+iLg2U7aWusK
         /cdw==
X-Gm-Message-State: APjAAAUB1Of+5DQurEaQBhtxZCbYbeYlkUdfhZLClLJeSfxNecuRUjLH
        bgMkl5r1XJo55BJJuB3Wh6KcAVEfoU46XQ==
X-Google-Smtp-Source: APXvYqzCe4O9Qb4ytT6ZR+d3xgIGmBUkeNuIjsg7p8dGl0kOmjIEHugSdRrFZV6eEgHR8IvNHXbcXw==
X-Received: by 2002:adf:c446:: with SMTP id a6mr29813538wrg.218.1580239056836;
        Tue, 28 Jan 2020 11:17:36 -0800 (PST)
Received: from desktopdebian.localdomain (x4d005f5e.dyn.telefonica.de. [77.0.95.94])
        by smtp.gmail.com with ESMTPSA id f18sm3446114wrt.75.2020.01.28.11.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 11:17:36 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     cgzones@googlemail.com, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Joshua Brindle <joshua.brindle@crunchydata.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] selinux: allow kernfs symlinks to inherit parent directory context
Date:   Tue, 28 Jan 2020 20:16:48 +0100
Message-Id: <20200128191656.111902-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124184221.322248-1-cgzones@googlemail.com>
References: <20200124184221.322248-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Currently symlinks on kernel filesystems, like sysfs, are labeled on
creation with the parent filesystem root sid.

Allow symlinks to inherit the parent directory context, so fine-grained
kernfs labeling can be applied to symlinks too and checking contexts
doesn't complain about them.

For backward-compatibility this behavior is contained in a new policy
capability: genfs_seclabel_symlinks

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
incorporate feedback from Stephen Smalley
  - changed polcap name
  - extended affected filesystems from SE_SBGENFS_XATTR to SE_SBGENFS

 security/selinux/hooks.c            | 4 +++-
 security/selinux/include/security.h | 8 ++++++++
 security/selinux/ss/services.c      | 3 ++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d9e8b2131a65..60a0b3553c70 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1475,7 +1475,9 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 		/* Default to the fs superblock SID. */
 		sid = sbsec->sid;
 
-		if ((sbsec->flags & SE_SBGENFS) && !S_ISLNK(inode->i_mode)) {
+		if ((sbsec->flags & SE_SBGENFS) &&
+		     (!S_ISLNK(inode->i_mode) ||
+		      selinux_policycap_genfs_seclabel_symlinks())) {
 			/* We must have a dentry to determine the label on
 			 * procfs inodes */
 			if (opt_dentry) {
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index a39f9565d80b..863ccf2bb629 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -79,6 +79,7 @@ enum {
 	POLICYDB_CAPABILITY_ALWAYSNETWORK,
 	POLICYDB_CAPABILITY_CGROUPSECLABEL,
 	POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
+	POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS,
 	__POLICYDB_CAPABILITY_MAX
 };
 #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
@@ -209,6 +210,13 @@ static inline bool selinux_policycap_nnp_nosuid_transition(void)
 	return state->policycap[POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION];
 }
 
+static inline bool selinux_policycap_genfs_seclabel_symlinks(void)
+{
+	struct selinux_state *state = &selinux_state;
+
+	return state->policycap[POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS];
+}
+
 int security_mls_enabled(struct selinux_state *state);
 int security_load_policy(struct selinux_state *state,
 			 void *data, size_t len);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 216ce602a2b5..d9306f489060 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -73,7 +73,8 @@ const char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
 	"extended_socket_class",
 	"always_check_network",
 	"cgroup_seclabel",
-	"nnp_nosuid_transition"
+	"nnp_nosuid_transition",
+	"genfs_seclabel_symlinks"
 };
 
 static struct selinux_ss selinux_ss;
-- 
2.25.0

