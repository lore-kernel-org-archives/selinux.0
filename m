Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A211FC433F5
	for <selinux@archiver.kernel.org>; Wed,  2 Feb 2022 12:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbiBBMzl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Feb 2022 07:55:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59791 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231500AbiBBMzk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Feb 2022 07:55:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643806540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yktwIblN4xGPWSBTlJEs+WWw8CK8xx4s+jF4gbobGHQ=;
        b=SvdrMoU9/kuw0eGpBi/5zLKlvohhS6aytrrEIkGtrHMGPYXGsqSTX4bbiIof/m+iNiSDm7
        XtwK41KOlqS8l0dhvc04Ffir4d25Vf0XZge6pEbef1srUnEex3zZVXE+AeKE/96yDlnEIg
        +NWPINH1UPz0CEkIEGznaYtxIJS1K84=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-yx6ZZanMPwu5QK170yp_tw-1; Wed, 02 Feb 2022 07:55:39 -0500
X-MC-Unique: yx6ZZanMPwu5QK170yp_tw-1
Received: by mail-wm1-f72.google.com with SMTP id r132-20020a1c448a000000b00352cf8b74dcso137535wma.0
        for <selinux@vger.kernel.org>; Wed, 02 Feb 2022 04:55:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yktwIblN4xGPWSBTlJEs+WWw8CK8xx4s+jF4gbobGHQ=;
        b=YU+GHF8jQopkbPA+Yab71+6PJkMKqQaGS0XPchebOEd4J0XoQkaWtUyXF/Z1VCCE88
         3Ewk8JlfYmWWkcSWliqSNvYkHfVkBUEFlpgXt/aSsW6R7cf2IJlOWEzDB+vd0TUjTGWz
         +JmRdJCg8DOHeXk7oEd5V/zMFQBsxLkjc49GdwIRQAz94BgSu4XEPyQ7M3XZ9ZkVEqKU
         E/Td3TIrnLbdyFoNsdjRFiMb0CHEexIE8+J/VNBNXVNNQAnN2qnDzfcFIZtmIQe2jHHs
         QmwqRLV7Q0LG+V4NKDDBBs6/ZipV0pgkRVEr0B+SZLSfeHop+oGuMj6f00OYHnJpFZ9J
         OkUw==
X-Gm-Message-State: AOAM530A9Qdp7j9gDy9jrL6KLLWvznMrPgZLqxEA9+6E7o3PS3wjnmnO
        KWbjEJ03GVzxZRQfEob1FEv6jnmZkj68+BVCA3Q4W/aPZz5nUEPQYbxydDe9JrZjoF3cVnNOgCe
        7z6zIbLbjjkwl1Dtw9w==
X-Received: by 2002:a05:600c:1e8b:: with SMTP id be11mr5975527wmb.96.1643806537798;
        Wed, 02 Feb 2022 04:55:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxYcln2jC9+I+P0Mvc21kgGX0+wrpxSfJQkoM6VQxezjzYcAJSP/D5OBzoTdqTNCRpmiiQRqg==
X-Received: by 2002:a05:600c:1e8b:: with SMTP id be11mr5975514wmb.96.1643806537596;
        Wed, 02 Feb 2022 04:55:37 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id e13sm20811023wrq.35.2022.02.02.04.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 04:55:37 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, Scott Mayhew <smayhew@redhat.com>
Subject: [PATCH] selinux: parse contexts for mount options early
Date:   Wed,  2 Feb 2022 13:55:29 +0100
Message-Id: <20220202125529.85533-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Commit b8b87fd954b4 ("selinux: Fix selinux_sb_mnt_opts_compat()")
started to parse mount options into SIDs in selinux_add_opt() if policy
has already been loaded. Since it's extremely unlikely that anyone would
depend on the ability to set SELinux contexts on fs_context before
loading the policy and then mounting that context after simplify the
logic by always parsing the options early.

