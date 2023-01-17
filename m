Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEA9C54E76
	for <selinux@archiver.kernel.org>; Tue, 17 Jan 2023 17:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjAQRKP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Jan 2023 12:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjAQRKN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Jan 2023 12:10:13 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865DA2CFEA
        for <selinux@vger.kernel.org>; Tue, 17 Jan 2023 09:10:12 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id qx13so18534769ejb.13
        for <selinux@vger.kernel.org>; Tue, 17 Jan 2023 09:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qubpaDRrlbwYt4tWsF/sG7kTygyh0iWIJmVI+kLUTkE=;
        b=GGw1vMLrYSX58FZiL9RZVbMOv2lq6z+Hd7MT6KawQltGK5COZno9MdOy7zo37kN9I8
         bHB1B5Kmn0lKlUTu+sW7ZhnNSsDRY6iO36kE7WybV/9/2i//cFRnnSXqtbvR5uuVWnKP
         sEHTC01/uB83Si0zOWcpYgEQwqLJR8dKIMEnNH3zYG/GZhPF0PAZaKPgB1xHfJ3ArYe6
         1uGDHZwkA1b+RFcl5ISMg8bnkG/Iee2ZbDF6JbRGZkZlabNrG0NRYMCz/xRINMV/We3K
         Zk3ub1pSVBRAaUX90gFM4fLPXRnHAgD7quZaUZKD7k4ui5Rydk/Lz7YA02y6tVhcxywY
         aaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qubpaDRrlbwYt4tWsF/sG7kTygyh0iWIJmVI+kLUTkE=;
        b=Udu5VxVxRyhe6ATKKf3xXEbOppwVHJT6cGibaVKShk3/R0EVh7LJFhpEWGKS2dqLg5
         bu1weSISRs1jZgEmWMj9OQDNU0ACSSBFGE5zGKRhG9YQVehTtV85wvJnMc9lnDYNblP6
         KT/io10uTIlIlmehR6vx/wrohK/YVc2wD5nADboyA1Eag9bZHIuN7JfXC3K4OXspf62T
         GyvWSJmaoSIdvpGbFIsalNlsasICxkKMdEV3EIXLsUimr2kcPpHFTWhBYg8dpDjSRh0H
         7ksyFIXN4khED6CeJYHNthalQ764K44cr2prGa6pkq8dCpQL0LB3XqmadJr56ymPBx+r
         kA+Q==
X-Gm-Message-State: AFqh2koby9B7UfwXNHePHxbssny0MCxWD+YBeLD0VT1lmu1u2rFzZCVd
        no4Y98qxwlfqfwmc9wvUC6rwcNmUopPF2g==
X-Google-Smtp-Source: AMrXdXtB5chijNWwi0HpVMK6uU+2MN30rezVA4dEBhyiYXENCV+vwPl5L3x8LEivJLMKiIYGGpONAQ==
X-Received: by 2002:a17:907:d609:b0:7c1:54b9:c688 with SMTP id wd9-20020a170907d60900b007c154b9c688mr4535885ejc.60.1673975411084;
        Tue, 17 Jan 2023 09:10:11 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-176-035.95.116.pool.telefonica.de. [95.116.176.35])
        by smtp.gmail.com with ESMTPSA id q27-20020a1709066b1b00b0087329ff593fsm819851ejr.144.2023.01.17.09.10.10
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:10:10 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [TESTSUITE PATCH v2] policy: handle files_list_pids() renaming in Refpolicy
Date:   Tue, 17 Jan 2023 18:09:33 +0100
Message-Id: <20230117170933.16807-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230116214626.28955-1-cgzones@googlemail.com>
References: <20230116214626.28955-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

files_list_pids() has been superseded and marked deprecated in the
Reference Policy since Jun 2020[1].  In the latest release it has been
completely removed[2].

Call both the old and replacement interface conditionally to support
recent Refpolicy versions as well as old ones.

[1]: https://github.com/SELinuxProject/refpolicy/commit/be04bb3e7e63671ed8a3c501a2ee76e11c3b92bb
[2]: https://github.com/SELinuxProject/refpolicy/commit/3ca0cd59d7a9b531dd3620a02940396343fe2ed5

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
   call both interfaces conditionally
---
 policy/test_global.te | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/policy/test_global.te b/policy/test_global.te
index e95102a..052c7dd 100644
--- a/policy/test_global.te
+++ b/policy/test_global.te
@@ -121,7 +121,6 @@ allow testsuite_domain proc_t:file { getattr read open };
 files_list_var(testsuite_domain)
 files_list_home(testsuite_domain)
 dev_read_rand(testsuite_domain)
-files_list_pids(testsuite_domain)
 require {
 	type root_t;
 	type etc_t;
@@ -154,6 +153,14 @@ selinux_compute_create_context(testsuite_domain)
 selinux_compute_relabel_context(testsuite_domain)
 selinux_compute_user_contexts(testsuite_domain)
 
+# Reference policy renamed files_list_pids() to files_list_runtime()
+ifdef(`files_list_pids', `
+    files_list_pids(testsuite_domain)
+')
+ifdef(`files_list_runtime', `
+    files_list_runtime(testsuite_domain)
+')
+
 ifdef(`distro_redhat', `
     ifdef(`auth_read_passwd', `
         auth_read_passwd(testsuite_domain)
-- 
2.39.0

