Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8593C001B0
	for <selinux@archiver.kernel.org>; Mon, 14 Aug 2023 13:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjHNNVL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Aug 2023 09:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjHNNVJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Aug 2023 09:21:09 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C5B10DE
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:55 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so66170591fa.3
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692019254; x=1692624054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9kDLgGg0yw55jOe6NObH+nTGKk893dES4rl5W0ubmgY=;
        b=jNJ5A0oBYJDKFM99Z8dWJq0Z7cThznBNZhGSrU7JV0XsVcJ0Ztj2PXkFFZptVB1qEF
         PijECfPqsqALmLqlJtNbpLAAyTiHLX/X5Q2IVD+sdWLEfpJRRKoGOmVy6U27oE3LIhES
         e8YaLZOdxD3YDV7vhskaLhfYnc19eTYIuTtpj2/57MgNZ64f+1ulQ+fP/4Pw/7m1c0yJ
         fVuScCHzTnyNC5pwpWMZVZUbjjvUqWVZA9jQxmqLHaiAtW4EeunbLOR+Em03ZujxcMdz
         NO/hJgvqPVKvdbp67UwM+ooR6jzKF4i16nMyKmIlU6nyn4iKq12NQB6PD+7aA2VOraTy
         /XTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692019254; x=1692624054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kDLgGg0yw55jOe6NObH+nTGKk893dES4rl5W0ubmgY=;
        b=OPnbfGQ1Goxhe+7rVOZlSkUNUfrtGkDGMWodglPEam18lefNzK7J4/tCnprw50Z6ES
         7apHcpjdDxjBlpduSDLn/xkVD0M6S91uRcme6Edx9OMjv0X5ianPIzMVAKDKF0cZ+ZGX
         785+tk2qISCL7muKLWDo6bG5z9IGizDxRDatSn8q7BG+6pG7tRmlzNBILNpzAtb9ibZ5
         +OaL5zRovInnKHtlYiPq+o+GvZSwTRFyPmFjKj2x89MCSqHTAi7su5cvnNEqh6Qkp2Zm
         hKKF2IcdCuxJGzd5pjcReN33Zazj8oUnHX3LYhTLOXtvBMElpcPJUlwPVu5XHSM/86zy
         ef7w==
X-Gm-Message-State: AOJu0YzmaQVc5nGpXGvjbBg7/lBsRoW5tALhbCdLRfuXPJtN8uLbjUHi
        8+hkaX4cuPwK1iqPBrXR/rnUfveSQfNVuSq0HHI=
X-Google-Smtp-Source: AGHT+IElE2f9UdJBHDjChQi8OQPrLR4QYIbx+EGoK7ZjBnWVh61sjPhLTngamaNtLPuYRTKAhL5kfA==
X-Received: by 2002:a2e:9c1a:0:b0:2ba:38c4:1624 with SMTP id s26-20020a2e9c1a000000b002ba38c41624mr6548556lji.15.1692019254070;
        Mon, 14 Aug 2023 06:20:54 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-167-009.95.112.pool.telefonica.de. [95.112.167.9])
        by smtp.gmail.com with ESMTPSA id ck9-20020a170906c44900b00993664a9987sm5683541ejb.103.2023.08.14.06.20.53
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:20:53 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 24/27] libselinux: set errno on label lookup failure
Date:   Mon, 14 Aug 2023 15:20:22 +0200
Message-Id: <20230814132025.45364-25-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814132025.45364-1-cgzones@googlemail.com>
References: <20230814132025.45364-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

selabel_lookup(3) is expected to set errno on lookup failure, i.e. when
it returns NULL.  Set errno if a regular expression failed to compile in
compile_regex().

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: add patch
---
 libselinux/src/label_file.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 3827b5c0..5365086b 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -407,6 +407,7 @@ static inline int compile_regex(struct spec *spec, const char **errbuf)
 			*errbuf = &regex_error_format_buffer[0];
 		}
 		__pthread_mutex_unlock(&spec->regex_lock);
+		errno = EINVAL;
 		return -1;
 	}
 
-- 
2.40.1

