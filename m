Return-Path: <SRS0=VlsA=TQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C26C04E84
	for <selinux@archiver.kernel.org>; Thu, 16 May 2019 01:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF29220873
	for <selinux@archiver.kernel.org>; Thu, 16 May 2019 01:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMY+F+vs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfEPBqd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 May 2019 21:46:33 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44973 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfEPAfE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 May 2019 20:35:04 -0400
Received: by mail-ot1-f67.google.com with SMTP id g18so1775270otj.11
        for <selinux@vger.kernel.org>; Wed, 15 May 2019 17:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GV0zBytOUkWMTc1mkwDidujCEM8RWB40RrYCLlpbtPE=;
        b=FMY+F+vshneloA78kBpyVxKtDY2wvkpOXcan4ftIWYSg593a+HhcENdHNEMfhOC24e
         wDyNs8waC70j+GaOiNcqgB4UjdKh8udW2qDKjqVPaWhK6imTTpS3RFb+r1uRzdaHwA85
         NITipbLcV0nGgaOYLl+OmvrWsr+ymP6YCSeQZrE8zyTDkgzQlX6URJGNbhjERm/Gn0Zp
         rKX8naqzC6LIJJwRClIDa+PP7ROYyTcLWGpstyJceYaPERxz+/oJlp+UuapZPvGz10it
         iNhtaDKWGSGtHaJWXEpuism6wnKmDyMztei2BJTH4OFIEiwYqia4lqiMDXsxYvLX9iPR
         BDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GV0zBytOUkWMTc1mkwDidujCEM8RWB40RrYCLlpbtPE=;
        b=fRqI3d7t6PsFNRDLtv5v4tnSlwDMsN4SuPhlDvqAyTM+BfQnNpczQil+U/+VxesOQs
         Eqo6V9GH6aFnWug1SbTCF8Lykb+4TVaW1cZm5sfEERrdaQARWGu3Hs4s2GieJ+u1n0s6
         i12ffVtKpUqEmSUfWvNeUvPP7l9XCcRM3vvOcbNaBQQgt3Yk1wnJLb32aZ3JnV7LxoGE
         B2ebcKwKmm/NKY7yTiRwl+6q4AB9BdjFmmUAOP1zgXN2mGsCa4UBQ8mXDY/IuqD/kZ+O
         yv6Srnuy6+U/MM6nsJU9bzH8Ytk1bA1xMRAuV08Inrwku1MmkzsloEcPMHNbhtTtaIBd
         qOow==
X-Gm-Message-State: APjAAAXSK23cYV5mBtCgQeVELg8M5cdxJZYmk2/2W/stbXKhJDnLj87M
        f8C4WlMmDLcck7WeR0WnzMIdSVfFoRm6srBwURuBV3A9SKU=
X-Google-Smtp-Source: APXvYqz/sB7k4DDkRwCzaQOGBJnH3KAmKUqxeRKowQlaVxExrl7rkV9elntVTdayumDJ9UZS4nNQAr7h3U44a/jxZ/M=
X-Received: by 2002:a9d:8a7:: with SMTP id 36mr26898959otf.111.1557966904096;
 Wed, 15 May 2019 17:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LFD.2.21.1905102117140.16225@34-41-5D-CA-59-C7> <CAFftDdrWTEXizp=BhcDBfKnh43uDX6dc_683EA_aO8aimpSo_g@mail.gmail.com>
In-Reply-To: <CAFftDdrWTEXizp=BhcDBfKnh43uDX6dc_683EA_aO8aimpSo_g@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Wed, 15 May 2019 17:34:52 -0700
Message-ID: <CAFftDdq5PF8Dx09a6SxtRhNkVH=L1a25HaK7ixhaJrf1VfyXtw@mail.gmail.com>
Subject: Re: [PATCH] Global replace exit(0) with more readable exit(EXIT_SUCCESS)
To:     =?UTF-8?B?Sm9ra2UgSMOkbcOkbMOkaW5lbg==?= 
        <jokke.hamalainen@kolttonen.fi>, Daniel J Walsh <dwalsh@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

