To: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov
References: <20180315102711.1593-1-vmojzis@redhat.com>
 <20180319110812.1804-1-vmojzis@redhat.com>
 <20180319110812.1804-2-vmojzis@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <2d3c45af-e082-038f-ab4f-46739239dee7@tycho.nsa.gov>
Date: Mon, 26 Mar 2018 10:01:48 -0400
MIME-Version: 1.0
In-Reply-To: <20180319110812.1804-2-vmojzis@redhat.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH] policycoreutils/semodule: Allow enabling/disabling
 multiple modules at once
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/19/2018 07:08 AM, Vit Mojzis wrote:
> From: Vit Mojzis <vmojzis@localhost.localdomain>
> 
> Unify behaviour for all module actions.
> The same behaviour is already present for -i/-u/-r/-e switches.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1545218

I've put up a PR for this one and your earlier patch for semodule man page / --help usage; assuming no problems, we can merge them anytime.  Sorry for the delay.

https://github.com/SELinuxProject/selinux/pull/88

> 
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  policycoreutils/semodule/semodule.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
> index 504247d3..a76797f5 100644
> --- a/policycoreutils/semodule/semodule.c
> +++ b/policycoreutils/semodule/semodule.c
> @@ -311,28 +311,29 @@ static void parse_command_line(int argc, char **argv)
>  	}
>  
>  	if (optind < argc) {
> -		int mode;
> +		int mode = commands ? (int) commands[num_commands - 1].mode : -1;
>  		/* if -i/u/r/E was the last command treat any remaining
>  		 * arguments as args. Will allow 'semodule -i *.pp' to
>  		 * work as expected.
>  		 */
>  
> -		if (commands && commands[num_commands - 1].mode == INSTALL_M) {
> -			mode = INSTALL_M;
> -		} else if (commands && commands[num_commands - 1].mode == REMOVE_M) {
> -			mode = REMOVE_M;
> -		} else if (commands && commands[num_commands - 1].mode == EXTRACT_M) {
> -			mode = EXTRACT_M;
> -		} else {
> -			fprintf(stderr, "unknown additional arguments:\n");
> -			while (optind < argc)
> -				fprintf(stderr, " %s", argv[optind++]);
> -			fprintf(stderr, "\n\n");
> -			usage(argv[0]);
> -			exit(1);
> +		switch (mode) {
> +			case INSTALL_M:
> +			case REMOVE_M:
> +			case EXTRACT_M:
> +			case ENABLE_M:
> +			case DISABLE_M:
> +				while (optind < argc)
> +					set_mode(mode, argv[optind++]);
> +				break;
> +			default:
> +				fprintf(stderr, "unknown additional arguments:\n");
> +				while (optind < argc)
> +					fprintf(stderr, " %s", argv[optind++]);
> +				fprintf(stderr, "\n\n");
> +				usage(argv[0]);
> +				exit(1);
>  		}
> -		while (optind < argc)
> -			set_mode(mode, argv[optind++]);
>  	}
>  }
>  
> 
