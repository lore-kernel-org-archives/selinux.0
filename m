Message-ID: <54C8FCCA.9010706@tycho.nsa.gov>
Date: Wed, 28 Jan 2015 10:14:18 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>, Paul Moore <paul@paul-moore.com>
Subject: Re: [patch] SELinux: fix error code in policydb_init()
References: <20150128064239.GB30893@mwanda>
In-Reply-To: <20150128064239.GB30893@mwanda>
Content-Type: text/plain; charset=windows-1252
Cc: James Morris <james.l.morris@oracle.com>, kernel-janitors@vger.kernel.org,
 linux-security-module@vger.kernel.org, Himangi Saraogi <himangi774@gmail.com>,
 selinux@tycho.nsa.gov, Namhyung Kim <namhyung@kernel.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/28/2015 01:42 AM, Dan Carpenter wrote:
> If hashtab_create() returns a NULL pointer then we should return -ENOMEM
> but instead the current code returns success.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> 
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index bc2a586..74aa224 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -289,12 +289,16 @@ static int policydb_init(struct policydb *p)
>  		goto out;
>  
>  	p->filename_trans = hashtab_create(filenametr_hash, filenametr_cmp, (1 << 10));
> -	if (!p->filename_trans)
> +	if (!p->filename_trans) {
> +		rc = -ENOMEM;
>  		goto out;
> +	}
>  
>  	p->range_tr = hashtab_create(rangetr_hash, rangetr_cmp, 256);
> -	if (!p->range_tr)
> +	if (!p->range_tr) {
> +		rc = -ENOMEM;
>  		goto out;
> +	}
>  
>  	ebitmap_init(&p->filename_trans_ttypes);
>  	ebitmap_init(&p->policycaps);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
