Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5B1C433FE
	for <selinux@archiver.kernel.org>; Tue,  1 Nov 2022 14:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiKAO0r (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Nov 2022 10:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiKAO0o (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 1 Nov 2022 10:26:44 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77541BEB2
        for <selinux@vger.kernel.org>; Tue,  1 Nov 2022 07:26:40 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id c15so2405296qtw.8
        for <selinux@vger.kernel.org>; Tue, 01 Nov 2022 07:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGeelK6e3RrGwUWA43330Pjlvt+ORjm/i7zBISsILRM=;
        b=VKgBXlskpBcN4s8cvcZ7lxqDws1SbONGjwMvkzwnmQjPoZuNjXMhdQmsiqtYPBBFPh
         QV27Tj7TWtue7rmxz380MIzZq7gBTKnNRZwAuNh9MtGEDjISep7NqZYUYsvCFbeecLTJ
         Q+ck6qm5VNkhM7K9Gfrp9uS5GTJ3HKH/rSGUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WGeelK6e3RrGwUWA43330Pjlvt+ORjm/i7zBISsILRM=;
        b=3pDkwvLnngNY9dFhLmwIH0071bwI6IWQB1vyebif3Cp4R8vzeH3J5bboSWjZYdWcos
         /KtFbKluPczrp9nBXDTnTV8uJd2CWKWwLvD8D8rVW8q+Xu2xuzl4N2IuiOrtFdKnbYK3
         i1E4aFAYrpjNPQhqxCYsYxe0TeeAUEtqSIcK+zCYbz3VUtOaM4oomDBkF3GMOQrIRoi3
         JZGzh3InieS4TtN3Gq5KAFg1LS4R5RpHev8LwQ4lSOS1sq0PasRMdh8giL4tpE7FuHbz
         dwlD2VGjZVs+kgWMofjIIdPzbk5Gs6/NUaD/NYlLtRUoD18N8aUNlaejxsVid/EIkmF9
         stJg==
X-Gm-Message-State: ACrzQf13mAo2WNXu3jwzCm+esdVPIC0IzLTUP2SGcBfuP67n8z68CqrQ
        CuWongFyOgf7BAXVBjEEq9pSMA==
X-Google-Smtp-Source: AMsMyM5INz1wmTnpMwzjcuPQX9hJsguUqKI3TT6ql2L4RJOZnTOL02p7t2zHBkOhzkdYglpc8U1w+g==
X-Received: by 2002:ac8:4e17:0:b0:3a5:318a:2625 with SMTP id c23-20020ac84e17000000b003a5318a2625mr4997366qtw.268.1667312799757;
        Tue, 01 Nov 2022 07:26:39 -0700 (PDT)
Received: from [192.168.1.242] ([68.33.139.110])
        by smtp.gmail.com with ESMTPSA id x10-20020ac84d4a000000b0039ccbf75f92sm5179459qtv.11.2022.11.01.07.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 07:26:39 -0700 (PDT)
Message-ID: <1ab28567-eefd-26e7-09fb-3ea3153a2ed3@ieee.org>
Date:   Tue, 1 Nov 2022 10:20:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
From:   Chris PeBenito <pebenito@ieee.org>
Subject: ANN: Reference Policy 2.20221101
To:     refpolicy <selinux-refpolicy@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

https://github.com/SELinuxProject/refpolicy/releases/tag/RELEASE_2_20221101

Notable changes:

* Clean up MCS constraints and add missing checks for IPC and sockers.
* Many minor fixes across the policy.

New modules:

* cloud-init
* fapolicyd
* opensm
* sympa
* zfs

-- 
Chris PeBenito
