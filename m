Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0418AEB64DA
	for <selinux@archiver.kernel.org>; Thu, 20 Jul 2023 20:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjGTUb1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Jul 2023 16:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGTUb0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Jul 2023 16:31:26 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C899E
        for <selinux@vger.kernel.org>; Thu, 20 Jul 2023 13:31:25 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-76758b855edso114859785a.0
        for <selinux@vger.kernel.org>; Thu, 20 Jul 2023 13:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689885084; x=1690489884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IT60q12rOLtuzgguwkPmRwtIaxsySqA30caj9iR32pQ=;
        b=Mmgb9EupskgxuN08eWIojHMt58YMqp+dDDEzhVXltdz4TYrk6Y7jHaZuV56JZSVDV8
         ozlXhZoQ49ALdfMsOCgm6AJigStnMJeedqtVztYTuHbF2tpyNijiSoRIJFekdpcztsCo
         3UiqplwcmMIjCNOEA0A6aXR7WEXQMssWH4E5a/7shUGnC/bG2PSP/gvjf2T4hptkjag1
         +aPHmY4tiRTT/YJMc291NIt1ZskfSWJ+B8liZAQ/nR3lI1tQG4nDy+pxG7PckECHJU6p
         KKJkAuFMZdaZyaWTEt8WcOyCVv44+WMGgEW1sp7/e/FWz8hYd5+zjnMtWKC9S9qxFi8i
         zSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689885084; x=1690489884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IT60q12rOLtuzgguwkPmRwtIaxsySqA30caj9iR32pQ=;
        b=HysmiYnOqcbZv3n7naomYkxiWzW8QPg61UospYqcIhBuhdNiI4yZAzQ6o9vk/lnc1m
         bIUw/03c0KV/rGhIEp1kA/PtrAoaGpv1WIIfbCxAxMcFbouOn6W8/kbeLpISlyk2xgzp
         49XW1F8nRhplE4rY7Ftq/Ews5Cg4yDwDUQ0VV/DdwWHjSTDCBBBmG7YwFHlPtdiyRFvV
         c/xQUvdcskgXvIWUpVRmU42btfZp8lEpIYYnfK4lMabpd4IxSBv8YcDqD4mnnQnmumS/
         08Xd0lQvkMYZkS/Mjh9h9YcogKFsYcoE90SFIY3OZ/qGL4/mXnOmU7uUp2mcl4J9rsVu
         KH8Q==
X-Gm-Message-State: ABy/qLa1dXYMxWCpnTLX8G2Eg3BL4/+56UrFzcrmaYt7E3hd494R2Ib4
        INmZ3mvE1HBL25x29KOXP/ZGfa8DIW0YyrqsMQ==
X-Google-Smtp-Source: APBJJlGmR+/etWqJBgaecbhARuV5wXNI2pzrYbRaio+xNj2N/f5HdzJyM9DVmnSODV3XHiUR7VlVbQ==
X-Received: by 2002:a05:620a:444a:b0:762:3841:c098 with SMTP id w10-20020a05620a444a00b007623841c098mr7767558qkp.30.1689885084564;
        Thu, 20 Jul 2023 13:31:24 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id c10-20020a05620a134a00b00767db1ba172sm610231qkl.31.2023.07.20.13.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 13:31:23 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Cc:     Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] selinux: fix a 0/NULL mistmatch in ad_net_init_from_iif()
Date:   Thu, 20 Jul 2023 16:31:17 -0400
Message-ID: <20230720203116.316250-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=904; i=paul@paul-moore.com; h=from:subject; bh=h5vMeiJOTTe0eFjjp/UWEni3exUyLgBJJk/h14o8+Po=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBkuZmUN4ZhNYtmPFEDcO/2kn+WTxFcg5t1zqXj2 mEA0C+gmwuJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZLmZlAAKCRDqIPLalzeJ czVQEACwKplj51iAsU4f1LbAGl0FGJghQdBM6cymzyQagbWeOBp4cup/r4LP7L6yPise78Q12pC tAYZ90kNXxBA+RprUy76DOE/kTLWoJduWXInnBpup+4ZYGLUHO5agaf/PnC8F51wb3TDPnlW2Mk ZnuxPYYxjuxDOR95SEUu406G/VGw/RFI5TRYcNW7wG2CocseJU26M9ZPxPKO3zgZ4W4REGTA0sh xsrj/5nZwoQHfGcR9SJgI/LVdRtV7Xp9nfSoLXEhxWN3v1F1fRcssd6qDyWI292TMLvJi8b8U4U juhiAYCFUj4iw4k+MfOWbx08Pp51uAe/N0pkRtVLgAvPBo6kDBYq/nI0LLiLnDENOxpSOe/64oO XdTmGnVux8W9J03PcGACkg9H8ngmYA7Oeqwjhf9SfOTceai41GOgWcrxABaY+nGJOubnWGcAbw2 jT9Pyb6jmHqPYv5ljjAOCx5nUYDTuWaq3UU6dcnraYgjgx8PP/rONK7zGghMLDIKfiSDtzU7G0u za7lh8yLHzsD7GCV1aU2RYGuYzL5AOZMg5h1KFgXSD9giYm0ImV8d9Sjh0dis/5C4fvpMeuhjmU U7dAynRIQRsv3Hr5K9b+RoJfVgHQyseRvJBHzyena9ZgsE2nbs+ZVeBHjq/i5AyWrvqihvFLnHz xHMsc1ouHB/4bMg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use a NULL instead of a zero to resolve a int/pointer mismatch.

Cc: Paolo Abeni <pabeni@redhat.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307210332.4AqFZfzI-lkp@intel.com/
Fixes: dd51fcd42fd6 ("selinux: introduce and use lsm_ad_net_init*() helpers")
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6f53fa71fbdb..5194f12def97 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -246,7 +246,7 @@ static void ad_net_init_from_iif(struct common_audit_data *ad,
 				 struct lsm_network_audit *net,
 				 int ifindex, u16 family)
 {
-	__ad_net_init(ad, net, ifindex, 0, family);
+	__ad_net_init(ad, net, ifindex, NULL, family);
 }
 
 /*
-- 
2.41.0

