Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F0BC19F2D
	for <selinux@archiver.kernel.org>; Tue,  9 Aug 2022 15:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbiHIPUP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Aug 2022 11:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243505AbiHIPUO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Aug 2022 11:20:14 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A04F24E
        for <selinux@vger.kernel.org>; Tue,  9 Aug 2022 08:20:13 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id cm4-20020a056830650400b0063675a4dd74so8680635otb.10
        for <selinux@vger.kernel.org>; Tue, 09 Aug 2022 08:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=iFmtaFePY+rmFXsEgy6wcWH69Z8ztS1ZF83wzsb5ZNg=;
        b=F6NIKIpzA5HTxrn4l52Ij4m9jqNMnx1KGnsRYJdQ8Mmvwgs8tJ2m92NU4zL9vRoyRY
         w9c+R6xNmFRPglqgB6w8DgooCsN3pCt3AoGZaQeROThdw88qvMW7kW9txc394J6ehvd2
         Xn4l2YisjsBwHzE5YsBpFYbTN8jO09nTS85VlVBh4vS1wzCKEkwb8u5AYVwbI4RbWo5m
         2NGeJsOrMGEWALzHVzomQksf7qzqZ7r4fquUezz3X030WksbiCv7ffJTMHY0IjNeqx/X
         P0iaPy8/ISjk0GoLdXrHDZBjmZO17+WRB5XciZ/U7uQteTQI7al6PB3YmeOzqFWHkoTX
         M/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=iFmtaFePY+rmFXsEgy6wcWH69Z8ztS1ZF83wzsb5ZNg=;
        b=AnPAlVooVK6mwEmF0OJepE1EwW7whKzx3PRAISKKc7U561MMQR0BAlP0zPhkrrDKtZ
         kU1HukX95pWPvN+NZ9sKdlAJab8GBEBgf2tR2YmowA0Pd79gqgF9ObbueYhIFrZ89St7
         lLsRlGplV/uqi2/PP/YvQsk72e9RTjqks7seXRsZ1JGcYYIp1dJ6B2+s7PDFvzf2tQTc
         aPy+mpeLRZ4XLkNZ36EBhaNAK2hGd1ML+e5HVTOGnTCcQVafl64jeVu9eD10NmZ9M+zR
         A1npgmjFDEuuUs9G0iVGbGQFVBkGEwnWuao64q3zXtAMugyTZFYIGMWE6fhoNRV2JFqx
         CTVw==
X-Gm-Message-State: ACgBeo3/16qV6OtKy72O4/Vc0zqpDQ0kk/YLk8dqTypIeICcuBpnWlJl
        jjndVNpDLQAFHtyrvIUM0m5MmJVBAOPQaLx1VXosaAlQ
X-Google-Smtp-Source: AA6agR5rfAhahWDj8KUTJXcXSzluSOsyfa9h3dQbM4ywwTZlyV89bhLPQlASnZTqvjLDVHSpcaCgtIMHNW3lcn5jcSw=
X-Received: by 2002:a05:6830:61cd:b0:618:d560:b787 with SMTP id
 cc13-20020a05683061cd00b00618d560b787mr9024516otb.154.1660058412411; Tue, 09
 Aug 2022 08:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220721152444.31690-1-cgzones@googlemail.com> <CAP+JOzR2Y90=v6WomOi=LRboCTAVqVJ79Ae6VArtSQEL_y8WwA@mail.gmail.com>
In-Reply-To: <CAP+JOzR2Y90=v6WomOi=LRboCTAVqVJ79Ae6VArtSQEL_y8WwA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 9 Aug 2022 11:20:01 -0400
Message-ID: <CAP+JOzTb=FH7DuuySxDsTzbXUsS3opJCQObgW5wP8Cw7_76yJA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] libsepol: rename validate_policydb to policydb_validate
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 1, 2022 at 2:48 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Thu, Jul 21, 2022 at 11:34 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Most global functions operating on a policy database use policydb as
> > prefix.
> >
> > Since this function is not exported there should not be any external
> > use.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For this series:
> Acked-by: James Carter <jwcart2@gmail.com>
>

This series has been merged.
Thanks,
Jim

>
> > ---
> >  libsepol/src/policydb.c          | 2 +-
> >  libsepol/src/policydb_validate.c | 2 +-
> >  libsepol/src/policydb_validate.h | 2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> > index fc260eb6..8a65df05 100644
> > --- a/libsepol/src/policydb.c
> > +++ b/libsepol/src/policydb.c
> > @@ -4570,7 +4570,7 @@ int policydb_read(policydb_t * p, struct policy_f=
ile *fp, unsigned verbose)
> >                 }
> >         }
> >
> > -       if (validate_policydb(fp->handle, p))
> > +       if (policydb_validate(fp->handle, p))
> >                 goto bad;
> >
> >         return POLICYDB_SUCCESS;
> > diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_v=
alidate.c
> > index 99d4eb7f..e1dad236 100644
> > --- a/libsepol/src/policydb_validate.c
> > +++ b/libsepol/src/policydb_validate.c
> > @@ -1330,7 +1330,7 @@ static void validate_array_destroy(validate_t fla=
vors[])
> >  /*
> >   * Validate policydb
> >   */
> > -int validate_policydb(sepol_handle_t *handle, policydb_t *p)
> > +int policydb_validate(sepol_handle_t *handle, policydb_t *p)
> >  {
> >         validate_t flavors[SYM_NUM] =3D {};
> >
> > diff --git a/libsepol/src/policydb_validate.h b/libsepol/src/policydb_v=
alidate.h
> > index d9f7229b..b7f9f191 100644
> > --- a/libsepol/src/policydb_validate.h
> > +++ b/libsepol/src/policydb_validate.h
> > @@ -4,4 +4,4 @@
> >  #include <sepol/policydb/policydb.h>
> >
> >  int value_isvalid(uint32_t value, uint32_t nprim);
> > -int validate_policydb(sepol_handle_t *handle, policydb_t *p);
> > +int policydb_validate(sepol_handle_t *handle, policydb_t *p);
> > --
> > 2.36.1
> >
