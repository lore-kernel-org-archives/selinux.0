Return-Path: <SRS0=SKFz=ZL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25E4C432C0
	for <selinux@archiver.kernel.org>; Tue, 19 Nov 2019 18:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A84A20721
	for <selinux@archiver.kernel.org>; Tue, 19 Nov 2019 18:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="HQuay805"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfKSSrP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Nov 2019 13:47:15 -0500
Received: from USAT19PA25.eemsg.mail.mil ([214.24.22.199]:62283 "EHLO
        USAT19PA25.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbfKSSrP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Nov 2019 13:47:15 -0500
X-EEMSG-check-017: 52443221|USAT19PA25_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,219,1571702400"; 
   d="scan'208";a="52443221"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA25.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 19 Nov 2019 18:46:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574189199; x=1605725199;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=a1qenierVxR6C2UDlTKgZhfyk6t3yvYhwifbLvyty/Q=;
  b=HQuay805RzPyFadheWPiLVpV7eHY6+AlvWvRdIbevJjWeNpjPUXtNJVH
   2kjF9RqGhWojaUR77cxuhMepuGQU7q1Gwjg3FmLyNQYwQz75rhwHptq3h
   QieNDuCfmBE7TkVGqMJY1b2Ck0JYGAenYBIjafNnT6q+N/t3lO9Ll4wk9
   0hVUIUy3GE5hChD0xNQQhLBpT+Zzxi9fj+PMmaa2Cdirvex6D2Bc15R1l
   DW4glhjUaX4jnzD+Oi5Agydo61Kb6woMlYFSLwkj3RYb/2ff2kd45lh8Z
   hXRKU2nx08KnoYyCLvEnXFGYERfGNdSRzFWaC/VWCz6j7tdSHlQepTyYS
   w==;
X-IronPort-AV: E=Sophos;i="5.69,219,1571702400"; 
   d="scan'208";a="35731673"
IronPort-PHdr: =?us-ascii?q?9a23=3AXwZHGxYblDdFJnpLN7uD913/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZrsiybnLW6fgltlLVR4KTs6sC17ON9fm8CSdZuMjJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/MusQZgoZuJbs9xg?=
 =?us-ascii?q?bIr3BVZ+lY2GRkKE6JkR3h/Mmw5plj8ypRu/Il6cFNVLjxcro7Q7JFEjkoKn?=
 =?us-ascii?q?g568L3uxbNSwuP/WYcXX4NkhVUGQjF7Qr1UYn3vyDnq+dywiiaPcnxTbApRT?=
 =?us-ascii?q?Sv6rpgRRH0hCsbMTMy7XragdJsgq1FvB2hpgR/w4/Kb4GTKPp+Zb7WcdcDSW?=
 =?us-ascii?q?ZcQspdSylND4WyYIsVC+oKIPhWoY/zqVATqReyHAehCefqxjJOm3T437A10/?=
 =?us-ascii?q?45HA/bwgIgEdIAvnfaotr7O6gdU/y6wqbTwDXfbf5bwyvx5JTGfx0jp/yHQL?=
 =?us-ascii?q?J+cdDWyUkqDw7Lk0mQppL9PzOVyOsNtXWQ4fdlVe21j24nrx9+oziyzcorkY?=
 =?us-ascii?q?nGm5kVx0vY9SR53Ik1Jdq4RFR9Yd6/CpRcrS6aN4xoQs47RWxjpSU0yqUetJ?=
 =?us-ascii?q?KmcyUHx44ryh7CZ/CdbYSF7QzvWPyMLTp+mXlrYqiwhwyo/kil0uD8U86030?=
 =?us-ascii?q?tUoSddidnMs2wN1wTU6siaVvtx5keh1iiL1wDU8uxEPVo7lbDaK5482b48jI?=
 =?us-ascii?q?YTsETfES/2n0X6lqmWeVk/+ue08ejnZ7TmppuEO491jAHxLLgul9SiDek3PQ?=
 =?us-ascii?q?UCRWiW9fmm2LH98kD1Xq9GguAunqncqp/aJMAbpqCjAw9S14Yu8w2/ACq90N?=
 =?us-ascii?q?kDgXkGLE5KeBKAj4TzPVHOO+r3Ae2wg1Srjjdn3+rGMaH5ApXRMnjDl6/sfL?=
 =?us-ascii?q?h8605YzAo+1tNf6IxOCrEHPv3zXlX9tNvCDh82Kwa02froCM1h1oMCXmKCGr?=
 =?us-ascii?q?SZP73WsV+J4OIvPuaNaZQLuDbyNfcl/eTijXwnll8He6mmw58XZGq/HvR8LE?=
 =?us-ascii?q?WTeWDsjcsZEWcWogo+S/TniFmDUT5VenazULsw5jIlB4K8C4fMWIStjaef3C?=
 =?us-ascii?q?e0AJJWfHpKClOSHnfycYWLRfMMZDiVIs97nTxXHYSmHrAg0RXmmALzwL1hZr?=
 =?us-ascii?q?7L+ykcnZHuzt5446vUjx5ksXRvAsCc1XydZ397k3lORDIs2q1750tnxQSty6?=
 =?us-ascii?q?991sdEGMRT6vUBaQIzMZrR3qQuENzpch7QddeODlC9S5OpBi9nHYF5+MMHf0?=
 =?us-ascii?q?soQ4bqtRvExSf/RuZOxrE=3D?=
X-IPAS-Result: =?us-ascii?q?A2BOAAB5N9Rd/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF+gXQsgUAzKoQqj1oBAQEBAQEGgREliWaKH4ckCQEBAQEBAQEBA?=
 =?us-ascii?q?TQBAgEBhEACgiUkOBMCEAEBAQQBAQEBAQUDAQFshUOCOykBgmwBAQEBAgEjB?=
 =?us-ascii?q?BFBEAsYAgImAgJXBgEMBgIBAYJfP4JTBSCwUnV/M4VOgy2BSIEOKIgig3MYe?=
 =?us-ascii?q?IEHgTgMgio1PodVgl4EjQ+JTEZ0lhSCNYI3kxIGG4I+h2iEOosxLY4bnBkig?=
 =?us-ascii?q?VgrCAIYCCEPgydQERSRJhcVjiwjAzCBBQEBjjIBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 19 Nov 2019 18:46:37 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xAJIkbj2004921;
        Tue, 19 Nov 2019 13:46:37 -0500
Subject: Re: [RFC PATCH 2/2] selinux: Propagate RCU walk status from
 'security_inode_follow_link()'
To:     Will Deacon <will@kernel.org>, selinux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20191119184057.14961-1-will@kernel.org>
 <20191119184057.14961-3-will@kernel.org>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d1b03e3f-2906-d022-3578-e443a5ebb1a0@tycho.nsa.gov>
Date:   Tue, 19 Nov 2019 13:46:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191119184057.14961-3-will@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/19/19 1:40 PM, Will Deacon wrote:
> 'selinux_inode_follow_link()' can be called as part of an RCU path walk,
> and is passed a 'bool rcu' parameter to indicate whether or not it is
> being called from within an RCU read-side critical section.
> 
> Unfortunately, this knowledge is not propagated further and, instead,
> 'avc_has_perm()' unconditionally passes a flags argument of '0' to both
> 'avc_has_perm_noaudit()' and 'avc_audit()' which may block.
> 
> Introduce 'avc_has_perm_flags()' which can be used safely from within an
> RCU read-side critical section.

Please see e46e01eebbbcf2ff6d28ee7cae9f117e9d1572c8 ("selinux: stop 
passing MAY_NOT_BLOCK to the AVC upon follow_link").

> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>   security/selinux/avc.c         | 12 +++++++-----
>   security/selinux/hooks.c       |  5 +++--
>   security/selinux/include/avc.h | 12 ++++++++----
>   3 files changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 9c183c899e92..7d99dadd24d0 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -1177,11 +1177,12 @@ inline int avc_has_perm_noaudit(struct selinux_state *state,
>   }
>   
>   /**
> - * avc_has_perm - Check permissions and perform any appropriate auditing.
> + * avc_has_perm_flags - Check permissions and perform any appropriate auditing.
>    * @ssid: source security identifier
>    * @tsid: target security identifier
>    * @tclass: target security class
>    * @requested: requested permissions, interpreted based on @tclass
> + * @flags: AVC_STRICT, AVC_NONBLOCKING, or 0
>    * @auditdata: auxiliary audit data
>    *
>    * Check the AVC to determine whether the @requested permissions are granted
> @@ -1192,17 +1193,18 @@ inline int avc_has_perm_noaudit(struct selinux_state *state,
>    * permissions are granted, -%EACCES if any permissions are denied, or
>    * another -errno upon other errors.
>    */
> -int avc_has_perm(struct selinux_state *state, u32 ssid, u32 tsid, u16 tclass,
> -		 u32 requested, struct common_audit_data *auditdata)
> +int avc_has_perm_flags(struct selinux_state *state, u32 ssid, u32 tsid,
> +		       u16 tclass, u32 requested, unsigned int flags,
> +		       struct common_audit_data *auditdata)
>   {
>   	struct av_decision avd;
>   	int rc, rc2;
>   
> -	rc = avc_has_perm_noaudit(state, ssid, tsid, tclass, requested, 0,
> +	rc = avc_has_perm_noaudit(state, ssid, tsid, tclass, requested, flags,
>   				  &avd);
>   
>   	rc2 = avc_audit(state, ssid, tsid, tclass, requested, &avd, rc,
> -			auditdata, 0);
> +			auditdata, flags);
>   	if (rc2)
>   		return rc2;
>   	return rc;
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 9625b99e677f..0c09f59a2740 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3008,8 +3008,9 @@ static int selinux_inode_follow_link(struct dentry *dentry, struct inode *inode,
>   	if (IS_ERR(isec))
>   		return PTR_ERR(isec);
>   
> -	return avc_has_perm(&selinux_state,
> -			    sid, isec->sid, isec->sclass, FILE__READ, &ad);
> +	return avc_has_perm_flags(&selinux_state, sid, isec->sid, isec->sclass,
> +				  rcu ? AVC_NONBLOCKING : 0,
> +				  FILE__READ, &ad);
>   }
>   
>   static noinline int audit_inode_permission(struct inode *inode,
> diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
> index 7be0e1e90e8b..0450e1b88182 100644
> --- a/security/selinux/include/avc.h
> +++ b/security/selinux/include/avc.h
> @@ -149,10 +149,14 @@ int avc_has_perm_noaudit(struct selinux_state *state,
>   			 unsigned flags,
>   			 struct av_decision *avd);
>   
> -int avc_has_perm(struct selinux_state *state,
> -		 u32 ssid, u32 tsid,
> -		 u16 tclass, u32 requested,
> -		 struct common_audit_data *auditdata);
> +int avc_has_perm_flags(struct selinux_state *state,
> +		       u32 ssid, u32 tsid,
> +		       u16 tclass, u32 requested,
> +		       unsigned flags,
> +		       struct common_audit_data *auditdata);
> +
> +#define avc_has_perm(state, ssid, tsid, tclass, requested, auditdata) \
> +	avc_has_perm_flags(state, ssid, tsid, tclass, requested, 0, auditdata)
>   
>   int avc_has_extended_perms(struct selinux_state *state,
>   			   u32 ssid, u32 tsid, u16 tclass, u32 requested,
> 

