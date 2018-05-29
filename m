Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4TEuC9x029306
 for <selinux@tycho.nsa.gov>; Tue, 29 May 2018 10:56:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC08.oob.disa.mil (Postfix) with SMTP id 40wGwW3lYmz34qRm
 for <selinux@tycho.nsa.gov>; Tue, 29 May 2018 14:54:51 +0000 (UTC)
Received: from UPDC3CPA07_EEMSG_MP23.eemsg.mil (unknown [192.168.18.18])
 by UPDCF3IC08.oob.disa.mil (Postfix) with ESMTP id 40wGwV4pBQz34qRY
 for <selinux@tycho.nsa.gov>; Tue, 29 May 2018 14:54:50 +0000 (UTC)
Received: by mail-ot0-f194.google.com with SMTP id l13-v6so17271379otk.9
 for <selinux@tycho.nsa.gov>; Tue, 29 May 2018 07:54:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180526184213.4896-8-nicolas.iooss@m4x.org>
References: <20180526184213.4896-1-nicolas.iooss@m4x.org>
 <20180526184213.4896-8-nicolas.iooss@m4x.org>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 29 May 2018 07:46:19 -0700
Message-ID: <CAFftDdq9nC1n_6My9PWgSi34b2vVbRArLRS6m3jRGWUAPyBgSg@mail.gmail.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 7/7] libsepol: destroy the copied va_list
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

ack

On Sat, May 26, 2018 at 11:42 AM, Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> va_copy()'s manpage [1] states:
>
>     Each invocation of va_copy() must be matched by a corresponding
>     invocation of va_end() in the same function.
>
> create_str_helper() is using va_copy() without va_end(). Add the missing
> call.
>
> [1] https://linux.die.net/man/3/va_copy
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libsepol/src/kernel_to_common.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_common.c
> index 342bc3c91df9..7c5699c52c95 100644
> --- a/libsepol/src/kernel_to_common.c
> +++ b/libsepol/src/kernel_to_common.c
> @@ -80,10 +80,13 @@ static char *create_str_helper(const char *fmt, int num, va_list vargs)
>                 goto exit;
>         }
>
> +       va_end(vargs2);
> +
>         return str;
>
>  exit:
>         free(str);
> +       va_end(vargs2);
>         return NULL;
>  }
>
> --
> 2.17.0
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