merged: https://github.com/SELinuxProject/selinux/pull/148

On Fri, May 10, 2019 at 2:00 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Fri, May 10, 2019 at 12:03 PM Jokke H=C3=A4m=C3=A4l=C3=A4inen
> <jokke.hamalainen@kolttonen.fi> wrote:
> >
> >
> >
> > ---
> >  libselinux/utils/avcstat.c         | 4 ++--
> >  libselinux/utils/compute_av.c      | 2 +-
> >  libselinux/utils/compute_create.c  | 2 +-
> >  libselinux/utils/compute_member.c  | 2 +-
> >  libselinux/utils/compute_relabel.c | 2 +-
> >  libselinux/utils/compute_user.c    | 4 ++--
> >  libselinux/utils/getfilecon.c      | 2 +-
> >  libselinux/utils/getpidcon.c       | 2 +-
> >  libselinux/utils/getseuser.c       | 2 +-
> >  libselinux/utils/policyvers.c      | 2 +-
> >  libselinux/utils/setfilecon.c      | 2 +-
> >  11 files changed, 13 insertions(+), 13 deletions(-)
> >
> > diff --git a/libselinux/utils/avcstat.c b/libselinux/utils/avcstat.c
> > index 884a10bf..da239287 100644
> > --- a/libselinux/utils/avcstat.c
> > +++ b/libselinux/utils/avcstat.c
> > @@ -116,7 +116,7 @@ int main(int argc, char **argv)
> >                 case 'h':
> >                 case '-':
> >                         usage();
> > -                       exit(0);
> > +                       exit(EXIT_SUCCESS);
>
> I wonder why this is exit success (as well as other spots)? Wouldn't
> something triggering usage be a fail unless they
> asked for usage()? Is that what - is doing ($ avcstat ----)? The man
> page doesn't mention it. Dan what was your thoughts here?
> I'm assuming you wrote it based on the man page and it seems to be
> included from Josh's initial import from SVN.
>
> >                 default:
> >                         usage();
> >                         die("unrecognized parameter '%c'", i);
> > @@ -133,7 +133,7 @@ int main(int argc, char **argv)
> >                 }
> >                 if (n =3D=3D 0) {
> >                         usage();
> > -                       exit(0);
> > +                       exit(EXIT_SUCCESS);
> >                 }
> >                 interval =3D n;
> >         }
> > diff --git a/libselinux/utils/compute_av.c b/libselinux/utils/compute_a=
v.c
> > index 574fa6ed..df4a77e8 100644
> > --- a/libselinux/utils/compute_av.c
> > +++ b/libselinux/utils/compute_av.c
> > @@ -51,5 +51,5 @@ int main(int argc, char **argv)
> >                 printf("\n");
> >         }
> >
> > -       exit(0);
> > +       exit(EXIT_SUCCESS);
> >  }
> > diff --git a/libselinux/utils/compute_create.c b/libselinux/utils/compu=
te_create.c
> > index 4abc29fb..449ccd90 100644
> > --- a/libselinux/utils/compute_create.c
> > +++ b/libselinux/utils/compute_create.c
> > @@ -32,5 +32,5 @@ int main(int argc, char **argv)
> >
> >         printf("%s\n", buf);
> >         freecon(buf);
> > -       exit(0);
> > +       exit(EXIT_SUCCESS);
> >  }
> > diff --git a/libselinux/utils/compute_member.c b/libselinux/utils/compu=
te_member.c
> > index 14edd451..c6dad19e 100644
> > --- a/libselinux/utils/compute_member.c
> > +++ b/libselinux/utils/compute_member.c
> > @@ -32,5 +32,5 @@ int main(int argc, char **argv)
> >
> >         printf("%s\n", buf);
> >         freecon(buf);
> > -       exit(0);
> > +       exit(EXIT_SUCCESS);
> >  }
> > diff --git a/libselinux/utils/compute_relabel.c b/libselinux/utils/comp=
ute_relabel.c
> > index 970750e8..85c760bc 100644
> > --- a/libselinux/utils/compute_relabel.c
> > +++ b/libselinux/utils/compute_relabel.c
> > @@ -32,5 +32,5 @@ int main(int argc, char **argv)
> >
> >         printf("%s\n", buf);
> >         freecon(buf);
> > -       exit(0);
> > +       exit(EXIT_SUCCESS);
> >  }
> > diff --git a/libselinux/utils/compute_user.c b/libselinux/utils/compute=
_user.c
> > index cae62b26..86d00a6e 100644
> > --- a/libselinux/utils/compute_user.c
> > +++ b/libselinux/utils/compute_user.c
> > @@ -27,12 +27,12 @@ int main(int argc, char **argv)
> >
> >         if (!buf[0]) {
> >                 printf("none\n");
> > -               exit(0);
> > +               exit(EXIT_SUCCESS);
> >         }
> >
> >         for (ptr =3D buf; *ptr; ptr++) {
> >                 printf("%s\n", *ptr);
> >         }
> >         freeconary(buf);
> > -       exit(0);
> > +       exit(EXIT_SUCCESS);
> >  }
> > diff --git a/libselinux/utils/getfilecon.c b/libselinux/utils/getfileco=
n.c
> > index a7a51abb..6266ae16 100644
> > --- a/libselinux/utils/getfilecon.c
> > +++ b/libselinux/utils/getfilecon.c
> > @@ -23,5 +23,5 @@ int main(int argc, char **argv)
> >                 printf("%s\t%s\n", argv[i], buf);
> >                 freecon(buf);
> >         }
> > -       exit(0);
> > +       exit(EXIT_SUCCESS);
> >  }
> > diff --git a/libselinux/utils/getpidcon.c b/libselinux/utils/getpidcon.=
c
> > index 3df0da1f..ea6c274e 100644
> > --- a/libselinux/utils/getpidcon.c
> > +++ b/libselinux/utils/getpidcon.c
> > @@ -27,5 +27,5 @@ int main(int argc, char **argv)
> >
> >         printf("%s\n", buf);
> >         freecon(buf);
> > -       exit(0);
> > +       exit(EXIT_SUCCESS);
> >  }
> > diff --git a/libselinux/utils/getseuser.c b/libselinux/utils/getseuser.=
c
> > index c33a4ad2..9193fe0a 100644
> > --- a/libselinux/utils/getseuser.c
> > +++ b/libselinux/utils/getseuser.c
> > @@ -36,5 +36,5 @@ int main(int argc, char **argv)
> >         for (i =3D 0; i < n; i++)
> >                 printf("Context %d\t%s\n", i, contextlist[i]);
> >         freeconary(contextlist);
> > -       exit(0);
> > +       exit(EXIT_SUCCESS);
> >  }
> > diff --git a/libselinux/utils/policyvers.c b/libselinux/utils/policyver=
s.c
> > index 0309d7d1..dd56f2c7 100644
> > --- a/libselinux/utils/policyvers.c
> > +++ b/libselinux/utils/policyvers.c
> > @@ -14,5 +14,5 @@ int main(int argc __attribute__ ((unused)), char **ar=
gv)
> >         }
> >
> >         printf("%d\n", rc);
> > -       exit(0);
> > +       exit(EXIT_SUCCESS);
> >  }
> > diff --git a/libselinux/utils/setfilecon.c b/libselinux/utils/setfileco=
n.c
> > index d69af84a..79af55de 100644
> > --- a/libselinux/utils/setfilecon.c
> > +++ b/libselinux/utils/setfilecon.c
> > @@ -20,5 +20,5 @@ int main(int argc, char **argv)
> >                         exit(2);
> >                 }
> >         }
> > -       exit(0);
> > +       exit(EXIT_SUCCESS);
> >  }
> > --
> > 2.21.0
> >
>
> ack on this as is, since it preserves behavior, but on the usage()
> case I wonder why
> some are not a failure.
