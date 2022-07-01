Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC9BC43334
	for <selinux@archiver.kernel.org>; Fri,  1 Jul 2022 09:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbiGAJVt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Jul 2022 05:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiGAJVs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Jul 2022 05:21:48 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E319558FC0
        for <selinux@vger.kernel.org>; Fri,  1 Jul 2022 02:21:43 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id s13-20020a0568301e0d00b00616ad12fee7so1384275otr.10
        for <selinux@vger.kernel.org>; Fri, 01 Jul 2022 02:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hxHldyNGjxMXzowFw50Y2rFuv0HyV9n3klELICJHlxw=;
        b=cWFvkTDJdkJpYT62zmkGNrXiEAwa2JSc11BdVvAgWmugrtNkJGEkVKKGmuUSd0h34P
         1Q33SjXmgpx3QlWBmeDEZq78c1A5JqlZco95watbCFByrbiU4o1XPltzgrZ21D7bZDVV
         fNYHFkQ7ms2ZjK6u1AiSl07oJTKRzh5lJfOMgAawQOXfEj1l5vQBMpTHnJ6H7DJND4rJ
         4SeyCmqmw6qQfoqCMJdNLqf4j+b4Wl5int6NAG/NIiJtBELmJCdFijZq49pyNMj1BnhY
         YBNAVr4PyqGcUcvKg6LGP9u5GAHP+hjlzRvfZrPWFWbVaGLu2m/UZtUCgXmhQ5FvMvhM
         aCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hxHldyNGjxMXzowFw50Y2rFuv0HyV9n3klELICJHlxw=;
        b=LolY3F4SNadNdesKMLctsoKRLPUZshaYWx+U3bf7g9ODBh8QlTIQOouellrcA2xKZP
         3ObngYreshAzhJMeeQ3D4NcLOfr8+eEzmdGm7N5nz/PP+HB5MfqDvdw0WeytCA5EN0+g
         aECVPv9dyLFpnt6DhiGTBYwOyeLJ81A33xeuCF+Yqv+CNUGRHWLnunmwAdpgvcRZpj20
         Eg3oQ3weDDSZoQS3zN7eTA7La5V123C6ZDm4vr6dTNCDxUOBUGO3Fx9GwENOwxjDHWyO
         N1mCRz6OBnr8jVmjCQL/UDr90ZjpZLzaphtMJZJhHPMjEY7HAwhQaRF2+ARLaJkRxRb7
         GfUQ==
X-Gm-Message-State: AJIora8aOTfnfGTLhlxvk4O5OvU4uqiyMh5/bgcvbdUGQnhxqc0sCxYj
        qcdfkU4aMFR1Bp+lqb/XvW+thYOvWns6lke750o=
X-Google-Smtp-Source: AGRyM1tz+Cdt26nDr61XkajY0vnnRG/QRF0OykpEOcfRpc9IK9tuvAcvvMg0JNrbjQJOyINcu27Xq3/uXtfcxVMLrto=
X-Received: by 2002:a05:6830:2692:b0:618:b992:cbc9 with SMTP id
 l18-20020a056830269200b00618b992cbc9mr3054451otu.117.1656667302306; Fri, 01
 Jul 2022 02:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220629072055.2653695-1-nicolas.iooss@m4x.org> <CAP+JOzRXjoneNg4sQ3W9sMSneQETHqCw1yGUP1hdmXqbXXMwsQ@mail.gmail.com>
In-Reply-To: <CAP+JOzRXjoneNg4sQ3W9sMSneQETHqCw1yGUP1hdmXqbXXMwsQ@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Fri, 1 Jul 2022 11:21:31 +0200
Message-ID: <CAJ2a_Dco+NbrnnZvb1tm_o37-ykKbkQZb3kp5vvH7nffKZ0UZQ@mail.gmail.com>
Subject: Re: [PATCH userspace 1/1] libsepol: initialize s in constraint_expr_eval_reason
To:     James Carter <jwcart2@gmail.com>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 29 Jun 2022 at 22:07, James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Jun 29, 2022 at 3:37 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > clang's static analyzer reports that s[0] can be uninitialized when used
> > in:
> >
> >     sprintf(tmp_buf, "%s %s\n",
> >                     xcontext ? "Validatetrans" : "Constraint",
> >                     s[0] ? "GRANTED" : "DENIED");
> >

The trace for the reports shows:

    441 for (e = constraint->expr; e; e = e->next) {
        Loop condition is false. Execution continues on line 708

and clang-tidy also reports:

     libsepol/src/services.c:715:16: warning: Call to 'calloc' has an
allocation size of 0 bytes [clang-analyzer-optin.portability.UnixAPI]
           answer_list = calloc(expr_count, sizeof(*answer_list));
                         ^      ~~~~~~~~~~
    libsepol/src/services.c:433:6: note: Assuming 'class_buf' is
non-null
           if (!class_buf) {
               ^~~~~~~~~~
    libsepol/src/services.c:433:2: note: Taking false branch
           if (!class_buf) {
           ^
    libsepol/src/services.c:439:2: note: The value 0 is assigned to
'expr_counter'
           expr_counter = 0;
           ^~~~~~~~~~~~~~~~
    libsepol/src/services.c:441:2: note: Loop condition is false.
Execution continues on line 708
           for (e = constraint->expr; e; e = e->next) {
           ^
    libsepol/src/services.c:708:2: note: The value 0 is assigned to
'expr_count'
           expr_count = expr_counter;
           ^~~~~~~~~~~~~~~~~~~~~~~~~
    libsepol/src/services.c:715:16: note: Call to 'calloc' has an
allocation size of 0 bytes
           answer_list = calloc(expr_count, sizeof(*answer_list));
                         ^      ~~~~~~~~~~

I think the root cause is the possibility of `constraint->expr` being
NULL, i.e. the constraint having no expression, which seems invalid to
me.
Maybe add a check `if(!constraint->expr) { BUG(); return -EINVAL; }`?

Also validation should probably catch this at
https://github.com/SELinuxProject/selinux/blob/956bda08f6183078f13b70f6aa27d0529a3ec20a/libsepol/src/policydb_validate.c#L238

    + if (!cons->expr)
    +     goto bad;
    +
    for (cexp = cons->expr; cexp; cexp = cexp->next) {

> > Silence this false-positive issue by making s always initialized.
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
> > ---
> >  libsepol/src/services.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> > index d7510e9dae51..db769cdcfaf9 100644
> > --- a/libsepol/src/services.c
> > +++ b/libsepol/src/services.c
> > @@ -394,7 +394,7 @@ static int constraint_expr_eval_reason(context_struct_t *scontext,
> >         role_datum_t *r1, *r2;
> >         mls_level_t *l1, *l2;
> >         constraint_expr_t *e;
> > -       int s[CEXPR_MAXDEPTH];
> > +       int s[CEXPR_MAXDEPTH] = {};
> >         int sp = -1;
> >         char tmp_buf[128];
> >
> > --
> > 2.36.1
> >
