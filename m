Return-Path: <SRS0=6AtE=B3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC519C433E1
	for <selinux@archiver.kernel.org>; Mon, 17 Aug 2020 15:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CFF62072E
	for <selinux@archiver.kernel.org>; Mon, 17 Aug 2020 15:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwVqgRH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387503AbgHQP54 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730748AbgHQP5d (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Aug 2020 11:57:33 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCD0C061389
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2020 08:57:31 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id e5so12752559qth.5
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2020 08:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=WCdH1RKBa+jnqdv9vsyfL8aLryG68b77WbxDgtwx9l8=;
        b=nwVqgRH+EFKXJU383OKdqaxK/+HDESmQfZDgW3ytyDzUQk2wDqkyniJ0SOkBruExjW
         r7GnrXSlAvxRg8rP41MwuGMEw5aihl8OM3G7irJeC1KD0Kmratw1cmnfZEsBfjfx+kug
         KCFekjufuEE4oKiacB5TYdBfMPQRaDx3cxhIQTbK/L42cVzbIvx6EZOxcIg7jH8M+Iba
         G9CPoj14sak+s9S3DJSflbXruC4PiSwdwcDiQYAaFfjvlTLtqiMznuYOvAffmVcVuMc6
         yEmeTrhzLbkT2Lv7OE17ySOiA+UIMwJg8Nbw1FSRLJSCDyifIUIikcoTBQo2V6we88l3
         iZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WCdH1RKBa+jnqdv9vsyfL8aLryG68b77WbxDgtwx9l8=;
        b=kjb/GRn8XBxRz6teh3nnsDEDH+VF1EvB2OlvSVgI6nAbGM1gX/MOsWwJOGtEXnB2Rc
         aX3MKEdA2sIFsIp5wqsGFHrVkfMTFU1WbRgWCwSVmGBnmJdeU9OwcH0YF/i77+8pX8vE
         /5pBSL8hMUho6suaFQ1lkgszR0btTQ2mIDQEPZJwO0WYhslfrElt5wiWM4x07ME9K6Eh
         6dz8c7O6Jb751Hv1PJXOxMznqgPHaHqQiXb5C/VGifM55u1dtL8gEvB8T4K9BuN3DJ+e
         4P8/cYkbopO58IXpSYhHLHoqUwDwX5LCouMSVzFXcYYCGSrVNkYgORSAd93JO149ZIE0
         loNA==
X-Gm-Message-State: AOAM533R1vkubCULxvj3UaSUXgy72RzU1uVhzPpPj7ydtOATe/JzcaLO
        aGTkuYm3TboX+Aloxt+zKKX5Od4VMHI=
X-Google-Smtp-Source: ABdhPJzG0BwAzmznFjYbXJMTvUwJrSioGmLaT1lbTcwru5KdKZD3L4as1cQ/pwiHid+5MaGGBLCgiQ==
X-Received: by 2002:aed:3b7a:: with SMTP id q55mr14078755qte.78.1597679850916;
        Mon, 17 Aug 2020 08:57:30 -0700 (PDT)
Received: from [192.168.1.190] (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id b23sm19788644qtp.41.2020.08.17.08.57.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 08:57:30 -0700 (PDT)
Subject: Re: [PATCH v5] secilc/docs: document expandtypeattribute
To:     James Carter <jwcart2@gmail.com>,
        Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
References: <CAP+JOzQe8Q0GKtm9aavEQTzFWCT8sUi8shjw=TmgJYm5XkaN_w@mail.gmail.com>
 <20200805194823.492092-1-dominick.grift@defensec.nl>
 <CAP+JOzRy+UxEAjJjuKy3NkDq-1S6tSvjEYAF+TpEcyHpUPPnTw@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <5c31e28b-7e55-9725-4276-d23a816ed3d9@gmail.com>
Date:   Mon, 17 Aug 2020 11:57:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAP+JOzRy+UxEAjJjuKy3NkDq-1S6tSvjEYAF+TpEcyHpUPPnTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/5/20 4:22 PM, James Carter wrote:

> On Wed, Aug 5, 2020 at 3:50 PM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>> This was added for Androids Treble in 2017.
>>
>> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> Acked-by: James Carter <jwcart2@gmail.com>

Applied.


