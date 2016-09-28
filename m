MIME-Version: 1.0
In-Reply-To: <1475078037-20217-1-git-send-email-william.c.roberts@intel.com>
References: <1475078037-20217-1-git-send-email-william.c.roberts@intel.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 28 Sep 2016 12:02:05 -0400
Message-ID: <CAFftDdpRZ=LfD49ez0FMnAE3FDkxPpgU9BkM2dWK9+0fcMbRuA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: fix unused variable error
To: William Roberts <william.c.roberts@intel.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Sep 28, 2016 at 11:53 AM,  <william.c.roberts@intel.com> wrote:
> From: William Roberts <william.c.roberts@intel.com>
>
> When building for Android, this error manifests itself:
>
> label_file.c:570:7: error: unused variable ‘subs_file’ [-Werror=unused-variable]
>   char subs_file[PATH_MAX + 1];
>

FYI this just happened when building with ANDROID_HOST=y on my
development branch, so I am
assuming some Makefile change introduced a hard error on it... inside
the android tree, it was still
building, without even printing a warning as well.

> Fix it by moving the variable into the ifdef'd usage block.
>
> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>  libselinux/src/label_file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index adf3dcc..a4dc3cd 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -567,7 +567,6 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
>         struct saved_data *data = (struct saved_data *)rec->data;
>         const char *path = NULL;
>         const char *prefix = NULL;
> -       char subs_file[PATH_MAX + 1];
>         int status = -1, baseonly = 0;
>
>         /* Process arguments */
> @@ -585,6 +584,7 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
>                 }
>
>  #if !defined(BUILD_HOST) && !defined(ANDROID)
> +       char subs_file[PATH_MAX + 1];
>         /* Process local and distribution substitution files */
>         if (!path) {
>                 rec->dist_subs =
> --
> 1.9.1
>
> _______________________________________________
> Seandroid-list mailing list
> Seandroid-list@tycho.nsa.gov
> To unsubscribe, send email to Seandroid-list-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Seandroid-list-request@tycho.nsa.gov.
