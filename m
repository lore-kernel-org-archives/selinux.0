MIME-Version: 1.0
In-Reply-To: <20180508143254.28306-1-sds@tycho.nsa.gov>
References: <20180508143254.28306-1-sds@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 8 May 2018 09:24:46 -0700
Message-ID: <CAFftDdrkUuzbMs7Oz_vjuZiaHJ=NN4Nt7aQZBfg+WTUKyzeFfg@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] libsemanage: prevent string overflow on final
 paths
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, May 8, 2018 at 7:32 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Verify that the final path does not exceed the size of the
> buffer before copying.  This can only occur if an alternate
> path for the policy root and/or the policy store root has been
> specified and if the resulting path would exceed PATH_MAX. A
> similar check is already applied by semanage_make_final().
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  libsemanage/src/semanage_store.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
> index bce648c4..f1984c50 100644
> --- a/libsemanage/src/semanage_store.c
> +++ b/libsemanage/src/semanage_store.c
> @@ -1597,7 +1597,12 @@ static int semanage_install_final_tmp(semanage_handle_t * sh)
>                 /* skip genhomedircon if configured */
>                 if (sh->conf->disable_genhomedircon &&
>                     i == SEMANAGE_FC_HOMEDIRS) continue;
> -
> +
> +               if (strlen(dst) >= sizeof(fn)) {
> +                       ERR(sh, "Unable to compose the final paths.");
> +                       status = -1;
> +                       goto cleanup;
> +               }
>                 strcpy(fn, dst);
>                 ret = semanage_mkpath(sh, dirname(fn));
>                 if (ret < 0) {
> --
> 2.14.3
>

ack
