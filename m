Message-ID: <44C915F5.8010502@mentalrootkit.com>
Date: Thu, 27 Jul 2006 15:37:25 -0400
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [PATCH RETRY 2/3] Optionally expand neverallows
References: <1153937503.5393.6.camel@twoface> <1153944945.11769.194.camel@moss-spartans.epoch.ncsc.mil> <1154005763.27604.58.camel@moss-spartans.epoch.ncsc.mil> <44C908FD.3090208@tresys.com>
In-Reply-To: <44C908FD.3090208@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Stephen Smalley wrote:
>>
>>
>> Also, suppose hypothetically that one of these policydbs with expanded
>> neverallow rules is passed along to one of the other libsepol functions.
>> What behavior do you want?  Seems like avtab_write_item() would happily
>> write it out, but avtab_read_item() would choke on it (no match in
>> spec_order, so set == 0).  Do you want to be able to save these as
>> binary policy images and use them later for analysis?
>>
> Right, there is no intention to store out these policydbs. This patch 
> is similar to one I already added for access control hooks in 
> libsepol. It marks policies as invalid when you do unsupported things 
> to them, and also skips assertion and hierarchy checking.

Did you mean to include the rename for expand_avrule_decls?
>
> Index: trunk/libsepol/include/sepol/policydb/policydb.h
> ===================================================================
> --- trunk/libsepol/include/sepol/policydb/policydb.h    (revision 951)
> +++ trunk/libsepol/include/sepol/policydb/policydb.h    (working copy)
> @@ -366,6 +366,7 @@
>     uint32_t policy_type;
>     char *name;
>     char *version;
> +    int invalid;
>

Expanding the avrules doesn't really make the policydb invalid, right? 
It just makes it non-standard (tainted :) )

>
>     }
> @@ -2156,7 +2159,7 @@
>         goto cleanup;
>     hashtab_map_remove_on_error(state.out->p_types.table,
>                     type_attr_remove, type_destroy, state.out);
> -    if (check) {
> +    if (check && !(out->invalid)) {
>         if (hierarchy_check_constraints(handle, state.out))
>             goto cleanup;
>

Why disallow hierarchy checking?

> Index: trunk/libsepol/src/write.c
> ===================================================================
> --- trunk/libsepol/src/write.c    (revision 951)
> +++ trunk/libsepol/src/write.c    (working copy)
> @@ -1411,6 +1411,9 @@
>     struct policy_data pd;
>     char *policydb_str;
>
> +    if (p->invalid)
> +        return -1;
> +

A separate return code is needed so that the caller can distinguish 
between general, likely fatal errors and a policydb that can't be 
written because the format doesn't support it.

Karl




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
