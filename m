Return-Path: <SRS0=1yCI=3M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9101C2D0DB
	for <selinux@archiver.kernel.org>; Thu, 23 Jan 2020 12:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE3C24125
	for <selinux@archiver.kernel.org>; Thu, 23 Jan 2020 12:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UBku0h76"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgAWM51 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Jan 2020 07:57:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60589 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726170AbgAWM51 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Jan 2020 07:57:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579784246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zJqVOqKDzdK8RLPmvzXdNuUPuXVrwd2ey9Kx5GAqz34=;
        b=UBku0h76CEaSUU9UoqiDSXbTeH4mNtwbuRM+/nkiwFMcbWHBIAvb440UFxoY8XKwaRGj3R
        BrfNyfVFRODc1Ml26M0LfujddsAg2vtXUHfZaKOoENcI8Fh3RN1E7ICH56hvrZnYe4FsSw
        bnqKoB2nzWlDMoiogNPJco+LB3VHhS8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-B95MO0ICN9q7iOIjrFwbLg-1; Thu, 23 Jan 2020 07:57:21 -0500
X-MC-Unique: B95MO0ICN9q7iOIjrFwbLg-1
Received: by mail-wm1-f70.google.com with SMTP id b202so444484wmb.2
        for <selinux@vger.kernel.org>; Thu, 23 Jan 2020 04:57:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zJqVOqKDzdK8RLPmvzXdNuUPuXVrwd2ey9Kx5GAqz34=;
        b=fD96gqrNdy0PGPzoehCKrTh2hS3GgldjIDSdJ5Gt+YT5Qkbw19yZ+M0/oBJu5QTdlE
         BGIXIbKGXuz5LW8qKLCKyIcAWsdFmAfkqgft9fBS3/VLnAVXk5oR1rjMq4Edz1KME/L+
         rPdu7AVS6vaFlUA3g7a6aQ3m78nntuBP3jx41qcdOzcHTwffGx2jThCyN+Vvhwhym5KB
         AT5EwRUztGYMwcSb8mrYveW/mP90hQ7xiY9lnIHCMknzriEE+9vIkeu2bZnci5F3rWCZ
         79bY6LmdzzC4C32c40v1vRGT7GgQjrTgfIMZHwlPODZEKTMHmw/J428dDLyk4EawHkcM
         cBEA==
X-Gm-Message-State: APjAAAWVsGZmluMxdeaVILaapgMsHKxAPm1QfjRtUxeCqhUBN1mZIvBg
        ksRlbetzsXsaZ/OlPiYa7S3AtdkN0hY3cNmiseZYkm/cAlzYA8hoZHD6iNU9Kst2u2t5EhWVGNY
        1c4xF43QQdIIzL+vghw==
X-Received: by 2002:a5d:6b82:: with SMTP id n2mr18741917wrx.153.1579784240410;
        Thu, 23 Jan 2020 04:57:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqzUTQcVTWACh0B2CxImDMNMV7fLUpPsMvBk4RHzwzyiZ+ZexfCVKXput9N6CIkXyNjjE97u9g==
X-Received: by 2002:a5d:6b82:: with SMTP id n2mr18741896wrx.153.1579784240174;
        Thu, 23 Jan 2020 04:57:20 -0800 (PST)
Received: from omos.redhat.com (ip-46.34.233.121.o2inet.sk. [46.34.233.121])
        by smtp.gmail.com with ESMTPSA id d8sm2821028wrx.71.2020.01.23.04.57.19
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 04:57:19 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v2 2/4] libsepol: remove leftovers of cil_mem_error_handler
Date:   Thu, 23 Jan 2020 13:57:14 +0100
Message-Id: <20200123125716.12662-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123125716.12662-1-omosnace@redhat.com>
References: <20200123125716.12662-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Commit 4459d635b8f1 ("libsepol: Remove cil_mem_error_handler() function
pointer") replaced cil_mem_error_handler usage with inline contents of
the default handler. However, it left over the header declaration and
two callers. Convert these as well and remove the header declaration.

This also fixes a build failure with -fno-common.

Fixes: 4459d635b8f1 ("libsepol: Remove cil_mem_error_handler() function pointer")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libsepol/cil/src/cil_mem.h     | 1 -
 libsepol/cil/src/cil_strpool.c | 8 ++++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/libsepol/cil/src/cil_mem.h b/libsepol/cil/src/cil_mem.h
index 902ce131..794f02a3 100644
--- a/libsepol/cil/src/cil_mem.h
+++ b/libsepol/cil/src/cil_mem.h
@@ -36,7 +36,6 @@ void *cil_calloc(size_t num_elements, size_t element_size);
 void *cil_realloc(void *ptr, size_t size);
 char *cil_strdup(const char *str);
 int cil_asprintf(char **strp, const char *fmt, ...);
-void (*cil_mem_error_handler)(void);
 
 #endif /* CIL_MEM_H_ */
 
diff --git a/libsepol/cil/src/cil_strpool.c b/libsepol/cil/src/cil_strpool.c
index 97d4c4b9..2598bbf3 100644
--- a/libsepol/cil/src/cil_strpool.c
+++ b/libsepol/cil/src/cil_strpool.c
@@ -80,8 +80,8 @@ char *cil_strpool_add(const char *str)
 		int rc = hashtab_insert(cil_strpool_tab, (hashtab_key_t)strpool_ref->str, strpool_ref);
 		if (rc != SEPOL_OK) {
 			pthread_mutex_unlock(&cil_strpool_mutex);
-			(*cil_mem_error_handler)();
-			pthread_mutex_lock(&cil_strpool_mutex);
+			cil_log(CIL_ERR, "Failed to allocate memory\n");
+			exit(1);
 		}
 	}
 
@@ -104,8 +104,8 @@ void cil_strpool_init(void)
 		cil_strpool_tab = hashtab_create(cil_strpool_hash, cil_strpool_compare, CIL_STRPOOL_TABLE_SIZE);
 		if (cil_strpool_tab == NULL) {
 			pthread_mutex_unlock(&cil_strpool_mutex);
-			(*cil_mem_error_handler)();
-			return;
+			cil_log(CIL_ERR, "Failed to allocate memory\n");
+			exit(1);
 		}
 	}
 	cil_strpool_readers++;
-- 
2.24.1

