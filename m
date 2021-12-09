Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96E2C433EF
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 16:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbhLIQ4D (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbhLIQ4D (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 11:56:03 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62250C061746
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 08:52:29 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id x10so4329022edd.5
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 08:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oF2vj0Jv8v8Kdyq57hO2V8GGlbS8mGYRgiPT4bPjkAU=;
        b=RF2bEhRKR8W5QJcEV2MkKM8hFbFcBoeJZqKYNemH309v74TbK+NIt7tcaI41MqjoMx
         jsWpGT0uXz+Y/o99zb/2evweNnCRdU+1cWiI+M/MAxW1+LJTV7Ucdm+eT9l6BZPplMV6
         Yp2zPj5qQj54cIj4XmWN7u2SHY0Ifw8BznQGQ4Nk7p35FRKtwc8dQB1osMUGYEc4/AY/
         s36amPPGZLpxkxEOBatiWnnaYDnNBLc/lMtOF3FADRiIPPpNcpMow3unrmnuTX8TE/o7
         Mh9ywAx+RsqH0+v4OdNS7xPP4DJv3v2rpNM9xruzBJuqgm9ntotbyC2TbIzAh0+iIfCr
         2KSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oF2vj0Jv8v8Kdyq57hO2V8GGlbS8mGYRgiPT4bPjkAU=;
        b=kOgr6Q9N1n0Pbay4kNVYjKnGZOU2yTjULSTpRzd6nquZO6nLiw3TxpCuZKL976KgR4
         N717f11bz7GoOV4j/wArFtisjuHnjP59pVB/kNRs9svhUlWKy7RsQsgi6Fedal85CGTx
         eJ4VEqNVF6JUBTsVezhUKVd/rECoHeLy+jInKafnGvDG0fbscmBFDa/KCHH4buP05jGR
         BzCHnLe2oYlyRnFNbF31D36BmcdSmsRk1R7HPaUGb5pZ5LkQIZyK09VPOHmqhUEEQuIY
         LZrF750pxLQO9jOhWipoXxJrVTN6LRI0xa3epIaPh1e4D8VkKcqhB8MVsxtlydsidiCt
         3UFA==
X-Gm-Message-State: AOAM530I7oAMpq/HXZslbUtDwdW8lSsn6otymhU3ctL1trwUF4sDq5tA
        WhzmVvWARdVt9xnN42bkNv7GbCJ6sqY=
X-Google-Smtp-Source: ABdhPJy+yOVNhT9ajJC//GSA2c99sWixeHi4B1eFMHA1q2QxISYYjYXqkecZBPZNhD9XpKzAkDVs9g==
X-Received: by 2002:a17:907:7ea6:: with SMTP id qb38mr16912662ejc.248.1639068585951;
        Thu, 09 Dec 2021 08:49:45 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-140-169.95.116.pool.telefonica.de. [95.116.140.169])
        by smtp.gmail.com with ESMTPSA id hu7sm172135ejc.62.2021.12.09.08.49.45
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:45 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 16/36] libsepol: use size_t for indexes in strs helpers
Date:   Thu,  9 Dec 2021 17:49:08 +0100
Message-Id: <20211209164928.87459-17-cgzones@googlemail.com>
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

Use size_t, as the strs struct uses it for its size member.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/kernel_to_common.c | 8 ++++----
 libsepol/src/kernel_to_common.h | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_common.c
index 51df8c25..47c02d61 100644
--- a/libsepol/src/kernel_to_common.c
+++ b/libsepol/src/kernel_to_common.c
@@ -159,7 +159,7 @@ int strs_add(struct strs *strs, char *s)
 {
 	if (strs->num + 1 > strs->size) {
 		char **new;
-		unsigned i = strs->size;
+		size_t i = strs->size;
 		strs->size *= 2;
 		new = reallocarray(strs->list, strs->size, sizeof(char *));
 		if (!new) {
@@ -212,11 +212,11 @@ char *strs_remove_last(struct strs *strs)
 	return strs->list[strs->num];
 }
 
-int strs_add_at_index(struct strs *strs, char *s, unsigned index)
+int strs_add_at_index(struct strs *strs, char *s, size_t index)
 {
 	if (index >= strs->size) {
 		char **new;
-		unsigned i = strs->size;
+		size_t i = strs->size;
 		while (index >= strs->size) {
 			strs->size *= 2;
 		}
@@ -237,7 +237,7 @@ int strs_add_at_index(struct strs *strs, char *s, unsigned index)
 	return 0;
 }
 
-char *strs_read_at_index(struct strs *strs, unsigned index)
+char *strs_read_at_index(struct strs *strs, size_t index)
 {
 	if (index >= strs->num) {
 		return NULL;
diff --git a/libsepol/src/kernel_to_common.h b/libsepol/src/kernel_to_common.h
index 8aa483fa..e9932d30 100644
--- a/libsepol/src/kernel_to_common.h
+++ b/libsepol/src/kernel_to_common.h
@@ -99,8 +99,8 @@ int strs_add(struct strs *strs, char *s);
 __attribute__ ((format(printf, 2, 4)))
 int strs_create_and_add(struct strs *strs, const char *fmt, int num, ...);
 char *strs_remove_last(struct strs *strs);
-int strs_add_at_index(struct strs *strs, char *s, unsigned index);
-char *strs_read_at_index(struct strs *strs, unsigned index);
+int strs_add_at_index(struct strs *strs, char *s, size_t index);
+char *strs_read_at_index(struct strs *strs, size_t index);
 void strs_sort(struct strs *strs);
 unsigned strs_num_items(struct strs *strs);
 size_t strs_len_items(struct strs *strs);
-- 
2.34.1

