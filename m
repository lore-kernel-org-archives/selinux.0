Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A719FC43616
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7619A61244
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhECRzE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 May 2021 13:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbhECRy5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 May 2021 13:54:57 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0645EC06174A
        for <selinux@vger.kernel.org>; Mon,  3 May 2021 10:54:03 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u3so9148787eja.12
        for <selinux@vger.kernel.org>; Mon, 03 May 2021 10:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=q1c+dSkGvb+QkY/rA9tywMX6zTIRP1JVcE26G5ixBJY=;
        b=QuafPaT7k/34b0IClduS4aejQlUgQwugA/P39+4cNoqi5wY0kgReeL+jHTwvIEBrzm
         TxDTsOV7707yURYUxmi3Cfjvq3XSW1x5sSCX3zEND69iFxkvU+omhPWWAHz629OUmqnM
         3yXC9Mdkxs+QyBHHr1Wu81QkMUa47D5eP1ob/+SNOae82ZCgJh3FsezRBDL26iadaDxS
         wN2CbhnJg0m3DrItCpNmbwFj5aO/4QLqpWAM2NahDddOmBnNVKtw32vyYhI9++4iMpNi
         PZWfXmZs4gspSja7SxsCQYMOOdzAYqG5ZL2oomP25GntBXDFoJwN5JYs+kyi51RdDDZp
         GurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q1c+dSkGvb+QkY/rA9tywMX6zTIRP1JVcE26G5ixBJY=;
        b=E19DGapMuHma92P4r1V5YQ6vuhfVavq5k8raHN9bmOWnOL2EM2VX+3xQjCNutrFmtn
         eYlpAQ+iLnS41eczdwpXL5kUBHzfqshZHidqS8/hMtO0EDPKdGK28FYlUJCReggwHECg
         Ujk8v3doPMiAA/4Hz4SOnI+MZKTvoKztYaVqJDwVQPRlgLzBL1DXpmpNi+hKunl/2K1w
         d1gQC+h/BimGLFlSoHNArt6OTpBMP3Dzb9qJT85UwuGkiJKweMs1FrBL+Cl+DkhEycx2
         YpS/3UjXT582c+TwmAbje3S6N62fmBNZjt+yLfNAuJ7qgumKIemevFdF59uHA17CmW7d
         DhDw==
X-Gm-Message-State: AOAM5330UZF6PDh6r4a1ruxdF1LW71RCFQc9BpgO76HUE5dZbKes3s1c
        evUrR68wJxcnzdq0wdOV8869IO4jSwORHg==
X-Google-Smtp-Source: ABdhPJw46mkbeBi12dwFkmbpQVj2HiRc2+02ic7EiKjgagytNWkAj6P3W2aU3ABDraeK0ensECXQ6w==
X-Received: by 2002:a17:906:6544:: with SMTP id u4mr17828181ejn.455.1620064441746;
        Mon, 03 May 2021 10:54:01 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-172-037.77.0.pool.telefonica.de. [77.0.172.37])
        by smtp.gmail.com with ESMTPSA id b17sm1830165edr.80.2021.05.03.10.54.01
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 10:54:01 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 20/25] libselinux: matchpathcon: free memory on realloc failure
Date:   Mon,  3 May 2021 19:53:45 +0200
Message-Id: <20210503175350.55954-21-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503175350.55954-1-cgzones@googlemail.com>
References: <20210503175350.55954-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In case `realloc()` fails and returns NULL, free the passed array,
instead of just setting the size helper variables to 0.

Also free the string contents in `free_array_elts()` of the array
`con_array`, instead of just the array of pointers.

Found by cppcheck.

src/matchpathcon.c:86:4: error: Common realloc mistake: 'con_array' nulled but not freed upon failure [memleakOnRealloc]
   con_array = (char **)realloc(con_array, sizeof(char*) *
   ^

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/matchpathcon.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index 9e1fab59..075a3fb3 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -78,17 +78,30 @@ static pthread_once_t once = PTHREAD_ONCE_INIT;
 static pthread_key_t destructor_key;
 static int destructor_key_initialized = 0;
 
+static void free_array_elts(void)
+{
+	int i;
+	for (i = 0; i < con_array_used; i++)
+		free(con_array[i]);
+	free(con_array);
+
+	con_array_size = con_array_used = 0;
+	con_array = NULL;
+}
+
 static int add_array_elt(char *con)
 {
+	char **tmp;
 	if (con_array_size) {
 		while (con_array_used >= con_array_size) {
 			con_array_size *= 2;
-			con_array = (char **)realloc(con_array, sizeof(char*) *
+			tmp = (char **)realloc(con_array, sizeof(char*) *
 						     con_array_size);
-			if (!con_array) {
-				con_array_size = con_array_used = 0;
+			if (!tmp) {
+				free_array_elts();
 				return -1;
 			}
+			con_array = tmp;
 		}
 	} else {
 		con_array_size = 1000;
@@ -105,13 +118,6 @@ static int add_array_elt(char *con)
 	return con_array_used++;
 }
 
-static void free_array_elts(void)
-{
-	con_array_size = con_array_used = 0;
-	free(con_array);
-	con_array = NULL;
-}
-
 void set_matchpathcon_invalidcon(int (*f) (const char *p, unsigned l, char *c))
 {
 	myinvalidcon = f;
-- 
2.31.1

