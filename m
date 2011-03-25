Subject: Re: [v2 PATCH 3/3] SELinux: Write class field in role_trans_write.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Harry Ciao <qingtao.cao@windriver.com>
Cc: jmorris@namei.org, eparis@parisplace.org, selinux@tycho.nsa.gov
In-Reply-To: <1301032323-20363-6-git-send-email-qingtao.cao@windriver.com>
References: <1301032323-20363-1-git-send-email-qingtao.cao@windriver.com>
	 <1301032323-20363-6-git-send-email-qingtao.cao@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 25 Mar 2011 12:50:36 -0400
Message-ID: <1301071836.22099.22.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2011-03-25 at 13:52 +0800, Harry Ciao wrote:
> If kernel policy version is >= 26, then write the class field of the
> role_trans structure into the binary reprensentation.
> 
> Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

for the 3 kernel patches.

> ---
>  security/selinux/ss/policydb.c |   11 +++++++++--
>  1 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index fd62c50..a493eae 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -2535,8 +2535,9 @@ static int cat_write(void *vkey, void *datum, void *ptr)
>  	return 0;
>  }
>  
> -static int role_trans_write(struct role_trans *r, void *fp)
> +static int role_trans_write(struct policydb *p, void *fp)
>  {
> +	struct role_trans *r = p->role_tr;
>  	struct role_trans *tr;
>  	u32 buf[3];
>  	size_t nel;
> @@ -2556,6 +2557,12 @@ static int role_trans_write(struct role_trans *r, void *fp)
>  		rc = put_entry(buf, sizeof(u32), 3, fp);
>  		if (rc)
>  			return rc;
> +		if (p->policyvers >= POLICYDB_VERSION_ROLETRANS) {
> +			buf[0] = cpu_to_le32(tr->tclass);
> +			rc = put_entry(buf, sizeof(u32), 1, fp);
> +			if (rc)
> +				return rc;
> +		}
>  	}
>  
>  	return 0;
> @@ -3267,7 +3274,7 @@ int policydb_write(struct policydb *p, void *fp)
>  	if (rc)
>  		return rc;
>  
> -	rc = role_trans_write(p->role_tr, fp);
> +	rc = role_trans_write(p, fp);
>  	if (rc)
>  		return rc;
>  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
