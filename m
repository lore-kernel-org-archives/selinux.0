Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBC8C2D0DB
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 14:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D01120661
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 14:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ARdipO5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392057AbgAXOff (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:35:35 -0500
Received: from USAT19PA25.eemsg.mail.mil ([214.24.22.199]:14371 "EHLO
        USAT19PA25.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387829AbgAXOfe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jan 2020 09:35:34 -0500
X-EEMSG-check-017: 73098985|USAT19PA25_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,358,1574121600"; 
   d="scan'208";a="73098985"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA25.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 24 Jan 2020 14:35:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579876532; x=1611412532;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=/qd8O4wJFWCaylyfdxJ/XQ8Qzps25L1NbWLn6O6GgYQ=;
  b=ARdipO5aWkT5SlYna/WYCaJLgNTfHOXm//zow5v5EoZDWL+bd6vhuUMX
   viNCvzD5yoIcNicCOhJeNyBTDfh92KSQ8YmszBvrs0h7Aqr0806lXtzSb
   643JPSdoYDln3MwHEKLdRR6OKsOK6+KRccisLZLsqxMtC+Df9rzS6TmZP
   u474KkVOK6p4rm7s5ZOC3LBK+KuUsMDv7GEy8uLQZPo51rQMrk/03D44B
   i0Z5i8+mzxkYSUuDX+ZjwJMxFeL/SEjzhvihgEo77fA4ZUY8Y9zvzXkGZ
   ZYzcztFjXYu/VCNMZdKDonvw3nbXkKKKxJEEGUeukozdvOn+un6VqJHIN
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,358,1574121600"; 
   d="scan'208";a="32294785"
IronPort-PHdr: =?us-ascii?q?9a23=3Amlw10hcN7mYHRQzgpKh0Q+/ClGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc2/ZBCN2/xhgRfzUJnB7Loc0qyK6vymAzBLv8zJ8ChbNsAVDF?=
 =?us-ascii?q?ld0YRetjdjKfbNMVf8Iv/uYn5yN+V5f3ghwUuGN1NIEt31fVzYry76xzcTHh?=
 =?us-ascii?q?LiKVg9fbytScbdgMutyu+95YDYbRlWizqhe7NyKwi9oRnMusUMjoZuN6k8xg?=
 =?us-ascii?q?HXrnZHdOhbxH1kLk+Xkxrg+8u85pFu/zletv4768JMTaD2dLkkQLJFCzgrL3?=
 =?us-ascii?q?o779DxuxnZSguP6HocUmEInRdNHgPI8hL0UIrvvyXjruZy1zWUMsPwTbAvRD?=
 =?us-ascii?q?St9LxrRwPyiCcGLDE27mfagdFtga1BoRKhoxt/w5PIYIyQKfFzcL/Rcc8cSG?=
 =?us-ascii?q?FcRctaSTBPDZ2gYIsOF+oBPPhXr4/hp1sVsBCyARCgCP7zxjNUg3P726M10/?=
 =?us-ascii?q?4lEQrbwgIuGdwAu2nQoNnsKqsfVeW5wa/VxjvBcvxWwy/w5pXWfBAvof+CXr?=
 =?us-ascii?q?x+fsTexkYtCwzLgU6dqZDnMj6PyugBr2aW4uhmWOmyi2AnsQZxoj23y8kxlo?=
 =?us-ascii?q?nGmJoVylDa+iV/3Y07ONi4R1R/Yd6gDpRRtzyROoxtQsw/WGFlozo6y70atp?=
 =?us-ascii?q?67eygG0pInxwXFZPCdfIiI5QzjWf+XLDxlh3xlYKqyiwu9/EWv0OHxVtS43E?=
 =?us-ascii?q?xUoidKjNXArG0B2hrO4cadUPR95F2u2TOX2gDW7eFLPF47mLLAK54k3r4wjp?=
 =?us-ascii?q?0TsVnfHiPumEX5kquWdkI89+i08evneLTmpoKHN4NuiwH+NKoumsukAesmLg?=
 =?us-ascii?q?cCRXSb+OSg273j+k31WrNKgeEtkqbFqpzaIMUbpqqhDw9U1IYs9Qq/Ai+73N?=
 =?us-ascii?q?kXknQLNlJIdA+dg4T3NFzCPur0Aeqnj1SpijhrxvTGPrP7ApXKK3jOiKzhcq?=
 =?us-ascii?q?tm60NH1AoyzcxQ55JTCr0bJvLzQVX+uMbXDh8+LQy42/znB8ll1oMCRWKPBb?=
 =?us-ascii?q?eUP7/Ivl+T+O0uI/KBZJQJtzb9Mfcl+vDujXsnll8HZKWmwYEYZGqkEfRhJk?=
 =?us-ascii?q?WTeWDsjcsZEWcWogo+S/Tnh0GYXj5IeXmzX7gw5ionB4KmF4jDW46tgLif0y?=
 =?us-ascii?q?ehBZBWZ2ZGCkySHnfsbYmLR/AMaCeKKM97jjMETaShS5Mm1Ry2tg/6zr1nLv?=
 =?us-ascii?q?DO+i0ZrpLuz9516PfWlR4s9Dx4FcOd03uCT2tshGMHWyc23LxjoUx60lqD1a?=
 =?us-ascii?q?l4g/pFFd1c/v9JSRk1OoLBz+xgCtDyRgLAcs6MSFahX9qmHDUxQcwqzt8QbE?=
 =?us-ascii?q?ZyBc+iggrA3yW0Gb8VkaKEBJgu/qLbxXjxKN53y2za26k5k1kmXsxPOHW9hq?=
 =?us-ascii?q?Fh8wjTBojJk1iWlquxa6Qc0zDC9H2ZwWqNok5YSghwXrvBXXwFYUvWt9v57F?=
 =?us-ascii?q?vYT7CyEbQnLhdBycmaJ6tJdNLmk05GS+vkONTZYGK8gHu/BRaSxrOLaYrqen?=
 =?us-ascii?q?gd3CDHBEgDiQAT8m6MNRIiCSe5v2LeEDtuGErtY0Pr8el+rmm3Tk0zzwGKdU?=
 =?us-ascii?q?Jh0aG19QAThfGHV/wcxLQEuCAnqzV1AFmyxdbWB8CcqApmeaVWeck970tf1W?=
 =?us-ascii?q?LFqwx9OYStL7h8iV4YfAR3okLu1xNuBoVDj8cqtnUqwxR2Ka+D0VNNbjeY3Z?=
 =?us-ascii?q?fuOrLJMGXy5wqga63L2lHEytma4KEP5+oip1XhpAGjDlAi/Gl/09lJz3uc4Y?=
 =?us-ascii?q?3HDBIIXpLsVkY67AB6qKvHYik5/o/U0HpsMa6usjDcwd4mGOwlyhPzN+tYZY?=
 =?us-ascii?q?iNDwLjW/YRB8GzJugngRD9ZRsfMfF676U0Nt6oc/acnaWieu1nmWTixW9O+4?=
 =?us-ascii?q?1slFmH9yNhROrFxb4Exe2V2k2MUDK4xFWktdrtmJtsYzgXE2v5zjLrQMZVZ6?=
 =?us-ascii?q?tvbcMQBGyzOcyr15B7gJLwX3Nw6lGuHRUF1dWvdB7UaEbymUVL2EAWp2G3sT?=
 =?us-ascii?q?W3wiYykDwzqKebmivUzLfMbh0Cb1VXSXFigFGkGo29i9QXTQD8dAQyvAe07k?=
 =?us-ascii?q?b9ga5AreJwKHeFEhQARDT/M2w3Cvj4jbGFecMarcpy4Cg=3D?=
X-IPAS-Result: =?us-ascii?q?A2BqAgAmACte/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFtIBIqhBKJA4Z2BoE3iW+RSQkBAQEBAQEBAQE3AQGEQAKCRjgTAhABAQEEA?=
 =?us-ascii?q?QEBAQEFAwEBbIVDgjspAYJ6AQUjBBFBEAsYAgImAgJXBgEMBgIBAYJXDD+CV?=
 =?us-ascii?q?yWtBn8zhUqDMIE+gQ4qjDF5gQeBEScPgi8uPoQ1gySCXgSNXIlYRpdegkOCT?=
 =?us-ascii?q?Io6iSsGG4JImDSOYIFKlUyGCCKBWCsIAhgIIQ87gmxQGA2IDAEXjkEjAzCLF?=
 =?us-ascii?q?IJCAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 24 Jan 2020 14:35:24 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00OEYWHp248063;
        Fri, 24 Jan 2020 09:34:35 -0500
Subject: Re: [PATCH v14 18/23] NET: Store LSM netlabel data in a lsmblob
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20200124002306.3552-1-casey@schaufler-ca.com>
 <20200124002306.3552-19-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <0a2cf4e8-3edf-43c8-9b1f-42c5fc11ab73@tycho.nsa.gov>
Date:   Fri, 24 Jan 2020 09:36:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200124002306.3552-19-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/23/20 7:23 PM, Casey Schaufler wrote:
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

Similarly, I acked v13 of this patch and didn't see any real change here.

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

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

