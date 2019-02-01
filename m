Return-Path: <SRS0=EhYF=QI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E2FC282DB
	for <selinux@archiver.kernel.org>; Fri,  1 Feb 2019 20:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7780B20863
	for <selinux@archiver.kernel.org>; Fri,  1 Feb 2019 20:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="ZkF373cm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbfBAUWg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Feb 2019 15:22:36 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:37373 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731348AbfBAUWg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Feb 2019 15:22:36 -0500
Received: by mail-qt1-f176.google.com with SMTP id t33so9102636qtt.4
        for <selinux@vger.kernel.org>; Fri, 01 Feb 2019 12:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=RUoLS1HM1NotXHAW3R2qbUjYA6VerEKovCcJfTYeb2Q=;
        b=ZkF373cmjxvKaxbVcxqv9hZBjl9jdM+MhzcPgB5YPf0B8uhPGKnS77pACUky56dIfq
         6f3MQr6Rq26oKdiS/4rvovKrFzOSAnJcuqGba6FuuZvNPT+nTWm3WZTx06zvOSw2MM6H
         D/DJdhFXrmU29mIjSy+jhHtpfKXdTLCVT0QY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=RUoLS1HM1NotXHAW3R2qbUjYA6VerEKovCcJfTYeb2Q=;
        b=nlI4hxDHbW79dGtUWq6FW0XP1P0ZX199/ENOIbbLejrj8bvE2aU/CmMberZozg9IC4
         xyKb41QfzhlCVHLPQNKMGSG4P/tDKkXL3SDuJx42q10Rzy01yc1Zyr69Svb2lkKnym0v
         uA4RD7TQkHX9Ey156LcWwV+pcJ4FSOMRXY6DVkqhxVIK0nn3qGX1VlwRGeWmppo1mJp2
         U1mZHNkwaN63SDgR2qRfNTu5mA7Pqptb2Xt0A8ojkO+Rr7BlriC87uQ5/yR9wkG3vW0G
         jiAM4YeqDDPjLpFzAhMdl3uRvcWCLLoKXLHUsmVDCmF3ocsiJzBx5kS20leLmTkJnbnO
         AanQ==
X-Gm-Message-State: AJcUukff5RWMEWAIpc1IGUHd1M789n5I1ZCnNz2p2EwKjJd9T3c1/8/5
        OG4inqJWARjTKQ05wDSsL3xXiqgMzt8=
X-Google-Smtp-Source: ALg8bN4WfqVwIhrVjbkQ+nDaOQfmf8aWDXzI/UQNLvV/kV1YR1LFjc6ck7g7XP+xHpReMIbQ5Q/w7g==
X-Received: by 2002:a0c:fb4c:: with SMTP id b12mr37717087qvq.177.1549052555404;
        Fri, 01 Feb 2019 12:22:35 -0800 (PST)
Received: from [192.168.1.190] (pool-108-15-23-247.bltmmd.fios.verizon.net. [108.15.23.247])
        by smtp.gmail.com with ESMTPSA id y137sm3470296qky.2.2019.02.01.12.22.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 12:22:34 -0800 (PST)
From:   Chris PeBenito <pebenito@ieee.org>
Subject: ANN: Reference Policy release
To:     selinux@vger.kernel.org,
        refpolicy <selinux-refpolicy@vger.kernel.org>
Message-ID: <89288574-4b39-9ff6-d2c7-b4e65ef3521c@ieee.org>
Date:   Fri, 1 Feb 2019 15:22:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This release includes three new modules (chromium, hostapd, and sigrok) 
among other miscellaneous fixes.

142 files changed, 2499 insertions, 270 deletions

<https://github.com/SELinuxProject/refpolicy/releases/tag/RELEASE_2_20190201>

-- 
Chris PeBenito
