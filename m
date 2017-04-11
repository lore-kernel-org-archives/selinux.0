Message-ID: <1491934702.14576.4.camel@tycho.nsa.gov>
Subject: Re: [PATCH] policycoreutils/load_policy: Drop is_selinux_enabled()
 check
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Luis Ressel <aranea@aixah.de>, selinux@tycho.nsa.gov
Date: Tue, 11 Apr 2017 14:18:22 -0400
In-Reply-To: <20170407120507.3815-1-aranea@aixah.de>
References: <20170407120507.3815-1-aranea@aixah.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-04-07 at 14:05 +0200, Luis Ressel wrote:
> This check is a remnant of the libselinux <2.5 era, back when
> is_selinux_enabled() checked whether a policy had been loaded.
> Nowadays
> it only checks whether selinuxfs is mounted, and "load_policy -i"
> therefore incorrectly refuses operation when selinuxfs is mounted,
> but
> no policy has been loaded yet.
> 
> While it doesn't make much sense to call selinux_init_load_policy()
> twice, there's no harm in doing so either, so let's just drop this
> safeguard instead of fixing it.

Thanks, applied.

> ---
>  policycoreutils/load_policy/load_policy.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/policycoreutils/load_policy/load_policy.c
> b/policycoreutils/load_policy/load_policy.c
> index 7c2c2a7..2707d6f 100644
> --- a/policycoreutils/load_policy/load_policy.c
> +++ b/policycoreutils/load_policy/load_policy.c
> @@ -65,13 +65,6 @@ int main(int argc, char **argv)
>  			argv[0], argv[optind++]);
>  	}
>  	if (init) {
> -		if (is_selinux_enabled() == 1) {
> -			/* SELinux is already enabled, we should not
> do an initial load again */
> -			fprintf(stderr,
> -					_("%s:  Policy is already
> loaded and initial load requested\n"),
> -					argv[0]);
> -			exit(2);
> -		}
>  		ret = selinux_init_load_policy(&enforce);
>  		if (ret != 0 ) {
>  			if (enforce > 0) {
