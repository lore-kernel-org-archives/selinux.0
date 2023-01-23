Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CBCC54EAA
	for <selinux@archiver.kernel.org>; Mon, 23 Jan 2023 01:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjAWBmk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 22 Jan 2023 20:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjAWBmj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 22 Jan 2023 20:42:39 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C9B193E1
        for <selinux@vger.kernel.org>; Sun, 22 Jan 2023 17:42:38 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id bj3so10393103pjb.0
        for <selinux@vger.kernel.org>; Sun, 22 Jan 2023 17:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqsFWQlkPmz6BYaCuIOf2OUJnutha5kbZsyc8XDADKw=;
        b=HOTtARUR4L3dy/9RYAA8lyQZ5+H/sTm67SoRQ/ImDeMVpKa0d6dEKENds82QXS/oRH
         L97HcGPoqsJvrMovv1EMBtXc1AADL5r9CaByLmc1a+IJx3WBK/C62PYFdiH08ieiXcw2
         23kX5rOKEV6kWpkcvcK6nspXt2QAAotxF5flGbF33ZPdf/9/EEiofqxAK4P/nR4DjJkd
         59ngMb9+i8JTUSuUklK4IeGx9ZTfHhT2efgsSPDq/Dsw1GRu2rcv2BJim2Gy/vPa6MUe
         VZ8SIgdZ2oly35OE0MvoAJ+M6Bh8eqxxrJmJcsgnJauFLdiRTvrJJaJGBl5rmxcUt/+c
         kKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqsFWQlkPmz6BYaCuIOf2OUJnutha5kbZsyc8XDADKw=;
        b=IvDbxyiIAHy+s/WoXdSOJIto/gxHk/4G8lI8cKTpAfJZWMXVbkWSoCVZd31GZcT65/
         +As5KblXub7TwVM6qwDDk/ITehcoJx844n19HO2Wx0AjuEpdi8h/LZYjRddB+TLGdC+Z
         cdSrmPxcU9FUKSLpb0cnPgkGTyYLn5DJxN4GXbTYEr5xeGpmrm7C/Kckf0MvzQywe9nF
         VtrqXu54DGGJAOf8Xb2OPF3gRWdZ0Hg7EU5JNCs6/a3DGoaCNOlkww5lAjejXBu5DrC1
         jaS8K79iN6ccY8aOrIa+2/d9En2MtWQL2iwbAx02u0yr/lvlaCnx3AtJNObeirvRNaPD
         TtHQ==
X-Gm-Message-State: AFqh2krQHPZWLTuaXJAcQ5iKEeiFXTT+D3EhxjHeQVXpL5bspiBygfZR
        CfAzJpG70+fi8iP0wTpJd5XVlPJRr8k=
X-Google-Smtp-Source: AMrXdXvYirkOpWNNDJ43P2T0XrlxKbzUt/a5KkjGrN9j9sZ0NDFKuJmfaPkCHZG31sCSdjAhOhIliw==
X-Received: by 2002:a05:6a20:d68c:b0:b8:7496:b663 with SMTP id it12-20020a056a20d68c00b000b87496b663mr25997432pzb.59.1674438157999;
        Sun, 22 Jan 2023 17:42:37 -0800 (PST)
Received: from localhost.. (192-184-217-7.fiber.dynamic.sonic.net. [192.184.217.7])
        by smtp.gmail.com with ESMTPSA id z18-20020a63c052000000b0049f2c7e59f5sm25857491pgi.27.2023.01.22.17.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 17:42:37 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     selinux@vger.kernel.org
Cc:     =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 3/3] libselinux: use a static match_data if single threaded
Date:   Mon, 23 Jan 2023 01:40:47 +0000
Message-Id: <20230123014047.84911-4-carenas@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230123014047.84911-1-carenas@gmail.com>
References: <20230121180318.11853-1-carenas@gmail.com>
 <20230123014047.84911-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

A previous patch reimplemented a single threaded fallback while keeping
the memory usage low as was done originally by the workaround, but the
resulting code is too slow.

To improve performance, while keeping memory in check, use instead a
static match_data that gets reused for all queries and let its contents
(including the heapframes) leak.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 libselinux/src/regex.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index 54f24026..a6b44023 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -220,7 +220,8 @@ void regex_data_free(struct regex_data *regex)
 int regex_match(struct regex_data *regex, char const *subject, int partial)
 {
 	int rc;
-	bool slow;
+	bool single_threaded;
+	static pcre2_match_data *static_match_data;
 	pcre2_match_data *match_data = NULL;
 
 	if (match_data_key_initialized > 0) {
@@ -238,10 +239,13 @@ int regex_match(struct regex_data *regex, char const *subject, int partial)
 			match_data = __selinux_getspecific(match_data_key);
 	}
 
-	slow = (match_data_key_initialized <= 0 || match_data == NULL);
-	if (slow) {
-		match_data = pcre2_match_data_create_from_pattern(regex->regex,
-									NULL);
+	single_threaded = (match_data_key_initialized <= 0 || !match_data);
+	if (single_threaded) {
+		if (!static_match_data && !match_data_initialized)
+			static_match_data = pcre2_match_data_create(1, NULL);
+
+		match_data_initialized = 1;
+		match_data = static_match_data;
 		if (!match_data)
 			return REGEX_ERROR;
 	}
@@ -250,9 +254,6 @@ int regex_match(struct regex_data *regex, char const *subject, int partial)
 	    regex->regex, (PCRE2_SPTR)subject, PCRE2_ZERO_TERMINATED, 0,
 	    partial ? PCRE2_PARTIAL_SOFT : 0, match_data, NULL);
 
-	if (slow)
-		pcre2_match_data_free(match_data);
-
 	if (rc >= 0)
 		return REGEX_MATCH;
 	switch (rc) {
-- 
2.39.0

