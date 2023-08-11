Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A26C04FDF
	for <selinux@archiver.kernel.org>; Fri, 11 Aug 2023 16:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjHKQ16 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Aug 2023 12:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbjHKQ14 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Aug 2023 12:27:56 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D4A2D78
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:55 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99c4923195dso298184466b.2
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691771274; x=1692376074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CfrxVDE9VstbWj4fn7sebiRQEdVJJz4CbC0Rg1wJlB8=;
        b=nbIkU22tQ4w2XYwjz3q4uQCy52zjEQ0MMgFXGZcsC/gQsGrxnbqmu8+0eEPfMtx8/7
         KONctYMU+pjHVKx0efO0m2ESft0pfCbb5pdpctFlZtHWiHp/Bu84WoJEb3UkZEl0gu/6
         6WSxlfnw/E0+bhgu+36quyuTKckrl4iokBsCzMuIqfVPLAfP2KxJO7CeyZ/t/JWxhtrn
         FOc5tS5zL0WtT1OZlT4Wo8c2E/VDBO0zopbGK9F3hZwIIe3B3SXfghBhEiUahc8TF1WE
         uzfLzcdZq35VMQnWrfyRzM9XSGTeTCLreVr4nlG3EDU+M4R+gmsrd4OG7SYGJ+wiIGHG
         gouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691771274; x=1692376074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CfrxVDE9VstbWj4fn7sebiRQEdVJJz4CbC0Rg1wJlB8=;
        b=V70C3mUKLgsiOHkZmPzFFXHF1FI05zd9PiMRAjxaYslPpVdeemNQazdbRuZw69z8bI
         LdHQEvBlDjBfq/vZmEvH15O6z97hYk55gv7Y4/e2UD75Ie+DJYIw4ZbmgbPh0qUyN4Ve
         8fvxKujRw5PSDfEsOLkB0Hn0hW4LgA++vEnPoD2zBaOmQnBfNmp0p+bKLyN4TRAH39n+
         N37fTR6mYBULbV/Csr+QLRXlPJ0mOoKKCVuVUhdbWrQgjkFZf5ghLS91RKwyP5sSTFEH
         XYYZAi0F3kr8M6UI8lQkPDoN3U2CxkFoC56b8l/70Kujr+D7z4bhtn+W5ZeisqOhd+FO
         8Glw==
X-Gm-Message-State: AOJu0Yy1sw+JWaF4pGiThkYLJJwUHvF4oQpFIkaudF798Kb+4/U39So1
        BclhMFjwHuujBcd+W2yk5aUkOoYtVp/hGQ==
X-Google-Smtp-Source: AGHT+IGySbSvrN1nVYRiK9mKF+D3Fsu07rA63dl197goCP6G+JkVIFRfFYeb/39Xr5fIYeTth/M83w==
X-Received: by 2002:a17:906:3ca9:b0:99b:ea8f:9003 with SMTP id b9-20020a1709063ca900b0099bea8f9003mr2254826ejh.50.1691771274260;
        Fri, 11 Aug 2023 09:27:54 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-174-226.77.0.pool.telefonica.de. [77.0.174.226])
        by smtp.gmail.com with ESMTPSA id p9-20020a170906b20900b00992afee724bsm2408807ejz.76.2023.08.11.09.27.53
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 09:27:54 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 11/24] libselinux/utils: use type safe union assignment
Date:   Fri, 11 Aug 2023 18:27:18 +0200
Message-Id: <20230811162731.50697-12-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230811162731.50697-1-cgzones@googlemail.com>
References: <20230811162731.50697-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

    selinux_check_access.c:43:10: warning: cast to union type is a GNU extension [-Wgnu-union-cast]
       43 |                                      (union selinux_callback)cb_auditinfo);
          |                                      ^                       ~~~~~~~~~~~~

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/selinux_check_access.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/utils/selinux_check_access.c b/libselinux/utils/selinux_check_access.c
index 6cea40e9..f7b27a85 100644
--- a/libselinux/utils/selinux_check_access.c
+++ b/libselinux/utils/selinux_check_access.c
@@ -40,7 +40,7 @@ int main(int argc, char **argv)
 
 	if (audit_msg)
 		selinux_set_callback(SELINUX_CB_AUDIT,
-				     (union selinux_callback)cb_auditinfo);
+				     (union selinux_callback) { .func_audit = cb_auditinfo });
 
 	rc = selinux_check_access(argv[optind], argv[optind + 1],
 				  argv[optind + 2], argv[optind + 3],
-- 
2.40.1

