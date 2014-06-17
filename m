Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s5HLeRLs022969
 for <selinux@tycho.nsa.gov>; Tue, 17 Jun 2014 17:40:27 -0400
Received: by mail-qc0-f182.google.com with SMTP id m20so10475535qcx.41
 for <selinux@tycho.nsa.gov>; Tue, 17 Jun 2014 14:40:21 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Himangi Saraogi <himangi774@gmail.com>
Subject: Re: [PATCH] SELinux: use ARRAY_SIZE
Date: Tue, 17 Jun 2014 17:40:17 -0400
Message-ID: <8937190.oVYW8tRbo1@sifl>
In-Reply-To: <20140616201104.GA18288@himangi-Dell>
References: <20140616201104.GA18288@himangi-Dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: James Morris <james.l.morris@oracle.com>, linux-kernel@vger.kernel.org,
 julia.lawall@lip6.fr, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tuesday, June 17, 2014 01:41:05 AM Himangi Saraogi wrote:
> ARRAY_SIZE is more concise to use when the size of an array is divided
> by the size of its type or the size of its first element.
> 
> The Coccinelle semantic patch that makes this change is as follows:
> 
> // <smpl>
> @@
> type T;
> T[] E;
> @@
> 
> - (sizeof(E)/sizeof(E[...]))
> + ARRAY_SIZE(E)
> // </smpl>
> 
> Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
> ---
>  security/selinux/ss/policydb.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 9c5cdc2..56eb65f 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -2608,7 +2608,7 @@ static int mls_write_range_helper(struct mls_range *r,
> void *fp) if (!eq)
>  		buf[2] = cpu_to_le32(r->level[1].sens);
> 
> -	BUG_ON(items > (sizeof(buf)/sizeof(buf[0])));
> +	BUG_ON(items > ARRAY_SIZE(buf));
> 
>  	rc = put_entry(buf, sizeof(u32), items, fp);
>  	if (rc)
> @@ -2990,7 +2990,7 @@ static int role_write(void *vkey, void *datum, void
> *ptr) if (p->policyvers >= POLICYDB_VERSION_BOUNDARY)
>  		buf[items++] = cpu_to_le32(role->bounds);
> 
> -	BUG_ON(items > (sizeof(buf)/sizeof(buf[0])));
> +	BUG_ON(items > ARRAY_SIZE(buf));
> 
>  	rc = put_entry(buf, sizeof(u32), items, fp);
>  	if (rc)
> @@ -3040,7 +3040,7 @@ static int type_write(void *vkey, void *datum, void
> *ptr) } else {
>  		buf[items++] = cpu_to_le32(typdatum->primary);
>  	}
> -	BUG_ON(items > (sizeof(buf) / sizeof(buf[0])));
> +	BUG_ON(items > ARRAY_SIZE(buf));
>  	rc = put_entry(buf, sizeof(u32), items, fp);
>  	if (rc)
>  		return rc;
> @@ -3069,7 +3069,7 @@ static int user_write(void *vkey, void *datum, void
> *ptr) buf[items++] = cpu_to_le32(usrdatum->value);
>  	if (p->policyvers >= POLICYDB_VERSION_BOUNDARY)
>  		buf[items++] = cpu_to_le32(usrdatum->bounds);
> -	BUG_ON(items > (sizeof(buf) / sizeof(buf[0])));
> +	BUG_ON(items > ARRAY_SIZE(buf));
>  	rc = put_entry(buf, sizeof(u32), items, fp);
>  	if (rc)
>  		return rc;

-- 
paul moore
www.paul-moore.com
