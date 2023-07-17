Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B19CEB64DC
	for <selinux@archiver.kernel.org>; Mon, 17 Jul 2023 16:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjGQQF7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Jul 2023 12:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjGQQF5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Jul 2023 12:05:57 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052E0F4
        for <selinux@vger.kernel.org>; Mon, 17 Jul 2023 09:05:56 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1b06ea7e7beso3667598fac.0
        for <selinux@vger.kernel.org>; Mon, 17 Jul 2023 09:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689609955; x=1692201955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnFL1AmrlheeY75vh6+ImZJxiaSYl7pddcdn0WO5Ko4=;
        b=Og7E9Y0BGSs9U4HtJuBz92O5FCZFfUD7Bu5iNoKzoW4e25+9ledteWm+0hcBx8wi0N
         MLTdgyZKDLKzLXSEkx/H2jPMhIdp6Ln8Z53FFcHUkwnWwJqEuFhGv/xAHFfPfGrrM/hX
         e3oPeqqIYVt7wXwoRlTz6irQydaBMW31ZC8L7WxMoSTrza1lCy+sBL/JpKXhqW8dMmTZ
         qENiyUXayZPzeKWhrL2Djot02nFtOL3W0fRMKZaSBPV0SGmU7F/UymPu4Pt/7jZxge4t
         rAEJ/G0RSmLjWG60NDnjRuYVQWYC1TJu7xJIv9nA/vndEANaERhcf5R/paJuG7GZmrOV
         qeig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689609955; x=1692201955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wnFL1AmrlheeY75vh6+ImZJxiaSYl7pddcdn0WO5Ko4=;
        b=i7KLUCFQhNjZ28ZYPHnm6Jbf8RWOZ5Fp8a8h2mUm3cytwZwrZOgpI37aLgtN44JHO/
         13ORF0/ztmJ+MV+CLeZAlYcRdtVasEPjs8UbeJefNfbiaGbAqYHjb3ZdtQ1GVeUfuU14
         rzrUTLqqHcncQV/OQJwgDmQkRb9u0pXLfPuJlvmLnDDQZVVCufs/UejuLj3uELcTngDS
         p9sL54IR0CAHzXpidNdUf6uOvAiT728+RPkAdQmCg/M15eOylWI30KrUX4ajl203xNcc
         ciJ9M7uf4ZcEUZCv9CpsJ6FAjUlwt5Ez2DjExjWvl71WssajD08JzQbyPMI57Z2EW0LC
         NzUA==
X-Gm-Message-State: ABy/qLZpHuZ8ml+K4+FazP7oN9OetUgfmcJGZqPfzAes4INj2woBz3wo
        cAAYBLeh5kMIlX5aKrH3jhIm4itZvOub9nOYbzg2
X-Google-Smtp-Source: APBJJlEkQ8jfboNvol4sSiMDOSxb3dzPR8+YbJL6Osnf4gfzCjolPepfBVC3Z8iLIS3Ip+BO+PBLYW9yf+OYEA0pBoc=
X-Received: by 2002:a05:6870:9726:b0:1b0:5bf7:3bb6 with SMTP id
 n38-20020a056870972600b001b05bf73bb6mr13595803oaq.28.1689609955350; Mon, 17
 Jul 2023 09:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689077819.git.gnault@redhat.com> <980e4d705147a44b119fe30565c40e2424dce563.1689077819.git.gnault@redhat.com>
In-Reply-To: <980e4d705147a44b119fe30565c40e2424dce563.1689077819.git.gnault@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Jul 2023 12:05:44 -0400
Message-ID: <CAHC9VhTrfw+5XJ+Fr0dQg0XayiD5x4-SREjpjOGmqroEbScVgw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] security: Constify sk in the sk_getsecid hook.
To:     Guillaume Nault <gnault@redhat.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 11, 2023 at 9:06=E2=80=AFAM Guillaume Nault <gnault@redhat.com>=
 wrote:
>
> The sk_getsecid hook shouldn't need to modify its socket argument.
> Make it const so that callers of security_sk_classify_flow() can use a
> const struct sock *.
>
> Signed-off-by: Guillaume Nault <gnault@redhat.com>
> ---
>  include/linux/lsm_hook_defs.h | 2 +-
>  include/linux/security.h      | 5 +++--
>  security/security.c           | 2 +-
>  security/selinux/hooks.c      | 4 ++--
>  4 files changed, 7 insertions(+), 6 deletions(-)

Thanks Guillaume, this looks good to me.  I had limited network access
last week and was only monitoring my email for urgent issues, but from
what I can tell it looks like this was picked up in the netdev tree so
I'll leave it alone, but if anything changes let me know and I'll
merge it via the LSM tree.

--=20
paul-moore.com
