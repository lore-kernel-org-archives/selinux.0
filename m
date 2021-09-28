Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A47C4332F
	for <selinux@archiver.kernel.org>; Tue, 28 Sep 2021 15:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D412611BD
	for <selinux@archiver.kernel.org>; Tue, 28 Sep 2021 15:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241672AbhI1Psx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Sep 2021 11:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241565AbhI1Psx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Sep 2021 11:48:53 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C037DC06161C
        for <selinux@vger.kernel.org>; Tue, 28 Sep 2021 08:47:13 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g8so85116317edt.7
        for <selinux@vger.kernel.org>; Tue, 28 Sep 2021 08:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Abxr88e4AjrbFisjHde26z4wPEeoRwVWpt7DfzPhMAo=;
        b=cVHWTEjKWhWNJ+eMEFfYZdwyU2s1IcL60ZZOUb/0AmPL5M9Wx57ZIv5JMacCSCKcy0
         XlcDXUj2a1i3hbnALXb2wx855gjjZ6P+Ha96byX5ETqU01MGMUO0tzVutV1ojJoUHbs4
         7sacPK7kNy5YKjxpi07s6ngpG8m6j6c4TVTZ63qnI4jqw0KXAReQMBr3QY2iIFCi+J3G
         j5NodKE+xSTv6J+mydsefdx6fF22UfMbYVR2+B7bxW/s+nQ0BogH6dyu9FRq3DStbAu5
         OB939ZetE511LddzTNupJKUiNCUaDs7GpomYhWQYg9iRkPakVbfwXrLltEyYjsPPiQoH
         BRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Abxr88e4AjrbFisjHde26z4wPEeoRwVWpt7DfzPhMAo=;
        b=Ws74sEYaDvG7AwIYc6wpM3ZY1ZYjfeTm4EKLVJ2eqBbs2aCTxlHPKhybX0wt1j+Il+
         1+2DWuR5/Z/4sZGDCJo7S45rHGilBt5CAc3KrD51DeFYB/PeoFqjtH/QP7FRtlZ3RWSN
         KODHZbUWj6+FZnXIg5nAEQxOKcwgdGMedSZK7Zacsg8lMPGwSdTJ5CAcX1fuLCFk7FOr
         XO90DkoAibRrJr6vuLIk4ZMHn/0dLtaEnqRsl5gEhLbq5FxgebzfAqDzmwCbuuLBdq0h
         TAvgnyMnCOfo+tb7VFQYib189lbqnfmXfpZwPn5GBO7JOSl2L4SvwJRdCmqMBTxox/ON
         VLiw==
X-Gm-Message-State: AOAM531dHJ1kLlNnxOxuljuouA88ntLUUDHxTue8Z6TADyF8vLpyXd3h
        udjU9jhuOenytJStE2uOCI/VDxhCXDM=
X-Google-Smtp-Source: ABdhPJyvY9f/SXF6OkNuBwJANBSMG183kkIGFSZwQ6TxjCEr5WQDKNRw8kkP+B+AHw1onqe9TrdJjw==
X-Received: by 2002:a50:e0c9:: with SMTP id j9mr8121820edl.336.1632843985108;
        Tue, 28 Sep 2021 08:46:25 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-152-081.95.112.pool.telefonica.de. [95.112.152.81])
        by smtp.gmail.com with ESMTPSA id l18sm13403834edw.78.2021.09.28.08.46.24
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 08:46:24 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 4/9] libsepol/cil: silence clang void-pointer-to-enum-cast warning
Date:   Tue, 28 Sep 2021 17:46:15 +0200
Message-Id: <20210928154620.11181-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210928154620.11181-1-cgzones@googlemail.com>
References: <20210928154620.11181-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add an intermediate cast to uintptr_t to silence the clang specific
warning about casting a void pointer to an enum.

    ../cil/src/cil_verify.c:1749:28: error: cast to smaller integer type 'enum cil_flavor' from 'void *' [-Werror,-Wvoid-pointer-to-enum-cast]
                                                    enum cil_flavor op = (enum cil_flavor)i->data;
                                                                         ^~~~~~~~~~~~~~~~~~~~~~~~

Similar to 32f8ed3d6b0b.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil_verify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index dc29ea66..d994d717 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -1746,7 +1746,7 @@ static int __cil_verify_classperms(struct cil_list *classperms,
 							goto exit;
 						}
 					} else {
-						enum cil_flavor op = (enum cil_flavor)i->data;
+						enum cil_flavor op = (enum cil_flavor)(uintptr_t)i->data;
 						if (op == CIL_ALL) {
 							struct cil_class *mc = cp->class;
 							struct cil_list *perm_list;
-- 
2.33.0

