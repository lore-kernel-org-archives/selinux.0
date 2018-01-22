Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w0MLOaBC007690
 for <selinux@tycho.nsa.gov>; Mon, 22 Jan 2018 16:24:36 -0500
Received: by mail-oi0-f65.google.com with SMTP id a28so810986oiy.12
 for <selinux@tycho.nsa.gov>; Mon, 22 Jan 2018 12:43:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180122163836.16567-1-richard_c_haines@btinternet.com>
References: <20180122163836.16567-1-richard_c_haines@btinternet.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Mon, 22 Jan 2018 12:43:43 -0800
Message-ID: <CAFftDdrWB95R9iX32CY5n1K-f98q4jET1tfrNX8qo+KMrkdAwg@mail.gmail.com>
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH V2] libsemanage: Allow tmp files to be kept if a
 compile fails
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Jan 22, 2018 at 8:38 AM, Richard Haines
<richard_c_haines@btinternet.com> wrote:
> Allow the tmp build files to be kept for debugging when a policy
> build fails.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
> V2 Changes:
> Remove the retain-tmp flag and just keep tmp files on build errors.
>
>  libsemanage/src/direct_api.c | 54 ++++++++++++++++++++++++++++++--------------
>  libsemanage/src/handle.c     |  2 ++
>  libsemanage/src/handle.h     |  1 +
>  3 files changed, 40 insertions(+), 17 deletions(-)
>
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index a455612f..3d1cf1fe 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -323,26 +323,44 @@ static void semanage_direct_destroy(semanage_handle_t * sh
>         /* do nothing */
>  }
>
> -static int semanage_direct_disconnect(semanage_handle_t * sh)
> +static int semanage_remove_tmps(semanage_handle_t *sh)
>  {
> -       /* destroy transaction */
> -       if (sh->is_in_transaction) {
> -               /* destroy sandbox */
> -               if (semanage_remove_directory
> -                   (semanage_path(SEMANAGE_TMP, SEMANAGE_TOPLEVEL)) < 0) {
> +       if (sh->commit_err)
> +               return 0;
> +
> +       /* destroy sandbox if it exists */
> +       if (semanage_remove_directory
> +           (semanage_path(SEMANAGE_TMP, SEMANAGE_TOPLEVEL)) < 0) {
> +               if (errno != ENOENT) {
>                         ERR(sh, "Could not cleanly remove sandbox %s.",
>                             semanage_path(SEMANAGE_TMP, SEMANAGE_TOPLEVEL));
>                         return -1;
>                 }
> -               if (semanage_remove_directory
> -                   (semanage_final_path(SEMANAGE_FINAL_TMP,
> -                                        SEMANAGE_FINAL_TOPLEVEL)) < 0) {
> +       }
> +
> +       /* destroy tmp policy if it exists */
> +       if (semanage_remove_directory
> +           (semanage_final_path(SEMANAGE_FINAL_TMP,
> +                                SEMANAGE_FINAL_TOPLEVEL)) < 0) {
> +               if (errno != ENOENT) {
>                         ERR(sh, "Could not cleanly remove tmp %s.",
>                             semanage_final_path(SEMANAGE_FINAL_TMP,
>                                                 SEMANAGE_FINAL_TOPLEVEL));
>                         return -1;
>                 }
> +       }
> +
> +       return 0;
> +}
> +
> +static int semanage_direct_disconnect(semanage_handle_t *sh)
> +{
> +       int retval = 0;
> +
> +       /* destroy transaction and remove tmp files if no commit error */
> +       if (sh->is_in_transaction) {
>                 semanage_release_trans_lock(sh);
> +               retval = semanage_remove_tmps(sh);
>         }
>
>         /* Release object databases: local modifications */
> @@ -375,7 +393,7 @@ static int semanage_direct_disconnect(semanage_handle_t * sh)
>         /* Release object databases: active kernel policy */
>         bool_activedb_dbase_release(semanage_bool_dbase_active(sh));
>
> -       return 0;
> +       return retval;
>  }
>
>  static int semanage_direct_begintrans(semanage_handle_t * sh)
> @@ -1639,13 +1657,15 @@ cleanup:
>
>         free(fc_buffer);
>
> -       /* regardless if the commit was successful or not, remove the
> -          sandbox if it is still there */
> -       semanage_remove_directory(semanage_path
> -                                 (SEMANAGE_TMP, SEMANAGE_TOPLEVEL));
> -       semanage_remove_directory(semanage_final_path
> -                                 (SEMANAGE_FINAL_TMP,
> -                                  SEMANAGE_FINAL_TOPLEVEL));
> +       /* Set commit_err so other functions can detect any errors. Note that
> +        * retval > 0 will be the commit number.
> +        */
> +       if (retval < 0)
> +               sh->commit_err = retval;
> +
> +       if (semanage_remove_tmps(sh) != 0)
> +               retval = -1;
> +
>         umask(mask);
>
>         return retval;
> diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
> index 4ce1df03..a6567bd4 100644
> --- a/libsemanage/src/handle.c
> +++ b/libsemanage/src/handle.c
> @@ -86,6 +86,8 @@ semanage_handle_t *semanage_handle_create(void)
>          * If any changes are made, this flag is ignored */
>         sh->do_rebuild = 0;
>
> +       sh->commit_err = 0;
> +
>         /* By default always reload policy after commit if SELinux is enabled. */
>         sh->do_reload = (is_selinux_enabled() > 0);
>
> diff --git a/libsemanage/src/handle.h b/libsemanage/src/handle.h
> index 1780ac81..65b15600 100644
> --- a/libsemanage/src/handle.h
> +++ b/libsemanage/src/handle.h
> @@ -62,6 +62,7 @@ struct semanage_handle {
>         int is_in_transaction;
>         int do_reload;          /* whether to reload policy after commit */
>         int do_rebuild;         /* whether to rebuild policy if there were no changes */
> +       int commit_err;         /* set by semanage_direct_commit() */

The other comments here have more information on what they mean, while
I like that
it indicates whom twiddles this bit, i'd like to see information on
what it means
and who consumes it.

It'll take me a day to produce any meaningful comments on the code body, silence
means I don't have any.

>         int modules_modified;
>         int create_store;       /* whether to create the store if it does not exist
>                                  * this will only have an effect on direct connections */
> --
> 2.14.3
>
>
