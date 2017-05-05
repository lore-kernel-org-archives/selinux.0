Message-ID: <1494004221.5745.11.camel@tycho.nsa.gov>
Subject: Re: [PATCH 2/2] libsepol: silence false-positive -Wwrite-strings
 warning
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
Date: Fri, 05 May 2017 13:10:21 -0400
In-Reply-To: <20170503205802.19751-2-nicolas.iooss@m4x.org>
References: <20170503205802.19751-1-nicolas.iooss@m4x.org>
 <20170503205802.19751-2-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-05-03 at 22:58 +0200, Nicolas Iooss wrote:
> When compiling with -Wwrite-strings, the compiler complains about
> calling strs_add with a const char* value for a char* parameter
> (DEFAULT_OBJECT is defined to "object_r"). Silence this warning by
> casting the literal string to char*.

Thanks, applied both patches.  At some point we should likely fix
strs_add() though to take const char *.

> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libsepol/src/kernel_to_cil.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libsepol/src/kernel_to_cil.c
> b/libsepol/src/kernel_to_cil.c
> index e873ac3a1981..3a1c0be76f45 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -2369,7 +2369,7 @@ static int write_user_decl_rules_to_cil(FILE
> *out, struct policydb *pdb)
>  				goto exit;
>  			}
>  
> -			rc = strs_add(role_strs, DEFAULT_OBJECT);
> +			rc = strs_add(role_strs, (char
> *)DEFAULT_OBJECT);
>  			if (rc != 0) {
>  				strs_destroy(&role_strs);
>  				goto exit;
