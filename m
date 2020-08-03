Return-Path: <SRS0=5Yje=BN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5534C433E0
	for <selinux@archiver.kernel.org>; Mon,  3 Aug 2020 13:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D9D2206D7
	for <selinux@archiver.kernel.org>; Mon,  3 Aug 2020 13:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGlSdyt+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgHCN5m (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Aug 2020 09:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgHCN5l (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Aug 2020 09:57:41 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CCEC06174A
        for <selinux@vger.kernel.org>; Mon,  3 Aug 2020 06:57:41 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l64so28341761qkb.8
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2020 06:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=qU2N+I7VcV74ZGq6fQgLFhgYFO2Oxqojc4a2AqUNAUk=;
        b=SGlSdyt+PsoPk5GufIWOlksjJrFBkflqM325EWHuA3xGA4xG1F4GbpVT0tIXkrsNfP
         b49WjIgAxGKlrFCYWEKLKeV330m55xSPkTRfobu/EOmIdiF81RtBIlvTUz7843bMSxl9
         ac9uGv8bEd8wTS/ft37AekWX3py4HZV6joHXoat9jpaDkJBHFbqp/B/SL3zUO79FbD4D
         wwQerby68TQnsrgZBV+JtKUvuAfXvykDIMIrif92dvXeuSgcVYOJQvb35QAf8xDCgn4M
         BgHoFvbhUL5vPu2Y59sqntSAjDF5WlTcJjRxYK6DPzYqXj5vsHNTH22wNKFtzXNvaLRe
         O6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qU2N+I7VcV74ZGq6fQgLFhgYFO2Oxqojc4a2AqUNAUk=;
        b=gkybNKsHD3lZ3T7UhvDCPNln8oZvXeQTUkgBs19eRnKrvGnsFFITYTnnHm+W8w25qZ
         9o6rsjFOuuPnzvTld0ISbXaEHNbcl+wqT9SFfmTb+j6g7+YhBt3Fc60J93VzKvbnPz2z
         OxsTL1JNvqFjUWaRdbBYtxrApdX822Goqcbm2gN6k5iuY2KjbbK7/ybskbdTNCmMMF7S
         FcTU/MyZnWBpG6mgm4Niczz+ZTXUCGBCLHimmGYcKwaTb4ZktulOHmO6TxnJBYgIsnnU
         AYCa7YElCBuy7ZdH0issLg+Dci0+znNfbS9Lldt1TYWOm5ShybjYMP9zNJJ4r9IHRk7Y
         9F6A==
X-Gm-Message-State: AOAM530plQie6Hi/OrsIXp19ZWvJk6feZNMSOgeFBFPcJ0sLmxhi3Yzz
        q6AxvS0Bj2Grn0dTSfpMTXk=
X-Google-Smtp-Source: ABdhPJyVkzCVt3nSct54hQFprvuMS9kl8cBRAyNL/8G3zKee6mc5PzkodQGxHS5XNkvMkb09barIGQ==
X-Received: by 2002:a05:620a:388:: with SMTP id q8mr4652040qkm.98.1596463061013;
        Mon, 03 Aug 2020 06:57:41 -0700 (PDT)
Received: from [192.168.1.190] (pool-96-244-118-111.bltmmd.fios.verizon.net. [96.244.118.111])
        by smtp.gmail.com with ESMTPSA id o21sm19059261qkk.94.2020.08.03.06.57.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 06:57:40 -0700 (PDT)
Subject: Re: [PATCH v6 2/2] libsepol: implement POLICYDB_VERSION_COMP_FTRANS
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>,
        Chris PeBenito <pebenito@ieee.org>,
        Petr Lautrbach <plautrba@redhat.com>
References: <20200731111035.498656-1-omosnace@redhat.com>
 <20200731111035.498656-3-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <5ad008a6-8a98-346b-98a9-77971684c2b6@gmail.com>
Date:   Mon, 3 Aug 2020 09:57:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200731111035.498656-3-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/31/20 7:10 AM, Ondrej Mosnacek wrote:

> Implement a new, more space-efficient form of storing filename
> transitions in the binary policy. The internal structures have already
> been converted to this new representation; this patch just implements
> reading/writing an equivalent representation from/to the binary policy.
>
> This new format reduces the size of Fedora policy from 7.6 MB to only
> 3.3 MB (with policy optimization enabled in both cases). With the
> unconfined module disabled, the size is reduced from 3.3 MB to 2.4 MB.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

