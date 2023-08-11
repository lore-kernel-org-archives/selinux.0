Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6B1C001B0
	for <selinux@archiver.kernel.org>; Fri, 11 Aug 2023 16:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjHKQ14 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Aug 2023 12:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjHKQ1z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Aug 2023 12:27:55 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C831E2D6D
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:54 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99c1c66876aso292266566b.2
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691771273; x=1692376073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gz2DG6hVVCAcG3/CCzRTc/rhYhJL45RjMUpsbqCWED0=;
        b=QJHuQ6Q8Lxltnu2/+bjW76oHAImEhITVBD05ot7zVI7DT+O98T4ibOG2leIfxkE4hr
         PsIzi8c7O+8MLKtqF5gp4rh8iCjFqVzG9CA6YPxK2ObeFmm+K3dMvEc60CAtsLG6DXyi
         VdYx+J9OhzjhupTC7otbnpoJjOrdqHwF+U2OuFeLvbRGenkn9q4tNPsQlnr2Z3V1XG5s
         tM/EggYE0l9AjJhVa86XJz7Yxm9EZ0Mumg0t7QkD1T08mlJNITryDLiUzFtY5s8PqkiP
         +BDW7+f55bM5ogl3cXBrGdTO6E7m9XrVhvcZLPgDzUpC6yI2OM8TYAg6V0JrrTopKzuj
         aQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691771273; x=1692376073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gz2DG6hVVCAcG3/CCzRTc/rhYhJL45RjMUpsbqCWED0=;
        b=WiD5XUunoKZmUdQET7Yf2DukQFy003oQljMQnZjhVmpgqGNxSs2+2NkwOLJVwJ/W5O
         qX+62AptvyVb3Cfhh6XuSSp6wvCgmQdv/cMVW9dRWFYpwpuzP1A5pHStHRhAtbqkVflv
         F4zLSf2Gq2XkAVWmhUyaL3cppcRmQQm5q6AlR9m/4zGV8byAHSLH55OLnRkE0nXAYTDZ
         J5N7oBEgoVlzwASXrFjnh6ZWrKap6keSYTZ1tm9dxy/n1k71qiLdRdWMETasAVoRqaTq
         /uTcuppkM0svzTYHw/a2lNM5ja1B4s38CFuk5/t1kVRjr9i2VV4sng8aFDDZUraAv5bm
         bolQ==
X-Gm-Message-State: AOJu0Yy/Vk8L6RQWaqyauaRybT58qL4OUjerD9fcwbzNVeVP+TvgZut2
        mCCebo6TIRX3prnQOKcugYuPBTu76MN/aA==
X-Google-Smtp-Source: AGHT+IG3P2CE+Xmfe1hfPmERdx8SY7VhXqtJHsBEC4EL/8lkmeqh0gSFFpRvRbEXB6bKv/hdsqEhlg==
X-Received: by 2002:a17:906:1db:b0:993:f90b:e549 with SMTP id 27-20020a17090601db00b00993f90be549mr2119392ejj.37.1691771273201;
        Fri, 11 Aug 2023 09:27:53 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-174-226.77.0.pool.telefonica.de. [77.0.174.226])
        by smtp.gmail.com with ESMTPSA id p9-20020a170906b20900b00992afee724bsm2408807ejz.76.2023.08.11.09.27.52
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 09:27:52 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 09/24] libselinux: simplify zeroing allocation
Date:   Fri, 11 Aug 2023 18:27:16 +0200
Message-Id: <20230811162731.50697-10-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230811162731.50697-1-cgzones@googlemail.com>
References: <20230811162731.50697-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Merge malloc(3) plus memset(3) call into calloc(3).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label_file.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 5ac23e1f..b9be1c9d 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -716,10 +716,9 @@ static int selabel_subs_init(const char *path, struct selabel_digest *digest,
 		if (! *dst)
 			continue;
 
-		sub = malloc(sizeof(*sub));
+		sub = calloc(1, sizeof(*sub));
 		if (! sub)
 			goto err;
-		memset(sub, 0, sizeof(*sub));
 
 		sub->src = strdup(src);
 		if (! sub->src)
@@ -1357,10 +1356,9 @@ int selabel_file_init(struct selabel_handle *rec,
 {
 	struct saved_data *data;
 
-	data = (struct saved_data *)malloc(sizeof(*data));
+	data = (struct saved_data *)calloc(1, sizeof(*data));
 	if (!data)
 		return -1;
-	memset(data, 0, sizeof(*data));
 
 	rec->data = data;
 	rec->func_close = &closef;
-- 
2.40.1

