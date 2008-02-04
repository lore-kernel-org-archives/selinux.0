Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m14NfomU004098
	for <selinux@tycho.nsa.gov>; Mon, 4 Feb 2008 18:41:50 -0500
Received: from us.intercode.com.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m14NflT7008846
	for <selinux@tycho.nsa.gov>; Mon, 4 Feb 2008 23:41:48 GMT
Date: Tue, 5 Feb 2008 10:40:54 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, bunk@kernel.org
Subject: Re: [PATCH] SELinux: Remove security_get_policycaps()
In-Reply-To: <20080204200747.22110.42876.stgit@flek.americas.hpqcorp.net>
Message-ID: <Xine.LNX.4.64.0802051040230.1137@us.intercode.com.au>
References: <20080204200747.22110.42876.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 4 Feb 2008, Paul Moore wrote:

> The security_get_policycaps() functions has a couple of bugs in it and it
> isn't currently used by any in-tree code, so get rid of it and all of it's
> bugginess.
> 
> Signed-off-by: Paul Moore <paul.moore@hp.com>

Applied to for-linus, should be pushed soon.

> ---
> 
>  security/selinux/include/security.h |    1 -
>  security/selinux/ss/services.c      |   33 ---------------------------------
>  2 files changed, 0 insertions(+), 34 deletions(-)
> 
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index 23137c1..837ce42 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -107,7 +107,6 @@ int security_get_classes(char ***classes, int *nclasses);
>  int security_get_permissions(char *class, char ***perms, int *nperms);
>  int security_get_reject_unknown(void);
>  int security_get_allow_unknown(void);
> -int security_get_policycaps(int *len, int **values);
>  
>  #define SECURITY_FS_USE_XATTR		1 /* use xattr */
>  #define SECURITY_FS_USE_TRANS		2 /* use transition SIDs, e.g. devpts/tmpfs */
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index fced6bc..f374186 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2246,39 +2246,6 @@ int security_get_allow_unknown(void)
>  }
>  
>  /**
> - * security_get_policycaps - Query the loaded policy for its capabilities
> - * @len: the number of capability bits
> - * @values: the capability bit array
> - *
> - * Description:
> - * Get an array of the policy capabilities in @values where each entry in
> - * @values is either true (1) or false (0) depending the policy's support of
> - * that feature.  The policy capabilities are defined by the
> - * POLICYDB_CAPABILITY_* enums.  The size of the array is stored in @len and it
> - * is up to the caller to free the array in @values.  Returns zero on success,
> - * negative values on failure.
> - *
> - */
> -int security_get_policycaps(int *len, int **values)
> -{
> -	int rc = -ENOMEM;
> -	unsigned int iter;
> -
> -	POLICY_RDLOCK;
> -
> -	*values = kcalloc(POLICYDB_CAPABILITY_MAX, sizeof(int), GFP_ATOMIC);
> -	if (*values == NULL)
> -		goto out;
> -	for (iter = 0; iter < POLICYDB_CAPABILITY_MAX; iter++)
> -		(*values)[iter] = ebitmap_get_bit(&policydb.policycaps, iter);
> -	*len = POLICYDB_CAPABILITY_MAX;
> -
> -out:
> -	POLICY_RDUNLOCK;
> -	return rc;
> -}
> -
> -/**
>   * security_policycap_supported - Check for a specific policy capability
>   * @req_cap: capability
>   *
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
