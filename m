Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A1EC433EF
	for <selinux@archiver.kernel.org>; Tue, 19 Oct 2021 15:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B09B60FDA
	for <selinux@archiver.kernel.org>; Tue, 19 Oct 2021 15:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbhJSPDl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Oct 2021 11:03:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20959 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229790AbhJSPDk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Oct 2021 11:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634655687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gF9l0RgNZxiVV6LSNg/XIYdzv59erhFGWnrkfk/sZ7o=;
        b=O5bQKvQtXigYJbtOTRdOH6YWuITrR2Yuy1tyj9XjqHPC77a3BlkruAi+sZl28Ik+mTeFyC
        lUw0fRxOoZn2PPDjhvfKoIiJLeuzwBwUonNp6Sa5YEcLKJuaLa1ev4s5XMncFQc1yiJjTG
        poGx6r27eIJDG9OLdWPGyPQbrruzmaI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-bBUFVem2OmiYhOsVsTqkfA-1; Tue, 19 Oct 2021 11:01:26 -0400
X-MC-Unique: bBUFVem2OmiYhOsVsTqkfA-1
Received: by mail-wm1-f72.google.com with SMTP id 6-20020a1c1906000000b0030dd4dd6659so850876wmz.3
        for <selinux@vger.kernel.org>; Tue, 19 Oct 2021 08:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gF9l0RgNZxiVV6LSNg/XIYdzv59erhFGWnrkfk/sZ7o=;
        b=sN0CsuhtnUJ/ZAg2GFlM+wZaojl+sQcV/lTuQL8yFgq4+isVrGQx2Qjgr5f7hTZMWK
         PvW1pXYnc6iEYCZUHooC+pm6U1NEaF/q7S5ZfbXnAUumqu+AB08QrsRmPqsEsEuQD3LC
         +lXDuCWmar3qEHReE6p3XKpjgWF+XwPJVz4xQ3dEFWqFgccFrNy+6GEMNdxvr51Ivc10
         7PPiymdTu2/Db4GKAVja2C5IT+AV0FF1/4NwGEmviVB/0GwjmORG0fySxKY2EDExS1X1
         RB61AVW1gYrvI24SY3+Q2DT7+UwJlyQxMcDId9Bn2KSOTkYKIXpcwI0iRj45HrZz30T4
         49Mw==
X-Gm-Message-State: AOAM530cir3PV+eAzfn29uIgKxkUEJvcIN002yZeq7lRtiL0G2Rh9z9W
        qdhlMhZGaH3HOMVfh2d+3+1L60761A1bgdZ+NXNoXSVp2eSiwwZac1bEsM30eSIFh5qByZihNP7
        YcUl1xP+8Ykn/dUGMCRc+dFR+oVqxjDzwtILmXrz0/xRGffz7B5Uvl9/1EPqJaglnZDHyWg==
X-Received: by 2002:a5d:648f:: with SMTP id o15mr45670158wri.3.1634655685039;
        Tue, 19 Oct 2021 08:01:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9d7e/wvJo/Rn74y1HYXD8YeAbjk6pDRkp/z+9+cdTTE16hS2mAiZkjmj55HS8Eui5EF+XWw==
X-Received: by 2002:a5d:648f:: with SMTP id o15mr45670105wri.3.1634655684667;
        Tue, 19 Oct 2021 08:01:24 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id r4sm19271630wrz.58.2021.10.19.08.01.24
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 08:01:24 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v3 1/7] label_file: fix a data race
Date:   Tue, 19 Oct 2021 17:01:16 +0200
Message-Id: <20211019150122.459722-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211019150122.459722-1-omosnace@redhat.com>
References: <20211019150122.459722-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The 'matches' member of 'struct spec' may be written to by different
threads, so it needs to be accessed using the proper atomic constructs.
Since the actual count of matches doesn't matter and is not used,
convert this field to a bool and just atomically set/read it using GCC
__atomic builtins (which are already being used in another place).

If the compiler lacks support for __atomic builtins (which seem to have
been introduced in GCC 4.1), just fail the compilation. I don't think
it's worth tryin to invent a workaround to support a 15 years old
compiler.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libselinux/src/label_file.c | 15 +++++++++++++--
 libselinux/src/label_file.h |  2 +-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 2e28d047..74ae9b9f 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -951,7 +951,12 @@ static struct spec **lookup_all(struct selabel_handle *rec,
 			rc = regex_match(spec->regex, key, partial);
 			if (rc == REGEX_MATCH || (partial && rc == REGEX_MATCH_PARTIAL)) {
 				if (rc == REGEX_MATCH) {
-					spec->matches++;
+#ifdef __ATOMIC_RELAXED
+					__atomic_store_n(&spec->any_matches,
+							 true, __ATOMIC_RELAXED);
+#else
+#error "Please use a compiler that supports __atomic builtins"
+#endif
 				}
 
 				if (strcmp(spec_arr[i].lr.ctx_raw, "<<none>>") == 0) {
@@ -1249,9 +1254,15 @@ static void stats(struct selabel_handle *rec)
 	struct saved_data *data = (struct saved_data *)rec->data;
 	unsigned int i, nspec = data->nspec;
 	struct spec *spec_arr = data->spec_arr;
+	bool any_matches;
 
 	for (i = 0; i < nspec; i++) {
-		if (spec_arr[i].matches == 0) {
+#ifdef __ATOMIC_RELAXED
+		any_matches = __atomic_load_n(&spec_arr[i].any_matches, __ATOMIC_RELAXED);
+#else
+#error "Please use a compiler that supports __atomic builtins"
+#endif
+		if (!any_matches) {
 			if (spec_arr[i].type_str) {
 				COMPAT_LOG(SELINUX_WARNING,
 				    "Warning!  No matches for (%s, %s, %s)\n",
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 343ffc70..b453e13f 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -51,7 +51,7 @@ struct spec {
 	bool regex_compiled; /* bool to indicate if the regex is compiled */
 	pthread_mutex_t regex_lock; /* lock for lazy compilation of regex */
 	mode_t mode;		/* mode format value */
-	int matches;		/* number of matching pathnames */
+	bool any_matches;	/* did any pathname match? */
 	int stem_id;		/* indicates which stem-compression item */
 	char hasMetaChars;	/* regular expression has meta-chars */
 	char from_mmap;		/* this spec is from an mmap of the data */
-- 
2.31.1

