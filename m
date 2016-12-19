Message-ID: <1482158796.28570.20.camel@tycho.nsa.gov>
Subject: Re: [PATCH 2/2] selinux: default to security isid in
 sel_make_bools() if no sid is found
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Gary Tierney <gary.tierney@gmx.com>, selinux@tycho.nsa.gov
Date: Mon, 19 Dec 2016 09:46:36 -0500
In-Reply-To: <1482007719-14313-3-git-send-email-gary.tierney@gmx.com>
References: <1482007719-14313-1-git-send-email-gary.tierney@gmx.com>
 <1482007719-14313-3-git-send-email-gary.tierney@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, 2016-12-17 at 20:48 +0000, Gary Tierney wrote:
> Use SECINITSID_SECURITY as the default SID for booleans which don't
> have
> a matching SID returned from security_genfs_sid().
> 
> This prevents the policy failing to load (and consequently the system
> failing to boot) when there is no default genfscon statement matched
> for
> the selinuxfs in the new policy.
> 
> Signed-off-by: Gary Tierney <gary.tierney@gmx.com>
> ---
>  security/selinux/selinuxfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/selinux/selinuxfs.c
> b/security/selinux/selinuxfs.c
> index 2139cc7..c282150 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -1312,10 +1312,10 @@ static int sel_make_bools(void)
>  		isec = (struct inode_security_struct *)inode-
> >i_security;
>  		ret = security_genfs_sid("selinuxfs", page,
> SECCLASS_FILE, &sid);
>  		if (ret) {
> -			pr_warn_ratelimited("SELinux: %s: failed to
> lookup sid for %s\n",
> +			pr_warn_ratelimited("SELinux: %s: no sid
> found, defaulting to security isid for %s\n",
>  					   __func__, page);
> -			goto out;
>  
> +			sid = SECINITSID_SECURITY;

I wouldn't include the function name; otherwise, LGTM.

>  		}
>  
>  		isec->sid = sid;
