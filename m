From: Paul Moore <paul.moore@hp.com>
To: Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH 2/5] SELinux: more careful use of avd in avc_has_perm_noaudit
Date: Thu, 12 Feb 2009 15:30:01 -0500
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org
References: <20090212195043.25599.80206.stgit@paris.rdu.redhat.com> <20090212195048.25599.58706.stgit@paris.rdu.redhat.com>
In-Reply-To: <20090212195048.25599.58706.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200902121530.02041.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 12 February 2009 02:50:49 pm Eric Paris wrote:
> we are often needlessly jumping through hoops when it comes to avd
> entries in avc_has_perm_noaudit and we have extra initialization and memcpy
> which are just wasting performance.  Try to clean the function up a bit.
>
> This patch resulted in a 13% drop in time spent in avc_has_perm_noaudit in
> my oprofile sampling of a tbench benchmark.
>
> Signed-off-by: Eric Paris <eparis@redhat.com>

Looks fine to me, some more not-your-fault comments below.

Reviewed-by: Paul Moore <paul.moore@hp.com>

>  static inline struct avc_node *avc_search_node(u32 ssid, u32 tsid, u16
> tclass) @@ -440,31 +440,31 @@ static int avc_latest_notif_update(int seqno,
> int is_insert) * @ssid: source security identifier
>   * @tsid: target security identifier
>   * @tclass: target security class
> - * @ae: AVC entry
> + * @avd: resulting av decision
>   *
>   * Insert an AVC entry for the SID pair
>   * (@ssid, @tsid) and class @tclass.
>   * The access vectors and the sequence number are
>   * normally provided by the security server in
>   * response to a security_compute_av() call.  If the
> - * sequence number @ae->avd.seqno is not less than the latest
> + * sequence number @avd->seqno is not less than the latest
>   * revocation notification, then the function copies
>   * the access vectors into a cache entry, returns
>   * avc_node inserted. Otherwise, this function returns NULL.
>   */
> -static struct avc_node *avc_insert(u32 ssid, u32 tsid, u16 tclass, struct
> avc_entry *ae) +static struct avc_node *avc_insert(u32 ssid, u32 tsid, u16
> tclass, struct av_decision *avd) {
>  	struct avc_node *pos, *node = NULL;
>  	int hvalue;
>  	unsigned long flag;
>
> -	if (avc_latest_notif_update(ae->avd.seqno, 1))
> +	if (avc_latest_notif_update(avd->seqno, 1))
>  		goto out;

Not your fault but why not change the "goto out;" to "return NULL;" and get 
rid of the "out" label.

>  	node = avc_alloc_node();
>  	if (node) {

Hmm, while you're at it how about converting to ...

	node = avc_alloc_node();
	if (node == NULL)
		return NULL;

... this seems to be a better fit with the "best practices" and it makes the 
code a bit more tidy (especially the "found" label, you could probably rename 
that to "out" ;) ).

>  		hvalue = avc_hash(ssid, tsid, tclass);
> -		avc_node_populate(node, ssid, tsid, tclass, ae);
> +		avc_node_populate(node, ssid, tsid, tclass, avd);
>
>  		spin_lock_irqsave(&avc_cache.slots_lock[hvalue], flag);
>  		list_for_each_entry(pos, &avc_cache.slots[hvalue], list) {

-- 
paul moore
linux @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
