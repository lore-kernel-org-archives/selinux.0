Return-Path: <SRS0=h1bs=44=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CF8C4CEC0
	for <selinux@archiver.kernel.org>; Wed, 11 Mar 2020 18:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1CA20735
	for <selinux@archiver.kernel.org>; Wed, 11 Mar 2020 18:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJ8dNjpi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730658AbgCKSRR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:17:17 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45932 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730808AbgCKSRF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Mar 2020 14:17:05 -0400
Received: by mail-ot1-f67.google.com with SMTP id f21so3043778otp.12
        for <selinux@vger.kernel.org>; Wed, 11 Mar 2020 11:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uw7hWVMRjOcjBjHn1QBIWn5FBX1/APpiUsivw1WJzfU=;
        b=gJ8dNjpiaFrm90pgXFCJa7REr0NxhyX+0GJLu3uoF3ytkO/KsFJb2r0KSx/EebYf4H
         JK0LlU31kMtdfijes/u9r06fEsSULz9toqcF77MqQLm1/YcR9Lt9X4nzy4iX1m+74rQh
         HR6g6SPWeIOBVH8M3jmhOW88O5qYSme0RStdBKlXME0FfpGWO9NMukOXY/e39V80bGvw
         tm9ik6HCx9RXaiZqhGJvJiHz0/5Kv/6hoN48zPaok15JbJZlh+DYP48AEqJuq2H9Yy4Y
         szNQ4XWqgf3P5YwP00eGbI+1x9UM/AwpCmSxMbpzHDGlew+jYw7AmQlGWLi/2TxyN/Xg
         AbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uw7hWVMRjOcjBjHn1QBIWn5FBX1/APpiUsivw1WJzfU=;
        b=GNx4pwGrfhxlRerNs5M1aVvpdQNvaOQZI5Ko4KiTYonawFvTTFsmAQFQ1eXp6J2kVi
         B/XVmn4r4FJBsC0yP/Ao0Pm22h+p9COH/MbO0l3TvJEGjDPmOSfqZM0B4MltLjKiytEa
         4zS3oXNoGOs/purRQN0Y8aawmUb505VOFDQsGDLJM4agFRXRgcVDYB1Wp6obRWV3+zk+
         D32wDtmbDiTj+2oDsjdSfomEPQ4vtpaQaYWx8IIeCtgnpcoRXV/dTsva55NwwALU7zQp
         XqjZtejK+mfGy91DiEFhsV2HK7ZMr5+MNWvPw9Eh3y06EPk7xgQg1ALf7I00PkR6cuZD
         /LpA==
X-Gm-Message-State: ANhLgQ2CB09huHQeuvtkDiQUQV90hPilTqm06F6k49AkFMQro+JWmShh
        KzkU+UIhWKgy73Vwq0QuZwjC1Jujzf4qv1zqVP5uTg==
X-Google-Smtp-Source: ADFU+vtajbJEzafojDWCrpZwfNiDsFJyIlUt6OMGZRtGZPNoGuM/xUT31BMl1dUQF8Cloumh0Q07trQmEZhnCZo/rU0=
X-Received: by 2002:a05:6830:1610:: with SMTP id g16mr3434350otr.295.1583950624897;
 Wed, 11 Mar 2020 11:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200310144133.381567-1-dburgener@linux.microsoft.com> <CAP+JOzTwr8hC2zkjy15PJpJb_jjJAMdAhj8d-JwzzBVOVWpWwQ@mail.gmail.com>
In-Reply-To: <CAP+JOzTwr8hC2zkjy15PJpJb_jjJAMdAhj8d-JwzzBVOVWpWwQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 11 Mar 2020 14:18:28 -0400
Message-ID: <CAP+JOzSe7YNQRj07GYKvvcP2Kjj8oo3XdUKbccow7QaLgBs-WA@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: Treat invalid characters as an error
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 10, 2020 at 3:19 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, Mar 10, 2020 at 10:42 AM Daniel Burgener
> <dburgener@linux.microsoft.com> wrote:
> >
> > Previously the behavior was to warn, discard the character and proceed. Now the build will halt upon encountering an expected character.
> >
> > Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
>

Thanks, applied.
Jim

> > ---
> >  checkpolicy/policy_scan.l | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> > index e2f676e4..8c100f3d 100644
> > --- a/checkpolicy/policy_scan.l
> > +++ b/checkpolicy/policy_scan.l
> > @@ -290,7 +290,7 @@ GLBLUB                              { return(GLBLUB); }
> >  "]" |
> >  "~" |
> >  "*"                            { return(yytext[0]); }
> > -.                               { yywarn("unrecognized character");}
> > +.                               { yyerror("unrecognized character");}
> >  %%
> >  int yyerror(const char *msg)
> >  {
> > --
> > 2.24.1
> >
