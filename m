Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A865EC38A02
	for <selinux@archiver.kernel.org>; Fri, 28 Oct 2022 20:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiJ1UjH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Oct 2022 16:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJ1UjG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Oct 2022 16:39:06 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9767E236423
        for <selinux@vger.kernel.org>; Fri, 28 Oct 2022 13:39:05 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id f22so4230665qto.3
        for <selinux@vger.kernel.org>; Fri, 28 Oct 2022 13:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqoV5l825hG0eWPYvxn+bwKlJaBDNcwDIvXDP9USAMs=;
        b=nFLOgBEiTS1VolBEmLR6ShTAXZ53ZsBSc3R2RxHDNoNNzgp5X7Ba0l1gbaaRqFSSXq
         g9I0lSdI1nmqI9UINbWZFGnHnFbbXnHNRVCnGm2XW5iOG/SD9s4nZEWG68/0oSIURzfh
         lMhZqMJxFAMIPrgbGOyDW0vklp3mz8YIWZ9/rAGyZGzx0u/HEzz0Rwqd9jX8vDr7uKOJ
         QsM15TTVNfWGef/knKh59Mo6XkdX5cC/hgBOPnVf+Xuyp2EzTtBMIQpIuSEzyGqr7XYl
         0BghsW7479C1B3Suf58XN/dmukqscmxTSjvf0KJve/M2oi0mfCI7h4/bMq4X2V2xxqeq
         NX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EqoV5l825hG0eWPYvxn+bwKlJaBDNcwDIvXDP9USAMs=;
        b=E18ywjnR3wYaRnr0GajDMm7Tv6tgNdnURjwSYYakOjk6kNrbAQb6aEXgZN0khmRIjO
         YpjU57pcOUrRYnFIhsYULAzfU7yRa2MoDjgIi3Mv7NiQtrhYJgODkLZw4xVE6pmCYCJ2
         B8oQWdiGcrK6y0jfTV57hRphjie9u+ZqVZpVjy1aZu4rDFUvhAkRYsakIS2MzaoCLm/F
         uFJ7xw5Aj99MY3sp9l+yLK7J91srptvXRCMg71tyvCHmPYATHy4/G03tt8oAJNnY68mb
         mq58+UPb4lcp5Wexx4zipST4Mm2LtM123SuA9eRxO4O1UTzzFMCZU3IimOpwnxiPsvoe
         gOig==
X-Gm-Message-State: ACrzQf1JcGYwKmVyxkeW6ENmHUajLSA6GXWYsn76mwpG4adOlzKUnq9O
        A+gDHm7Q31QyAHwwMYvd6dwPetPOCwc=
X-Google-Smtp-Source: AMsMyM7Ae6YqCC8z9L+MSXUXEixgdD13U002RtX55JoBIftwNrtEGHgW/Bcfo+o/X+owuqTBNgHZcA==
X-Received: by 2002:ac8:5b05:0:b0:399:9b82:77b4 with SMTP id m5-20020ac85b05000000b003999b8277b4mr1143216qtw.681.1666989544457;
        Fri, 28 Oct 2022 13:39:04 -0700 (PDT)
Received: from electric.. (c-73-200-155-132.hsd1.md.comcast.net. [73.200.155.132])
        by smtp.gmail.com with ESMTPSA id v17-20020a05620a0f1100b006ecfb2c86d3sm3606642qkl.130.2022.10.28.13.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 13:39:03 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 5/5] README.md: Remove mention of python3-distutils dependency
Date:   Fri, 28 Oct 2022 16:38:52 -0400
Message-Id: <20221028203852.526472-6-jwcart2@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028203852.526472-1-jwcart2@gmail.com>
References: <20221028203852.526472-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

With the removal of any dependence on the python disutils module,
Debian no longer depends on the python3-disutils package.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 README.md | 1 -
 1 file changed, 1 deletion(-)

diff --git a/README.md b/README.md
index 74b0a0c3..f91cb7d9 100644
--- a/README.md
+++ b/README.md
@@ -81,7 +81,6 @@ apt-get install --no-install-recommends --no-install-suggests \
     libpcre2-dev \
     pkgconf \
     python3 \
-    python3-distutils \
     systemd \
     xmlto
 
-- 
2.37.3

