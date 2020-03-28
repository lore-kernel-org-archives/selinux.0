Return-Path: <SRS0=0b+K=5N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B142C43331
	for <selinux@archiver.kernel.org>; Sat, 28 Mar 2020 22:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D421F20716
	for <selinux@archiver.kernel.org>; Sat, 28 Mar 2020 22:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGGejhVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbgC1WJJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 28 Mar 2020 18:09:09 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46589 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbgC1WJJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 28 Mar 2020 18:09:09 -0400
Received: by mail-lj1-f196.google.com with SMTP id r7so6278975ljg.13
        for <selinux@vger.kernel.org>; Sat, 28 Mar 2020 15:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=UhcqGVyI3sfadTnJBrXZ23ITGFjgSSX50bskPAVsZIM=;
        b=GGGejhVa8HwZ8YRTUlX+N+Ce9VCvrt/s7LPzXFXwzbdbMuyur0AMl8TKzij99VEiLc
         nYwspscloVyXMuxvtK3LGBR7+8OuD7dMPGm0qaS1CVFHZqV/XhrWDbPbkKFL7k2EKyfX
         J0MC4DG72buzezwWqYrnXo458MoHAcL3TAb3dP8yvY4EiGETK/knD43SE82P33DxQn0c
         OO6oDgwnMq+8ozW6tjpmkbBJoAWEGOj1jzs+lE2wAuvgKj45oLWHUXyfo9jd5maTghdy
         hIHFb54w3jekZCYEl3BLh971HmgyCF0Ukva0iQVo76yb4uixoR5+GXHLSmjeNxiqnHx7
         Wl2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=UhcqGVyI3sfadTnJBrXZ23ITGFjgSSX50bskPAVsZIM=;
        b=a/x59CHKnMdURYP6vu78xDNFSgziXP75y9AXxLJV5my60f1I0lPhH7Zal+K7jSzBFa
         6GpJpaT/Fd3Mzkip4Ab/yn/eOWmOpFvvoC6hhrdE+8lKFwztn42gXONuLeAId0AxTVWC
         lMplgTlmFouXYuIaGX+efuOBf9+nAN4JUSojC4vCMe79ooTaLwpj/23sNjvHKtOKeR9U
         cd8/SLm6mXdso8L5UfjAfhpACijBHAfc7/IATzRKs6zEwzagVOJHRPCIWEbKRlJOYjEa
         XgNu7u2zgdTMFGMlpEUUsbjA6czHf9DobXWb+QNkmWPphNjOVX8ic7dnWo78iDQ7fdJz
         eANg==
X-Gm-Message-State: AGi0PuZFaG9HwarSrc67qMsBDCsnPtPfQizgBcNq5DhzUFID1wdvaPB4
        6pxPTjrXxbzLSlU/Tda7QmJJbH6tLV0=
X-Google-Smtp-Source: APiQypLNvVN1LH/SiSqpr0lNBxcBRWFMKl0cZK2QqQ6NT949HYxhtZqKsjK0be70UGdHRaCcWfKRgQ==
X-Received: by 2002:a2e:5304:: with SMTP id h4mr3078843ljb.75.1585433346805;
        Sat, 28 Mar 2020 15:09:06 -0700 (PDT)
Received: from [192.168.1.38] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id r141sm5016521lff.58.2020.03.28.15.09.06
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2020 15:09:06 -0700 (PDT)
To:     selinux@vger.kernel.org
From:   Topi Miettinen <toiwoton@gmail.com>
Subject: [PATCH] libselinux: mount selinuxfs nodev,noexec,nosuid
Message-ID: <f4e6ddb4-66ac-45d1-04a6-67bfd9fd225e@gmail.com>
Date:   Sun, 29 Mar 2020 00:09:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Mount selinuxfs with mount flags nodev,noexec and nosuid. It's not
likely that this has any effect, but it's visually more pleasing.

Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
  libselinux/src/load_policy.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index fa1a3bf1..3e4020a9 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -279,7 +279,7 @@ int selinux_init_load_policy(int *enforce)
         const char *mntpoint = NULL;
         /* First make sure /sys is mounted */
         if (mount("sysfs", "/sys", "sysfs", 0, 0) == 0 || errno == EBUSY) {
-               if (mount(SELINUXFS, SELINUXMNT, SELINUXFS, 0, 0) == 0 
|| errno == EBUSY) {
+               if (mount(SELINUXFS, SELINUXMNT, SELINUXFS, MS_NODEV | 
MS_NOEXEC | MS_NOSUID, 0) == 0 || errno == EBUSY) {
                         mntpoint = SELINUXMNT;
                 } else {
                         /* check old mountpoint */
-- 
2.25.1

