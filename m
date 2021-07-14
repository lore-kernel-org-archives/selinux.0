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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0569C11F67
	for <selinux@archiver.kernel.org>; Wed, 14 Jul 2021 18:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A53E6128D
	for <selinux@archiver.kernel.org>; Wed, 14 Jul 2021 18:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239899AbhGNSQn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Jul 2021 14:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239918AbhGNSQm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Jul 2021 14:16:42 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EFCC06175F
        for <selinux@vger.kernel.org>; Wed, 14 Jul 2021 11:13:50 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id t3so4361838edc.7
        for <selinux@vger.kernel.org>; Wed, 14 Jul 2021 11:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ziM0fkJuZyD2AWczxGjHTbFbRPnaPU4JiMm5QdUbPQk=;
        b=N1mirWmv1ZC7brueBPmwtVgFkw+rTR6mqVOgGsPxmvsyFpLX5AdY/BE6H746nf7tWw
         yKuCV1LmF2JrfUfiIzpKub4PTH/UpagHnFMxqBRDGY4+IIyhSozIKahYPYf1aMdZIaCW
         8nks+GQdtygUdG0kY69qVBV5sXf0uyA82ITQRKOv9E3f3S0tocST16l47S80tSyyUz7F
         VMWG+aXu/4B26HxDF76HyMmojXBQJTPP5/WwolneKlv4U23eo2tDacEEaSpvsCH/Vwe6
         R5zU9nFyWsxmPmGEE+Y5bZUGJUaoInZuiDQHuTYdKZh8H27TtAGq+i7HoeeSVRnJo15l
         i/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ziM0fkJuZyD2AWczxGjHTbFbRPnaPU4JiMm5QdUbPQk=;
        b=uFUWfhJM5m+jD3zrfK5Raizlzy3LKcdUe5e019n5rp6UB3CJa/bLBVipZGAqPefZnm
         rt8TarX8b+vCWKiy9q/zpIiBJjacAV7fUiQsKtDk2hlYy70rfX7Cn8aGSJTr5Wvv4FQ/
         +SSlFk2cL1rglwv9FUo5zaP49302ktgQekj8BX0iLQhcDzxO7AcckwGN4TA/nzvbHfHv
         IgvkSpsyB2xqaksWdUsUHJElQYhT+ip2vD2fPZ4wVIEotU1533rdhjoV30Z2g82BPQes
         DkBy6kOTcSz7HxOCDEdy39SMIfyYwzdI49HQquQf+BA282kFMYXCAMkBiNpiN1TxK1bF
         pt1w==
X-Gm-Message-State: AOAM531n6ijpsSn5+D4Fcorgd6Oh4NsD8nyDngXw+xV2kscDwHZwpWKC
        kdlyGgpTkZ65Pk4fXW8hohFC+JUXlYo=
X-Google-Smtp-Source: ABdhPJzPQCeFtAdEiZp++adAb24MObj3Qsll2T7kcyYX65Fj7E/57VWNhg9w6rO8ZVkSha3JaPdwHw==
X-Received: by 2002:a05:6402:35d4:: with SMTP id z20mr15993530edc.138.1626286429512;
        Wed, 14 Jul 2021 11:13:49 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-198-161.95.116.pool.telefonica.de. [95.116.198.161])
        by smtp.gmail.com with ESMTPSA id ot18sm1020975ejb.109.2021.07.14.11.13.49
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 11:13:49 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 5/6] policycoreutils: free memory of allocated context in run_init
Date:   Wed, 14 Jul 2021 20:13:42 +0200
Message-Id: <20210714181343.58880-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210714181343.58880-1-cgzones@googlemail.com>
References: <20210714181343.58880-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Found by scan-build.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/run_init/run_init.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/policycoreutils/run_init/run_init.c b/policycoreutils/run_init/run_init.c
index 1c5eb68e..545490a2 100644
--- a/policycoreutils/run_init/run_init.c
+++ b/policycoreutils/run_init/run_init.c
@@ -406,14 +406,19 @@ int main(int argc, char *argv[])
 
 	if (chdir("/")) {
 		perror("chdir");
+		free(new_context);
 		exit(-1);
 	}
 
 	if (setexeccon(new_context) < 0) {
 		fprintf(stderr, _("Could not set exec context to %s.\n"),
 			new_context);
+		free(new_context);
 		exit(-1);
 	}
+
+	free(new_context);
+
 	if (access("/usr/sbin/open_init_pty", X_OK) != 0) {
 		if (execvp(argv[1], argv + 1)) {
 			perror("execvp");
-- 
2.32.0

