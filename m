Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A28C433F5
	for <selinux@archiver.kernel.org>; Thu, 18 Nov 2021 16:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2109B61A3A
	for <selinux@archiver.kernel.org>; Thu, 18 Nov 2021 16:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbhKRQUh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Nov 2021 11:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbhKRQUh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Nov 2021 11:20:37 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67909C061574
        for <selinux@vger.kernel.org>; Thu, 18 Nov 2021 08:17:37 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id h12-20020a056830034c00b0055c8458126fso11890148ote.0
        for <selinux@vger.kernel.org>; Thu, 18 Nov 2021 08:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nc+KpPecUvzpI4Bcc+ecw7zs99x4nx2D5jL/BfcUAXg=;
        b=fATDPcN+mSAbItY0qQ0//Ca2aebUpjcGVQ0z41l+ZyT5IlPRqIJX0wHPtToePLufoj
         1rPiIIrJJSUyAYmuqAtsKpbmhqh7AYsN+HhIc7QotQg/SVyHrCxd1EIJ6pzslWgJQq8Q
         LdY1NEcRAjHbLJwwxcPPNDT71GtL31Gh7KiwCwXd8C4Q7Ch1cACB7jl7LZZ6ffgXzymR
         4okSS+qXxuaLeqct8liLulC1+Uo2Ngd5Xde+l9AJtMMrICi9BITZ7urDPUxPzioes4Jw
         7apV5rFgf7yaQvwXgnRsWKDvhL6rIT8GS5HqtPny71wI7t65B0KYw8OOoMd7xRDB7VzQ
         NJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nc+KpPecUvzpI4Bcc+ecw7zs99x4nx2D5jL/BfcUAXg=;
        b=XyhRUsT7fO15L9uWL58ffVOLZERstbN3l6ZIMpkG/J87NhfZUUV1fN0i9aDpHD+M/j
         OJJYdh7NZYS3A1/X5u5LkLhFiE95wMJKhLs6qjKZUhWSlw8uSoaNXIYyPYmgxG/KSYx7
         eWcXMVd0+lwLuh66lWbDZWZOdcM1EWfEOROvZgGTkgWBP7z7gXnLSt9jxDDAwpkSSCrO
         xS3VYJ9oPQnESvMSvd1zl2Zo71+vtgAgcvhDJQEzz2n1bpMdwt0vLvQk4eJQIozVK+r3
         Igu3/zK+MBVzug6MkzRiS1v2LFRfzBXaDN0KdEOldywNnzniTPaaWdUa1V05V0VAIU43
         dJjA==
X-Gm-Message-State: AOAM5309lowUYCNn0KMLUpeitlNoRjilkTckxTBJyytczk1FRISC3/LB
        nyYD/1zEF2Z7F/6UMAw+tHgvgDQk2ho1U4c09yxOsc9e
X-Google-Smtp-Source: ABdhPJwWsdUjAiB1FsjZQEuo1Bfrb/qCoVQqJmeSRFf0NI5aHtiIygz5oX1+RqhMND/J4mU6etPd3CV/WPy6rOPt0Ds=
X-Received: by 2002:a05:6830:1bfa:: with SMTP id k26mr21857459otb.139.1637252256840;
 Thu, 18 Nov 2021 08:17:36 -0800 (PST)
MIME-Version: 1.0
References: <20211112154201.78217-1-cgzones@googlemail.com> <CAP+JOzSNQbg_a+0Yu4NU0ki_0zrXBU_R_fh9Zrn_Twf8=_HTJw@mail.gmail.com>
In-Reply-To: <CAP+JOzSNQbg_a+0Yu4NU0ki_0zrXBU_R_fh9Zrn_Twf8=_HTJw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 18 Nov 2021 11:17:25 -0500
Message-ID: <CAP+JOzRd_i=aP3dOk0mRY7WOCDsjTz3GSJ0-LCbyMWbmAt+UnA@mail.gmail.com>
Subject: Re: [PATCH 01/12] checkpolicy: use correct unsigned format specifiers
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 15, 2021 at 4:48 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Fri, Nov 12, 2021 at 10:42 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > The two variables policydb_lineno and source_lineno are both of the typ=
e
> > unsigned long; use the appropriate format specifier.
> >
> > Found by Cppcheck
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For all 12 patches.
> Acked-by: James Carter <jwcart2@gmail.com>
>

This has been merged.
Thanks,
Jim

> > ---
> >  checkpolicy/policy_scan.l | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> > index 129a8a2a..ef9f1899 100644
> > --- a/checkpolicy/policy_scan.l
> > +++ b/checkpolicy/policy_scan.l
> > @@ -308,11 +308,11 @@ GLBLUB                            { return(GLBLUB=
); }
> >  int yyerror(const char *msg)
> >  {
> >         if (source_file[0])
> > -               fprintf(stderr, "%s:%ld:",
> > +               fprintf(stderr, "%s:%lu:",
> >                         source_file, source_lineno);
> >         else
> >                 fprintf(stderr, "(unknown source)::");
> > -       fprintf(stderr, "ERROR '%s' at token '%s' on line %ld:\n%s\n%s\=
n",
> > +       fprintf(stderr, "ERROR '%s' at token '%s' on line %lu:\n%s\n%s\=
n",
> >                         msg,
> >                         yytext,
> >                         policydb_lineno,
> > @@ -327,11 +327,11 @@ int yywarn(const char *msg)
> >                 return yyerror(msg);
> >
> >         if (source_file[0])
> > -               fprintf(stderr, "%s:%ld:",
> > +               fprintf(stderr, "%s:%lu:",
> >                         source_file, source_lineno);
> >         else
> >                 fprintf(stderr, "(unknown source)::");
> > -       fprintf(stderr, "WARNING '%s' at token '%s' on line %ld:\n%s\n%=
s\n",
> > +       fprintf(stderr, "WARNING '%s' at token '%s' on line %lu:\n%s\n%=
s\n",
> >                         msg,
> >                         yytext,
> >                         policydb_lineno,
> > --
> > 2.33.1
> >
