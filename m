Message-ID: <45C892DC.7050607@mentalrootkit.com>
Date: Tue, 06 Feb 2007 09:38:20 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: V13 <v13@priest.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux <selinux@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: [patch] libsepol:  check for unmet requires on sensitivities
 and categories (Was:  Re: core dump)
References: <200702060412.33276.v13@priest.com> <1170765638.12293.362.camel@moss-spartans.epoch.ncsc.mil> <1170767196.12293.375.camel@moss-spartans.epoch.ncsc.mil> <200702061524.29509.v13@priest.com>
In-Reply-To: <200702061524.29509.v13@priest.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

V13 wrote:
> On Tuesday 06 February 2007 15:06, Stephen Smalley wrote:
>> Patch below for the stable branch.
>>
>> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
>>
>> Index: libsepol/src/link.c
>> ===================================================================
>> --- libsepol/src/link.c	(revision 2221)
>> +++ libsepol/src/link.c	(working copy)
>> @@ -597,6 +597,13 @@
>>  			    state->cur_mod_name);
>>  			return -SEPOL_LINK_NOTSUP;
>>  		}
>> +		if (scope->scope == SCOPE_REQ) {
>> +			/* unmet requirement */
>> +			ERR(state->handle,
>> +			    "%s:  Sensitivity %s not declared by base.\n",
>> +			    state->cur_mod_name, id);
>> +			return -SEPOL_LINK_NOTSUP;
>> +		}
>>  	}
> 
> May I recomend that an:
> 
> assert(0);
> 
> been added at the end of the outter if statement or there is no way that 
> another SCOPE_ value will be added in the future.

I think this is a good practice in general, but it's not likely that 
another scope will be added.

  In the latter case, perhaps
> an enum (for the SCOPE_* values) and a switch() (instead of the ifs) would be 
> better. gcc warns on switch() statements that don't handle all values of an 
> enum.
> 

Enums aren't used often in libsepol and I'd rather not change to that 
style now.

Thanks - Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
