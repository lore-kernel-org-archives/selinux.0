Return-Path: <SRS0=cEwN=U2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FD8C4321A
	for <selinux@archiver.kernel.org>; Thu, 27 Jun 2019 21:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637DD2075E
	for <selinux@archiver.kernel.org>; Thu, 27 Jun 2019 21:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfF0Vi3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Jun 2019 17:38:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37214 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfF0Vi3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Jun 2019 17:38:29 -0400
Received: from static-50-53-46-226.bvtn.or.frontiernet.net ([50.53.46.226] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <john.johansen@canonical.com>)
        id 1hgc60-0002Lf-58; Thu, 27 Jun 2019 21:38:20 +0000
Subject: Re: [PATCH v4 22/23] NET: Store LSM netlabel data in a lsmblob
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
References: <20190626192234.11725-1-casey@schaufler-ca.com>
 <20190626192234.11725-23-casey@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <709bb7ab-0bc7-d51d-53ed-4645a47480e9@canonical.com>
Date:   Thu, 27 Jun 2019 14:38:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190626192234.11725-23-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/26/19 12:22 PM, Casey Schaufler wrote:
> Netlabel uses LSM interfaces requiring an lsmblob and
> the internal storage is used to pass information between
> these interfaces, so change the internal data from a secid
> to a lsmblob. Update the netlabel interfaces and their
> callers to accomodate the change. This requires that the
> modules using netlabel use the lsm_id.slot to access the
> correct secid when using netlabel.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: John Johansen <john.johansen@canonical.com>


