Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B251C43219
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E757761108
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbhKEPsh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbhKEPsh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:37 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75045C061208
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:45:57 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id f8so34736259edy.4
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vvxklblsHGQCrBdVywtxrRqPdECJnimmtACej20pwXU=;
        b=Cvkc1s4SEExlMaPM/sGWmUvdp13HuiSv+PS8DbexMWwWFZB0QQN/XFSHBgmSZrCwa6
         5OhCGhlZxdRLq5cc7+G4AuJInDgHHc/IQwsQh6m636X/a3gywSO89AI4N+c02OzJ8h/h
         ypKzw/kn8d+ROXD/JJCbByI2qQPwDJnkllG2BZahH0w0V+WBWp9glgyVDmm1I4czkufj
         i0Nb56HUKDlLkRqkce6hvq1JQCZRvbNWtPKqJMr5fFL04suOiw0YZWNNOTLXGIJUMQc7
         o+HMaIQ7swLIClqckwdDoyqek+umk9NsVUlmD9X4ZxuG+OXzMaVQDgvVGNHzAGKvZ2O8
         nLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vvxklblsHGQCrBdVywtxrRqPdECJnimmtACej20pwXU=;
        b=P9srQugw+0X3qdgWBoNdmuhDL1Jj64+PE/3xXnTkU8E0mg27rFduyYivzpU/2kkkGZ
         Yo+rP92Evv7AL+kyOGIoRauUFphmsRwcGMg1M9ztvDH8Msz7xlb+8g+O6/tkMaIZfErr
         +F8WoPZOcc+e2I5U/dGNOcVfaCJT6IpjYMD7XK9MnxlGJgTS4pp/jzU8PeflX9ppjCJu
         UF5aORl9wt7uKWlpFBIBJPDekk+Jz38I8Km/SofwdJtVWym0DllgnRBJkGmhUCM7OdrK
         SC6Wd5lWqeo/tIhSF22k3bhVFUOoOP8QrvdHJ7DodhjMhDy0Bhtuspug5Vy9yX/K2UNc
         wtpg==
X-Gm-Message-State: AOAM532qg/CF6w18x/Uws3Cn6MEf5oYMUINVqIAEgSoP8WlTGdrdajSO
        TJ+3y+AvyTBav7MjDESuigoGAkXmK48=
X-Google-Smtp-Source: ABdhPJzMTFCLpLnWSk5auzyTURag0EJ17/i9WEdBhHRktQQcjhHzh4D8ZBa3cW73nGCQNE3WfurOHA==
X-Received: by 2002:a05:6402:6c8:: with SMTP id n8mr47991500edy.38.1636127156015;
        Fri, 05 Nov 2021 08:45:56 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.45.55
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:45:55 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 17/36] libsepol: do not underflow on short format arguments
Date:   Fri,  5 Nov 2021 16:45:19 +0100
Message-Id: <20211105154542.38434-18-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211105154542.38434-1-cgzones@googlemail.com>
References: <20211011162533.53404-1-cgzones@googlemail.com>
 <20211105154542.38434-1-cgzones@googlemail.com>
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
2.33.1

