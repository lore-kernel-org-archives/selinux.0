Return-Path: <SRS0=TGs9=7I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116C3C433E0
	for <selinux@archiver.kernel.org>; Tue, 26 May 2020 19:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C373B20776
	for <selinux@archiver.kernel.org>; Tue, 26 May 2020 19:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DiPSMUYO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391433AbgEZTUa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 May 2020 15:20:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40758 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2392083AbgEZTM2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 May 2020 15:12:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590520347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4az2Ns9+dWWRUrn/wGIJCYm9Z2ECLPwclq7eITKZ3y8=;
        b=DiPSMUYO5FyFFEJIduiqRW/U4vLy7o2OVh/JNowTnR51BS1Xu8rg9WHmXgFUkqV+XbPNvd
        bFL64eRzy+uiTANKdI1GEXK5fPsUUMq7qPAujHx8l+rxLBNpN5nuVqht+lN4vZCbj5t2rg
        9SAmhH3lMVxjmyZlz+zeoFh20O/vuCE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-gRYx4SMlOnW67oaMtE-7pw-1; Tue, 26 May 2020 15:12:18 -0400
X-MC-Unique: gRYx4SMlOnW67oaMtE-7pw-1
Received: by mail-pl1-f198.google.com with SMTP id d9so16329478pll.12
        for <selinux@vger.kernel.org>; Tue, 26 May 2020 12:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4az2Ns9+dWWRUrn/wGIJCYm9Z2ECLPwclq7eITKZ3y8=;
        b=d07r7mQ53ZRq3bSeL/JSvhA/Er5xnnvnSFve03UMOx91AgesCfQ+Ti36LD/WSRYsT2
         dJCGLyxKBCbWjkoUsOy+e9p4JgJjJD6m2uG8hxP72CP2s1Kl0u2Q/FFAIFuo8btQ1BWP
         7v/lRzZKAME1T9yT93dcwVlmkCr9sWFoZqKtVTD+05A3bJK+Ots6uU3J73tTtX94qA6P
         zRM8FqpuNZTGo/d6SeTP0IYT4+Nq9Wn92rfsGAQNsYxTOoyfnR1+h2GsmNViNwgzszNb
         +NOcb9El8iUagH7FBesEpmkNU9HFJd3GvpmUF6nESWhrs28eh5GPhy1X8RsC57Ai0DcM
         XU2g==
X-Gm-Message-State: AOAM530n/IkEXXFTN0Iwjb7MesRxOh2rkIfyBXlBPEoH2IF5o4bUmtMz
        eYgWqBmMVCY5r0cERjVKXnqPWoIGTOM8newDNFLQWaqKPyX687K+5+xhd+vul24+MfM4NL9rEdq
        FJWuM2e9P1VLCvPCwQgEmhv2SWOXnoEH40A==
X-Received: by 2002:a62:b40b:: with SMTP id h11mr252195pfn.183.1590520337804;
        Tue, 26 May 2020 12:12:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSG4uZsjAL/YS/sT4m9ktkGpQPtbmwHJpi/MLlNPVS4Z/5csXAKlMlEeCmhhEdldfwb1kRTNMe9coVb2kh7V0=
X-Received: by 2002:a62:b40b:: with SMTP id h11mr252183pfn.183.1590520337604;
 Tue, 26 May 2020 12:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200523195130.409607-1-jlebon@redhat.com> <CAFqZXNsuJ7S9zFhHBJNJxUr4=_ZGmKdzTU29PrWRuziMfJJkGQ@mail.gmail.com>
In-Reply-To: <CAFqZXNsuJ7S9zFhHBJNJxUr4=_ZGmKdzTU29PrWRuziMfJJkGQ@mail.gmail.com>
From:   Jonathan Lebon <jlebon@redhat.com>
Date:   Tue, 26 May 2020 15:12:05 -0400
Message-ID: <CACpbjYqBL3a6iVuN9NGzLLHdENC-EXNsNikJZsEhpvCkCGEM2A@mail.gmail.com>
Subject: Re: [PATCH] selinux: allow reading labels before policy is loaded
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 25, 2020 at 1:14 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> I might be missing something, but couldn't you achieve the same by
> simply adding something like this in here:
>
> if (!selinux_initialized(&selinux_state))
>         return -EOPNOTSUPP;
>
> (Or by adding it to the condition above.)
>
> Then you should hit this condition here and be all set:
> https://elixir.bootlin.com/linux/v5.7-rc7/source/fs/xattr.c#L337

Hi Ondrej,

Yes, that looks promising. Two questions with that approach:

1. Is there a concern here with transiently returning -EOPNOTSUPP even
if the SELinux LSM does technically support the inode_getsecurity
hook? I'm thinking of potential corner-cases down the road where
somehow this knowledge is cached.

2. The selinux_inode_getsecurity hook today does somewhat handle the
uninitialized case. It ends up here:

https://elixir.bootlin.com/linux/v5.7-rc7/source/security/selinux/ss/services.c#L1322.

Specifically, it has support for initial SIDs. The patch I wrote
purposely tries to allow falling back to that logic. Is there a
concern with short-circuiting this logic even if the inode SID somehow
isn't SECINITSID_UNLABELED?

