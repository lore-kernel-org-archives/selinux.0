Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E586C4167D
	for <selinux@archiver.kernel.org>; Thu,  9 Nov 2023 13:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbjKINxY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Nov 2023 08:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjKINxY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Nov 2023 08:53:24 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6402D5B
        for <selinux@vger.kernel.org>; Thu,  9 Nov 2023 05:53:22 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9c53e8b7cf4so149013366b.1
        for <selinux@vger.kernel.org>; Thu, 09 Nov 2023 05:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1699538000; x=1700142800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aULkyJIGRGALtv4xtIeKpu861oBjEsk1XeiBonlFgUw=;
        b=H0rkPhjsHs6deVJvgg4m4wL/XQUDTeNUWLuXaXBKRBXQUvX3p7ihnbVWwjzwPipprA
         zBVtaEWuJmAWzOKHvF+3FH6y7ksfgo2PLGrZCCRkckbn/kiYmxqnezMmSybADAFAS17W
         EhtXT9IBRodJ9YiyuOnM/EdetfMGkV4Z1RQbhnn6T1Rd9+QoyvIHREveIl2kFVJ3CAuM
         As/6rRmyfzHeKoPtUKinRSUtdm9blsbonNYXjdwvnXAVxMf0M8N0R8kMa3fIXW5EhEOk
         m69AMeMeXk0SDwznVyyUAmWBOsJ92Q3ZDNvWcOJQBfuA5hWi19cxRo0SofLqYS2qfvgJ
         ANPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699538000; x=1700142800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aULkyJIGRGALtv4xtIeKpu861oBjEsk1XeiBonlFgUw=;
        b=hON+qX0z6AAqh1l3gFvncGPrEJcZQaHu4Wfwp20mJnwd3qtV+cGgORXg2d1BPbhXKi
         uaoG34keuaXZ9bEGTFYsEnXgw5jTFi22UPxVbz7uiF/AVXpDmzfhoc1OyTYMX9DteKma
         TQyrPjJgj3XelIsTpZnu2e88TULaF9hrR8ot2xAtx2j6F2+JUV8YqIBpCCBRCSr/O6Uh
         mLq0I5Eidy/yA8l7VciQ1YVNQbd/YxoHkeSHlBOC4PI7UFYe7pOFvh6NtUvH+qDhPgH9
         pFTogFtgsQIXhN5VUU8X4+T7+9vmSiz3yWjTZERxIIixVo9KDIM0V6sFNC9B1Ytz6un7
         icVQ==
X-Gm-Message-State: AOJu0Yy99TY06EycR4M/N0KSSBk1PCvwN3F8J7vnCk5GAIzbXUXyifJh
        mtNIp0e/TlLDaHVcpVaZrnXvz2UpIhY=
X-Google-Smtp-Source: AGHT+IF3pyOvzC2qHR7r3dwwVgQy/YMEwTgZMKo7+Ic3Xf0AGYjzieoATGeXxlok3It5CT7j2mk8uw==
X-Received: by 2002:a17:906:794a:b0:9c3:b609:7211 with SMTP id l10-20020a170906794a00b009c3b6097211mr4434288ejo.1.1699538000396;
        Thu, 09 Nov 2023 05:53:20 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-000-043-071.77.0.pool.telefonica.de. [77.0.43.71])
        by smtp.gmail.com with ESMTPSA id q8-20020a1709060e4800b009de61c89f6fsm2549900eji.1.2023.11.09.05.53.19
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 05:53:20 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/5] libsepol: set number of target names
Date:   Thu,  9 Nov 2023 14:53:12 +0100
Message-ID: <20231109135315.44095-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231109135315.44095-1-cgzones@googlemail.com>
References: <20231109135315.44095-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Set the number of target names to 0 instead of leaving it uninitialized.
The number is always 0 since CIL does not support non-trivial not-self
neverallow rules yet.

Reported by Clang Analyzer:

    module_to_cil.c:1211:18: warning: The right operand of '<' is a garbage value [core.UndefinedBinaryOperatorResult]
     1211 |                         for (t = 0; t < num_tnames; t++) {
          |                                       ^ ~~~~~~~~~~

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/module_to_cil.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index d2868019..2d77e22a 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -1199,6 +1199,8 @@ static int avrule_list_to_cil(int indent, struct policydb *pdb, struct avrule *a
 				rc = -1;
 				goto exit;
 			}
+
+			num_tnames = 0;
 		} else {
 			ts = &avrule->ttypes;
 			rc = process_typeset(pdb, ts, attr_list, &tnames, &num_tnames);
-- 
2.42.0

