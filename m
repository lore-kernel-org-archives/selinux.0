Return-Path: <SRS0=lcCQ=3X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27786C33CAC
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 13:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E36502087E
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 13:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="BnwVzxhK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgBCNg7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Feb 2020 08:36:59 -0500
Received: from UPDC19PA20.eemsg.mail.mil ([214.24.27.195]:37499 "EHLO
        UPDC19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgBCNg7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Feb 2020 08:36:59 -0500
X-EEMSG-check-017: 53427087|UPDC19PA20_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,398,1574121600"; 
   d="scan'208";a="53427087"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 03 Feb 2020 13:36:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580737014; x=1612273014;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=s1FnkH28N4Zw2fh21mMjid1efUXDCGNMHVTkhXhiKpA=;
  b=BnwVzxhKjl5adUlOj1m3zYtv/ch3mSvLL5lFj5zRRGL0dMxXqA09IjqS
   /Iv9aDbt3fhDtiLdOiLO7wUeJswetpXHnM1K2dBjBRubOpXZN1tVAZQbc
   Fn8BG5829fXDqGyDiRoD37vMx7TQ+Z9gCr5G+k1a1r2vKAxG4/laWYr2K
   uBY3i8LyjGElg2Hi8i72D26Liq3kTinbt1I426CJIAhy7quZ2zXf5B0jz
   9HCXK5aqx4kDWJppVMhSOAHfwXlUkeBwTp3iTPYIIInnk9QbBrqHrLccP
   A6W6pn6eVQRitbNm36MVoi4AVz8pgkSBkeSC7rdE8IjI/z6TE9aVZpcuU
   g==;
X-IronPort-AV: E=Sophos;i="5.70,398,1574121600"; 
   d="scan'208";a="32602059"
IronPort-PHdr: =?us-ascii?q?9a23=3AFBmaOBMTEVw9jItEgjEl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/j+osbcNUDSrc9gkEXOFd2Cra4d16yK7Ou9ASRAuc/H7ClZNsQUFl?=
 =?us-ascii?q?cssoY/p0QYGsmLCEn2frbBThcRO4B8bmJj5GyxKkNPGczzNBX4q3y26iMOSF?=
 =?us-ascii?q?2kbVImbuv6FZTPgMupyuu854PcYxlShDq6fLh+MAi6oR/eu8ULjoZuMKk8xx?=
 =?us-ascii?q?nGrnZIZ+hd2GdkKU6Okxrm6cq84ZBu/z5Mt/498sJLTLn3cbk/QbFEFjotLn?=
 =?us-ascii?q?o75NfstRnNTAuP4mUTX2ALmRdWAAbL8Q/3UI7pviT1quRy1i+aPdbrTb8vQj?=
 =?us-ascii?q?St871rSB7zhygZMTMy7XzahdZxjKJfpxKhugB/zovJa4ybKPZyYqXQds4BSG?=
 =?us-ascii?q?FfQsheSTBOAoKkb4sOEeUBO/pYr5LgrFcKtBeyGBWgCP/qxjJOiHD2x6k62P?=
 =?us-ascii?q?k/Hw/A0gIrAtYCvG3aodjxMasfV/2+wqvVwjXZd/5YxCnz6IbIfB4ir/+DU7?=
 =?us-ascii?q?1/fsjNxkcgDA7FkledpJb5Mz+J2OkAsW6W5PdgW+K1jG4nrhl8rCWzxsgyko?=
 =?us-ascii?q?nJhpwaylbZ/itkxYY6P9m4SEplbt+kDZBdsDqaOJZtQs45X2FpuDo1yr0BuZ?=
 =?us-ascii?q?KheigK044oywTQa/yAbYiF+xTuX/uSLzdgnH9pZb2yihmo/UWg1+HwTNe43V?=
 =?us-ascii?q?lUoiZfj9XBsG0G2QbJ5cidUPR9+1+s2TOI1w/O9O5JOVs0la/HK545xb4wi4?=
 =?us-ascii?q?YTvVzDHiDonEX2i7ebdlk+9eiy6uTnf67mqoWdN49yhAH+Nb8uldKjDugiLg?=
 =?us-ascii?q?gPX3SU+eS71LH5+032XK5KgeEsnqncsZDaIdwXpq+/AwBLzoYu8wuzAjip3d?=
 =?us-ascii?q?gCnXQLMUhJdAyIgoT3IV3CPej0DfKljFStlDdryerGPrrkApjVNXjMjazhcK?=
 =?us-ascii?q?1h609c1AUzzddf64hSCrEaOv3/QEDxtNvGDhMhKQy73/7nCMlh1oMZQW+PAr?=
 =?us-ascii?q?WZMKLPvl6I/O0iOOaMZIgSuDbyL/gq+eTigmM+mV8YZaOpx4cYaGikHvR6JE?=
 =?us-ascii?q?WUeWLsjc0cEWcOpQc+VPbliECGUTJKYnayWKU85islB468EYjDQYWtiqSb3C?=
 =?us-ascii?q?inBp1WenxGCleUHHj2b4WLQe0MaCOJIsJ6ijwLT6KhS4461RG2sA/10aZoIf?=
 =?us-ascii?q?TO9i0fr5Lj28B/5/fPmhEq6Tx0E8Od3nmPT25qkGMISSE20btwoUx6zVeD3q?=
 =?us-ascii?q?x4jOJCGdNP4PNJVx8wNYTAwOxiF9DyRgXBc8+SSFm8RtWnATAwT9I3w9IVeU?=
 =?us-ascii?q?l9HcitjgrE3yqrHrAZjaCEBJsx8qjExXj+O959y2ra1Kkml1QmWdVANWmnhq?=
 =?us-ascii?q?556gjSCJXEk1uWl6m0b6QQxi3N+3mZzWqIok5YVBR8UaLfXXAQfkHWt8j25l?=
 =?us-ascii?q?veT7+yDrQqKg9Byc+EKqtXZdzllFZGS+n5ONTYfW2xn3y9BQiHxrySdormYW?=
 =?us-ascii?q?Yd0zvHCEgCjQ8T+WyKNQ8kBieuu2jeFiBhFUrzY0Pw9ulzsHC7QVEuzwGMcU?=
 =?us-ascii?q?Jh06O5+gILivOGTvMexagLuCE8pDVuG1a93s/ZB8CcqApmeaUPKe86tXdd1G?=
 =?us-ascii?q?7IvkRDN5i7JrprhENWJwRtvk//3j14DYJPlcVsp3Qvmk46EauF1BtkcDSC0N?=
 =?us-ascii?q?ikIrTKLkHq9Q2rLqvR3UvTlt2R//FLoNkiql6rhAizF1Fqp3h/2sNUyFOE74?=
 =?us-ascii?q?/LFxIWWJn8FEEt+E4+75PXbCd12YrS2XB2eZKotTLak4YrCeUr1D6veNBQNK?=
 =?us-ascii?q?7CHwj3RYlSIsG0K6QRkly4fAMCdLRJ/aolLdKgX/KA1LSsPeomlzWj2yAP+4?=
 =?us-ascii?q?1500SR5wJiRePSmZUI2feV2k2ATTi4xFOgtN3n3INJfzcfGkKhxiX+Qo1cfK?=
 =?us-ascii?q?t/ecAME2j9Ddeww4BFm5P1W3NevGWmDlcC1d7hLQGedHThzAZQ0gIRunXhli?=
 =?us-ascii?q?ymmW8n2wo1p7aSiXSdi9/pcwAKbysSHzhv?=
X-IPAS-Result: =?us-ascii?q?A2AVAAA6IThe/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYFqAgEBAQELAYF8gW0gEiqEFIkDhlwBAQaBN4lvkHIDVAkBAQEBA?=
 =?us-ascii?q?QEBAQE3AQGEQAKCWDcGDgIQAQEBBAEBAQEBBQMBAWyFQ4I7KQGDAgEFIwQRQ?=
 =?us-ascii?q?RALGAICJgICVwYBDAYCAQGCYz+CVyWrYH8zhUqDQYE+gQ4qAYUdDIcQeYEHg?=
 =?us-ascii?q?TgPgl0+hBKDSYI8IgSWV2FGl2SCRYJOk2wGG5sIjmGdKiM3gSErCAIYCCEPg?=
 =?us-ascii?q?ydQGA2cLAFUIwMwjEaCQwEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 03 Feb 2020 13:36:53 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 013Da30M154637;
        Mon, 3 Feb 2020 08:36:03 -0500
Subject: Re: [PATCH] selinux: Fix typo in filesystem name
To:     Hridya Valsaraju <hridya@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Mark Salyzyn <salyzyn@android.com>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com
References: <20200202014624.75356-1-hridya@google.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <63958eb9-0b65-00f2-76fa-799c3a933f7b@tycho.nsa.gov>
Date:   Mon, 3 Feb 2020 08:38:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200202014624.75356-1-hridya@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/1/20 8:46 PM, Hridya Valsaraju wrote:
> Correct the filesystem name to "binder" to enable
> genfscon per-file labelling for binderfs.
> 
> Fixes: 7a4b5194747 ("selinux: allow per-file labelling for binderfs")
> Signed-off-by: Hridya Valsaraju <hridya@google.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
> 
> Hello,
> 
> I seem to have made the typo/mistake during a rebase. Sorry about that
> :(
> 
> Thanks,
> Hridya
> 
>   security/selinux/hooks.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 89fe3a805129..d67a80b0d8a8 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -699,7 +699,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>   
>   	if (!strcmp(sb->s_type->name, "debugfs") ||
>   	    !strcmp(sb->s_type->name, "tracefs") ||
> -	    !strcmp(sb->s_type->name, "binderfs") ||
> +	    !strcmp(sb->s_type->name, "binder") ||
>   	    !strcmp(sb->s_type->name, "pstore"))
>   		sbsec->flags |= SE_SBGENFS;
>   
> 

