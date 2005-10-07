Message-ID: <4346CE4C.1030201@tresys.com>
Date: Fri, 07 Oct 2005 15:36:44 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux-dev@tresys.com,
   dwalsh@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
References: <43454A61.8010907@cornell.edu>	<1128626875.15836.168.camel@moss-spartans.epoch.ncsc.mil>	<1128695426.1450.26.camel@moss-spartans.epoch.ncsc.mil>	<1128700358.1450.39.camel@moss-spartans.epoch.ncsc.mil> <1128709856.1450.75.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1128709856.1450.75.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2005-10-07 at 11:52 -0400, Stephen Smalley wrote:
> 
>>On Fri, 2005-10-07 at 10:30 -0400, Stephen Smalley wrote:
>>
>>>Ok, I've made a first cut at the changes to libsepol and updated it and
>>>checkpolicy to build again, and am starting to work through libsemanage.
>>>As an example of what to expect, the diff below to database_direct.[ch]
>>>was needed to get it to compile again.
>>
>>A more interesting example - conversion of direct_api.c.
> 
> 
> Still more interesting example - conversion of semanage_store.c.
> This brings in the expand/link interfaces.  A few things to note,
> primarily directed at the Tresys folks since this was their code:
> - AFAICS the calls to policydb_index* were unneeded; they are already
> called as appropriate by the libsepol functions to update the indices.
> Possibly legacy of earlier versions of the libsepol code?

Yes, this is probably legacy from before everything was always indexed.

> - Enabling of the global branch moved into sepol_expand_module based on
> a new parameter, so that libsemanage and other callers don't need access
> to the policydb definition.  Not sure how you plan to selectively enable
> in the future.

I don't know of any reason to selectively enable the global branch, it 
should always be enabled or else there won't be any rules in the 
expanded policy.

> - expand_module already set the output type, so we only need to adjust
> the version here (and I changed it to use the kernel's policyvers if
> available instead of the config, as that is what will be loaded by
> load_policy now).

Hrm... Would it be better to always expand it to the latest format we 
know about and handle downgrading at write time? What if the kernel 
policyvery is lower than the requested write version? There is a 
possibility of lost information.

> - AFAICS the calls to load_isids were bogus/unneeded, unless you were
> trying to use their error checking as a side effect, in which case we
> should do that as part of expand_module.

yes, expand_module is probably a better place to do it (for error 
checking)..

<snip>
> @@ -1165,7 +1157,7 @@ int semanage_link_sandbox(semanage_handl
>  	}
>  	free(module_filenames);
>  	for (i = 0; mods != NULL && i < num_modules; i++) {
> -		sepol_module_package_destroy(mods[i]);
> +		sepol_module_package_free(mods[i]);
>  	}
>  	free(mods);
>  	return retval;

What is this?

> @@ -1176,31 +1168,24 @@ int semanage_link_sandbox(semanage_handl
>   * error.
>   */
>  int semanage_expand_sandbox(semanage_handle_t *sh, sepol_module_package_t *base) {
> -	policydb_t out;
> +	struct sepol_policydb *out;
>  	int retval = -1;
>  	const char *kernel_filename = NULL;
> -	sidtab_t sidtab;
> -	struct policy_file pf;
> +	struct sepol_policy_file *pf;
> +	int policyvers = security_policyvers();
>  	FILE *outfile = NULL;
>  
> -	memset(&out, 0, sizeof(out));
> +	if (policyvers < 0)
> +		policyvers = sh->conf->policyvers;
>  

Only if the kernel policyvers lookup fails we use the config file?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
