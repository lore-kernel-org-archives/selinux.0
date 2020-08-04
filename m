Return-Path: <SRS0=dV66=BO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CD8C433DF
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 01:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3818020781
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 01:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="tbLFGm5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbgHDBdi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Aug 2020 21:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHDBdi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Aug 2020 21:33:38 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAB3C06174A
        for <selinux@vger.kernel.org>; Mon,  3 Aug 2020 18:33:38 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 77so4763056qkm.5
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2020 18:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=5fTIi0PQ8YABtKnFj2l7LiM2WgmTwIcrXUBwbnQL4i4=;
        b=tbLFGm5f5v5sMfVrgrw/zBzfMliiaEOU0/5hcry1UmcbXjYUGcw0Wf9h3mfhyc5LC9
         txE6H2i4K67WAGt4T8KGzmpj2K28XRhpeKZrxG5s30qVqYxcfO47hybbX/QWp6Tb1xoE
         g7JaBI+VPNmU8ibYSJUDR6mXGECD1HWYicdhH5PFYclC5HeOSLtZ/39K5p++soz64l8m
         DOQEq+TgBl5q4NRkf6q+cK7Zyf+zWfH47nquuGEWMGGKS3BDgGk1WGeMBFPRZhvzKGGy
         GPISJVoqCZCR+FHkQFbmOGRD9U2wInQIzqC7M4+oSGWEeEIP23OOvun/5e2kZrM4B0Ry
         fnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=5fTIi0PQ8YABtKnFj2l7LiM2WgmTwIcrXUBwbnQL4i4=;
        b=ATe1a8QdUS1wIeZMZRsxDbjGU8t4qIJ/KFdw14cn9UPf7BKQKI5uG9FZ6XvCKMKRu2
         O+sZHXJqpoCz4fluOTnAmL3t5HM0OpASqDjz/4UFRfUk9r7DWztQu7IZwEudwifG55oo
         J/hYjdTtjPSyGdEwFFvAQV4RSgew1XCWD5TYAer5Cdvht3COoP45dv4bspckW5HygT4U
         6gVeq1cR0d8SS780xjc9qgoZmGm8hCUNfUjgwtmRRrnUTO9EteikqELhcj51YYY2bDge
         gsF3J3sXohBfo7DnjYpytGneVyP0/ye4gMbkaMvtJziHnm6o6tU6/2iboOTb/2oJ8eTj
         jVXA==
X-Gm-Message-State: AOAM531RMyElAr5rUOZsylSSptGJWlNCJHdPbyIY2RsVxTDI/z6oDj4P
        V6VWSoAyP/wCV71qF17a+Fygqebh62SF
X-Google-Smtp-Source: ABdhPJxnXeZBxUtvL72HiiQhMMOi+W5QgInAlMnJPmVKecjLZ4tJbed/I6T5Q6Y2zZb9TNcNtc/xmg==
X-Received: by 2002:a37:6644:: with SMTP id a65mr18748895qkc.4.1596504817090;
        Mon, 03 Aug 2020 18:33:37 -0700 (PDT)
Received: from localhost (pool-96-230-24-152.bstnma.fios.verizon.net. [96.230.24.152])
        by smtp.gmail.com with ESMTPSA id z126sm19953507qkc.58.2020.08.03.18.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 18:33:36 -0700 (PDT)
Subject: [RFC,selinux-notebook PATCH 03/18] css: style improvements
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Mon, 03 Aug 2020 21:33:35 -0400
Message-ID: <159650481580.8961.18287412326005256104.stgit@sifl>
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

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 src/styles_html.css |   15 ++++++++++++++-
 src/styles_pdf.css  |   18 +++++++++++++++++-
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/src/styles_html.css b/src/styles_html.css
index 887051c..fef851e 100644
--- a/src/styles_html.css
+++ b/src/styles_html.css
@@ -15,11 +15,18 @@ a {
 
 table {
 	/* limit to 95% page width */
+	min-width: 50%;
 	max-width: 95%;
 	/* combine table borders when they are adjacent */
 	border-collapse: collapse;
 }
-table tr, th, td {
+table th {
+	padding: 0.5em;
+	border: 1px solid black;
+	background-color: #d3d3d3;
+}
+table tr, td {
+	padding: 0.5em;
 	border: 1px solid black;
 }
 
@@ -30,3 +37,9 @@ img {
 	margin-right: auto;
 	max-width: 95%;
 }
+
+pre {
+	width: 95%;
+	padding: 1em;
+	background-color: #f5f5f5;
+}
diff --git a/src/styles_pdf.css b/src/styles_pdf.css
index 5fa9d02..f0bba23 100644
--- a/src/styles_pdf.css
+++ b/src/styles_pdf.css
@@ -68,7 +68,16 @@ table {
 	 *       revaluate the 'table-layout: fixed' hack below */
 	table-layout: fixed;
 }
-table tr, th, td {
+table th {
+	padding: 0.5em;
+	border: 1px solid black;
+	background-color: #d3d3d3;
+	/* TODO: once we finish the HTML->Markdown conversion we should
+	 *       revaluate the 'word-wrap: break-word' hack below */
+	word-wrap: break-word;
+}
+table tr, td {
+	padding: 0.5em;
 	border: 1px solid black;
 	/* TODO: once we finish the HTML->Markdown conversion we should
 	 *       revaluate the 'word-wrap: break-word' hack below */
@@ -82,3 +91,10 @@ img {
 	margin-right: auto;
 	max-width: 95%;
 }
+
+pre {
+	/* force/limit to 95% page width */
+	width: 95%;
+	padding: 1em;
+	background-color: #f5f5f5;
+}

