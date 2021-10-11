Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10849C433EF
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3D0160EE5
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 16:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbhJKQ2m (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbhJKQ2k (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 12:28:40 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5447C061749
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:39 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id w19so10008862edd.2
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 09:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sC8cwKG+2oCE7BgfnouvfvbA61CTdboV/LZj7svDuTg=;
        b=np4HMosfk4WYFT31XqjmgJtK0cavhnkwvcS4egLp1jeMtTc8SHYFm5jCnh2b3O65w3
         x7KlQjOwY4j7C8eXpB6iBvoHpaWXaekaeC9jBZDBNTPKq6lljfbza9MIa5wWBCz9PiVw
         CYOtRjpOrW8ntHFQe+hgyZDP2PrUMGn56ver6a+Fs3XHUhsixq//ESVfNtppD+CDj904
         ZV8PTtWpOi4zXjaEMGJKAFN3UE4k6RImab420dJkAcbdEQO9UXTYB3I2mIOwwQ89WRH/
         dVeCTQltOZsl5kJePR9MOJHcEYfZNPOrueWtxkGEdtFWVPq9fFowagT7pRHgPGQ4mfin
         AUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sC8cwKG+2oCE7BgfnouvfvbA61CTdboV/LZj7svDuTg=;
        b=cKaHryLg1U+v6gpOyXqhRDW6WIfsiOzNNoYxYwJJPpi5qIjwqmyl2jmywP1RPs/7md
         Ouh2QKUuKT13p6ApS2Yc+fHs7CnctKiNo4CHvQ5S9uk+6aOPpCaQzvg5jKbL3s6gwSVK
         YAGFkKl9FjEIAmZfYPeiDz4wPW7cMlpykFQgxQa3QtOz0P2k7ktm3HHrS9secN/70m3s
         LeMHhT3/3HKVLGSxXmVZfZltG0e358MGhLPgyy/I2kwdHz1t/PfjonO0rZIbpw6d5Q0e
         n+qMt0sx7pVmUfYq/heOLLYl5e8NqHNbgi+hx4De/d/ecHSudRUf4abyWZ1c6RCMClaH
         5Iew==
X-Gm-Message-State: AOAM530Hvd8QOsoXTrzC9bnkJp9BkGjQ8CFGzefrzBCojrB6p5Ai6lwN
        Jjjm6VUibD80DrZbeGVOnMecvSM9vn8=
X-Google-Smtp-Source: ABdhPJxwuUdipVINgFMA1UhXRHgOoEuRdYQMEeISoV4zpp48aRuP58Cm1eE1G+XvC4UkQt84bUY/iQ==
X-Received: by 2002:a17:906:4895:: with SMTP id v21mr27504585ejq.299.1633969598214;
        Mon, 11 Oct 2021 09:26:38 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-085-058.77.10.pool.telefonica.de. [77.10.85.58])
        by smtp.gmail.com with ESMTPSA id a1sm4489514edu.43.2021.10.11.09.26.37
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 09:26:37 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 32/35] libsepol: do not underflow on short format arguments
Date:   Mon, 11 Oct 2021 18:25:30 +0200
Message-Id: <20211011162533.53404-33-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011162533.53404-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Handle format arguments that do not have a size of at least 2.

    kernel_to_common.c:69:20: runtime error: unsigned integer overflow: 1 - 2 cannot be represented in type 'unsigned long'
        #0 0x557b0b in create_str_helper ./libsepol/src/kernel_to_common.c:69:20
        #1 0x5577b8 in create_str ./libsepol/src/kernel_to_common.c:99:8
        #2 0x56448c in cond_expr_to_str ./libsepol/src/kernel_to_conf.c:82:15
        #3 0x56448c in write_cond_nodes_to_conf ./libsepol/src/kernel_to_conf.c:2103:10
        #4 0x55bd9b in sepol_kernel_policydb_to_conf ./libsepol/src/kernel_to_conf.c:3171:7
        #5 0x4f9d79 in main ./checkpolicy/checkpolicy.c:684:11
        #6 0x7fe2a342b7ec in __libc_start_main csu/../csu/libc-start.c:332:16
        #7 0x41f3a9 in _start (./checkpolicy/checkpolicy+0x41f3a9)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/kernel_to_common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_common.c
index 47c02d61..152f2816 100644
--- a/libsepol/src/kernel_to_common.c
+++ b/libsepol/src/kernel_to_common.c
@@ -57,7 +57,7 @@ static char *create_str_helper(const char *fmt, int num, va_list vargs)
 	va_list vargs2;
 	char *str = NULL;
 	char *s;
-	size_t len;
+	size_t len, s_len;
 	int i, rc;
 
 	va_copy(vargs2, vargs);
@@ -66,7 +66,8 @@ static char *create_str_helper(const char *fmt, int num, va_list vargs)
 
 	for (i=0; i<num; i++) {
 		s = va_arg(vargs, char *);
-		len += strlen(s) - 2; /* -2 for each %s in fmt */
+		s_len = strlen(s);
+		len += s_len > 1 ? s_len - 2 : 0; /* -2 for each %s in fmt */
 	}
 
 	str = malloc(len);
-- 
2.33.0

