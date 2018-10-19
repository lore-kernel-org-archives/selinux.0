Return-Path: <SRS0=dFHA=M7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AE5ECDE3D
	for <selinux@archiver.kernel.org>; Fri, 19 Oct 2018 14:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC9A2145D
	for <selinux@archiver.kernel.org>; Fri, 19 Oct 2018 14:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC9A2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbeJSWdJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Oct 2018 18:33:09 -0400
Received: from upbd19pa09.eemsg.mail.mil ([214.24.27.84]:62585 "EHLO
        UPBD19PA09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbeJSWdI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Oct 2018 18:33:08 -0400
X-EEMSG-check-008: 145815942|UPBD19PA09_EEMSG_MP9.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPBD19PA09.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 19 Oct 2018 14:26:39 +0000
X-IronPort-AV: E=Sophos;i="5.54,400,1534809600"; 
   d="scan'208";a="19636662"
IronPort-PHdr: =?us-ascii?q?9a23=3As8CgVR+Obh5QSv9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+0ekVIJqq85mqBkHD//Il1AaPAd2Eraocw8Pt8InYEVQa5piAtH1QOLdtbD?=
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
 =?us-ascii?q?KZbGL0gtgbDGcKuhEzTPTwh12fVT5ffnOyX6U75jEhFo2qF5vMRoeogLaZxi?=
 =?us-ascii?q?e0AoVWZnxaClCLCXrnap+LW/ENaC2MJs9hkCcJVb2/RI8l0RGhrgn6y71oL+?=
 =?us-ascii?q?bO5iIYspfj3sBv5+LPjREy6SB0D8OF3m6TS2F0n3gFRzoo06B7pUxy0FGD0a?=
 =?us-ascii?q?93gvBCCdNT4PZJWB8gNZHA1+x6F8zyWgXZc9eLTVamRc+mASswTtIq2NIOZV?=
 =?us-ascii?q?xyG9C8gRDCxSaqBKUVl7OTDpwu7q3cx2TxJ9p6y3veyaYhi0cpTdZBNW2hnK?=
 =?us-ascii?q?5w6hPeB5TXnEqEl6alb7gc0DTR+2eEyGqEpFtYXxJoUaXZQXAfYVPbrc/l5k?=
 =?us-ascii?q?zYVLCuDaooPxBfyc6NNKRKcMfljVZYS/f5PtTRfWaxl323BRaSybPfJLbtLk?=
 =?us-ascii?q?Ib0D/QCgAhlBsV9H2LNkBqASKmuGTXBzFGD1/jY0rwt+J5rSX/BlQ5ywCMcl?=
 =?us-ascii?q?1JybW44FgWiOaaRvdV2agL/G8ZoihwVHO62MjbQ46YrhdlVL1VfNd45VBAz2?=
 =?us-ascii?q?+fvAt4aM+ONadn02UCfhx3skWm7BB+DoFNgIB+t38x5BZjIqKfllVafnWX2o?=
 =?us-ascii?q?6mae6fEXX74B36M/2e4VrZytvDv/5VsPk=3D?=
X-IPAS-Result: =?us-ascii?q?A2CMAQBF6Mlb/wHyM5BkGwEBAQEDAQEBBwMBAQGBZYFbK?=
 =?us-ascii?q?oFlKIN1lDNMAQEBAQEBBoE1iQaQAzgBhEAChQYhOBYBAwEBAQEBAQIBbCiCN?=
 =?us-ascii?q?iQBgl8BBSMEEQ8yEAsOCgICJgICVwYBDAYCAQGCXj+BdQ2md3szgyqCEYRdg?=
 =?us-ascii?q?QuKRBd5gQeBESeCa4gBglcCiG2GGo86CYl6hmwGF4FPjlqCYoFBhQCPCSGBV?=
 =?us-ascii?q?SsIAhgIIQ+DJ5BzIzCBBQEBij4BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 19 Oct 2018 14:26:36 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w9JEQYjA014075;
        Fri, 19 Oct 2018 10:26:34 -0400
Subject: Re: [PATCH v4] selinux: policydb - fix byte order and alignment
 issues
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Cc:     selinux@tycho.nsa.gov, Daniel Jurgens <danielj@mellanox.com>,
        Eli Cohen <eli@mellanox.com>, James Morris <jmorris@namei.org>,
        Doug Ledford <dledford@redhat.com>, stable@vger.kernel.org
References: <20181018074704.23835-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <45457a65-93f0-b93b-876b-6e9216a8754b@tycho.nsa.gov>
Date:   Fri, 19 Oct 2018 10:28:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181018074704.23835-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/18/2018 03:47 AM, Ondrej Mosnacek wrote:
> Do the LE conversions before doing the Infiniband-related range checks.
> The incorrect checks are otherwise causing a failure to load any policy
> with an ibendportcon rule on BE systems. This can be reproduced by
> running (on e.g. ppc64):
> 
> cat >my_module.cil <<EOF
> (type test_ibendport_t)
> (roletype object_r test_ibendport_t)
> (ibendportcon mlx4_0 1 (system_u object_r test_ibendport_t ((s0) (s0))))
> EOF
> semodule -i my_module.cil
> 
> Also, fix loading/storing the 64-bit subnet prefix for OCON_IBPKEY to
> use a correctly aligned buffer.
> 
> Finally, do not use the 'nodebuf' (u32) buffer where 'buf' (__le32)
> should be used instead.
> 
> Tested internally on a ppc64 machine with a RHEL 7 kernel with this
> patch applied.
> 
> Cc: Daniel Jurgens <danielj@mellanox.com>
> Cc: Eli Cohen <eli@mellanox.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: <stable@vger.kernel.org> # 4.13+
> Fixes: a806f7a1616f ("selinux: Create policydb version for Infiniband support")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>   security/selinux/ss/policydb.c | 46 +++++++++++++++++++++++-----------
>   1 file changed, 32 insertions(+), 14 deletions(-)
> 
> Changes in v4:
>   - defer assignment to 16-bit struct fields to after the range check
> 
> Changes in v3:
>   - use separate buffer for the 64-bit subnet_prefix
>   - add comments on the byte ordering of subnet_prefix
>   - deduplicate the le32_to_cpu() calls from checks
> 
> Changes in v2:
>   - add reproducer to commit message
>   - update e-mail address of James Morris
>   - better Cc also the old SELinux ML
> 
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index f4eadd3f7350..d50668006a52 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -2108,6 +2108,7 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
>   {
>   	int i, j, rc;
>   	u32 nel, len;
> +	__be64 prefixbuf[1];
>   	__le32 buf[3];
>   	struct ocontext *l, *c;
>   	u32 nodebuf[8];
> @@ -2217,21 +2218,30 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
>   					goto out;
>   				break;
>   			}
> -			case OCON_IBPKEY:
> -				rc = next_entry(nodebuf, fp, sizeof(u32) * 4);
> +			case OCON_IBPKEY: {
> +				u32 pkey_lo, pkey_hi;
> +
> +				rc = next_entry(prefixbuf, fp, sizeof(u64));
> +				if (rc)
> +					goto out;
> +
> +				/* we need to have subnet_prefix in CPU order */
> +				c->u.ibpkey.subnet_prefix = be64_to_cpu(prefixbuf[0]);
> +
> +				rc = next_entry(buf, fp, sizeof(u32) * 2);
>   				if (rc)
>   					goto out;
>   
> -				c->u.ibpkey.subnet_prefix = be64_to_cpu(*((__be64 *)nodebuf));
> +				pkey_lo = le32_to_cpu(buf[0]);
> +				pkey_hi = le32_to_cpu(buf[1]);
>   
> -				if (nodebuf[2] > 0xffff ||
> -				    nodebuf[3] > 0xffff) {
> +				if (pkey_lo > U16_MAX || pkey_hi > U16_MAX) {
>   					rc = -EINVAL;
>   					goto out;
>   				}
>   
> -				c->u.ibpkey.low_pkey = le32_to_cpu(nodebuf[2]);
> -				c->u.ibpkey.high_pkey = le32_to_cpu(nodebuf[3]);
> +				c->u.ibpkey.low_pkey  = pkey_lo;
> +				c->u.ibpkey.high_pkey = pkey_hi;
>   
>   				rc = context_read_and_validate(&c->context[0],
>   							       p,
> @@ -2239,6 +2249,7 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
>   				if (rc)
>   					goto out;
>   				break;
> +			}
>   			case OCON_IBENDPORT:
>   				rc = next_entry(buf, fp, sizeof(u32) * 2);
>   				if (rc)
> @@ -2249,13 +2260,14 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
>   				if (rc)
>   					goto out;
>   
> -				if (buf[1] > 0xff || buf[1] == 0) {
> +				c->u.ibendport.port = le32_to_cpu(buf[1]);

ibendport.port is a u8 here, same issue.

> +
> +				if (c->u.ibendport.port > 0xff ||
> +				    c->u.ibendport.port == 0) {
>   					rc = -EINVAL;
>   					goto out;
>   				}
>   
> -				c->u.ibendport.port = le32_to_cpu(buf[1]);
> -
>   				rc = context_read_and_validate(&c->context[0],
>   							       p,
>   							       fp);
> @@ -3105,6 +3117,7 @@ static int ocontext_write(struct policydb *p, struct policydb_compat_info *info,
>   {
>   	unsigned int i, j, rc;
>   	size_t nel, len;
> +	__be64 prefixbuf[1];
>   	__le32 buf[3];
>   	u32 nodebuf[8];
>   	struct ocontext *c;
> @@ -3192,12 +3205,17 @@ static int ocontext_write(struct policydb *p, struct policydb_compat_info *info,
>   					return rc;
>   				break;
>   			case OCON_IBPKEY:
> -				*((__be64 *)nodebuf) = cpu_to_be64(c->u.ibpkey.subnet_prefix);
> +				/* subnet_prefix is in CPU order */
> +				prefixbuf[0] = cpu_to_be64(c->u.ibpkey.subnet_prefix);
>   
> -				nodebuf[2] = cpu_to_le32(c->u.ibpkey.low_pkey);
> -				nodebuf[3] = cpu_to_le32(c->u.ibpkey.high_pkey);
> +				rc = put_entry(prefixbuf, sizeof(u64), 1, fp);
> +				if (rc)
> +					return rc;
>   
> -				rc = put_entry(nodebuf, sizeof(u32), 4, fp);
> +				buf[0] = cpu_to_le32(c->u.ibpkey.low_pkey);
> +				buf[1] = cpu_to_le32(c->u.ibpkey.high_pkey);
> +
> +				rc = put_entry(buf, sizeof(u32), 2, fp);
>   				if (rc)
>   					return rc;
>   				rc = context_write(p, &c->context[0], fp);
> 