> ---
>  include/net/netlabel.h              |  8 ++--
>  net/ipv4/cipso_ipv4.c               |  6 ++-
>  net/netlabel/netlabel_kapi.c        |  6 +--
>  net/netlabel/netlabel_unlabeled.c   | 57 +++++++++++------------------
>  net/netlabel/netlabel_unlabeled.h   |  2 +-
>  security/selinux/hooks.c            |  2 +-
>  security/selinux/include/security.h |  1 +
>  security/selinux/netlabel.c         |  2 +-
>  security/selinux/ss/services.c      |  4 +-
>  security/smack/smack.h              |  1 +
>  security/smack/smack_lsm.c          |  5 ++-
>  security/smack/smackfs.c            | 10 +++--
>  12 files changed, 50 insertions(+), 54 deletions(-)
> 
> diff --git a/include/net/netlabel.h b/include/net/netlabel.h
> index 72d6435fc16c..6c550455e69f 100644
> --- a/include/net/netlabel.h
> +++ b/include/net/netlabel.h
> @@ -180,7 +180,7 @@ struct netlbl_lsm_catmap {
>   * @attr.mls: MLS sensitivity label
>   * @attr.mls.cat: MLS category bitmap
>   * @attr.mls.lvl: MLS sensitivity level
> - * @attr.secid: LSM specific secid token
> + * @attr.lsmblob: LSM specific data
>   *
>   * Description:
>   * This structure is used to pass security attributes between NetLabel and the
> @@ -215,7 +215,7 @@ struct netlbl_lsm_secattr {
>  			struct netlbl_lsm_catmap *cat;
>  			u32 lvl;
>  		} mls;
> -		u32 secid;
> +		struct lsmblob lsmblob;
>  	} attr;
>  };
>  
> @@ -429,7 +429,7 @@ int netlbl_cfg_unlbl_static_add(struct net *net,
>  				const void *addr,
>  				const void *mask,
>  				u16 family,
> -				u32 secid,
> +				struct lsmblob *lsmblob,
>  				struct netlbl_audit *audit_info);
>  int netlbl_cfg_unlbl_static_del(struct net *net,
>  				const char *dev_name,
> @@ -537,7 +537,7 @@ static inline int netlbl_cfg_unlbl_static_add(struct net *net,
>  					      const void *addr,
>  					      const void *mask,
>  					      u16 family,
> -					      u32 secid,
> +					      struct lsmblob *lsmblob,
>  					      struct netlbl_audit *audit_info)
>  {
>  	return -ENOSYS;
> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index f0165c5f376b..eb4939f38a14 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -1481,7 +1481,8 @@ static int cipso_v4_gentag_loc(const struct cipso_v4_doi *doi_def,
>  
>  	buffer[0] = CIPSO_V4_TAG_LOCAL;
>  	buffer[1] = CIPSO_V4_TAG_LOC_BLEN;
> -	*(u32 *)&buffer[2] = secattr->attr.secid;
> +	/* only one netlabel user - the first */
> +	*(u32 *)&buffer[2] = secattr->attr.lsmblob.secid[0];
>  
>  	return CIPSO_V4_TAG_LOC_BLEN;
>  }
> @@ -1501,7 +1502,8 @@ static int cipso_v4_parsetag_loc(const struct cipso_v4_doi *doi_def,
>  				 const unsigned char *tag,
>  				 struct netlbl_lsm_secattr *secattr)
>  {
> -	secattr->attr.secid = *(u32 *)&tag[2];
> +	/* only one netlabel user - the first */
> +	secattr->attr.lsmblob.secid[0] = *(u32 *)&tag[2];
>  	secattr->flags |= NETLBL_SECATTR_SECID;
>  
>  	return 0;
> diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
> index ee3e5b6471a6..724d44943543 100644
> --- a/net/netlabel/netlabel_kapi.c
> +++ b/net/netlabel/netlabel_kapi.c
> @@ -210,7 +210,7 @@ int netlbl_cfg_unlbl_map_add(const char *domain,
>   * @addr: IP address in network byte order (struct in[6]_addr)
>   * @mask: address mask in network byte order (struct in[6]_addr)
>   * @family: address family
> - * @secid: LSM secid value for the entry
> + * @lsmblob: LSM data value for the entry
>   * @audit_info: NetLabel audit information
>   *
>   * Description:
> @@ -224,7 +224,7 @@ int netlbl_cfg_unlbl_static_add(struct net *net,
>  				const void *addr,
>  				const void *mask,
>  				u16 family,
> -				u32 secid,
> +				struct lsmblob *lsmblob,
>  				struct netlbl_audit *audit_info)
>  {
>  	u32 addr_len;
> @@ -244,7 +244,7 @@ int netlbl_cfg_unlbl_static_add(struct net *net,
>  
>  	return netlbl_unlhsh_add(net,
>  				 dev_name, addr, mask, addr_len,
> -				 secid, audit_info);
> +				 lsmblob, audit_info);
>  }
>  
>  /**
> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
> index 4716e0011ba5..57ede7781c8f 100644
> --- a/net/netlabel/netlabel_unlabeled.c
> +++ b/net/netlabel/netlabel_unlabeled.c
> @@ -80,7 +80,7 @@ struct netlbl_unlhsh_tbl {
>  #define netlbl_unlhsh_addr4_entry(iter) \
>  	container_of(iter, struct netlbl_unlhsh_addr4, list)
>  struct netlbl_unlhsh_addr4 {
> -	u32 secid;
> +	struct lsmblob lsmblob;
>  
>  	struct netlbl_af4list list;
>  	struct rcu_head rcu;
> @@ -88,7 +88,7 @@ struct netlbl_unlhsh_addr4 {
>  #define netlbl_unlhsh_addr6_entry(iter) \
>  	container_of(iter, struct netlbl_unlhsh_addr6, list)
>  struct netlbl_unlhsh_addr6 {
> -	u32 secid;
> +	struct lsmblob lsmblob;
>  
>  	struct netlbl_af6list list;
>  	struct rcu_head rcu;
> @@ -233,7 +233,7 @@ static struct netlbl_unlhsh_iface *netlbl_unlhsh_search_iface(int ifindex)
>   * @iface: the associated interface entry
>   * @addr: IPv4 address in network byte order
>   * @mask: IPv4 address mask in network byte order
> - * @secid: LSM secid value for entry
> + * @lsmblob: LSM data value for entry
>   *
>   * Description:
>   * Add a new address entry into the unlabeled connection hash table using the
> @@ -244,7 +244,7 @@ static struct netlbl_unlhsh_iface *netlbl_unlhsh_search_iface(int ifindex)
>  static int netlbl_unlhsh_add_addr4(struct netlbl_unlhsh_iface *iface,
>  				   const struct in_addr *addr,
>  				   const struct in_addr *mask,
> -				   u32 secid)
> +				   struct lsmblob *lsmblob)
>  {
>  	int ret_val;
>  	struct netlbl_unlhsh_addr4 *entry;
> @@ -256,7 +256,7 @@ static int netlbl_unlhsh_add_addr4(struct netlbl_unlhsh_iface *iface,
>  	entry->list.addr = addr->s_addr & mask->s_addr;
>  	entry->list.mask = mask->s_addr;
>  	entry->list.valid = 1;
> -	entry->secid = secid;
> +	entry->lsmblob = *lsmblob;
>  
>  	spin_lock(&netlbl_unlhsh_lock);
>  	ret_val = netlbl_af4list_add(&entry->list, &iface->addr4_list);
> @@ -273,7 +273,7 @@ static int netlbl_unlhsh_add_addr4(struct netlbl_unlhsh_iface *iface,
>   * @iface: the associated interface entry
>   * @addr: IPv6 address in network byte order
>   * @mask: IPv6 address mask in network byte order
> - * @secid: LSM secid value for entry
> + * @lsmblob: LSM data value for entry
>   *
>   * Description:
>   * Add a new address entry into the unlabeled connection hash table using the
> @@ -284,7 +284,7 @@ static int netlbl_unlhsh_add_addr4(struct netlbl_unlhsh_iface *iface,
>  static int netlbl_unlhsh_add_addr6(struct netlbl_unlhsh_iface *iface,
>  				   const struct in6_addr *addr,
>  				   const struct in6_addr *mask,
> -				   u32 secid)
> +				   struct lsmblob *lsmblob)
>  {
>  	int ret_val;
>  	struct netlbl_unlhsh_addr6 *entry;
> @@ -300,7 +300,7 @@ static int netlbl_unlhsh_add_addr6(struct netlbl_unlhsh_iface *iface,
>  	entry->list.addr.s6_addr32[3] &= mask->s6_addr32[3];
>  	entry->list.mask = *mask;
>  	entry->list.valid = 1;
> -	entry->secid = secid;
> +	entry->lsmblob = *lsmblob;
>  
>  	spin_lock(&netlbl_unlhsh_lock);
>  	ret_val = netlbl_af6list_add(&entry->list, &iface->addr6_list);
> @@ -379,7 +379,7 @@ int netlbl_unlhsh_add(struct net *net,
>  		      const void *addr,
>  		      const void *mask,
>  		      u32 addr_len,
> -		      u32 secid,
> +		      struct lsmblob *lsmblob,
>  		      struct netlbl_audit *audit_info)
>  {
>  	int ret_val;
> @@ -388,7 +388,6 @@ int netlbl_unlhsh_add(struct net *net,
>  	struct netlbl_unlhsh_iface *iface;
>  	struct audit_buffer *audit_buf = NULL;
>  	struct lsmcontext context;
> -	struct lsmblob blob;
>  
>  	if (addr_len != sizeof(struct in_addr) &&
>  	    addr_len != sizeof(struct in6_addr))
> @@ -421,7 +420,7 @@ int netlbl_unlhsh_add(struct net *net,
>  		const struct in_addr *addr4 = addr;
>  		const struct in_addr *mask4 = mask;
>  
> -		ret_val = netlbl_unlhsh_add_addr4(iface, addr4, mask4, secid);
> +		ret_val = netlbl_unlhsh_add_addr4(iface, addr4, mask4, lsmblob);
>  		if (audit_buf != NULL)
>  			netlbl_af4list_audit_addr(audit_buf, 1,
>  						  dev_name,
> @@ -434,7 +433,7 @@ int netlbl_unlhsh_add(struct net *net,
>  		const struct in6_addr *addr6 = addr;
>  		const struct in6_addr *mask6 = mask;
>  
> -		ret_val = netlbl_unlhsh_add_addr6(iface, addr6, mask6, secid);
> +		ret_val = netlbl_unlhsh_add_addr6(iface, addr6, mask6, lsmblob);
>  		if (audit_buf != NULL)
>  			netlbl_af6list_audit_addr(audit_buf, 1,
>  						  dev_name,
> @@ -451,8 +450,7 @@ int netlbl_unlhsh_add(struct net *net,
>  unlhsh_add_return:
>  	rcu_read_unlock();
>  	if (audit_buf != NULL) {
> -		lsmblob_init(&blob, secid);
> -		if (security_secid_to_secctx(&blob, &context) == 0) {
> +		if (security_secid_to_secctx(lsmblob, &context) == 0) {
>  			audit_log_format(audit_buf, " sec_obj=%s",
>  					 context.context);
>  			security_release_secctx(&context);
> @@ -487,7 +485,6 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
>  	struct audit_buffer *audit_buf;
>  	struct net_device *dev;
>  	struct lsmcontext context;
> -	struct lsmblob blob;
>  
>  	spin_lock(&netlbl_unlhsh_lock);
>  	list_entry = netlbl_af4list_remove(addr->s_addr, mask->s_addr,
> @@ -507,10 +504,8 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
>  					  addr->s_addr, mask->s_addr);
>  		if (dev != NULL)
>  			dev_put(dev);
> -		if (entry != NULL)
> -			lsmblob_init(&blob, entry->secid);
>  		if (entry != NULL &&
> -		    security_secid_to_secctx(&blob, &context) == 0) {
> +		    security_secid_to_secctx(&entry->lsmblob, &context) == 0) {
>  			audit_log_format(audit_buf, " sec_obj=%s",
>  					 context.context);
>  			security_release_secctx(&context);
> @@ -551,7 +546,6 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
>  	struct audit_buffer *audit_buf;
>  	struct net_device *dev;
>  	struct lsmcontext context;
> -	struct lsmblob blob;
>  
>  	spin_lock(&netlbl_unlhsh_lock);
>  	list_entry = netlbl_af6list_remove(addr, mask, &iface->addr6_list);
> @@ -570,10 +564,8 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
>  					  addr, mask);
>  		if (dev != NULL)
>  			dev_put(dev);
> -		if (entry != NULL)
> -			lsmblob_init(&blob, entry->secid);
>  		if (entry != NULL &&
> -		    security_secid_to_secctx(&blob, &context) == 0) {
> +		    security_secid_to_secctx(&entry->lsmblob, &context) == 0) {
>  			audit_log_format(audit_buf, " sec_obj=%s",
>  					 context.context);
>  			security_release_secctx(&context);
> @@ -927,9 +919,8 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
>  	if (ret_val != 0)
>  		return ret_val;
>  
> -	/* scaffolding with the [0] */
>  	return netlbl_unlhsh_add(&init_net,
> -				 dev_name, addr, mask, addr_len, blob.secid[0],
> +				 dev_name, addr, mask, addr_len, &blob,
>  				 &audit_info);
>  }
>  
> @@ -977,10 +968,8 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
>  	if (ret_val != 0)
>  		return ret_val;
>  
> -	/* scaffolding with the [0] */
>  	return netlbl_unlhsh_add(&init_net,
> -				 NULL, addr, mask, addr_len, blob.secid[0],
> -				 &audit_info);
> +				 NULL, addr, mask, addr_len, &blob, &audit_info);
>  }
>  
>  /**
> @@ -1092,8 +1081,7 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
>  	struct net_device *dev;
>  	struct lsmcontext context;
>  	void *data;
> -	u32 secid;
> -	struct lsmblob blob;
> +	struct lsmblob *lsmb;
>  
>  	data = genlmsg_put(cb_arg->skb, NETLINK_CB(cb_arg->nl_cb->skb).portid,
>  			   cb_arg->seq, &netlbl_unlabel_gnl_family,
> @@ -1131,7 +1119,7 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
>  		if (ret_val != 0)
>  			goto list_cb_failure;
>  
> -		secid = addr4->secid;
> +		lsmb = (struct lsmblob *)&addr4->lsmblob;
>  	} else {
>  		ret_val = nla_put_in6_addr(cb_arg->skb,
>  					   NLBL_UNLABEL_A_IPV6ADDR,
> @@ -1145,11 +1133,10 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
>  		if (ret_val != 0)
>  			goto list_cb_failure;
>  
> -		secid = addr6->secid;
> +		lsmb = (struct lsmblob *)&addr6->lsmblob;
>  	}
>  
> -	lsmblob_init(&blob, secid);
> -	ret_val = security_secid_to_secctx(&blob, &context);
> +	ret_val = security_secid_to_secctx(lsmb, &context);
>  	if (ret_val != 0)
>  		goto list_cb_failure;
>  	ret_val = nla_put(cb_arg->skb,
> @@ -1500,7 +1487,7 @@ int netlbl_unlabel_getattr(const struct sk_buff *skb,
>  					      &iface->addr4_list);
>  		if (addr4 == NULL)
>  			goto unlabel_getattr_nolabel;
> -		secattr->attr.secid = netlbl_unlhsh_addr4_entry(addr4)->secid;
> +		secattr->attr.lsmblob = netlbl_unlhsh_addr4_entry(addr4)->lsmblob;
>  		break;
>  	}
>  #if IS_ENABLED(CONFIG_IPV6)
> @@ -1513,7 +1500,7 @@ int netlbl_unlabel_getattr(const struct sk_buff *skb,
>  					      &iface->addr6_list);
>  		if (addr6 == NULL)
>  			goto unlabel_getattr_nolabel;
> -		secattr->attr.secid = netlbl_unlhsh_addr6_entry(addr6)->secid;
> +		secattr->attr.lsmblob = netlbl_unlhsh_addr6_entry(addr6)->lsmblob;
>  		break;
>  	}
>  #endif /* IPv6 */
> diff --git a/net/netlabel/netlabel_unlabeled.h b/net/netlabel/netlabel_unlabeled.h
> index 3a9e5dc9511b..dcff99695c97 100644
> --- a/net/netlabel/netlabel_unlabeled.h
> +++ b/net/netlabel/netlabel_unlabeled.h
> @@ -225,7 +225,7 @@ int netlbl_unlhsh_add(struct net *net,
>  		      const void *addr,
>  		      const void *mask,
>  		      u32 addr_len,
> -		      u32 secid,
> +		      struct lsmblob *lsmblob,
>  		      struct netlbl_audit *audit_info);
>  int netlbl_unlhsh_remove(struct net *net,
>  			 const char *dev_name,
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 8c93b07bb353..d90dfce15d44 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6622,7 +6622,7 @@ struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
>  	.lbs_superblock = sizeof(struct superblock_security_struct),
>  };
>  
> -static struct lsm_id selinux_lsmid = { .lsm="selinux", .slot=LSMBLOB_NEEDED };
> +struct lsm_id selinux_lsmid = { .lsm="selinux", .slot=LSMBLOB_NEEDED };
>  
>  static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index b5b7c5aade8c..f0ca3879ba48 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -68,6 +68,7 @@
>  struct netlbl_lsm_secattr;
>  
>  extern int selinux_enabled;
> +extern struct lsm_id selinux_lsmid;
>  
>  /* Policy capabilities */
>  enum {
> diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
> index c40914a157b7..120d50c1bcac 100644
> --- a/security/selinux/netlabel.c
> +++ b/security/selinux/netlabel.c
> @@ -122,7 +122,7 @@ static struct netlbl_lsm_secattr *selinux_netlbl_sock_getattr(
>  		return NULL;
>  
>  	if ((secattr->flags & NETLBL_SECATTR_SECID) &&
> -	    (secattr->attr.secid == sid))
> +	    (secattr->attr.lsmblob.secid[selinux_lsmid.slot] == sid))
>  		return secattr;
>  
>  	return NULL;
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index e3f5d6aece66..4ca0e006c3cc 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -3593,7 +3593,7 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
>  	if (secattr->flags & NETLBL_SECATTR_CACHE)
>  		*sid = *(u32 *)secattr->cache->data;
>  	else if (secattr->flags & NETLBL_SECATTR_SECID)
> -		*sid = secattr->attr.secid;
> +		*sid = secattr->attr.lsmblob.secid[selinux_lsmid.slot];
>  	else if (secattr->flags & NETLBL_SECATTR_MLS_LVL) {
>  		rc = -EIDRM;
>  		ctx = sidtab_search(sidtab, SECINITSID_NETMSG);
> @@ -3666,7 +3666,7 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
>  	if (secattr->domain == NULL)
>  		goto out;
>  
> -	secattr->attr.secid = sid;
> +	secattr->attr.lsmblob.secid[selinux_lsmid.slot] = sid;
>  	secattr->flags |= NETLBL_SECATTR_DOMAIN_CPY | NETLBL_SECATTR_SECID;
>  	mls_export_netlbl_lvl(policydb, ctx, secattr);
>  	rc = mls_export_netlbl_cat(policydb, ctx, secattr);
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index 7cc3a3382fee..039bf5de56b4 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -320,6 +320,7 @@ void smk_destroy_label_list(struct list_head *list);
>   * Shared data.
>   */
>  extern int smack_enabled;
> +extern struct lsm_id smack_lsmid;
>  extern int smack_cipso_direct;
>  extern int smack_cipso_mapped;
>  extern struct smack_known *smack_net_ambient;
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 3d571c438dfa..a8d56ce00918 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3741,7 +3741,8 @@ static struct smack_known *smack_from_secattr(struct netlbl_lsm_secattr *sap,
>  		/*
>  		 * Looks like a fallback, which gives us a secid.
>  		 */
> -		return smack_from_secid(sap->attr.secid);
> +		return smack_from_secid(
> +				sap->attr.lsmblob.secid[smack_lsmid.slot]);
>  	/*
>  	 * Without guidance regarding the smack value
>  	 * for the packet fall back on the network
> @@ -4558,7 +4559,7 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
>  	.lbs_superblock = sizeof(struct superblock_smack),
>  };
>  
> -static struct lsm_id smack_lsmid = { .lsm="smack", .slot=LSMBLOB_NEEDED };
> +struct lsm_id smack_lsmid = { .lsm="smack", .slot=LSMBLOB_NEEDED };
>  
>  static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(ptrace_access_check, smack_ptrace_access_check),
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index faf2ea3968b3..6a4c468c200c 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -1150,6 +1150,7 @@ static void smk_net4addr_insert(struct smk_net4addr *new)
>  static ssize_t smk_write_net4addr(struct file *file, const char __user *buf,
>  				size_t count, loff_t *ppos)
>  {
> +	struct lsmblob lsmblob;
>  	struct smk_net4addr *snp;
>  	struct sockaddr_in newname;
>  	char *smack;
> @@ -1281,10 +1282,13 @@ static ssize_t smk_write_net4addr(struct file *file, const char __user *buf,
>  	 * this host so that incoming packets get labeled.
>  	 * but only if we didn't get the special CIPSO option
>  	 */
> -	if (rc == 0 && skp != NULL)
> +	if (rc == 0 && skp != NULL) {
> +		lsmblob_init(&lsmblob, 0);
> +		lsmblob.secid[smack_lsmid.slot] = snp->smk_label->smk_secid;
>  		rc = netlbl_cfg_unlbl_static_add(&init_net, NULL,
> -			&snp->smk_host, &snp->smk_mask, PF_INET,
> -			snp->smk_label->smk_secid, &audit_info);
> +			&snp->smk_host, &snp->smk_mask, PF_INET, &lsmblob,
> +			&audit_info);
> +	}
>  
>  	if (rc == 0)
>  		rc = count;
> 

