Return-Path: <SRS0=uP1p=TK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9790EC04A6B
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 21:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C5B20989
	for <selinux@archiver.kernel.org>; Fri, 10 May 2019 21:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcQ38Ft8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfEJVAc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 May 2019 17:00:32 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45665 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbfEJVAc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 May 2019 17:00:32 -0400
Received: by mail-oi1-f193.google.com with SMTP id w144so620oie.12
        for <selinux@vger.kernel.org>; Fri, 10 May 2019 14:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=guQTit6f8dsux3n8v4/Ok7qPRwtZInO/ps1JmlENujA=;
        b=LcQ38Ft8RNnsDgGJpM03wI+Op1lY1fyo/69ixzdcYOlnE14Xm6ppSWwra2L6M8+oj4
         8RV1aa6zixffckbwkXmb9NWtEJnnsJaO1e97an/MIlX1VbdLyfqrXoHASzwrHZo79+m3
         1wBeceoCf+eGPEFMgp+riWKSvP93HDMoKGfYzdSlXiW7SiIxRNOD7WKAvG4yO8hPOTPZ
         28AnkWJyLdXiieO4laeBWvt5MRHjK2/NpGQnzETFSdBfsGRpi0+N4ADhU9nZSkKqbIy/
         Ais3OkXks8XOZy1jQAEspunXy5VxgMOoFUBRn3IQScFgMtLEnv4ImPYY1vjnjxjjgsKZ
         5htQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=guQTit6f8dsux3n8v4/Ok7qPRwtZInO/ps1JmlENujA=;
        b=UJgbsFzz1R1H7MxEMPPdRl6MmsgzpbdW7JrXVS/Y/51bFhQ0SjoosHL8t5PhrTU6XD
         7NS2SjKN466nXJFgZaFdHNT+jLqZh6ByGs8Z/CA3GXjD2YJmAVVqaaRjyGFe4KZ10M/K
         leXXRpuuATkMBpxcGaQ0bjW5cbYGqA5iqm+FT3zbQ9sU3+i7O2iwPESG+ENs8wTZffjR
         tREqzSSQ0SWWR40NzCaS9v5vvl0ZJCd0YSImDXl+BX7d7TaumK/9fNgSTQADiAHvuSXM
         2vSpdMd+DgmjIA/FMvpTDPtS06ExPWw+tkfqBDD3t1Cp1UeYyhejj5VYyodj6iQb4ebZ
         tSgg==
X-Gm-Message-State: APjAAAWBTCJaXTYG9ytcJClcPD2/CxAVCj2s/meCaCphVsieJhXPmAdA
        Gfk3dmk2cpjQJ7CC7ab1oSVqDj1gdagFMihJlrw=
X-Google-Smtp-Source: APXvYqwEDJFAdt4yEh3b5fVVWM694cn1cVua6KOSH2yyazHVo8fECTUwWDDHcLbHZtmXYGlIdar96TllyQNFWJWsjbE=
X-Received: by 2002:aca:40c3:: with SMTP id n186mr5963440oia.156.1557522031585;
 Fri, 10 May 2019 14:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LFD.2.21.1905102117140.16225@34-41-5D-CA-59-C7>
In-Reply-To: <alpine.LFD.2.21.1905102117140.16225@34-41-5D-CA-59-C7>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 10 May 2019 14:00:20 -0700
Message-ID: <CAFftDdrWTEXizp=BhcDBfKnh43uDX6dc_683EA_aO8aimpSo_g@mail.gmail.com>
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

On Fri, May 10, 2019 at 12:03 PM Jokke H=C3=A4m=C3=A4l=C3=A4inen
<jokke.hamalainen@kolttonen.fi> wrote:
>
>
>
> ---
>  libselinux/utils/avcstat.c         | 4 ++--
>  libselinux/utils/compute_av.c      | 2 +-
>  libselinux/utils/compute_create.c  | 2 +-
>  libselinux/utils/compute_member.c  | 2 +-
>  libselinux/utils/compute_relabel.c | 2 +-
>  libselinux/utils/compute_user.c    | 4 ++--
>  libselinux/utils/getfilecon.c      | 2 +-
>  libselinux/utils/getpidcon.c       | 2 +-
>  libselinux/utils/getseuser.c       | 2 +-
>  libselinux/utils/policyvers.c      | 2 +-
>  libselinux/utils/setfilecon.c      | 2 +-
>  11 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/libselinux/utils/avcstat.c b/libselinux/utils/avcstat.c
> index 884a10bf..da239287 100644
> --- a/libselinux/utils/avcstat.c
> +++ b/libselinux/utils/avcstat.c
> @@ -116,7 +116,7 @@ int main(int argc, char **argv)
>                 case 'h':
>                 case '-':
>                         usage();
> -                       exit(0);
> +                       exit(EXIT_SUCCESS);

I wonder why this is exit success (as well as other spots)? Wouldn't
something triggering usage be a fail unless they
asked for usage()? Is that what - is doing ($ avcstat ----)? The man
page doesn't mention it. Dan what was your thoughts here?
I'm assuming you wrote it based on the man page and it seems to be
included from Josh's initial import from SVN.

