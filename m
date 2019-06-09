Return-Path: <SRS0=aXwL=UI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D05C468BD
	for <selinux@archiver.kernel.org>; Sun,  9 Jun 2019 18:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A9F206DF
	for <selinux@archiver.kernel.org>; Sun,  9 Jun 2019 18:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="G49IuZa3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbfFISjD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 9 Jun 2019 14:39:03 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]:36248 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729415AbfFISjD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 9 Jun 2019 14:39:03 -0400
Received: by mail-qk1-f181.google.com with SMTP id g18so4361039qkl.3
        for <selinux@vger.kernel.org>; Sun, 09 Jun 2019 11:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=J6h205K9VwncrhdwAH5KZdu3Yk1B8j0yHv6kNl6pk5c=;
        b=G49IuZa3DSyzo9+zv2eQq6Smf+HSwRTWWwm/G0/06PrF6M4ymmjcvWJzei/4wMr1lz
         53JRvq2Ih0QDedm1s23MZlWeRufZ3opIbgx3USPqMUe71UB6hYsey5xoemUS94jFv2gQ
         aI4pWCYE3jR02tTgSwIadpbLouEgab8gbKtWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=J6h205K9VwncrhdwAH5KZdu3Yk1B8j0yHv6kNl6pk5c=;
        b=ZFZLdXNRnJ/EZKzGAQayPFV0xHtkv2vouLTb/97wltpzn8Ub8e5vL95B8juZIpCjSe
         dB2PdbhtdWMF/+sqJVA4oxuPCdihRJAdWmKnV/S8L5BDVN/4Eg9Qjw8+k2fRSE0ew3od
         gL4jkaf1PAVaS2O3n3Q/saYdjQnk5ozWlskLXa/1LIgjGfRy1ORBZUnYX3eRoc+ENJL4
         X5hCkrHXtT84LKNdc8QAcrlRIwnI9FwNHhBvqZkmPVaavhsHBHqdDp8ynStMWNmLKmco
         hHzNGRmm4ofVk1idoPvryu54zHaUZyCysvplJCB08x022q0v1zI08g/lE1TzWmJCdkiR
         Syqw==
X-Gm-Message-State: APjAAAUzvnWWc8zENldDX8sXF8cyZjNWLMaHOTUtIZIliZcP4ZEApAJ/
        T6tpGOMK7w/319HbMgvw/t5urUFY6vY=
X-Google-Smtp-Source: APXvYqx5mxrtDthT4QyS6XS11EC4w5+Fyr4dii2RWCPMNzU03TzXimPSaa1MFXNpbySGlyqzm54v8Q==
X-Received: by 2002:a37:64cb:: with SMTP id y194mr44357025qkb.197.1560105541601;
        Sun, 09 Jun 2019 11:39:01 -0700 (PDT)
Received: from [192.168.1.190] (pool-108-15-23-247.bltmmd.fios.verizon.net. [108.15.23.247])
        by smtp.gmail.com with ESMTPSA id d17sm3884182qtp.84.2019.06.09.11.39.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 11:39:01 -0700 (PDT)
To:     refpolicy <selinux-refpolicy@vger.kernel.org>,
        selinux@vger.kernel.org
From:   Chris PeBenito <pebenito@ieee.org>
Subject: ANN: Reference Policy 2.20190609
Message-ID: <f73cf738-ea92-d029-004f-fc32712588f9@ieee.org>
Date:   Sun, 9 Jun 2019 14:38:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This release includes one new module (stubby) and several systemd 
updates, including initial support for systemd --user sessions.

This release requires SELinux userspace 2.8 or higher and Python 3 to build.

79 files changed, 1329 insertions, 191 deletions

<https://github.com/SELinuxProject/refpolicy/releases/tag/RELEASE_2_20190609>

-- 
Chris PeBenito
