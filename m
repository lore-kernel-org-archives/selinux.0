Subject: Re: [PATCH] libselinux: raw string_to_class/string_to_av_perm
 variants
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: SELinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <4ACCF117.4060807@tycho.nsa.gov>
References: <4ACCE820.4080007@tycho.nsa.gov>
	 <4ACCF117.4060807@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 08 Oct 2009 08:23:19 -0400
Message-Id: <1255004599.2182.13.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-10-07 at 15:50 -0400, Eamon Walsh wrote:
> This patch adds support for remapping classes and permissions on policy 
> reload.  This is accomplished by separating the code that computes the 
> "real" kernel class and permission values into a helper function, 
> mapping_compute().  This function is called both from 
> selinux_set_mapping() when the user specifies a new mapping, and from 
> the netlink code when a policyload notification is received.  The 
> function now builds up a temporary mapping and swaps it in rather than 
> working on the active mapping in place.
> 
> Issue: There is a race condition in which old class and permission 
> values may arrive from userspace after a kernel policyload has taken 
> place.  Fixing this would require a string interface to the kernel, or 
> some kind of transaction support.
> 
> Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
> ---
> 
>   avc_internal.c |   17 +++++++
>   mapping.c      |  130 +++++++++++++++++++++++++++++++++++++++++++--------------
>   mapping.h      |   10 ++++
>   3 files changed, 126 insertions(+), 31 deletions(-)
> 
> 

> diff --git a/libselinux/src/mapping.c b/libselinux/src/mapping.c
> index f9858ce..eb99eb3 100644
> --- a/libselinux/src/mapping.c
> +++ b/libselinux/src/mapping.c
<snip>
> +static int
> +mapping_compute(struct selinux_mapping *map, int size, int free_strings)
> +{
> +	struct selinux_mapping *old_mapping;
> +	int old_mapping_size, i;
> +	unsigned k;
> +
> +	/* Find the real, kernel values for the names */
> +	for (i = 1; i<  size; i++) {
> +		map[i].value = string_to_security_class_raw(map[i].name);
> +		if (!map[i].value)
> +			return -1;
> +
> +		for (k = 0; k<  map[i].num_perms; k++) {
> +			if (!map[i].names[k])
> +				continue;
> +			map[i].perms[k] = string_to_av_perm_raw(
> +				map[i].value, map[i].names[k]);
> +			if (!map[i].perms[k])
> +				return -1;
> +		}
> +	}
> +
> +	/* Switch in the new mapping */
> +	old_mapping_size = current_mapping_size;
> +	old_mapping = current_mapping;
> +	current_mapping_size = size;
> +	current_mapping = map;
> +	mapping_free(old_mapping, old_mapping_size, free_strings);

I don't think this is quite safe.  Other threads might see new value of
current_mapping_size while still having old value of current_mapping, or
might dereference the old current_mapping value after it has been freed.
In the kernel security server, we have the policy rdlock guarding reads
to it and the policy wrlock guarding the switching of the two values.

If you moved the call to this function inside of avc_ss_reset() after
taking the avc lock, then that would exclude interleaving calls to
security_compute_av() via avc_has_perm(), although not direct calls to
it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
