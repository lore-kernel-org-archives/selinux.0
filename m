Message-ID: <50EC37E2.2000705@tycho.nsa.gov>
Date: Tue, 08 Jan 2013 10:14:42 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Alice Chu <alice.chu@sta.samsung.com>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
Subject: Re: Fixing external/libsepol issues found by Klocwork
References: <C1432A7484D61749AF22A060C2B03C5D1632046A1B@StaEx7mb3.telecom.sna.samsung.com>
In-Reply-To: <C1432A7484D61749AF22A060C2B03C5D1632046A1B@StaEx7mb3.telecom.sna.samsung.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 01/07/2013 08:51 PM, Alice Chu wrote:
> Hello,
>
> Attached you will find the Klocwork report on seandroid master branch external/libsepol. The following is the fix.
> Please review and give me your feedback.
>
> Thank you very much,
> Alice Chu
> ======================================================================================
>>From 1b6465ee62e9d5f1b5c7ef5c69b97bc572472f78 Mon Sep 17 00:00:00 2001
> From: Alice Chu <alice.chu@sta.samsung.com>
> Date: Fri, 4 Jan 2013 15:51:37 -0800
> Subject: [PATCH] Fix issues found by Klocwork
>
> Change-Id: I055d851c95de6326a6833b02a40261f282847c7b
> ---
>   include/sepol/policydb/symtab.h |    1 +
>   src/expand.c                    |   13 +++++++++++++
>   src/genusers.c                  |   11 ++++++++++-
>   src/hierarchy.c                 |    1 +
>   src/link.c                      |    7 ++++++-
>   src/policydb.c                  |    6 ++++--
>   src/policydb_convert.c          |    1 +
>   src/services.c                  |    2 ++
>   src/symtab.c                    |    9 +++++++++
>   src/write.c                     |    1 +
>   10 files changed, 48 insertions(+), 4 deletions(-)
>

> diff --git a/src/symtab.c b/src/symtab.c
> index b3a7aa8..87046b2 100644
> --- a/src/symtab.c
> +++ b/src/symtab.c
> @@ -46,4 +46,13 @@ int symtab_init(symtab_t * s, unsigned int size)
>   	return 0;
>   }
>
> +void symtab_destroy(symtab_t * s)
> +{
> +	if (!s)
> +		return;
> +	if (s->table)
> +		hashtab_destroy(s->table);
> +	free(s);
> +	return;
> +}
>   /* FLASK */

symtab_init() does not allocate s, so symtab_destroy() should not free 
it.  It isn't separately allocated from the containing structure.  Also, 
if you truly want to fully free the symtab, you'll need to pass in a 
destroy function to symtab_destroy and invoke hashtab_map() on the table 
with that destroy function - see for example symtabs_destroy(), 
class_destroy(), etc in policydb.c.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
