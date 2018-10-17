Return-Path: <SRS0=vIUq=M5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EBFECDE32
	for <selinux@archiver.kernel.org>; Wed, 17 Oct 2018 15:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C609621528
	for <selinux@archiver.kernel.org>; Wed, 17 Oct 2018 15:39:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C609621528
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbeJQXgC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:36:02 -0400
Received: from ucol19pa09.eemsg.mail.mil ([214.24.24.82]:8544 "EHLO
        ucol19pa09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbeJQXgC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Oct 2018 19:36:02 -0400
X-Greylist: delayed 575 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Oct 2018 19:36:01 EDT
X-EEMSG-check-008: 781454449|UCOL19PA09_EEMSG_MP7.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.54,392,1534809600"; 
   d="scan'208";a="781454449"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by ucol19pa09.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Oct 2018 15:30:13 +0000
X-IronPort-AV: E=Sophos;i="5.54,392,1534809600"; 
   d="scan'208";a="19529008"
IronPort-PHdr: =?us-ascii?q?9a23=3A7ddgFxxJw1ObKcbXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2ukVIJqq85mqBkHD//Il1AaPAd2Eraocw8Pt8InYEVQa5piAtH1QOLdtbD?=
 =?us-ascii?q?Qizfssogo7HcSeAlf6JvO5JwYzHcBFSUM3tyrjaRsdF8nxfUDdrWOv5jAOBB?=
 =?us-ascii?q?r/KRB1JuPoEYLOksi7ze+/94HRbglSmDaxfa55IQmrownWqsQYm5ZpJLwryh?=
 =?us-ascii?q?vOrHtIeuBWyn1tKFmOgRvy5dq+8YB6/ShItP0v68BPUaPhf6QlVrNYFygpM3?=
 =?us-ascii?q?o05MLwqxbOSxaE62YGXWUXlhpIBBXF7A3/U5zsvCb2qvZx1S+HNsDtU7s6RS?=
 =?us-ascii?q?qt4LtqSB/wiScIKTg58H3MisdtiK5XuQ+tqwBjz4LRZoyaOuB+fqfAdt0EQ2?=
 =?us-ascii?q?RPUNtaWyhYDo+ic4cDCuwMNvtaoYbgvVsDtQawCxeiBO3vyTFGiHH50qI43O?=
 =?us-ascii?q?s9Hg/LxxAgEtAUvXjIsNn4OqUfXOaox6fI1zXDaPZW1C/g5ojUbB8hufGMUq?=
 =?us-ascii?q?x2ccHM1EcvEhnKjlGUqYP7PzKey+MAs3OG4Op7Tu+vl24mpB1xojio3MssjJ?=
 =?us-ascii?q?LJiZgPxlDL8iV53p84KNulQ0B4ed6pCIZcui6VOodsQs4uXntktDg1x7EYo5?=
 =?us-ascii?q?K3YS4Hw4k9yRHFcfyIaY2I7wrmVOaWPDh3mmpoeKm6hxau6UigzfD8VtWs3F?=
 =?us-ascii?q?ZKsCVFlt7Mu2gR1xPJ8MiHS+Z9/ly71TaT1wHc9uFEIUcumardN5Eh2aI/mo?=
 =?us-ascii?q?AWsUTCGi/6gET2jKmIeUU44uWk9uvqb7r8qpKcKoN4kB/yP6swlsClHOg0Kg?=
 =?us-ascii?q?0OUHKa+eS42r3j50r5QLBSg/0tj6bZq4vXJdgbp6GlAw9V1Zwv6xCkDzi8yt?=
 =?us-ascii?q?gYkn4HLExddBKdk4fpI03OIOz/DfqnhFSslTBrx+vAPrL7HprCMGPOkK3/cr?=
 =?us-ascii?q?lg605T0hYzwcpD6JJTD7ELOOjzVVPptNzEEh85NBS5w/35B9V514MeX3+PA6?=
 =?us-ascii?q?CCPaPMvl+H+PgvL/OPZIALojb9LeYq5/r0gX8+g18dcrGj3YELZ3CgAvRmP0?=
 =?us-ascii?q?KZbGLxjdgbF2cKvxQxTOjoiFCZVD5ceXKyX6Ym6TE9D4KnAp3PSZyqgLyEj2?=
 =?us-ascii?q?+HGchxYGxcB1LENHDzcYyPVvREPCWXJdRnmzcJfaKsR48oyVelswqsj/J8I+?=
 =?us-ascii?q?7V/DAInYzs2cIz5ODJkxw2sztuAJezyWaIGlpok3sISjl+56V2pUhw2x/Xyq?=
 =?us-ascii?q?Rjq+BJHtxUofVSW0E1MoCKnL8yMMz7Rg+UJoTBc12hWNjzRGhrFt8=3D?=
X-IPAS-Result: =?us-ascii?q?A2AbAQA5VMdb/wHyM5BjGwEBAQEDAQEBBwMBAQGBZYFbK?=
 =?us-ascii?q?oFlKIN1lDFMAQEBAQEBBoEQJYkEkAI4AYRAAoR6ITgWAQMBAQEBAQECAWwog?=
 =?us-ascii?q?jYkAYJfAQUjBBFBEAsOCgICJgICVwYBDAYCAQGCXT+BdQ2kcXszhTqEXoELi?=
 =?us-ascii?q?kEXeYEHgTkMgl+IAYJXAo5/jzIJiXGGbAYXkCKYFSGBVSsIAhgIIQ+DJ5ByI?=
 =?us-ascii?q?zCBBQEBiwMBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 17 Oct 2018 15:30:12 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w9HFUCEE000877;
        Wed, 17 Oct 2018 11:30:12 -0400
Subject: Re: [PATCH] libsepol: fix endianity in ibpkey range checks
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Cc:     selinux@tycho.nsa.gov, Daniel Jurgens <danielj@mellanox.com>
References: <20181017144659.10960-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <61a96080-4427-bb24-9cdd-ef52a181f665@tycho.nsa.gov>
Date:   Wed, 17 Oct 2018 11:31:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181017144659.10960-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/17/2018 10:46 AM, Ondrej Mosnacek wrote:
> We need to convert from little-endian before dong range checks on the
> ibpkey port numbers, otherwise we would be checking a wrong value.
> 
> Fixes: 9fbb3112769a ("libsepol: Add ibpkey ocontext handling")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   libsepol/src/policydb.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index a6d76ca3..dc201e2f 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -2830,15 +2830,21 @@ static int ocontext_read_selinux(struct policydb_compat_info *info,
>   				break;
>   			case OCON_IBPKEY:
>   				rc = next_entry(buf, fp, sizeof(uint32_t) * 4);
> -				if (rc < 0 || buf[2] > 0xffff || buf[3] > 0xffff)
> +				if (rc < 0)
>   					return -1;
>   
> +				c->u.ibpkey.low_pkey  = le32_to_cpu(buf[2]);
> +				c->u.ibpkey.high_pkey = le32_to_cpu(buf[3]);
> +
> +				if (c->u.ibpkey.low_pkey  > 0xffff ||
> +				    c->u.ibpkey.high_pkey > 0xffff)
> +					return -1;
> +
> +				/* we want c->u.ibpkey.subnet_prefix in network
> +				 * (big-endian) order, just memcpy it */
>   				memcpy(&c->u.ibpkey.subnet_prefix, buf,
>   				       sizeof(c->u.ibpkey.subnet_prefix)); >
> -				c->u.ibpkey.low_pkey = le32_to_cpu(buf[2]);
> -				c->u.ibpkey.high_pkey = le32_to_cpu(buf[3]);
> -
>   				if (context_read_and_validate
>   				    (&c->context[0], p, fp))
>   					return -1;
> 

