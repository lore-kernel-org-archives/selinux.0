Return-Path: <SRS0=8zWZ=P2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87392C43387
	for <selinux@archiver.kernel.org>; Fri, 18 Jan 2019 16:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5986E20850
	for <selinux@archiver.kernel.org>; Fri, 18 Jan 2019 16:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="rDiccX/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfARQOT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:14:19 -0500
Received: from ucol19pa14.eemsg.mail.mil ([214.24.24.87]:61018 "EHLO
        ucol19pa14.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfARQOS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Jan 2019 11:14:18 -0500
X-EEMSG-check-017: 664927341|UCOL19PA14_EEMSG_MP12.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.56,491,1539648000"; 
   d="scan'208";a="664927341"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by ucol19pa14.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Jan 2019 16:14:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1547828048; x=1579364048;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=bUcI9dfpK1lpI9exmacIk2EZq+9xNP8QAGT4iQX0dK4=;
  b=rDiccX/67XqdZFAs9nC7iMh8OCS4PeCfinV1+JnbmtxESXG2IHxT3RWP
   a9tCwFdgl2R/B19RXUXZsD4RYnStR5wz9lhiwcBddIXaZRpFqbEa7GSLz
   QgtckdjSCEC8GViwwwU5BPeJuRaCEA9dJrRR0gsjq7+nLGvCAqM1XhfBa
   yLtCA1EbqLCvL6ajLYWR8w1Ze02FfYq9+vPHN54nWuSv5EW+B7EDAo14t
   548SS7tVSTEaKzHQiLEcRUppBwjMoz34zPD2tx5cOpVtK0Gf7EJp8TEGk
   /5UMp8PpiJ36bDiWT7CXwVXYyFQHLZFmgCEW9FKOy2lAi9X3+H3R6UGpy
   A==;
X-IronPort-AV: E=Sophos;i="5.56,491,1539648000"; 
   d="scan'208";a="22842874"
IronPort-PHdr: =?us-ascii?q?9a23=3AoCWNnBFvM/5QJfz1JmeTM51GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7ypsWwAkXT6L1XgUPTWs2DsrQY07qQ6/iocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmDmwbaluIBmqsA7cqtQYjYx+J6gr1x?=
 =?us-ascii?q?DHuGFIe+NYxWNpIVKcgRPx7dqu8ZBg7ipdpesv+9ZPXqvmcas4S6dYDCk9PG?=
 =?us-ascii?q?Au+MLrrxjDQhCR6XYaT24bjwBHAwnB7BH9Q5fxri73vfdz1SWGIcH7S60/VC?=
 =?us-ascii?q?+85Kl3VhDnlCYHNyY48G7JjMxwkLlbqw+lqxBm3oLYfJ2ZOP94c6zTZ9MaQX?=
 =?us-ascii?q?dKUNhXWSJPH4iwa5IDA/cdMepdqYT2ulkAogakBQS0Ge3h1DFIiH/106M03e?=
 =?us-ascii?q?suHgPJ0xAvEd8VrHTZrs/4OLsOXe27zqTFyyjIYfNM2Tf67YjFag0voe2SUr?=
 =?us-ascii?q?Joccre108vHB7YgFWVs4PlOzeV2foNsmOG6OdgTv+gi3U8pgFtojmg2scsio?=
 =?us-ascii?q?7TioIT0VDL7z91wIkyJd2mUUN2Z8OvHpVXtyGfLYR2Q8UiTnlnuCY71r0GuY?=
 =?us-ascii?q?O7czMQxJs7wB7fbvqKeJWL7BL7TOudPDh1iX1/dL+/mhq+61asx+LiWsWuzV?=
 =?us-ascii?q?pHqDdOnMPWuXAXzRPT79CKSv56/ki8xzmCzxvT6uRYIUAskqrbNoIhzqYwlp?=
 =?us-ascii?q?UNtUTDGTf7mFnsg6+Md0Uk5/Oo5/77YrTmupCcN4h0hhv4MqsygcywHf40Mg?=
 =?us-ascii?q?0PX2if4ei81bvj8lPlQLhSk/E7nabUvIraKMgGvKK1HQBY3pg55xqiFzum1c?=
 =?us-ascii?q?4XnXgDLFJLYhKHiI3pNknVIP/lFveymEiskTd3yPDGOb3tGJPNLmPZn7v7cr?=
 =?us-ascii?q?Z97FBcxBIpzd9D/5JUFq0BIPXrV0/3tdzXEhg5MwiuzOb8Etl914QeWWWUAq?=
 =?us-ascii?q?+CK67StFCF5+01L+mLfo8Vty73K+I56P72kX85hVgdcLGy3ZQJbHC4H/JmI1?=
 =?us-ascii?q?iWYHf3nNcBHnkFvhAkQOzpllKCSzhTaGi2X64m4TE7Eo2mXs//QdWLgbeG2C?=
 =?us-ascii?q?6gVrxRYXtdQgSKEHzvc4yfHfYLbzmJCso9gnoDT7f3D8c62BWvshLq46RoI/?=
 =?us-ascii?q?CS+SACs5/nkt9v6L79jxY3oAdoAtyd3mfFdGR9mmcFVndix6xkiVBswVeEl6?=
 =?us-ascii?q?5jirpXEsIFtKABaRszKZOJl78yMNv1QA+UO47QEFs=3D?=
X-IPAS-Result: =?us-ascii?q?A2C8AwCk+kFc/wHyM5BkHAEBAQQBAQcEAQGBZYFbKWaBA?=
 =?us-ascii?q?ieEAZQDTwEBAQaBCAgliTOJRocDMAgBhEACglwiOBIBAwEBAQEBAQIBbBwMg?=
 =?us-ascii?q?jopAYJnAQUjFVELGAICJgICVwYBDAYCAQGCXz8BgXQND6tXgS+ELgGBFIRyB?=
 =?us-ascii?q?YELizYXeIEHgTgMgl+DHgKBKoNAglcCkFM5kRQJhySKcQYYgWaIZodILYlXh?=
 =?us-ascii?q?RyNWiGBVisIAhgIIQ+DJ4JRgziKcSEDMIEFAQGGQIJNAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 18 Jan 2019 16:14:07 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x0IGE4El006488;
        Fri, 18 Jan 2019 11:14:04 -0500
Subject: Re: [PATCH 1/1] libselinux: do not dereference symlink with statfs in
 selinux_restorecon
To:     Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org
References: <20190116205710.30659-1-nicolas.iooss@m4x.org>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a72edea4-6285-2260-b3bf-f7d08f53767d@tycho.nsa.gov>
Date:   Fri, 18 Jan 2019 11:16:05 -0500
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

Thanks, merged via
https://github.com/SELinuxProject/selinux/pull/131

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

