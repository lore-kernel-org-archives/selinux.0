Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56492EB64DC
	for <selinux@archiver.kernel.org>; Mon, 17 Jul 2023 20:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjGQUWD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Jul 2023 16:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGQUWC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Jul 2023 16:22:02 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D257C136
        for <selinux@vger.kernel.org>; Mon, 17 Jul 2023 13:22:00 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-56661fe27cbso3139914eaf.3
        for <selinux@vger.kernel.org>; Mon, 17 Jul 2023 13:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689625320; x=1692217320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWiE3CkGTDUlj6QCNZoo/WRVOd/qSvpeFml4/GNI1l4=;
        b=Ovnxdri/2azVGDeU5lzqBST5/chKrc8SVm4zfJ1ZIpx7cAbY9GLgYW3jcUkmuzRrXZ
         TJp15XjCoBRSz+SwqIsnVjp7s+32BR8O59aTYfOZafrbnu35Q0rYYdUb/FQoyhPBd5Ec
         8BvNLgEpZKM+tKgA0N1xj77okD4qJYUJ7lngH0Gth/8PUeL8d4VVqoRw7r0RaUPsHH75
         9BAXe19pLao6COeY4AI9UBU6iTPoizkDNxAjwpzHeXNDf3nK6N+XRkZ4pl/75zxhnl5c
         Zo28RFxYzG/kSPE4WRtzNH7qcxvWXo/D1CaGaD3GkTnyjCh8qNvS2fx94AR2ITDOJgVF
         vfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689625320; x=1692217320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWiE3CkGTDUlj6QCNZoo/WRVOd/qSvpeFml4/GNI1l4=;
        b=HQIGQLdSXAky3PsdczZwL7Dp6EMw1JWrKlaW0Fop2YDYFluGzhBYg7SnvVunI1r5XW
         M9yYFOnjuKxrdPAGHOsydOeFKZcXHmw4jERIzVGXI6Sab6hHdCYo9N7yutzmWTn52OdK
         zztcLwg3VFZM+Lfe3HTyOoTnIM5qPtZ+dKZ2zYVtbypsit8vjT8rhzMPN+f5gmottCrr
         AruhlMAnM8QZrtIPldyn9+e12iVyXRXSCpyP0GQUAN4i3L33F7hBI8vshE/NYA7JTdUa
         vxVlOxatFg2dqOZPtwSbsm4P9iHS9ZhtES3vrkJGskctnI8L3x2NYsOvV6CNyIm2gTw7
         G4Ww==
X-Gm-Message-State: ABy/qLZIcByLdUWIBTnPM+2oUdlIIKn7l6ckANPFvhUc3Hb1zm7w4J7z
        fuVch5txgwtdsewem9MH1amnn+RUtwdk3cP1ptTk
X-Google-Smtp-Source: APBJJlFChmprhsDlKpZJ+VXqA7MXSy6U6tiLSsjYS9GovKy+o4Q7IqfJNgEAdV13vfZ/utB4reCljTFOUd7b+KXxjvI=
X-Received: by 2002:a05:6808:140e:b0:3a4:316b:42c7 with SMTP id
 w14-20020a056808140e00b003a4316b42c7mr14345026oiv.2.1689625320107; Mon, 17
 Jul 2023 13:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230706133751.38149-1-cgzones@googlemail.com>
In-Reply-To: <20230706133751.38149-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Jul 2023 16:21:49 -0400
Message-ID: <CAHC9VhQFn1cE39YuXNxssttu1tU6oXWsYjGLSzD496Wa5-Gs5A@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: disable debug functions by default
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 6, 2023 at 9:37=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> avtab_hash_eval() and hashtab_stat() are only used in policydb.c when
> the debug macro DEBUG_HASHES is defined.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/avtab.c   | 2 ++
>  security/selinux/ss/avtab.h   | 3 +++
>  security/selinux/ss/hashtab.c | 3 ++-
>  security/selinux/ss/hashtab.h | 2 ++
>  4 files changed, 9 insertions(+), 1 deletion(-)

This reminds me that I don't really like the "hidden" and kludgy
nature of DEBUG_HASHES.  What if we created a proper SELinux debug
Kconfig flag and used it in place of DEBUG_HASHES?  I'm thinking of
something like this:

config SECURITY_SELINUX_DEBUG
  bool "NSA SELinux kernel debugging support"
  depends on SECURITY_SELINUX
  default n
  help
    This enables debugging code designed to help SELinux kernel developers,
    unless you know what this does in the kernel code you should leave this
    disabled.

... and then we do all of the usual Kconfig triggered dummy funcs,
etc.  Thoughts?

--=20
paul-moore.com
