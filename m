Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4D3C10F1E
	for <selinux@archiver.kernel.org>; Thu, 15 Dec 2022 21:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiLOVep (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Dec 2022 16:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiLOVen (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Dec 2022 16:34:43 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEEF1C437
        for <selinux@vger.kernel.org>; Thu, 15 Dec 2022 13:34:42 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id e141so347793ybh.3
        for <selinux@vger.kernel.org>; Thu, 15 Dec 2022 13:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJxhMP6E88t4wzBZeJ8ExOZQRdjkovGmykpxKqNdebE=;
        b=a/qW3xRsf2a/daThtPUicjl9730sB4fJytFejRfCp+/9pFa4jN8qALpK2iVLzl2aDk
         IgtBgKxwBXBenmgk5r+EsJrnPEwtB8zooEAvA+TfMM58gngyPjYkS5W3uT5TLlx0/qBk
         /hvV4lv1fvLY5HM810Loty+Bhpt603/jIHrLlf4E/WF/9Ta9voFgmeEfCghcOEfq9uuu
         u7Ri3iQLBJ47Qm6KzgVdypdUbLBbQQ/FcEXNBlxjA3K6mQsolx1zpbEAiDouJ72a6Z/L
         i2tq/pexb9YT6sNhhdua2WVxVK2res6hPT/yvTJXk+3BfZgY8zKHomIdo+bvQpwGiDxH
         nYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJxhMP6E88t4wzBZeJ8ExOZQRdjkovGmykpxKqNdebE=;
        b=03AlstI8Y3I7aM18VStg+6QiN3cKMdDUFG30sOgB1TpCiv0ZH4ZynoMUiSUh8WkZa1
         1n0J7Z+bFWhosIr7Byqa2E5vvhGOGzKzKeYurqFjXZTBe6cfat+wnC6g3A+4+HBmlorW
         V6MxibUgU8zNwhmyuAyLntr/Bc/E0WIuYSEPVOIMwxOZ0kme59PkjYcQCI1NSR5qJFO9
         gb2ob2WtrSpx4JtmIWu5pi6QJrFHvSHYyey4g5VdmJLkFoDaRHJlQrbblCoPw+8w1ADA
         LDmP3dHPaDtO83QHndy7UGFlWEtUEJ3Jceucvr5UMxK3bM8OIM7Ld0ubGR7+xrf1eaUA
         nBhg==
X-Gm-Message-State: ANoB5pksmvMF/UTaKCf+tR0MQuMZ2XOZ0Byqe/A3D9uRpNw7c1Z/e8ON
        ipzPCyFp1Ee90jHz+JXfhKu+ubiBrAg=
X-Google-Smtp-Source: AA0mqf6we62bHcKHvpAj5vJzR7oeSsIcG5YYGj9duu3INvYL2m3HWPxllW8hQECycIwbONbhh66FjQ==
X-Received: by 2002:a25:10d4:0:b0:6fe:301f:13b1 with SMTP id 203-20020a2510d4000000b006fe301f13b1mr25581262ybq.41.1671140081801;
        Thu, 15 Dec 2022 13:34:41 -0800 (PST)
Received: from electric.. (c-73-200-155-132.hsd1.md.comcast.net. [73.200.155.132])
        by smtp.gmail.com with ESMTPSA id w10-20020a05620a424a00b006a6ebde4799sm21066qko.90.2022.12.15.13.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 13:34:41 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, James Carter <jwcart2@gmail.com>
Subject: [RFC PATCH 6/9] libsepol: Export the cil_write_post_ast function
Date:   Thu, 15 Dec 2022 16:34:26 -0500
Message-Id: <20221215213429.998948-7-jwcart2@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221215213429.998948-1-jwcart2@gmail.com>
References: <20221215213429.998948-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/libsepol.map.in | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
index 844924fc..6ad68f0b 100644
--- a/libsepol/src/libsepol.map.in
+++ b/libsepol/src/libsepol.map.in
@@ -289,3 +289,8 @@ LIBSEPOL_3.4 {
 	sepol_string_to_security_class;
 	sepol_validate_transition_reason_buffer;
 } LIBSEPOL_3.0;
+
+LIBSEPOL_3.5 {
+  global:
+	cil_write_post_ast;
+} LIBSEPOL_3.4;
-- 
2.38.1

