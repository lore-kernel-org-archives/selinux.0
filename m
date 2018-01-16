Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w0GFmNfL009786
 for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2018 10:48:23 -0500
Received: by mail-io0-f193.google.com with SMTP id w188so17253958iod.10
 for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2018 07:47:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAB9W1A3F67LHE9bG7C2y7hnoXkxh51RLyvtnsOd98DaSSnohww@mail.gmail.com>
References: <20180114153436.21916-1-richard_c_haines@btinternet.com>
 <CAB9W1A1RmO4jbo-yyZPUNhLU6S9e3C0rmY3ZOLR8TNGd+vx_Xg@mail.gmail.com>
 <CAB9W1A3dOC7G9-=Y1i4Fb=JnQuOO26+dV794nQKZk+cj-A+DXQ@mail.gmail.com>
 <CAB9W1A3F67LHE9bG7C2y7hnoXkxh51RLyvtnsOd98DaSSnohww@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 16 Jan 2018 07:47:49 -0800
Message-ID: <CAFftDdqhzFptFePGfWGT+NwpuzVPb1RAsyitGEy-BeqinS2nRw@mail.gmail.com>
To: Stephen Smalley <stephen.smalley@gmail.com>
Cc: Richard Haines <richard_c_haines@btinternet.com>,
 selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] libsemanage: Allow tmp files to be kept if a compile fails
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Jan 15, 2018 at 9:32 AM, Stephen Smalley
<stephen.smalley@gmail.com> wrote:
> On Jan 14, 2018 10:36 AM, "Richard Haines" <richard_c_haines@btinternet.com>
> wrote:
>
> Add new option to semanage.conf that allows the tmp build files
> to be kept for debugging when building policy.
>
>
> Would it be better to just retain the files by default if there is an error?

I thought about this as well, my reasoning as to why Richard's approach was
better is that if someone does it N times trying to figure out an issue,
then there would be N piles of files in the tmp folder. This way they
have to opt in to have their tmp folder spammed.

