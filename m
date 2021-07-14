Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4038EC11F66
	for <selinux@archiver.kernel.org>; Wed, 14 Jul 2021 18:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 260496128D
	for <selinux@archiver.kernel.org>; Wed, 14 Jul 2021 18:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239973AbhGNSQn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Jul 2021 14:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239092AbhGNSQn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Jul 2021 14:16:43 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63780C061762
        for <selinux@vger.kernel.org>; Wed, 14 Jul 2021 11:13:50 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id c17so4721098ejk.13
        for <selinux@vger.kernel.org>; Wed, 14 Jul 2021 11:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=I+mjAm6G/3wfcYSM1YkLi/1fXsxESJzYA3+GBs3PkQc=;
        b=IOQZVRcWZHWtnEJjSsoCUvVz8DERLNFSenMB12gkdo0UeXoPiESYWcQpeuDslQbze6
         MuPriCF0WYTIHw+IDNqYk00nOes5yw2xQG/1c1NS2fBV+pswqQWeyv+XqHaccTmxDt12
         0Jz7JBbXHHUJ5t88kYddeDyYiVhBUSfFj53Eq7xocCmJHF/OzJFft1dQF4ekGeAWrYAI
         tZXrFBs7jp8aZlU4RzUcO3WbyfTWUgsCOqNAVxQ448d6Jvz/z1K5tdlv6IUizJCZt8BN
         CjUDOqRk2Cxb5/A7btc1TcBQVroeSwzLV4gSwM8kFU4K7V6CPOOt5KXneTG1jtp8wIVX
         pI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I+mjAm6G/3wfcYSM1YkLi/1fXsxESJzYA3+GBs3PkQc=;
        b=XxiuUcPJL3JDoHVRkp0iH6O3V2OfS5oDgnpXbuNkhRyta145ThaBVRMqZI2MHJxbvA
         z1E6ECNQnBiFxkeUbkQekmpMjDmXC0/n9DrQ5kW/rfhgrcNWJ9z914YhVhlTaPjpCbE5
         DtLAd7L9AjMRKXrvZmenf32ZPzlHhlltsjD3yWWwiYD9XvSjWqPjnfQjdkw8UU0ytd00
         LmrW5SExWI9ZAqQQu8GvxN6X+ZmTbJnG+fmArPu5FTGinp9HbTM01JPEVDGGUFxKgFfp
         KvWzu5H3r3tEE4ZMtq7OdLDnjOnmjVMbF/BZvHcTZDYU6/3DeNE2KwNwH+/gLfMzxYAz
         4aoA==
X-Gm-Message-State: AOAM532hONN6JUKujGhgslhLXkkmMcq3ISlKHieTNyq6gKD0tJ8Pf7vt
        jtgr6HQp3LBvmsz5hyJx3l/Ml5WDYx0=
X-Google-Smtp-Source: ABdhPJyFUCxgxzcstUKrOcd+9iURVKwtW5cqOLI7c++S0dQVpl2tYLkal8pT0pbL8n9jZeo7xeJFbw==
X-Received: by 2002:a17:906:5384:: with SMTP id g4mr13997613ejo.27.1626286428973;
        Wed, 14 Jul 2021 11:13:48 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-198-161.95.116.pool.telefonica.de. [95.116.198.161])
        by smtp.gmail.com with ESMTPSA id ot18sm1020975ejb.109.2021.07.14.11.13.48
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 11:13:48 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 4/6] policycoreutils: free memory on lstat failure in sestatus
Date:   Wed, 14 Jul 2021 20:13:41 +0200
Message-Id: <20210714181343.58880-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210714181343.58880-1-cgzones@googlemail.com>
References: <20210714181343.58880-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In case lstat(3) fails the memory is not free'd at the end of the for
loop, due to the control flow change by continue.

Found by scan-build.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/sestatus/sestatus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/policycoreutils/sestatus/sestatus.c b/policycoreutils/sestatus/sestatus.c
index b37f0353..ceee0d52 100644
--- a/policycoreutils/sestatus/sestatus.c
+++ b/policycoreutils/sestatus/sestatus.c
@@ -461,6 +461,7 @@ int main(int argc, char **argv)
 				    ("%s (could not check link status (%s)!)\n",
 				     context, strerror(errno));
 				freecon(context);
+				free(fc[i]);
 				continue;
 			}
 			if (S_ISLNK(m.st_mode)) {
-- 
2.32.0

