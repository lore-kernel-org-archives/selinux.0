Return-Path: <SRS0=vIUq=M5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579F7ECDE30
	for <selinux@archiver.kernel.org>; Wed, 17 Oct 2018 15:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F5521476
	for <selinux@archiver.kernel.org>; Wed, 17 Oct 2018 15:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05F5521476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeJQXVq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:21:46 -0400
Received: from uphb19pa10.eemsg.mail.mil ([214.24.26.84]:55668 "EHLO
        USFB19PA13.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727048AbeJQXVp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Oct 2018 19:21:45 -0400
X-EEMSG-check-008: 204536969|USFB19PA13_EEMSG_MP9.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Oct 2018 15:25:31 +0000
X-IronPort-AV: E=Sophos;i="5.54,392,1534809600"; 
   d="scan'208";a="19528590"
IronPort-PHdr: =?us-ascii?q?9a23=3A9V884xWESBRev/xkDftavV6neW/V8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZRaEvqdThVPEFb/W9+hDw7KP9fy4BipYud6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9uLhi6txndutULioZ+N6g9zQ?=
 =?us-ascii?q?fErGFVcOpM32NoIlyTnxf45siu+ZNo7jpdtfE8+cNeSKv2Z6s3Q6BWAzQgKG?=
 =?us-ascii?q?A1+dbktQLfQguV53sTSXsZnxxVCAXY9h76X5Pxsizntuph3SSRIMP7QawoVT?=
 =?us-ascii?q?mk8qxmUwHjhjsZODEl8WHXks1wg7xdoBK9vBx03orYbJiIOPZiYq/ReNUXSm?=
 =?us-ascii?q?RbXsZVSidPHIWyYYUSBOYFJOpUsZXxq14IoBCjBwejGfnvxydViHHo06000+?=
 =?us-ascii?q?cvHw/I0wMvHd0BrHvaoc7pNKoQS+250LXEwDvBYv5QxDzz6JLIchckofyUQL?=
 =?us-ascii?q?xwbdTeyVEvFwzbiFWbtJHrPzaP2eQJt2iU8ephXv+ohm48tg5xuSOixtssi4?=
 =?us-ascii?q?bVhoIVzUrI9SNiwIkvP9G4R0l7YcC9HZZWqiqUNJN2T9s/T2xntys20L0LtY?=
 =?us-ascii?q?OhcCQUx5kr2QTTZ+GBfoOV+BzsTvyRLi19hH99fbK/gAu9/la4x+3nU8m0zE?=
 =?us-ascii?q?5Kri1YktnQrnwN1wLc6syASvZl4keuwyyP1wHO6uFfO0w0iaraJIIhwr43jJ?=
 =?us-ascii?q?YTt1jMHjTql0nsia+Wd0Ek9vCp6+ThfLrmuoeRO5J7hwzxKKgjmtGzDf4mPg?=
 =?us-ascii?q?UBQWSX4/mw2KXm/ULjQbVKivM2krPesJDfPckbvbO2AxRO34Y/6xewEzem0N?=
 =?us-ascii?q?MCkXkBN1JKYgiLj4fuO1HQOPz4F+uwg0ywkDd3wPDLJrrhApDKLnjYlrfuZ6?=
 =?us-ascii?q?py5FBHxQop099Q+pJUBasdIP7pRkDxs9nYBAcjMwOo2+bnFMl91oQGVGKUHK?=
 =?us-ascii?q?CZNKLSsVmV5uMgOOSMeoAVtyjnK/Q/5P7hk2U5mVkDcqmtx5cXb2q4Hvt+KU?=
 =?us-ascii?q?WDfXXsmssBEXsNvgcmVOzlkkCCUTpIanaqRa08+zU7BJujDYfEQYCtmqKO0D?=
 =?us-ascii?q?2nEZ1RY2BMEkqMHmvwd4WYR/cMbzqfLdJ7nTwCVLiuVYsh1RO1uQ//1bVnKu?=
 =?us-ascii?q?7U9TcetZLk29l5/fHclRY39TZsFcSSz3mNT31onmMPXzI5wqR/oU1mx1eGz6?=
 =?us-ascii?q?d4h/hYGsZV5/NOXQY2L4LTz+t/C9rqQALOYs+JSEq6QtWhGTwxTNcxw9gUY0?=
 =?us-ascii?q?ZnGtWilQvO3yywDL8QibOLBYY48qXG33j+P8x90WrJ1LE9j1k6RctCLXCphq?=
 =?us-ascii?q?ph+AfOCY7JlF+ZmLuxeKQGwiHC6WeDwnCSvE1CTAFwVqDFV2gFZkTKtdT5+l?=
 =?us-ascii?q?/CT7i2BLQ8LgtO09WNKq9UZdDyk1VGS+nsOM7Eb2KyhWiwHxCIya2IbIbwfG?=
 =?us-ascii?q?UdxirdWwA4lFU0+3qcOAp2IyC6pWvVAT8mQVXqZFjq+OJzgGm2Qk8900eBaE?=
 =?us-ascii?q?g3k/Ku9xoUg+GMY+0c06hCuyo7rThwWlGn0JaeM9Odo0JEe6JGbJtp+F5a0U?=
 =?us-ascii?q?rBvhF5e5mnKLpvwFUZdlIkkVnp0kBMFohYkcUs5EgvxQ52JLPQhEhNbBuEzJ?=
 =?us-ascii?q?vwPfvRMWC08xexPf2FkmrC2cqbr/9coM8zrE/u6UTwTBIv?=
X-IPAS-Result: =?us-ascii?q?A2AbAQAPU8db/wHyM5BjGwEBAQEDAQEBBwMBAQGBZYFbK?=
 =?us-ascii?q?oFlKIN1lDFMAQEBAQEBBoEQJYkEkAI4AYRAAoR6ITgWAQMBAQEBAQECAWwog?=
 =?us-ascii?q?jYkAYJfAQUjBBEPMhALDgoCAiYCAlcGAQwGAgEBgl0/gXUNpG97M4MqghCEX?=
 =?us-ascii?q?oELikEXeYEHgRInDIJfiAGCVwKIaIYXjzIJiXGGbAYXgU+OU4JggT6Efo55I?=
 =?us-ascii?q?YFVKwgCGAghD4MnkHIjMIEFAQGLAwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 17 Oct 2018 15:25:29 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w9HFPSil030696;
        Wed, 17 Oct 2018 11:25:28 -0400
Subject: Re: [PATCH v3] selinux: policydb - fix byte order and alignment
 issues
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Cc:     selinux@tycho.nsa.gov, Daniel Jurgens <danielj@mellanox.com>,
        Eli Cohen <eli@mellanox.com>, James Morris <jmorris@namei.org>,
        Doug Ledford <dledford@redhat.com>, stable@vger.kernel.org
References: <20181017141512.4866-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <faa49903-0850-25bc-e811-3670ab75568a@tycho.nsa.gov>
Date:   Wed, 17 Oct 2018 11:27:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181017141512.4866-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/17/2018 10:15 AM, Ondrej Mosnacek wrote:
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

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/ss/policydb.c | 41 ++++++++++++++++++++++------------
>   1 file changed, 27 insertions(+), 14 deletions(-)
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
> index f4eadd3f7350..b9029491869b 100644
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
> @@ -2218,21 +2219,26 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
>   				break;
>   			}
>   			case OCON_IBPKEY:
> -				rc = next_entry(nodebuf, fp, sizeof(u32) * 4);
> +				rc = next_entry(prefixbuf, fp, sizeof(u64));
>   				if (rc)
>   					goto out;
>   
> -				c->u.ibpkey.subnet_prefix = be64_to_cpu(*((__be64 *)nodebuf));
> +				/* we need to have subnet_prefix in CPU order */
> +				c->u.ibpkey.subnet_prefix = be64_to_cpu(prefixbuf[0]);
>   
> -				if (nodebuf[2] > 0xffff ||
> -				    nodebuf[3] > 0xffff) {
> +				rc = next_entry(buf, fp, sizeof(u32) * 2);
> +				if (rc)
> +					goto out;
> +
> +				c->u.ibpkey.low_pkey  = le32_to_cpu(buf[0]);
> +				c->u.ibpkey.high_pkey = le32_to_cpu(buf[1]);
> +
> +				if (c->u.ibpkey.low_pkey  > 0xffff ||
> +				    c->u.ibpkey.high_pkey > 0xffff) {
>   					rc = -EINVAL;
>   					goto out;
>   				}
>   
> -				c->u.ibpkey.low_pkey = le32_to_cpu(nodebuf[2]);
> -				c->u.ibpkey.high_pkey = le32_to_cpu(nodebuf[3]);
> -
>   				rc = context_read_and_validate(&c->context[0],
>   							       p,
>   							       fp);
> @@ -2249,13 +2255,14 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
>   				if (rc)
>   					goto out;
>   
> -				if (buf[1] > 0xff || buf[1] == 0) {
> +				c->u.ibendport.port = le32_to_cpu(buf[1]);
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
> @@ -3105,6 +3112,7 @@ static int ocontext_write(struct policydb *p, struct policydb_compat_info *info,
>   {
>   	unsigned int i, j, rc;
>   	size_t nel, len;
> +	__be64 prefixbuf[1];
>   	__le32 buf[3];
>   	u32 nodebuf[8];
>   	struct ocontext *c;
> @@ -3192,12 +3200,17 @@ static int ocontext_write(struct policydb *p, struct policydb_compat_info *info,
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
> +
> +				buf[0] = cpu_to_le32(c->u.ibpkey.low_pkey);
> +				buf[1] = cpu_to_le32(c->u.ibpkey.high_pkey);
>   
> -				rc = put_entry(nodebuf, sizeof(u32), 4, fp);
> +				rc = put_entry(buf, sizeof(u32), 2, fp);
>   				if (rc)
>   					return rc;
>   				rc = context_write(p, &c->context[0], fp);
> 

