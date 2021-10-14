Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02902C433EF
	for <selinux@archiver.kernel.org>; Thu, 14 Oct 2021 14:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D083F610F9
	for <selinux@archiver.kernel.org>; Thu, 14 Oct 2021 14:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhJNONI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Oct 2021 10:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhJNONI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Oct 2021 10:13:08 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2D3C061570
        for <selinux@vger.kernel.org>; Thu, 14 Oct 2021 07:11:03 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id q129so8707442oib.0
        for <selinux@vger.kernel.org>; Thu, 14 Oct 2021 07:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GAPwSrMlgstEqnt4oWmCp73phbCZIxt636RYBd96XCs=;
        b=UlUGRlgxdl9UfE/CcaDPUp+946caiKvNqM30exkpm5LMoUKMBMtR2n4aOzVSDM9AL2
         iO0TTigP+ggNTlcaqJ72gpcgv6HbSWhY/8py+Q0uAOmJ4UtSho+e4kKeEfc7VawjHBHm
         /FCG7TwTSwQWJWWDW3n3tVp2HDVcLkAd4WkLsDJsbkumg0nbzli+20U0Wbjd+SW3ScJY
         2VWWjF8amChH4F9cXMx81+weHnttYRSPWcQDSZtgKURnTcmNxkcvFIRleqywXZgRNDmq
         /AG81rGCHLEWMyl7Ow+wL4slo/xtiNyffThqKtAYlRnXjm0NGvSFMuYm/B0ueUWzfHM1
         3oEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GAPwSrMlgstEqnt4oWmCp73phbCZIxt636RYBd96XCs=;
        b=QWsIra74mYCPoqTg0fsO9C/rGmxYwIr00K42EKi7M0Pam0SpUL+jD/I4z/XTEEDTQ0
         lAPfUsZgOKYHXm+FmfYCe59puJIOPmJz5ldCryYJIYTcLKbNAz55UfXCgzwjIxP7rbZ7
         92RFAbD0C8JSuDBjkL1j5S5VbpTeJopO2JbevvcXz+i2a05YzvDQdNesJmXGeinWAHYq
         6fUvQWplKPqZVB9L4D3P+6NZPebjSJeHHuGukhOKJCoMJMg0nEMTn4KyDlxBoILmfMJL
         xLE7cEL0K4CuJ5lene/5j0D/0qefTVufI0Jzhp6NOuMZWdvpJmu2T8iTXfHBGOPB6OdX
         pa5w==
X-Gm-Message-State: AOAM531P6j/0VT9dlK8IGVi2Kg7hlXcvqC29/yIfLoTGGgd5PmpJQLR5
        BYB0Wg8v9Wm9yp0XsbbWH50enXbOX9u9QIm/1f4=
X-Google-Smtp-Source: ABdhPJzlrk4LNsYq/bijP7sxHUEIdQ6oyonwKrxqjjbgi5FLSafMTo++F6lDAm0emdyLvtxWfAaJxVMuLmx18aNK43Y=
X-Received: by 2002:a05:6808:545:: with SMTP id i5mr4132683oig.16.1634220662867;
 Thu, 14 Oct 2021 07:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211011162533.53404-1-cgzones@googlemail.com> <20211011162533.53404-30-cgzones@googlemail.com>
In-Reply-To: <20211011162533.53404-30-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 14 Oct 2021 10:10:52 -0400
Message-ID: <CAP+JOzSkFNDjOMDWgP+xeJPS=Q5Xzwx=6wrYqx2_n0vLPA4dPg@mail.gmail.com>
Subject: Re: [RFC PATCH 29/35] libsepol: validate genfs contexts
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 11, 2021 at 12:41 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/src/policydb_validate.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index 5c06e6f4..63fd935c 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -712,6 +712,25 @@ bad:
>         return -1;
>  }
>
> +static int validate_genfs(sepol_handle_t *handle, policydb_t *p, validat=
e_t flavors[])
> +{
> +       genfs_t *genfs;
> +       ocontext_t *octx;
> +
> +       for (genfs =3D p->genfs; genfs; genfs =3D genfs->next) {
> +               for (octx =3D genfs->head; octx; octx =3D octx->next) {
> +                       if (validate_context(&octx->context[0], flavors, =
p->mls))
> +                               goto bad;
> +               }
> +       }
> +
> +       return 0;
> +
> +bad:
> +       ERR(handle, "Invalid genfs");
> +       return -1;
> +}
> +
>  /*
>   * Functions to validate a module policydb
>   */
> @@ -898,6 +917,8 @@ int validate_policydb(sepol_handle_t *handle, policyd=
b_t *p)
>                         goto bad;
>                 if (validate_ocontexts(handle, p, flavors))
>                         goto bad;
> +               if (validate_genfs(handle, p, flavors))
> +                       goto bad;
>                 if (p->policyvers >=3D POLICYDB_VERSION_FILENAME_TRANS)
>                         if (validate_filename_trans_hashtab(handle, p->fi=
lename_trans, flavors))
>                                 goto bad;
> --
> 2.33.0
>

Like ocontexts, genfs rules can be in base modules.
Jim
