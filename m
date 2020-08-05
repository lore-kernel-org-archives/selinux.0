Return-Path: <SRS0=Kca8=BP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18C6C433E3
	for <selinux@archiver.kernel.org>; Wed,  5 Aug 2020 16:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FC6C206A2
	for <selinux@archiver.kernel.org>; Wed,  5 Aug 2020 16:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Og9W77/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgHEQ1k (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Aug 2020 12:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgHEQZe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Aug 2020 12:25:34 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5395C001FE2
        for <selinux@vger.kernel.org>; Wed,  5 Aug 2020 09:16:50 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id h7so42156441qkk.7
        for <selinux@vger.kernel.org>; Wed, 05 Aug 2020 09:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=hZMxhqCxm6wTSvpY3IiZ8g67cZvuZBYIdmVenp5gjhY=;
        b=Og9W77/btJd1RzlHBhleJmMgoHGixetABgJWKi6NmRObhCff1WqV6JZTTJmjsEwXyf
         0a+w1c6F+6rot2Y8JdoExhhVXxWd8Uv2WpPtymravNNhOrt1XCELa3BeCtpQMUTLLRlA
         7s8XlYuSzi5Y6z412z1LvJKs7rUOQ7To8Wot6Bd1mf6/Gsog8SdTKa3P2cr+fW+J3RlJ
         nvUKy0+FzmuP0E0g7bJqxLBbRNswc5XgxibRpxUtBg3bdxSwr09dD4T7vU1/jKvuErX9
         yGn4R/XfALuCtoKrLDD8Osqu6thl5+DXi8BfL5Dh0RUm+qR/xRcYatwStkcMXN2o0CsG
         ahCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hZMxhqCxm6wTSvpY3IiZ8g67cZvuZBYIdmVenp5gjhY=;
        b=aNDT5asGCX1GRTID61Uw6y+L2eFHzbe6agsjB5QNnLv4BGzGHqKqzfl92ih6/e4Mfc
         XEKOwRId7rOOFzU9g05Nzd5jaep1Uy08PW1jySg9LQ3SwjMzT8I1j4XKl59hEn69K3TU
         UuuvqaaH7yiP8ljYHgvkROARaTu2LpMXBPJNiRiPW9uvMj+ICGOfYSnCBFm7L/Gw8XdC
         Uw3q9hoDzIM4L7AUsy6KsqOrc7scBkBzxAGZaRSQJYxVTlwstnsfTVJ07ivEdLzJjk/q
         AliDlSjvowIrsIigTdGpfVfaa1+i8IxciL4w6SxD1zCkTp46bdZw9hXb4OP8Xc6Sw8gw
         FyQQ==
X-Gm-Message-State: AOAM533CPxDULeW51cE4nWPn+y6cjw3Ud1iefruMnxxQdRZnJ2ggCEnp
        djvBrTt5VUmz1dY+JJUiTMQ=
X-Google-Smtp-Source: ABdhPJwNd+T+sbRTUvQRObmOVHDkNS4qtgYUp107Y/xyBw0uy6AIXErkcs+wfiTgzayTn+lJDm2L6w==
X-Received: by 2002:a37:a454:: with SMTP id n81mr4223581qke.11.1596644210134;
        Wed, 05 Aug 2020 09:16:50 -0700 (PDT)
Received: from [192.168.1.190] (pool-71-244-252-199.bltmmd.fios.verizon.net. [71.244.252.199])
        by smtp.gmail.com with ESMTPSA id i18sm2317210qtv.39.2020.08.05.09.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 09:16:49 -0700 (PDT)
Subject: Re: [RFC PATCH] selinux: move policy commit after updating selinuxfs
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     paul@paul-moore.com
Cc:     omosnace@redhat.com, selinux@vger.kernel.org,
        dburgener@linux.microsoft.com
References: <20200804135352.5650-1-stephen.smalley.work@gmail.com>
 <a1111b69-23a4-e885-e3a3-aea2613a82d2@gmail.com>
Message-ID: <35ddc017-cac8-3e20-82ee-eb22492452c5@gmail.com>
Date:   Wed, 5 Aug 2020 12:16:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a1111b69-23a4-e885-e3a3-aea2613a82d2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/4/20 4:19 PM, Stephen Smalley wrote:

> Recognizing that re-basing the selinux namespace patches on top of 
> these two patches might be painful, I went ahead and did so; the 
> result can be found here:
>
> https://github.com/stephensmalley/selinux-kernel/tree/working-selinuxns-rebase 
>
>
> The two patches that required manual fix-ups were the first one 
> ("selinux: rename selinux state to ns (namespace)") and the third one 
> ("selinux: dynamically allocate selinux namespace"). The rest re-based 
> without conflicts.  The resulting tree built, booted, passed the 
> selinux-testsuite, and I could successfully follow the instructions to 
> create a new namespace and load a policy into it. As before, the child 
> namespace won't be usable if you switch it to enforcing mode since we 
> haven't yet revived the per-namespace support for inode and superblock 
> security blobs and it is still very unsafe to use in its current form.

Re-based again with the revised version of both patches.  This required 
one additional manual fix-up for "selinux: annotate lockdep for services 
locks" due to conflicting with the restored load_mutex.


