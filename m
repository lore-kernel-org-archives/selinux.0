Return-Path: <SRS0=LxTM=M4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99972C04EBD
	for <selinux@archiver.kernel.org>; Tue, 16 Oct 2018 12:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47DC20881
	for <selinux@archiver.kernel.org>; Tue, 16 Oct 2018 12:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47DC20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbeJPUnm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Oct 2018 16:43:42 -0400
Received: from uphb19pa09.eemsg.mail.mil ([214.24.26.83]:28411 "EHLO
        USFB19PA12.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726778AbeJPUnl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Oct 2018 16:43:41 -0400
X-EEMSG-check-008: 223527091|USFB19PA12_EEMSG_MP8.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Oct 2018 12:53:18 +0000
X-IronPort-AV: E=Sophos;i="5.54,388,1534809600"; 
   d="scan'208";a="16858379"
IronPort-PHdr: =?us-ascii?q?9a23=3ALFpveBZN8yayyL09z3hq6YT/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZps65Zx7h7PlgxGXEQZ/co6odzbaO7Oa4ASQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTahY75+Ngm6oRnMvcQKnIVuLbo8xA?=
 =?us-ascii?q?HUqXVSYeRWwm1oJVOXnxni48q74YBu/SdNtf8/7sBMSar1cbg2QrxeFzQmLn?=
 =?us-ascii?q?s65Nb3uhnZTAuA/WUTX2MLmRdVGQfF7RX6XpDssivms+d2xSeXMdHqQb0yRD?=
 =?us-ascii?q?+v9LlgRgP2hygbNj456GDXhdJ2jKJHuxKquhhzz5fJbI2JKPZye6XQct0ARW?=
 =?us-ascii?q?pFQ81fSSpPDI2hZIcLFuYNI/pUo4z7qlATrxWxGBOsCfvyxDFWiH/43a403e?=
 =?us-ascii?q?ovHg7J3gMvA90AvW/IrNj3LqoeTfy5wafKwDjFcvhY2S396I/Nch05vP+MQa?=
 =?us-ascii?q?x/cdLRyUYxEQPOk0ieqYn/MDOR0uQCrWia5PdnWOK0lmEnsBp8oiSvx8gwio?=
 =?us-ascii?q?nJgZgZylbf9Spj2oo1Ktq4SFBibNOiDZBetDmaOpNrTs4tTGxkoiY3xqActZ?=
 =?us-ascii?q?KlcyUG1o4rywPZZveaaYaH+AjjW/yUITpggXJlf6+wiAiq/Ei7z+38StG00F?=
 =?us-ascii?q?FXripZitXMtm4C1xjU6sWfVvty5F2h2TeS1wDI8O1EPUA1mrbbK54m2LIwkI?=
 =?us-ascii?q?YcsV/fESPsnUX2jauWel0l+uiu9evnfq3rqoKTOoJ7kA3zMrkiltahDek3LA?=
 =?us-ascii?q?QCRXWX9fy51LL5/E35RLtKjucxkqncqJ3aPtkUprWiDg9J0ocs9xa/DzC83N?=
 =?us-ascii?q?QehnkINkhJeB2Aj4j3I13OOuz3De+jg1Swlzdm3/fGPrjmApXWKHjMiqvucq?=
 =?us-ascii?q?hm5k5G1gU80NBf6IhICr0bPP3zXUrxvsTCDhAlKwy03/rnCNJl24MFR22PBq?=
 =?us-ascii?q?6ZMKXPsV6H/e8vPeaMa5EPuDrnKPgq+eTujXknll8ZZ6Wp2oEXaH+gFPR8P0?=
 =?us-ascii?q?qZeWbsgssGEWoSpgoxVvHqiFmZXD5LfXmyQqY86ig+CIKhCofDXJ6ijKad0y?=
 =?us-ascii?q?e8G51cfnpGBUyUEXf0a4WEXO8BZz+ILc9nkzwLS7yhS4062BGrqgD6z75nIf?=
 =?us-ascii?q?DS+i0fupPvzsR65+rWlRsq7zx7E9yd032RT2Fzhm4HWTs23KFkrEx41FiD1a?=
 =?us-ascii?q?x4jOZeFdxU6PJFSBs1NZnZz+ZiEdD9RhrBfsuVSFahWtimAzQxTtUrw98UYk?=
 =?us-ascii?q?Z9AM6vjhbZ0CqvHbAVlqaHBJsu8qLTx3LxPdpyy27a1Kk9iFkrWtZANWm4ia?=
 =?us-ascii?q?Fi+QjTAJTJnFiCmqawa6sTwS7N+32fzWaUoE5YVwtwW73fXX8DfkvWscj55k?=
 =?us-ascii?q?TaQr+1FbQoKBBOycqcJaZRdN3pgktJRO35NNTdfW2xgWGwCgiMxr+Wa4rqYW?=
 =?us-ascii?q?odj23hDx0jlQwJ8HTOEA8lAC6qrmGWWDtrEknpakjh2fNzpHOyUgk/yATcKw?=
 =?us-ascii?q?V62r60/AMFreKTRulV3b8eviol7TJuExL159vLD5KloA17ce0Iedog5H9f3H?=
 =?us-ascii?q?/d8gl6OYataatlgwhNXR5wuhbVyxhvCohG2fMvpXcuwRs6fbmUy3tdZjiY2t?=
 =?us-ascii?q?b2IbSRJW7sqkP8I5XK003ThY7FspwE7+41/hC65lmk?=
X-IPAS-Result: =?us-ascii?q?A2DWAACb3sVb/wHyM5BkGwEBAQEDAQEBBwMBAQGBZYFaK?=
 =?us-ascii?q?oFlKIN1lRcGgTWJAo9/OAGENgoChHQhOBYBAwEBAQEBAQIBbCiCNiQBgl4BA?=
 =?us-ascii?q?QEBAgEjBBEPMhALDgoCAiYCAlcGAQwGAgEBgl0/gXUFCKV6ezODKoIQhGaBC?=
 =?us-ascii?q?4pBF3mBB4ESJ4JriAGCVwKIaIYVjy0JiWuGagYXgU+OT4QehHyObSGBVSsIA?=
 =?us-ascii?q?hgIIQ+DJ5ByIzCBBQEBiCUqgiMBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 16 Oct 2018 12:53:17 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w9GCrFIG030617;
        Tue, 16 Oct 2018 08:53:16 -0400
Subject: Re: [PATCH v2] selinux: fix byte order and alignment issues in
 policydb.c
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Cc:     selinux@tycho.nsa.gov, Daniel Jurgens <danielj@mellanox.com>,
        Eli Cohen <eli@mellanox.com>, James Morris <jmorris@namei.org>,
        Doug Ledford <dledford@redhat.com>, stable@vger.kernel.org
References: <20181016070917.5530-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <759badb4-86fe-03b3-7bf6-0f4ff12e7026@tycho.nsa.gov>
Date:   Tue, 16 Oct 2018 08:55:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181016070917.5530-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/16/2018 03:09 AM, Ondrej Mosnacek wrote:
> Add missing LE conversions to the Infiniband-related range checks. These
> were causing a failure to load any policy with an ibendportcon rule on
> BE systems. This can be reproduced by running:
> 
> cat >my_module.cil <<EOF
> (type test_ibendport_t)
> (roletype object_r test_ibendport_t)
> (ibendportcon mlx4_0 1 (system_u object_r test_ibendport_t ((s0) (s0))))
> EOF
> semodule -i my_module.cil
> 
> (On ppc64 it fails with "/sbin/load_policy:  Can't load policy: Invalid
> argument")
> 
> Also, the temporary buffers are only guaranteed to be aligned for 32-bit
> access so use (get/put)_unaligned_be64() for 64-bit accesses.
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
>   security/selinux/ss/policydb.c | 28 +++++++++++++++-------------
>   1 file changed, 15 insertions(+), 13 deletions(-)
> 
> Changes in v2:
>   - add reproducer to commit message
>   - update e-mail address of James Morris
>   - better Cc also the old SELinux ML
> 
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index f4eadd3f7350..2b310e8f2923 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -37,6 +37,7 @@
>   #include <linux/errno.h>
>   #include <linux/audit.h>
>   #include <linux/flex_array.h>
> +#include <asm/unaligned.h>
>   #include "security.h"
>   
>   #include "policydb.h"
> @@ -2108,7 +2109,7 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
>   {
>   	int i, j, rc;
>   	u32 nel, len;
> -	__le32 buf[3];
> +	__le32 buf[4];
>   	struct ocontext *l, *c;
>   	u32 nodebuf[8];
>   
> @@ -2218,20 +2219,20 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
>   				break;
>   			}
>   			case OCON_IBPKEY:
> -				rc = next_entry(nodebuf, fp, sizeof(u32) * 4);
> +				rc = next_entry(buf, fp, sizeof(u32) * 4);
>   				if (rc)
>   					goto out;
>   
> -				c->u.ibpkey.subnet_prefix = be64_to_cpu(*((__be64 *)nodebuf));
> +				c->u.ibpkey.subnet_prefix = get_unaligned_be64(buf);
>   
> -				if (nodebuf[2] > 0xffff ||
> -				    nodebuf[3] > 0xffff) {
> +				if (le32_to_cpu(buf[2]) > 0xffff ||
> +				    le32_to_cpu(buf[3]) > 0xffff) {
>   					rc = -EINVAL;
>   					goto out;
>   				}
>   
> -				c->u.ibpkey.low_pkey = le32_to_cpu(nodebuf[2]);
> -				c->u.ibpkey.high_pkey = le32_to_cpu(nodebuf[3]);
> +				c->u.ibpkey.low_pkey = le32_to_cpu(buf[2]);
> +				c->u.ibpkey.high_pkey = le32_to_cpu(buf[3]);

I'm wondering why the handling here is inconsistent with that of 
OCON_NODE/OCON_NODE6, which also deals with network byte order / big 
endian data.  Also it is inconsistent with the corresponding userspace 
code in libsepol for IBPKEY, which just does a memcpy() for copying 
between the subnet_prefix and the buffer.

Switching to buf entirely doesn't seem right since it is __le32 and the 
first part is actually __be64.

Maybe we ought to be splitting this into two next_entry() calls, one to 
fetch the be64 subnet prefix into an appropriately aligned and typed 
buffer and one to fetch the le32 low/high pkey values into buf?

We also need to fix the libsepol code 
(selinux/libsepol/src/policydb.c:ocontext_read_selinux) for the validity 
check at least.

>   
>   				rc = context_read_and_validate(&c->context[0],
>   							       p,
> @@ -2249,7 +2250,8 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
>   				if (rc)
>   					goto out;
>   
> -				if (buf[1] > 0xff || buf[1] == 0) {
> +				if (le32_to_cpu(buf[1]) > 0xff ||
> +				    le32_to_cpu(buf[1]) == 0) {
>   					rc = -EINVAL;
>   					goto out;
>   				}
> @@ -3105,7 +3107,7 @@ static int ocontext_write(struct policydb *p, struct policydb_compat_info *info,
>   {
>   	unsigned int i, j, rc;
>   	size_t nel, len;
> -	__le32 buf[3];
> +	__le32 buf[4];
>   	u32 nodebuf[8];
>   	struct ocontext *c;
>   	for (i = 0; i < info->ocon_num; i++) {
> @@ -3192,12 +3194,12 @@ static int ocontext_write(struct policydb *p, struct policydb_compat_info *info,
>   					return rc;
>   				break;
>   			case OCON_IBPKEY:
> -				*((__be64 *)nodebuf) = cpu_to_be64(c->u.ibpkey.subnet_prefix);
> +				put_unaligned_be64(c->u.ibpkey.subnet_prefix, buf);
>   
> -				nodebuf[2] = cpu_to_le32(c->u.ibpkey.low_pkey);
> -				nodebuf[3] = cpu_to_le32(c->u.ibpkey.high_pkey);
> +				buf[2] = cpu_to_le32(c->u.ibpkey.low_pkey);
> +				buf[3] = cpu_to_le32(c->u.ibpkey.high_pkey);
>   
> -				rc = put_entry(nodebuf, sizeof(u32), 4, fp);
> +				rc = put_entry(buf, sizeof(u32), 4, fp);
>   				if (rc)
>   					return rc;
>   				rc = context_write(p, &c->context[0], fp);
> 

Likewise this doesn't seem consistent with the OCONTEXT_NODE/NODE6 
handling here or the libsepol ocontext_write_selinux code for 
OCON_IBPKEY.  We could also split this into two put_entry() calls to 
preserve the typing separation between the be64 and le32 data.
