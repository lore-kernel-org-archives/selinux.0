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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5D7C43600
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CD7461278
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhECRzC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 May 2021 13:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbhECRy4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 May 2021 13:54:56 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6F3C061346
        for <selinux@vger.kernel.org>; Mon,  3 May 2021 10:54:01 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id j28so7295309edy.9
        for <selinux@vger.kernel.org>; Mon, 03 May 2021 10:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RO441n4/VIEk7ehh6qb3RnHBVuLrEYuAYiYFb0xNGt4=;
        b=TVK/Nf5+1cIY4X9pRRVLUdNC/ZEBkKwrWnf5APJ/ZAYKPtMhTC698Kc3SB+TX1Noal
         z/ChnKE6jiZanWtQiQYYUeWjCyt6b07gU9uxtMrcIls0Bw3Wr+x9BU+1poOe0MseX8X8
         49AdWdNT/QKNOvD+23J3NbSz42Uw3JvEZlqRHEpopRJnoa9P91ULMEiF830qcMCtyPQe
         1K3ue95jkvykwP+Axu6+RIW1ChO3WgN7zRXMmP2XZJkyHQnIGUgc5+EteRH2TedXwh1c
         Y+Cmm1x+RqAyiAkl8ocECdscr2wR61pIddqNG+msRuSBXpeeI7WFrJf/fr5lDM2iSH8e
         UqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RO441n4/VIEk7ehh6qb3RnHBVuLrEYuAYiYFb0xNGt4=;
        b=PYD8qVrNIljT0YqISuLd5KxXSNQq//hEwaBreRdRJPoaJ090YDxRN2T1inrnz5aVTD
         7CIgMzNG7y3Y3NZh+FG9kFjUeu+SH2NK12FX0dnB/XlDXhA216uQTcrofecsTjKcd1Si
         GdQyb8fJpBSTKnEiFZ1oljb9VCGSpyeemYYImLtayhXuQKe2c/H2FP1iOvp4IhDutRfK
         Yd8GMqYJ/5KJ4UrEa8DEmUrSL2laS848on41sjO5HI14VRhP+7yiNJzK6KCvXRUXK7Db
         dolNu+JpZP3Z3msl/yGrPFkXDc74nSLp/d6mPq45tl6+C/vSs8RNa0v+v627GKXSA5y5
         PgcQ==
X-Gm-Message-State: AOAM5332qST3qYF8R92JzEi0AuyykN5UV3uGTyuEB7vv83Vk/GvnWcno
        dzXVO24QH5WTXvhFTaB+/9fa1HrEnA/ffQ==
X-Google-Smtp-Source: ABdhPJzxKoYs9V4PD/KzBwYJxMySdwzSt+9LUVEKi4Gszzs34p4YKPZWvp/4jnoSndcly4oSHAvHeQ==
X-Received: by 2002:aa7:cc98:: with SMTP id p24mr21232235edt.187.1620064440231;
        Mon, 03 May 2021 10:54:00 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-172-037.77.0.pool.telefonica.de. [77.0.172.37])
        by smtp.gmail.com with ESMTPSA id b17sm1830165edr.80.2021.05.03.10.53.59
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 10:54:00 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 15/25] libselinux: getdefaultcon: free memory on multiple same arguments
Date:   Mon,  3 May 2021 19:53:40 +0200
Message-Id: <20210503175350.55954-16-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503175350.55954-1-cgzones@googlemail.com>
References: <20210503175350.55954-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Do not leak memory if program arguments get specified more than once.

Found by clang-anlyzer.

getdefaultcon.c:52:3: warning: Potential leak of memory pointed to by 'level' [unix.Malloc]
                fprintf(stderr,
                ^~~~~~~~~~~~~~~
getdefaultcon.c:52:3: warning: Potential leak of memory pointed to by 'role' [unix.Malloc]
                fprintf(stderr,
                ^~~~~~~~~~~~~~~
getdefaultcon.c:52:3: warning: Potential leak of memory pointed to by 'service' [unix.Malloc]
                fprintf(stderr,
                ^~~~~~~~~~~~~~~

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/getdefaultcon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/libselinux/utils/getdefaultcon.c b/libselinux/utils/getdefaultcon.c
index 96a5a8c2..957c1cb2 100644
--- a/libselinux/utils/getdefaultcon.c
+++ b/libselinux/utils/getdefaultcon.c
@@ -28,12 +28,15 @@ int main(int argc, char **argv)
 	while ((opt = getopt(argc, argv, "l:r:s:v")) > 0) {
 		switch (opt) {
 		case 'l':
+			free(level);
 			level = strdup(optarg);
 			break;
 		case 'r':
+			free(role);
 			role = strdup(optarg);
 			break;
 		case 's':
+			free(service);
 			service = strdup(optarg);
 			break;
 		case 'v':
-- 
2.31.1

