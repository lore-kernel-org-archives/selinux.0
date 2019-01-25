Return-Path: <SRS0=5KO5=QB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69298C282C0
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 14:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376AA218CD
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 14:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="DgrA2GNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfAYOts (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:49:48 -0500
Received: from upbd19pa09.eemsg.mail.mil ([214.24.27.84]:50386 "EHLO
        UPBD19PA09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfAYOts (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 25 Jan 2019 09:49:48 -0500
X-EEMSG-check-017: 165128893|UPBD19PA09_EEMSG_MP9.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPBD19PA09.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 25 Jan 2019 14:49:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1548427784; x=1579963784;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=P7dhlm0xw/TQUPSVZ2KwLMbHOpBwbQ8pU6AGrziARz0=;
  b=DgrA2GNIcHs7vR2ilRCXgJRoNZ9TIc8DLpuW4+BgJ6GHUHNpOg4m0yS2
   KO5Yl9QmHaNKlE9oGa0wjFdvLRV40omT/OKLAI7gW9bHNjoxa0daxq22v
   rZeP54R33ASsyZ8lzlB0jy7w3Yj0DWQKHGej9vhuuckxc/W2d5XWwYO4e
   a416KnTzJGv/8JRsvZQwqzsHik9EQbzqmLJisLrfou2H5ut0JSU/96a/+
   X6GzZrXrym7tp6SdBWHfhFaNr2cmJWcL8nFQ+4D7HZ+IjPspqPBKiiU+W
   ySa3NNgR4nQ9zUcBV0sPKniovvoS2JgfnW4+h5EXcSZhZGHyEdI81m8XC
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,521,1539648000"; 
   d="scan'208";a="19859442"
IronPort-PHdr: =?us-ascii?q?9a23=3AURNG4h1Pf5FX3lg8smDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesWKPnxwZ3uMQTl6Ol3ixeRBMOHs6IC07KempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffwZFiCChbb9uMR67sRjfus4KjIV4N60/0A?=
 =?us-ascii?q?HJonxGe+RXwWNnO1eelAvi68mz4ZBu7T1et+ou+MBcX6r6eb84TaFDAzQ9L2?=
 =?us-ascii?q?81/szrugLdQgaJ+3ART38ZkhtMAwjC8RH6QpL8uTb0u+ZhxCWXO9D9QKsqUj?=
 =?us-ascii?q?q+8ahkVB7oiD8GNzEn9mHXltdwh79frB64uhBz35LYbISTOfVwZKPdec4RS3?=
 =?us-ascii?q?RHUMhfSidNBpqwY5UTA+YEO+tTsovzqEYUrRamGAeiGu3vxD9LiHH406I13O?=
 =?us-ascii?q?YuHh3J0gE7A9IDsm7ZoMnpOKocU+24yrTDwzXZb/NR3Dfw8JXGcgw/rvGUXb?=
 =?us-ascii?q?J/b8zRwlQyGQPAlFqQrYjlMC2V1+8QtGWb9PdvVfm0hm47qwB+vjivxsA2ho?=
 =?us-ascii?q?nPnYIa0ErI9Sp+wIYrPNC1TlNwb928EJZIqi2XOIR7TtkiTm11oio21LILtY?=
 =?us-ascii?q?ChcCQXzpks2gTRZOadc4eS5xLuTOORITBli317YL+/nBOy8VS4yu37S8m0zE?=
 =?us-ascii?q?5GripbndnIsXAAzwDT5dKdSvt840ehwiyD1xzT6+5YIUA0krDXK5g9zb4rip?=
 =?us-ascii?q?Ufq0HDHi7ymEnuja+WcFsr+vSw5uj6bbjrqYWQOo9phg3kLKgjldKzDf4lPg?=
 =?us-ascii?q?QWWmiU4+W81Lnt/U3jR7VKi+U7krLEv5DBPskbuq64DBNV0oYk8Rq/CSym38?=
 =?us-ascii?q?4CkXkIK1JFZgqLj5L1NFHWPPD4EfC/jkyrkDduwPDGJbvhDY/RIXfdi7rhZ6?=
 =?us-ascii?q?hy5FNcyAUp0dBT/Y5bCrYEIPjrQE/+qMTYDgMlMwyz2+vnE8ty1ocfWWKJH6?=
 =?us-ascii?q?+YP7jfsUGH5u0xOemAfowVtyjnK/gj+fHuiWU1mVgHfammxZEXcmy3Hux6I0?=
 =?us-ascii?q?WFZnrhms8BHn0Xvgo6V+HqkEeNUSNXZ3qrWqI84TY7CJi4AovZWo+th7mB1j?=
 =?us-ascii?q?+hHpJKfmBGFkyMEXDweoWAWvcMbj+SI8B4njMeSLiuVo4h1Q21uQ/g1bVoM+?=
 =?us-ascii?q?rU9TcEtZ75yNd14OjTxlkO8mlTCciH3mPFamZvmGoDSjx+iKd6pld7w1yO+b?=
 =?us-ascii?q?J1j/xRCZpY4PYfFk8hOJrdyfFqI879VxiHfdqTTluiBNK8DnV5dtssx5crZE?=
 =?us-ascii?q?FnFp32lhne2wKyCqIR0rmMA4Y5tKnb2i6iCdx6ziP9yKQ5j1QgCvBKPGmii7?=
 =?us-ascii?q?83oxPfHKbVgk6ZkOCsbq1a0ynTojTQhVGStV1VBVYjGZ7OWmoSMw6P94z0?=
X-IPAS-Result: =?us-ascii?q?A2BsAADyIEtc/wHyM5BkGgEBAQEBAgEBAQEHAgEBAQGBZ?=
 =?us-ascii?q?YFbKYE3ATInhAGUEUwBAQEBAQEGgQgtiTSQTjgBhEACgwkiOBIBAwEBAQEBA?=
 =?us-ascii?q?QIBbCiCOikBgmcBBSMEEUEQCw4KAgImAgJXBgEMBgIBAYJfP4F1DaslfDOFQ?=
 =?us-ascii?q?4RtgQuLNhd4gQeBOIJriAqCVwKJV4Y8STlWkE0JkiQGGJInLYlmkw8hgVYrC?=
 =?us-ascii?q?AIYCCEPgyeCJxeOPCEDMIEFAQGKJwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 25 Jan 2019 14:49:43 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x0PEngqu012028;
        Fri, 25 Jan 2019 09:49:43 -0500
Subject: Re: [PATCH v3 2/4] selinux: replace some BUG_ON()s with a WARN_ON()
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Cc:     linux-audit@redhat.com
References: <20190125100651.21753-1-omosnace@redhat.com>
 <20190125100651.21753-3-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8987cae9-327f-96b7-f598-2dec47097f31@tycho.nsa.gov>
Date:   Fri, 25 Jan 2019 09:52:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125100651.21753-3-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/25/19 5:06 AM, Ondrej Mosnacek wrote:
> We don't need to crash the machine in these cases. Let's just detect the
> buggy state early and error out with a warning.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/avc.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 502162eeb3a0..5ebad47391c9 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -678,7 +678,6 @@ static void avc_audit_pre_callback(struct audit_buffer *ab, void *a)
>   		return;
>   	}
>   
> -	BUG_ON(!sad->tclass || sad->tclass >= ARRAY_SIZE(secclass_map));
>   	perms = secclass_map[sad->tclass-1].perms;
>   
>   	audit_log_string(ab, " {");
> @@ -731,7 +730,6 @@ static void avc_audit_post_callback(struct audit_buffer *ab, void *a)
>   		kfree(scontext);
>   	}
>   
> -	BUG_ON(!sad->tclass || sad->tclass >= ARRAY_SIZE(secclass_map));
>   	audit_log_format(ab, " tclass=%s", secclass_map[sad->tclass-1].name);
>   
>   	if (sad->denied)
> @@ -748,6 +746,9 @@ noinline int slow_avc_audit(struct selinux_state *state,
>   	struct common_audit_data stack_data;
>   	struct selinux_audit_data sad;
>   
> +	if (WARN_ON(!tclass || tclass >= ARRAY_SIZE(secclass_map)))
> +		return -EINVAL;
> +
>   	if (!a) {
>   		a = &stack_data;
>   		a->type = LSM_AUDIT_DATA_NONE;
> 

