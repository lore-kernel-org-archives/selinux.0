Message-ID: <1482247834.28169.10.camel@tycho.nsa.gov>
Subject: Re: [PATCH v2 1/2] selinux: log errors when loading new policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Gary Tierney <gary.tierney@gmx.com>, selinux@tycho.nsa.gov,
 sgrubb@redhat.com
Date: Tue, 20 Dec 2016 10:30:34 -0500
In-Reply-To: <8f6b74e709a3280457fc875207134f723ca152ab.1482195891.git.gary.tierney@gmx.com>
References: <20161219160041.GB5359@workstation>
 <cover.1482195891.git.gary.tierney@gmx.com>
 <8f6b74e709a3280457fc875207134f723ca152ab.1482195891.git.gary.tierney@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2016-12-20 at 01:28 +0000, Gary Tierney wrote:
> Adds error logging to the code paths which can fail when loading a
> new
> policy in sel_write_load().  If the policy fails to be loaded from
> userspace then a warning message is printed, whereas if a failure
> occurs
> after loading policy from userspace an error message will be printed
> with details on where policy loading failed (recreating one of
> /classes/,
> /policy_capabilities/, /booleans/ in the SELinux fs).
> 
> Also, if sel_make_bools() fails to obtain an SID for an entry in
> /booleans/* an error will be printed indicating the path of the
> boolean.
> 
> Signed-off-by: Gary Tierney <gary.tierney@gmx.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>  security/selinux/selinuxfs.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/security/selinux/selinuxfs.c
> b/security/selinux/selinuxfs.c
> index 0aac402..e667c34 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -522,20 +522,28 @@ static ssize_t sel_write_load(struct file
> *file, const char __user *buf,
>  		goto out;
>  
>  	length = security_load_policy(data, count);
> -	if (length)
> +	if (length) {
> +		pr_warn_ratelimited("SELinux: failed to load
> policy\n");
>  		goto out;
> +	}
>  
>  	length = sel_make_bools();
> -	if (length)
> +	if (length) {
> +		pr_err("SELinux: failed to load policy booleans\n");
>  		goto out1;
> +	}
>  
>  	length = sel_make_classes();
> -	if (length)
> +	if (length) {
> +		pr_err("SELinux: failed to load policy classes\n");
>  		goto out1;
> +	}
>  
>  	length = sel_make_policycap();
> -	if (length)
> +	if (length) {
> +		pr_err("SELinux: failed to load policy
> capabilities\n");
>  		goto out1;
> +	}
>  
>  	length = count;
>  
> @@ -1299,9 +1307,12 @@ static int sel_make_bools(void)
>  
>  		isec = (struct inode_security_struct *)inode-
> >i_security;
>  		ret = security_genfs_sid("selinuxfs", page,
> SECCLASS_FILE, &sid);
> -		if (ret)
> +		if (ret) {
> +			pr_err("SELinux: failed to lookup sid for
> %s\n", page);
>  			goto out;
>  
> +		}
> +
>  		isec->sid = sid;
>  		isec->initialized = LABEL_INITIALIZED;
>  		inode->i_fop = &sel_bool_ops;
