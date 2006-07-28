Subject: Re: [PATCH RETRY 2/3] Optionally expand neverallows
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, kmacmillan@mentalrootkit.com, jmowery@tresys.com
In-Reply-To: <1154025241.10023.3.camel@twoface.columbia.tresys.com>
References: <1153937503.5393.6.camel@twoface>
	 <1153944945.11769.194.camel@moss-spartans.epoch.ncsc.mil>
	 <1154025241.10023.3.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 28 Jul 2006 08:16:57 -0400
Message-Id: <1154089017.31881.22.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-07-27 at 14:34 -0400, Joshua Brindle wrote:
> Index: trunk/libsepol/src/link.c
> ===================================================================
> --- trunk/libsepol/src/link.c	(revision 951)
> +++ trunk/libsepol/src/link.c	(working copy)
> @@ -965,8 +965,7 @@
>  			    module->map[SYM_CLASSES][cur_perm->class - 1];
>  			assert(new_perm->class);
>  
> -			if (new_rule->
> -			    specified & (AVRULE_AV | AVRULE_NEVERALLOW)) {
> +			if (new_rule->specified & (AVRULE_AV)) {
>  				for (i = 0;
>  				     i <
>  				     module->perm_map_len[cur_perm->class - 1];
> 
> 
> > Hmm...do you want alwaysexpand = 1 for the do_neverallow case?
> > Otherwise, type attributes might not get expanded.  Does
> > expand_avtab_insert need to know about AVTAB_NEVERALLOW?
> 
> No, apol doesn't always want the attributes expanded out, it knows how
> to deal with attributes.

Hmm...but is apol ok with the fact that attributes will be expanded in
some cases here, since we always expand attributes for:
- type rules
- self rules
- type sets that have negative sets (-) or flags (~)

I'm not sure I understand what apol wants as output; at present, it will
get a mixture of expanded and unexpanded attributes.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
