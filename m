Return-Path: <SRS0=wfQh=3L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156C2C2D0DB
	for <selinux@archiver.kernel.org>; Wed, 22 Jan 2020 15:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB842217F4
	for <selinux@archiver.kernel.org>; Wed, 22 Jan 2020 15:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VoE+pBIq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgAVPrE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Jan 2020 10:47:04 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29496 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725884AbgAVPrE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Jan 2020 10:47:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579708023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fdYXrgPZPf1+pERqCah9TmaBcw2cP6a64QeBfDJVZGU=;
        b=VoE+pBIq+1ANmqOUVNBBvVpObooVTrlDzxRau4XWMPCaEMERgZllpyArPNtfuQZct0HaVP
        IR4C5ziw7FJHzwStDWRRsvUlukEnsDOMvm+m5ZzTGqlPKh+7z6zzo5kqfFTLePtzDgQI5B
        gmKtngCehjTGlsNiypN2NUHzjVCi8QI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-JLi_VJd1Px-tIn3SUoriiw-1; Wed, 22 Jan 2020 10:47:00 -0500
X-MC-Unique: JLi_VJd1Px-tIn3SUoriiw-1
Received: by mail-wm1-f71.google.com with SMTP id t17so1557080wmi.7
        for <selinux@vger.kernel.org>; Wed, 22 Jan 2020 07:47:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fdYXrgPZPf1+pERqCah9TmaBcw2cP6a64QeBfDJVZGU=;
        b=N3oSee+bnwimG4VhFg799g11PCiyC+hxonKdRzL4/rzvM3hbnt9ysMSqAD+Q2nv2AD
         FniwF1BhAFLnR1lMIONh+qJbQoANMNess4qNk38suzY/HXqF5PkhzrwoQAJhJCmFkwYx
         GCvOJ6O90JnE91ebOszjbTYEKx/2lHQgswmNNm0qVOEjRTyrFWyMIDWYCTRhBdE85eGU
         I6cllftoyJGIPMJBiWapzWR7d3Unv0vu7v3fU/kLPfYpDgPt/QyWsLrB2uHfnQBDsiHw
         P2IVVLcYiHLsrfcFQSfNOkksC7zOeFCYacSEpTc20VIwdngbApzLZ4ntk/DxsWy0++3i
         jcQA==
X-Gm-Message-State: APjAAAVzcpsov4BZHxlWNqh+90jytMUQFLWKYpMEypDPbFLH8ZogyHcN
        M7rl18UG5GYU/hhUFGuRbmY1IC5Xob0+4CkvX3mw92t+shTQeidsQY7eeaRebsBEp11hCwVjCc9
        +OMjlFglU00ACbYhGYg==
X-Received: by 2002:adf:e5ce:: with SMTP id a14mr11674634wrn.214.1579708019395;
        Wed, 22 Jan 2020 07:46:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqyh4ISQmHOUO7j48EozVyRuuy0usQRT+8U03M01QKybRiDwzu+JmCxliZKMquLwiX3VKpCgDg==
X-Received: by 2002:adf:e5ce:: with SMTP id a14mr11674620wrn.214.1579708019223;
        Wed, 22 Jan 2020 07:46:59 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c5sm4811788wmb.9.2020.01.22.07.46.58
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 07:46:58 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace 2/4] libsepol: remove unused cil_mem_error_handler
Date:   Wed, 22 Jan 2020 16:46:53 +0100
Message-Id: <20200122154655.257233-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200122154655.257233-1-omosnace@redhat.com>
References: <20200122154655.257233-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It is declared in an internal header but never defined. Remove it.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libsepol/cil/src/cil_mem.h     | 1 -
 libsepol/cil/src/cil_strpool.c | 2 --
 2 files changed, 3 deletions(-)

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
index 97d4c4b9..508541d6 100644
--- a/libsepol/cil/src/cil_strpool.c
+++ b/libsepol/cil/src/cil_strpool.c
@@ -80,7 +80,6 @@ char *cil_strpool_add(const char *str)
 		int rc = hashtab_insert(cil_strpool_tab, (hashtab_key_t)strpool_ref->str, strpool_ref);
 		if (rc != SEPOL_OK) {
 			pthread_mutex_unlock(&cil_strpool_mutex);
-			(*cil_mem_error_handler)();
 			pthread_mutex_lock(&cil_strpool_mutex);
 		}
 	}
@@ -104,7 +103,6 @@ void cil_strpool_init(void)
 		cil_strpool_tab = hashtab_create(cil_strpool_hash, cil_strpool_compare, CIL_STRPOOL_TABLE_SIZE);
 		if (cil_strpool_tab == NULL) {
 			pthread_mutex_unlock(&cil_strpool_mutex);
-			(*cil_mem_error_handler)();
 			return;
 		}
 	}
-- 
2.24.1

