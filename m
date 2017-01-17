Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0HGWnQ1008215
 for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2017 11:32:50 -0500
Subject: Re: [PATCH 15/46] selinux: One check and function call less in
 genfs_read() after error detection
To: SF Markus Elfring <elfring@users.sourceforge.net>,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Eric Paris <eparis@parisplace.org>, James Morris
 <james.l.morris@oracle.com>,
 Paul Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <dbd8e89d-45a1-5785-f2dd-673389ac01a3@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <a9983d7d-e1f7-8f85-f696-107cf32160ef@schaufler-ca.com>
Date: Tue, 17 Jan 2017 08:32:43 -0800
MIME-Version: 1.0
In-Reply-To: <dbd8e89d-45a1-5785-f2dd-673389ac01a3@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 1/15/2017 7:15 AM, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 18:29:20 +0100
>
> Adjust a jump target to avoid a check repetition at the end after a memory
> allocation failed for the local variable "newgenfs".
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/policydb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 5dc31faa601f..e7b882251da8 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -2015,7 +2015,7 @@ static int genfs_read(struct policydb *p, void *fp)
>  		newgenfs = kzalloc(sizeof(*newgenfs), GFP_KERNEL);
>  		if (!newgenfs) {
>  			rc = -ENOMEM;
> -			goto out;
> +			goto exit;
>  		}
>  
>  		rc = str_read(&newgenfs->fstype, GFP_KERNEL, fp, len);
> @@ -2101,7 +2101,7 @@ static int genfs_read(struct policydb *p, void *fp)
>  		kfree(newgenfs);
>  	}
>  	ocontext_destroy(newc, OCON_FSUSE);
> -
> +exit:
>  	return rc;

Why not replace the "goto out" with "return rc" rather
than add a target?

>  }
>  
