Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF889C4167B
	for <selinux@archiver.kernel.org>; Thu,  9 Nov 2023 13:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbjKINxZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Nov 2023 08:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjKINxY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Nov 2023 08:53:24 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C91F272C
        for <selinux@vger.kernel.org>; Thu,  9 Nov 2023 05:53:22 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9a6190af24aso153072966b.0
        for <selinux@vger.kernel.org>; Thu, 09 Nov 2023 05:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1699538001; x=1700142801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0KItzZLwFEZg974XNkkFFeNNdCYF1cbO13DcgIokm1s=;
        b=THLXDRE3bmQOcMu4tp6o+Lfk8W/eKnHuurC63c6Q1BleVqkAwZ7achZdJOBumWwpun
         biYXV9TpwsGy3PyYR//vxQAPMhLcKJtF/axvOr78AAJI+V0XcYJ26AvEv8ojuZFoUdTl
         ns8487J30zQ+eaG4ox6C+MlWvYyR0H4yoqXyeigvGDHc74C9Arj6e+6cx/Tg62YMxjmL
         UI73/KSn/SV5QWW1I+ezzz9phuyAyb3myEWER7suuNVccQ/jZmbIKeeUiWroVMFJhrJu
         sKQG9G86cnmFo4zcm6zVlC+NK5vrNonUdDdzWbi1D65rN6xMf6ywLYi/ovHCRN4FaLip
         xKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699538001; x=1700142801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KItzZLwFEZg974XNkkFFeNNdCYF1cbO13DcgIokm1s=;
        b=H1UEeYUxrTSzrKkO4zEPNSrhhGYZ/E3gFRBMbQqvbUCr4VOuhABiAWlKABCkC47D5K
         HsdUrVDh1N4z6PiT0P4QV4BO8eKH7RSfc1A3si1VjU5+2GcRPltfCAkE1wKSYAON0NvZ
         a49/E/Y2KqdklQEeh4ljSCS6iIK6oLEezpU0uZqB48PicumgCdD90IvinEexxF/7wqFy
         5HQkzJw4SQ63iXe/cpSjcOP/y8LbxE4PJMnFjRa3JhIyONw55DyazB/8jpcqRfcvCQwj
         RAMvfI9KEsJB9QI4Gbf+1eB4jH9EMqA3Q6MyBCJUTCYAN/Ck9TONu6HT+1SVNpjXjN94
         BrFA==
X-Gm-Message-State: AOJu0YyLNwNwx6qwX0NBVujtO91plqcj8MOwUwrukJ95Nrhtamxh2Csj
        lIf4woFpjRxwdqia1ih1iihzxaNlSxI=
X-Google-Smtp-Source: AGHT+IFAxEquwgv5bDIj+AKd7xukG4et7jPsmrmCigokKQMsSxpZp2++3DGhogBkT4ybdDP7dP5i0w==
X-Received: by 2002:a17:906:fd85:b0:9c7:5a14:ecf2 with SMTP id xa5-20020a170906fd8500b009c75a14ecf2mr4339189ejb.56.1699538000852;
        Thu, 09 Nov 2023 05:53:20 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-000-043-071.77.0.pool.telefonica.de. [77.0.43.71])
        by smtp.gmail.com with ESMTPSA id q8-20020a1709060e4800b009de61c89f6fsm2549900eji.1.2023.11.09.05.53.20
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 05:53:20 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/5] libselinux: fix memory leak in customizable_init()
Date:   Thu,  9 Nov 2023 14:53:13 +0100
Message-ID: <20231109135315.44095-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231109135315.44095-1-cgzones@googlemail.com>
References: <20231109135315.44095-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Reported by Clang Analyzer:

    is_customizable_type.c:36:3: warning: Potential leak of memory pointed to by 'buf' [unix.Malloc]
       36 |                 fclose(fp);
          |                 ^~~~~~

Fixes: 9911f2ac6f77 ("libselinux: check for stream rewind failures")
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/is_customizable_type.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libselinux/src/is_customizable_type.c b/libselinux/src/is_customizable_type.c
index 9be50174..da301c60 100644
--- a/libselinux/src/is_customizable_type.c
+++ b/libselinux/src/is_customizable_type.c
@@ -33,6 +33,7 @@ static void customizable_init(void)
 	}
 
 	if (fseek(fp, 0L, SEEK_SET) == -1) {
+		free(buf);
 		fclose(fp);
 		return;
 	}
-- 
2.42.0

