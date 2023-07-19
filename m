Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0920EB64DA
	for <selinux@archiver.kernel.org>; Wed, 19 Jul 2023 08:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjGSITG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jul 2023 04:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGSITF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jul 2023 04:19:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B90D26AD
        for <selinux@vger.kernel.org>; Wed, 19 Jul 2023 01:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689754686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MmVR/bllIudc94xa/30s1JGUSnUJtFWF09nSa97ATdk=;
        b=TkvMVbjFo+6H8ZozwyHZXCW44Y/Hvq1Awj8HnEDATCSDeoQPwp1MtKofuRo/iGMmlyciyK
        K4h+M9dWPzPMOkDF3EJTslfzjGkzNeekdG6bWCPpa6ONmtoxn6BuoVb4aKO3laN5rpYr/7
        kBXKjZ67J3nEv005FRPgiftBnI4s4xA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-o1jUXm7FMCeHQg2c5i7iVQ-1; Wed, 19 Jul 2023 04:18:05 -0400
X-MC-Unique: o1jUXm7FMCeHQg2c5i7iVQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-314256aedcbso3693452f8f.0
        for <selinux@vger.kernel.org>; Wed, 19 Jul 2023 01:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689754684; x=1692346684;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MmVR/bllIudc94xa/30s1JGUSnUJtFWF09nSa97ATdk=;
        b=M9di0VVAsMLGFFumKYK2VVehJ0Mt7SY4b4zri+gJARBFTx54CIJRKq2jMlKHQI0vxY
         F8bRn2An7rfljfFtilmPN/opX/Sc9F60xhNoMAY2MFAfjtvX3J1vFpBGJAHQfnMdDgLY
         zDW6hGQ3VOY2Iqt8VdZgd1uBBL6GeW6/QOCUmc9mNv8BwJiw3BC95PkRM4WzOtc3pkan
         AOKOt/bIfoYnvG4sr5aQ2I2drV8o1K9Q6CumWqto9WbPzJhT1CuZA0NacrGNiLGPMFY2
         pmvJkGGvShfRe5tmp30jucxQxbTe26HxYQXyGqprBnVOp+7FwmPvUU7uhCnOnaAT1MI2
         1Aiw==
X-Gm-Message-State: ABy/qLZ86TecwpYA5ba2nuDW9GWl3BjKaqXJjB+OP1NieQ29VGFrLmLb
        i08zIuP5rWG5dyqfyLu/cithBX0MlkIH5LPcM+DvBk7RHzdcnYUvI2NR2CAje884GvvoBscfpmP
        pj1qTNa5719PIuOm1UA==
X-Received: by 2002:adf:fe49:0:b0:314:1ca4:dbd9 with SMTP id m9-20020adffe49000000b003141ca4dbd9mr13566758wrs.27.1689754683964;
        Wed, 19 Jul 2023 01:18:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF49g1Vta7mjhC1+bf3quUqv/nXAVqJtAkEUDjFA8Ku+wnpSH62a3c0EOossUbfX4CpB0nijg==
X-Received: by 2002:adf:fe49:0:b0:314:1ca4:dbd9 with SMTP id m9-20020adffe49000000b003141ca4dbd9mr13566743wrs.27.1689754683589;
        Wed, 19 Jul 2023 01:18:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:4f00:b030:1632:49f2:63? (p200300cbc74b4f00b030163249f20063.dip0.t-ipconnect.de. [2003:cb:c74b:4f00:b030:1632:49f2:63])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d51ca000000b00314398e4dd4sm4588195wrv.54.2023.07.19.01.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 01:18:03 -0700 (PDT)
Message-ID: <456a78ae-5d7e-9955-5edb-f9f46c22bd75@redhat.com>
Date:   Wed, 19 Jul 2023 10:18:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/4] mm: factor out VMA stack and heap checks
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        selinux@vger.kernel.org,
        =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>
References: <20230719075127.47736-1-wangkefeng.wang@huawei.com>
 <20230719075127.47736-2-wangkefeng.wang@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230719075127.47736-2-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 19.07.23 09:51, Kefeng Wang wrote:
> Factor out VMA stack and heap checks and name them
> vma_is_initial_stack() and vma_is_initial_heap() for
> general use.
> 
> Cc: Christian Göttsche <cgzones@googlemail.com>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---


[...]

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 2dd73e4f3d8e..51f8c573db74 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -822,6 +822,27 @@ static inline bool vma_is_anonymous(struct vm_area_struct *vma)
>   	return !vma->vm_ops;
>   }
>   

Worth adding a similar comment like for vma_is_initial_stack() ?

> +static inline bool vma_is_initial_heap(const struct vm_area_struct *vma)
> +{
> +       return vma->vm_start <= vma->vm_mm->brk &&
> +		vma->vm_end >= vma->vm_mm->start_brk;
> +}
> +
> +/*
> + * Indicate if the VMA is a stack for the given task; for
> + * /proc/PID/maps that is the stack of the main task.
> + */
> +static inline bool vma_is_initial_stack(const struct vm_area_struct *vma)
> +{
> +	/*
> +	 * We make no effort to guess what a given thread considers to be
> +	 * its "stack".  It's not even well-defined for programs written
> +	 * languages like Go.
> +	 */
> +       return vma->vm_start <= vma->vm_mm->start_stack &&
> +	       vma->vm_end >= vma->vm_mm->start_stack;
> +}
> +
>   static inline bool vma_is_temporary_stack(struct vm_area_struct *vma)
>   {
>   	int maybe_stack = vma->vm_flags & (VM_GROWSDOWN | VM_GROWSUP);

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

