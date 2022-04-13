Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A32C433EF
	for <selinux@archiver.kernel.org>; Wed, 13 Apr 2022 15:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbiDMP7G (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Apr 2022 11:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbiDMP7F (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Apr 2022 11:59:05 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76516579A
        for <selinux@vger.kernel.org>; Wed, 13 Apr 2022 08:56:42 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u15so4823353ejf.11
        for <selinux@vger.kernel.org>; Wed, 13 Apr 2022 08:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uJDBjRixr1V5+t5+tCsubIlBRlVoDbKkmUDmxIB/h0A=;
        b=o227K+uWvmNHrKHI0W7+6eILMlEp6PgAdVhYlZwbWW3jzHoQ2T3eZzIUxLYQlE57rH
         yT8MhVGvWDKwBt3vuwRFsCeWZxPOhQVOM0K7J2UqkY7grzDDt7wkG3beFVEOztwzSgol
         qF3RC2C0QpiG/xTQEnFejgxen+3lt+EHmtM+Kb8FtpyBnaj+HJ0GMLQMQQzzS6iAFx1e
         I6OGZS4ThDpy8mYwUJva47wl1/1tKGqJMto+S6XswkNbLfFA+4Kblk//pABr55pTfg+f
         MQLg+WRYofH7yREbJun+WRwL+z9HFjBXj6VblnKGt31D4oCDzO9UQQr5OvfDhS8JM6bR
         HG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uJDBjRixr1V5+t5+tCsubIlBRlVoDbKkmUDmxIB/h0A=;
        b=SuqIncGF1CbgplFlUH3vNkstgZJSQ7VnPYZOKm+nCRrSBvjuStalI/2cQYSfeURNJT
         4RZsT3XewMk/r13RzQu3onNQCjCX1CqF78dQJSfzvUCqPs7J1ABseRwUCacX6VKG5cRG
         JjPkDmtpEnfB7/CzC9gLvySxjuApY0CQWwW7HLPVL61TLLqbgDa6JH1hZwcO1xUtyJHc
         gpm0zXlLVQ0Ps/fzX1aT41gakQqW7xeKHTOyM1DYJ0InsQVwUgnhTp+3sbW2lzHJsSrC
         p2vDwLx4o3ygUhdgvUJk+yvDIOFwbUBn4ljoCyC6b0NQtez3Y0ypqunbtjiXXCVE1wm/
         gCYw==
X-Gm-Message-State: AOAM5310Lr6gXywVczcGmOaBnJGqx081RufmLk1ge78ERGkhasxi12vd
        R0uUZExQNEdOxpwSM3Y0j+FWWtzMruI=
X-Google-Smtp-Source: ABdhPJyKFJk1O5JPARzZm2XuTtx0UFZAx7G4PnGSw3Gi+WCMwy3FR/MLo9OWYnNUHz7coYtRlMxZzw==
X-Received: by 2002:a17:907:608c:b0:6e8:ad4b:b501 with SMTP id ht12-20020a170907608c00b006e8ad4bb501mr8714340ejc.466.1649865401470;
        Wed, 13 Apr 2022 08:56:41 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-215-252.77.0.pool.telefonica.de. [77.0.215.252])
        by smtp.gmail.com with ESMTPSA id kw3-20020a170907770300b006b2511ea97dsm121296ejc.42.2022.04.13.08.56.40
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 08:56:40 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/3] libselinux: correct parameter type in selabel_open(3)
Date:   Wed, 13 Apr 2022 17:56:31 +0200
Message-Id: <20220413155633.62677-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

selabel_open(3) takes an `unsigned int` as backend parameter.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/man/man3/selabel_open.3 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/man/man3/selabel_open.3 b/libselinux/man/man3/selabel_open.3
index 971ebc1a..c8348ca4 100644
--- a/libselinux/man/man3/selabel_open.3
+++ b/libselinux/man/man3/selabel_open.3
@@ -10,7 +10,7 @@ selabel_open, selabel_close \- userspace SELinux labeling interface
 .br
 .B #include <selinux/label.h>
 .sp
-.BI "struct selabel_handle *selabel_open(int " backend , 
+.BI "struct selabel_handle *selabel_open(unsigned int " backend , 
 .in +\w'struct selabel_handle *selabel_open('u
 .BI "const struct selinux_opt *" options ,
 .br
-- 
2.35.2

