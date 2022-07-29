Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E02BC00144
	for <selinux@archiver.kernel.org>; Fri, 29 Jul 2022 12:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbiG2MC5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 Jul 2022 08:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiG2MC5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Jul 2022 08:02:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61AC7863DF
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659096175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a5EhKEszb9HRRMcqbAiShYxIGCu2o2tljuJt8lp8NE8=;
        b=QGTv4ivb4GGRhcnQzOymxfkIYbOAqw8SUDLQwwGLkE5XGMKJCbXXPYFFC9IaGLsMZl1VQK
        7dXtAov2H/iFyCbTlVr9YLxea2exX8KsByYk5cjFjvCpljaVug55G9T9Rj3dAuXQnMknfR
        uV8Ej8uEwOSVQvLYDL1380gZ9O4ySLU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-61-O7-9ICYLPomvFMh1kI3hag-1; Fri, 29 Jul 2022 08:02:54 -0400
X-MC-Unique: O7-9ICYLPomvFMh1kI3hag-1
Received: by mail-wr1-f69.google.com with SMTP id h18-20020adfaa92000000b0021ec200d50fso1143286wrc.14
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=a5EhKEszb9HRRMcqbAiShYxIGCu2o2tljuJt8lp8NE8=;
        b=hO7TjxuUCz72EhNNk++0Z7YoL/Zk1A3Jgn6f2uAf8YYXKmx0SDx2/849k/iYHxtDYM
         GrM3wB0wDG0Q/ZzSTdtaftE2EuQZ9ZfmfHZwepcCNaT5zB4b/nEOyW2qAKCz1SA+Rkgb
         flZPo15O7/d5ncJbpsxjcmHChu1fjXwbglnSwka+G5zPIhDi5iFMrLl0Y97i9bLSM0n8
         fAP+pUyDyEal1huZp+ZsNzwWIzuukoGqQi+3Hc5n9YBr0TbdLbGt7EMFkPnQsMfskAAH
         FsWVcvvlQvVuMW00qMqkh9d7OAxZINRHa3MP2r6SpjiCyVK6XpbabgZyB/HLvIo/asP3
         IR6Q==
X-Gm-Message-State: AJIora+Sk2zNivaXgJyp3pPs+FVJVkURN0zSFKTaMxh8Pav5ehaig/Li
        u+dJvVUpTeVd8/mCFJpetJ94gZKA/wXKXdqKGd3z6kjpTxzPXhQxg3goPsdftr4w9F5pDik+X/9
        rSLuQ71vahXuKN6tB0EHK60TQSykNS/T9yaejiiJxDCSInpz7iW06Hr8u0S4R8qX59q3Q0Q==
X-Received: by 2002:a05:600c:1c83:b0:3a3:2631:2fec with SMTP id k3-20020a05600c1c8300b003a326312fecmr2185964wms.155.1659096172356;
        Fri, 29 Jul 2022 05:02:52 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vUb6WsemWxZsDgcJTl5rXBJgaVLK3H/5w6jWO0VVYq3RBCzXlOUHZVIa/mnxtCdJXY9FQb0Q==
X-Received: by 2002:a05:600c:1c83:b0:3a3:2631:2fec with SMTP id k3-20020a05600c1c8300b003a326312fecmr2185935wms.155.1659096172003;
        Fri, 29 Jul 2022 05:02:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id i3-20020a05600c354300b003a2e92edeccsm9590622wmq.46.2022.07.29.05.02.50
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 05:02:50 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 12/24] test_filesystem.te: remove redundant dontaudit rules
Date:   Fri, 29 Jul 2022 14:02:17 +0200
Message-Id: <20220729120229.207584-13-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220729120229.207584-1-omosnace@redhat.com>
References: <20220729120229.207584-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

These accesses should already be allowed to unconfined_t via
files_type().

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_filesystem.te            | 2 --
 policy/test_filesystem_name_trans.te | 4 +---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/policy/test_filesystem.te b/policy/test_filesystem.te
index 5de489c..4942e0d 100644
--- a/policy/test_filesystem.te
+++ b/policy/test_filesystem.te
@@ -57,7 +57,6 @@ allow test_filesystem_t test_filesystem_filecon_t:file { open read getattr relab
 fs_associate(test_filesystem_filetranscon_t)
 type_transition test_filesystem_t test_filesystem_file_t:file test_filesystem_filetranscon_t;
 allow test_filesystem_t test_filesystem_filetranscon_t:file { create getattr open write relabelfrom };
-dontaudit unconfined_t test_filesystem_filetranscon_t:file { getattr read };
 
 # For NFS
 type_transition test_filesystem_t test_file_t:file test_filesystem_filetranscon_t;
@@ -268,7 +267,6 @@ fs_associate(test_filesystem_inode_setxattr_no_associate_t)
 # Create test file
 allow test_filesystem_inode_setxattr_no_associate_t self:file { create relabelfrom relabelto };
 # neverallow unconfined_t test_filesystem_inode_setxattr_no_associate_t:filesystem { associate };
-dontaudit unconfined_t test_filesystem_filecon_t:file { getattr read };
 allow test_filesystem_inode_setxattr_no_associate_t unconfined_t:dir { add_name write };
 allow test_filesystem_inode_setxattr_no_associate_t unconfined_t:file { create relabelfrom relabelto };
 
diff --git a/policy/test_filesystem_name_trans.te b/policy/test_filesystem_name_trans.te
index 7e336e4..9956c07 100644
--- a/policy/test_filesystem_name_trans.te
+++ b/policy/test_filesystem_name_trans.te
@@ -12,12 +12,10 @@ files_type(test_filesystem_filenametranscon2_t)
 fs_associate(test_filesystem_filenametranscon1_t)
 type_transition test_filesystem_t test_filesystem_file_t:file test_filesystem_filenametranscon1_t "name_trans_test_file1";
 allow test_filesystem_t test_filesystem_filenametranscon1_t:file { create getattr open write };
-dontaudit unconfined_t test_filesystem_filenametranscon1_t:file { getattr read };
-#
+
 fs_associate(test_filesystem_filenametranscon2_t)
 type_transition test_filesystem_t test_filesystem_file_t:file test_filesystem_filenametranscon2_t "name_trans_test_file2";
 allow test_filesystem_t test_filesystem_filenametranscon2_t:file { create getattr open write };
-dontaudit unconfined_t test_filesystem_filenametranscon2_t:file { getattr read };
 
 ### NFS Rules ##########
 type_transition test_filesystem_t test_file_t:file test_filesystem_filenametranscon1_t "name_trans_test_file1";
-- 
2.37.1

