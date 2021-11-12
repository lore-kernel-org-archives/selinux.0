Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E99C433EF
	for <selinux@archiver.kernel.org>; Fri, 12 Nov 2021 15:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B5FA60273
	for <selinux@archiver.kernel.org>; Fri, 12 Nov 2021 15:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbhKLPpE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Nov 2021 10:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235312AbhKLPpD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Nov 2021 10:45:03 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57302C061766
        for <selinux@vger.kernel.org>; Fri, 12 Nov 2021 07:42:12 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id f4so39242942edx.12
        for <selinux@vger.kernel.org>; Fri, 12 Nov 2021 07:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OhjgPaB1eQPAPhm4bIVwHNUnE32r4+v3B8Rqc8yYYJk=;
        b=ZN1puIIYCkzQ5cW9HrKy4sgPgFlQ6gfBuLqaOVd35Y2CCc2dGKZZ4qrj9uG7LCWTgu
         +ihEEZJle2dw3ONGFTK0Y8WNaKqNylUrecIAwmKwzQFy05JDFBpvIXv7Q3n0Z87ybupi
         YhHm3OliB+JKk9yHHFffIktuM6zLfWhtRGqky/2aBKnB1xHthDBrNRqf2fYBimqwe2pT
         SSHUmXSN4f7L7FdO4U+HWJM9hwkPwOOZTsz0+CchYNqsQnMSZBnOmx+iijxPWdPWNphm
         kJ/OoaVZaE8bnXjOV606PV3uR7HTvtprjIldb3YK0+fKcVtAZk8tNnhAUelUQZnL1Zae
         +QzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OhjgPaB1eQPAPhm4bIVwHNUnE32r4+v3B8Rqc8yYYJk=;
        b=jXojEXh4VifRWPgukm8gH8I77N0NKUSEfWSMIRoou/QDlEkMqKut0Xv17cjwDrPbhQ
         +i9IH3Uoc4mok2iG/m3zCGF982LEFOs7HJdMDlT6ys/HOJxFHFtxYdhJyW59PftkRfD4
         J6MoZxIheoFn/lFPapRIoGwsWlL4afMMRauj0NEhZwiEhomKBBqtVJQMnNKiJuW+0UYP
         qwhf/ZNhahDa14VVzuHGspcBEDirZvWe3WOyzu5c8uTPiCqEBXa4Skz8SsNIeY2Kul29
         vGmNm9F/RtR4mp08Y1prppD7pRhavCZBR0i+4wjO7Xrtpo9bUncGWCoD0X8HPhwzdG+2
         LSEw==
X-Gm-Message-State: AOAM533O1P4fJ3L8YVS6bJW2wEEddZJBvVRgZGgRaaLqojomwZn9xIBX
        jxl8KGs5ifGZuMZPShC5/IYcP9llAeA=
X-Google-Smtp-Source: ABdhPJycW5sjigQQgalKl5nd746rYz2teYIzHQ+XXOSpT4+jAg44+/PW1lButVLY1x42f7Fv/xEwaw==
X-Received: by 2002:a17:907:8a1a:: with SMTP id sc26mr20684042ejc.402.1636731730890;
        Fri, 12 Nov 2021 07:42:10 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-000-195-130.77.0.pool.telefonica.de. [77.0.195.130])
        by smtp.gmail.com with ESMTPSA id m9sm2628914eje.102.2021.11.12.07.42.10
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 07:42:10 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 08/12] python: mark local functions static
Date:   Fri, 12 Nov 2021 16:41:57 +0100
Message-Id: <20211112154201.78217-8-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211112154201.78217-1-cgzones@googlemail.com>
References: <20211112154201.78217-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

    sepolgen-ifgen-attr-helper.c:59:5: warning: no previous prototype for ‘render_access_mask’ [-Wmissing-prototypes]
       59 | int render_access_mask(uint32_t av, avtab_key_t *key, policydb_t *policydbp,
          |     ^~~~~~~~~~~~~~~~~~
    sepolgen-ifgen-attr-helper.c:114:5: warning: no previous prototype for ‘output_avrule’ [-Wmissing-prototypes]
      114 | int output_avrule(avtab_key_t *key, avtab_datum_t *datum, void *args)
          |     ^~~~~~~~~~~~~
    sepolgen-ifgen-attr-helper.c:220:6: warning: no previous prototype for ‘usage’ [-Wmissing-prototypes]
      220 | void usage(char *progname)
          |      ^~~~~

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 python/audit2allow/sepolgen-ifgen-attr-helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/python/audit2allow/sepolgen-ifgen-attr-helper.c b/python/audit2allow/sepolgen-ifgen-attr-helper.c
index f010c958..6f3ba962 100644
--- a/python/audit2allow/sepolgen-ifgen-attr-helper.c
+++ b/python/audit2allow/sepolgen-ifgen-attr-helper.c
@@ -56,7 +56,7 @@ static int perm_name(hashtab_key_t key, hashtab_datum_t datum, void *data)
 	return 0;
 }
 
-int render_access_mask(uint32_t av, avtab_key_t *key, policydb_t *policydbp,
+static int render_access_mask(uint32_t av, avtab_key_t *key, policydb_t *policydbp,
 		       FILE *fp)
 {
 	struct val_to_name v;
@@ -111,7 +111,7 @@ struct callback_data
 	FILE *fp;
 };
 
-int output_avrule(avtab_key_t *key, avtab_datum_t *datum, void *args)
+static int output_avrule(avtab_key_t *key, avtab_datum_t *datum, void *args)
 {
 	struct callback_data *cb_data = (struct callback_data *)args;
 
@@ -217,7 +217,7 @@ static policydb_t *load_policy(const char *filename)
 
 }
 
-void usage(char *progname)
+static void usage(char *progname)
 {
 	printf("usage: %s out_file [policy_file]\n", progname);
 }
-- 
2.33.1

