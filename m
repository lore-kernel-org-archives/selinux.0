Subject: Re: upstart/SELinux problem loading the wrong policy with kernel
	version change
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Chad Sellers <csellers@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <1207661386.21223.272.camel@moss-spartans.epoch.ncsc.mil>
References: <47FACB0F.5050208@redhat.com>
	 <1207659261.21223.261.camel@moss-spartans.epoch.ncsc.mil>
	 <1207661386.21223.272.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 18 Apr 2008 10:32:59 -0400
Message-Id: <1208529179.18883.476.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-04-08 at 09:29 -0400, Stephen Smalley wrote:
> If we are not setting local definitions or preserving booleans, then the
> maximum policy version for load can be the max of the kernel-supported
> version and the libsepol-supported version since we do not need to
> manipulate the policy image prior to load.

This patch has been merged, although it doesn't fully solve the problem
that started this thread (only helps when the kernel is updated to the
new policy version).

> Index: trunk/libselinux/src/load_policy.c
> ===================================================================
> --- trunk/libselinux/src/load_policy.c	(revision 2858)
> +++ trunk/libselinux/src/load_policy.c	(working copy)
> @@ -43,6 +43,9 @@
>  
>  int load_setlocaldefs hidden = 1;
>  
> +#undef max
> +#define max(a, b) (((a) > (b)) ? (a) : (b))
> +
>  int selinux_mkload_policy(int preservebools)
>  {	
>  	int kernvers = security_policyvers();
> @@ -127,11 +130,6 @@
>  
>  #endif
>  
> -	if (usesepol) {
> -		maxvers = vers_max();
> -		minvers = vers_min();
> -	}
> -
>  	/*
>  	 * Check whether we need to support local boolean and user definitions.
>  	 */
> @@ -157,6 +155,13 @@
>  	if (preservebools && uname(&uts) == 0 && strverscmp(uts.release, "2.6.22") >= 0)
>  		preservebools = 0;
>  
> +	if (usesepol) {
> +		maxvers = vers_max();
> +		minvers = vers_min();
> +		if (!setlocaldefs && !preservebools)
> +			maxvers = max(kernvers, maxvers);
> +	}
> +
>  	vers = maxvers;
>        search:
>  	snprintf(path, sizeof(path), "%s.%d",
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