>                 default:
>                         usage();
>                         die("unrecognized parameter '%c'", i);
> @@ -133,7 +133,7 @@ int main(int argc, char **argv)
>                 }
>                 if (n =3D=3D 0) {
>                         usage();
> -                       exit(0);
> +                       exit(EXIT_SUCCESS);
>                 }
>                 interval =3D n;
>         }
> diff --git a/libselinux/utils/compute_av.c b/libselinux/utils/compute_av.=
c
> index 574fa6ed..df4a77e8 100644
> --- a/libselinux/utils/compute_av.c
> +++ b/libselinux/utils/compute_av.c
> @@ -51,5 +51,5 @@ int main(int argc, char **argv)
>                 printf("\n");
>         }
>
> -       exit(0);
> +       exit(EXIT_SUCCESS);
>  }
> diff --git a/libselinux/utils/compute_create.c b/libselinux/utils/compute=
_create.c
> index 4abc29fb..449ccd90 100644
> --- a/libselinux/utils/compute_create.c
> +++ b/libselinux/utils/compute_create.c
> @@ -32,5 +32,5 @@ int main(int argc, char **argv)
>
>         printf("%s\n", buf);
>         freecon(buf);
> -       exit(0);
> +       exit(EXIT_SUCCESS);
>  }
> diff --git a/libselinux/utils/compute_member.c b/libselinux/utils/compute=
_member.c
> index 14edd451..c6dad19e 100644
> --- a/libselinux/utils/compute_member.c
> +++ b/libselinux/utils/compute_member.c
> @@ -32,5 +32,5 @@ int main(int argc, char **argv)
>
>         printf("%s\n", buf);
>         freecon(buf);
> -       exit(0);
> +       exit(EXIT_SUCCESS);
>  }
> diff --git a/libselinux/utils/compute_relabel.c b/libselinux/utils/comput=
e_relabel.c
> index 970750e8..85c760bc 100644
> --- a/libselinux/utils/compute_relabel.c
> +++ b/libselinux/utils/compute_relabel.c
> @@ -32,5 +32,5 @@ int main(int argc, char **argv)
>
>         printf("%s\n", buf);
>         freecon(buf);
> -       exit(0);
> +       exit(EXIT_SUCCESS);
>  }
> diff --git a/libselinux/utils/compute_user.c b/libselinux/utils/compute_u=
ser.c
> index cae62b26..86d00a6e 100644
> --- a/libselinux/utils/compute_user.c
> +++ b/libselinux/utils/compute_user.c
> @@ -27,12 +27,12 @@ int main(int argc, char **argv)
>
>         if (!buf[0]) {
>                 printf("none\n");
> -               exit(0);
> +               exit(EXIT_SUCCESS);
>         }
>
>         for (ptr =3D buf; *ptr; ptr++) {
>                 printf("%s\n", *ptr);
>         }
>         freeconary(buf);
> -       exit(0);
> +       exit(EXIT_SUCCESS);
>  }
> diff --git a/libselinux/utils/getfilecon.c b/libselinux/utils/getfilecon.=
c
> index a7a51abb..6266ae16 100644
> --- a/libselinux/utils/getfilecon.c
> +++ b/libselinux/utils/getfilecon.c
> @@ -23,5 +23,5 @@ int main(int argc, char **argv)
>                 printf("%s\t%s\n", argv[i], buf);
>                 freecon(buf);
>         }
> -       exit(0);
> +       exit(EXIT_SUCCESS);
>  }
> diff --git a/libselinux/utils/getpidcon.c b/libselinux/utils/getpidcon.c
> index 3df0da1f..ea6c274e 100644
> --- a/libselinux/utils/getpidcon.c
> +++ b/libselinux/utils/getpidcon.c
> @@ -27,5 +27,5 @@ int main(int argc, char **argv)
>
>         printf("%s\n", buf);
>         freecon(buf);
> -       exit(0);
> +       exit(EXIT_SUCCESS);
>  }
> diff --git a/libselinux/utils/getseuser.c b/libselinux/utils/getseuser.c
> index c33a4ad2..9193fe0a 100644
> --- a/libselinux/utils/getseuser.c
> +++ b/libselinux/utils/getseuser.c
> @@ -36,5 +36,5 @@ int main(int argc, char **argv)
>         for (i =3D 0; i < n; i++)
>                 printf("Context %d\t%s\n", i, contextlist[i]);
>         freeconary(contextlist);
> -       exit(0);
> +       exit(EXIT_SUCCESS);
>  }
> diff --git a/libselinux/utils/policyvers.c b/libselinux/utils/policyvers.=
c
> index 0309d7d1..dd56f2c7 100644
> --- a/libselinux/utils/policyvers.c
> +++ b/libselinux/utils/policyvers.c
> @@ -14,5 +14,5 @@ int main(int argc __attribute__ ((unused)), char **argv=
)
>         }
>
>         printf("%d\n", rc);
> -       exit(0);
> +       exit(EXIT_SUCCESS);
>  }
> diff --git a/libselinux/utils/setfilecon.c b/libselinux/utils/setfilecon.=
c
> index d69af84a..79af55de 100644
> --- a/libselinux/utils/setfilecon.c
> +++ b/libselinux/utils/setfilecon.c
> @@ -20,5 +20,5 @@ int main(int argc, char **argv)
>                         exit(2);
>                 }
>         }
> -       exit(0);
> +       exit(EXIT_SUCCESS);
>  }
> --
> 2.21.0
>

ack on this as is, since it preserves behavior, but on the usage()
case I wonder why
some are not a failure.
