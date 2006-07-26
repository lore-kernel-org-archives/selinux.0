Subject: Re: [PATCH RETRY 2/3] Optionally expand neverallows
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, kmacmillan@mentalrootkit.com
In-Reply-To: <1153937503.5393.6.camel@twoface>
References: <1153937503.5393.6.camel@twoface>
Content-Type: text/plain
Date: Wed, 26 Jul 2006 16:15:45 -0400
Message-Id: <1153944945.11769.194.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-07-26 at 14:11 -0400, Joshua Brindle wrote:
> The setools team would like to be able to optionally expand neverallow
> rules for analysis purposes.  This patch leaves the current behavior
> unchanged, but allows a new state variable for the expander to indicate
> whether neverallow rules should get expanded, and creates an init
> function for the expand_state struct. This has the earlier suggestions
> incorporated.

> @@ -1200,7 +1205,8 @@ static int expand_rule_helper(sepol_hand
>  		if (!ebitmap_node_get_bit(snode, i))
>  			continue;
>  		if (source_rule->flags & RULE_SELF) {
> -			if (source_rule->specified & AVRULE_AV) {
> +			if (source_rule->
> +			    specified & (AVRULE_AV | AVRULE_NEVERALLOW)) {
>  				if ((retval =
>  				     expand_avrule_helper(handle,
>  							  source_rule->

I don't see any occurrences of AVRULE_AV by itself after this patch, so
why wouldn't you just fold AVRULE_NEVERALLOW into it?  We don't need to
preserve interface for static users of the library.

> @@ -1264,13 +1271,14 @@ static int convert_and_expand_rule(sepol
>  				   policydb_t * dest_pol, uint32_t * typemap,
>  				   avrule_t * source_rule, avtab_t * dest_avtab,
>  				   cond_av_list_t ** cond,
> -				   cond_av_list_t ** other, int enabled)
> +				   cond_av_list_t ** other, int enabled,
> +				   int do_neverallow)
>  {
>  	int retval;
>  	ebitmap_t stypes, ttypes;
>  	unsigned char alwaysexpand;
>  
> -	if (source_rule->specified & AVRULE_NEVERALLOW)
> +	if (!do_neverallow && source_rule->specified & AVRULE_NEVERALLOW)
>  		return 1;

Hmm...do you want alwaysexpand = 1 for the do_neverallow case?
Otherwise, type attributes might not get expanded.  Does
expand_avtab_insert need to know about AVTAB_NEVERALLOW?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
