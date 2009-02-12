From: Paul Moore <paul.moore@hp.com>
To: Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH 4/5] SELinux: code readability with avc_cache
Date: Thu, 12 Feb 2009 15:39:26 -0500
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org
References: <20090212195043.25599.80206.stgit@paris.rdu.redhat.com> <20090212195059.25599.72450.stgit@paris.rdu.redhat.com>
In-Reply-To: <20090212195059.25599.72450.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200902121539.26666.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 12 February 2009 02:50:59 pm Eric Paris wrote:
> The code making use of struct avc_cache was not easy to read thanks to
> liberal use of &avc_cache.{slots_lock,slots}[hvalue] throughout.  This
> patch simply creates local pointers and uses those instead of the long
> global names.
>
> Signed-off-by: Eric Paris <eparis@redhat.com>

If you're going to make these changes you might as well fixup the issues I 
mentioned earlier :)

> @@ -311,26 +313,30 @@ static inline int avc_reclaim_node(void)
>  	struct avc_node *node;
>  	int hvalue, try, ecx;
>  	unsigned long flags;
> +	struct list_head *head;
> +	spinlock_t *lock;
>
>  	for (try = 0, ecx = 0; try < AVC_CACHE_SLOTS; try++) {
>  		hvalue = atomic_inc_return(&avc_cache.lru_hint) & (AVC_CACHE_SLOTS - 1);

See previous comments about getting rid of lru_hint and replacing this hvalue 
with 0.

> @@ -458,11 +466,17 @@ static struct avc_node *avc_insert(u32 ssid, u32
> tsid, u16 tclass, struct av_dec
>
>  	node = avc_alloc_node();
>  	if (node) {
> +		struct list_head *head;
> +		spinlock_t *lock;
> +

Yeah, definitely convert this "if (..." like I mentioned earlier.

-- 
paul moore
linux @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
