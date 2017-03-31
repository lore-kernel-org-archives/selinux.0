Message-ID: <1490975541.31110.12.camel@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: Fix an uninitialized variable bug
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dan Carpenter <dan.carpenter@oracle.com>, Paul Moore <paul@paul-moore.com>,
 Markus Elfring <elfring@users.sourceforge.net>
Cc: Eric Paris <eparis@parisplace.org>, James Morris
 <james.l.morris@oracle.com>, "Serge E. Hallyn" <serge@hallyn.com>, William
 Roberts <william.c.roberts@intel.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, kernel-janitors@vger.kernel.org
Date: Fri, 31 Mar 2017 11:52:21 -0400
In-Reply-To: <20170331152118.GA8141@mwanda>
References: <20170331152118.GA8141@mwanda>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-03-31 at 18:21 +0300, Dan Carpenter wrote:
> We removed this initialization as a cleanup but it is probably
> required.
> 
> The concern is that "nel" can be zero.  I'm not an expert on SELinux
> code but I think it looks possible to write an SELinux policy which
> triggers this bug.  GCC doesn't catch this, but my static checker
> does.
> 
> Fixes: 9c312e79d6af ("selinux: Delete an unnecessary variable
> initialisation in range_read()")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Nice catch, thanks!

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> 
> diff --git a/security/selinux/ss/policydb.c
> b/security/selinux/ss/policydb.c
> index 658247f98dc1..0080122760ad 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1832,7 +1832,7 @@ u32 string_to_av_perm(struct policydb *p, u16
> tclass, const char *name)
>  
>  static int range_read(struct policydb *p, void *fp)
>  {
> -	struct range_trans *rt;
> +	struct range_trans *rt = NULL;
>  	struct mls_range *r = NULL;
>  	int i, rc;
>  	__le32 buf[2];
