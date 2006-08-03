Subject: Re: [PATCH 1/2] Optionally expand neverallows, propagate errors in
	policydb
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Jeremy A. Mowery" <jmowery@tresys.com>
Cc: selinux@tycho.nsa.gov, selinux-dev@tresys.com
In-Reply-To: <1154612344.12897.43.camel@Bishop.columbia.tresys.com>
References: <1154612344.12897.43.camel@Bishop.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 12:19:28 -0400
Message-Id: <1154621968.32479.65.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-08-03 at 09:39 -0400, Jeremy A. Mowery wrote:
> This patch allows neverallow rules to be expanded into the avtab for
> analysis purposes. This option is added to the expand state structure
> (and set to off by default).  When neverallows are expanded, the
> unsupported_format flag is set for the policydb disallowing hierarchy
> and assertion checking, and disabling writing the binary file. The read
> and write functions now recognize this state and appropriate defines
> were added for the return values.
> 
> (This is a resend of the previous patch set with corrections made as per
> suggestions on the list.)
> 
> Jeremy A. Mowery
> Tresys Technology
> 410-290-1411 x148

> diff -urpN -x 'Change*' -x entries -x '*.orig' -x '*.rej' -x '*.svn*' -x '*.swp' trunk/libsepol/src/expand.c branch/setools_public-policydb-components/libsepol/src/expand.c
> --- trunk/libsepol/src/expand.c	2006-07-13 13:57:39.000000000 -0400
> +++ trunk/libsepol/src/expand.c	2006-08-01 11:05:06.000000000 -0400
> @@ -1007,6 +1008,10 @@ static avtab_ptr_t find_avtab_node(sepol
>  	return node;
>  }
>  
> +#define EXPAND_RULE_SUCCESS   1
> +#define EXPAND_RULE_CONFLICT  0
> +#define EXPAND_RULE_ERROR    -1

Ok, so now you are preserving the original return values.
But you still don't update all callers to check for the #define'd symbol
rather than the hardcoded value of 1 for success (look for != 1).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
