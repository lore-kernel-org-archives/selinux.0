Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B18EC072A2
	for <selinux@archiver.kernel.org>; Fri, 17 Nov 2023 15:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjKQP3B (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Nov 2023 10:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjKQP3A (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Nov 2023 10:29:00 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686F0A6
        for <selinux@vger.kernel.org>; Fri, 17 Nov 2023 07:28:57 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507bd64814fso3034632e87.1
        for <selinux@vger.kernel.org>; Fri, 17 Nov 2023 07:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700234935; x=1700839735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDLZhPVMYJxUM0p6kOUJg6S3+sijr1R3pF4GYH4Eoe4=;
        b=VlS0h2FKt2t+uG0Zc7oyGxqcR4YAbREa1BSdEPJj4dy2IxeIG+cLltZru9RbSshpLk
         AHhK9fvT3l95d6oJvfnGPOGvcX2P6CNCr8XSQInRNiGVQazYz50dov0EoPLHagGx1qpj
         m2xLShwyziJNCX4fPX1G+wRXMz2nL4zSYEld+mR8mV1Wb2qWF1Q0ci2xNhxIS+C/66co
         3zw5wwWO8QNWzLzS1Ek6ysutw9plQXILziPb8ZXEumo+dKr0vZWSG5QRdCfsoNbb0QS/
         /IimTP200GmoC8gSeEzV+J5yt8hEkCvKQ9ejZhjaXQQb/YjfbJZzhQ4UEXJMR7El4tus
         sOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700234935; x=1700839735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDLZhPVMYJxUM0p6kOUJg6S3+sijr1R3pF4GYH4Eoe4=;
        b=H4OHdavIsKCKiNq18KR9RHAFpynKwtQ30hKdxf+Qpcs+fYOcDDAcY4fUt7ok99hgZ9
         qQnoPg5VPbo4r4NpbzWNJjncPhjhmGfpOZ8ALaI9PDydy4v3BMWtaDWGiCk6TepJmBW0
         cMV0Ait3ARWlnR0pnXU7QRi0sbRM0nbEGtdaR7WvPUPiBRYWikf8OmW4Sy7nib4UvKia
         24ukTpkIAgJB8EezC1OcTHHZDsSB/f1cdUqxAE249Z4hTZcLfk7PT20MMx+5x++V5sPI
         IAzG1I+QjkXs5ERzseltUjk0d2hEdI9JXh+pUyRs7SgL9mkpHJgMj+WXbKTlBTkIBRu/
         2ZCQ==
X-Gm-Message-State: AOJu0Yy92kFBuncNaoioSt2ZLl1d5WUlg+lKQ3P6ozzhTEcNttvOhCTa
        cprDhxSezaGau8YtvfCrpSRFovzauuNhPLu5aZHnVgDQ
X-Google-Smtp-Source: AGHT+IFO2JX6KnKuEpnb0hSaPTyCGJPwbw5tWDNrTBh5lUEZWUJCw78XHZVC8zPNVZwd6ci0SYUUNnjUSffevPsVvck=
X-Received: by 2002:ac2:4831:0:b0:50a:72e6:96c7 with SMTP id
 17-20020ac24831000000b0050a72e696c7mr4102482lft.3.1700234935295; Fri, 17 Nov
 2023 07:28:55 -0800 (PST)
MIME-Version: 1.0
References: <20230927190021.1164278-1-jwcart2@gmail.com> <20230927190021.1164278-2-jwcart2@gmail.com>
 <4b23ff1b-6b93-f21b-26f4-193efcd9db93@linux.microsoft.com>
 <CAP+JOzQA64fXdpow02ZDy9rcDx48v3jq2VGiSuG4akNVDn3xvQ@mail.gmail.com>
 <2c0b5552-84b8-fe63-6d4c-0a42c7b8a753@linux.microsoft.com> <87a5rxhknz.fsf@redhat.com>
In-Reply-To: <87a5rxhknz.fsf@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 17 Nov 2023 10:29:48 -0500
Message-ID: <CAP+JOzTSnP3xDK5uA2Cy0R2FSWbyb_H9UeNMsKtUKaVXwxL33w@mail.gmail.com>
Subject: Re: [PATCH 1/9] libsepol/cil: Use struct cil_db * instead of void *
To:     Petr Lautrbach <lautrbach@redhat.com>
Cc:     Daniel Burgener <dburgener@linux.microsoft.com>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 1, 2023 at 5:45=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.com=
> wrote:
>
> Daniel Burgener <dburgener@linux.microsoft.com> writes:
>
> > On 9/27/2023 4:41 PM, James Carter wrote:
> >> On Wed, Sep 27, 2023 at 3:27=E2=80=AFPM Daniel Burgener
> >> <dburgener@linux.microsoft.com> wrote:
> >>>
> >>>> @@ -3661,21 +3615,17 @@ static int cil_check_for_bad_inheritance(str=
uct cil_tree_node *node)
> >>>>        return rc;
> >>>>    }
> >>>>
> >>>> -static int __cil_resolve_ast_node(struct cil_tree_node *node, void =
*extra_args)
> >>>> +static int __cil_resolve_ast_node(struct cil_tree_node *node, struc=
t cil_args_resolve *args)
> >>>>    {
> >>>>        int rc =3D SEPOL_OK;
> >>>> -     struct cil_args_resolve *args =3D extra_args;
> >>>> +     struct cil_db *db =3D args->db;
> >>>>        enum cil_pass pass =3D 0;
> >>>>
> >>>> -     if (node =3D=3D NULL || args =3D=3D NULL) {
> >>>> -             goto exit;
> >>>> -     }
> >>>> -
> >>>
> >>> Is deleting the "node =3D=3D NULL" part of this check intended here? =
 It
> >>> seems unrelated to the rest of the commit, and it's not locally obvio=
us
> >>> that it's safe.
> >>
> >> You are right. It is not related to the rest of the commit. There are
> >> a bunch of these sorts of checks that are useless and really annoy me.
> >> The function __cil_resolve_ast_node() is called once from
> >> __cil_resolve_ast_node_helper() and neither node nor args can be NULL.
> >> Since I was changing something nearby, I guess I couldn't resist. I
> >> can leave it in, if people prefer. It doesn't cause any harm, other
> >> than annoying me.
> >>
> >
> > As is is fine by me.  Your explanation makes sense.  I mostly wanted to
> > make sure it was reasoned out rather than an accidental drop, but now
> > that you point it out, it does look impossible for this to be NULL.
> >
> > Reviewed-by: Daniel Burgener <dburgener@linux.microsoft.com>
>
> Acked-by: Petr Lautrbach <lautrbach@redhat.com>
>
>
> Petr
>

I plan on merging this series next week, unless someone objects.
Jim
