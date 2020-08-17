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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194CDC433DF
	for <selinux@archiver.kernel.org>; Mon, 17 Aug 2020 18:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED7EB20578
	for <selinux@archiver.kernel.org>; Mon, 17 Aug 2020 18:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rU9LoHbl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731445AbgHQSkP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387968AbgHQP6A (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Aug 2020 11:58:00 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD7DC061389
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2020 08:58:00 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id x69so15416080qkb.1
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2020 08:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=v1ikipruLir8f3QQPoH5hDUDdC1rkEYVy0NWJEQ4GxY=;
        b=rU9LoHbl4bg72p/b4N8InrxgGGdfLPw2P2neUcoU1ok6vRL/tSo9kFYT5vqXqPxfGy
         kLZS+fSga5bmbVokE0vqOq0leaUzj1iVXu8HYvJWPKIOcPA3O30QeSuwNoYOn3IvBd9O
         MaNpMc4Jq7zE9IjJ+fb+r2sH5yvj6y4mT+EVySOo3WIFGqHEvknH8b1/pCPxzAUDBaxy
         kKP0BcMvEPb52YmlWwlE0fhqmFMuRDERkmfKBBfTc5IOI51/UcZwmoPT955YjK+6sPx0
         JIJ1jGAojmWYiBUQkFezUzghKHzfPXMmI5eSRLNphiNoZUo8zj84nIFdlnZjwWq86uB5
         0Wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=v1ikipruLir8f3QQPoH5hDUDdC1rkEYVy0NWJEQ4GxY=;
        b=qGkC+Q4FZv9RU6J42GBTjbM4rdyMyEALeJRh9GzrieT17+a2w4aVX0VGJqgcihiyH3
         P2DBuwl+BwLJ98YXng/lWqvrPPB2SzhZik2Z64zRNzx263qYNG6H9I3qJaZI0SdYPkJE
         9wY/VNYHrhIvSoxrHkyNwM35HeUQM5MVIAW4krACjRIdP3mEAx2Kq+AKsKBQ/67gUhhJ
         sNBedZRrcbIK91mJuyqwpn1qK3gLnuDF4k/yVW8+06CSc6QVJaGIKa3Lar6Hdc3cRo91
         Dr7j/EYpxQmq9R7Trpl88fKDH2QFxEkbd4qZpx5J0aMFtSuw+4TLrvGhs/KgF2O5iFRu
         oY9w==
X-Gm-Message-State: AOAM533t5LIzow0DNcp7dx0+7QJ00nE3ArCudlxSVFgvn/ac940Myfz3
        +fl7mitVy9H6OjZ+eOq3lBv9E1Qt75Q=
X-Google-Smtp-Source: ABdhPJxOk+iU1o/4OWBQHqGbB2+fg5wFMNkwo2fiY9TrtRDCMs2W2W0PHpGYAtLU/OFiFKbNhpXHmA==
X-Received: by 2002:a37:9382:: with SMTP id v124mr13085354qkd.391.1597679877095;
        Mon, 17 Aug 2020 08:57:57 -0700 (PDT)
Received: from [192.168.1.190] (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id 20sm18098089qkh.110.2020.08.17.08.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 08:57:56 -0700 (PDT)
Subject: Re: [RFC PATCH v2] fixfiles: correctly restore context of mountpoints
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     bauen1 <j2468h@googlemail.com>, selinux@vger.kernel.org
References: <CAEjxPJ67MVocx8MO51VcpHRmwZzxANa8Q+-iZFgxPrdwXk5i3g@mail.gmail.com>
 <85917790-f0a6-0d57-face-58a6536b1793@gmail.com>
 <c123b432-07e6-c26a-6d08-2b88863c2432@gmail.com>
Message-ID: <d8630b0c-3a43-8295-9903-f21746c37539@gmail.com>
Date:   Mon, 17 Aug 2020 11:57:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c123b432-07e6-c26a-6d08-2b88863c2432@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/7/20 11:05 AM, Stephen Smalley wrote:

> On 8/6/20 10:48 AM, bauen1 wrote:
>
>> By bind mounting every filesystem we want to relabel we can access all
>> files without anything hidden due to active mounts.
>>
>> This comes at the cost of user experience, because setfiles only
>> displays the percentage if no path is given or the path is /
>>
>> Signed-off-by: Jonathan Hettwer <j2468h@gmail.com>
>
> This looks good to me and running fixfiles -vM relabel appeared to 
> work as expected, and a subsequent fixfiles -v relabel didn't show any 
> changes so it seems to yield a consistent result.  Would welcome 
> comments from others though since fixfiles has always been somewhat 
> magical / obscure to me and I am not much of a shell programmer.
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Applied.


