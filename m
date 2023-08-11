Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC9EC001B0
	for <selinux@archiver.kernel.org>; Fri, 11 Aug 2023 16:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbjHKQ2A (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Aug 2023 12:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbjHKQ16 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Aug 2023 12:27:58 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77052D79
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:57 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-991c786369cso302672566b.1
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691771276; x=1692376076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uFHeKtuzr80FElLaFbiAjddhDdkcDaWlinC+MHI3t3U=;
        b=m68rvBQbsZLYJqHVuR372qpac/NQ2wqiz52zeVuH6owm+RtcBhXEN+cY53pRJlU+rp
         EWon5ObU/tKh1mTGxw+phqrjpCmgujg+x1hpqL7JYfB40d70VjR0ca/FZ8mkZc7/HZR3
         n0UDg4zqu7g9kGmezoZPED2TQr9ABk6yd+Mhe6AL+daxoAvdGvBGWlC4Qp1OU4JPAXYl
         uaLAoEEJq4MszgpaYhrTqtde39yhIl3iVAMhPfUP3esCwtCOe64IuY7llLuNMgzkGhwd
         Gxh5TzXcf+4VpIqQxYKiYHD1PWsBhSbE7D8Qjc5SqMzO8YmY5D4LNqNEplMgiUSUGR1k
         ehww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691771276; x=1692376076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFHeKtuzr80FElLaFbiAjddhDdkcDaWlinC+MHI3t3U=;
        b=C8F+wJ4alhWQz1uangbsibR5WOFNKzWJUnpTN8YodVJpRmZTT+D/u4FDrSTnPY2p0z
         bzkFQ/DZRgHAVT/8Sm0yCO2oBP8i8K+eTEYSg2ZDGuD1Q1hTCbm+jUQk+61twcB+2RNZ
         gbqvBue+PeefwCRw2EPvXq2qHIznvqI+dNqQKtJvrSmI3blsbfFWFTPZtBJguGPvFNnt
         PejxmlTRDvCLUrPUbDEpnjeAyoG4SFGQwwIk8Kvtwsl1ZdM2xFzs33frOhC+1qOtE2FS
         HxYJ9IF7jnjiX+gzstG7TVMHOBdd2Qt3rUZTv85M4oO0EGzhYQOSUHZsvKNSPfMhKyqV
         0FUg==
X-Gm-Message-State: AOJu0YwNFhTnoc+o3XL5cKiLNGFrWhBfPIBCEvRxXTMnBL1NIOTJMYSu
        5aFtmrdEuuUQlGyksGUwBM82nh4VX8ylnw==
X-Google-Smtp-Source: AGHT+IHvwsWWJYsca4lEp9YqGgsk4Hf2LZivjPSrYEYHqPgXZKIXxw5+Yj0wNKiWRM6sIJEYAXKR9A==
X-Received: by 2002:a17:907:2beb:b0:99b:c0f0:77fe with SMTP id gv43-20020a1709072beb00b0099bc0f077femr2084086ejc.69.1691771276121;
        Fri, 11 Aug 2023 09:27:56 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-174-226.77.0.pool.telefonica.de. [77.0.174.226])
        by smtp.gmail.com with ESMTPSA id p9-20020a170906b20900b00992afee724bsm2408807ejz.76.2023.08.11.09.27.55
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 09:27:55 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 15/24] libselinux/utils: use correct type for backend argument
Date:   Fri, 11 Aug 2023 18:27:22 +0200
Message-Id: <20230811162731.50697-16-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230811162731.50697-1-cgzones@googlemail.com>
References: <20230811162731.50697-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

selabel_open(3) expects the backend to be of type unsigned int.

Also initialize with a macro flag instead raw 0.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/selabel_digest.c | 3 ++-
 libselinux/utils/selabel_lookup.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/libselinux/utils/selabel_digest.c b/libselinux/utils/selabel_digest.c
index 6a8313a2..bf22b472 100644
--- a/libselinux/utils/selabel_digest.c
+++ b/libselinux/utils/selabel_digest.c
@@ -59,7 +59,8 @@ static int run_check_digest(char *cmd, char *selabel_digest)
 
 int main(int argc, char **argv)
 {
-	int backend = 0, rc, opt, validate = 0;
+	unsigned int backend = SELABEL_CTX_FILE;
+	int rc, opt, validate = 0;
 	char *baseonly = NULL, *file = NULL, *digest = (char *)1;
 	char **specfiles = NULL;
 	unsigned char *sha1_digest = NULL;
diff --git a/libselinux/utils/selabel_lookup.c b/libselinux/utils/selabel_lookup.c
index 112ffda1..5dc32548 100644
--- a/libselinux/utils/selabel_lookup.c
+++ b/libselinux/utils/selabel_lookup.c
@@ -32,7 +32,8 @@ static __attribute__ ((__noreturn__)) void usage(const char *progname)
 
 int main(int argc, char **argv)
 {
-	int raw = 0, type = 0, backend = 0, rc, opt;
+	int raw = 0, type = 0, rc, opt;
+	unsigned int backend = SELABEL_CTX_FILE;
 	char *validate = NULL, *key = NULL, *context = NULL, *file = NULL;
 
 	struct selabel_handle *hnd;
-- 
2.40.1

