Subject: Re: [PATCH] selinux: type_bounds_sanity_check has a meaningless
 variable declaration
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <20100803192605.1788.92228.stgit@paris.rdu.redhat.com>
References: <20100803192605.1788.92228.stgit@paris.rdu.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 04 Aug 2010 15:08:18 -0400
Message-ID: <1280948898.21957.211.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-08-03 at 15:26 -0400, Eric Paris wrote:
> type is not used at all, stop declaring and assigning it.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> ---
> 
>  security/selinux/ss/policydb.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index b7ef93e..3ff0c24 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1606,11 +1606,11 @@ static int role_bounds_sanity_check(void *key, void *datum, void *datap)
>  
>  static int type_bounds_sanity_check(void *key, void *datum, void *datap)
>  {
> -	struct type_datum *upper, *type;
> +	struct type_datum *upper;
>  	struct policydb *p = datap;
>  	int depth = 0;
>  
> -	upper = type = datum;
> +	upper = datum;
>  	while (upper->bounds) {
>  		if (++depth == POLICYDB_BOUNDS_MAXDEPTH) {
>  			printk(KERN_ERR "SELinux: type %s: "

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
