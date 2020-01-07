Return-Path: <SRS0=B3ih=24=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49387C282DD
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 19:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2BE520656
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 19:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="DCMgmRi8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgAGTZf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:25:35 -0500
Received: from UPDC19PA21.eemsg.mail.mil ([214.24.27.196]:59225 "EHLO
        UPDC19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbgAGTZf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jan 2020 14:25:35 -0500
X-EEMSG-check-017: 43434867|UPDC19PA21_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,407,1571702400"; 
   d="scan'208";a="43434867"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 07 Jan 2020 19:25:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578425130; x=1609961130;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=k5QS04sPCgdHyeGaz7Dyjzs36Py5B0wFTYFMO7tzTBg=;
  b=DCMgmRi8VhQvZVWvRAqS1hDFQZJUB7b+tU9pukQYVhZMI6LeLbhGhHWy
   5yV7Y8+9X7pm1YpW7kG7glYNevHgPN5triAFXRjv+T8oiYuF8kETZljYx
   tuT8ogcaLYIKgCiTlbrsGrbbSVpaKDKI8FGqD4SBxUTefRx5pHWbQK2hT
   4ooGKbwSEkNMhBRB8zVyGsSL8U/bmLZcAvD3hLe8fvH0TdYkjlVxpmYng
   kgHhz2MOPDxmg3umQ/bIhgOgQhn4ewrQf0T20dA+7ghkANsWRosgxP2xu
   Z8mYwvZpK77ZOTYT77vX3skQLwx7rn38286KnHCcG3XXXL9Gu6OfBh3TV
   g==;
X-IronPort-AV: E=Sophos;i="5.69,407,1571702400"; 
   d="scan'208";a="31690683"
IronPort-PHdr: =?us-ascii?q?9a23=3AFyCHKhC2hRnR7Ua2e5NdUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP3/oM2wAkXT6L1XgUPTWs2DsrQY0rGQ6f2+EjReqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba58IRmsswnctsgbjYR+Jqsw1x?=
 =?us-ascii?q?DEvmZGd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U6VWACwpPG?=
 =?us-ascii?q?4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Ui?=
 =?us-ascii?q?ms4qt3VBPljjoMOiUn+2/LlMN/kKNboAqgpxNhxY7UfJqVP+d6cq/EYN8WWX?=
 =?us-ascii?q?ZNUsNXWiNPGIO8a5YEAfQHM+hWsoLxo0ICoQW6CAWpAu7k1z1GiWLs3aAizu?=
 =?us-ascii?q?ovDw/G0gwjEdwAvnvbo9f6O7sdX+2u0KnFzy/OY+9K1Trz6oXFdA0qr/GWXb?=
 =?us-ascii?q?J3dMrc0VQhFx/bgVWIqYzqITWV3fkQvWie9eVgUeavhHAnqgpspTWv3dojip?=
 =?us-ascii?q?LSi4IJylHL6SV5wIEvKd2+U050e8SoEJRXtyGELoZ7RN4pTWJwuCsi17ELtp?=
 =?us-ascii?q?G2cDIKxZg63RLTdfOKf5aS7h7+UuuaPC12i2h/eL2lgha/6U2gyurhWcaqyF?=
 =?us-ascii?q?tKtS9FksXUtnAKyhzT9tCLSvtj8Uel3jaCzxzT5fteIUA1iKrbMIQtwr82lp?=
 =?us-ascii?q?odtkTDBTH5l1nsgK+KdkQr5uio6+P9brXgupCcLJN7hhv7MqQvnsyzGeU4Mg?=
 =?us-ascii?q?4QUGiH4emwybLu8ELjTLhKk/E6iLfVvZ/EKcgBu6K1GwpV3Zwi6xa7ATemyt?=
 =?us-ascii?q?MYnXwfIVJeZR2HlJPkO03OIf/kDfe/hE6gkDFwx//cJLHhDZLNLmbbnLf7Yb?=
 =?us-ascii?q?l981JcyBY0zd1H+51bEKoBL+zzW0Lqr9zXEh85PBapw+bpDNVyyJkeVXuTDa?=
 =?us-ascii?q?CDKq/drViI5uc3KemWeIAVoCr9K+Qi5/P2kXA2g0Qdcrep3JcNc3C3AvRmLF?=
 =?us-ascii?q?+EYXrihtcOD30KsxE/TOzslF2NTzpTa2yuUKI74zExEJimApvbRoCxnLyB2z?=
 =?us-ascii?q?+2Hp9TZmBBEFCMC3bod56fVvcKci2SJ9Fukj0eWbimUY8h2gmktBXmxLp/Mu?=
 =?us-ascii?q?rU5ioYuIrn1Nh04e3TiB4z+SVvD8uDz26NUnt0nmIURz42xax/pEt9xUqe0a?=
 =?us-ascii?q?h8nfNVDsJT5/xXXQcgL5LczPJ1C8r0Wg3feteFUlGmQs+pATspVNI+38cOY1?=
 =?us-ascii?q?phG9Wllh3DxDSlA7sUl7yNGZw1/bnR32b+J8lj0XbKzqohgEc8QstJK2Kmgr?=
 =?us-ascii?q?Rz9w/JB47Gi0+ZjbqldbwA3C7R82eO1WmOs19GXw5rTarFWncfZkjNoNvl5k?=
 =?us-ascii?q?PCVbiuCbEmMgtczM6OMKxKasfmjV9eXvfsJMzeY36tm2e3HRuIxLSMbIrse2?=
 =?us-ascii?q?kH3iXdD0gEnBoV/XadKwc+ADysrH7EAzxoElLvZULs/vVkp3O/VEM70waKb0?=
 =?us-ascii?q?h53bqv5hEVneCcS+8U3r8coCcutTN0HFmg39LXDdqMvglhc7tGYdM7/lhH0X?=
 =?us-ascii?q?nUtw1kMpykKKBimEARfx5sv0z01BV3F59AntIwoHMs0gV+M6CY0EtZfTOCwZ?=
 =?us-ascii?q?/wIqHXKnX1/B23c67ZwEze0NKN96cX8vs4tlHjsBisFkol9HVnycda32GA6Z?=
 =?us-ascii?q?XNCQpBGa72B20+7BVr74rRYiAg6YfZzzU4OqCvvy7qwNkpDfYrzhu6OtxWdq?=
 =?us-ascii?q?iDEVm2W8YTHMW/bvchm1G0YBYJJshT8rI5O4WtcP7CkKyuO/x6nSmOi21C7Y?=
 =?us-ascii?q?E71ViDs2J4S+jVz9MezvqFxAqbRnL5i1u8ts3fh49Jf3cRE3C5xCyiA5ReIu?=
 =?us-ascii?q?VpcIIKD3q+C9O4y884hJP3XXNcslm5CAAowsisLCGOYkT90AsY7kEepXiqiG?=
 =?us-ascii?q?Ps1DBvuy04paqYmirVyqLtcwRRaT0Df3VrkVq5edv8tNsdRkX9KlFzxRY=3D?=
X-IPAS-Result: =?us-ascii?q?A2CXAwCq2hRe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXyBf?=
 =?us-ascii?q?YFtIBIqhAmJA4ZuBoESJYlukUgJAQEBAQEBAQEBNwEBhEACgg04EwIQAQEBB?=
 =?us-ascii?q?AEBAQEBBQMBAWyFQ4I7KQGCegEFIwQRQRALGAICJgICVwYBDAYCAQGCUww/g?=
 =?us-ascii?q?lMlrSB/M4VPgy2BPYEOKIwzeYEHgREnDAOCLy4+hDWDJIJeBI1MiU1Gl0CCQ?=
 =?us-ascii?q?IJFiiuJJgYbgkeYGI5TgUiVKoYAIoFYKwgCGAghDzuCbFAYDY0dAReOQSMDM?=
 =?us-ascii?q?IwbgkIBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 07 Jan 2020 19:25:21 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 007JOkaf227753;
        Tue, 7 Jan 2020 14:24:47 -0500
Subject: Re: [PATCH v13 19/25] NET: Store LSM netlabel data in a lsmblob
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191224235939.7483-1-casey@schaufler-ca.com>
 <20191224235939.7483-20-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <9e114536-36be-9395-ef00-cd1059d710ac@tycho.nsa.gov>
Date:   Tue, 7 Jan 2020 14:25:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191224235939.7483-20-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/24/19 6:59 PM, Casey Schaufler wrote:
> Netlabel uses LSM interfaces requiring an lsmblob and
> the internal storage is used to pass information between
> these interfaces, so change the internal data from a secid
> to a lsmblob. Update the netlabel interfaces and their
> callers to accommodate the change. This requires that the
> modules using netlabel use the lsm_id.slot to access the
> correct secid when using netlabel.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Why is this needed for stacking AppArmor?  AA doesn't use NetLabel, at 
least not upstream AFAICS.

> ---
>   include/net/netlabel.h              |  8 ++--
>   net/ipv4/cipso_ipv4.c               | 23 +++++++-----
>   net/netlabel/netlabel_kapi.c        |  6 +--
>   net/netlabel/netlabel_unlabeled.c   | 57 +++++++++++------------------
>   net/netlabel/netlabel_unlabeled.h   |  2 +-
>   security/selinux/hooks.c            |  2 +-
>   security/selinux/include/security.h |  1 +
>   security/selinux/netlabel.c         |  2 +-
>   security/selinux/ss/services.c      |  4 +-
>   security/smack/smack.h              |  1 +
>   security/smack/smack_lsm.c          |  5 ++-
>   security/smack/smackfs.c            | 10 +++--
>   12 files changed, 59 insertions(+), 62 deletions(-)
> 
> diff --git a/include/net/netlabel.h b/include/net/netlabel.h
> index 43ae50337685..73fc25b4042b 100644
> --- a/include/net/netlabel.h
> +++ b/include/net/netlabel.h
> @@ -166,7 +166,7 @@ struct netlbl_lsm_catmap {
>    * @attr.mls: MLS sensitivity label
>    * @attr.mls.cat: MLS category bitmap
>    * @attr.mls.lvl: MLS sensitivity level
> - * @attr.secid: LSM specific secid token
> + * @attr.lsmblob: LSM specific data
>    *
>    * Description:
>    * This structure is used to pass security attributes between NetLabel and the
> @@ -201,7 +201,7 @@ struct netlbl_lsm_secattr {
>   			struct netlbl_lsm_catmap *cat;
>   			u32 lvl;
>   		} mls;
> -		u32 secid;
> +		struct lsmblob lsmblob;
>   	} attr;
>   };
>   
> @@ -415,7 +415,7 @@ int netlbl_cfg_unlbl_static_add(struct net *net,
>   				const void *addr,
>   				const void *mask,
>   				u16 family,
> -				u32 secid,
> +				struct lsmblob *lsmblob,
>   				struct netlbl_audit *audit_info);
>   int netlbl_cfg_unlbl_static_del(struct net *net,
>   				const char *dev_name,
> @@ -523,7 +523,7 @@ static inline int netlbl_cfg_unlbl_static_add(struct net *net,
>   					      const void *addr,
>   					      const void *mask,
>   					      u16 family,
> -					      u32 secid,
> +					      struct lsmblob *lsmblob,
>   					      struct netlbl_audit *audit_info)
>   {
>   	return -ENOSYS;
> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index 376882215919..adb9dffc3952 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -106,15 +106,17 @@ int cipso_v4_rbm_strictvalid = 1;
>   /* Base length of the local tag (non-standard tag).
>    *  Tag definition (may change between kernel versions)
>    *
> - * 0          8          16         24         32
> - * +----------+----------+----------+----------+
> - * | 10000000 | 00000110 | 32-bit secid value  |
> - * +----------+----------+----------+----------+
> - * | in (host byte order)|
> - * +----------+----------+
> - *
> + * 0          8          16                    16 + sizeof(struct lsmblob)
> + * +----------+----------+---------------------+
> + * | 10000000 | 00000110 | LSM blob data       |
> + * +----------+----------+---------------------+
> + *
> + * All secid and flag fields are in host byte order.
> + * The lsmblob structure size varies depending on which
> + * Linux security modules are built in the kernel.
> + * The data is opaque.
>    */
> -#define CIPSO_V4_TAG_LOC_BLEN         6
> +#define CIPSO_V4_TAG_LOC_BLEN         (2 + sizeof(struct lsmblob))
>   
>   /*
>    * Helper Functions
> @@ -1467,7 +1469,8 @@ static int cipso_v4_gentag_loc(const struct cipso_v4_doi *doi_def,
>   
>   	buffer[0] = CIPSO_V4_TAG_LOCAL;
>   	buffer[1] = CIPSO_V4_TAG_LOC_BLEN;
> -	*(u32 *)&buffer[2] = secattr->attr.secid;
> +	memcpy(&buffer[2], &secattr->attr.lsmblob,
> +	       sizeof(secattr->attr.lsmblob));
>   
>   	return CIPSO_V4_TAG_LOC_BLEN;
>   }
> @@ -1487,7 +1490,7 @@ static int cipso_v4_parsetag_loc(const struct cipso_v4_doi *doi_def,
>   				 const unsigned char *tag,
>   				 struct netlbl_lsm_secattr *secattr)
>   {
> -	secattr->attr.secid = *(u32 *)&tag[2];
> +	memcpy(&secattr->attr.lsmblob, &tag[2], sizeof(secattr->attr.lsmblob));
>   	secattr->flags |= NETLBL_SECATTR_SECID;
>   
>   	return 0;
> diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
> index 409a3ae47ce2..f2ebd43a7992 100644
> --- a/net/netlabel/netlabel_kapi.c
> +++ b/net/netlabel/netlabel_kapi.c
> @@ -196,7 +196,7 @@ int netlbl_cfg_unlbl_map_add(const char *domain,
>    * @addr: IP address in network byte order (struct in[6]_addr)
>    * @mask: address mask in network byte order (struct in[6]_addr)
>    * @family: address family
> - * @secid: LSM secid value for the entry
> + * @lsmblob: LSM data value for the entry
>    * @audit_info: NetLabel audit information
>    *
>    * Description:
> @@ -210,7 +210,7 @@ int netlbl_cfg_unlbl_static_add(struct net *net,
>   				const void *addr,
>   				const void *mask,
>   				u16 family,
> -				u32 secid,
> +				struct lsmblob *lsmblob,
>   				struct netlbl_audit *audit_info)
>   {
>   	u32 addr_len;
> @@ -230,7 +230,7 @@ int netlbl_cfg_unlbl_static_add(struct net *net,
>   
>   	return netlbl_unlhsh_add(net,
>   				 dev_name, addr, mask, addr_len,
> -				 secid, audit_info);
> +				 lsmblob, audit_info);
>   }
>   
>   /**
> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
> index c03fe9a4f7b9..3b0f07b59436 100644
> --- a/net/netlabel/netlabel_unlabeled.c
> +++ b/net/netlabel/netlabel_unlabeled.c
> @@ -66,7 +66,7 @@ struct netlbl_unlhsh_tbl {
>   #define netlbl_unlhsh_addr4_entry(iter) \
>   	container_of(iter, struct netlbl_unlhsh_addr4, list)
>   struct netlbl_unlhsh_addr4 {
> -	u32 secid;
> +	struct lsmblob lsmblob;
>   
>   	struct netlbl_af4list list;
>   	struct rcu_head rcu;
> @@ -74,7 +74,7 @@ struct netlbl_unlhsh_addr4 {
>   #define netlbl_unlhsh_addr6_entry(iter) \
>   	container_of(iter, struct netlbl_unlhsh_addr6, list)
>   struct netlbl_unlhsh_addr6 {
> -	u32 secid;
> +	struct lsmblob lsmblob;
>   
>   	struct netlbl_af6list list;
>   	struct rcu_head rcu;
> @@ -219,7 +219,7 @@ static struct netlbl_unlhsh_iface *netlbl_unlhsh_search_iface(int ifindex)
>    * @iface: the associated interface entry
>    * @addr: IPv4 address in network byte order
>    * @mask: IPv4 address mask in network byte order
> - * @secid: LSM secid value for entry
> + * @lsmblob: LSM data value for entry
>    *
>    * Description:
>    * Add a new address entry into the unlabeled connection hash table using the
> @@ -230,7 +230,7 @@ static struct netlbl_unlhsh_iface *netlbl_unlhsh_search_iface(int ifindex)
>   static int netlbl_unlhsh_add_addr4(struct netlbl_unlhsh_iface *iface,
>   				   const struct in_addr *addr,
>   				   const struct in_addr *mask,
> -				   u32 secid)
> +				   struct lsmblob *lsmblob)
>   {
>   	int ret_val;
>   	struct netlbl_unlhsh_addr4 *entry;
> @@ -242,7 +242,7 @@ static int netlbl_unlhsh_add_addr4(struct netlbl_unlhsh_iface *iface,
>   	entry->list.addr = addr->s_addr & mask->s_addr;
>   	entry->list.mask = mask->s_addr;
>   	entry->list.valid = 1;
> -	entry->secid = secid;
> +	entry->lsmblob = *lsmblob;
>   
>   	spin_lock(&netlbl_unlhsh_lock);
>   	ret_val = netlbl_af4list_add(&entry->list, &iface->addr4_list);
> @@ -259,7 +259,7 @@ static int netlbl_unlhsh_add_addr4(struct netlbl_unlhsh_iface *iface,
>    * @iface: the associated interface entry
>    * @addr: IPv6 address in network byte order
>    * @mask: IPv6 address mask in network byte order
> - * @secid: LSM secid value for entry
> + * @lsmblob: LSM data value for entry
>    *
>    * Description:
>    * Add a new address entry into the unlabeled connection hash table using the
> @@ -270,7 +270,7 @@ static int netlbl_unlhsh_add_addr4(struct netlbl_unlhsh_iface *iface,
>   static int netlbl_unlhsh_add_addr6(struct netlbl_unlhsh_iface *iface,
>   				   const struct in6_addr *addr,
>   				   const struct in6_addr *mask,
> -				   u32 secid)
> +				   struct lsmblob *lsmblob)
>   {
>   	int ret_val;
>   	struct netlbl_unlhsh_addr6 *entry;
> @@ -286,7 +286,7 @@ static int netlbl_unlhsh_add_addr6(struct netlbl_unlhsh_iface *iface,
>   	entry->list.addr.s6_addr32[3] &= mask->s6_addr32[3];
>   	entry->list.mask = *mask;
>   	entry->list.valid = 1;
> -	entry->secid = secid;
> +	entry->lsmblob = *lsmblob;
>   
>   	spin_lock(&netlbl_unlhsh_lock);
>   	ret_val = netlbl_af6list_add(&entry->list, &iface->addr6_list);
> @@ -365,7 +365,7 @@ int netlbl_unlhsh_add(struct net *net,
>   		      const void *addr,
>   		      const void *mask,
>   		      u32 addr_len,
> -		      u32 secid,
> +		      struct lsmblob *lsmblob,
>   		      struct netlbl_audit *audit_info)
>   {
>   	int ret_val;
> @@ -374,7 +374,6 @@ int netlbl_unlhsh_add(struct net *net,
>   	struct netlbl_unlhsh_iface *iface;
>   	struct audit_buffer *audit_buf = NULL;
>   	struct lsmcontext context;
> -	struct lsmblob blob;
>   
>   	if (addr_len != sizeof(struct in_addr) &&
>   	    addr_len != sizeof(struct in6_addr))
> @@ -407,7 +406,7 @@ int netlbl_unlhsh_add(struct net *net,
>   		const struct in_addr *addr4 = addr;
>   		const struct in_addr *mask4 = mask;
>   
> -		ret_val = netlbl_unlhsh_add_addr4(iface, addr4, mask4, secid);
> +		ret_val = netlbl_unlhsh_add_addr4(iface, addr4, mask4, lsmblob);
>   		if (audit_buf != NULL)
>   			netlbl_af4list_audit_addr(audit_buf, 1,
>   						  dev_name,
> @@ -420,7 +419,7 @@ int netlbl_unlhsh_add(struct net *net,
>   		const struct in6_addr *addr6 = addr;
>   		const struct in6_addr *mask6 = mask;
>   
> -		ret_val = netlbl_unlhsh_add_addr6(iface, addr6, mask6, secid);
> +		ret_val = netlbl_unlhsh_add_addr6(iface, addr6, mask6, lsmblob);
>   		if (audit_buf != NULL)
>   			netlbl_af6list_audit_addr(audit_buf, 1,
>   						  dev_name,
> @@ -437,8 +436,7 @@ int netlbl_unlhsh_add(struct net *net,
>   unlhsh_add_return:
>   	rcu_read_unlock();
>   	if (audit_buf != NULL) {
> -		lsmblob_init(&blob, secid);
> -		if (security_secid_to_secctx(&blob, &context) == 0) {
> +		if (security_secid_to_secctx(lsmblob, &context) == 0) {
>   			audit_log_format(audit_buf, " sec_obj=%s",
>   					 context.context);
>   			security_release_secctx(&context);
> @@ -473,7 +471,6 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
>   	struct audit_buffer *audit_buf;
>   	struct net_device *dev;
>   	struct lsmcontext context;
> -	struct lsmblob blob;
>   
>   	spin_lock(&netlbl_unlhsh_lock);
>   	list_entry = netlbl_af4list_remove(addr->s_addr, mask->s_addr,
> @@ -493,10 +490,8 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
>   					  addr->s_addr, mask->s_addr);
>   		if (dev != NULL)
>   			dev_put(dev);
> -		if (entry != NULL)
> -			lsmblob_init(&blob, entry->secid);
>   		if (entry != NULL &&
> -		    security_secid_to_secctx(&blob, &context) == 0) {
> +		    security_secid_to_secctx(&entry->lsmblob, &context) == 0) {
>   			audit_log_format(audit_buf, " sec_obj=%s",
>   					 context.context);
>   			security_release_secctx(&context);
> @@ -537,7 +532,6 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
>   	struct audit_buffer *audit_buf;
>   	struct net_device *dev;
>   	struct lsmcontext context;
> -	struct lsmblob blob;
>   
>   	spin_lock(&netlbl_unlhsh_lock);
>   	list_entry = netlbl_af6list_remove(addr, mask, &iface->addr6_list);
> @@ -556,10 +550,8 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
>   					  addr, mask);
>   		if (dev != NULL)
>   			dev_put(dev);
> -		if (entry != NULL)
> -			lsmblob_init(&blob, entry->secid);
>   		if (entry != NULL &&
> -		    security_secid_to_secctx(&blob, &context) == 0) {
> +		    security_secid_to_secctx(&entry->lsmblob, &context) == 0) {
>   			audit_log_format(audit_buf, " sec_obj=%s",
>   					 context.context);
>   			security_release_secctx(&context);
> @@ -913,9 +905,8 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
>   	if (ret_val != 0)
>   		return ret_val;
>   
> -	/* scaffolding with the [0] */
>   	return netlbl_unlhsh_add(&init_net,
> -				 dev_name, addr, mask, addr_len, blob.secid[0],
> +				 dev_name, addr, mask, addr_len, &blob,
>   				 &audit_info);
>   }
>   
> @@ -963,10 +954,8 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
>   	if (ret_val != 0)
>   		return ret_val;
>   
> -	/* scaffolding with the [0] */
>   	return netlbl_unlhsh_add(&init_net,
> -				 NULL, addr, mask, addr_len, blob.secid[0],
> -				 &audit_info);
> +				 NULL, addr, mask, addr_len, &blob, &audit_info);
>   }
>   
>   /**
> @@ -1078,8 +1067,7 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
>   	struct net_device *dev;
>   	struct lsmcontext context;
>   	void *data;
> -	u32 secid;
> -	struct lsmblob blob;
> +	struct lsmblob *lsmb;
>   
>   	data = genlmsg_put(cb_arg->skb, NETLINK_CB(cb_arg->nl_cb->skb).portid,
>   			   cb_arg->seq, &netlbl_unlabel_gnl_family,
> @@ -1117,7 +1105,7 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
>   		if (ret_val != 0)
>   			goto list_cb_failure;
>   
> -		secid = addr4->secid;
> +		lsmb = (struct lsmblob *)&addr4->lsmblob;
>   	} else {
>   		ret_val = nla_put_in6_addr(cb_arg->skb,
>   					   NLBL_UNLABEL_A_IPV6ADDR,
> @@ -1131,11 +1119,10 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
>   		if (ret_val != 0)
>   			goto list_cb_failure;
>   
> -		secid = addr6->secid;
> +		lsmb = (struct lsmblob *)&addr6->lsmblob;
>   	}
>   
> -	lsmblob_init(&blob, secid);
> -	ret_val = security_secid_to_secctx(&blob, &context);
> +	ret_val = security_secid_to_secctx(lsmb, &context);
>   	if (ret_val != 0)
>   		goto list_cb_failure;
>   	ret_val = nla_put(cb_arg->skb,
> @@ -1487,7 +1474,7 @@ int netlbl_unlabel_getattr(const struct sk_buff *skb,
>   					      &iface->addr4_list);
>   		if (addr4 == NULL)
>   			goto unlabel_getattr_nolabel;
> -		secattr->attr.secid = netlbl_unlhsh_addr4_entry(addr4)->secid;
> +		secattr->attr.lsmblob = netlbl_unlhsh_addr4_entry(addr4)->lsmblob;
>   		break;
>   	}
>   #if IS_ENABLED(CONFIG_IPV6)
> @@ -1500,7 +1487,7 @@ int netlbl_unlabel_getattr(const struct sk_buff *skb,
>   					      &iface->addr6_list);
>   		if (addr6 == NULL)
>   			goto unlabel_getattr_nolabel;
> -		secattr->attr.secid = netlbl_unlhsh_addr6_entry(addr6)->secid;
> +		secattr->attr.lsmblob = netlbl_unlhsh_addr6_entry(addr6)->lsmblob;
>   		break;
>   	}
>   #endif /* IPv6 */
> diff --git a/net/netlabel/netlabel_unlabeled.h b/net/netlabel/netlabel_unlabeled.h
> index 058e3a285d56..168920780994 100644
> --- a/net/netlabel/netlabel_unlabeled.h
> +++ b/net/netlabel/netlabel_unlabeled.h
> @@ -211,7 +211,7 @@ int netlbl_unlhsh_add(struct net *net,
>   		      const void *addr,
>   		      const void *mask,
>   		      u32 addr_len,
> -		      u32 secid,
> +		      struct lsmblob *lsmblob,
>   		      struct netlbl_audit *audit_info);
>   int netlbl_unlhsh_remove(struct net *net,
>   			 const char *dev_name,
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index b8501ca3c8f3..cd4743331800 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6871,7 +6871,7 @@ static int selinux_perf_event_write(struct perf_event *event)
>   }
>   #endif
>   
> -static struct lsm_id selinux_lsmid __lsm_ro_after_init = {
> +struct lsm_id selinux_lsmid __lsm_ro_after_init = {
>   	.lsm  = "selinux",
>   	.slot = LSMBLOB_NEEDED
>   };
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index ae840634e3c7..741ba0e6dd83 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -70,6 +70,7 @@
>   struct netlbl_lsm_secattr;
>   
>   extern int selinux_enabled;
> +extern struct lsm_id selinux_lsmid;
>   
>   /* Policy capabilities */
>   enum {
> diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
> index 6a94b31b5472..d8d7603ab14e 100644
> --- a/security/selinux/netlabel.c
> +++ b/security/selinux/netlabel.c
> @@ -108,7 +108,7 @@ static struct netlbl_lsm_secattr *selinux_netlbl_sock_getattr(
>   		return NULL;
>   
>   	if ((secattr->flags & NETLBL_SECATTR_SECID) &&
> -	    (secattr->attr.secid == sid))
> +	    (secattr->attr.lsmblob.secid[selinux_lsmid.slot] == sid))
>   		return secattr;
>   
>   	return NULL;
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index a5813c7629c1..2b7680903b6b 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -3599,7 +3599,7 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
>   	if (secattr->flags & NETLBL_SECATTR_CACHE)
>   		*sid = *(u32 *)secattr->cache->data;
>   	else if (secattr->flags & NETLBL_SECATTR_SECID)
> -		*sid = secattr->attr.secid;
> +		*sid = secattr->attr.lsmblob.secid[selinux_lsmid.slot];
>   	else if (secattr->flags & NETLBL_SECATTR_MLS_LVL) {
>   		rc = -EIDRM;
>   		ctx = sidtab_search(sidtab, SECINITSID_NETMSG);
> @@ -3672,7 +3672,7 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
>   	if (secattr->domain == NULL)
>   		goto out;
>   
> -	secattr->attr.secid = sid;
> +	secattr->attr.lsmblob.secid[selinux_lsmid.slot] = sid;
>   	secattr->flags |= NETLBL_SECATTR_DOMAIN_CPY | NETLBL_SECATTR_SECID;
>   	mls_export_netlbl_lvl(policydb, ctx, secattr);
>   	rc = mls_export_netlbl_cat(policydb, ctx, secattr);
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index 2836540f9577..6e76b6b33063 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -316,6 +316,7 @@ void smk_destroy_label_list(struct list_head *list);
>    * Shared data.
>    */
>   extern int smack_enabled;
> +extern struct lsm_id smack_lsmid;
>   extern int smack_cipso_direct;
>   extern int smack_cipso_mapped;
>   extern struct smack_known *smack_net_ambient;
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 9737ead06b39..9ce67e03ac49 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3775,7 +3775,8 @@ static struct smack_known *smack_from_secattr(struct netlbl_lsm_secattr *sap,
>   		/*
>   		 * Looks like a fallback, which gives us a secid.
>   		 */
> -		return smack_from_secid(sap->attr.secid);
> +		return smack_from_secid(
> +				sap->attr.lsmblob.secid[smack_lsmid.slot]);
>   	/*
>   	 * Without guidance regarding the smack value
>   	 * for the packet fall back on the network
> @@ -4592,7 +4593,7 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
>   	.lbs_sock = sizeof(struct socket_smack),
>   };
>   
> -static struct lsm_id smack_lsmid __lsm_ro_after_init = {
> +struct lsm_id smack_lsmid __lsm_ro_after_init = {
>   	.lsm  = "smack",
>   	.slot = LSMBLOB_NEEDED
>   };
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index e3e05c04dbd1..d10e9c96717e 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -1122,6 +1122,7 @@ static void smk_net4addr_insert(struct smk_net4addr *new)
>   static ssize_t smk_write_net4addr(struct file *file, const char __user *buf,
>   				size_t count, loff_t *ppos)
>   {
> +	struct lsmblob lsmblob;
>   	struct smk_net4addr *snp;
>   	struct sockaddr_in newname;
>   	char *smack;
> @@ -1253,10 +1254,13 @@ static ssize_t smk_write_net4addr(struct file *file, const char __user *buf,
>   	 * this host so that incoming packets get labeled.
>   	 * but only if we didn't get the special CIPSO option
>   	 */
> -	if (rc == 0 && skp != NULL)
> +	if (rc == 0 && skp != NULL) {
> +		lsmblob_init(&lsmblob, 0);
> +		lsmblob.secid[smack_lsmid.slot] = snp->smk_label->smk_secid;
>   		rc = netlbl_cfg_unlbl_static_add(&init_net, NULL,
> -			&snp->smk_host, &snp->smk_mask, PF_INET,
> -			snp->smk_label->smk_secid, &audit_info);
> +			&snp->smk_host, &snp->smk_mask, PF_INET, &lsmblob,
> +			&audit_info);
> +	}
>   
>   	if (rc == 0)
>   		rc = count;
> 