Note that the multi-step mounting is only possible with the new
fscontext mount API and wasn't possible before its introduction.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/hooks.c | 202 ++++++++++-----------------------------
 1 file changed, 53 insertions(+), 149 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b60481192b38..e2a3b872c0f9 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -340,7 +340,6 @@ static void inode_free_security(struct inode *inode)
 }
 
 struct selinux_mnt_opts {
-	const char *fscontext, *context, *rootcontext, *defcontext;
 	u32 fscontext_sid;
 	u32 context_sid;
 	u32 rootcontext_sid;
@@ -349,12 +348,7 @@ struct selinux_mnt_opts {
 
 static void selinux_free_mnt_opts(void *mnt_opts)
 {
-	struct selinux_mnt_opts *opts = mnt_opts;
-	kfree(opts->fscontext);
-	kfree(opts->context);
-	kfree(opts->rootcontext);
-	kfree(opts->defcontext);
-	kfree(opts);
+	kfree(mnt_opts);
 }
 
 enum {
@@ -601,17 +595,6 @@ static int bad_option(struct superblock_security_struct *sbsec, char flag,
 	return 0;
 }
 
-static int parse_sid(struct super_block *sb, const char *s, u32 *sid)
-{
-	int rc = security_context_str_to_sid(&selinux_state, s,
-					     sid, GFP_KERNEL);
-	if (rc)
-		pr_warn("SELinux: security_context_str_to_sid"
-		       "(%s) failed for (dev %s, type %s) errno=%d\n",
-		       s, sb ? sb->s_id : "?", sb ? sb->s_type->name : "?", rc);
-	return rc;
-}
-
 /*
  * Allow filesystems with binary mount data to explicitly set mount point
  * labeling information.
@@ -674,49 +657,29 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	 * than once with different security options.
 	 */
 	if (opts) {
-		if (opts->fscontext) {
-			if (opts->fscontext_sid == SECSID_NULL) {
-				rc = parse_sid(sb, opts->fscontext, &fscontext_sid);
-				if (rc)
-					goto out;
-			} else
-				fscontext_sid = opts->fscontext_sid;
+		if (opts->fscontext_sid) {
+			fscontext_sid = opts->fscontext_sid;
 			if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid,
 					fscontext_sid))
 				goto out_double_mount;
 			sbsec->flags |= FSCONTEXT_MNT;
 		}
-		if (opts->context) {
-			if (opts->context_sid == SECSID_NULL) {
-				rc = parse_sid(sb, opts->context, &context_sid);
-				if (rc)
-					goto out;
-			} else
-				context_sid = opts->context_sid;
+		if (opts->context_sid) {
+			context_sid = opts->context_sid;
 			if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid,
 					context_sid))
 				goto out_double_mount;
 			sbsec->flags |= CONTEXT_MNT;
 		}
-		if (opts->rootcontext) {
-			if (opts->rootcontext_sid == SECSID_NULL) {
-				rc = parse_sid(sb, opts->rootcontext, &rootcontext_sid);
-				if (rc)
-					goto out;
-			} else
-				rootcontext_sid = opts->rootcontext_sid;
+		if (opts->rootcontext_sid) {
+			rootcontext_sid = opts->rootcontext_sid;
 			if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid,
 					rootcontext_sid))
 				goto out_double_mount;
 			sbsec->flags |= ROOTCONTEXT_MNT;
 		}
-		if (opts->defcontext) {
-			if (opts->defcontext_sid == SECSID_NULL) {
-				rc = parse_sid(sb, opts->defcontext, &defcontext_sid);
-				if (rc)
-					goto out;
-			} else
-				defcontext_sid = opts->defcontext_sid;
+		if (opts->defcontext_sid) {
+			defcontext_sid = opts->defcontext_sid;
 			if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid,
 					defcontext_sid))
 				goto out_double_mount;
@@ -986,6 +949,8 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 {
 	struct selinux_mnt_opts *opts = *mnt_opts;
 	bool is_alloc_opts = false;
+	u32 *dst_sid;
+	int rc;
 
 	if (token == Opt_seclabel)
 		/* eaten and completely ignored */
@@ -993,6 +958,11 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 	if (!s)
 		return -ENOMEM;
 
+	if (!selinux_initialized(&selinux_state)) {
+		pr_warn("SELinux: Unable to set superblock options before the security server is initialized\n");
+		return -EINVAL;
+	}
+
 	if (!opts) {
 		opts = kzalloc(sizeof(*opts), GFP_KERNEL);
 		if (!opts)
@@ -1003,36 +973,34 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 
 	switch (token) {
 	case Opt_context:
-		if (opts->context || opts->defcontext)
+		if (opts->context_sid || opts->defcontext_sid)
 			goto err;
-		opts->context = s;
-		if (selinux_initialized(&selinux_state))
-			parse_sid(NULL, s, &opts->context_sid);
+		dst_sid = &opts->context_sid;
 		break;
 	case Opt_fscontext:
-		if (opts->fscontext)
+		if (opts->fscontext_sid)
 			goto err;
-		opts->fscontext = s;
-		if (selinux_initialized(&selinux_state))
-			parse_sid(NULL, s, &opts->fscontext_sid);
+		dst_sid = &opts->fscontext_sid;
 		break;
 	case Opt_rootcontext:
-		if (opts->rootcontext)
+		if (opts->rootcontext_sid)
 			goto err;
-		opts->rootcontext = s;
-		if (selinux_initialized(&selinux_state))
-			parse_sid(NULL, s, &opts->rootcontext_sid);
+		dst_sid = &opts->rootcontext_sid;
 		break;
 	case Opt_defcontext:
-		if (opts->context || opts->defcontext)
+		if (opts->context_sid || opts->defcontext_sid)
 			goto err;
-		opts->defcontext = s;
-		if (selinux_initialized(&selinux_state))
-			parse_sid(NULL, s, &opts->defcontext_sid);
+		dst_sid = &opts->defcontext_sid;
 		break;
+	default:
+		WARN_ON(1);
+		return -EINVAL;
 	}
-
-	return 0;
+	rc = security_context_str_to_sid(&selinux_state, s, dst_sid, GFP_KERNEL);
+	if (rc)
+		pr_warn("SELinux: security_context_str_to_sid (%s) failed with errno=%d\n",
+			s, rc);
+	return rc;
 
 err:
 	if (is_alloc_opts) {
@@ -2681,37 +2649,27 @@ static int selinux_sb_mnt_opts_compat(struct super_block *sb, void *mnt_opts)
 	if (!opts)
 		return (sbsec->flags & SE_MNTMASK) ? 1 : 0;
 
-	if (opts->fscontext) {
-		if (opts->fscontext_sid == SECSID_NULL)
-			return 1;
-		else if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid,
-				       opts->fscontext_sid))
+	if (opts->fscontext_sid) {
+		if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid,
+			       opts->fscontext_sid))
 			return 1;
 	}
-	if (opts->context) {
-		if (opts->context_sid == SECSID_NULL)
-			return 1;
-		else if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid,
-				       opts->context_sid))
+	if (opts->context_sid) {
+		if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid,
+			       opts->context_sid))
 			return 1;
 	}
