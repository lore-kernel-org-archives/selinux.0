Subject: Re: [RFC PATCH 2/2] [SELINUX] Better integration between peer
	labeling subsystems
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20070925204832.13699.51638.stgit@flek.americas.hpqcorp.net>
References: <20070925203856.13699.90782.stgit@flek.americas.hpqcorp.net>
	 <20070925204832.13699.51638.stgit@flek.americas.hpqcorp.net>
Content-Type: text/plain
Date: Wed, 26 Sep 2007 08:41:36 -0400
Message-Id: <1190810496.15779.11.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-09-25 at 16:48 -0400, Paul Moore wrote:
> Rename the existing selinux_skb_extlbl_sid() function to
> selinux_skb_peerlbl_sid() and modify it's behavior such that it now reconciles
> multiple peer/external labels and if reconciliation is not possible it returns
> an error to the caller.
> ---
> 
>  security/selinux/hooks.c            |   70 ++++++++++++++++++++++++++---------
>  security/selinux/include/security.h |    2 +
>  security/selinux/ss/services.c      |   42 +++++++++++++++++++++
>  3 files changed, 95 insertions(+), 19 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 0753b20..a97d1b1 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3132,32 +3132,59 @@ static int selinux_parse_skb(struct sk_buff *skb, struct avc_audit_data *ad,
>  }
>  
>  /**
> - * selinux_skb_extlbl_sid - Determine the external label of a packet
> + * selinux_skb_peerlbl_sid - Determine the peer label of a packet
>   * @skb: the packet
> - * @sid: the packet's SID
> + * @sid: the packet's peer label SID
>   *
>   * Description:
> - * Check the various different forms of external packet labeling and determine
> - * the external SID for the packet.  If only one form of external labeling is
> - * present then it is used, if both labeled IPsec and NetLabel labels are
> - * present then the SELinux type information is taken from the labeled IPsec
> - * SA and the MLS sensitivity label information is taken from the NetLabel
> - * security attributes.  This bit of "magic" is done in the call to
> - * selinux_netlbl_skbuff_getsid().
> + * Check the various different forms of network peer labeling and determine
> + * the peer label/SID for the packet.  If only one form of peer labeling is
> + * present then it is returned in @sid.  If multiple forms of peer labeling
> + * are present the the different peer labels are checked for consistency
> + * (i.e. all the different peer labels have the same value) before the peer
> + * label is returned to the caller in @sid.  The function returns negative
> + * values when there are multiple, inconsistent peer labels present and zero
> + * otherwise.  A table summarizing the different return values is below:
> + *
> + *                                 | function return |      @sid
> + *   ------------------------------+-----------------+-----------------
> + *   no peer labels                |        0        |    SECSID_NULL
> + *   single peer label             |        0        |    peer_label
> + *   multiple, consistent labels   |        0        |    peer_label
> + *   multiple, inconsistent labels |     -EACCES     |    SECSID_NULL
>   *
>   */
> -static void selinux_skb_extlbl_sid(struct sk_buff *skb, u32 *sid)
> +static int selinux_skb_peerlbl_sid(struct sk_buff *skb, u32 *sid)
>  {
>  	u32 xfrm_sid;
>  	u32 nlbl_sid;
>  
>  	selinux_skb_xfrm_sid(skb, &xfrm_sid);
> -	if (selinux_netlbl_skbuff_getsid(skb,
> -					 (xfrm_sid == SECSID_NULL ?
> -					  SECINITSID_NETMSG : xfrm_sid),
> -					 &nlbl_sid) != 0)
> -		nlbl_sid = SECSID_NULL;
> -	*sid = (nlbl_sid == SECSID_NULL ? xfrm_sid : nlbl_sid);
> +	selinux_netlbl_skbuff_getsid(skb, SECINITSID_NETMSG, &nlbl_sid);
> +
> +	if (nlbl_sid != SECSID_NULL && xfrm_sid != SECSID_NULL) {
> +		if (nlbl_sid != xfrm_sid &&
> +		    /* XXX - not sure if we should just compare the low end of
> +		     * the range or the whole range?  probably safest to
> +		     * compare the entire range ... */
> +		    security_sid_mls_cmp(nlbl_sid, xfrm_sid) != 0) {

I know that this isn't the first instance of this, but the goal of the
Flask architecture was to encapsulate the security model completely
within the security server.  So leaking MLS specific logic out into the
hook functions (as is also done by security_sid_mls_copy) violates that
goal.

> +			*sid = SECSID_NULL;
> +			return -EACCES;
> +		} else
> +			/* at present NetLabel SIDs/labels really only carry
> +			 * MLS information so if the MLS portion of the
> +			 * NetLabel SID matches the MLS portion of the labeled
> +			 * XFRM SID/label then pass along the XFRM SID as it
> +			 * has the most peer label information */
> +			*sid = xfrm_sid;
> +	} else if (nlbl_sid != SECSID_NULL)
> +		*sid = nlbl_sid;
> +	else if (xfrm_sid != SECSID_NULL)
> +		*sid = xfrm_sid;
> +	else
> +		*sid = SECSID_NULL;
> +
> +	return 0;
>  }
>  
>  /* socket security operations */
> @@ -3640,6 +3667,9 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>  	if (err)
>  		goto out;
>  
> +	/* XXX - make use of selinux_skb_peerlbl_sid() here but only once we
> +	 *       have the new peer object class in place */
> +
>  	err = selinux_netlbl_sock_rcv_skb(sksec, skb, &ad);
>  	if (err)
>  		goto out;
> @@ -3701,7 +3731,7 @@ static int selinux_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *
>  	if (sock && sock->sk->sk_family == PF_UNIX)
>  		selinux_get_inode_sid(SOCK_INODE(sock), &peer_secid);
>  	else if (skb)
> -		selinux_skb_extlbl_sid(skb, &peer_secid);
> +		selinux_skb_peerlbl_sid(skb, &peer_secid);
>  
>  	if (peer_secid == SECSID_NULL)
>  		err = -EINVAL;
> @@ -3762,7 +3792,9 @@ static int selinux_inet_conn_request(struct sock *sk, struct sk_buff *skb,
>  	u32 newsid;
>  	u32 peersid;
>  
> -	selinux_skb_extlbl_sid(skb, &peersid);
> +	err = selinux_skb_peerlbl_sid(skb, &peersid);
> +	if (err)
> +		return err;
>  	if (peersid == SECSID_NULL) {
>  		req->secid = sksec->sid;
>  		req->peer_secid = SECSID_NULL;
> @@ -3800,7 +3832,7 @@ static void selinux_inet_conn_established(struct sock *sk,
>  {
>  	struct sk_security_struct *sksec = sk->sk_security;
>  
> -	selinux_skb_extlbl_sid(skb, &sksec->peer_sid);
> +	selinux_skb_peerlbl_sid(skb, &sksec->peer_sid);
>  }
>  
>  static void selinux_req_classify_flow(const struct request_sock *req,
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index cd45cf0..4cbb6f7 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -109,6 +109,8 @@ int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
>  
>  int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid);
>  
> +int security_sid_mls_cmp(u32 sid_a, u32 sid_b);
> +
>  int security_get_classes(char ***classes, int *nclasses);
>  int security_get_permissions(char *class, char ***perms, int *nperms);
>  
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index ef557b6..ea78f75 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2009,6 +2009,48 @@ out:
>  	return rc;
>  }
>  
> +/**
> + * security_sid_mls_cmp - Compare the MLS portion of two SIDs
> + * @sid_a: SID to compare
> + * @sid_b: SID to compare
> + *
> + * Description:
> + * Compare the MLS portions of two SIDs and return zero if they are the same,
> + * otherwise return a non-zero value.
> + *
> + */
> +int security_sid_mls_cmp(u32 sid_a, u32 sid_b)
> +{
> +	int rc;
> +	struct context *ctx_a;
> +	struct context *ctx_b;
> +
> +	if (!ss_initialized || !selinux_mls_enabled)
> +		return 0;
> +
> +	POLICY_RDLOCK;
> +
> +	ctx_a = sidtab_search(&sidtab, sid_a);
> +	if (!ctx_a) {
> +		printk(KERN_ERR
> +		       "security_sid_mls_cmp:  unrecognized SID %d\n", sid_a);
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +	ctx_b = sidtab_search(&sidtab, sid_b);
> +	if (!ctx_b) {
> +		printk(KERN_ERR
> +		       "security_sid_mls_cmp:  unrecognized SID %d\n", sid_b);
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +	rc = mls_context_cmp(ctx_a, ctx_b);
> +
> +out:
> +	POLICY_RDUNLOCK;
> +	return rc;
> +}
> +
>  static int get_classes_callback(void *k, void *d, void *args)
>  {
>  	struct class_datum *datum = d;
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
