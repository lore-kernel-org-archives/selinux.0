Message-ID: <45C8992A.7040906@mentalrootkit.com>
Date: Tue, 06 Feb 2007 10:05:14 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Stefanos Harhalakis <v13@priest.com>, selinux <selinux@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: [patch -trunk] libsepol:  check for unmet requires on	sensitivities
 and categories (Was:  Re: core dump)
References: <200702060412.33276.v13@priest.com>	 <1170765638.12293.362.camel@moss-spartans.epoch.ncsc.mil>	 <1170767196.12293.375.camel@moss-spartans.epoch.ncsc.mil> <1170767757.12293.377.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1170767757.12293.377.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2007-02-06 at 08:06 -0500, Stephen Smalley wrote:
> 
> Second patch below for the trunk (I also stripped the extraneous \n 
> characters from the first patch locally).
> 
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
> 

Acked-by: Karl MacMillan <kmacmillan@mentalrootkit.com> and merged into 
trunk as libsepol 2.0.1.

> Index: libsepol/src/link.c
> ===================================================================
> --- libsepol/src/link.c	(revision 2221)
> +++ libsepol/src/link.c	(working copy)
> @@ -598,6 +598,13 @@
>  			    state->cur_mod_name);
>  			return SEPOL_ENOTSUP;
>  		}
> +		if (scope->scope == SCOPE_REQ) {
> +			/* unmet requirement */
> +			ERR(state->handle,
> +			    "%s: Sensitivity %s not declared by base.",
> +			    state->cur_mod_name, id);
> +			return SEPOL_ENOTSUP;
> +		}
>  	}
>  
>  	state->cur->map[SYM_LEVELS][level->level->sens - 1] =
> @@ -629,6 +636,13 @@
>  			    state->cur_mod_name);
>  			return SEPOL_ENOTSUP;
>  		}
> +		if (scope->scope == SCOPE_REQ) {
> +			/* unmet requirement */
> +			ERR(state->handle,
> +			    "%s: Category %s not declared by base.",
> +			    state->cur_mod_name, id);
> +			return SEPOL_ENOTSUP;
> +		}
>  	}
>  
>  	state->cur->map[SYM_CATS][cat->s.value - 1] = base_cat->s.value;
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
