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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CFFC11F66
	for <selinux@archiver.kernel.org>; Wed, 14 Jul 2021 18:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70548613BA
	for <selinux@archiver.kernel.org>; Wed, 14 Jul 2021 18:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhGNSQl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Jul 2021 14:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239092AbhGNSQl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Jul 2021 14:16:41 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B969C061760
        for <selinux@vger.kernel.org>; Wed, 14 Jul 2021 11:13:49 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id hd33so4752639ejc.9
        for <selinux@vger.kernel.org>; Wed, 14 Jul 2021 11:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=X3FlQqkgsJX6pjmpzjzwEzUKoTL2ceRrEt9ap0iYDls=;
        b=eYRcBM+L/m1cN5xeNup3SQOijcOpEPaqeAlcMwcOpNi05/2bXTzAHCAKxdrq3+ELAf
         A3JkSY3rlyEcG/DHFx9xWiXiGOWgVuPeDNSI1imnTSnFC2PYWZ1sHxnFGcsou7Sh8IP2
         b1wFBa0hLYOuUB9mEsDzDlh6J7CyxA3j7tH9QeX+anbrZVTuvn320kE9kn4rRZD+b9JF
         IYp/nJ9F4/HE3PYzGy1AG6ilSqF8e35IfuI7IhoZX1eApnRHL66DIPLzouKiB705eoJH
         8cN2BheYVD8J992wLKWo1zM8UKZFaguMhT6gn2YnFs5xpAQmg0Pw06nlQjWyS31+GnHP
         3+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X3FlQqkgsJX6pjmpzjzwEzUKoTL2ceRrEt9ap0iYDls=;
        b=sgyMsGdbnr6xWtjsF2S0s+lPsLuf0hrdYM4WaxBbX7sgObx8bzfG5Ha7/absedV6d1
         f11SAwNxjbWMzihVlZK2LmM8772JT99EuxkbR3A7Tn4xLjkhimnvk2H2icQ76WjHVpkO
         D5E5bEYAsaFLK0Sk3UChzirjvXkUsK5+2RRK10yH4CKAWaOt5tOjnprL7sLmEOgjz4dJ
         bfQdis3h84bPcwA7Izr4CwLV9WF04utnvtyxiwy1L93VrInOkVEKznJ+rQVn3rBShYFW
         RSgswu/pojXf1tK3rZDNWt7nfTKHJRtav/ANGyBgQK3WQgcsgHEV/fr/deWAdEBK73aK
         8yKw==
X-Gm-Message-State: AOAM532CPiPaeYFb2kjLd25++T7Fp+1wWYNz2HwWuCrBVWO6BHNb4+Gt
        ekmjxttc8b+BXBpkA43rAbCfKObU/tM=
X-Google-Smtp-Source: ABdhPJxjQYZU0oscBnl5c5a3IPg3UrOPr2iI2UeTUpQSSpkDV97PseiI0zYLqjBAQn+5goWI4Rrgyg==
X-Received: by 2002:a17:906:b53:: with SMTP id v19mr13317850ejg.262.1626286427778;
        Wed, 14 Jul 2021 11:13:47 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-198-161.95.116.pool.telefonica.de. [95.116.198.161])
        by smtp.gmail.com with ESMTPSA id ot18sm1020975ejb.109.2021.07.14.11.13.47
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 11:13:47 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/6] secilc: fix memory leaks in secilc
Date:   Wed, 14 Jul 2021 20:13:39 +0200
Message-Id: <20210714181343.58880-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210714181343.58880-1-cgzones@googlemail.com>
References: <20210714181343.58880-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When specifying -o or -f more than once, the previous allocations leak.

Found by scan-build.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 secilc/secilc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/secilc/secilc.c b/secilc/secilc.c
index 1c4f1ca0..80d3583d 100644
--- a/secilc/secilc.c
+++ b/secilc/secilc.c
@@ -199,9 +199,11 @@ int main(int argc, char *argv[])
 				qualified_names = 1;
 				break;
 			case 'o':
+				free(output);
 				output = strdup(optarg);
 				break;
 			case 'f':
+				free(filecontexts);
 				filecontexts = strdup(optarg);
 				break;
 			case 'G':
-- 
2.32.0

