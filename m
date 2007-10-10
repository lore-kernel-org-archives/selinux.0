Subject: Re: [RFC PATCH v4 1/3] [SELinux] Add a capabilities bitmap to
	SELinux policy version 22
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20071005193245.28034.67610.stgit@flek.americas.hpqcorp.net>
References: <20071005192619.28034.62276.stgit@flek.americas.hpqcorp.net>
	 <20071005193245.28034.67610.stgit@flek.americas.hpqcorp.net>
Content-Type: text/plain
Date: Wed, 10 Oct 2007 14:16:34 -0400
Message-Id: <1192040194.2687.75.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-10-05 at 15:32 -0400, Paul Moore wrote:
> Add a new policy capabilities bitmap to SELinux policy version 22.  This bitmap
> will enable the security server to query the policy to determine which features
> it supports.
> ---
> 
>  security/selinux/Kconfig            |    2 -
>  security/selinux/include/security.h |   15 ++++++
>  security/selinux/selinuxfs.c        |   89 +++++++++++++++++++++++++++++++++--
>  security/selinux/ss/policydb.c      |   18 +++++++
>  security/selinux/ss/policydb.h      |    2 +
>  security/selinux/ss/services.c      |   62 ++++++++++++++++++++++++
>  6 files changed, 181 insertions(+), 7 deletions(-)
> 

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 6100fc0..7059400 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -59,6 +60,8 @@
>  extern void selnl_notify_policyload(u32 seqno);
>  unsigned int policydb_loaded_version;
>  
> +int selinux_policycap_netpeer;
> +
>  /*
>   * This is declared in avc.c
>   */
> @@ -1304,6 +1307,9 @@ int security_load_policy(void *data, size_t len)
>  			return -EINVAL;
>  		}
>  		policydb_loaded_version = policydb.policyvers;
> +		selinux_policycap_netpeer =
> +		  ebitmap_get_bit(&policydb.policycaps,
> +				  POLICYDB_CAPABILITY_NETPEER);
>  		ss_initialized = 1;
>  		seqno = ++latest_granting;
>  		LOAD_UNLOCK;

Only handles the initial policy load case, not reloads.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
