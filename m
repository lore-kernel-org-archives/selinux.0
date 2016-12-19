Message-ID: <1482173007.28570.55.camel@tycho.nsa.gov>
Subject: Re: [PATCH 6/7] libsemanage: genhomedircon: drop ustr dependency
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
Date: Mon, 19 Dec 2016 13:43:27 -0500
In-Reply-To: <20161219130404.11496-7-nicolas.iooss@m4x.org>
References: <20161219130404.11496-1-nicolas.iooss@m4x.org>
 <20161219130404.11496-7-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2016-12-19 at 14:04 +0100, Nicolas Iooss wrote:
> ustr library uses old (pre-C99) "extern inline" semantic. This makes
> it
> incompatible with recent versions of gcc and clang, which default to
> C99 standard. Distributions have shipped patched versions of this
> library to fix issues (e.g. Gentoo package uses this patch:
> https://gitweb.gentoo.org/repo/gentoo.git/tree/dev-libs/ustr/files/us
> tr-1.0.4-gcc_5-
> check.patch?id=7dea6f8820f36bf389e6315044bea7507553bed0
> ) but there is no upstream solution to make ustr compatible with C99
> standard.
> 
> The git tree of ustr (http://www.and.org/ustr/ustr.git) has not been
> updated since 2008 and the developer of this project did not reply to
> emails.
> 
> Therefore update genhomedircon implementation in order to no longer
> rely on ustr library.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libsemanage/src/genhomedircon.c | 137 +++++++++++++++++++-----------
> ----------
>  1 file changed, 66 insertions(+), 71 deletions(-)
> 
> diff --git a/libsemanage/src/genhomedircon.c
> b/libsemanage/src/genhomedircon.c
> index 5e9d7224a06e..4b7352c8648a 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
<snip>
> @@ -624,10 +619,9 @@ static int
> write_contexts(genhomedircon_settings_t *s, FILE *out,
>  
>  		if (strcmp(old_context_str, CONTEXT_NONE) == 0) {
>  			if (check_line(s, line) == STATUS_SUCCESS &&
> -			    !ustr_io_putfileline(&line, out)) {
> +			    fprintf(out, "%s\n", line) < 0) {
>  				goto fail;
>  			}
> -
>  			continue;

We will leak the memory referenced by 'line' here.

>  		}
>  
