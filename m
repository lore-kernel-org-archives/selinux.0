Message-ID: <45C89B98.4040709@mentalrootkit.com>
Date: Tue, 06 Feb 2007 10:15:36 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Stefanos Harhalakis <v13@priest.com>, selinux <selinux@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: [patch] libsepol:  check for unmet requires on sensitivities
 and	categories (Was:  Re: core dump)
References: <200702060412.33276.v13@priest.com>	 <1170765638.12293.362.camel@moss-spartans.epoch.ncsc.mil> <1170767196.12293.375.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1170767196.12293.375.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2007-02-06 at 07:40 -0500, Stephen Smalley wrote:
>> On Tue, 2007-02-06 at 04:12 +0200, Stefanos Harhalakis wrote:
>>> I had this issue today:
>>>
>>> # semodule -i logging.pp 
>>> Segmentation fault (core dumped)
>>>
>>> I traced this a bit and it seems that this is because of libsepol. 
>>> The core dump is the result of lines 602:603 of link.c:
>>>
>>> (gdb) bt
>>> #0  0xb7f732fd in sens_copy_callback (key=0x848c2a0 "s15", datum=0x848c290, data=0xbfde3854) at link.c:602
>>> #1  0xb7f6f8a1 in hashtab_map (h=0x846cbf0, apply=0xb7f731d1 <sens_copy_callback>, args=0xbfde3854) at hashtab.c:214
>>> #2  0xb7f75528 in copy_identifiers (state=0xbfde3854, src_symtab=0x843cc74, dest_decl=0x0) at link.c:1323
>>> #3  0xb7f77c72 in link_modules (handle=0x804c710, b=0x80525b8, mods=0x863ce18, len=19, verbose=0) at link.c:2178
>>> #4  0xb7f7a2c9 in sepol_link_packages (handle=0x804c710, base=0x8053060, modules=0x80543c8, num_modules=19, verbose=0) at module.c:302
>>>
>>> Where:
>>>
>>> (gdb) l
>>> 597                                 state->cur_mod_name);
>>> 598                             return -SEPOL_LINK_NOTSUP;
>>> 599                     }
>>> 600             }
>>> 601     
>>> 602             state->cur->map[SYM_LEVELS][level->level->sens - 1] =
>>> 603                 base_level->level->sens;
>>> 604     
>>> 605             return 0;
>>> 606     }
>>>
>>> Because of:
>>>
>>> (gdb) p base_level
>>> $1 = (level_datum_t *) 0x0
>>>
>>> The last 'if' checks for !base_level, but inside the 'if' block, only 
>>> !scope and scope->scope==SCOPE_DECL are checked.
>>>
>>> This core dump is caused by:
>>>
>>> (gdb) p scope->scope
>>> $2 = 1
>>>
>>> Which is noted as:
>>>
>>> /* Required for this decl */
>>> #define SCOPE_REQ  1
>>>
>>> in libsepol/include/sepol/policydb/policydb.h
>>>
>>> Hope this helps...
>> Looks like your logging.pp policy module has a requires on sensitivity
>> s15 but your base module doesn't declare it.  Naturally, that should
>> show up as an unfulfilled requirement rather than a seg fault.
> 
> Patch below for the stable branch.
> 
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
> 

Acked-by: Karl MacMillan <kmacmillan@mentalrootkit.com> and merged as 
libsepol 1.16.1.

> Index: libsepol/src/link.c
> ===================================================================
> --- libsepol/src/link.c	(revision 2221)
> +++ libsepol/src/link.c	(working copy)
> @@ -597,6 +597,13 @@
>  			    state->cur_mod_name);
>  			return -SEPOL_LINK_NOTSUP;
>  		}
> +		if (scope->scope == SCOPE_REQ) {
> +			/* unmet requirement */
> +			ERR(state->handle,
> +			    "%s:  Sensitivity %s not declared by base.\n",
> +			    state->cur_mod_name, id);
> +			return -SEPOL_LINK_NOTSUP;
> +		}
>  	}
>  
>  	state->cur->map[SYM_LEVELS][level->level->sens - 1] =
> @@ -628,6 +635,13 @@
>  			    state->cur_mod_name);
>  			return -SEPOL_LINK_NOTSUP;
>  		}
> +		if (scope->scope == SCOPE_REQ) {
> +			/* unmet requirement */
> +			ERR(state->handle,
> +			    "%s:  Category %s not declared by base.\n",
> +			    state->cur_mod_name, id);
> +			return -SEPOL_LINK_NOTSUP;
> +		}
>  	}
>  
>  	state->cur->map[SYM_CATS][cat->s.value - 1] = base_cat->s.value;
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
