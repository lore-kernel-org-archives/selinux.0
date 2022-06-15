Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC7AC43334
	for <selinux@archiver.kernel.org>; Wed, 15 Jun 2022 18:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244809AbiFOSb6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Jun 2022 14:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236325AbiFOSb6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Jun 2022 14:31:58 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A47A393C2
        for <selinux@vger.kernel.org>; Wed, 15 Jun 2022 11:31:57 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id w16so16560925oie.5
        for <selinux@vger.kernel.org>; Wed, 15 Jun 2022 11:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9OdgGwKVZS3NC1R0yK//M02vocQzw7P4tzDCd6kMhZE=;
        b=eUhvaBOQltbuUen6U1mlFnuS+ZDMmvwENAF8Eq2+zZ3gldT/HgmHr2zixuWLp6ct8a
         VWd5TvBhbzU20CZCHAqW4+GwKXIx5yEP1V5kIxCXSbnfsw4gTv2QJMxM9ggPMz7qmh7a
         uxqoH2amenDWYrMueetpr9afDHLYqQKYWk4ewne0EPFYvy3t4qRayheU1vRlAlQJ/sSa
         NDjARyOZQz6uP42QZ5jg4Bo4PgBAD0hw2ui5nflzbGGsHvAbZPcK51mNzbGjky7u4vYz
         PtNxgS2r51TpjU8sba1AeYMMFbwmTn0WcltuEOMN6hNlC5qeyEAwxMo5wb8epnGmM8Fc
         3Jog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9OdgGwKVZS3NC1R0yK//M02vocQzw7P4tzDCd6kMhZE=;
        b=tOrWmxPxzynHUwrcdo1I9qeKShBwfkAgTOouZccCC0KbtkiiUq8ZmtkMVFzxNrgC+P
         5pHHn8O94iRJ60bhyH2LAp5NmSjr5OyhlNWxrggvxGS9Yyl/rBVKR7Hq1HmPYg5oRNoJ
         e8D4E6ooTMmBzFALPU6jNGBWlmObwhxNs2otnnl0B1y18Lc9gF8GDrHMrAeq5JzsumzQ
         9x7Ha0xEquROt7KbafEpI6iPwgP3Y4MqEqAsPxWkPj4OMmD3lXYcOevzbvturs42Pc54
         LBn2trniNzKwPc3GngSlxF9VPZDg2qFRq9kLTV6pkQkVmnRUaaFaD4E4n1KXGpQGUeVp
         MKjw==
X-Gm-Message-State: AJIora/XcE6J5uWfvNa9z0Ia9ffFSG4K/BKj1Pd9lQmdZs0PbE/KSHE4
        AsTRM6n7/w4Yll6VF79Te0kmziNLwux1APiQ153LTJTkPu4=
X-Google-Smtp-Source: AGRyM1vKXWBfXM1UfI8Ghdardso+eO1uT4itLUJFiRd7p0WKMyEznaC6NKV25s3pNEshymh5mHQe6bhKbAJJOHi65wA=
X-Received: by 2002:a05:6808:1805:b0:32e:fa16:59b9 with SMTP id
 bh5-20020a056808180500b0032efa1659b9mr502298oib.205.1655317916316; Wed, 15
 Jun 2022 11:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220610150637.21133-1-cgzones@googlemail.com> <CAP+JOzSYuPN-W-qsruMq1xGjUq-kwf_WXxz0VZAt1q_9sRY5cw@mail.gmail.com>
In-Reply-To: <CAP+JOzSYuPN-W-qsruMq1xGjUq-kwf_WXxz0VZAt1q_9sRY5cw@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Wed, 15 Jun 2022 20:31:45 +0200
Message-ID: <CAJ2a_Df8QY92WENiLMcpiayr_QgJP-pyckb5XWcsb-i8YjhqVA@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: error out if required permission would
 exceed limit
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 15 Jun 2022 at 20:18, James Carter <jwcart2@gmail.com> wrote:
>
> On Fri, Jun 10, 2022 at 11:12 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > A require statement for a class permission adds that permission to the
> > class representation for the current module.  In case the resulting
> > class would have more than the supported amount of 32 permissions
> > assigned the resulting binary module will fail to load at link-time
> > without an informative error message (since [1]).
> >
> > Bail out if adding a permission would result in a class having more the=
n

s/then/than/

> > the supported amount of 32 permissions assigned.
> >
> > [1]: https://github.com/SELinuxProject/selinux/commit/97af65f69644a3233=
d073ae93980a0d2e51f42e1
> >
> > Closes: https://github.com/SELinuxProject/selinux/issues/356
> > Reported-by: Julie Pichon
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
> > ---
> >  checkpolicy/module_compiler.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compile=
r.c
> > index 129650fa..3188af89 100644
> > --- a/checkpolicy/module_compiler.c
> > +++ b/checkpolicy/module_compiler.c
> > @@ -851,6 +851,14 @@ int require_class(int pass)
> >                                 free(perm_id);
> >                                 return -1;
> >                         }
> > +                       if (datum->permissions.nprim >=3D PERM_SYMTAB_S=
IZE) {
> > +                               yyerror2("Class %s would have too many =
permissions "
> > +                                        "to fit in an access vector wi=
th permission %s",
> > +                                        policydbp->p_class_val_to_name=
[datum->s.value - 1],
> > +                                        perm_id);
> > +                               free(perm_id);
> > +                               return -1;
> > +                       }
> >                         allocated =3D 1;
> >                         if ((perm =3D malloc(sizeof(*perm))) =3D=3D NUL=
L) {
> >                                 yyerror("Out of memory!");
> > --
> > 2.36.1
> >
