Message-ID: <1484847158.28584.14.camel@tycho.nsa.gov>
Subject: Re: [PATCH] policycoreutils/hll/pp: Fix pp crash when processing
 base module
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov
Date: Thu, 19 Jan 2017 12:32:38 -0500
In-Reply-To: <1484822049-4082-1-git-send-email-vmojzis@redhat.com>
References: <1484822049-4082-1-git-send-email-vmojzis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-01-19 at 11:34 +0100, Vit Mojzis wrote:
> Policy module structure created by libsepol out of base module
> contains NULL in module name, which results in segfault in "pp"
> compiler. Add NULL check.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1350806

Thanks, applied.

> 
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  policycoreutils/hll/pp/pp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/policycoreutils/hll/pp/pp.c
> b/policycoreutils/hll/pp/pp.c
> index 2c9f53f..7f9afb0 100644
> --- a/policycoreutils/hll/pp/pp.c
> +++ b/policycoreutils/hll/pp/pp.c
> @@ -141,7 +141,7 @@ int main(int argc, char **argv)
>  		if (separator) {
>  			*separator = '\0';
>  		}
> -		if (strcmp(mod_name, cil_name) != 0) {
> +		if (mod_name && strcmp(mod_name, cil_name) != 0) {
>  			fprintf(stderr,	"Warning: SELinux
> userspace will refer to the module from %s as %s rather than %s\n",
> ifile, mod_name, cil_name);
>  		}
>  		free(cil_path);
