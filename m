Return-Path: <SRS0=qlmh=3W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9229CC35249
	for <selinux@archiver.kernel.org>; Sun,  2 Feb 2020 01:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE8220661
	for <selinux@archiver.kernel.org>; Sun,  2 Feb 2020 01:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EqLkIhXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgBBBqc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 1 Feb 2020 20:46:32 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:43614 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbgBBBqc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 1 Feb 2020 20:46:32 -0500
Received: by mail-pf1-f202.google.com with SMTP id x199so6723118pfc.10
        for <selinux@vger.kernel.org>; Sat, 01 Feb 2020 17:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cWMg+lMkC5CwgYJ9EZeOZlpHEi0qWTvf3rAR3TItwx8=;
        b=EqLkIhXgRZk2d6ttlAE/IrZ07I3+F1wAeV3BpJTqmC62cUYA3mD9hPRRTbkA03hsgN
         IZj7P8/Hh7HdsYRONo4wDDiP3nDUp21b5agZa+7wz47v6Z4J3aIbKJ01Ijhb0VFhD5al
         phf/pX8/lAzg+hoBDNPuoBddw2c/szLCfaZl6fVoPDP6PjfJpCbm+m3QP5C/K8OeVgme
         TUSgsYlXF75y8aLvZZUQKnZvFgNS2KarOs27Hb4TU+Qdpv0mgD9aNcTyvy3YVJ+ccsaL
         h2wNhFKg3rKRc/pYB/tbNlyfIMbCC76UPFflz9iT8TgR2iZvosTXvwuVovoQvH61R6Hy
         eVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cWMg+lMkC5CwgYJ9EZeOZlpHEi0qWTvf3rAR3TItwx8=;
        b=QkBWppGc6Pw0qrgehX3Ri1g4cL8zESLpOaOVg6rJhp1GJ2oLy16NIMJ+uC7KAkjh8X
         Xo4WxmHOSRkGtoFPGGUNaHmADsva3dgGv2WKu1ByZ3n88M3WDUdh1+LrQATzhGuUJaMh
         kOBhIZwzCk7JVDdJd0DZMRd+HuPhnv90NoLY8KPZDRkWDcZZ4ADmbt/QLAwSqi7IB2LT
         sDCpEI6MoBjG8HAAZlYTa99rpveO0DWZuPR3LvtklGRZvp5BjFt5OfWvrTwXEAYZan9P
         mMuUdaH+j7sDrUiJdN3aZ/gVIRA/IpVT6uDeFL4V5zze57If2xJJ6fZ8ou2piA7MojMa
         gcqA==
X-Gm-Message-State: APjAAAUK9RvgAYRPtHuKiBgtUuXwhsuN7krmmTf3t2LEx1xYtnSjMEoK
        +U8NyB+WWAOmQQUEn++SC2xi2J+2yTc=
X-Google-Smtp-Source: APXvYqytCAuvL8qC7xByebS+X1UOErAOhxRRMWluFWrxoVVILntVsMJsPYSA5+Z1ZQQj6bpOOlDIGN2jGQ4=
X-Received: by 2002:a63:66c6:: with SMTP id a189mr16560150pgc.401.1580607991518;
 Sat, 01 Feb 2020 17:46:31 -0800 (PST)
Date:   Sat,  1 Feb 2020 17:46:23 -0800
Message-Id: <20200202014624.75356-1-hridya@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH] selinux: Fix typo in filesystem name
From:   Hridya Valsaraju <hridya@google.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Hridya Valsaraju <hridya@google.com>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Correct the filesystem name to "binder" to enable
genfscon per-file labelling for binderfs.

Fixes: 7a4b5194747 ("selinux: allow per-file labelling for binderfs")
Signed-off-by: Hridya Valsaraju <hridya@google.com>
---

Hello,

I seem to have made the typo/mistake during a rebase. Sorry about that
:(

Thanks,
Hridya

 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 89fe3a805129..d67a80b0d8a8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -699,7 +699,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 
 	if (!strcmp(sb->s_type->name, "debugfs") ||
 	    !strcmp(sb->s_type->name, "tracefs") ||
-	    !strcmp(sb->s_type->name, "binderfs") ||
+	    !strcmp(sb->s_type->name, "binder") ||
 	    !strcmp(sb->s_type->name, "pstore"))
 		sbsec->flags |= SE_SBGENFS;
 
-- 
2.25.0.341.g760bfbb309-goog

