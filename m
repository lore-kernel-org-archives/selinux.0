Return-Path: <SRS0=rjXy=CC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DADC433E3
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 13:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E560C2078D
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 13:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="wud7QFiz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgHXNUe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Aug 2020 09:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgHXNU3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Aug 2020 09:20:29 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150BEC061573
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 06:20:29 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id b2so8016441edw.5
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 06:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ovutwx82aMiCT5WAboMDBPjEdONVTMYW2cB4po8ZcNg=;
        b=wud7QFiz7lyZDqPxWQS1LI9uClSoHD2tnWJFZhMv8qTdTW6x0X/Av+2iXo7HkztPmh
         fEbi2mHge49FELsA4RK2bp8L4tJila6XnRSEcc08EPhKEX1qMNnfU75/HFOng9Ak8Dl7
         kmeUrYNQVnHe/BiLWc5iGAzQmmomDAJyApCVw+UAwDceec/QBS/AVwhQhjwl/Njvuj9L
         Po/4gBTwJuB8xTMWAdMZwN8yH5hV0FzEqBcU8GxF2dc4+GC7OoHbZlPmGNilQlxzmoDX
         4CZQoK2WJgL5p5DGhvBWBAuk4yv/XeVLUKlFoYxE52WYaXesIVCV0guPeuq+TlJz9Q+x
         5XMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ovutwx82aMiCT5WAboMDBPjEdONVTMYW2cB4po8ZcNg=;
        b=r92jejTKBuWhaW069bUf3BHSjN5Gtm/76Nnzy+RJQx1EYbCZ0K2yaI0ZuqpQ8EDdCL
         iz1f+Y3U7IgE/TlZ4XAS1EsUeSBvAiw6l9Y44ogs5YN/wsmZYZ/QElJIq0i4faXSllZS
         W9jqUsl57GJ2EwS3MTE7fy6n6Uz1JQK1iQkbNMAxSYGX3100LA3nmrEesUS42Mmx46v9
         rHUc9vDmoY2Vxk6uCzkV04GoeJZNjBTotyOpv9K1F171q4PoGyP05w4VfKa/PS1vaQal
         g+BraeUNVghbBU/7xceQAKuzvEsiJt2xsONjfTzUav8Gq0PXo4eic5Mk3h5T/w0PfzQY
         r1mQ==
X-Gm-Message-State: AOAM531VwxcLXz8RP67yI9a2skFZG7vNEN8dYeCujQWDIJJtfqqsGHGU
        862S6JQ/0q/a+MV6b01zKaZuovPXijUB2Z4vCeZ/o+PyIrBB
X-Google-Smtp-Source: ABdhPJy5hyWlJ/fwKTTG0g3OdIQVmfXoJa5BTayAOyU2347ZXRW7Xt+fI/pQQzTSaFbXfWwsdRjxD2XiNnv1O8b3de0=
X-Received: by 2002:aa7:de8f:: with SMTP id j15mr5160071edv.135.1598275227717;
 Mon, 24 Aug 2020 06:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200807151722.12114-1-richard_c_haines@btinternet.com>
In-Reply-To: <20200807151722.12114-1-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 24 Aug 2020 09:20:16 -0400
Message-ID: <CAHC9VhScvQ+ueA0bwjstrivqMGZV--fD3MxFcJOBpeGZvu3dxA@mail.gmail.com>
Subject: Re: [PATCH] selinux-notebook: kernel_policy_language.md convert to markdown
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Aug 7, 2020 at 11:17 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> Add a TOC to aid navigation and convert HTML tables to either pipe tables
> or markdown unordered lists.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  src/kernel_policy_language.md | 1016 ++++++---------------------------
>  1 file changed, 182 insertions(+), 834 deletions(-)

Merged, thanks for your patience!

-- 
paul moore
www.paul-moore.com
