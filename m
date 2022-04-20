Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C231FC433EF
	for <selinux@archiver.kernel.org>; Wed, 20 Apr 2022 19:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbiDTTHo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Apr 2022 15:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244725AbiDTTHo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Apr 2022 15:07:44 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B7F2DCF
        for <selinux@vger.kernel.org>; Wed, 20 Apr 2022 12:04:56 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-e2fa360f6dso2991098fac.2
        for <selinux@vger.kernel.org>; Wed, 20 Apr 2022 12:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t12hWkQ2kzE7o1cXRZwgNHN5x8A8hkeT0c+TOsHYBUs=;
        b=HjKvubL7JNQYj4jFIDn8jtavGc8+8TGn1mf5lGOdSRabH220uFqjQ5YXWvhC/OD0V6
         htLxGkwhPcKGYumAJrWjGxrYeqHRcl1N4h7+JH9e0vrLp1J1JyIgLpVY2lf9OtBNXZFB
         rj0oRpzNUNAnZK4e9qxH/5yj+VkR3knBhHXr3WZr16zvrqPrF7polNNDaOA94lb4r9VR
         jJIRC2o3NdgytKaxZ7TPREWeEET33zwa89tiRZKBn+U+g9czGH6E4FckjGS5aWPuFwn7
         IVIToVD7AIwRNk99hPtr49Re1bgIJLRmMdQsRUcsFiaUUDpHvgacwgpSkxWzRF1IQeVv
         zVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t12hWkQ2kzE7o1cXRZwgNHN5x8A8hkeT0c+TOsHYBUs=;
        b=dbvrliIEE/bTSAzCq1377+sqd++sPpf1iiTmhXBVVcJp1FqGPFnWfWLT8/efyGsdoH
         CeuAYzLtXqccoVHlr/oVn0D/UHvbBh3svcOwOs4Ns4xeZfehVSY5WXqDgW2wRgjopHzI
         wknJ3D7p7Y9ol35gRn6sWFQHzJjrbxuEGqEuZPKhwIoENOqxbLA7x062GwaA4xzLSuid
         FP/h2lU0ej1CrlkRqT1eQbUEERcLR1UGevgEXhIEqiECxDj5tnXXdWUngoiFPNERH1KC
         +uyRyDdKsnxcCak6smX6nQfP8oMtkzv49HV/G6Bk3FIjU4bP2fFD05BMbU+LsDcyMXOY
         8cmQ==
X-Gm-Message-State: AOAM530PUPzY6fpdsNTTbrhWxyZjop3eVgdAzNuqRutU5KEir56EbVsu
        DfoMU6KWqXbjMP4amtCVPy7hF1+0Gjq/5Zc7ksQydTRM
X-Google-Smtp-Source: ABdhPJx33+pH70P1CFR7KGF7Zdyft11fzN52tCi4Izzh3PkHHoJTkdLNjam/85dl/yrKjIEJd2Y7HqrF9zUzfMxG80k=
X-Received: by 2002:a05:6870:d68e:b0:e2:861:8b15 with SMTP id
 z14-20020a056870d68e00b000e208618b15mr2324134oap.156.1650481495939; Wed, 20
 Apr 2022 12:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220331144752.31495-1-cgzones@googlemail.com>
 <20220405133548.51598-1-cgzones@googlemail.com> <20220405133548.51598-4-cgzones@googlemail.com>
 <CAP+JOzTXBr_jMK8PjoYJt2CXashgO1jyKkWhrVGKrdmLV-6EVw@mail.gmail.com>
In-Reply-To: <CAP+JOzTXBr_jMK8PjoYJt2CXashgO1jyKkWhrVGKrdmLV-6EVw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 20 Apr 2022 15:04:45 -0400
Message-ID: <CAP+JOzSZPE66RgwqL6Yvx1EKwmExuZK1gCrc--pXigmk2Dq4fA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] libsepol/cil: comment out unused function __cil_verify_rule
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 6, 2022 at 12:15 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Apr 6, 2022 at 9:28 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > The function __cil_verify_rule() is currently not used as all call site=
s
> > are commented out.  Keep the function for future references.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Patches 1-3 have already been merged.
>
> For patches 4-6:
> Acked-by: James Carter <jwcart2@gmail.com>
>

Now that the libsepol and libsemanage tests work for
"-Wmissing-prototypes", patches 4-6 have been merged.
Thanks,
Jim

> > ---
> >  libsepol/cil/src/cil_verify.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verif=
y.c
> > index aecbdc19..4640dc59 100644
> > --- a/libsepol/cil/src/cil_verify.c
> > +++ b/libsepol/cil/src/cil_verify.c
> > @@ -970,7 +970,8 @@ exit:
> >         return rc;
> >  }
> >
> > -int __cil_verify_rule(struct cil_tree_node *node, struct cil_complex_s=
ymtab *symtab)
> > +/*
> > +static int __cil_verify_rule(struct cil_tree_node *node, struct cil_co=
mplex_symtab *symtab)
> >  {
> >
> >         int rc =3D SEPOL_ERR;
> > @@ -1016,6 +1017,7 @@ exit:
> >         cil_tree_log(node, CIL_ERR, "Invalid rule");
> >         return rc;
> >  }
> > +*/
> >
> >  static int __cil_verify_booleanif_helper(struct cil_tree_node *node, _=
_attribute__((unused)) uint32_t *finished, __attribute__((unused)) void *ex=
tra_args)
> >  {
> > --
> > 2.35.1
> >
