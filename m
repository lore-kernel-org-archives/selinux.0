Return-Path: <SRS0=ealm=ZH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230A3C33C99
	for <selinux@archiver.kernel.org>; Fri, 15 Nov 2019 15:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC53E20733
	for <selinux@archiver.kernel.org>; Fri, 15 Nov 2019 15:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WByWlTiX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfKOPQb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 Nov 2019 10:16:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20270 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727429AbfKOPQa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 Nov 2019 10:16:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573830989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rJDHnMpLPNBipzjUuMEKojnhSlR5u5vorthOUCcXJDY=;
        b=WByWlTiXDSmHuR5D+hgJ3Bh+R2DAnaYUFaDrVspk3VhIDVo8LUFn9fjcXPWcvBNmUZsbC2
        W6zDJl6C8VKR2F+I3V4tfuHv+LVhIzSNPhdxzaHHqyrxeo4rsmecY9pGU+etcUp0VTD9Ig
        yG17arDkPK7EilUjMxXLVNiE0d3PUaM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-U855JNJvMWiPwtlbA-sX2Q-1; Fri, 15 Nov 2019 10:16:28 -0500
Received: by mail-wm1-f69.google.com with SMTP id m68so7101213wme.7
        for <selinux@vger.kernel.org>; Fri, 15 Nov 2019 07:16:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ABpl1Fm6q8zGwc1QaGo7DyedQRdBuLrLnJ/fam9pfg=;
        b=EyFd/A1RTUjpWqGiBZd5CIx6uuj+o/UBIayIjlPn7WezifaHpxzW/9OcwHxB/21y+o
         jBgTowloVLPqie0Y7WvmNxhtINJOALFtdBMaWcRVF9QT5J5u6+RnCYwFNyrNUh2lFDJK
         lAW8+RqEdvfLlptSpaN+dtLFO3g8mqUitHaSJ2W17QD7eQkIQjM7vDNAniQ86k5gqmHU
         AxlCrtOwX/9n28t1T+UxXaReBs+0O0ACytorWhmn9LtTrDxPtQyF70Tzlw2ENJSSzjEm
         IQiasWtzjAxs3fOQ4YB9tFbbE1j+jpPfB5bcXHBOVs9etNaMIA69PPWWICd0L5M9JYKA
         3XWg==
X-Gm-Message-State: APjAAAVjPwhvDLsujNY7sJztyhnfsQvCMUgTUGz2PgEEwGxF7yWF3hYx
        b9eBKwCbpKqO+6gSkb1F7sK26NLy6XcrSf2Nj+zgAT+YAfCSc1d2Hyxu1bBmR1CDSaUFPttH8Np
        RbC8zXW8stMquDnLJIg==
X-Received: by 2002:a05:600c:22d1:: with SMTP id 17mr16171374wmg.31.1573830987557;
        Fri, 15 Nov 2019 07:16:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqzI7h2Mb/sEyDaYOsNd3KrlCaVSy+dhXjj/lcQty3xz6ItNZjmwBoFam+fAHfe9R3piSvqoGQ==
X-Received: by 2002:a05:600c:22d1:: with SMTP id 17mr16171346wmg.31.1573830987312;
        Fri, 15 Nov 2019 07:16:27 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id j63sm10337239wmj.46.2019.11.15.07.16.26
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 07:16:26 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite v2 2/3] policy: add fallbacks for Fedora-specific macros
Date:   Fri, 15 Nov 2019 16:16:22 +0100
Message-Id: <20191115151623.265770-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191115151623.265770-1-omosnace@redhat.com>
References: <20191115151623.265770-1-omosnace@redhat.com>
MIME-Version: 1.0
X-MC-Unique: U855JNJvMWiPwtlbA-sX2Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

dev_rw_infiniband_dev() and mount_rw_pid_files() are not defined in
refpolicy. Fall back to dev_rw_generic_files() and
mount_rw_runtime_files() if they are not defined.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_policy.if | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/policy/test_policy.if b/policy/test_policy.if
index 40e7499..e31345e 100644
--- a/policy/test_policy.if
+++ b/policy/test_policy.if
@@ -71,3 +71,17 @@ interface(`userdom_search_generic_user_home_dirs', `
     userdom_search_user_home_content($1)
 ')
 ')
+
+# Workarounds for refpolicy:
+
+ifdef(`dev_rw_infiniband_dev', `', ` dnl
+interface(`dev_rw_infiniband_dev', `
+    dev_rw_generic_files($1)
+')
+')
+
+ifdef(`mount_rw_pid_files', `', ` dnl
+interface(`mount_rw_pid_files', `
+    mount_rw_runtime_files($1)
+')
+')
--=20
2.23.0