>
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  libsemanage/man/man5/semanage.conf.5 |  8 ++++++++
>  libsemanage/src/conf-parse.y         | 15 ++++++++++++++-
>  libsemanage/src/conf-scan.l          |  1 +
>  libsemanage/src/direct_api.c         | 21 ++++++++++++---------
>  libsemanage/src/semanage_conf.h      |  1 +
>  5 files changed, 36 insertions(+), 10 deletions(-)
>
> diff --git a/libsemanage/man/man5/semanage.conf.5
> b/libsemanage/man/man5/semanage.conf.5
> index 8f8de55a..10cab65a 100644
> --- a/libsemanage/man/man5/semanage.conf.5
> +++ b/libsemanage/man/man5/semanage.conf.5
> @@ -121,6 +121,14 @@ and by default it is set to "false".
>  Please note that since this option deletes all HLL files, an updated HLL
> compiler will not be able to recompile the original HLL file into CIL.
>  In order to compile the original HLL file into CIL, the same HLL file will
> need to be reinstalled.
>
> +.TP
> +.B retain-tmp
> +When set to "true", tmp directories (the sandbox at
> \fBstore-root/\fR[\fIpolicy-store\fR]\fB/tmp \fRand/or the final policy at
> \fBstore-root/final/\fR[\fIpolicy-store\fR]) will be retained after
> compilation to allow debugging of any build errors. Note that on a
> successful build the sandbox becomes
> \fBstore-root/\fR[\fIpolicy-store\fR]\fB/active\fR.
> +.br
> +The
> +.B retain-tmp
> +option can be set to either "true" or "false" and by default it is set to
> "false".
> +
>  .SH "SEE ALSO"
>  .TP
>  semanage(8)
> diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
> index b527e893..f098e55d 100644
> --- a/libsemanage/src/conf-parse.y
> +++ b/libsemanage/src/conf-parse.y
> @@ -61,7 +61,7 @@ static int parse_errors;
>
>  %token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE SAVE_PREVIOUS
> SAVE_LINKED TARGET_PLATFORM COMPILER_DIR IGNORE_MODULE_CACHE STORE_ROOT
>  %token LOAD_POLICY_START SETFILES_START SEFCONTEXT_COMPILE_START
> DISABLE_GENHOMEDIRCON HANDLE_UNKNOWN USEPASSWD IGNOREDIRS
> -%token BZIP_BLOCKSIZE BZIP_SMALL REMOVE_HLL
> +%token BZIP_BLOCKSIZE BZIP_SMALL REMOVE_HLL RETAIN_TMP
>  %token VERIFY_MOD_START VERIFY_LINKED_START VERIFY_KERNEL_START BLOCK_END
>  %token PROG_PATH PROG_ARGS
>  %token <s> ARG
> @@ -95,6 +95,7 @@ single_opt:     module_store
>         |       bzip_blocksize
>         |       bzip_small
>         |       remove_hll
> +       |       retain_tmp
>          ;
>
>  module_store:   MODULE_STORE '=' ARG {
> @@ -268,6 +269,17 @@ remove_hll:  REMOVE_HLL'=' ARG {
>         free($3);
>  }
>
> +retain_tmp:  RETAIN_TMP'=' ARG {
> +       if (strcasecmp($3, "false") == 0) {
> +               current_conf->retain_tmp = 0;
> +       } else if (strcasecmp($3, "true") == 0) {
> +               current_conf->retain_tmp = 1;
> +       } else {
> +               yyerror("retain-tmp can only be 'true' or 'false'");
> +       }
> +       free($3);
> +}
> +
>  command_block:
>                  command_start external_opts BLOCK_END  {
>                          if (new_external->path == NULL) {
> @@ -352,6 +364,7 @@ static int semanage_conf_init(semanage_conf_t * conf)
>         conf->bzip_small = 0;
>         conf->ignore_module_cache = 0;
>         conf->remove_hll = 0;
> +       conf->retain_tmp = 0;
>
>         conf->save_previous = 0;
>         conf->save_linked = 0;
> diff --git a/libsemanage/src/conf-scan.l b/libsemanage/src/conf-scan.l
> index 607bbf0b..e26c3494 100644
> --- a/libsemanage/src/conf-scan.l
> +++ b/libsemanage/src/conf-scan.l
> @@ -54,6 +54,7 @@ handle-unknown    return HANDLE_UNKNOWN;
>  bzip-blocksize return BZIP_BLOCKSIZE;
>  bzip-small     return BZIP_SMALL;
>  remove-hll     return REMOVE_HLL;
> +retain-tmp     return RETAIN_TMP;
>  "[load_policy]"   return LOAD_POLICY_START;
>  "[setfiles]"      return SETFILES_START;
>  "[sefcontext_compile]"      return SEFCONTEXT_COMPILE_START;
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index a455612f..5d2a443c 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -326,7 +326,10 @@ static void semanage_direct_destroy(semanage_handle_t *
> sh
>  static int semanage_direct_disconnect(semanage_handle_t * sh)
>  {
>         /* destroy transaction */
> -       if (sh->is_in_transaction) {
> +       if (sh->is_in_transaction)
> +               semanage_release_trans_lock(sh);
>
>
> Is it safe to release the trans lock before deleting the sandbox?
>
> +
> +       if (!sh->conf->retain_tmp && sh->is_in_transaction) {
>                 /* destroy sandbox */
>                 if (semanage_remove_directory
>                     (semanage_path(SEMANAGE_TMP, SEMANAGE_TOPLEVEL)) < 0) {
> @@ -342,7 +345,6 @@ static int semanage_direct_disconnect(semanage_handle_t
> * sh)
>                                                 SEMANAGE_FINAL_TOPLEVEL));
>                         return -1;
>                 }
> -               semanage_release_trans_lock(sh);
>         }
>
>         /* Release object databases: local modifications */
> @@ -1639,13 +1641,14 @@ cleanup:
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
> +       /* Delete sandbox unless requested by semanage.conf */
> +       if (!sh->conf->retain_tmp) {
> +               semanage_remove_directory(semanage_path
> +                                         (SEMANAGE_TMP,
> SEMANAGE_TOPLEVEL));
> +               semanage_remove_directory(semanage_final_path
> +                                         (SEMANAGE_FINAL_TMP,
> +                                          SEMANAGE_FINAL_TOPLEVEL));
> +       }
>         umask(mask);
>
>         return retval;
> diff --git a/libsemanage/src/semanage_conf.h
> b/libsemanage/src/semanage_conf.h
> index c99ac8c7..f7bba754 100644
> --- a/libsemanage/src/semanage_conf.h
> +++ b/libsemanage/src/semanage_conf.h
> @@ -46,6 +46,7 @@ typedef struct semanage_conf {
>         int bzip_blocksize;
>         int bzip_small;
>         int remove_hll;
> +       int retain_tmp;
>         int ignore_module_cache;
>         char *ignoredirs;       /* ";" separated of list for genhomedircon
> to ignore */
>         struct external_prog *load_policy;
> --
> 2.14.3
>
>
>



-- 
Respectfully,

William C Roberts
