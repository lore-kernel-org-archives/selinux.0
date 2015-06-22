Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5MJeQe5020849
 for <selinux@tycho.nsa.gov>; Mon, 22 Jun 2015 15:40:26 -0400
Received: by obctg8 with SMTP id tg8so120188789obc.3
 for <selinux@tycho.nsa.gov>; Mon, 22 Jun 2015 12:40:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1434979390-12058-1-git-send-email-sds@tycho.nsa.gov>
References: <1434979390-12058-1-git-send-email-sds@tycho.nsa.gov>
Date: Mon, 22 Jun 2015 12:40:24 -0700
Message-ID: <CABXk95BWHXXzq4=KCcs5LSVpY=HJ6TVJFh+aa1xh3-DCi7jifg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Correctly handle an empty file_contexts file.
From: Jeffrey Vander Stoep <jeffv@google.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Acked-by:  Jeff Vander Stoep <jeffv@google.com>

On Mon, Jun 22, 2015 at 6:23 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> If you add some local file contexts via semanage fcontext -a and
> later delete them all via semanage fcontext -D, you get an empty
> file_contexts.local file.  Then when you try to load it, getline()
> returns 0 and we fall through to the out path without having set rc.
> In label_file.c, rc will always be non-zero at this point because
> we will have failed the load_mmap() call.  In sefcontext_compile,
> rc may contain random garbage at this point.  Explicitly set rc
> before the loop.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  libselinux/src/label_file.c           | 3 ++-
>  libselinux/utils/sefcontext_compile.c | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 1d6c36e..4faf808 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -425,9 +425,10 @@ static int process_file(const char *path, const char *suffix,
>                 goto out;
>
>         /*
> -        * The do detailed validation of the input and fill the spec array
> +        * Then do detailed validation of the input and fill the spec array
>          */
>         lineno = 0;
> +       rc = 0;
>         while (getline(&line_buf, &line_len, fp) > 0) {
>                 rc = process_line(rec, path, prefix, line_buf, ++lineno);
>                 if (rc)
> diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
> index 1c46af8..a93105d 100644
> --- a/libselinux/utils/sefcontext_compile.c
> +++ b/libselinux/utils/sefcontext_compile.c
> @@ -35,6 +35,7 @@ static int process_file(struct selabel_handle *rec, const char *filename)
>         }
>
>         line_num = 0;
> +       rc = 0;
>         while (getline(&line_buf, &line_len, context_file) > 0) {
>                 rc = process_line(rec, filename, prefix, line_buf, ++line_num);
>                 if (rc)
> --
> 2.1.0
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
