Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F8DC54EE9
	for <selinux@archiver.kernel.org>; Fri, 23 Sep 2022 01:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiIWBu1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 22 Sep 2022 21:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiIWBu0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 22 Sep 2022 21:50:26 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA8C7D79B
        for <selinux@vger.kernel.org>; Thu, 22 Sep 2022 18:50:24 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id y2so7428293qkl.11
        for <selinux@vger.kernel.org>; Thu, 22 Sep 2022 18:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :to:from:subject:from:to:cc:subject:date;
        bh=sMt8kG5b8hrpdxwCBvZNKPHq3lTvifHBn+3QoP6sqFE=;
        b=EKhXxo5TiIUHri65GCtVNPJR8ROhhEntlhLdELaFFqAFyKjCFhFa+rn5HJTGMGoFHh
         8vwKd7ATAJGb0mQ/Cfr6IkJ7ucMGsMexLTDVbp1gpLBAqZSev+r5fbmfub8zSpuOtDsW
         5QluSWg5A9FSwRLsD+WmyIADxCP/glwQ4nheKc3FhfrDndqFwNCnAqB0eOh0WfO5SwL2
         rcFWxs+fXQ0PaHx8ddCwgF2Vg8shbjmSDNHvwERhvD3aa9ds1CEd/suFSZDMHDsW2KYA
         zgU/rYK/F/fJmqITG+H5nkSUy6M+kFp0jUl6wq7EwjKI3DHZRF4oEJz1ot5aIALLMZQo
         JfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :to:from:subject:x-gm-message-state:from:to:cc:subject:date;
        bh=sMt8kG5b8hrpdxwCBvZNKPHq3lTvifHBn+3QoP6sqFE=;
        b=kLlzi1XKvqHnDDdoTehtemkraOGHns7C6hZLk938INLX0wi3qY57XTKyMFyCvLIMhB
         Cm+rAw9Vuh/lxmvPY5Np7wwYywADTClTTHXs725T4sim0rfrq6lWLNGjm+2/JumeIq8v
         gb66pG5hvyQkeiT0gixKLGYpxOIM67xY1MjVihe230iR//uONXIY0AP+C0Jz2r5Pl1If
         Bf3XAmPCoNAfXQLJmveMIy+WIs0Cn+Z15g4jXYB5DBnH5QI9+3ozXbBTlLru7Oky+2Xp
         hluK+NT+0YBM7RvDJuUMKnYq6RoTeCNCMEGaCZTMz58Z842//xad7Ia4NHdcJXFFh0OB
         v0vA==
X-Gm-Message-State: ACrzQf0r6HoepnS9sSbzQfiwr1MF4YWygHMLyXKifvCBrVFl1+oZ0594
        JamtJq5q4HTngbcn2ijO/M/MII9qwVBx
X-Google-Smtp-Source: AMsMyM4jH7NZ2ldAhSL1PeRGKGWCAldBejfljqhCFtI/IoieQoOHWRcccNHg/yj0/lT5COA9W5pVvw==
X-Received: by 2002:a05:620a:4055:b0:6ce:4073:179 with SMTP id i21-20020a05620a405500b006ce40730179mr4181554qko.617.1663897823476;
        Thu, 22 Sep 2022 18:50:23 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id h7-20020a05620a244700b006ce7316f361sm5025300qkn.118.2022.09.22.18.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 18:50:23 -0700 (PDT)
Subject: [RFC PATCH] selinux: increase the deprecation sleep for checkreqprot
 and runtime disable
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Thu, 22 Sep 2022 21:50:22 -0400
Message-ID: <166389782245.2164705.1324707815130435654.stgit@olly>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Further the checkreqprot and runtime disable deprecation efforts by
increasing the sleep time from 5 to 15 seconds to help make this more
noticeable for any users who are still using these knobs.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/selinuxfs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index a00d191394365..0a6894cdc54d9 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -294,7 +294,7 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
 	 */
 	pr_err("SELinux:  Runtime disable is deprecated, use selinux=0 on the kernel cmdline.\n");
 	pr_err("SELinux:  https://github.com/SELinuxProject/selinux-kernel/wiki/DEPRECATE-runtime-disable\n");
-	ssleep(5);
+	ssleep(15);
 
 	if (count >= PAGE_SIZE)
 		return -ENOMEM;
@@ -763,7 +763,7 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 
 	checkreqprot_set(fsi->state, (new_value ? 1 : 0));
 	if (new_value)
-		ssleep(5);
+		ssleep(15);
 	length = count;
 
 	selinux_ima_measure_state(fsi->state);

