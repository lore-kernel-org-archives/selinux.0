Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90959EB64DA
	for <selinux@archiver.kernel.org>; Wed, 12 Jul 2023 17:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjGLRfu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Jul 2023 13:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjGLRfs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Jul 2023 13:35:48 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767861FDE
        for <selinux@vger.kernel.org>; Wed, 12 Jul 2023 10:35:46 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b717e9d423so13224911fa.1
        for <selinux@vger.kernel.org>; Wed, 12 Jul 2023 10:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689183345; x=1691775345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snGDgUzdARs45Jy1QW2qlvoiIwvGYVpr1Pjq4y7l+Fo=;
        b=pJKYra/xXYHfa1Rj7WljYn5BQF+pi3FkFGgfIWOpr9K8xNx0/TAm+dKsDlFjNtTOFH
         XCr7SIvo8eYtHXQKneCKX87vasKvthO82FgxzCiOuSAZqH3LSZwirnF+NRIsNDyQHyci
         kEcA53jCwohTO42MPlnMWBF4PRbsb+i5Uz5LqZQemXnY4I/q34kssIQaZSsmFRQPRx6q
         IpFeOkbf31eCXbWPfnhEdfeIhFes40f3UFvzavKSyPd5EE81YLvOTH0Dx7MAj7gZc7Nu
         csRWjJF7fy2DgJsDeJYu100TEw84O3O1uttOLnp5P0fKe2TgXg81jr4Fun4YlhXgKLCG
         eB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689183345; x=1691775345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snGDgUzdARs45Jy1QW2qlvoiIwvGYVpr1Pjq4y7l+Fo=;
        b=Scu3OlZdDSXLA1XqBlWBvFi8LwC7myJvFsR3WIcNt2uUQTbxgUXrrL/YhVgLs4HFH7
         oNzLMYuIemrlGnC0VlTVN2QuO+lxZK8CmgQC0DvngR6CsWFzofNohc88LD8ES8kfU/FD
         cfHL3EU6k7YpRiLyn7p1RndC6dwVwKkFkEynoWzUL2e+7bjC5VxWBvuW1kmZ+hDn9tfj
         8bzP3i0eawkEV7g3/0tMFpZtANHpPiLLGsXv9ReBJ/FUSuerHym/S/bGGS6KAlQySXIj
         wf5p8ty2MQQ0H5guKlYB5B747waBXEuRxB92IuhDqhvYP2zzc5unDhoa9FUshSMffTVJ
         IM7A==
X-Gm-Message-State: ABy/qLaQ4z4JejMMkPKY/R5RDwHaPTZ06dCU7pj+akyqxtafF5L1yyhu
        3h2jQoIgREQMpYGzm/DZdB1Nd+uyCJc/WpNHyol25c7+
X-Google-Smtp-Source: APBJJlEnr4QCjShm74Uo8iLLB7mstLOBv9Bhv9gxxZypidnFFGYg32opRQmB8Lw46FX54Ck5A5I8wGEl0qiCNgBjr4U=
X-Received: by 2002:a2e:92c8:0:b0:2b4:50b8:5d3b with SMTP id
 k8-20020a2e92c8000000b002b450b85d3bmr1096946ljh.0.1689183344649; Wed, 12 Jul
 2023 10:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230706140233.45990-1-cgzones@googlemail.com> <CAP+JOzSsg_N8CGNAmMZfatcPC-XfjKANAr6W=Ld_r6R9UeyG=w@mail.gmail.com>
In-Reply-To: <CAP+JOzSsg_N8CGNAmMZfatcPC-XfjKANAr6W=Ld_r6R9UeyG=w@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 12 Jul 2023 13:35:33 -0400
Message-ID: <CAP+JOzS=nvi5aGad+3Jj0_shVWazi5D5oHMoBUhOpf2OkwBPzQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol/fuzz: more strict fuzzing of binary policies
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 11, 2023 at 3:47=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, Jul 6, 2023 at 10:06=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Validate policy after optimizing.
> >
> > Run policy assertion check, ignoring any assertions.
> >
> > Abort on failures writing the parsed policy, as writing should not fail=
 on
> > validated policies.
> >
> > Set close-on-exec flag in case of any sibling thread.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsepol/fuzz/binpolicy-fuzzer.c | 21 ++++++++++++++++-----
> >  1 file changed, 16 insertions(+), 5 deletions(-)
> >
> > diff --git a/libsepol/fuzz/binpolicy-fuzzer.c b/libsepol/fuzz/binpolicy=
-fuzzer.c
> > index 85c59645..79d42b0e 100644
> > --- a/libsepol/fuzz/binpolicy-fuzzer.c
> > +++ b/libsepol/fuzz/binpolicy-fuzzer.c
> > @@ -3,6 +3,8 @@
> >  #include <sepol/kernel_to_conf.h>
> >  #include <sepol/policydb/policydb.h>
> >
> > +extern int policydb_validate(sepol_handle_t *handle, const policydb_t =
*p);
> > +
> >  extern int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
> >
> >  static int write_binary_policy(policydb_t *p, FILE *outfp)
> > @@ -38,18 +40,27 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, siz=
e_t size)
> >         if (policydb_load_isids(&policydb, &sidtab))
> >                 goto exit;
> >
> > -       if (policydb.policy_type =3D=3D POLICY_KERN)
> > +       if (policydb.policy_type =3D=3D POLICY_KERN) {
> >                 (void) policydb_optimize(&policydb);
> >
> > -       devnull =3D fopen("/dev/null", "w");
> > +               if (policydb_validate(NULL, &policydb) =3D=3D -1)
> > +                       abort();
> > +       }
> > +
> > +       (void) check_assertions(NULL, &policydb, policydb.global->branc=
h_list->avrules);
> > +
> > +       devnull =3D fopen("/dev/null", "we");
> >         if (!devnull)
> >                 goto exit;
> >
> > -       (void) write_binary_policy(&policydb, devnull);
> > +       if (write_binary_policy(&policydb, devnull))
> > +               abort();
> >
> > -       (void) sepol_kernel_policydb_to_conf(devnull, &policydb);
> > +       if (sepol_kernel_policydb_to_conf(devnull, &policydb))
> > +               abort();
> >
> > -       (void) sepol_kernel_policydb_to_cil(devnull, &policydb);
> > +       if (sepol_kernel_policydb_to_cil(devnull, &policydb))
> > +               abort();
> >
> >  exit:
> >         if (devnull !=3D NULL)
> > --
> > 2.40.1
> >
