Message-ID: <1483979664.20858.75.camel@tycho.nsa.gov>
Subject: Re: [PATCH 1/2] libsemanage: genhomedircon: remove duplicated test
 condition
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
Date: Mon, 09 Jan 2017 11:34:24 -0500
In-Reply-To: <20170104214623.24674-1-nicolas.iooss@m4x.org>
References: <20170104214623.24674-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-01-04 at 22:46 +0100, Nicolas Iooss wrote:
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libsemanage/src/genhomedircon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libsemanage/src/genhomedircon.c
> b/libsemanage/src/genhomedircon.c
> index 7ceeafb7b5d9..fd6d391984b6 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -246,7 +246,7 @@ static int fcontext_matches(const
> semanage_fcontext_t *fcontext, void *varg)
>  
>  	/* Only match ALL or DIR */
>  	type = semanage_fcontext_get_type(fcontext);
> -	if (type != SEMANAGE_FCONTEXT_ALL && type !=
> SEMANAGE_FCONTEXT_ALL)
> +	if (type != SEMANAGE_FCONTEXT_ALL)

The comment suggests the second test should be against
SEMANAGE_FCONTEXT_DIR, not removed altogether.

>  		return 0;
>  
>  	len = strlen(oexpr);
