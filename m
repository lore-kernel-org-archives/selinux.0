Return-Path: <SRS0=IDnY=ST=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3767C282DA
	for <selinux@archiver.kernel.org>; Wed, 17 Apr 2019 16:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D43206BA
	for <selinux@archiver.kernel.org>; Wed, 17 Apr 2019 16:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="sn3HNZGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732007AbfDQQCJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:02:09 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40742 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbfDQQCI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Apr 2019 12:02:08 -0400
Received: by mail-lf1-f68.google.com with SMTP id a28so19301635lfo.7
        for <selinux@vger.kernel.org>; Wed, 17 Apr 2019 09:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OcKKfzC2J0NDcwflS6XTHqexTiFB3Fc7D+cB5nxyOT8=;
        b=sn3HNZGuU+1n0ui8wrXjNwQ5EssMxu/nZp0Kn707xObRFiGVW06PE2T+RBNtEIXFZ/
         Oo+SAsT7lHtQx3OBDOnVL8OqT+YvSOrPouV9oak2EyZPFWKWTB2dwk7m+oQub58bTx47
         46KCuikeHVrvAwtOn3elT2EmTOjYF0hJ5PtQCmRX6URFtjItoUC5+2Ko0vsNNKB1+PH8
         O4Z9VJS2k00FEI6UNUV8C+E1Pc1jOqNCdRVm1iZYIW6r+fhtGqejjYKoqFa9Xy+sgey5
         W9bZhVU8wtQRBkvqPTSmTxXsPE2cQKQe8qxc50BT4oWepMNnSXg5u+xyCDutO0J879Fo
         c8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OcKKfzC2J0NDcwflS6XTHqexTiFB3Fc7D+cB5nxyOT8=;
        b=jYRLkE0LM8eZO+CDoZBt0kMdglwcVq058dQeGKjvEsCcD4IufAQPoOZ4MaX5GOqGAj
         Ofe3mMz9egzKckeAjTD9ueyY8y8jyLzNYvrs62hdSeuLZa0xewyDW5W14BXxilwWSOyc
         cl4Sa+tuoXUGzPveF+0qk/8B57nxsyKS2yfA4ct1VEmxxHhEmZM9YwAx2YmNu0E8jZY0
         Lu6QArH1rxXVSlMz3lzhJaEwXFxrxiEF8lQHlfGcPrFGCBizhRtj1LPgu2Jnu9HrbWG4
         S+InmtIn17fi2vVrZMejEwy30xAFoEouxwZwHwy7kbZjQbgfSgJkpwhYjNi8jYB5WKMk
         Kdgw==
X-Gm-Message-State: APjAAAUTQ73aOvSSSN3cYzw/HX8/AcEA/EI/+GtVEW17hIz1QQYEuWF6
        fszP2pZ681K/7sRxfcd/z9/bGYOxkxuFL1KXh4Dg
X-Google-Smtp-Source: APXvYqxp+A+CUl2J0hnd5DH6YQJkejwR1VjOHah5omnN7xiz8Dsa4Jx/sugXSXJgK5o2Y1oWXsipc8exydkrnZ5caGE=
X-Received: by 2002:a19:760f:: with SMTP id c15mr25571120lff.105.1555516926922;
 Wed, 17 Apr 2019 09:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190411123103.23485-1-richard_c_haines@btinternet.com>
In-Reply-To: <20190411123103.23485-1-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 17 Apr 2019 12:01:55 -0400
Message-ID: <CAHC9VhTk05_vROpqZJ4rvJdv=Fexnb9Z17vob0H-ZPg8DHRnSQ@mail.gmail.com>
Subject: Re: [PATCH] selinux testsuite: Do not build SCTP unless kernel support
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 11, 2019 at 8:31 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> Do not build/run SCTP tests unless the kernel is 4.20.17 or
> greater as they support SELinux SCTP.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  tests/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tests/Makefile b/tests/Makefile
> index fb6de5c..1bd643e 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -24,8 +24,10 @@ SUBDIRS += extended_socket_class
>  endif
>
>  ifeq ($(shell grep -q corenet_sctp_bind_all_nodes $(POLDEV)/include/kernel/corenetwork.if && grep -q 1 /sys/fs/selinux/policy_capabilities/extended_socket_class && echo true),true)
> +ifneq ($(shell ./kvercmp $$(uname -r) 4.20.17),-1)

Technically we shipped the SELinux/SCTP support before v4.20.17, but
v4.20 does have some important fixes so I think this is okay.

Merged, thanks.

>  SUBDIRS += sctp
>  endif
> +endif
>
>  ifeq ($(shell grep -q netlink_iscsi_socket $(POLDEV)/include/support/all_perms.spt && echo true),true)
>  SUBDIRS += netlink_socket
> --
> 2.20.1

-- 
paul moore
www.paul-moore.com
