Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E80C433F5
	for <selinux@archiver.kernel.org>; Thu,  9 Dec 2021 16:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237346AbhLIQzr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbhLIQzr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Dec 2021 11:55:47 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AC4C061746
        for <selinux@vger.kernel.org>; Thu,  9 Dec 2021 08:52:13 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id e3so21820803edu.4
        for <selinux@vger.kernel.org>; Thu, 09 Dec 2021 08:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lzy1nMecbbDHZ5D5hHpVg7+BKTjN8QKKUyzfNWc8G4M=;
        b=nb4nh+7OEzvdXOav8DBgg97/pU6iQ1fumZFm7k88Hoa1Y9YfoQzjKQ9hlPADZhJ0bL
         yY3YJ28q7YdYE+Fou4RGn5Nob2ijo3bwaUpHmLj/qCIMFkYXHouC8s4HN2wFJ6pJBtbU
         miCNGQFncIqmf2NVKjHJNufDQR/qBQOpbBxmqcZG5Q/LADV3kaaFOcpRlpX6p81Z2a7K
         uhicUJxKrbFEWpItchDtRL8cXZovRXJcD6MpN5EpEbov7FZgAsoXyJxYeu7/J3+eSB6p
         2qHKedHKez5oaBLsd0CD2IX6YjnD7ZcLvEMvM+M4hOclSrHmF185SOCcOKcK84OURWV2
         yxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lzy1nMecbbDHZ5D5hHpVg7+BKTjN8QKKUyzfNWc8G4M=;
        b=mJe/oivPSYAqMqQ4aq3Y/Gf9xqrSRk0gyW67O5RlwImGnkGuRXHU3d/wzjYpGKRo+B
         o/fkgkklDxKsiaYsXfRpO4mSi7d8+lUN+HmuRWb34orv5CbAv49o9p31K77NZt2B5Ljh
         FlLx0irkwnXWZEOLylan6OxcVVZGjrLzePSTkCvFiIuTWqsYtJNLqPTpQH5gC76ONoMs
         2N2OjHkM870TCvK4tRTYcE2GmcpftrMPBqZeMqQLvMlAVuiVjtyl7bbklNazPOEVGNdx
         lQrNbuYm4sNtfm6mflbGg+6ReGPRwX0PNmvtFmhbTYrJFUsSJ4MwgwnJTGu5kMO2zWvw
         Ph1w==
X-Gm-Message-State: AOAM531PCRZy+58WC4uPXzdqCpCqDA3CiCRG1zmZ8xORJNImkR2TPi2l
        6QhCvwhL2pzLLslzE4snZArqJnozmcw=
X-Google-Smtp-Source: ABdhPJxH2KUZghCbhpSwcSf2iv8MX7+l/6ONjLQrs9So+8pkZSTPmG8NT8jdD8YhcwIwrcI/93mBsQ==
X-Received: by 2002:aa7:cc09:: with SMTP id q9mr31048831edt.102.1639068589387;
        Thu, 09 Dec 2021 08:49:49 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-140-169.95.116.pool.telefonica.de. [95.116.140.169])
        by smtp.gmail.com with ESMTPSA id hu7sm172135ejc.62.2021.12.09.08.49.48
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 08:49:49 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 21/36] libsepol: do not create a string list with initial size zero
Date:   Thu,  9 Dec 2021 17:49:13 +0100
Message-Id: <20211209164928.87459-22-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211209164928.87459-1-cgzones@googlemail.com>
References: <20211105154542.38434-1-cgzones@googlemail.com>
 <20211209164928.87459-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Currently is it implementation defined, due to the size being passed to
calloc(3), whether the operations fails nor not.
Also strs_add() does not handle a size of zero, cause it just multiplies
the size by two.

Use a default size of 1 if 0 is passed and swap the calloc arguments for
consistency.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/kernel_to_common.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_common.c
index 152f2816..9f5400c9 100644
--- a/libsepol/src/kernel_to_common.c
+++ b/libsepol/src/kernel_to_common.c
@@ -107,6 +107,10 @@ int strs_init(struct strs **strs, size_t size)
 {
 	struct strs *new;
 
+	if (size == 0) {
+		size = 1;
+	}
+
 	*strs = NULL;
 
 	new = malloc(sizeof(struct strs));
@@ -115,7 +119,7 @@ int strs_init(struct strs **strs, size_t size)
 		return -1;
 	}
 
-	new->list = calloc(sizeof(char *), size);
+	new->list = calloc(size, sizeof(char *));
 	if (!new->list) {
 		sepol_log_err("Out of memory");
 		free(new);
-- 
2.34.1

