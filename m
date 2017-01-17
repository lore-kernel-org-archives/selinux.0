Message-ID: <1484689106.20454.21.camel@tycho.nsa.gov>
Subject: Re: [PATCH 1/1] libsemanage: genhomedircon: consider
 SEMANAGE_FCONTEXT_DIR in fcontext_matches()
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
Date: Tue, 17 Jan 2017 16:38:26 -0500
In-Reply-To: <20170114110011.13316-1-nicolas.iooss@m4x.org>
References: <20170114110011.13316-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, 2017-01-14 at 12:00 +0100, Nicolas Iooss wrote:
> When generating file_contexts.homedirs, libsemanage enumerates the
> users
> on the system and tries to find misconfiguration issues by comparing
> their home directories with file contexts defined in the policy. The
> comparison is done by fcontext_matches().
> 
> Currently this function only operates on file contexts with type ALL,
> but it makes sense to also operate on the DIR ones, as a comment
> states
> in the function.
> 
> For example on a system with the following entry in /etc/passwd:
> 
>     mytestservice:x:2000:100::/var/lib/mytestservice/dir:/bin/bash
> 
> and with the following file context definition:
> 
>     /var/lib/mytestservice/.* -d
> gen_context(system_u:object_r:var_lib_t,s0)
> 
> "semodule -B" now shows the following warning:
> 
>     libsemanage.get_home_dirs: mytestservice homedir
>     /var/lib/mytestservice/dir or its parent directory conflicts with
> a
>     file context already specified in the policy.  This usually
>     indicates an incorrectly defined system account.  If it is a
> system
>     account please make sure its uid is less than 1000 or greater
> than
>     60000 or its login shell is /sbin/nologin.

Thanks, applied.

> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libsemanage/src/genhomedircon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libsemanage/src/genhomedircon.c
> b/libsemanage/src/genhomedircon.c
> index fd6d391984b6..465dd8829403 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -246,7 +246,7 @@ static int fcontext_matches(const
> semanage_fcontext_t *fcontext, void *varg)
>  
>  	/* Only match ALL or DIR */
>  	type = semanage_fcontext_get_type(fcontext);
> -	if (type != SEMANAGE_FCONTEXT_ALL)
> +	if (type != SEMANAGE_FCONTEXT_ALL && type !=
> SEMANAGE_FCONTEXT_DIR)
>  		return 0;
>  
>  	len = strlen(oexpr);
