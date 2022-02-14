Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF22C433F5
	for <selinux@archiver.kernel.org>; Mon, 14 Feb 2022 17:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243725AbiBNRJJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Feb 2022 12:09:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239676AbiBNRJI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Feb 2022 12:09:08 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDC165171
        for <selinux@vger.kernel.org>; Mon, 14 Feb 2022 09:09:00 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id h8so12324432ejy.4
        for <selinux@vger.kernel.org>; Mon, 14 Feb 2022 09:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7Z+Qmu6+dK4uXxKZlE30IfqpCTz5kO8Q0GmUnoVKUrg=;
        b=GPXF7kDuYJcS6Yu95kHA+VdoJtQ1hkpcrg/0oSih7W3bCwfQ4OfszRdKNs3xdo32qo
         xx/5sRiBlOtg/nlr3PlF1NaANDdl15hr9zugdIGNrYCwbEGYrMknqch4DDrJIu0TWteA
         PlUy2wVcgnYTcmKqxONqfQtuu4iGV3XbRshKGdq4XFviiQ8nbXMtTUpE7EMkR1EYAop6
         HfGqD7Vbcbnn1zxO420pWmcg/5ELKXEAkilkphI81LTzrIJsx3AZi4r6SWSNVLFRDIeg
         c4LffiV/d/sfMnwPFDGYJpFOpCQPd+pOSL4m7c5PLiVIoL990CBHpy5vNwWtOyWb89S1
         r0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Z+Qmu6+dK4uXxKZlE30IfqpCTz5kO8Q0GmUnoVKUrg=;
        b=tyMWuH2iPgEsnRxim0cxPxwb245qHpsLx7ins6wBw7+7cH+hTnv4H7meHhY3PyJWop
         CpTHPk7RI1eAr+jdxa7imvinj+xWLwFe9DTcXNoStZcNi2+xyX/d4q1B5YrIgVrInPf1
         25R2/NEm6CkxO3VhgszMV0hvj9ZnGnBjGhUYjyXbrHtRZ9Dbvm/kS2VOeEdytEXQp3bq
         II8oWyCnmZXA/f3E4h4Md1cnn6RSv6Qf3+fu0ebIpX4cIMh7syHRn/58QZKbMlRJfGBY
         OP5Xn0Sq4ap0BaJxT5F6qWJSFn00B+7S6TIcxYlQftIeZWo4Q3kk9lAiiIAq31YaokY8
         NDfA==
X-Gm-Message-State: AOAM5307G0yNFmpkJ5ZcaSjruai9YYEJ/kfzT5KZvHSvvLOtLsSAZMpK
        XO6LxJG24f+ZSlHhF+0/nsdDPpBCat0=
X-Google-Smtp-Source: ABdhPJzTzKpRN8ZvcJPmTK8Aua7nda1nwPfW53uNYL6meHJB9Pj5tBBMTPtuGzi2FxaH1/Of0b3PPg==
X-Received: by 2002:a17:906:1291:: with SMTP id k17mr415047ejb.451.1644858539250;
        Mon, 14 Feb 2022 09:08:59 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-003-192-083.77.3.pool.telefonica.de. [77.3.192.83])
        by smtp.gmail.com with ESMTPSA id 13sm2029430ejh.126.2022.02.14.09.08.58
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 09:08:58 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] python/sepolgen: accept square brackets in FILENAME token
Date:   Mon, 14 Feb 2022 18:08:55 +0100
Message-Id: <20220214170855.10603-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220214165812.9359-1-cgzones@googlemail.com>
References: <20220214165812.9359-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When parsing Reference Policy style files accept square brackets in file
names.  The FILENAME token is used in the TYPE_TRANSITION grammar rule
for the optional name based argument.  This name can contain square
brackets, e.g. for anonymous inodes like "[io_uring]".

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
added missing signed-off
---
 python/sepolgen/src/sepolgen/refparser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolgen/src/sepolgen/refparser.py
index e611637f..1bb90564 100644
--- a/python/sepolgen/src/sepolgen/refparser.py
+++ b/python/sepolgen/src/sepolgen/refparser.py
@@ -261,7 +261,7 @@ def t_IDENTIFIER(t):
     return t
 
 def t_FILENAME(t):
-    r'\"[a-zA-Z0-9_\-\+\.\$\*~ :]+\"'
+    r'\"[a-zA-Z0-9_\-\+\.\$\*~ :\[\]]+\"'
     # Handle any keywords
     t.type = reserved.get(t.value,'FILENAME')
     return t
-- 
2.34.1

