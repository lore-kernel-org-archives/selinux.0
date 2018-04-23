Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w3NGof5Q014699
 for <selinux@tycho.nsa.gov>; Mon, 23 Apr 2018 12:50:41 -0400
Received: by mail-oi0-f66.google.com with SMTP id y20-v6so14930520oix.5
 for <selinux@tycho.nsa.gov>; Mon, 23 Apr 2018 09:50:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180422193032.8132-1-nicolas.iooss@m4x.org>
References: <20180422193032.8132-1-nicolas.iooss@m4x.org>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Mon, 23 Apr 2018 09:50:36 -0700
Message-ID: <CAFftDdr+rtJ8=FNS00CvdGXKGZf6K_Kix4J3FQvpxMnF7j9EZw@mail.gmail.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 1/1] libsemanage: always check append_arg return
 value
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sun, Apr 22, 2018 at 12:30 PM, Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> When split_args() calls append_arg(), the returned value needs to be
> checked in order to detect memory allocation failure. Checks were
> missing in two places, which are spotted by clang's static analyzer:
>
>     semanage_store.c:1352:7: warning: Value stored to 'rc' is never
>     read
>             rc = append_arg(&argv, &num_args, arg);
>             ^    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     semanage_store.c:1368:3: warning: Value stored to 'rc' is never read
>             rc = append_arg(&argv, &num_args, arg);
>             ^    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libsemanage/src/semanage_store.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
> index 14ad99c152ad..bce648c46464 100644
> --- a/libsemanage/src/semanage_store.c
> +++ b/libsemanage/src/semanage_store.c
> @@ -1350,6 +1350,8 @@ static char **split_args(const char *arg0, char *arg_string,
>                                 if (isspace(*s) && !in_quote && !in_dquote) {
>                                         if (arg != NULL) {
>                                                 rc = append_arg(&argv, &num_args, arg);
> +                                               if (rc)
> +                                                       goto cleanup;
>                                                 free(arg);
>                                                 arg = NULL;
>                                         }
> @@ -1366,6 +1368,8 @@ static char **split_args(const char *arg0, char *arg_string,
>         }
>         if (arg != NULL) {
>                 rc = append_arg(&argv, &num_args, arg);
> +               if (rc)
> +                       goto cleanup;
>                 free(arg);
>                 arg = NULL;
>         }
> --
> 2.17.0
>
>

ack
