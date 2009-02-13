Subject: Re: [PATCH 2/5] SELinux: more careful use of avd in
 avc_has_perm_noaudit
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, paul.moore@hp.com
In-Reply-To: <20090212195048.25599.58706.stgit@paris.rdu.redhat.com>
References: <20090212195043.25599.80206.stgit@paris.rdu.redhat.com>
	 <20090212195048.25599.58706.stgit@paris.rdu.redhat.com>
Content-Type: text/plain
Date: Fri, 13 Feb 2009 09:20:40 -0500
Message-Id: <1234534840.24702.24.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-02-12 at 14:50 -0500, Eric Paris wrote:
> we are often needlessly jumping through hoops when it comes to avd
> entries in avc_has_perm_noaudit and we have extra initialization and memcpy
> which are just wasting performance.  Try to clean the function up a bit.
> 
> This patch resulted in a 13% drop in time spent in avc_has_perm_noaudit in my
> oprofile sampling of a tbench benchmark.

Further improvement might be to eliminate the need to return an avd at
all from avc_has_perm_noaudit(); there is only one user left and that
could be handled inside of avc_has_perm if it just passed in a flag
indicating audit vs no-audit (as in the original AVC).

> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> ---
> 
>  security/selinux/avc.c |   43 ++++++++++++++++++++++++-------------------
>  1 files changed, 24 insertions(+), 19 deletions(-)
> 
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index abfe378..332c3cd 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -355,12 +355,12 @@ out:
>  	return node;
>  }
>  
> -static void avc_node_populate(struct avc_node *node, u32 ssid, u32 tsid, u16 tclass, struct avc_entry *ae)
> +static void avc_node_populate(struct avc_node *node, u32 ssid, u32 tsid, u16 tclass, struct av_decision *avd)
>  {
>  	node->ae.ssid = ssid;
>  	node->ae.tsid = tsid;
>  	node->ae.tclass = tclass;
> -	memcpy(&node->ae.avd, &ae->avd, sizeof(node->ae.avd));
> +	memcpy(&node->ae.avd, avd, sizeof(node->ae.avd));
>  }
>  
>  static inline struct avc_node *avc_search_node(u32 ssid, u32 tsid, u16 tclass)
> @@ -440,31 +440,31 @@ static int avc_latest_notif_update(int seqno, int is_insert)
>   * @ssid: source security identifier
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
> -static struct avc_node *avc_insert(u32 ssid, u32 tsid, u16 tclass, struct avc_entry *ae)
> +static struct avc_node *avc_insert(u32 ssid, u32 tsid, u16 tclass, struct av_decision *avd)
>  {
>  	struct avc_node *pos, *node = NULL;
>  	int hvalue;
>  	unsigned long flag;
>  
> -	if (avc_latest_notif_update(ae->avd.seqno, 1))
> +	if (avc_latest_notif_update(avd->seqno, 1))
>  		goto out;
>  
>  	node = avc_alloc_node();
>  	if (node) {
>  		hvalue = avc_hash(ssid, tsid, tclass);
> -		avc_node_populate(node, ssid, tsid, tclass, ae);
> +		avc_node_populate(node, ssid, tsid, tclass, avd);
>  
>  		spin_lock_irqsave(&avc_cache.slots_lock[hvalue], flag);
>  		list_for_each_entry(pos, &avc_cache.slots[hvalue], list) {
> @@ -777,7 +777,7 @@ static int avc_update_node(u32 event, u32 perms, u32 ssid, u32 tsid, u16 tclass,
>  	 * Copy and replace original node.
>  	 */
>  
> -	avc_node_populate(node, ssid, tsid, tclass, &orig->ae);
> +	avc_node_populate(node, ssid, tsid, tclass, &orig->ae.avd);
>  
>  	switch (event) {
>  	case AVC_CALLBACK_GRANT:
> @@ -869,10 +869,10 @@ int avc_ss_reset(u32 seqno)
>  int avc_has_perm_noaudit(u32 ssid, u32 tsid,
>  			 u16 tclass, u32 requested,
>  			 unsigned flags,
> -			 struct av_decision *avd)
> +			 struct av_decision *in_avd)
>  {
>  	struct avc_node *node;
> -	struct avc_entry entry, *p_ae;
> +	struct av_decision avd_entry, *avd;
>  	int rc = 0;
>  	u32 denied;
>  
> @@ -883,26 +883,31 @@ int avc_has_perm_noaudit(u32 ssid, u32 tsid,
>  	node = avc_lookup(ssid, tsid, tclass, requested);
>  	if (!node) {
>  		rcu_read_unlock();
> -		rc = security_compute_av(ssid, tsid, tclass, requested, &entry.avd);
> +
> +		if (in_avd)
> +			avd = in_avd;
> +		else
> +			avd = &avd_entry;
> +
> +		rc = security_compute_av(ssid, tsid, tclass, requested, avd);
>  		if (rc)
>  			goto out;
>  		rcu_read_lock();
> -		node = avc_insert(ssid, tsid, tclass, &entry);
> +		node = avc_insert(ssid, tsid, tclass, avd);
> +	} else {
> +		if (in_avd)
> +			memcpy(in_avd, &node->ae.avd, sizeof(*in_avd));
> +		avd = &node->ae.avd;
>  	}
>  
> -	p_ae = node ? &node->ae : &entry;
> -
> -	if (avd)
> -		memcpy(avd, &p_ae->avd, sizeof(*avd));
> -
> -	denied = requested & ~(p_ae->avd.allowed);
> +	denied = requested & ~(avd->allowed);
>  
>  	if (denied) {
>  		if (flags & AVC_STRICT)
>  			rc = -EACCES;
>  		else if (!selinux_enforcing || security_permissive_sid(ssid))
>  			avc_update_node(AVC_CALLBACK_GRANT, requested, ssid,
> -					tsid, tclass, p_ae->avd.seqno);
> +					tsid, tclass, avd->seqno);
>  		else
>  			rc = -EACCES;
>  	}
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
