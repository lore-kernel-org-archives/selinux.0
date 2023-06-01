Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6193C77B7E
	for <selinux@archiver.kernel.org>; Thu,  1 Jun 2023 18:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjFASGu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Jun 2023 14:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjFASGt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Jun 2023 14:06:49 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7121A2
        for <selinux@vger.kernel.org>; Thu,  1 Jun 2023 11:06:44 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-75b2726f04cso96306585a.3
        for <selinux@vger.kernel.org>; Thu, 01 Jun 2023 11:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1685642804; x=1688234804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=han+Wp1gmrwD3MGPT7YKrI3QucY//yN+Pdm/tDnefv0=;
        b=cdnMzB+VqWUWlgyMHNgox32r1A/yyZfIfXILDs04b16MfsWKEBxtW4wOm5y8W7wVuw
         OQP5prU5tRVhUmH3n/NSnz2SuAAT8LJSBVWC0ejVTReWYcgj6kTz8WuDylr+UgjdBE91
         02XDOynJGcz4gmfo3LNPV9fXpxr+ezA/X751EkBBGwFuH10ARAFZGImE7wJICA+eBtlS
         o9BjGJG/FbCgtKrueoF3LtFFFWXLFFljIdSyVvpEItAhamcZFByVTkCBeAZl6lk/ouLE
         UTFt9EYNCSTpQIqg6pmniHDXgETHacwgg4WFKwFFMRDaSbjBFBb00EeQo8vMmHM+roFa
         jUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685642804; x=1688234804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=han+Wp1gmrwD3MGPT7YKrI3QucY//yN+Pdm/tDnefv0=;
        b=eDgk63HBUOvPVl0neApmHnVsDIB+02o8rq4qWNWq+b0lkdEt2XdFWbD7XY/PT3TPf5
         b6CNYd39wQurhnqHN6P940Zcr19o5xh/k1Xaw757++E81kSE5ASAyHFiqQ3CWOVziuvy
         ruVjZy6T0/OVzwlM/EIRucvbv0ollrC+YmzycLGOA2eWAVe9+zgnfgty5TGVZDPRLeZN
         PxYEWaW9CApMHjfB7pRDKDxf9+Y4sRYkGUXeQ1iHBpQIcV01gZsERNSqMIiJgVTtcg0u
         LmBpVex2vs8gh0BtkfEn6WlU22EVq2hpfqUml+882W/wk+OnOnxD1VLUC9WdLDZS3iEg
         8/BA==
X-Gm-Message-State: AC+VfDwRNjZi0vEG1/5vXqknT0XTkENuWZkd5/leRfu3riO1YtpAwLRJ
        H80LiIcyKLovulRb0Kr2yaL8Vsqj6rfTD1DKig==
X-Google-Smtp-Source: ACHHUZ5zjQjT/3JO2bLHFQtDkfr6V6Us+dyQQPMj4XaT76JochCrHwaqnE+WSpm3e9CvlSE96dPacw==
X-Received: by 2002:a05:6214:20ed:b0:56b:f28e:628a with SMTP id 13-20020a05621420ed00b0056bf28e628amr12088050qvk.6.1685642803852;
        Thu, 01 Jun 2023 11:06:43 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id n24-20020ae9c318000000b0075b09ae68b1sm6962969qkg.118.2023.06.01.11.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 11:06:43 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Cc:     Erwan Velu <e.velu@criteo.com>,
        Luiz Capitulino <luizcap@amazon.com>
Subject: [PATCH] selinux: don't use make's grouped targets feature yet
Date:   Thu,  1 Jun 2023 14:06:43 -0400
Message-Id: <20230601180643.211112-1-paul@paul-moore.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1579; i=paul@paul-moore.com; h=from:subject; bh=1uMo3UXqLPExtasw2K0aolC4UOtXoIOLCOWsfLjKCIQ=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBkeN4sbhhtA3LZoeaAVtPvhQlO4cqIRvcXVl6rJ LjLTDeOoMuJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZHjeLAAKCRDqIPLalzeJ c4KyEACopHoVm8NbC5bqJJtJEcbF8NJJifjyvH0CGJKKFiII4fYBmZ+H7vPnNOq2RqgBSE9hGOf zrE+c/EYRKrfhfASWSROqC4NXJuMI2tTHK3pZYxKrfzlKzW8xBAsrt5cuKxN5PzuzL01+Rg7PLG 1APvKHSPK2AOXc4UH8N3SuDCp7AsY850f0FieeO+8Hlu4bTIIrULC1OktfxLuAz/YfI/h6qtfkP yMr8aNDedvRYm7dc91ncEfbaYZsBJee2UGDobNtVvmD9X5VGv1ZV2ZEqLqHDdKge4Y3kCDgncNI cmxYaqPCSlbbCYp2Q8sxQV+IbMf3PO1T4CJQ5rhwnm9SB1vVHljKHFYeJBQcQa4ZeE2gTp6b/tO esFTiqA21xfEwUNcS6EBzaTM1XceYtkTAJR9q5QAbGdm1CASEDOI+qs11r3nUUPwsHQantHMIY/ 2VBYO76vuW416pcCXNaFjP4gIng2boRT9dRK4UuNy13RTKakMEEqJuACUi8wLPEeHkiip9/in7J ZMRHExslRVVyuerzNRCMxwP+y9S6msgECr2Rd47pc+j9WnnOTLgxYteSKWxLb78QvYqFvj7Uhwm qKCu0a7/L7yYxjjzSbyw5S5zMNmVWFNC8P0kbOslRj6qGhnTqvKZxSN2qPTjrSRQYGHA3eVxptN q8/kwAMgnMe0W2w==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The Linux Kernel currently only requires make v3.82 while the grouped
target functionality requires make v4.3.  Removed the grouped target
introduced in 4ce1f694eb5d ("selinux: ensure av_permissions.h is
built when needed") as well as the multiple header file targets in
the make rule.  This effectively reverts the problem commit.

We will revisit this change when make >= 4.3 is required by the rest
of the kernel.

Cc: stable@vger.kernel.org
Fixes: 4ce1f694eb5d ("selinux: ensure av_permissions.h is built when needed")
Reported-by: Erwan Velu <e.velu@criteo.com>
Reported-by: Luiz Capitulino <luizcap@amazon.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index 0aecf9334ec3..8b21520bd4b9 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -26,5 +26,9 @@ quiet_cmd_flask = GEN     $(obj)/flask.h $(obj)/av_permissions.h
       cmd_flask = $< $(obj)/flask.h $(obj)/av_permissions.h
 
 targets += flask.h av_permissions.h
-$(obj)/flask.h $(obj)/av_permissions.h &: scripts/selinux/genheaders/genheaders FORCE
+# once make >= 4.3 is required, we can use grouped targets in the rule below,
+# which basically involves adding both headers and a '&' before the colon, see
+# the example below:
+#   $(obj)/flask.h $(obj)/av_permissions.h &: scripts/selinux/...
+$(obj)/flask.h: scripts/selinux/genheaders/genheaders FORCE
 	$(call if_changed,flask)
-- 
2.40.1

