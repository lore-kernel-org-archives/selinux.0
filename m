Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF4AC433EF
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 16:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhLIQ4I (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbhLIQ4H (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 11:56:07 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9E0C061746
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 08:52:33 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id r11so21096663edd.9
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 08:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YCXs6Gz3cg2tgZH375fimvcsJkMhE0dVaZWHoVjvtrc=;
        b=qKVPI/xhXeTjMWJepUoPLMRKOf+U9vAHpVRzqrbVMrWOtrO1kte0QHPSQ5ExBGcaoj
         ZMQYYrKMEO7WnVO8hKwU1NPogyfbtmCHNG02EV2PFnvc5UuXzqyWOQjnlHb0aeAsIBmN
         4jMMTlSw7rwxnpUKBhBmUFa7toVhLlmd+JRHU3kF5kuf0XkhJTSmKtp4CpA+SdsWHbNh
         lO+cdziXxql/DY9bvw/vZ2aOrciX7FhMANVkTAT6ufH4RTT9z1t+uRe9NpdQw87V6H2S
         lp5XFw0iBNQkR4BW/IEGuCay3jdZc0bvXKx05mt0A5EuWIHDd7dHgRTiU4p6uoAG9oaN
         YEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YCXs6Gz3cg2tgZH375fimvcsJkMhE0dVaZWHoVjvtrc=;
        b=t3GmyvFIoulZHlo/HCV7jOnC597+H43TaiHDRu5io/kG41hdWcP69wglVxStRzndnu
         KCflwXSzyUK0cwQS0o93wqnotq4X3+l2kUAgWwqEgM7eXOo/Ipd4D0+OX0KX2SmtUI15
         iAW9IkAFgbe5HX+l46yu5vu0sC5g0ZG0vJbNDXR8w5bJK86ArJDC2PdlMSaY/vbl1c/o
         +4zNthQTcrqijj96wdAyRncZnpanDhcvAFxA9yHenON+jXc05q0bDJdQOffODxWv4iQV
         A6iFowZMr7QSdJV+608BjizoDSa/5Ma+pCR4t8cjwr1uAB97Yk5YICWeC6Ha3g/nKmy1
         /JQw==
X-Gm-Message-State: AOAM532r7D+LVZ9LAUbTnq7Mt9hXNiS0iCAzrFjUP2nsgVOjKUMJkxpK
        B6aQHvFgSk2eLQ3jaW8EACbKRi0oVq8=
X-Google-Smtp-Source: ABdhPJwZR2wgKlAhOL4Oe4iyOPrUaLS/3jut6z8doZ5ni4orarPab0N8jbjnFT0Manpt4bW8/DFN7A==
X-Received: by 2002:a50:fb16:: with SMTP id d22mr30936459edq.367.1639068586736;
        Thu, 09 Dec 2021 08:49:46 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-140-169.95.116.pool.telefonica.de. [95.116.140.169])
        by smtp.gmail.com with ESMTPSA id hu7sm172135ejc.62.2021.12.09.08.49.46
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:46 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 17/36] libsepol: do not underflow on short format arguments
Date:   Thu,  9 Dec 2021 17:49:09 +0100
Message-Id: <20211209164928.87459-18-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211209164928.87459-1-cgzones@googlemail.com>
References: <20211105154542.38434-1-cgzones@googlemail.com>
 <20211209164928.87459-1-cgzones@googlemail.com>
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
2.34.1