-	if (opts->rootcontext) {
-		if (opts->rootcontext_sid == SECSID_NULL)
-			return 1;
-		else {
-			struct inode_security_struct *root_isec;
+	if (opts->rootcontext_sid) {
+		struct inode_security_struct *root_isec;
 
-			root_isec = backing_inode_security(sb->s_root);
-			if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid,
-				       opts->rootcontext_sid))
-				return 1;
-		}
-	}
-	if (opts->defcontext) {
-		if (opts->defcontext_sid == SECSID_NULL)
+		root_isec = backing_inode_security(sb->s_root);
+		if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid,
+			       opts->rootcontext_sid))
 			return 1;
-		else if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid,
-				       opts->defcontext_sid))
+	}
+	if (opts->defcontext_sid) {
+		if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid,
+			       opts->defcontext_sid))
 			return 1;
 	}
 	return 0;
@@ -2721,7 +2679,6 @@ static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)
 {
 	struct selinux_mnt_opts *opts = mnt_opts;
 	struct superblock_security_struct *sbsec = selinux_superblock(sb);
-	int rc;
 
 	if (!(sbsec->flags & SE_SBINITIALIZED))
 		return 0;
@@ -2729,47 +2686,24 @@ static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)
 	if (!opts)
 		return 0;
 
-	if (opts->fscontext) {
-		if (opts->fscontext_sid == SECSID_NULL) {
-			rc = parse_sid(sb, opts->fscontext,
-				       &opts->fscontext_sid);
-			if (rc)
-				return rc;
-		}
+	if (opts->fscontext_sid) {
 		if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid,
 			       opts->fscontext_sid))
 			goto out_bad_option;
 	}
