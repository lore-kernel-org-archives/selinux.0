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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61DCC11F68
	for <selinux@archiver.kernel.org>; Wed, 14 Jul 2021 18:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F041613C3
	for <selinux@archiver.kernel.org>; Wed, 14 Jul 2021 18:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239986AbhGNSQn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Jul 2021 14:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239092AbhGNSQn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Jul 2021 14:16:43 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C258FC06175F
        for <selinux@vger.kernel.org>; Wed, 14 Jul 2021 11:13:51 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id nd37so4799039ejc.3
        for <selinux@vger.kernel.org>; Wed, 14 Jul 2021 11:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=irGbfK4DqMAI/5PrSBE+ev8F8q53nGm4C016+uwtSig=;
        b=LLu2ARhPj13CYBPOrEkIClpxMPUT7y5yDfRluApvPizZs9FnPsb3f5y6bchT+aL2is
         SEv0OkCUQJln/t6YwnU3JqXfJPFuPcQhlaI6HNipZQMd0ZoLgoJ+gtv0zI0JxyTskdeG
         qACt9UQrTP+xLxsjQ+ptuhzdXT1UYzPvXZnSx8f29Z2u9tA461Kp7mMLc0xOIzZ0JN50
         jCCxcgivTnkbFBvefBGPubPCQ0mG5XK02+sC5eSPdX9U0hfasfNGw5iLzuB4jWR1iwaU
         TKZvU/NnNgOu2nVzo1Ih5QsMPcCoyBfz/hDtAC85gGPCYMs/0P4PsiHTz7DC6f9Un2oU
         qYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=irGbfK4DqMAI/5PrSBE+ev8F8q53nGm4C016+uwtSig=;
        b=mHlpP6PrYhJ0Su2J0Ym3GYH3tCX1Ba3PjPCLFv0rpZuJEUNYuQoOvjVgf4kY2Kh1Nq
         4F0VeJHfH3MC8hKuAOVphBT7dR+eohK0+M3ywuFP0yc1k9OkdZk1EJxAOdoUlTGt4SdM
         n+Ordz6McmTtyv6S3FpFXnaA91dIPXcKSiVR/OeZr/24zYY/hr7Rc9Dm6LfptlBcM0KD
         jYoD3ahYS1vD7TnC2YoqrssLa3jgLSk2FFBdAAbIIXJ30Gm7zBTf5Iyy8tV8MJ7YURvT
         fWIo5ztXk83M9BUpQpI42QhOZT8cxeQWDDwzZgL1dGNyOY52J1Wt291w8yLIoWsLs30a
         YqfA==
X-Gm-Message-State: AOAM532D0l+mhYf4tnuoQMtnm76e8DuvpOWqh84+kLrcrQToErOLIURc
        qoG5ofp/CzxTFeyF6DPy2F5l4WBEZ3c=
X-Google-Smtp-Source: ABdhPJyOCO8fa7x6voazcN6zWYgo6ipFrDOsFtF2C0WEDMabNbqL17X0v7vzOahxMr9rOEjTD5LMJQ==
X-Received: by 2002:a17:907:e8c:: with SMTP id ho12mr7665466ejc.552.1626286430120;
        Wed, 14 Jul 2021 11:13:50 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-198-161.95.116.pool.telefonica.de. [95.116.198.161])
        by smtp.gmail.com with ESMTPSA id ot18sm1020975ejb.109.2021.07.14.11.13.49
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 11:13:49 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 6/6] policycoreutils: free memory of allocated context in newrole
Date:   Wed, 14 Jul 2021 20:13:43 +0200
Message-Id: <20210714181343.58880-6-cgzones@googlemail.com>
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
 policycoreutils/newrole/newrole.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
index 0264531a..7c1f062f 100644
--- a/policycoreutils/newrole/newrole.c
+++ b/policycoreutils/newrole/newrole.c
@@ -1239,6 +1239,7 @@ int main(int argc, char *argv[])
 		free(pw.pw_dir);
 		free(pw.pw_shell);
 		free(shell_argv0);
+		free(new_context);
 		return exit_code;
 	}
 
-- 
2.32.0

