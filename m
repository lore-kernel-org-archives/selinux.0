Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2404EB64DA
	for <selinux@archiver.kernel.org>; Wed, 19 Jul 2023 08:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjGSIT3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jul 2023 04:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjGSIT0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jul 2023 04:19:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F8C1BEF
        for <selinux@vger.kernel.org>; Wed, 19 Jul 2023 01:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689754721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WssQg9iV0YySJw5yTj4rTXaeROV2bWX6ZiqkxpcpXZY=;
        b=bNTxbP4XihI0W+CSLZmm2nMGanTeW7pQiYmAsubMcw5Ri9r5r5gzwJ1nfQNhSfAoBHKOty
        3vC6D6wiVHaeaJRIfVAdf7N6aopUF3DHXEqO6/ZanFDB5IkXidD7x+0OhK/6DSxQPIrPt/
        PU0bMHpHLSt78js5WqRPBO0WxuS3Xec=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-rflxWL35N9Og6hFCkcYFNQ-1; Wed, 19 Jul 2023 04:18:40 -0400
X-MC-Unique: rflxWL35N9Og6hFCkcYFNQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fc08d6a40cso37540515e9.0
        for <selinux@vger.kernel.org>; Wed, 19 Jul 2023 01:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689754719; x=1692346719;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WssQg9iV0YySJw5yTj4rTXaeROV2bWX6ZiqkxpcpXZY=;
        b=f7SsUxoXeqwzTIFafuydi2lcR4dDo29X0kUM9axqky1/f9lJd3J/WJukB9s+uxtYOo
         JiE6O1sxKV0X7/kzzaCykLo8dcH+Mea7xJ13DumBoIk7a4BX4oMTiutDBaF9Ut0/yja2
         ZYcU2FRPMJspdO7biaIdql3wIa4s1JiICjrQrQIzaGgcwaxx0z70S0f+jcqF8WdBjPjD
         qK0yGh6Ufci3dPgzCV6KXGbeinivSZhk5MZOtF7eYxDVA3nz2uOH8hup87nDnmgtWhVt
         X+gne92SPB+ZOQbGJbgWkOlB/F5QBKBE11kmA9z+c+nlqkbFPnDQZUxEZC2oSHHPjM9e
         gJYg==
X-Gm-Message-State: ABy/qLY1T4J7fmAxKYzHBiVFHvfli2dXj/fGOHXdltfiJs5T9pi1O9V4
        To4zeK5BzH4NfiheC/a7IuD1F1hfwu2Gf5sod4uykxtZGUtnRXE8niGuzb2XmJFEkd8dr/z8dV9
        3NMdNygxO4ArjzVZ+Iw==
X-Received: by 2002:a05:6000:196c:b0:313:e9d7:108f with SMTP id da12-20020a056000196c00b00313e9d7108fmr1523231wrb.33.1689754719291;
        Wed, 19 Jul 2023 01:18:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG4mVtD6KPNWpna0uoP5njNw9A2AvVcDer/KJcrmJqawn0BMPkdBDdKHedf8gqslDrAWE1usQ==
X-Received: by 2002:a05:6000:196c:b0:313:e9d7:108f with SMTP id da12-20020a056000196c00b00313e9d7108fmr1523206wrb.33.1689754718915;
        Wed, 19 Jul 2023 01:18:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:4f00:b030:1632:49f2:63? (p200300cbc74b4f00b030163249f20063.dip0.t-ipconnect.de. [2003:cb:c74b:4f00:b030:1632:49f2:63])
        by smtp.gmail.com with ESMTPSA id n6-20020a5d67c6000000b0030e5bd253aasm4592215wrw.39.2023.07.19.01.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 01:18:38 -0700 (PDT)
Message-ID: <149bdc44-eba1-1615-dd12-c3c324426dca@redhat.com>
Date:   Wed, 19 Jul 2023 10:18:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/4] drm/amdkfd: use vma_is_initial_stack() and
 vma_is_initial_heap()
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        selinux@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
References: <20230719075127.47736-1-wangkefeng.wang@huawei.com>
 <20230719075127.47736-3-wangkefeng.wang@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230719075127.47736-3-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 19.07.23 09:51, Kefeng Wang wrote:
> Use the helpers to simplify code.
> 
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 5ff1a5a89d96..0b7bfbd0cb66 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2621,10 +2621,7 @@ svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
>   		return -EFAULT;
>   	}
>   
> -	*is_heap_stack = (vma->vm_start <= vma->vm_mm->brk &&
> -			  vma->vm_end >= vma->vm_mm->start_brk) ||
> -			 (vma->vm_start <= vma->vm_mm->start_stack &&
> -			  vma->vm_end >= vma->vm_mm->start_stack);
> +	*is_heap_stack = vma_is_initial_heap(vma) || vma_is_initial_stack(vma);
>   
>   	start_limit = max(vma->vm_start >> PAGE_SHIFT,
>   		      (unsigned long)ALIGN_DOWN(addr, 2UL << 8));

Certainly a valid refactoring, although questionable if such code should 
care about that.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

