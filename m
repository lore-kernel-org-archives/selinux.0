Return-Path: <SRS0=F/Jq=4N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89814C35E10
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 20:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B579218AC
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 20:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqXeCmY5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731665AbgBYUCm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:02:42 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38939 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731645AbgBYUCl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Feb 2020 15:02:41 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so243982plp.6
        for <selinux@vger.kernel.org>; Tue, 25 Feb 2020 12:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p1GByf6fsu6kmddAau9KLY0+hGhmNnwPe1Shj/m1U6Q=;
        b=AqXeCmY5IvPepWRvxoeKzkTP2Tdn+bclC6xw/XTDZo6CEMsi4RvdGbs3NVE9U3azoh
         mxLYIf3e71fth1lkgXfee7L1CUWXeNesDv4C5dluij/VEjHvezKoiEUGM9MN0ZPzqvAS
         3j2G7d5i0vK8foAQ6eQvA91hTH9KvzmJ6BowOnmBc72aS1cJkRo1NnkYJTXtXBlV9Y0j
         jGmOZu5qX2I3N6twiUUcrxvG8EC1KyGwZ3K7I+6cYWTTvXBB5/WwR0vCN2E5bDUrwoXR
         uN5DIfDvzmm7HKNYzXr/Cmzy7XOgKtbAUvXU/u7Bj8pofSS70jrU0JruZfWKfSZRVu23
         xKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p1GByf6fsu6kmddAau9KLY0+hGhmNnwPe1Shj/m1U6Q=;
        b=oYa2aD3Mqhpgpjo0Cch0jhwEj42gUUQpyXm0dT5GplG7ijfSG3bP2Xk8yygMhGptcy
         pLTKCc6fYx/MaVt1xsG/55hJTvY5BuFDT4wXGNO5GGCEQ1NgFQz+OeZK4PfKuybMViaw
         +VN0s56y5toZOoS5r4j24ARAvtUTJQQA3YibkCctaxRv6Alb3P9IDoJLunczBz1i+ADj
         uCdpenyM5EojsjEp64kulit0UHVktcI7fZA9KsZ9l0VY7MYt0M2jTQe1CNiPoCbVQlaK
         b8JqJj/k2Tu3evQK0wj3wIigB7drqt5q+NkllS5fp5vIQDI2Xjjva1EF9XhXehrC8YFg
         qZ5A==
X-Gm-Message-State: APjAAAWkiCtgojlTmLqmoipJgDJUZJvktGkL/2hjxYj0mSDcK1WvYy53
        pxgAlx71w635qsCO7MbF28c=
X-Google-Smtp-Source: APXvYqyTmxm7oPa5/0LdAXKRKDKTtqL4sVPsxpDBAUO1ZRUaPfNk9NqP/5rjPaL6M8si7HEf24IQhw==
X-Received: by 2002:a17:90a:c390:: with SMTP id h16mr742388pjt.131.1582660961068;
        Tue, 25 Feb 2020 12:02:41 -0800 (PST)
Received: from localhost.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id v29sm10636362pgc.72.2020.02.25.12.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 12:02:40 -0800 (PST)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     sds@tycho.nsa.gov, plautrba@redhat.com, selinux@vger.kernel.org
Cc:     William Roberts <william.c.roberts@intel.com>
Subject: [PATCH 02/17] selinux_booleans_path: annotate deprecated
Date:   Tue, 25 Feb 2020 14:02:04 -0600
Message-Id: <20200225200219.6163-3-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200225200219.6163-1-william.c.roberts@intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/include/selinux/selinux.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index ee808dd954ad..97834cc842dd 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -321,7 +321,7 @@ extern int security_set_boolean_list(size_t boolcnt,
 /* Load policy boolean settings. Deprecated as local policy booleans no
  * longer supported. Will always return -1.
  */
-extern int security_load_booleans(char *path);
+extern int security_load_booleans(char *path) __attribute__ ((deprecated));
 
 /* Check the validity of a security context. */
 extern int security_check_context(const char * con);
-- 
2.17.1

