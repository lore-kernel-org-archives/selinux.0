Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20E6C2D0DB
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 18:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC862072C
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 18:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="p2E5qUKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391452AbgAXSmg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jan 2020 13:42:36 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32850 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389067AbgAXSmg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jan 2020 13:42:36 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so3230759wrq.0;
        Fri, 24 Jan 2020 10:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hxaGriu+6OASXqVTTD7fqR/Evc+gXUed/rL6pEHioHM=;
        b=p2E5qUKf/90BiHk6doo6hKQ2tmAsndtzrVRKNHBT2hGtfSRR9F7fAxcefAXwRNjEWk
         5AKziF4gPF/m5+W7fbc+/4f3/GPamv6RoxHy+/mYY2sXfpwMA6iS+wNJjRt1Dk30hRBM
         WVvvHsTNnPEWQq0uAkigFjPfQwZ3T25oul13qzHnqt5T9SF0u3nHJX+AzDArAVBVg54L
         pv7vCHjtLr9NHAJC8qqK50+3+3+RVI79Tqq6XQdwcARzzkom2Ca6Wm5vkwXS45mgH8eY
         9QTrnbhpBY4vGKq07Clx0/y4ni7+SoaS+3qSCvF0k3TzpfPwbKYxKGAs6c1qBTK2SmcP
         f9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hxaGriu+6OASXqVTTD7fqR/Evc+gXUed/rL6pEHioHM=;
        b=NLzFhisAgTK0KO5seNaRv+phSpFp2ocicFaDVdXQKQGDWe6tjmeOIb+apsTIPH9W3K
         gS2ac0p6J4OHN6gJze0J7f3x8aAqLyK3A8jpV4KKFiDt5IwbQlDMIqeM5aLIZeQa9/BQ
         EUme5No/bouwTSh5+Wc0kqCkn12JTTJ7hOvvVF/WnPts6iQxt+aS0ufInAnawUWf/eMY
         KAdqzV2GWMjJ+5lBCYpPiN76KvjhWRYdC42qHOs+lBmmFfxemz2nohXZO/uuvuWp3kai
         QulGGd5mzO4/3hBKeUoho4HP8utQMPWpPi/KMbg0HCpWhAuMU9b0qTjmUhcVU+m+6CSX
         YJIQ==
X-Gm-Message-State: APjAAAXxbLD1ttK7fjCbjx2ra9KwsbYfxnhUaM+9cx18YgxZMozx/gWE
        0XNAm5OC8enBePfsOZclbYo=
X-Google-Smtp-Source: APXvYqzEXpUS4DI6SZ7C8bn6Zh3dAPRFC02N9FBQ/+W5uZf8HmUz7IrPEpYcSLhpvX2wEORsxjB2Iw==
X-Received: by 2002:adf:ef8b:: with SMTP id d11mr5492462wro.45.1579891354616;
        Fri, 24 Jan 2020 10:42:34 -0800 (PST)
Received: from desktopdebian.localdomain (x4d03a6f1.dyn.telefonica.de. [77.3.166.241])
        by smtp.gmail.com with ESMTPSA id d14sm9302724wru.9.2020.01.24.10.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 10:42:34 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     cgzones@googlemail.com, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selinux: allow kernfs symlinks to inherit parent directory context
Date:   Fri, 24 Jan 2020 19:42:21 +0100
Message-Id: <20200124184221.322248-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Currently symlinks on kernel filesystems, like sysfs, are labeled on
creation with the parent fs root sid.

Allow symlinks to inherit the parent directory context, so fine-grained
kernfs labeling can be applied to symlinks too and checking contexts
doesn't complain about them.

For backward-compatibility this behavior is contained in a new policy
capability: kernfs_sovereign_symlinks

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/hooks.c            | 5 ++++-
 security/selinux/include/security.h | 8 ++++++++
 security/selinux/ss/services.c      | 3 ++-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d9e8b2131..1303bc8c4 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1475,7 +1475,10 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 		/* Default to the fs superblock SID. */
 		sid = sbsec->sid;
 
-		if ((sbsec->flags & SE_SBGENFS) && !S_ISLNK(inode->i_mode)) {
+		if (((sbsec->flags & SE_SBGENFS) &&
+		     (!S_ISLNK(inode->i_mode))) ||
+		    (selinux_policycap_kernfs_sovereign_symlinks() &&
+		     (sbsec->flags & SE_SBGENFS_XATTR))) {
 			/* We must have a dentry to determine the label on
 			 * procfs inodes */
 			if (opt_dentry) {
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index a39f9565d..cc8217848 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -79,6 +79,7 @@ enum {
 	POLICYDB_CAPABILITY_ALWAYSNETWORK,
 	POLICYDB_CAPABILITY_CGROUPSECLABEL,
 	POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
+	POLICYDB_CAPABILITY_KERNFS_SOVEREIGN_SYMLINKS,
 	__POLICYDB_CAPABILITY_MAX
 };
 #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
@@ -209,6 +210,13 @@ static inline bool selinux_policycap_nnp_nosuid_transition(void)
 	return state->policycap[POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION];
 }
 
+static inline bool selinux_policycap_kernfs_sovereign_symlinks(void)
+{
+	struct selinux_state *state = &selinux_state;
+
+	return state->policycap[POLICYDB_CAPABILITY_KERNFS_SOVEREIGN_SYMLINKS];
+}
+
 int security_mls_enabled(struct selinux_state *state);
 int security_load_policy(struct selinux_state *state,
 			 void *data, size_t len);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 216ce602a..b70380947 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -73,7 +73,8 @@ const char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
 	"extended_socket_class",
 	"always_check_network",
 	"cgroup_seclabel",
-	"nnp_nosuid_transition"
+	"nnp_nosuid_transition",
+	"kernfs_sovereign_symlinks"
 };
 
 static struct selinux_ss selinux_ss;
-- 
2.25.0

