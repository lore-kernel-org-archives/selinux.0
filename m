Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2B5C433B4
	for <selinux@archiver.kernel.org>; Wed, 14 Apr 2021 14:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68039613B1
	for <selinux@archiver.kernel.org>; Wed, 14 Apr 2021 14:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbhDNOL1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Apr 2021 10:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbhDNOL1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Apr 2021 10:11:27 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7241C061574
        for <selinux@vger.kernel.org>; Wed, 14 Apr 2021 07:11:05 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id z11-20020aa785cb0000b0290241496f2b5aso1083884pfn.8
        for <selinux@vger.kernel.org>; Wed, 14 Apr 2021 07:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eSt/QA91exeOcWyslodwpwOCQ2rvmXir5MlApc+Ky8k=;
        b=K4c0VrHIlUcIGEfFstFXu2t2/W1yXlcN/E3dEA+bV/7iafVGwmZohcwuqUGCG8ZQFj
         8JZkM7J2NRvdLMxSu6WMBZgkPjcrqvORShQ5mR6AYNR88gd/wtxRmf0Nlvbz039MqXnT
         ShfGdYUzsk4PL68h690jI2K9k6F2kSTrLF7rNN1Yyqo5rA/MugVMPpW/0eXIMyWhkmwl
         y08vRyXKd/bud+6u96lDvdVTR1vmc4MldNoreNnEau7uvGuh8k2jvvRTfKb11Glqtw33
         5psySUg76llJ2pNrmwTiQ0gDzM5U9vY7G+SZ3ymSHz0oJanka2lOZUX116A+X4c+u4Ix
         beRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eSt/QA91exeOcWyslodwpwOCQ2rvmXir5MlApc+Ky8k=;
        b=JOiP2C8Y13VO8sVfKChlJVh0APJ8hjOWE0pTaiN/hKUy/2O4EQheBcogzh1MxyD1fC
         Ky2NQjlaK00tb5nr5b0GEj4XUQLw+oMBuYRHKD/cClePv0HuAjpaUTkXRmedNC4o9Ttz
         CUUU9zyTG2MSsd5E2YY/49kbIzWB7NOpQ/y91HcK6qhtmg/BZWGp/pYAt238ipOjmXYP
         4QnyUVSOYE3i1Vxa0x6y59bklHR0bogjBwl8s3PLHIELnUJjlTqb2PmcpbFFwfNpxP8w
         JOJFy/EDTBDMIoseQ36CN+B+M6yWVeqnDm+vLitYTqVIcC6zNdzD2+p06vRiRhEeL5Ak
         ZU9g==
X-Gm-Message-State: AOAM5339LnGFh2sn+eP00xZ53hCjNt+DER77hTEXRLPsU5lWEZvszxTj
        9u8KFWeDOt332wcFXQ1BvOFNqVLtwi4ePk1MkBHgzCC1NPNKHADJH/Tb5m5al0jFHevD2YmWgVy
        Ey7vhqxam+2PObQF8zro5dwxSCH2/tGdVV97ZMJA1Qv0b76oSu3+iOKmEpvWBspudvBdQ
X-Google-Smtp-Source: ABdhPJyvlad8x+TXFHTHSoMMJckLtCd7Pc++u7c6l7Kxs3dUv75PjHx4jkeoZpCMYM+cVTjQ1Q+pirVWgv+5dg==
X-Received: from yochiang-p920.tpe.corp.google.com ([2401:fa00:1:10:182f:78fa:a26e:60c])
 (user=yochiang job=sendgmr) by 2002:a17:90a:b105:: with SMTP id
 z5mr3753867pjq.187.1618409465290; Wed, 14 Apr 2021 07:11:05 -0700 (PDT)
Date:   Wed, 14 Apr 2021 22:10:27 +0800
Message-Id: <20210414141027.3494107-1-yochiang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH] secilc.c: Don't fail if input file is empty
From:   Yi-Yo Chiang <yochiang@google.com>
To:     selinux@vger.kernel.org
Cc:     Yi-Yo Chiang <yochiang@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

fread(3) returns zero if |size| is zero. This confuses secilc, and
causes it to fail with a "Failure reading file" error, even though there
is no error.

Add a shortcut that closes and skips an input file if file size is zero.

Signed-off-by: Yi-Yo Chiang <yochiang@google.com>
---
 secilc/secilc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/secilc/secilc.c b/secilc/secilc.c
index 186c5a73..9c78e425 100644
--- a/secilc/secilc.c
+++ b/secilc/secilc.c
@@ -268,6 +268,12 @@ int main(int argc, char *argv[])
 		}
 		file_size = filedata.st_size;
 
+		if (!file_size) {
+			fclose(file);
+			file = NULL;
+			continue;
+		}
+
 		buffer = malloc(file_size);
 		rc = fread(buffer, file_size, 1, file);
 		if (rc != 1) {
-- 
2.31.1.295.g9ea45b61b8-goog

