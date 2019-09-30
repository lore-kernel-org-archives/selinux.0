Return-Path: <SRS0=KDcg=XZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6729AC35280
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 10:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CDFE216F4
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 10:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fi/NAM1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730824AbfI3KtB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 Sep 2019 06:49:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47265 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730819AbfI3KtA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 30 Sep 2019 06:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569840539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Te7BJZAe86InjFPZpLM7gkllmIbHYi4gHqkSeuHEL4Y=;
        b=Fi/NAM1sLWmLdWUf91URi7CQUEexqaC4bcZNPgtfDgqUb+8tm+PRdrl9l8w5JB996s8YSg
        DATZ7cls+ZqT/WnqbOQ2Ff8CdriLHO9hpOlNfUFBJIBH3s6Ip5YUfnaQSFOdic0gzXigNl
        wA0ct2Ynvk8LP+K46JlCDvTqh+fAsv8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-wuMQaOXHNpqXjtW9-C9PLQ-1; Mon, 30 Sep 2019 06:48:57 -0400
Received: by mail-wr1-f69.google.com with SMTP id b6so4365114wrx.0
        for <selinux@vger.kernel.org>; Mon, 30 Sep 2019 03:48:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x4dDWvD863WnKkG6dQE65TW0I/Db5xEu7HCzS8sROPI=;
        b=U/jDA21bqxCvhMyHEGfd/DD3ExZgGiC4q2dEXSHz0DcbA+YP4jI7WMqvdi5cZp25dQ
         apVVG3DRmNMjqzOstfGz7lJ1EbomZuCu/tRgMF2XL1Vl7Sz+ybXNmPnAuA0629Z5XPDi
         SHnJuzX6SUU1O9P1lxp+guPyu/3ClJJco7vu97rT1T3ZO2k/7gYAHMaa7NiFheEy6Aqj
         K7hoHmYsM6l1zoMGdK4dcw/GUfgkljwvFEtC2V/fbGlbf39V+JFLs+zmpu1XGpC+Yer7
         Q3xoxHUdu/Xi8jA1YPsp0n1tyFyF1qVYU/cSUOC0XmlcI/4dHlQXGe+qcN83kwPeKRKv
         qy1w==
X-Gm-Message-State: APjAAAXNNmD7qf2ovbpeA5Ae+fgNpP+OwOj1WVsY99fPhB0hs28K7TLw
        QPmsgdCA/rHHW9uTXG7hFUifWVGi4eMDdimqGfr7go3U5/9LfmMMeTZ1GvkrowVVvPJ7WwbRP6v
        5zz7WkqNYqSGWj1aLAg==
X-Received: by 2002:a05:600c:2153:: with SMTP id v19mr17065667wml.146.1569840536046;
        Mon, 30 Sep 2019 03:48:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqybmNXWmYsFluY3QDHpT7w2Yv/tw72WtIxspBB9Of/h61FTvILbhsnhp4BTy2H2FpP0xuPZPQ==
X-Received: by 2002:a05:600c:2153:: with SMTP id v19mr17065659wml.146.1569840535826;
        Mon, 30 Sep 2019 03:48:55 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id i73sm27081254wmg.33.2019.09.30.03.48.54
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 03:48:55 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 2/3] policy: add fallbacks for Fedora-specific macros
Date:   Mon, 30 Sep 2019 12:48:49 +0200
Message-Id: <20190930104850.5482-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190930104850.5482-1-omosnace@redhat.com>
References: <20190930104850.5482-1-omosnace@redhat.com>
MIME-Version: 1.0
X-MC-Unique: wuMQaOXHNpqXjtW9-C9PLQ-1
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
2.21.0

