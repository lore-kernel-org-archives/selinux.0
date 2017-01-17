Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0HI2j8f003530
 for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2017 13:02:46 -0500
Subject: Re: [PATCH 45/46] selinux: Use common error handling code in
 sidtab_insert()
To: SF Markus Elfring <elfring@users.sourceforge.net>,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Eric Paris <eparis@parisplace.org>, James Morris
 <james.l.morris@oracle.com>,
 Paul Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <36f95c73-4ae1-efbf-393c-6f4239a91478@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <923ce5f2-48ce-9d90-db19-7c94b7c43794@schaufler-ca.com>
Date: Tue, 17 Jan 2017 10:02:40 -0800
MIME-Version: 1.0
In-Reply-To: <36f95c73-4ae1-efbf-393c-6f4239a91478@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 1/15/2017 7:45 AM, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 15 Jan 2017 13:45:45 +0100
>
> Add a jump target so that a bit of exception handling can be better reused
> at the end of this function.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/sidtab.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index f6915f257486..4130f882808c 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -35,10 +35,8 @@ int sidtab_insert(struct sidtab *s, u32 sid, struct context *context)
>  	int hvalue, rc = 0;
>  	struct sidtab_node *prev, *cur, *newnode;
>  
> -	if (!s) {
> -		rc = -ENOMEM;
> -		goto out;
> -	}
> +	if (!s)
> +		goto failure_indication;
>  
>  	hvalue = SIDTAB_HASH(sid);
>  	prev = NULL;
> @@ -54,15 +52,12 @@ int sidtab_insert(struct sidtab *s, u32 sid, struct context *context)
>  	}
>  
>  	newnode = kmalloc(sizeof(*newnode), GFP_ATOMIC);
> -	if (!newnode) {
> -		rc = -ENOMEM;
> -		goto out;

Why not "return -ENOMEM;" ?

> -	}
> +	if (!newnode)
> +		goto failure_indication;
>  	newnode->sid = sid;
>  	if (context_cpy(&newnode->context, context)) {
>  		kfree(newnode);
> -		rc = -ENOMEM;
> -		goto out;
> +		goto failure_indication;

Again, "return -ENOMEM:"

>  	}
>  
>  	if (prev) {
> @@ -80,6 +75,9 @@ int sidtab_insert(struct sidtab *s, u32 sid, struct context *context)
>  		s->next_sid = sid + 1;
>  out:
>  	return rc;
> +failure_indication:
> +	rc = -ENOMEM;
> +	goto out;

Backward gotos are horrible. Don't do this.

>  }
>  
>  static struct context *sidtab_search_core(struct sidtab *s, u32 sid, int force)
