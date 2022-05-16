Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E779DC433EF
	for <selinux@archiver.kernel.org>; Mon, 16 May 2022 17:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344212AbiEPRLX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 May 2022 13:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344105AbiEPRK6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 May 2022 13:10:58 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481D62B27E
        for <selinux@vger.kernel.org>; Mon, 16 May 2022 10:10:57 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id m15-20020a9d608f000000b00606a788887aso10482361otj.0
        for <selinux@vger.kernel.org>; Mon, 16 May 2022 10:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6ix8uPGLyp+7LgnZq2LJs/TJAUcCKo3TdVpP2ZXI7Go=;
        b=ZzuvOzuQYRMYspgjReo1LDF6UI50BeIHQjKyBxSkUBzC4ZUcs620tkXkvVsimc9dR9
         Z4OQftdtYrULuRUT1ZdZM0j5/BoVQz7wgf/+jO/7DzhMtmo59wnHfT6Cb75f1Lf/XXVs
         eIK9rHdE09yE6o6KYHK8RbnhgEdHsUBQciW1jkxihK0ZbVBT3EsIgVMo1RidnKRFm6Up
         e4/ipBhlPEI87tGV5Q5zNPGeG3e8SDrUMMzbsha75QBnx5z9jbb3ew/pTnnwZL3Y927j
         gZC162SOUCeW3jUZMy53LRBIFFm2siBEQerXWxzSYZVnvXFrzSafL+9nJU8w1jwZhOCH
         WB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6ix8uPGLyp+7LgnZq2LJs/TJAUcCKo3TdVpP2ZXI7Go=;
        b=h53GTNEXK/eHTdP8fx/XUqK3Sdie++QmaV88bH3ws/VgcRlTUr9qkawBsKIgicJCdA
         EXs3aA8CDGC/wDJUpBZ3TE7xz4EuH1e/+zeH6iLkrudkqD4/p8epposIV4jPO00i4seR
         624CSyU4i/cEQGKF8G7ZGNrHyvPnn19qjJKPJqq9v3h5oHaQeanfXvfZrAub6OyIcf8Y
         ZGHl97VjeM1IrfOk4SeyWKiYsQ1A1666wUSZskUIn9FIR9THpGsbnw2+vJheX3Q/mGIn
         Y7+7ifpen+nemyx4RviKMqhVS/YphQUpU5hvDQn8pK7h8NDGSfiRrnKNUa/Xv5WqN0Yh
         +xTg==
X-Gm-Message-State: AOAM532AVWjgzVO37NAA9WnxBl2GjdDXnSpn0fCRLeoGLamSZS98E0sa
        7bE4eP3sZ4Cciu3YaezGEK+NctjKLNqUyVjvzaI=
X-Google-Smtp-Source: ABdhPJzvlgm2OLFssDmvLf8WFhN5RSrwbGCKdkqYFA3Uhu6/Qbu8iYfVz7Hrn1gFjwYT3dHsHACIARBGTFSYBLImVs4=
X-Received: by 2002:a05:6830:60c:b0:606:3e1:322c with SMTP id
 w12-20020a056830060c00b0060603e1322cmr6554963oti.53.1652721056562; Mon, 16
 May 2022 10:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220505174420.24537-1-cgzones@googlemail.com>
 <20220511184225.218062-1-cgzones@googlemail.com> <20220511184225.218062-2-cgzones@googlemail.com>
 <CAP+JOzQOhjPs+dUmAd0S3JXd4LPn67WNkSddLMc-Z9tZ8cECPw@mail.gmail.com>
In-Reply-To: <CAP+JOzQOhjPs+dUmAd0S3JXd4LPn67WNkSddLMc-Z9tZ8cECPw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 16 May 2022 13:10:45 -0400
Message-ID: <CAP+JOzRCHKsdQHHZpuCt48yTXWg1HuDFENfqFUSKU0m9qVyyhA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] libselinux: restorecon: forward error if not ENOENT
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 12, 2022 at 1:39 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Thu, May 12, 2022 at 5:54 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > selabel_lookup_raw(3) can fail for other reasons than no corresponding
> > context found, e.g. ENOMEM or EINVAL for invalid key or type.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim


> > ---
> >  libselinux/src/selinux_restorecon.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selin=
ux_restorecon.c
> > index c158ead8..42ef30cb 100644
> > --- a/libselinux/src/selinux_restorecon.c
> > +++ b/libselinux/src/selinux_restorecon.c
> > @@ -651,12 +651,16 @@ static int restorecon_sb(const char *pathname, co=
nst struct stat *sb,
> >                                                     sb->st_mode);
> >
> >         if (rc < 0) {
> > -               if (errno =3D=3D ENOENT && flags->warnonnomatch && firs=
t)
> > -                       selinux_log(SELINUX_INFO,
> > -                                   "Warning no default label for %s\n"=
,
> > -                                   lookup_path);
> > +               if (errno =3D=3D ENOENT) {
> > +                       if (flags->warnonnomatch && first)
> > +                               selinux_log(SELINUX_INFO,
> > +                                           "Warning no default label f=
or %s\n",
> > +                                           lookup_path);
> >
> > -               return 0; /* no match, but not an error */
> > +                       return 0; /* no match, but not an error */
> > +               }
> > +
> > +               return -1;
> >         }
> >
> >         if (flags->progress) {
> > --
> > 2.36.1
> >
