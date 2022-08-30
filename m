Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627F3ECAAA1
	for <selinux@archiver.kernel.org>; Tue, 30 Aug 2022 21:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiH3VQW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Aug 2022 17:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiH3VQV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Aug 2022 17:16:21 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C209F80503
        for <selinux@vger.kernel.org>; Tue, 30 Aug 2022 14:16:20 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-11eab59db71so15968793fac.11
        for <selinux@vger.kernel.org>; Tue, 30 Aug 2022 14:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=QIzx4jr+4KB27xfkYmwQ1uaET1dYVTZcRm2qTQ+l5zs=;
        b=8VXnPOAdmSTU8lKGtg1El42/CoEBkWOI1/bj99Lwgd0kMzBuMN4ixRwyqtuefr/9rE
         SKHcG8wKE00HTyqnyjeLIq+5FE5LNmfpDcR8JEt9yxutl5IIYR2kAM1ptmWIKQLmXQZp
         WoFbsQQdv/pHTvRfoWCMOOmt9xJuMS3fxNlFLADjtDPTuft95/nU6DIF/GAqAQTF5BlG
         Tm5WRTSb8mGfDx/bBj6BpcmGhjnC+1Qqe3qrr8UcbIBlxiF9tnz2RJekzxgZs8v56cFj
         w+QKtMmeMYLbugx7I0fDKVrYruuoNl9ZPd6AiShx6hKp7nKp2pVofyIn+b71h8aLtixt
         pG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=QIzx4jr+4KB27xfkYmwQ1uaET1dYVTZcRm2qTQ+l5zs=;
        b=DftQ+PDxcbKcO008mIajbittULyKU0/aW4ezLpyrWeImTyuWMLBg9DImkFYyfqs3fl
         TDNEhIjeSSXnc8T4T8AigJHiGzNsgADa1VXW2jy/NDUOaCJgymdjTrymPCm9jCGcjdjh
         twg8KHlmMcpVhPH4oWQI0fY7eGrKqpFs6SgV5HXGfuClCobxKrqbCq/ttnhSJkff4otR
         Cs6rf5KryWmGz/y4viaFervEQxhPb/aUHj1P3oTNLL4sXQyeETMW7TCqOPZDzxSyMncS
         V51FZTOQjusYt44GNflgvqrLuGw0L/X29iFaIoFP3iQFJVtSPZ5+51JUkMpZqnzuogH+
         IWng==
X-Gm-Message-State: ACgBeo1VCbGepn/Z3HdCnIFUAzhRmRhHmetUJa0bAbt7VsjNV0U073pj
        d0BA4TbTx0pY24l9namA5Iqg26x1xoNjzhbV5N17
X-Google-Smtp-Source: AA6agR4PY0wH+DhCIemu3ZzjKv/dbXTQ97xMbd4BvrFn5a/ljMprJcT5rh3IbTlI8W2uFj1at8XmUb7mEx7H2E+2FoQ=
X-Received: by 2002:a05:6808:bd1:b0:345:da59:d3ae with SMTP id
 o17-20020a0568080bd100b00345da59d3aemr69557oik.136.1661894180151; Tue, 30 Aug
 2022 14:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220830155253.19364-1-cgzones@googlemail.com>
In-Reply-To: <20220830155253.19364-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 30 Aug 2022 17:16:09 -0400
Message-ID: <CAHC9VhRm468n-OEmBztymAi+ADHd1bnKNYXvt2-0S4oNk9OCAw@mail.gmail.com>
Subject: Re: [PATCH] selinux: declare read-only parameters const
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 30, 2022 at 11:53 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Declare ebitmap, mls_level and mls_context parameters const where they
> are only read from.  This allows callers to supply pointers to const
> as arguments and increases readability.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> This patch is similar to userspace commits ("libsepol: mark read-only
> parameters of ebitmap interfaces const") [1] and ("libsepol: mark
> immutable mls and context parameter const") [2].
> Pointers to const are for example used in the (for now userspace only)
> policy validation code.
>
> [1]: https://github.com/SELinuxProject/selinux/commit/390ec54d278a14d9c29=
b80cc4fc5cb9ba504ed13
> [2]: https://github.com/SELinuxProject/selinux/commit/6359946633507db1d98=
b24638cf22eb5afdcd272
> ---
>  security/selinux/ss/context.h   | 17 +++++++++--------
>  security/selinux/ss/ebitmap.c   | 21 +++++++++++----------
>  security/selinux/ss/ebitmap.h   | 18 +++++++++---------
>  security/selinux/ss/mls_types.h |  4 ++--
>  4 files changed, 31 insertions(+), 29 deletions(-)

Merged into selinux/next, thanks!

--=20
paul-moore.com
