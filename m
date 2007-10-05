Subject: Re: [PATCH 3/3] libselinux: minor updates to AVC, mapping,
	callbacks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <47052C83.3020703@tycho.nsa.gov>
References: <47041CB6.8070408@tycho.nsa.gov>
	 <47052C83.3020703@tycho.nsa.gov>
Content-Type: text/plain
Date: Fri, 05 Oct 2007 10:23:53 -0400
Message-Id: <1191594233.891.15.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-10-04 at 14:10 -0400, Eamon Walsh wrote:
> This patch allows empty strings to be specified as permissions in
> the dynamic permission mapping.  An empty string will be interpreted
> as a "skipped bit" which allows userspace object managers to use
> non-contiguous permission bits.
> 
> Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>

Merged all three, although we can revisit the last one if you find a
cleaner solution.

> ---
> 
>  mapping.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> 
> Index: libselinux/src/mapping.c
> ===================================================================
> --- libselinux/src/mapping.c	(revision 2628)
> +++ libselinux/src/mapping.c	(working copy)
> @@ -68,6 +68,11 @@
>  
>  		k = 0;
>  		while (p_in->perms && p_in->perms[k]) {
> +			/* An empty permission string skips ahead */
> +			if (!*p_in->perms[k]) {
> +				k++;
> +				continue;
> +			}
>  			p_out->perms[k] = string_to_av_perm(p_out->value,
>  							    p_in->perms[k]);
>  			if (!p_out->perms[k])
> @@ -111,6 +116,7 @@
>  
>  		for (i=0; i<current_mapping[tclass].num_perms; i++)
>  			if (tperm & (1<<i)) {
> +				assert(current_mapping[tclass].perms[i]);
>  				kperm |= current_mapping[tclass].perms[i];
>  				tperm &= ~(1<<i);
>  			}
> 
> 
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
