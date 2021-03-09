Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FA4C433E0
	for <selinux@archiver.kernel.org>; Tue,  9 Mar 2021 00:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 589456523B
	for <selinux@archiver.kernel.org>; Tue,  9 Mar 2021 00:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhCIAp1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Mar 2021 19:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhCIApO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Mar 2021 19:45:14 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B0DC06175F
        for <selinux@vger.kernel.org>; Mon,  8 Mar 2021 16:45:14 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id p7so12698491eju.6
        for <selinux@vger.kernel.org>; Mon, 08 Mar 2021 16:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dQe1AbiZhxgjMUYYGXlYzpJ40d5EmgWOr56kHx2VkgA=;
        b=kvefS7LytgcL5mOrqW9KkUyo6D+WmvTdbuG5uk5Q98GrqstXZ2L3y5SzNRaQO+GDYQ
         9UelCieNXwKcDfOKYH7R5T82w/mvZgoGnV2615ThR+sJM4DOIwi/aDhGA7HIFUdIjTLn
         Ac0fTnJr1NYpDatykpCgjJVXbLyMM8wuieRiPv0vFwoOGnwhF+G5ItYV2mC54nm+2MH+
         Qrd/5rYfDpE5dhB06qyZfg4XpVhOeYHtbvVd/MgUt5vw9XmgMcA5PaDcNzn3Qr9J30TW
         eL/RAlY0mDgQEYrLiitrSuJucLOUP/hRLd/V1uhF3++o0XzegPqYIcQ3Oe9xvYk8HAHT
         dA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dQe1AbiZhxgjMUYYGXlYzpJ40d5EmgWOr56kHx2VkgA=;
        b=FJtelWvKy0iGy5gWSKpKtVEvSdQf/BzRb1971yMxXnau0dym4bpn+Oc4dqAEQRJIzB
         zZd1oGCYPMdomznnYSxBGdatsBofWz0bBHb8MSyZwZGN4hNSJd2qsSgr6sl1/rrTz5WE
         M0kOydBsnC5ZErisKzU4hW1c+7w6xwDX5gvsnsFfs6O1Ep7Su8cDEwOmxiOII6peGKnJ
         cb7xyqd2wSy3drhVk7SsiC/RaglmcWxggp47KBAs28AAdjy6Y3PTblUKRd1W6mkD8FOW
         S9oiLMtzzwSUFm8kIIxBSk8RJc+oExM/U9NWFTaNK0ZM0qIHP9aq88HNxQpf4cAu1VN4
         AMcQ==
X-Gm-Message-State: AOAM531m3D/yRc6IFpB2f/aJCRK1hrJbbpRVuCKLvjx1UZNWgqUp774E
        ouOmK3XQhW3xCBJIjhgbEHkZvj/sqoFiQ2+YrGNO
X-Google-Smtp-Source: ABdhPJzDPSLT5v0CWN+7wPUx3EFHHng+i6xxLMNsRHv2Dzj+PYBE9FtYWEltECxLGB7vqix+CzY1DxMAv3yAiTYjLy8=
X-Received: by 2002:a17:906:a443:: with SMTP id cb3mr17286079ejb.542.1615250713261;
 Mon, 08 Mar 2021 16:45:13 -0800 (PST)
MIME-Version: 1.0
References: <20210308110338.259868-1-xiong.zhenwu@zte.com.cn>
In-Reply-To: <20210308110338.259868-1-xiong.zhenwu@zte.com.cn>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 8 Mar 2021 19:45:02 -0500
Message-ID: <CAHC9VhTJCMc16j5XTb8cEkgvaLCao0C5s7eT4tp4u6o0Kx6eQQ@mail.gmail.com>
Subject: Re: [PATCH] security/selinux/ss: fix misspellings using codespell tool
To:     menglong8.dong@gmail.com
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, xiong.zhenwu@zte.com.cn,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 8, 2021 at 6:03 AM <menglong8.dong@gmail.com> wrote:
>
> From: Xiong Zhenwu <xiong.zhenwu@zte.com.cn>
>
> A typo is found out by codespell tool in 16th line of hashtab.c
>
> $ codespell ./security/selinux/ss/
> ./hashtab.c:16: rouding  ==> rounding
>
> Fix a typo found by codespell.
>
> Signed-off-by: Xiong Zhenwu <xiong.zhenwu@zte.com.cn>
> ---
>  security/selinux/ss/hashtab.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged, thanks.

-- 
paul moore
www.paul-moore.com
