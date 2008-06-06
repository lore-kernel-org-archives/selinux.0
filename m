Subject: Re: [PATCH 3/3] SELinux: open code sidtab lock
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
In-Reply-To: <Xine.LNX.4.64.0806061858290.25093@us.intercode.com.au>
References: <Xine.LNX.4.64.0806061856160.25093@us.intercode.com.au>
	 <Xine.LNX.4.64.0806061858290.25093@us.intercode.com.au>
Content-Type: text/plain
Date: Fri, 06 Jun 2008 08:12:45 -0400
Message-Id: <1212754365.2763.171.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-06-06 at 18:58 +1000, James Morris wrote:
> Open code sidtab lock to make Andrew Morton happy.
> 
> Signed-off-by: James Morris <jmorris@namei.org>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

I suspect though what would make him even happier would be to reduce our
critical sections and our usage of GFP_ATOMIC throughout.

> ---
>  security/selinux/ss/sidtab.c |   18 +++++++-----------
>  1 files changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index ba35416..a81ded1 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -14,10 +14,6 @@
>  #define SIDTAB_HASH(sid) \
>  (sid & SIDTAB_HASH_MASK)
>  
> -#define INIT_SIDTAB_LOCK(s) spin_lock_init(&s->lock)
> -#define SIDTAB_LOCK(s, x) spin_lock_irqsave(&s->lock, x)
> -#define SIDTAB_UNLOCK(s, x) spin_unlock_irqrestore(&s->lock, x)
> -
>  int sidtab_init(struct sidtab *s)
>  {
>  	int i;
> @@ -30,7 +26,7 @@ int sidtab_init(struct sidtab *s)
>  	s->nel = 0;
>  	s->next_sid = 1;
>  	s->shutdown = 0;
> -	INIT_SIDTAB_LOCK(s);
> +	spin_lock_init(&s->lock);
>  	return 0;
>  }
>  
> @@ -180,7 +176,7 @@ int sidtab_context_to_sid(struct sidtab *s,
>  
>  	sid = sidtab_search_context(s, context);
>  	if (!sid) {
> -		SIDTAB_LOCK(s, flags);
> +		spin_lock_irqsave(&s->lock, flags);
>  		/* Rescan now that we hold the lock. */
>  		sid = sidtab_search_context(s, context);
>  		if (sid)
> @@ -199,7 +195,7 @@ int sidtab_context_to_sid(struct sidtab *s,
>  		if (ret)
>  			s->next_sid--;
>  unlock_out:
> -		SIDTAB_UNLOCK(s, flags);
> +		spin_unlock_irqrestore(&s->lock, flags);
>  	}
>  
>  	if (ret)
> @@ -264,19 +260,19 @@ void sidtab_set(struct sidtab *dst, struct sidtab *src)
>  {
>  	unsigned long flags;
>  
> -	SIDTAB_LOCK(src, flags);
> +	spin_lock_irqsave(&src->lock, flags);
>  	dst->htable = src->htable;
>  	dst->nel = src->nel;
>  	dst->next_sid = src->next_sid;
>  	dst->shutdown = 0;
> -	SIDTAB_UNLOCK(src, flags);
> +	spin_unlock_irqrestore(&src->lock, flags);
>  }
>  
>  void sidtab_shutdown(struct sidtab *s)
>  {
>  	unsigned long flags;
>  
> -	SIDTAB_LOCK(s, flags);
> +	spin_lock_irqsave(&s->lock, flags);
>  	s->shutdown = 1;
> -	SIDTAB_UNLOCK(s, flags);
> +	spin_unlock_irqrestore(&s->lock, flags);
>  }
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
