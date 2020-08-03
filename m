Return-Path: <SRS0=5Yje=BN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898FDC433E0
	for <selinux@archiver.kernel.org>; Mon,  3 Aug 2020 13:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6537A206D7
	for <selinux@archiver.kernel.org>; Mon,  3 Aug 2020 13:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J30bpseP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgHCN5C (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Aug 2020 09:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgHCN5C (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Aug 2020 09:57:02 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401A9C06174A
        for <selinux@vger.kernel.org>; Mon,  3 Aug 2020 06:57:02 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g26so35191353qka.3
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2020 06:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Fvh53iCawb10uW4dtkemiVGO9VggNPF76V4QogT+/1c=;
        b=J30bpsePZoR7p2lcZapJvmJgyRKPHaX0gN+5d2SBZ6uBHI919uvoQM6AT9TfmMDBcV
         gXz1z8g5fbdEB72E7pZV6dgjxYisfKTxrQLVdvvoF6WPyCamm+KDam6PBVn79tlloJiV
         wofL7yvRcUwUaht9d+wH2niMVeZW4HCrGTvsAPCL+DLfl7Fz6Cb4b03kRCM+yvpvd+va
         cOEEh3CbDtx6Tv3+heglkAtR4J2o07Dfg4rytyymTXkBOIoxftqWLjpRLE3VV9IrmaXo
         Xs28o/825i20L538qEJtK32OgV9Txp1iBmHTbMsHmfOePiLN5fVMa648GrK21dGcWXtw
         gU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Fvh53iCawb10uW4dtkemiVGO9VggNPF76V4QogT+/1c=;
        b=lq8SnOk7Ha2wloKO27y4wTRV+bppe2ugsthAcqBIvBu+kD3Q9O/JNUgOwmTj6WTrB+
         QQvLw7fBCW2DhO/UPZeo0rdQ5vjIkH/V7WVfF1MF1MoINuvVlwAEys4KCyaKJ0lWrxm4
         +Y5JJNjC1kz08G/vWRWL1Ih5UytX77TZ/Wp3LSMpZxAN+cHRaGgWC3+m8L/6Xzrb2nG+
         dOZUbC4AxaBqcl9n9LYk1tEmE5ceZva/IcYLXlQ+bDK8q7Ju0pQui9bK3UEjOH/9h0HH
         41dzWZlkzQNYgDpwjGVkiDfPkDerwb+jJerjdqLarpruq9vj4G+zE7iCChXsaG7fAv6y
         fknA==
X-Gm-Message-State: AOAM5323lK94L3m+Tv4uA3p0F8Fjw9dQ4EG3kKs3hWF0DHbWsg1f7+a2
        uxKwAcv22Sfz78nolqWe3ho=
X-Google-Smtp-Source: ABdhPJy53omBgPwFsbah1mV6h6mEPnRF87fRyqGbZXqYQGB1J1oQUVcmrV42BjQ/nPb7ybMaCaCqYQ==
X-Received: by 2002:a37:a756:: with SMTP id q83mr16498159qke.328.1596463019446;
        Mon, 03 Aug 2020 06:56:59 -0700 (PDT)
Received: from [192.168.1.190] (pool-96-244-118-111.bltmmd.fios.verizon.net. [96.244.118.111])
        by smtp.gmail.com with ESMTPSA id 78sm20623060qke.81.2020.08.03.06.56.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 06:56:58 -0700 (PDT)
Subject: Re: [PATCH v6 1/2] libsepol,checkpolicy: optimize storage of filename
 transitions
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>,
        Chris PeBenito <pebenito@ieee.org>,
        Petr Lautrbach <plautrba@redhat.com>
References: <20200731111035.498656-1-omosnace@redhat.com>
 <20200731111035.498656-2-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <e57f8b36-6134-bc19-35a7-f03a6f7b7bb2@gmail.com>
Date:   Mon, 3 Aug 2020 09:56:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200731111035.498656-2-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/31/20 7:10 AM, Ondrej Mosnacek wrote:

> In preparation to support a new policy format with a more optimal
> representation of filename transition rules, this patch applies an
> equivalent change from kernel commit c3a276111ea2 ("selinux: optimize
> storage of filename transitions").
>
> See the kernel commit's description [1] for the rationale behind this
> representation. This change doesn't bring any measurable difference of
> policy build performance (semodule -B) on Fedora.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/commit/?id=c3a276111ea2572399281988b3129683e2a6b60b
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