-	if (opts->context) {
-		if (opts->context_sid == SECSID_NULL) {
-			rc = parse_sid(sb, opts->context, &opts->context_sid);
-			if (rc)
-				return rc;
-		}
+	if (opts->context_sid) {
 		if (bad_option(sbsec, CONTEXT_MNT, sbsec->mntpoint_sid,
 			       opts->context_sid))
 			goto out_bad_option;
 	}
-	if (opts->rootcontext) {
+	if (opts->rootcontext_sid) {
 		struct inode_security_struct *root_isec;
 		root_isec = backing_inode_security(sb->s_root);
-		if (opts->rootcontext_sid == SECSID_NULL) {
-			rc = parse_sid(sb, opts->rootcontext,
-				       &opts->rootcontext_sid);
-			if (rc)
-				return rc;
-		}
 		if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid,
 			       opts->rootcontext_sid))
 			goto out_bad_option;
 	}
-	if (opts->defcontext) {
-		if (opts->defcontext_sid == SECSID_NULL) {
-			rc = parse_sid(sb, opts->defcontext,
-				       &opts->defcontext_sid);
-			if (rc)
-				return rc;
-		}
+	if (opts->defcontext_sid) {
 		if (bad_option(sbsec, DEFCONTEXT_MNT, sbsec->def_sid,
 			       opts->defcontext_sid))
 			goto out_bad_option;
@@ -2838,42 +2772,12 @@ static int selinux_fs_context_dup(struct fs_context *fc,
 				  struct fs_context *src_fc)
 {
 	const struct selinux_mnt_opts *src = src_fc->security;
-	struct selinux_mnt_opts *opts;
 
 	if (!src)
 		return 0;
 
-	fc->security = kzalloc(sizeof(struct selinux_mnt_opts), GFP_KERNEL);
-	if (!fc->security)
-		return -ENOMEM;
-
-	opts = fc->security;
-
-	if (src->fscontext) {
-		opts->fscontext = kstrdup(src->fscontext, GFP_KERNEL);
-		if (!opts->fscontext)
-			return -ENOMEM;
-	}
-	if (src->context) {
-		opts->context = kstrdup(src->context, GFP_KERNEL);
-		if (!opts->context)
-			return -ENOMEM;
-	}
-	if (src->rootcontext) {
-		opts->rootcontext = kstrdup(src->rootcontext, GFP_KERNEL);
-		if (!opts->rootcontext)
-			return -ENOMEM;
-	}
-	if (src->defcontext) {
-		opts->defcontext = kstrdup(src->defcontext, GFP_KERNEL);
-		if (!opts->defcontext)
-			return -ENOMEM;
-	}
-	opts->fscontext_sid = src->fscontext_sid;
-	opts->context_sid = src->context_sid;
-	opts->rootcontext_sid = src->rootcontext_sid;
-	opts->defcontext_sid = src->defcontext_sid;
-	return 0;
+	fc->security = kmemdup(src, sizeof(*src), GFP_KERNEL);
+	return fc->security ? 0 : -ENOMEM;
 }
 
 static const struct fs_parameter_spec selinux_fs_parameters[] = {
-- 
2.34.1

