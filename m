Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3BFC433EF
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5853461183
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 15:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhKEPsh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbhKEPsg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 11:48:36 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A52C061205
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 08:45:56 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id ee33so34757651edb.8
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 08:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mxUQrPZca8PGmH8HvJqAYMNir/lzZz4H2vk9lITypqM=;
        b=G66Rk0goXV2LggY7Wb6tlyTIlge9xoB6lZ4kZhQb9GVYPd/4mXN35KD+n6OSb8SVGC
         Ac2foAcOTqtUjUwgnVv4zWd07xhk1qZsJJuZ28gqxVaYMIGqZ4xy+AeMyT8dvZw4Xiiu
         Q3VKGDAIS78kDzY7LuP356Km68Ypw+cQf+XgQqu5U+/NHcZLR/jjJimx1Xv2qQa5eu3w
         ivvUjwUJwrDIBw6DVJF+9SGJqAGAZYZsk5UjaSAyJ/P0V/enJttCGJeXVF/kM+KQvmLj
         IsND63akwLncReLww/Oj1ZZoWyz5IZPM5JEDvEVaViH1K0Mjp6CQohgeaLUbXPUJ20Lb
         3Nbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mxUQrPZca8PGmH8HvJqAYMNir/lzZz4H2vk9lITypqM=;
        b=2DC3kCr//KEtEzS38+piJha+FGTYta/b2g7Mb6gnUPi0O2Wetr221MBH6SyEcEBq+A
         Wpx22ahfszm8d3/7KcZJ5S6OWu5ABa1Xu427YGyl/2zN0MHAPtfaMr+d7hi83H2B11Gn
         jo2/jvW9WuVuKVU9LS0UGh2XRW2bmWQl+PuJ9dARVe6HdRMRSKW2gT23HmJrYkSmapaW
         4KzSO6NbMDKY0w9QJTwvRStxcMYonCER0ZJAHspHC+pIhxNA+XrUs0XSKWLV3FRaDaD5
         AWDtE9OqQqXGMEknJtbofP09kxsf/4GmQuOhnTq+k+5sKfNN+OzWc+B6hlI8ZNyciQB+
         NQxQ==
X-Gm-Message-State: AOAM530DNHXlLtR4O1t0sfbVU5VVRSjtLEiicnFHlVMmLRSDO1whA7ZG
        t1SUdqwC1Qwfk/x9T/xN/TUUfgRtQV4=
X-Google-Smtp-Source: ABdhPJwYspYvqno0NgILJXx3ohrtDlcUMeZDJXX7FDrFO9cfKZ0ZPzbiVSF62m04J/++hqcd+vtwIQ==
X-Received: by 2002:a50:d984:: with SMTP id w4mr79647934edj.375.1636127155431;
        Fri, 05 Nov 2021 08:45:55 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-185-074.77.1.pool.telefonica.de. [77.1.185.74])
        by smtp.gmail.com with ESMTPSA id u16sm4245474ejy.16.2021.11.05.08.45.54
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 08:45:55 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 16/36] libsepol: use size_t for indexes in strs helpers
Date:   Fri,  5 Nov 2021 16:45:18 +0100
Message-Id: <20211105154542.38434-17-cgzones@googlemail.com>
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
2.33.1

