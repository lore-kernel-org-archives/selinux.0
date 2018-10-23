Return-Path: <SRS0=23Lp=ND=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40339C46475
	for <selinux@archiver.kernel.org>; Tue, 23 Oct 2018 14:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF7CC20665
	for <selinux@archiver.kernel.org>; Tue, 23 Oct 2018 14:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF7CC20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbeJWWc4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Oct 2018 18:32:56 -0400
Received: from uhil19pa10.eemsg.mail.mil ([214.24.21.83]:24837 "EHLO
        uhil19pa10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeJWWc4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Oct 2018 18:32:56 -0400
X-Greylist: delayed 585 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Oct 2018 18:32:56 EDT
X-EEMSG-check-008: 349233076|UHIL19PA10_EEMSG_MP8.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by uhil19pa10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 23 Oct 2018 13:59:35 +0000
X-IronPort-AV: E=Sophos;i="5.54,416,1534809600"; 
   d="scan'208";a="19761400"
IronPort-PHdr: =?us-ascii?q?9a23=3AfCDDExC2zc3UMQtjkdK0UyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP35pM+wAkXT6L1XgUPTWs2DsrQY07WQ6/iocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmDiwbaluIBmqsA7cqtQYjYx+J6gr1x?=
 =?us-ascii?q?DHuGFIe+NYxWNpIVKcgRPx7dqu8ZBg7ipdpesv+9ZPXqvmcas4S6dYDCk9PG?=
 =?us-ascii?q?Au+MLrrxjDQhCR6XYaT24bjwBHAwnB7BH9Q5fxri73vfdz1SWGIcH7S60/VC?=
 =?us-ascii?q?+85Kl3VhDnlCYHNyY48G7JjMxwkLlbqw+lqxBm3oLYfJ2ZOP94c6zTZ9MaQX?=
 =?us-ascii?q?dKUNhXWSJPH4iwa5IDA/QdMepdqYT2ulkAogakBQS0Ge3h1DFIiH/106M03e?=
 =?us-ascii?q?suHgPJ0xAvEd8VrHTZrs/4OLsOXe27zqTFyyjIYfNM2Tf67YjFag0voe2SUr?=
 =?us-ascii?q?Joccre108vHB7YgFWVs4PlOzeV2foNsmOG6OdgTv+gi3U8pgFtojmg2scsio?=
 =?us-ascii?q?7TioIT0VDL7z91wIkyJd2mUUN2Z8OvHphItyyCKod7TcwvT3totSon0LEKp5?=
 =?us-ascii?q?G2cDYQxJg6wRPUduaJfJKS4h35UeacOTJ4hHV4d72hnxuy6k2gyvHkVsmzzV?=
 =?us-ascii?q?ZKsjJJktnSuXAJ0Bze8tSHReFn/kegxDaPzBrf6v1EIE8olarbLIQtwrgsmZ?=
 =?us-ascii?q?oIrUvPBCr2mETyjKOOd0Uk/Pan6/j/b7n7qZKROJV4hwHjPqg0hMCyDvo0Ph?=
 =?us-ascii?q?ITU2SD/OSzzrzj/Un3QLVQif02l7HUsIvHKsQAvaO5Hw9U3Zoj6xa4FTum1s?=
 =?us-ascii?q?8YkmMdIFJKfxKHkZDlO0vSL/DgEfe/n1OsnS9sx/DDOb3hGZPNIWLfn7j/Zr?=
 =?us-ascii?q?t98VBTxxczzd9F+5JYEK0OIPX2WkXprtzXEgc5MxCow+bgENh9zZ0RWWaOAq?=
 =?us-ascii?q?+fLaPTvkSF5vwgI+aSfo8ZojX9JOY/5/7ok3A5nUURfa6z3ZsYcHq4BOhpI1?=
 =?us-ascii?q?2FYXrwhdcMCX8KsRAjTOzuk1CCSSRcZ2u2X64l4zE7D4WmDZ3dSYy3nLOB2y?=
 =?us-ascii?q?K7FIVMZm9aElCMDWvod4KcVvgRci2SJM5hnSIAVbijUIIh0A+htAv+y7V9KO?=
 =?us-ascii?q?rU/SIZuYj/29hy4u3ZjQsy+iBsD8SBz2GNSHl5kX0MRz83x61/pFJyylOH0a?=
 =?us-ascii?q?dihfxYEtNS6+lVXQc9MJ7W1/Z6BMzqWgLdYteJT06rQtejATE2VNIx2d4OY1?=
 =?us-ascii?q?1mFtWklB/D2jSlA74Pm7yMHpw0/brW32LtKMZl13bGyK4hgkE7TctLK2Kpm6?=
 =?us-ascii?q?B/9w/JB4HUiEiZjbilerkc3CHX6GeP13aBvEZdUARoS6XKQWgfZlfKrdT+/k?=
 =?us-ascii?q?7CVKOuBq48PQtF18GPMbVKatL3glVcXvvjO8rRY3i3m2iuARaE3LSMbJDlez?=
 =?us-ascii?q?ZV4CKIL04IiQ0RtVOBLg43DSqi6zbZCTt1E1vkbmv2/OV+oW/9RUgxmUXCdE?=
 =?us-ascii?q?Bl1ryo6jYLivGGDfAexLQJvGEmsTowVG60wtaeLt2HvQcpKL1VfNcV+F5a0S?=
 =?us-ascii?q?fcsAtnM9qrKKU01XAEdAEihF/jzxV6DM17lMEuqH47hF5pJbmwzEJKdzTe24?=
 =?us-ascii?q?v5fLLQND+hr1iUd6fK1wSGg56t8aAV5aF98g+7sQ=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AYAACzKM9b/wHyM5BjGgEBAQEBAgEBAQEHAgEBAQGBV?=
 =?us-ascii?q?AIBAQEBCwGBWiqBZSiDdZQ1UgaBNYkIkAc4AYRAAoUqITcKDQEDAQEBAQEBA?=
 =?us-ascii?q?gFsKII2JAGCYAEFIwQRDzIQCw4KAgImAgJXBgEMBgIBAYJeP4F1DaYwezODK?=
 =?us-ascii?q?oIRhGeBC4pXF3mBB4ERJ4JrhFiDKYJXAohvhh+PQgmKAIZuBheBUo5egmOBQ?=
 =?us-ascii?q?YUFjxsigVUrCAIYCCEPgyeQcyMwgQUBAYlagkwBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 23 Oct 2018 13:59:34 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w9NDxYa2031297;
        Tue, 23 Oct 2018 09:59:34 -0400
Subject: Re: [PATCH v6] selinux: policydb - fix byte order and alignment
 issues
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Cc:     selinux@tycho.nsa.gov, Daniel Jurgens <danielj@mellanox.com>,
        Eli Cohen <eli@mellanox.com>, James Morris <jmorris@namei.org>,
        Doug Ledford <dledford@redhat.com>, stable@vger.kernel.org
References: <20181023070217.17015-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <556106c9-b3e7-921a-8a0b-2bcc51d164fb@tycho.nsa.gov>
Date:   Tue, 23 Oct 2018 10:01:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181023070217.17015-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/23/2018 03:02 AM, Ondrej Mosnacek wrote:
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
>   security/selinux/ss/policydb.c | 51 ++++++++++++++++++++++++----------
>   1 file changed, 36 insertions(+), 15 deletions(-)
> 
> Changes in v6:
>   - use U8_MAX as the limit for ibendport.port value to emphasize that it
>     is an 8-bit value
> 
> Changes in v5:
>   - defer also assignment to 8-bit ibendport.port
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
> index f4eadd3f7350..b63ef865ce1e 100644
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
> @@ -2239,7 +2249,10 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
>   				if (rc)
>   					goto out;
>   				break;
> -			case OCON_IBENDPORT:
> +			}
> +			case OCON_IBENDPORT: {
> +				u32 port;
> +
>   				rc = next_entry(buf, fp, sizeof(u32) * 2);
>   				if (rc)
>   					goto out;
> @@ -2249,12 +2262,13 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
>   				if (rc)
>   					goto out;
>   
> -				if (buf[1] > 0xff || buf[1] == 0) {
> +				port = le32_to_cpu(buf[1]);
> +				if (port > U8_MAX || port == 0) {
>   					rc = -EINVAL;
>   					goto out;
>   				}
>   
> -				c->u.ibendport.port = le32_to_cpu(buf[1]);
> +				c->u.ibendport.port = port;
>   
>   				rc = context_read_and_validate(&c->context[0],
>   							       p,
> @@ -2262,7 +2276,8 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
>   				if (rc)
>   					goto out;
>   				break;
> -			}
> +			} /* end case */
> +			} /* end switch */
>   		}
>   	}
>   	rc = 0;
> @@ -3105,6 +3120,7 @@ static int ocontext_write(struct policydb *p, struct policydb_compat_info *info,
>   {
>   	unsigned int i, j, rc;
>   	size_t nel, len;
> +	__be64 prefixbuf[1];
>   	__le32 buf[3];
>   	u32 nodebuf[8];
>   	struct ocontext *c;
> @@ -3192,12 +3208,17 @@ static int ocontext_write(struct policydb *p, struct policydb_compat_info *info,
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

