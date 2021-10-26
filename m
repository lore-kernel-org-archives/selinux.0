Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8150DC433F5
	for <selinux@archiver.kernel.org>; Tue, 26 Oct 2021 11:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6440260F0F
	for <selinux@archiver.kernel.org>; Tue, 26 Oct 2021 11:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbhJZLzK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Oct 2021 07:55:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48901 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235550AbhJZLzK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Oct 2021 07:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635249166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gF9l0RgNZxiVV6LSNg/XIYdzv59erhFGWnrkfk/sZ7o=;
        b=Vog0+fLid95IKiKt9y2CPxrJikBnAkP1/pesPiW6WCN3GBkGXj6yZOGM+GgGJdYqNnWvPH
        uh9tagvBm9d6DhvY5BXsoBus7xUFwMV1UDF72hG2nURASz7Sd418DVWRwyF71/f7p2t/c6
        7pvXL1ERZzLgzqT3MhZqzpY6YaB/C/0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-1wzjYDTZPmSU7wsCWHx49A-1; Tue, 26 Oct 2021 07:52:44 -0400
X-MC-Unique: 1wzjYDTZPmSU7wsCWHx49A-1
Received: by mail-ed1-f70.google.com with SMTP id v9-20020a50d849000000b003dcb31eabaaso12835326edj.13
        for <selinux@vger.kernel.org>; Tue, 26 Oct 2021 04:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gF9l0RgNZxiVV6LSNg/XIYdzv59erhFGWnrkfk/sZ7o=;
        b=hxvJhhraimyu6aKXhws9YzAmR2TGxhlmJI9X5RAc8wlM4KPRdWmIML6q+lZQILjWFK
         IJXoBMZEVw0UcOGFB+8MKzaxv8Q8b5+n1Uf1imvqDy7fbbtj3+OvhxVrGu4WWLHu2CuB
         POOANy5f3Ow6TC5Q+ZNH7h7Kbl7MBXQHBSGIZKgkPqkUnQ4xBvSbrxL6vRDK4Ai1gzJE
         4/xWV8XD7Z7XY0aeBE8OrPqk6MpZiwKKCyv4w8k8HCzL+ESaseLO27J7uLFDLK2TsJF+
         WGiJG6IsWTJ/klR9VvGdUzAuTpTVxu3L/OQMim7IgaX8Kf6wC/dZSjLd0ZSUwV46J8PS
         4qTw==
X-Gm-Message-State: AOAM531lDGhfcacm3m3RGvppqbY5HX4y8KtgVvd6wEe28xjrJIXGT2TF
        JFQEw4kBEaFQORmDl9VIR7ECb9zERSRVkN+h2ez/kRu0JsB9HwwRHoTIyPPhpBPOLAQSBXUtSdo
        75PD8PBU8tWMsitPYrMDWxDcLQ6AR4aQJpDz1wVzFKnaIBGA6VqUdyFES1jY93KE5CiKqTg==
X-Received: by 2002:a50:950b:: with SMTP id u11mr34989823eda.121.1635249163229;
        Tue, 26 Oct 2021 04:52:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYVJPPDmdHHOVNWVEKr3xoCq/etwR29AuCR9JpzXE4XP4O2dN3zsWHBusy5caBUOKTTOHXxw==
X-Received: by 2002:a50:950b:: with SMTP id u11mr34989793eda.121.1635249162944;
        Tue, 26 Oct 2021 04:52:42 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:d067:83f0:d612:b70f])
        by smtp.gmail.com with ESMTPSA id v15sm10658105edi.89.2021.10.26.04.52.42
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 04:52:42 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v4 1/8] label_file: fix a data race
Date:   Tue, 26 Oct 2021 13:52:32 +0200
Message-Id: <20211026115239.267449-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026115239.267449-1-omosnace@redhat.com>
References: <20211026115239.267449-1-omosnace@redhat.com>
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

