Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FADC433FE
	for <selinux@archiver.kernel.org>; Tue,  9 Nov 2021 15:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AC57610A8
	for <selinux@archiver.kernel.org>; Tue,  9 Nov 2021 15:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbhKIPDI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Nov 2021 10:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234887AbhKIPDH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Nov 2021 10:03:07 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F88AC061766
        for <selinux@vger.kernel.org>; Tue,  9 Nov 2021 07:00:21 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id f4so77525630edx.12
        for <selinux@vger.kernel.org>; Tue, 09 Nov 2021 07:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I6uJhYgaShmiRXF04cLV4RwDYjwYFS466hjaILAfyiA=;
        b=oh++hDJXIKSIULecGTYkYa8h1fLMICBrU3u7wdye21L2M7oIFkBBTlbNEb9A6pnIxr
         Ej8NWLSg0ouGH7XU3FEoVfa0+v5EmeL03EXz0+Rrz1z2hpVhgf9rXYnYQHfO1etJPQJj
         rY8a5oEBslDyPFNnQILPaj89oKk63q+xmT9LmjbTFXTnp7EzPnWJfk/rNWyAtxIzGgDI
         dc89cXmGMAsZ9WLVr5OpJ4I0O4cBR1AEBvtSdH53ZjwopiCVhoXi52n/Qz9dnonMZz/p
         Ajp7ILcPZy1K/oehLxm8oRm36X/Kldl5sktl4wqVH4Dna5Bd1D9oAMN1428zxa0YLdRT
         s6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I6uJhYgaShmiRXF04cLV4RwDYjwYFS466hjaILAfyiA=;
        b=fJtZ/A/XVSQqI37bDCUqhxW+hxHEesLiqyIDAR6gFT4Pbbg6Mz6+WBwuvlHhyjgmXf
         HkJDCIzSESwIV4u9wrl62+hXQJw99dDhmONabtHJ46FdcwAcMjsDCG/hdf58YpmuNVPZ
         +sGgPnqHP2HfOE/J4WVWeRIYlWNswahqkOXaL5caFM66GUkgYnk8UA7SRSiV74EVOcKm
         WCzcZTghvIMcN1kmCBdB2fqtHliRMg4T2EG2VaXS/DBQ5NZklqi9oixUlsgolcGAaNOz
         j8YCAhefuXqTPRAHcRacwKcx9IO4joPF0YagU5wgFCtDwlz6HWgkg1rR6dkThFF6Se5z
         +JeQ==
X-Gm-Message-State: AOAM531inGs2g0+erLkrLf+GHFwI+mW52THal/ZhQys2nS2xVhDp5PQ8
        1P62RhW05eCCL1EAZIpAPArotqEF3E9B/3nYxpMv
X-Google-Smtp-Source: ABdhPJwudea26ElEmhWHO/N5gvNlQtUK8zEtfTsVc1cJaPGB66AF29W0PyBst6prdCXPqh8eM47USKwhnF6BbZHnNQU=
X-Received: by 2002:a17:906:6592:: with SMTP id x18mr10277115ejn.307.1636470019526;
 Tue, 09 Nov 2021 07:00:19 -0800 (PST)
MIME-Version: 1.0
References: <20211104195949.135374-1-omosnace@redhat.com> <20211109062140.2ed84f96@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20211109062140.2ed84f96@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 9 Nov 2021 10:00:08 -0500
Message-ID: <CAHC9VhTVNOUHJp+NbqV5AgtwR6+3V6am0SKGKF0CegsPqjQ8pw@mail.gmail.com>
Subject: Re: [PATCH net] selinux: fix SCTP client peeloff socket labeling
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Xin Long <lucien.xin@gmail.com>, netdev@vger.kernel.org,
        davem@davemloft.net,
        Richard Haines <richard_c_haines@btinternet.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        linux-sctp@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 9, 2021 at 9:21 AM Jakub Kicinski <kuba@kernel.org> wrote:
> On Thu,  4 Nov 2021 20:59:49 +0100 Ondrej Mosnacek wrote:
> > As agreed with Xin Long, I'm posting this fix up instead of him. I am
> > now fairly convinced that this is the right way to deal with the
> > immediate problem of client peeloff socket labeling. I'll work on
> > addressing the side problem regarding selinux_socket_post_create()
> > being called on the peeloff sockets separately.
>
> IIUC Paul would like to see this part to come up in the same series.

Just to reaffirm the IIUC part - yes, your understanding is correct.

-- 
paul moore
www.paul-moore.com
