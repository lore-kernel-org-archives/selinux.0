Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w3NGsIg7014903
 for <selinux@tycho.nsa.gov>; Mon, 23 Apr 2018 12:54:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID16.oob.disa.mil (Postfix) with SMTP id 40VCGv4Bdgz1P6vR
 for <selinux@tycho.nsa.gov>; Mon, 23 Apr 2018 16:54:15 +0000 (UTC)
Received: from USFB3CPA04_EEMSG_MP26.eemsg.mil (unknown [192.168.16.21])
 by USFBF3ID16.oob.disa.mil (Postfix) with ESMTP id 40VCGv2QSZz1P6v3
 for <selinux@tycho.nsa.gov>; Mon, 23 Apr 2018 16:54:15 +0000 (UTC)
Received: by mail-oi0-f67.google.com with SMTP id n65-v6so14934468oig.6
 for <selinux@tycho.nsa.gov>; Mon, 23 Apr 2018 09:54:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180422192148.7320-2-nicolas.iooss@m4x.org>
References: <20180422192148.7320-1-nicolas.iooss@m4x.org>
 <20180422192148.7320-2-nicolas.iooss@m4x.org>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Mon, 23 Apr 2018 09:54:13 -0700
Message-ID: <CAFftDdq8sfyE5w-1-_-psMc5547cvh5zXvZ0ZWDgkpc8vk1o_w@mail.gmail.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 2/2] sestatus: free process and file contexts
 which are checked
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sun, Apr 22, 2018 at 12:21 PM, Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> clang's static analyzer reports a potential memory leak because the
> buffers allocated in pc and fc are not freed in main(), in sestatus.c.
> Free these buffers properly.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  policycoreutils/sestatus/sestatus.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/policycoreutils/sestatus/sestatus.c b/policycoreutils/sestatus/sestatus.c
> index d7f198c2fa0d..9a92e72ff4fd 100644
> --- a/policycoreutils/sestatus/sestatus.c
> +++ b/policycoreutils/sestatus/sestatus.c
> @@ -436,6 +436,7 @@ int main(int argc, char **argv)
>                         printf("%s\n", context);
>                         freecon(context);
>                 }
> +               free(pc[i]);
>         }
>
>         printf("\nFile contexts:\n");
> @@ -478,6 +479,7 @@ int main(int argc, char **argv)
>                                 freecon(context);
>                         }
>                 }
> +               free(fc[i]);
>         }
>
>         return 0;
> --
> 2.17.0
>
>
ack on both patches in this series.
