Return-Path: <SRS0=Zlcp=RJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185F1C43381
	for <selinux@archiver.kernel.org>; Wed,  6 Mar 2019 14:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54D320684
	for <selinux@archiver.kernel.org>; Wed,  6 Mar 2019 14:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="G7JZAfFZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfCFOer (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Mar 2019 09:34:47 -0500
Received: from ucol19pa10.eemsg.mail.mil ([214.24.24.83]:38825 "EHLO
        UCOL19PA10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfCFOer (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Mar 2019 09:34:47 -0500
X-EEMSG-check-017: 650089314|UCOL19PA10_EEMSG_MP8.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.58,448,1544486400"; 
   d="scan'208";a="650089314"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Mar 2019 14:34:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1551882869; x=1583418869;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=M1xbkcrSAww+A9Id2ODVqaBakcXjTnPocMcrYCJPiwA=;
  b=G7JZAfFZRd66Ay2jw80x3eWKkWWByc9mh7HWwfIR0OA/omaGQ1AD7Rfe
   LwCRQU8aQtq/t7LwhcUmflQxtfC346RJ/MVqctr3hcmdBOZayMn/LwLLr
   zlOFJQ2B4co3D+axlSsu+Ijjgy7lNiUZSC7/EcBMyDy6kxFUucT5x2Jox
   YwAXbH03GkolEOecZpj8RYMEZc4TzCpasi1uDyctrXodFtU5Pe8s7+zOz
   Njgw7VUUgVlLbNjjaGzWfcBhMemjSyvjF4cM6koKKAxzhgBWhPugZfbpD
   JazTx5j0aURbaQg6aJaUWIJLyRYF68p6CeZ47xf8/DooOBnLlXEv4fn3K
   w==;
X-IronPort-AV: E=Sophos;i="5.58,448,1544486400"; 
   d="scan'208";a="21184533"
IronPort-PHdr: =?us-ascii?q?9a23=3A2WFPfx8cbAFcGf9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+0ugfIJqq85mqBkHD//Il1AaPAdyDraodw8Pt8InYEVQa5piAtH1QOLdtbD?=
 =?us-ascii?q?Qizfssogo7HcSeAlf6JvO5JwYzHcBFSUM3tyrjaRsdF8nxfUDdrWOv5jAOBB?=
 =?us-ascii?q?r/KRB1JuPoEYLOksi7ze+/94DPbwlSmDaxfK55IQmrownWqsQYm5ZpJLwryh?=
 =?us-ascii?q?vOrHtIeuBWyn1tKFmOgRvy5dq+8YB6/ShItP0v68BPUaPhf6QlVrNYFygpM3?=
 =?us-ascii?q?o05MLwqxbOSxaE62YGXWUXlhpIBBXF7A3/U5zsvCb2qvZx1S+HNsDtU7s6RS?=
 =?us-ascii?q?qt4LtqSB/wiScIKTg58H3MisdtiK5XuQ+tqwBjz4LRZoyaOuB+fqfAdt0EQ2?=
 =?us-ascii?q?RPUNtaWyhYDo+ia4YDCuwMNvtaoYbgvVsDtQawCxeiBO3vyTFGiHH50qI43O?=
 =?us-ascii?q?s9Hg/LxxAgEtAUvXjIsNn4OqUfXOaox6fI1zXDaPZW1C/g5ojUbB8hufGMUq?=
 =?us-ascii?q?x2ccHM1EcvEhnKjlGUqYP7PzKey+MAs3OG4Op7Tu+vl24mpB1xojio3MssjJ?=
 =?us-ascii?q?LJiZgPxlDL8iV53p84KNulQ0B1Zt6kFYFftyCcN4ZuTcMiQn1ouCYnyrIdo5?=
 =?us-ascii?q?K0YC8KyJEhyhXCaPKHa5CF7g/sWeueOzt1hG9pdKihixu970Ss0PDwW8+p21?=
 =?us-ascii?q?hQtCVFiMPDtnUV2hzW7ciIV+Vy81+62TaKywDT8uZEIV0olabDK54u3Lowlp?=
 =?us-ascii?q?0LvETfBCD2gkT2jLKNdkk+5uip6/joYrXhppOGMY97lhr+Pbg0lsy6AOQ4Nh?=
 =?us-ascii?q?ACX2md+euiyL3u5VD1TbpFg/EskqTVrYrWKdoUq6KnGQNZz54v6xOlADen1N?=
 =?us-ascii?q?QYk2MHLFVAeB+flIjmJkrOLevkDfa/n1uskDBry+rAPr36GJrBNHfDkLD/fb?=
 =?us-ascii?q?pl8U5T1BIzzcxD55JTErwOO/zzWk7vu9zcExA5KBe5w+jmCNpj0oMRRHmPDb?=
 =?us-ascii?q?GCMK/Itl+I/O0vKfGWZIAJoDb9N+Ql5/n2gH8hg1AdYK2p0IAPaH+iA/RmJ1?=
 =?us-ascii?q?yVYX/rgtcGC2cFoBAyQ/DtiF2HSTRTfWq9X7og5jEnD4KrFZnMRpi3j7yb3S?=
 =?us-ascii?q?e7BYZbZnhcBVCWEHfobJ2EW/MWZy2OPMBtiDsEVaKuS4U5zxGhqBf6y6Z7Lu?=
 =?us-ascii?q?rT4iAYrozs1Nx05+3ViBEz+id5D9qS026TVWF4hGAISCEs3KB5v0N9zk2P0a?=
 =?us-ascii?q?9ig/xXDdZT/e9GUh8mNZ7AyOx3E8vyWgfbcdaJSFapXNunDCorTt0v3tAOY1?=
 =?us-ascii?q?xyG8m4gh/f2CqqBuxdq7veTr5yuojGwnP8b+h8xnLKz+Np21MoQ8ZLOXaOiK?=
 =?us-ascii?q?9y8wTICpWPlF+WweLiTa0B2Gbo82CZwCLapEhFVCZoWLjBGHUYYVHb69/+4x?=
 =?us-ascii?q?WGB5K0CL9vCgJbyNXKfqZSY8foln1eTe3iI8zaamm83WCqCkDb6KmLad/RZ2?=
 =?us-ascii?q?gF3CjbQHMBmgQX8GfOYRMyHQ+9smneC3poDlupbETyp7ot4EinR1M5mlnZJ3?=
 =?us-ascii?q?Zq0KC4r1tM362R?=
X-IPAS-Result: =?us-ascii?q?A2DrAABX2X9c/wHyM5BkHAEBAQQBAQcEAQGBVAQBAQsBg?=
 =?us-ascii?q?WAFKmiBAyeECJQwAQEBAQEBBoEILYk8iVWHDTAIAYRAAoQxIjcGDQEBAwEBA?=
 =?us-ascii?q?QIBAwIBbBwMgjopAYJmAQEBAQMjBBFBEAsVAwICJgICVwYBDAYCAQGCXz8Bg?=
 =?us-ascii?q?WgND6sBfDOFRIRgBYELJAGLKBd4gQeBOIJrgx4CgSohgyCCVwKRNTuSHwmHS?=
 =?us-ascii?q?YsxBhmTLy2KQoVfjlYigVYrCAIYCCEPgyeCQIM4inEhAzCBBQEBikCCTQEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 06 Mar 2019 14:34:28 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x26EYPAw024682;
        Wed, 6 Mar 2019 09:34:25 -0500
Subject: Re: [PATCH] security/selinux: fix SECURITY_LSM_NATIVE_LABELS on
 reused superblock
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>
Cc:     selinux@vger.kernel.org, Scott Mayhew <smayhew@redhat.com>
References: <20190305211758.GA27437@fieldses.org>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <ea347670-ea52-3ab6-a786-aeebff40dd0e@tycho.nsa.gov>
Date:   Wed, 6 Mar 2019 09:34:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190305211758.GA27437@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/5/19 4:17 PM, J. Bruce Fields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> In the case when we're reusing a superblock, selinux_sb_clone_mnt_opts()
> fails to set set_kern_flags, with the result that
> nfs_clone_sb_security() incorrectly clears NFS_CAP_SECURITY_LABEL.
> 
> The result is that if you mount the same NFS filesystem twice, NFS
> security labels are turned off, even if they would work fine if you
> mounted the filesystem only once.
> 
> ("fixes" may be not exactly the right tag, it may be more like
> "fixed-other-cases-but-missed-this-one".)
> 
> Cc: Scott Mayhew <smayhew@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: 0b4d3452b8b4 "security/selinux: allow security_sb_clone_mnt_opts..."
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

Do you have some tests you are using for the selinux nfs support?  I 
have an open issue on the selinux-testsuite with an example script for 
running the regular selinux tests on a NFS mount but it can't fully 
succeed as noted there,
https://github.com/SELinuxProject/selinux-testsuite/issues/32

I've also have another script to test context= mount handling for nfs 
since that should take precedence over native labels; it looks like that 
might be broken again:

#!/bin/sh
cat > /etc/exports <<EOF
/home localhost(rw,no_root_squash,security_label)
EOF
exportfs -a
systemctl start nfs-server
mkdir -p /mnt/home
mount -t nfs -o vers=4.0,context=system_u:object_r:etc_t:s0 
localhost:/home /mnt/home
echo "Under NFSv4.0:"
ls -Za /mnt/home
touch /mnt/home/foo
ls -Z /mnt/home/foo
ls -Z /home/foo
rm /mnt/home/foo
umount /mnt/home
mount -t nfs -o vers=4.2,context=system_u:object_r:etc_t:s0 
localhost:/home /mnt/home
echo "Under NFSv4.2:"
ls -Za /mnt/home
touch /mnt/home/foo
ls -Z /mnt/home/foo
ls -Z /home/foo
rm /home/foo
umount /mnt/home
rmdir /mnt/home
rm /etc/exports
exportfs -ua
systemctl stop nfs-server

> ---
>   security/selinux/hooks.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index f0e36c3492ba..5e9304567233 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -959,8 +959,11 @@ static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
>   	BUG_ON(!(oldsbsec->flags & SE_SBINITIALIZED));
>   
>   	/* if fs is reusing a sb, make sure that the contexts match */
> -	if (newsbsec->flags & SE_SBINITIALIZED)
> +	if (newsbsec->flags & SE_SBINITIALIZED) {
> +		if ((kern_flags & SECURITY_LSM_NATIVE_LABELS) && !set_context)
> +			*set_kern_flags |= SECURITY_LSM_NATIVE_LABELS;
>   		return selinux_cmp_sb_context(oldsb, newsb);
> +	}
>   
>   	mutex_lock(&newsbsec->lock);
>   
> 

