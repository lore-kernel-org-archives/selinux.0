Return-Path: <SRS0=uPJ/=PY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E7FC43387
	for <selinux@archiver.kernel.org>; Wed, 16 Jan 2019 21:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B772C20675
	for <selinux@archiver.kernel.org>; Wed, 16 Jan 2019 21:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="U3LfQdfM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbfAPV1d (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:27:33 -0500
Received: from uphb19pa08.eemsg.mail.mil ([214.24.26.82]:15255 "EHLO
        USFB19PA11.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729613AbfAPV1d (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Jan 2019 16:27:33 -0500
X-EEMSG-check-017: 104317839|USFB19PA11_EEMSG_MP7.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Jan 2019 21:27:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1547674051; x=1579210051;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=5fuXc0mBdnC3qt7A6KSzMRyoT3haRXjABHH5akruv54=;
  b=U3LfQdfMFwE6TA3HMWpPB/goR0Uv2IfUv3oOOn2PAW4b+WOD9zRZl2k3
   pVLl3nHET5LDssuw0z/WkTZ05UeRUk3eur3s3WyLrr3LGsB02P4R8gjxk
   bcC/K7zLDLZrEa3F4I9ksKjNJemDdPSSqkucSuluEBMruSQNPQpNun31q
   f2M9a9WkwasNbfemWBGUSdXqJ5MfqVcQCwD1j4KeX+xOJb2An7XjZQHr6
   P68/W5PRHltC0EKlDLHLDOeWZRPsF2A4GirPZyOiaZiwuZyR5L7G9EX8B
   ExJmcdAeHqrz7hWpnZrJrTARBEduR2Ia1Hi33Cq/Hy9FBBxouSnRSpm+f
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,487,1539648000"; 
   d="scan'208";a="22763456"
IronPort-PHdr: =?us-ascii?q?9a23=3APnRoDh9kgw3Jyv9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B20uMcTK2v8tzYMVDF4r011RmVBdWds6oMotGVmpioYXYH75eFvSJKW713fD?=
 =?us-ascii?q?hBt/8rmRc9CtWOE0zxIa2iRSU7GMNfSA0tpCnjYgBaF8nkelLdvGC54yIMFR?=
 =?us-ascii?q?XjLwp1Ifn+FpLPg8it2O2+557ebx9UiDahfLh/MAi4oQLNu8cMnIBsMLwxyh?=
 =?us-ascii?q?zHontJf+RZ22ZlLk+Nkhj/+8m94odt/zxftPw9+cFAV776f7kjQrxDEDsmKW?=
 =?us-ascii?q?E169b1uhTFUACC+2ETUmQSkhpPHgjF8BT3VYr/vyfmquZw3jSRMNboRr4oRz?=
 =?us-ascii?q?ut86ZrSAfpiCgZMT457HrXgdF0gK5CvR6tuwBzz4vSbY6bLvp+er7Wc80cS2?=
 =?us-ascii?q?RPQ81dUzVNDp6gY4cKCecKIORWoJTnp1YWsBWwGwesCuPsxDFGiHD50q813P?=
 =?us-ascii?q?guHwzdwAwtHcgDvGjIoNj7NqofV/2+wqnSzTXEavNbwSrz6JTWfRA5ofGDQ7?=
 =?us-ascii?q?RwetfMx0kqDQzFilGQppLlPjiI0ekNqHWU7/F7WOKzi28otwFxoj+1yscqkY?=
 =?us-ascii?q?nGnJgZyl/D9SVn2Ys4I8CzRkB8Yd6hCpRQtieaOpN5QsMjX2FouDs6xaYctZ?=
 =?us-ascii?q?GneygKzZIqzAPcZfyfa4WE/x3uWemLLTp4mX5pYqyzihms/US61+HxUNS/3k?=
 =?us-ascii?q?xQoSpfiNbMs2gA1xnU6seaVPRw5lyh2TOT1wDL7eFEPFw0mbLbK5E/xr4wkY?=
 =?us-ascii?q?IesVjZES/smUX2kbSWel84+umo9+vnYrLmqoWaN4BokQHxLr4imsm+AeQ8Kg?=
 =?us-ascii?q?QOXm6b9vqg1LD74EH0T7pHguc2n6XEqpzWO8sWqrCjDwNIyooj7gywDzai0N?=
 =?us-ascii?q?QWh3kHK1dFdQqcj4f0IFHDO+z4DPejjFSslzdn3fbGPqb7DZnXIXjDl6nhca?=
 =?us-ascii?q?5n60FA0Aoz0cxf55VMB7EHIfL8RkjxtNjCAR8iKQC0wuHnCNJm1oMFQm+PB6?=
 =?us-ascii?q?CUMazIvV+P/OIvLPGGZJUJtzblN/gl+/nugGcimVADeamp3J0XaG23H/l9PU?=
 =?us-ascii?q?WZbmTjgs0bHWcJoAU+Vurqh0OGUTJJYHayRa08tXkHD9eADIzEQom2yJ2G2z?=
 =?us-ascii?q?ygVslQZ2tBDlmXV3bvcJ6fc/JQeGSVOMA31nQfWLygTZIx/Q+huRW8yLd9KO?=
 =?us-ascii?q?fQvCoCusHNzt9wstbPmAky+Do8NMGU12WAXikghW8TbyMn16B450pmwxGM1r?=
 =?us-ascii?q?Yu0K8QLsBa+/4cClRyDpXb1eEvTomrAg8=3D?=
X-IPAS-Result: =?us-ascii?q?A2DaAAD8oD9c/wHyM5BjGwEBAQEDAQEBBwMBAQGBZYFbK?=
 =?us-ascii?q?WZPMyeEAZN8TAEBAQEBAQaBNYkwiUaHAzAIAYRAAoJTIjgSAQMBAQEBAQECA?=
 =?us-ascii?q?WwcDII6KQGCZwEFIxVRCxgCAiYCAlcGAQwGAgEBgl8/AYF0DQ+rcIEvhUOEb?=
 =?us-ascii?q?AWBC4s0F3iBB4E4gmuDHgKBKoNAglcCkEs5kQwJhyKKawYYgWWIYYdFLYlTh?=
 =?us-ascii?q?RiNUyGBVisIAhgIIQ+DJ4JRgziKcSEDMIEFAQGHX4JNAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 16 Jan 2019 21:27:29 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x0GLRSoM004680;
        Wed, 16 Jan 2019 16:27:28 -0500
Subject: Re: [PATCH 1/1] libselinux: do not dereference symlink with statfs in
 selinux_restorecon
To:     Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org
References: <20190116205710.30659-1-nicolas.iooss@m4x.org>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <ebe6cfeb-ed7e-f185-e4e0-7bf47d6b8e49@tycho.nsa.gov>
Date:   Wed, 16 Jan 2019 16:29:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190116205710.30659-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/16/19 3:57 PM, Nicolas Iooss wrote:
> When selinux_restorecon() is used to relabel symlinks, it performs the
> following syscalls (as seen by running strace on restorecond):
> 
>      lstat("/root/symlink", {st_mode=S_IFLNK|0777, st_size=6, ...}) = 0
>      statfs("/root/symlink", 0x7ffd6bb4d090) = -1 ENOENT (No such file or directory)
>      lstat("/root/symlink", {st_mode=S_IFLNK|0777, st_size=6, ...}) = 0
>      lgetxattr("/root/symlink", "security.selinux", "sysadm_u:object_r:user_home_t", 255) = 30
> 
> The second one triggers a SELinux check for lnk_file:read, as statfs()
> dereferences symbolic links. This call to statfs() is only used to find
> out whether "restoreconlast" xattr can be ignored, which is always the
> case for non-directory files (the first syscall, lstat(), is actually
> used to perform this check).
> 
> Skip the call to statfs() when setrestoreconlast is already false.
> 
> This silences an AVC denial that would otherwise be reported to
> audit.log (cf. https://github.com/SELinuxProject/refpolicy/pull/22).
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   libselinux/src/selinux_restorecon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
> index 3df2d382d50b..42a48f5a1b0b 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -881,7 +881,7 @@ int selinux_restorecon(const char *pathname_orig,
>   		setrestoreconlast = false;
>   
>   	/* Ignore restoreconlast on in-memory filesystems */
> -	if (statfs(pathname, &sfsb) == 0) {
> +	if (setrestoreconlast && statfs(pathname, &sfsb) == 0) {
>   		if (sfsb.f_type == RAMFS_MAGIC || sfsb.f_type == TMPFS_MAGIC)
>   			setrestoreconlast = false;
>   	}
> 

