Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C487C433EF
	for <selinux@archiver.kernel.org>; Mon,  7 Mar 2022 23:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbiCGXJz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Mar 2022 18:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240749AbiCGXJy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Mar 2022 18:09:54 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBCA625C
        for <selinux@vger.kernel.org>; Mon,  7 Mar 2022 15:08:56 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id hw13so35187766ejc.9
        for <selinux@vger.kernel.org>; Mon, 07 Mar 2022 15:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:message-id:date:mime-version:user-agent:content-language:to
         :subject:content-transfer-encoding;
        bh=1OwzLnFzqre5/hh4FNt1sWqd2426i8MND1RpfxIF9pM=;
        b=oJVMlGwgDMTRKN8hKCHohRpRMd0fUQ+z+8ImsGJGWH73PWZ2+xCp1mNMSItMKl6oH9
         cGUp9kbGTeY6a2wwSZ+IB9wmdkIHhI7tQJ+ZM4gjxZNtt0Rb/RGbtT/BTNntLeHvPALm
         6Q7cECCDW2E2vnqkELMrLQibuyXlY45YUC8eNphtwvrxQS7qnO6ToH04Mg+fcb+1botN
         uzfXsaSIqX1u+MLyBMOKeukhf/BxtAvDiKZT4/YzVXoIedQnx1cMifzCRAtYh6uj7Dd7
         ub5ekrSNSoj7KIvWpREZifEI/1U05swpUpe+/3L8pOIiBx4fYaaMr/pBv2QpU9tXHCZd
         nOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent
         :content-language:to:subject:content-transfer-encoding;
        bh=1OwzLnFzqre5/hh4FNt1sWqd2426i8MND1RpfxIF9pM=;
        b=dvFzfrzHNIOtAEYqZ6TfPfmq2ArEPh/aKdkmcmicqVqr6OMpIpkprKUCNOAyZezTr8
         i33jcrsrGlrVOb7CRgeaReN1NG47Ep99iyHGMLCVX7XyI2IKlZYWAv78rTNhCYfFklg2
         dPF7PnVM+Yc2X/i7ZGjV4EGzD/XHqmR9goFuGRz48TFqEubUzjmQmPu9h/FoiVqdMLQg
         pf0VW5VbJB3kRpUJwgZoCGYBhkljShDWq+XcCpbk5JY6cchqy8+ppg3T1Hnfj7kVrXgS
         Fmn8ErjJXEjMUuJujroTgIQJ6QqENiUHO1JStFcy0mbBf4H97jvkEIKOKRS6peYf08nO
         5g/A==
X-Gm-Message-State: AOAM531SD3QClBlYsi39IJY4Rrbq74DkC6UM+FH4Wku1nbGL5GHcKAGq
        1ogYQUJt2/yxRufO53WscPFKXtMmyWDHnXwB
X-Google-Smtp-Source: ABdhPJw14LVZ1BNio0tNoIYxksn6QrVoIihs+2HS6e2fty8RYwIp5F/teNMvUREOMAPuVGXh/0bW2g==
X-Received: by 2002:a17:907:1b27:b0:6d9:ceb6:7967 with SMTP id mp39-20020a1709071b2700b006d9ceb67967mr11151382ejc.186.1646694534605;
        Mon, 07 Mar 2022 15:08:54 -0800 (PST)
Received: from ?IPV6:2001:a61:34b2:1901:6a0b:aae1:c0f1:d98b? ([2001:a61:34b2:1901:6a0b:aae1:c0f1:d98b])
        by smtp.gmail.com with ESMTPSA id q18-20020a170906771200b006d2a835ac30sm5199769ejm.151.2022.03.07.15.08.53
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 15:08:54 -0800 (PST)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
Message-ID: <077581c9-4169-5c12-e551-0db4bfa78655@gmail.com>
Date:   Tue, 8 Mar 2022 00:08:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     selinux <selinux@vger.kernel.org>
Subject: Recently fixed neverallowx checks report (range 0x)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

The recently merged commit https://github.com/SELinuxProject/selinux/commit/71291385cf149a0316d5fa995d70641d3b1a0ab3 seems to have caused some neverallowx failures for my pipeline, they're correct.

However during reporting a `(range 0x)` is printed, which does not seem right, please see the log of my CI that failed https://gitlab.com/bauen1/bauen1-policy/-/jobs/2174049183#L1653 the associated commit is 73b511c3050952527fff3050bb75774214691d24 of my policy.

My policy can be build by invoking make, however this involves many modules.
A smaller policy that still reproduces the bug can be build by creating a `policy/base/test.cil` file with:
```
(type t2)
(allow t2 .dev.dri.type (chr_file (ioctl)))
(allowx t2 .dev.dri.type (ioctl chr_file (0x640D)))
```
and `make validate-core` will build a policy with less modules that will still fail the neverallowx checks and print this message:

neverallowx check failed at policy/base/permission_sets.cil:1002
   (neverallowx all_types all_types (ioctl chr_file (not ((range 0x5401 0x540B) (range 0x540D 0x5410) 0x5413 0x5414 0x5420 (range 0x5429 0x5431) 0x5437 0x5441 0x5456 0x5457 (range 0x5601 0x5603) (range 0x5605 0x5608) 0x4B33 0x4B3A 0x4B3B 0x4B44 0x4B45 0x4B4B 0x4B4E 0x4B64 0x4B67 0x4B68 0x4B6A 0x4B72 0xFD00 (range 0xFD02 0xFD04) (range 0xFD06 0xFD0D) (range 0x9371 0x9374) 0x9376 0x937A (range 0x4501 0x4503) (range 0x4506 0x450A) 0x4518 0x4519 0x451B (range 0x4520 0x457F) 0x4593 0x45A0 (range 0x45C0 0x45FF) 0x690B 0x690D 0x6910 0x6911 (range 0x))
     <root>
     allowx at policy/base/test.cil:3
       (allowx t2 dev.dri.type (ioctl chr_file (0x640D)))

As far as I know the `(range 0x)` appears to be a bug.

Sadly I don't have the time right now to condense my policy down to a smaller reproducible example.

-- 
bauen1
https://dn42.bauen1.xyz/
