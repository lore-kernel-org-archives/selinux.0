Message-ID: <1482247891.28169.11.camel@tycho.nsa.gov>
Subject: Re: [PATCH v2 2/2] selinux: default to security isid in
 sel_make_bools() if no sid is found
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Gary Tierney <gary.tierney@gmx.com>, selinux@tycho.nsa.gov,
 sgrubb@redhat.com
Date: Tue, 20 Dec 2016 10:31:31 -0500
In-Reply-To: <61a07062f6ba9f90e3235160644f3b5e62439173.1482195891.git.gary.tierney@gmx.com>
References: <20161219160041.GB5359@workstation>
 <cover.1482195891.git.gary.tierney@gmx.com>
 <61a07062f6ba9f90e3235160644f3b5e62439173.1482195891.git.gary.tierney@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2016-12-20 at 01:28 +0000, Gary Tierney wrote:
> Use SECINITSID_SECURITY as the default SID for booleans which don't
> have
> a matching SID returned from security_genfs_sid(), also update the
> error message to a warning which matches this.
> 
> This prevents the policy failing to load (and consequently the system
> failing to boot) when there is no default genfscon statement matched
> for
> the selinuxfs in the new policy.
> 
> Signed-off-by: Gary Tierney <gary.tierney@gmx.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>  security/selinux/selinuxfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/security/selinux/selinuxfs.c
> b/security/selinux/selinuxfs.c
> index e667c34..616a8d2 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -1308,9 +1308,9 @@ static int sel_make_bools(void)
>  		isec = (struct inode_security_struct *)inode-
> >i_security;
>  		ret = security_genfs_sid("selinuxfs", page,
> SECCLASS_FILE, &sid);
>  		if (ret) {
> -			pr_err("SELinux: failed to lookup sid for
> %s\n", page);
> -			goto out;
> -
> +			pr_warn_ratelimited("SELinux: no sid found,
> defaulting to security isid for %s\n",
> +					   page);
> +			sid = SECINITSID_SECURITY;
>  		}
>  
>  		isec->sid = sid;
