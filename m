Message-ID: <46674C16.40005@tycho.nsa.gov>
Date: Wed, 06 Jun 2007 20:06:46 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>,
        "sds >> Stephen Smalley" <sds@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [PATCH 3/5] libselinux: add string<->value functions that use
 discovery
References: <1181157090.6578.38.camel@sgc.columbia.tresys.com>
In-Reply-To: <1181157090.6578.38.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> Add new value->name, name->value functions that use object class discovery.
> 
> Signed-off-by: Chris PeBenito <cpebenito@tresys.com>
> 
> ---
>  libselinux/src/stringrep.c |   56 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> Index: selinux-obj-class-discovery/libselinux/src/stringrep.c
> ===================================================================
> --- selinux-obj-class-discovery.orig/libselinux/src/stringrep.c
> +++ selinux-obj-class-discovery/libselinux/src/stringrep.c
> @@ -407,6 +407,62 @@ static const char *security_av_perm_to_s
>  	return NULL;
>  }
>  
> +security_class_t string_to_security_class(const char *s)
> +{
> +	struct discover_class_node *node;
> +
> +	node = get_class_cache_entry_name(s);
> +	if (node == NULL) {
> +		node = discover_class(s);
> +
> +		if (node == NULL)
> +			return 0;
> +	}
> +
> +	return node->value;
> +}
> +
> +access_vector_t string_to_av_perm(security_class_t tclass, const char *s)
> +{
> +	struct discover_class_node *node;
> +
> +	node = get_class_cache_entry_value(tclass);
> +	if (node != NULL) {
> +		size_t i;
> +		for (i=0; i<MAXVECTORS && node->perms[i] != NULL; i++)
> +			if (strcmp(node->perms[i],s) == 0)
> +				return (1<<i);

I think if you fall off the end of this loop, you may want to flush the
cache and try once more.  This would handle the case where the policy
was reloaded with new permission bits added to the class.  This is a
pretty obscure corner case so maybe it's not worth the effort.  But see
comments about netlink below.

> +	}
> +
> +	return 0;

Set errno to EINVAL, as mentioned earlier.

> +}
> +
> +const char *security_class_to_string(security_class_t tclass)
> +{
> +	struct discover_class_node *node;
> +
> +	node = get_class_cache_entry_value(tclass);
> +	if (node == NULL)
> +		return NULL;
> +	else
> +		return node->name;
> +}
> +
> +const char *security_av_perm_to_string(security_class_t tclass,
> +				       access_vector_t av)
> +{
> +	struct discover_class_node *node;
> +	size_t i;
> +
> +	node = get_class_cache_entry_value(tclass);
> +	if (av && node)
> +		for (i = 0; i<MAXVECTORS; i++)
> +			if ((1<<i) & av)
> +				return node->perms[i];

Likewise here, if you hit a NULL node->perms[i] you may want to flush
the cache and try again.

Do we want to flush the cache when a netlink reload notification comes
in?  I don't necessarily think that the kernel should allow a policy
reload that moves or deletes classes and permissions.  But in theory
(disregarding race conditions), this patchset along with use of the
mapping support could allow a userspace object manager to keep working
across a policy reload that does move things around and/or delete unused
values.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
