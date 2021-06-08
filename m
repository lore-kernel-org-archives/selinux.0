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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5AEC4743E
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 15:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B467060FEA
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 15:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhFHQBW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Jun 2021 12:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbhFHQBV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Jun 2021 12:01:21 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259D7C06178B
        for <selinux@vger.kernel.org>; Tue,  8 Jun 2021 08:59:28 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id cb9so25158965edb.1
        for <selinux@vger.kernel.org>; Tue, 08 Jun 2021 08:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=C3nXCcvnkDXMCR3wdcYuoqMvBk+nOj0oP10tIddhEXQ=;
        b=GBB79vKIQHta4WRS+yNRLPxhrBRgX3YtUZPMwKit9c4+otim3kHzJEBdoFKDuVb6HH
         wE91652rRfe4qytx4HK4x9vkYcagrrJQ88PtQ4f1epuUbxxgWkzFghuCxYr+NXsR92TP
         HkmxfohJjz+BWnduMTOZzalDpOTdKbbnlKkj5qq6tsjBYqAfPd3QbZpSaQyqlIxQSHEi
         ogBkbZdKmOxDzuk6k2noHzB95fRaLXSwFIcsv9emo6xe6AJDnDTwIwstoBrmqkKGR/D5
         qHJTXPe+W0vWZplGIVdLNai59VGc5pzYERadnfbW+tGZ0uSe/6fL4pfjXZSvv36Ovk6G
         wEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C3nXCcvnkDXMCR3wdcYuoqMvBk+nOj0oP10tIddhEXQ=;
        b=K7C9+LpxILS7jmJbcSeJnFFWc+ZeLNrcuNYIgvFnt0uYiEORSPIzIE1OsKtEW6KO/S
         wnutyW735xmIm/i8r1iLYL/0CfoQU6feo4XsQTeu350s2NVLml+fl2DdQE6oiRIUMfNO
         g/RKBn4lp9Y+BV5cQzluYSkCC9K4LXoX0lg3gQ++Ve2ewz1wPnfehTiphE48JTVBbFGo
         z3/26MhVpZZg5YegyP23ipegIdXX8adHP0n/M4I6mscuRebBi6uHZH6DkWp8Xli7HhD7
         l8qDY5yYHKelHPqfe0KauShQE5rlqcdC4bEKTPLEJsBYCFClC7sqiRAMzS4eeBQnOM7v
         Gxeg==
X-Gm-Message-State: AOAM532xq12L+ExHY8RlnAWGy63n8SBS9e3bYagOipAYzlaRGOIDtVYM
        Zj+2XDjgaS2Yx9VlplEHtxbVEuSd3DQ=
X-Google-Smtp-Source: ABdhPJxRoFGntd+2I1qMCSEbx2fEBfhD5Oehjo64Ju5zzqgj33uBgNou6xvKcXv9WkEea0IO7URDsQ==
X-Received: by 2002:aa7:d9d8:: with SMTP id v24mr25933255eds.15.1623167966620;
        Tue, 08 Jun 2021 08:59:26 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-183-231.95.112.pool.telefonica.de. [95.112.183.231])
        by smtp.gmail.com with ESMTPSA id n13sm51134ejk.97.2021.06.08.08.59.26
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 08:59:26 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 13/23] libsepol: assure string NUL-termination
Date:   Tue,  8 Jun 2021 17:59:02 +0200
Message-Id: <20210608155912.32047-14-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608155912.32047-1-cgzones@googlemail.com>
References: <20210608155912.32047-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

ibendport_record.c: In function ‘sepol_ibendport_get_ibdev_name’:
ibendport_record.c:169:2: error: ‘strncpy’ specified bound 64 equals destination size [-Werror=stringop-truncation]
  169 |  strncpy(tmp_ibdev_name, ibendport->ibdev_name, IB_DEVICE_NAME_MAX);
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ibendport_record.c: In function ‘sepol_ibendport_set_ibdev_name’:
ibendport_record.c:189:2: error: ‘strncpy’ specified bound 64 equals destination size [-Werror=stringop-truncation]
  189 |  strncpy(tmp, ibdev_name, IB_DEVICE_NAME_MAX);
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

strncpy(3) does not NUL-terminate the destination if the source is of
the same length or longer then the specified size.
Reduce the size to copy by 1.

Found by Clang

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/ibendport_record.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/ibendport_record.c b/libsepol/src/ibendport_record.c
index adf67161..2eb8ca18 100644
--- a/libsepol/src/ibendport_record.c
+++ b/libsepol/src/ibendport_record.c
@@ -166,7 +166,7 @@ int sepol_ibendport_get_ibdev_name(sepol_handle_t *handle,
 	if (sepol_ibendport_alloc_ibdev_name(handle, &tmp_ibdev_name) < 0)
 		goto err;
 
-	strncpy(tmp_ibdev_name, ibendport->ibdev_name, IB_DEVICE_NAME_MAX);
+	strncpy(tmp_ibdev_name, ibendport->ibdev_name, IB_DEVICE_NAME_MAX - 1);
 	*ibdev_name = tmp_ibdev_name;
 	return STATUS_SUCCESS;
 
@@ -186,7 +186,7 @@ int sepol_ibendport_set_ibdev_name(sepol_handle_t *handle,
 	if (sepol_ibendport_alloc_ibdev_name(handle, &tmp) < 0)
 		goto err;
 
-	strncpy(tmp, ibdev_name, IB_DEVICE_NAME_MAX);
+	strncpy(tmp, ibdev_name, IB_DEVICE_NAME_MAX - 1);
 	free(ibendport->ibdev_name);
 	ibendport->ibdev_name = tmp;
 	return STATUS_SUCCESS;
-- 
2.32.0

