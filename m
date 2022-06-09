Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C8DC433EF
	for <selinux@archiver.kernel.org>; Thu,  9 Jun 2022 08:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiFII1j (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jun 2022 04:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFII1h (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Jun 2022 04:27:37 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF6214D7AD
        for <selinux@vger.kernel.org>; Thu,  9 Jun 2022 01:27:33 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id g13-20020a9d6b0d000000b0060b13026e0dso16844061otp.8
        for <selinux@vger.kernel.org>; Thu, 09 Jun 2022 01:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sSZ1ebQqwmnHo/5tp3l4c21li7cAfjvbiRqKDvA70qI=;
        b=oGLlEyjkt8sxzta4f13dl8bnxFmU8+UdWgehxFFzARiXIxAUC1TCG8wc06t0kL2SjN
         hq5TIHTHzwuxth8I/VQyJKUksaUFX/O3LaMf14tu7sfWXP236ip/j4Jl14uhH5vKEtQv
         A5Lq6rfKiJNT1Ob57qCCnJ6ycOGD+vfrtJeji5vpZcYQ4C8IHbDbS3uSKxikXGJnMjhZ
         xLd5jNfEi+O9wlFnsVugha46ZNRU++9Vu3xlxU9E5SVwDUcVuf1DgKKUyEvKTBNe/Klg
         8R0OGw5XPPrgTkmvHZ0hMgDux9Qkv0/WbaYZ/vnEiyRY3iHaZLfqWrdYCAYSeAHX9WMP
         mKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sSZ1ebQqwmnHo/5tp3l4c21li7cAfjvbiRqKDvA70qI=;
        b=UrXujnvAIGH+8qrqDPn4TnS2LtQA2ZBdTj8VW2NyPD7aFxZpBO4jrg7kbYWNxxZqSu
         BBjsyW8GGU3sH5x8lZgwyxpVYQt1konqtmrrUvWPYd+m1nzdQvYFDFcWxtRJUgwWmmgf
         g8WdI8cpgiEa1NQoc0rwPjSV3P/FR5r3tDG4n7M63VOmMy/b7oo8Wxn6oVjIlWaJG3td
         Odva5agVBFHKHBEIvUCqJuB/4w1eG2xYPgdzusF9pWiiP4Is8pkyNcfOtUDs58V6PawZ
         wCgYOqfAJiQ3H7Ozca+uigr6xzdAgWxDGBmoLXi69mwxlVnZ0Dj5kT5jxCegL02rU8B2
         23nw==
X-Gm-Message-State: AOAM5305owlr4FoNe0d2Van6liePX/idXPQY9H4zEC/ZPDntqbHcBo/2
        EOOvCje3ZZlsD4Arv7p8L1pEvONbXdvJxJdeOZI=
X-Google-Smtp-Source: ABdhPJxvx2ASZ2uZrVb7YRUDH/PW0TNuAGQS5cLjX3Rr3YwyCCm5LXWvYFkwHVQbUEvszK/i7Q8MzpBPZV+Cz04dHVw=
X-Received: by 2002:a9d:6a83:0:b0:60b:ebf5:1c3a with SMTP id
 l3-20020a9d6a83000000b0060bebf51c3amr10817206otq.56.1654763253277; Thu, 09
 Jun 2022 01:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220607150145.29757-1-cgzones@googlemail.com> <CAJfZ7==wRe=5QXr=g4VGwudXGiiWLdJeiyP9kM97TZS=D=nySg@mail.gmail.com>
In-Reply-To: <CAJfZ7==wRe=5QXr=g4VGwudXGiiWLdJeiyP9kM97TZS=D=nySg@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Thu, 9 Jun 2022 10:27:22 +0200
Message-ID: <CAJ2a_DddXxaKvRDHPTe6mG_mTWZ+HfVV122URY+_XqvMzGTkKQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: fix validation of user declarations in modules
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>, bauen1 <j2468h@gmail.com>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 8 Jun 2022 at 21:16, Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Tue, Jun 7, 2022 at 5:02 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Users are allowed to be declared in modules. Modules do not get expande=
d
> > leaving the `struct user_datum` members `exp_range` and `exp_dfltlevel`
> > empty.
> > Do no validate the expanded range and level for modular polices.
> >
> > Reported-by: bauen1 <j2468h@gmail.com>
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  libsepol/src/policydb_validate.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_v=
alidate.c
> > index da18282b..99d4eb7f 100644
> > --- a/libsepol/src/policydb_validate.c
> > +++ b/libsepol/src/policydb_validate.c
> > @@ -18,7 +18,7 @@ typedef struct validate {
> >  typedef struct map_arg {
> >         validate_t *flavors;
> >         sepol_handle_t *handle;
> > -       int mls;
> > +       policydb_t *policy;
> >  } map_arg_t;
>
> Hello,
> As the policy is not modified, could this pointer be "const policydb_t
> *policy;"? (And the last parameter of validate_user_datum be "const
> policydb_t *p"). On the other hand, as policydb_validate.c does not
> use any const pointer, feel free to disregard my comment.
>

Since policydb_validate.c does not use const pointer at all yet I
followed that style.
I might prepare a patch to constify all pointers and refactor the
logging mechanism,
since I like to add validation into the kernel to avoid crashes like
[1], especially
if SELinux gets namespace support [2].


[1]: https://github.com/SELinuxProject/selinux-testsuite/issues/76
[2]: https://patchwork.kernel.org/project/selinux/list/?series=3D632975

> This patch nevertheless looks good to me too.
> Thanks!
> Nicolas
>
