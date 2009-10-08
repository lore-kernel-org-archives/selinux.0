Subject: Re: [PATCH] libselinux: raw string_to_class/string_to_av_perm
 variants
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: SELinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <4ACCE820.4080007@tycho.nsa.gov>
References: <4ACCE820.4080007@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 08 Oct 2009 08:13:38 -0400
Message-Id: <1255004018.2182.3.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-10-07 at 15:12 -0400, Eamon Walsh wrote:
> This is the first patch in a series to add dynamic class and permission 
> remapping support.  The kernel has recently gained support for such 
> remapping, where the class and permission values exposed in 
> /selinux/class may change on policy reload.  Hence libselinux must do 
> its own remapping in response to policy reloads.
> 
> This patch adds internal "raw" variants of string_to_security_class() 
> and string_to_av_perm().  These are used by the mapping code when 
> setting up a new mapping.
> 
> Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
> ---
> 
>   mapping.h   |   11 +++++++++++
>   stringrep.c |   21 +++++++++++++++------
>   2 files changed, 26 insertions(+), 6 deletions(-)
> 
> 

> diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
> index b19bce7..c82d07a 100644
> --- a/libselinux/src/stringrep.c
> +++ b/libselinux/src/stringrep.c
> @@ -453,31 +453,40 @@ security_class_t string_to_security_class(const char *s)
<snip>
> +access_vector_t string_to_av_perm_raw(security_class_t kclass, const char *s)
>   {
>   	struct discover_class_node *node;
> -	security_class_t kclass = unmap_class(tclass);
>   	__selinux_once(once, init_obj_class_compat);
> 
>   	if (obj_class_compat)
> -		return map_perm(tclass, string_to_av_perm_compat(kclass, s));
> +		return string_to_av_perm_compat(kclass, s);
> 
>   	node = get_class_cache_entry_value(kclass);
>   	if (node != NULL) {
>   		size_t i;
>   		for (i=0; i<MAXVECTORS&&  node->perms[i] != NULL; i++)
>   			if (strcmp(node->perms[i],s) == 0)
> -				return map_perm(tclass, 1<<i);
> +				return 1<<i;
>   	}
> 
>   	errno = EINVAL;
>   	return 0;
>   }
> 
> +access_vector_t string_to_av_perm(security_class_t tclass, const char *s)
> +{
> +	return map_perm(tclass, string_to_av_perm_raw(map_class(tclass), s));
> +}
> +

Shouldn't this be unmap_class(tclass)?

BTW, speaking of it in terms of kernel vs mapped values is confusing,
especially now that the kernel itself is performing mapping.  The actual
distinction is policy values (unmapped) vs. object manager (mapped)
values.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
