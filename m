Message-ID: <459BD6AA.9070201@mentalrootkit.com>
Date: Wed, 03 Jan 2007 11:15:38 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Patch to load_policy to enforce quiet option
References: <456E06BE.1030007@redhat.com>
In-Reply-To: <456E06BE.1030007@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> 
> 

This patch was merged as policycoreutils 1.33.7.

Karl

> ------------------------------------------------------------------------
> 
> diff --exclude-from=exclude --exclude POTFILES.in --exclude='*.po' --exclude='*.pot' -N -u -r nsapolicycoreutils/load_policy/load_policy.c policycoreutils-1.33.5/load_policy/load_policy.c
> --- nsapolicycoreutils/load_policy/load_policy.c	2006-11-16 17:14:31.000000000 -0500
> +++ policycoreutils-1.33.5/load_policy/load_policy.c	2006-11-28 10:44:25.000000000 -0500
> @@ -50,12 +50,12 @@
>  	nargs = argc - optind;
>  	if (nargs > 2)
>  		usage(argv[0]);
> -	if (nargs >= 1) {
> -		fprintf(stderr,
> -			"%s:  Warning!  Policy file argument (%s) is no longer supported, installed policy is always loaded.  Continuing...\n",
> -			argv[0], argv[optind++]);
> +	if (nargs >= 1 && !quiet) {
> +			fprintf(stderr,
> +				"%s:  Warning!  Policy file argument (%s) is no longer supported, installed policy is always loaded.  Continuing...\n",
> +				argv[0], argv[optind++]);
>  	}
> -	if (nargs == 2) {
> +	if (nargs == 2 && ! quiet) {
>  		fprintf(stderr,
>  			"%s:  Warning!  Boolean file argument (%s) is no longer supported, installed booleans file is always used.  Continuing...\n",
>  			argv[0], argv[optind++]);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
