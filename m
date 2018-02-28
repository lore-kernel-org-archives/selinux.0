Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1SHr1fa021198
 for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2018 12:53:01 -0500
Received: by mail-oi0-f68.google.com with SMTP id g5so2412512oiy.8
 for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2018 09:52:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180228101510.21023-2-vmojzis@redhat.com>
References: <1498485334.13301.9.camel@tycho.nsa.gov>
 <20180228101510.21023-1-vmojzis@redhat.com>
 <20180228101510.21023-2-vmojzis@redhat.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 28 Feb 2018 09:52:57 -0800
Message-ID: <CAFftDdpaQkXpABA1A5kkS4+ps7s2FzPEPo_wNqRg+dJDbGuiWA@mail.gmail.com>
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 2/3] libsemanage: remove access() check to make
 setuid programs work
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Feb 28, 2018 at 2:15 AM, Vit Mojzis <vmojzis@redhat.com> wrote:
> F_OK access checks only work properly as long as all directories along
> the path are accessible to real user running the program.
> Replace F_OK access checks by testing return value of open, write, etc.
>
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1186431
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  libsemanage/src/direct_api.c | 39 +++++++++++++++------------------------
>  1 file changed, 15 insertions(+), 24 deletions(-)
>
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index b7899d68..f4d57cf8 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -1563,34 +1563,25 @@ rebuild:
>                 goto cleanup;
>         }
>
> -       path = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_LOCAL);
> -       if (access(path, F_OK) == 0) {
> -               retval = semanage_copy_file(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_LOCAL),
> -                                                       semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_LOCAL),
> -                                                       sh->conf->file_mode);
> -               if (retval < 0) {
> -                       goto cleanup;
> -               }
> +       retval = semanage_copy_file(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_LOCAL),
> +                                               semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_LOCAL),
> +                                               sh->conf->file_mode);
> +       if (retval < 0 && errno != ENOENT) {
> +               goto cleanup;
>         }
>
> -       path = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC);
> -       if (access(path, F_OK) == 0) {
> -               retval = semanage_copy_file(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC),
> -                                                       semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC),
> -                                                       sh->conf->file_mode);
> -               if (retval < 0) {
> -                       goto cleanup;
> -               }
> +       retval = semanage_copy_file(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC),
> +                                               semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC),
> +                                               sh->conf->file_mode);
> +       if (retval < 0 && errno != ENOENT) {
> +               goto cleanup;
>         }
>
> -       path = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_SEUSERS);
> -       if (access(path, F_OK) == 0) {
> -               retval = semanage_copy_file(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_SEUSERS),
> -                                                       semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_SEUSERS),
> -                                                       sh->conf->file_mode);
> -               if (retval < 0) {
> -                       goto cleanup;
> -               }
> +       retval = semanage_copy_file(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_SEUSERS),
> +                                               semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_SEUSERS),
> +                                               sh->conf->file_mode);
> +       if (retval < 0 && errno != ENOENT) {
> +               goto cleanup;
>         }
>
>         /* run genhomedircon if its enabled, this should be the last operation
> --
> 2.14.3
>
>

tentative ack. I need to run tests on this one, but it looks fine. I
suspect this should work looking at semanage_copy_file() internals.
