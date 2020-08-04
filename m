Return-Path: <SRS0=dV66=BO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDC2C433E0
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 01:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFD7120781
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 01:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="w2Y8a/1h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgHDBdc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Aug 2020 21:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHDBdc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Aug 2020 21:33:32 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F049FC06174A
        for <selinux@vger.kernel.org>; Mon,  3 Aug 2020 18:33:31 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id c12so20779512qtn.9
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2020 18:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=RT32yweqTmfDSy4bYjN1WNQdcpdshYzkUvt1F6G2i20=;
        b=w2Y8a/1hllZL5UeWfLscDDgBqrWRu7h7HRrVlcIXpDkkhtJvY9iKIbWU9StL4H6nxw
         4tUjPw/7/JLRRXk3n0lT9LyVG3q9RG6I/9lKg36IzrRJ2Ecr4Sg/AjpiiRvCky5aunPF
         rFSZuuF20qGx0TmO2WLBy88uMmdavZUHt++cvunofG2TNqXxgDfbCLvIPd/c9Wi8DYEZ
         NsOx4sIc7LbQyQT4/xMVNvJpVQvA9mlwDxqLuX++FgoAntTINDxc02VKmL1u8UiM+puL
         0iHe3L98t1sac2Um6vg25c6/5yX+KUHnSRFYyPTsRH4xTzQJ2SkvRwAxNwnsiQfkmo3y
         qPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=RT32yweqTmfDSy4bYjN1WNQdcpdshYzkUvt1F6G2i20=;
        b=FyzAWK92/qMibRLsv3wm2EGA5/MGsSB6LEn5XzQw949eg+rHGZswHYmr5MTkvZmD9E
         mDrjTRX7MpxbX6cop6CmmJOfL4TeuicTcmzIr+2TTZTQbE62JmYgC8ksX8KfJptuSSBL
         SjrGKwPMLpnF46jCmki+dHtktwvSeIlcYEshkF+rYOd8Vo4S+UVguulpN3XaHw7IEiGZ
         xcTG8PaWd3hyWP1/IkaBFDeOo7KI9zr6Z1R12vMdnJR0ajI7EqX6Yd+v0hYAKmcaFpl9
         fl1WhFCsxfnW90iwyXu5jdKsDueWdgv2TwFf5+1s4iQ+WXQD2gqV7AkJkwiWzTwlg5JU
         9BlQ==
X-Gm-Message-State: AOAM530YQX3WYAls28KiNXEirIGXNsb9psY08ewdqSBJO3+66X33Wz5c
        ZOlhYKoa9SzwEFNwG20VEHp3Ao+Eaydb
X-Google-Smtp-Source: ABdhPJwkZ1FTtaBmnFjaonbcmcIG6blyM+VAWRpPEE8tk2CW6VrCXcXpDY5kPD0pUIpmQ1Oikt9ywQ==
X-Received: by 2002:ac8:1e95:: with SMTP id c21mr19617087qtm.306.1596504810693;
        Mon, 03 Aug 2020 18:33:30 -0700 (PDT)
Received: from localhost (pool-96-230-24-152.bstnma.fios.verizon.net. [96.230.24.152])
        by smtp.gmail.com with ESMTPSA id c9sm20524691qkm.44.2020.08.03.18.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 18:33:30 -0700 (PDT)
Subject: [RFC,selinux-notebook PATCH 02/18] css: identify table layout hacks
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Mon, 03 Aug 2020 21:33:29 -0400
Message-ID: <159650480947.8961.9574180519610718746.stgit@sifl>
In-Reply-To: <159650470076.8961.12721446818345626943.stgit@sifl>
References: <159650470076.8961.12721446818345626943.stgit@sifl>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Better identify, and tweak, some of the table layout hacks so that
we know to revisit them later once we have fully converted to
markdown.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 src/styles_html.css |    1 -
 src/styles_pdf.css  |    6 +++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/styles_html.css b/src/styles_html.css
index ea3f7ee..887051c 100644
--- a/src/styles_html.css
+++ b/src/styles_html.css
@@ -21,7 +21,6 @@ table {
 }
 table tr, th, td {
 	border: 1px solid black;
-	word-wrap: break-word;
 }
 
 img {
diff --git a/src/styles_pdf.css b/src/styles_pdf.css
index 48da310..5fa9d02 100644
--- a/src/styles_pdf.css
+++ b/src/styles_pdf.css
@@ -62,12 +62,16 @@ table {
 	margin-left: auto;
 	margin-right: auto;
 	width: 95%;
-	table-layout: fixed;
 	/* combine table borders when they are adjacent */
 	border-collapse: collapse;
+	/* TODO: once we finish the HTML->Markdown conversion we should
+	 *       revaluate the 'table-layout: fixed' hack below */
+	table-layout: fixed;
 }
 table tr, th, td {
 	border: 1px solid black;
+	/* TODO: once we finish the HTML->Markdown conversion we should
+	 *       revaluate the 'word-wrap: break-word' hack below */
 	word-wrap: break-word;
 }
 

