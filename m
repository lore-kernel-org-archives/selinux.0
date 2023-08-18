Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C69AC77B7C
	for <selinux@archiver.kernel.org>; Fri, 18 Aug 2023 16:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378557AbjHRQZx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Aug 2023 12:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378708AbjHRQZa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Aug 2023 12:25:30 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D564483
        for <selinux@vger.kernel.org>; Fri, 18 Aug 2023 09:25:24 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-58419517920so11052277b3.0
        for <selinux@vger.kernel.org>; Fri, 18 Aug 2023 09:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1692375924; x=1692980724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucUz8MLzQcOIBd0t0XomfDYuKop1ElGaSovik3pwpoQ=;
        b=ahNIeC5eO83tE7Mkt9NbXxeJBGAO+XWYjqJDEtrfQQbPCmx8AUSEAFnurG699BN40Z
         TmciiODTWlI9qkyzdtkEpUYVeE+rzscA6taQe3QG6KKcvziEAWUmRNy+U/T5kWB9Yt4d
         bT3odde1G8BCNQANIwQ+syDE9IQ1nRJqAND7XlRNd8V+KaZ3ebkOLV6WKJS4T2eki7Dx
         w4Kyc0sFmYkdbimeVr6b/Dt3c0SSb++Hcu37HH1ZOFhGjWVOWDIpwRZBEdVDYx3sKztH
         b3s0zFlGMEXK3fD6g0eFkk1hqQnIRHVXtwUfHVYA9+GR6kFWW8ASeOn6+kQZkF81tCW9
         hTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692375924; x=1692980724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucUz8MLzQcOIBd0t0XomfDYuKop1ElGaSovik3pwpoQ=;
        b=BjcuDPx3rVLaGXUGGVnth524H3KInpfltXthbOk910n4g7fvKUECY34B4h2WX6HC1e
         q4s2tNi1YlypeK5crCKEhNDSCCCukjW70/G5c0deNvk30Q3qKP7PvxNGzuVgdgcI6aZW
         76MDnl1JtPB5ZDk1UrQEhtU+Tr1n4ylYzA/noeMYzLddE7dPAaF8dxJXQSjWi29gUPhM
         f7CuQh/qRIsurtdBrbQtUT2kCKM++we6Hb/JMQkuEEtGHE/NgEiT+C5kDqK3SqXqYWD4
         6helo3jsj7M/VVMdmZyJTaAhaJwhHb8qbhtb0nWxsVGF5DK99bRm3vGAt2hffK34pies
         I/VA==
X-Gm-Message-State: AOJu0Yzn43c/Jd8Z4bJKZHdLwQBkTO875P+YKkfdyYAbx1hP6jsaq8lQ
        bcd/4E4cxqe+EJQqp7vfWM0sHPgBm+XxwKM+/U+L
X-Google-Smtp-Source: AGHT+IGGZmIBmOhrdBZxCN6SiC6TfpQQSM5iqw9/0scHGRqppWqbVIg9L05WNia94iikezIgrRH2Nmc2C5JdLAKlSQk=
X-Received: by 2002:a81:9e4d:0:b0:589:d617:e7c4 with SMTP id
 n13-20020a819e4d000000b00589d617e7c4mr1442370ywj.16.1692375923646; Fri, 18
 Aug 2023 09:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230817202210.never.014-kees@kernel.org>
In-Reply-To: <20230817202210.never.014-kees@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 18 Aug 2023 12:25:12 -0400
Message-ID: <CAHC9VhR-vxsaR7deTQ+zzVP9W2uSupz4ucf8p+tt0e730qbZ1g@mail.gmail.com>
Subject: Re: [PATCH] selinux: Annotate struct sidtab_str_cache with __counted_by
To:     Kees Cook <keescook@chromium.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "GONG, Ruiqi" <gongruiqi1@huawei.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 17, 2023 at 4:22=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> Prepare for the coming implementation by GCC and Clang of the __counted_b=
y
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUND=
S
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> As found with Coccinelle[1], add __counted_by for struct sidtab_str_cache=
.
>
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/c=
ounted_by.cocci
>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> Cc: Eric Paris <eparis@parisplace.org>
> Cc: Ondrej Mosnacek <omosnace@redhat.com>
> Cc: selinux@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  security/selinux/ss/sidtab.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This also looks good to me, but similarly to the audit patch, since we
are at -rc6 I'm going to wait to merge this until after the merge
window.  I'll send a follow up email once it's merged.

Thanks.

> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index d8ead463b8df..732fd8e22a12 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -25,7 +25,7 @@ struct sidtab_str_cache {
>         struct list_head lru_member;
>         struct sidtab_entry *parent;
>         u32 len;
> -       char str[];
> +       char str[] __counted_by(len);
>  };
>
>  #define index_to_sid(index) ((index) + SECINITSID_NUM + 1)
> --
> 2.34.1

--=20
paul-moore.com
