Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD042C77B73
	for <selinux@archiver.kernel.org>; Thu, 20 Apr 2023 15:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbjDTPF6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Apr 2023 11:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbjDTPF5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Apr 2023 11:05:57 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA7C4ECE
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 08:05:55 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ud9so7071052ejc.7
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 08:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682003153; x=1684595153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZBYB6+ftJqpoofpF5FogMXzFAY0MQEJD+6bC/hiVxUo=;
        b=SW+Yh7vtZ/B3boOwwTMy5dWCY2QoX7nYN4n3dMXLLoL47wTPN3CfpaH2S4LJHyA6bs
         ZoicbAprFcU1+FbT/T5DwCGJEd4GxvAJAzVxGGALGrcOZHyXXuWIHNyiJ166sgZ8a1wo
         rDJm3AcN1ZfMl/lvyKFluQpLUsIY+vORVSNJsVrYnsU5clmRQkdgwEZ0iV7bDMrqhUSe
         UFDFcNdEtrX/VWUFhLARexxKVD/wMFgdgefYDVeBzBlTsMaWhpJQId635o1mN2FEAsUw
         3YPOB8sjzqRycRN83THFm3bZJWAdp5T1lJrnMPM2tHSnK0BzVjyVayMMyFDsi3WhcsCb
         pDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682003153; x=1684595153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBYB6+ftJqpoofpF5FogMXzFAY0MQEJD+6bC/hiVxUo=;
        b=Uuoi+BTBdV94kVndj9SubSUsuIu70OMjv1CuNcV2nEwZI7DHV9JwRF59Y4UT5MYong
         zV6u2R/F56tnkKVHVFHbsANtff16MAJrmKwtxTZxCBEpSSFvViR63naXjwWWSk8mgYpu
         nMbCzkFn7TvqNKtDtlewt6X1hU7F7k1Sb43CHTtrATobSgY7+pRV1YgKXSCu/lsE8AH1
         ylYzK8LSov7Jq/PV337pIymctRS8eWZJUeDJme0qG+hxNAqXtTrLcDSFsD+cyO+Zz4t1
         MVWMHZDLEtCTJnwW9AYWiTRBNcNL2Zu/orZMhI8IPpxvUDiFfJOFMarXX+ipzSE0F3ik
         o8Dw==
X-Gm-Message-State: AAQBX9fYF6ekxoT4O5SXz5rwezseEDdxChC9jPsDMaUKlABAgta4VA9R
        lQeOu/A16+n4X678NU2c5nE=
X-Google-Smtp-Source: AKy350bvp2suvaEezeNfXjDQ579mMA1vKPPnf2tQsxGTjARkM0M+mA8cYZ251Re4cwS/Iyj4cWjLcg==
X-Received: by 2002:a17:907:20cf:b0:8b1:3467:d71b with SMTP id qq15-20020a17090720cf00b008b13467d71bmr1848320ejb.48.1682003153492;
        Thu, 20 Apr 2023 08:05:53 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-119-201-251.95.119.pool.telefonica.de. [95.119.201.251])
        by smtp.gmail.com with ESMTPSA id jo2-20020a170906f6c200b009538cc79241sm827430ejb.56.2023.04.20.08.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 08:05:53 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org
Subject: [PATCH 6/6] selinux: declare read-only data arrays const
Date:   Thu, 20 Apr 2023 17:05:03 +0200
Message-Id: <20230420150503.22227-6-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230420150503.22227-1-cgzones@googlemail.com>
References: <20230420150503.22227-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The array of mount tokens in only used in match_opt_prefix() and never
modified.

The array of symtab names is never modified and only used in the
DEBUG_HASHES configuration as output.

The array of files for the SElinux filesystem sub-directory `ss` is
similar to the other `struct tree_descr` usages only read from to
construct the containing entries.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/hooks.c       | 2 +-
 security/selinux/selinuxfs.c   | 2 +-
 security/selinux/ss/policydb.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c49ce2044a17..99ded60a6b91 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -357,7 +357,7 @@ enum {
 };
 
 #define A(s, has_arg) {#s, sizeof(#s) - 1, Opt_##s, has_arg}
-static struct {
+static const struct {
 	const char *name;
 	int len;
 	int opt;
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 7cc7e2f0272b..bad1f6b685fd 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1649,7 +1649,7 @@ static int sel_make_ss_files(struct dentry *dir)
 	struct super_block *sb = dir->d_sb;
 	struct selinux_fs_info *fsi = sb->s_fs_info;
 	int i;
-	static struct tree_descr files[] = {
+	static const struct tree_descr files[] = {
 		{ "sidtab_hash_stats", &sel_sidtab_hash_stats_ops, S_IRUGO },
 	};
 
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index adcfb63b3550..97c0074f9312 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -42,7 +42,7 @@
 #include "services.h"
 
 #ifdef DEBUG_HASHES
-static const char *symtab_name[SYM_NUM] = {
+static const char *const symtab_name[SYM_NUM] = {
 	"common prefixes",
 	"classes",
 	"roles",
-- 
2.40.0

