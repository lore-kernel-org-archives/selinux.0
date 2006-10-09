Message-ID: <452A94A2.8040905@us.ibm.com>
Date: Mon, 09 Oct 2006 13:27:46 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Michael C Thompson <thompsmc@us.ibm.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH 2/4] make newrole suid
References: <4526D5C6.3090505@us.ibm.com>
In-Reply-To: <4526D5C6.3090505@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Michael C Thompson wrote:
> This is the 2nd of 4 patches.
> This patch applies against policycoreutils-1.30.30-1.
> 
> Changes:
>  * main is changed in the following ways:
>    - remove the duplicated functionality for patch 1/4
>    - set to call the new functions
>    - introduces better error handling and cleanup paths
> 
> Signed-off-by: Michael Thompson <thompsmc@us.ibm.com>
> 
> 
> 
> ------------------------------------------------------------------------
> 
> diff -Naur policycoreutils-1.30.30/newrole/newrole.c policycoreutils-1.30.30.suid/newrole/newrole.c
> --- policycoreutils-1.30.30/newrole/newrole.c	2006-10-06 17:01:10.000000000 -0500
> +++ policycoreutils-1.30.30.suid/newrole/newrole.c	2006-10-06 17:00:18.000000000 -0500
<snip>
>  	if (!is_selinux_enabled()) {
> -		fprintf(stderr,
> -			_
> -			("Sorry, newrole may be used only on a SELinux kernel.\n"));
> -		exit(-1);
> +		fprintf(stderr, _("Sorry, newrole may be used only on "
> +			"a SELinux kernel.\n"));
> +		return -1;
>  	}
> -	enforcing = security_getenforce();
> -	if (enforcing < 0) {
> +
> +	if (security_getenforce()) {
>  		fprintf(stderr, _("Could not determine enforcing mode.\n"));
> -		exit(-1);
> +		return -1;
>  	}

Rather embarrassing, but this was overlooked by myself before I sent 
this patch out. It's been fixed on my side.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
