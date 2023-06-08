Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9990EC7EE29
	for <selinux@archiver.kernel.org>; Thu,  8 Jun 2023 19:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjFHTwz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Jun 2023 15:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbjFHTwy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Jun 2023 15:52:54 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66112D6A
        for <selinux@vger.kernel.org>; Thu,  8 Jun 2023 12:52:51 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b1a7e31dcaso10051411fa.2
        for <selinux@vger.kernel.org>; Thu, 08 Jun 2023 12:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686253970; x=1688845970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFULCShR7Wh3U78WTMLmkPI4ywB7wt6gOWAKJOiBl9U=;
        b=O+VR/iMgR+B6VBeAf0Z7WNIRbkxsGvgmhaFI+UsVbSs64ffxvXZ9a0s5a5XXfFWHBH
         2rh5+c6iMNZfiy/6KGSWgItiFuMIMDCYI7tUZ/y1YwxQh2/7CBiD3U4lz3S66mkiUTs8
         D+ey6NA3KstjHkL5n+Lkamdda4jbC0eq5VKj3hcnwoW+tuPu7fcvhP6H9Hjwn3aSMJKF
         WnVEhmKRXeGD/io5u2vqagKMR+h4l3n/tEnupcSSqK82vLkLpiZN71xX0nueEHTTPrhX
         HYbFTqsANzfZZ9sKdZjViFZCOhWoLXBcTCJby/4Rv6NiKB6Qp18Ae4p+8GHO+fcbCRUg
         E92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686253970; x=1688845970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFULCShR7Wh3U78WTMLmkPI4ywB7wt6gOWAKJOiBl9U=;
        b=VFd/BAjLZL94cEfVlyPxpdonNxC2nRwxp8Om1hbFiTxxrE6yVxuI5gmUIqBF9d9gqN
         Msj5VQRnRh6nD1PwA/8WbjMLOXs1Sn2bOiBPowluQEHfgvlWlKTsXwvAhMnFO2SNQndb
         D4lUfgkQrrJ30W0LsMINrpLja1tZEMPzha9fGcTb0HdCEgoU9L56l3FbgxrghugLt6pK
         jLlW8elIufWaRCld5bIgAIj0GC5IQEkwAzBPewE+SWpkwrrgKdZMjsPH5QPKpo0Aqr3C
         lUPya7qxOzhQjBmHDufRUfE4vX22O4lBnJ2Lz9ty8LhZWIDNbs2d3Y7WlW+/XDklQDAb
         ItKw==
X-Gm-Message-State: AC+VfDzKVdIsNINjmSkqQmI0v1dH63k4XLdZtqSVW8CGNICdupYyaqpR
        HK0vgB5Rd+6n9wwiSi0iU8hCUnyO0673NfqCzbI=
X-Google-Smtp-Source: ACHHUZ5g1RnMARCGLuD01WnrR8PD8UVDgbu0W7qSgi51pEMxk7u1PtUilfyLLWzl+B9NMtnHkdUrE8sBr0EgOvnvtik=
X-Received: by 2002:a2e:3c19:0:b0:2b2:104d:8f8d with SMTP id
 j25-20020a2e3c19000000b002b2104d8f8dmr1464674lja.7.1686253969760; Thu, 08 Jun
 2023 12:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230608015241.2454912-1-yamato@redhat.com> <CAP+JOzTYNajYPUwYHMat=U3TJH1Pd6yprN0tm-EN3jxuOQaz3A@mail.gmail.com>
In-Reply-To: <CAP+JOzTYNajYPUwYHMat=U3TJH1Pd6yprN0tm-EN3jxuOQaz3A@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 8 Jun 2023 15:52:38 -0400
Message-ID: <CAP+JOzT4jOg+ZiyhhjWrL0f4CFCFAtDEBf51ZnHS5UvqJ8OyhQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] dispol: add --help option
To:     Masatake YAMATO <yamato@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 8, 2023 at 10:21=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Wed, Jun 7, 2023 at 9:59=E2=80=AFPM Masatake YAMATO <yamato@redhat.com=
> wrote:
> >
> > Signed-off-by: Masatake YAMATO <yamato@redhat.com>
>
> For these four patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These four patches have been merged.
Thanks,
Jim

> Thanks,
> Jim
>
> > ---
> >  checkpolicy/test/dispol.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
> > index b61f1b4b..50027e40 100644
> > --- a/checkpolicy/test/dispol.c
> > +++ b/checkpolicy/test/dispol.c
> > @@ -38,7 +38,11 @@ static policydb_t policydb;
> >
> >  static __attribute__((__noreturn__)) void usage(const char *progname)
> >  {
> > -       printf("usage:  %s binary_pol_file\n\n", progname);
> > +       puts("Usage:");
> > +       printf(" %s [OPTIONS] binary_pol_file\n\n", progname);
> > +       puts("Options:");
> > +       puts(" -h, --help   print this help message");
> > +       puts("\n");
> >         exit(1);
> >  }
> >
> > @@ -481,7 +485,7 @@ int main(int argc, char **argv)
> >         int state;
> >         struct policy_file pf;
> >
> > -       if (argc !=3D 2)
> > +       if (argc < 2 || strcmp(argv[1], "-h") =3D=3D 0 || strcmp(argv[1=
], "--help") =3D=3D 0)
> >                 usage(argv[0]);
> >
> >         fd =3D open(argv[1], O_RDONLY);
> > --
> > 2.40.1
> >
