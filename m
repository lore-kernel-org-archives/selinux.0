Return-Path: <SRS0=AdpT=BQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40213C433E0
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 17:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99901221E3
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 17:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyGyK8E+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgHFR1I (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729449AbgHFRBx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Aug 2020 13:01:53 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0272AC061A14
        for <selinux@vger.kernel.org>; Thu,  6 Aug 2020 05:03:21 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id v22so30168041qtq.8
        for <selinux@vger.kernel.org>; Thu, 06 Aug 2020 05:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=fV/eUaQHUhK0tmiW9lBWh+ohT6CBRHN8ubKtW51keyw=;
        b=EyGyK8E+6qmZ4AfKsFQOBqmtXo2fJ05/eySRotOuPO360zitXVAp8Giv+4iz95RFH9
         f9l2S7/oMKYd2VY9H8FncND4/oqU8vaPS6ABalCoCeFK/ylfe6TSuipo02wsDhY3HfDA
         NyIEsdzu/LKJ/ik9UkneV/1EGI1J3bSu1kEZ27Xf2406xgJM/4wzntX3jepm1dxnnTbM
         I43N3a9wRQiEpNQ/bvbhSpiC/JcsfgBMh8ju9+kIysVFWfYvWA2R3eRusuE3gVTDE2K6
         oweslefCf1RMFpaQxw1MyAds55U6iyj1MPKyOTN8roR0sXorHGWB6e4Bqvtpvo1zyZ85
         h8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fV/eUaQHUhK0tmiW9lBWh+ohT6CBRHN8ubKtW51keyw=;
        b=udfWQ5Ixk3irM+KmcGqO0sGZsLQMNUhHNkuXTEkOPv4ipMBJxgSAmTRjI7INllAyO1
         ccIQQj6kUu3SOd2xzvzU+ljr+5FYJ00YjB1eTj233mIsUSeO7cf6fcWUR58A1K1pH1Xy
         hxLMwz6kQxFEh1mn2TbdPR6zVhN3782bn7rIrO0lBay3cExUw3pH0Vt9fbVm3XQAciYn
         LZSU2G2F3dwFEGpj5UoZzlSjLHpW0Db20pYav0yNnLKLWwEMmgSluVs2U62A9zuQWkwb
         5gtu1bcysjMFylCHqI0270mlT5bdAxyrUP7b1SMQyJfxTDqER4drZICf3v+QyfxgPbct
         Q6Kg==
X-Gm-Message-State: AOAM5312K2wX6BbDXRim0wS4U2lGCWGEIAPu9S0TtFLWm5e2GVZRxEak
        7nFDe1EuVXMGvDn6oCBfknc=
X-Google-Smtp-Source: ABdhPJxiyCn+P+4mnXZU3QKVeWRXhKx2fcsR3stLHrklvJVHKSqNzgbg4Fvb7UGw6TlEPrrA4QDZHg==
X-Received: by 2002:ac8:4095:: with SMTP id p21mr8544529qtl.166.1596715397902;
        Thu, 06 Aug 2020 05:03:17 -0700 (PDT)
Received: from [192.168.1.190] (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id w27sm4487949qtv.68.2020.08.06.05.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 05:03:17 -0700 (PDT)
Subject: Re: [PATCH v6 2/2] libsepol: implement POLICYDB_VERSION_COMP_FTRANS
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>,
        Chris PeBenito <pebenito@ieee.org>,
        Petr Lautrbach <plautrba@redhat.com>
References: <20200731111035.498656-1-omosnace@redhat.com>
 <20200731111035.498656-3-omosnace@redhat.com>
 <5ad008a6-8a98-346b-98a9-77971684c2b6@gmail.com>
Message-ID: <2c0fb524-f82f-a08b-740e-8617b78b2a27@gmail.com>
Date:   Thu, 6 Aug 2020 08:03:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5ad008a6-8a98-346b-98a9-77971684c2b6@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/3/20 9:57 AM, Stephen Smalley wrote:

> On 7/31/20 7:10 AM, Ondrej Mosnacek wrote:
>
>> Implement a new, more space-efficient form of storing filename
>> transitions in the binary policy. The internal structures have already
>> been converted to this new representation; this patch just implements
>> reading/writing an equivalent representation from/to the binary policy.
>>
>> This new format reduces the size of Fedora policy from 7.6 MB to only
>> 3.3 MB (with policy optimization enabled in both cases). With the
>> unconfined module disabled, the size is reduced from 3.3 MB to 2.4 MB.
>>
>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
Thanks, applied.


