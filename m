Return-Path: <SRS0=r+0f=YV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364F8CA9EC0
	for <selinux@archiver.kernel.org>; Mon, 28 Oct 2019 13:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C839121734
	for <selinux@archiver.kernel.org>; Mon, 28 Oct 2019 13:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="pJ3ojupM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbfJ1NCd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Oct 2019 09:02:33 -0400
Received: from UPDC19PA23.eemsg.mail.mil ([214.24.27.198]:5537 "EHLO
        UPDC19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbfJ1NCd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Oct 2019 09:02:33 -0400
X-EEMSG-check-017: 26054822|UPDC19PA23_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,240,1569283200"; 
   d="scan'208";a="26054822"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 28 Oct 2019 13:02:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1572267750; x=1603803750;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=cM4wgWbwCWzPh+MGOs43eG7G67sCjoR2moROQV3Ush4=;
  b=pJ3ojupMjmw9Ux9peJ1l3sbWMGAZxfpf2WbuUVPTzZbVPA42KpIoODwH
   AcPP5dWlEJxM9sYGfeGG7lvFF3IfOXwKU8ULCsAgieDsLDbB2QHrLIHQS
   E2p7JbgugdVEVDP92HPxF34ZFHmKfhXaL3yTPzbTBqs0loZPMgg+j9WYr
   833boKYtFkdpXA2w/Hgm6NgCPxc9ojtpFBPXQZAZYMHcVZixBtZbkd+kf
   AOy/00vrjMDx242umh47Ty9l0o9xO/IMECCSvebIyzn5/qu41JmAIHyl+
   oPV3dG+yEFDenKPqTCPvfzHOVM2unI8kMEEjxTQmDhbY39hFX+iUFOMPZ
   A==;
X-IronPort-AV: E=Sophos;i="5.68,240,1569283200"; 
   d="scan'208";a="34743545"
IronPort-PHdr: =?us-ascii?q?9a23=3APcPeGhQJgD4aPlBIfR+4KKOh29psv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6ybBSN2/xhgRfzUJnB7Loc0qyK6vumCD1LusfJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/Vu8QSjodvJKI8wQ?=
 =?us-ascii?q?bVr3VVfOhb2XlmLk+JkRbm4cew8p9j8yBOtP8k6sVNT6b0cbkmQLJBFDgpPH?=
 =?us-ascii?q?w768PttRnYUAuA/WAcXXkMkhpJGAfK8hf3VYrsvyTgt+p93C6aPdDqTb0xRD?=
 =?us-ascii?q?+v4btnRAPuhSwaLDMy7n3ZhdJsg6JauBKhpgJww4jIYIGOKfFyerrRcc4GSW?=
 =?us-ascii?q?ZdW8pcUSJOApm4b4ASEeQPO+hWpJT5q1cXoxazAQygCeXywTFKm3D2x7U33f?=
 =?us-ascii?q?k/HwHI3AIuHNwAv3rbo9r3KKgcXvu4zLXKwDjZc/9axTnw5YrOfxs8of+MR7?=
 =?us-ascii?q?Vwcc/JxEcyCwPKkE2QqYz7MDOTy+8Drm2b4PBkVeKrlWEmqxx6rz+0xsgxkY?=
 =?us-ascii?q?nEnZ4Vy1DY+iV5x4Y5P9u4SFVhbtK+H5tQsD+aOpJwT8g/QG9ooD43xqAJtJ?=
 =?us-ascii?q?O0ZiQHyIkrywTBZ/GIbYSE+A/vWeCMKjlinn1lYqiwhxOq/Eilze3zS9e73U?=
 =?us-ascii?q?5RripAjtnMrncN1wHP6sSfSvty4EOh2TGX2gDP8O5EO0E0lbfAK5I73r4xlo?=
 =?us-ascii?q?YcsUTEHiPsnkX5kLSWeVk+9uit6uTnZq3qpp6aN4BqlgHzKrkil8OwDOgiMg?=
 =?us-ascii?q?UCQnKX9fqz2bH950H1Xa1GjvgsnanYtJDaK94bpqm8AwJNyYYs9g2/Aiy60N?=
 =?us-ascii?q?UYgXYHLFVFdAiBj4jyIV7COv/4DfChg1i0ijdk2+jGPqH9ApXKNnXCkK3ufb?=
 =?us-ascii?q?Nn5E5Azwo+1spf6IxJBbEBOv3zRlX9u8DfDh88Kwa02froCM1h1oMCXmKCGr?=
 =?us-ascii?q?SZP73WsV+J4OIvPuaNaZQLuDbyNfcl/eTijXwnll8He6mmw58XZGq/HvR8LE?=
 =?us-ascii?q?XKKUbr1/IICm4WtwkzBN3DrXS+dnYHdn+3Vr47zis2BIKvEcHIQYX7xPSa0S?=
 =?us-ascii?q?O6GIBGTn5JB0rKEnrycYiAHfAWZ3G8OMhkxwcYWKChRolp7hSnsAv32vIzNe?=
 =?us-ascii?q?bP0jEJvpLkkt5u7qvckg9kpm88NNiUz2zYFzI8pWgPXTJjmfkk8EE=3D?=
X-IPAS-Result: =?us-ascii?q?A2BnAQA13rZd/wHyM5BlHAEBAQEBBwEBEQEEBAEBgWoEA?=
 =?us-ascii?q?QELAYFzLGxTATIqhCiPBk8BAQEBAQaBESWJY5ExCQEBAQEBAQEBAScNAQIBA?=
 =?us-ascii?q?YRAAoNIJDcGDgIMAQEBBAEBAQEBBQMBAWyFQ4I6KQGCbAEBAQECASMVNhsLG?=
 =?us-ascii?q?AICJgICVwYBDAYCAQGCXz8BglIFIK8mdYEyhU6DNoFIgQ4oAYwOGHiBB4E4D?=
 =?us-ascii?q?IJfPodVgjwiBJY2lzKCLoIzhF2FG4h9BhuCPJcejj+BQJQphXUjgVgrCAIYC?=
 =?us-ascii?q?CEPO4JsCUcQFJFoJQMwgQYBAY9eAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 28 Oct 2019 13:02:28 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9SD2SWr003776;
        Mon, 28 Oct 2019 09:02:28 -0400
Subject: Re: [PATCH 1/2] docs: sysctl: update description for inode-state
To:     Masatake YAMATO <yamato@redhat.com>, selinux@vger.kernel.org
References: <20191028124353.25276-1-yamato@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <871cd7f6-5866-7e8d-1fc3-664828d031a6@tycho.nsa.gov>
Date:   Mon, 28 Oct 2019 09:02:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191028124353.25276-1-yamato@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/28/19 8:43 AM, Masatake YAMATO wrote:
> The third field of inode-state is dummy (== 0).
> Update the description about the actual fields and
> dummies.

These are not patches for SELinux and hence should not go to the selinux 
mailing list. Use scripts/get_maintainer.pl for some suggestions on the 
right set of maintainers and lists.

> 
> Signed-off-by: Masatake YAMATO <yamato@redhat.com>
> ---
>   Documentation/admin-guide/sysctl/fs.rst | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
> index 2a45119e3331..596f84a1748d 100644
> --- a/Documentation/admin-guide/sysctl/fs.rst
> +++ b/Documentation/admin-guide/sysctl/fs.rst
> @@ -151,18 +151,15 @@ out of inodes, you need to increase this value.
>   The file inode-nr contains the first two items from
>   inode-state, so we'll skip to that file...
>   
> -Inode-state contains three actual numbers and four dummies.
> -The actual numbers are, in order of appearance, nr_inodes,
> -nr_free_inodes and preshrink.
> +Inode-state contains two actual numbers and five dummies.
> +The actual numbers are, in order of appearance, nr_inodes
> +and nr_free_inodes.
>   
>   Nr_inodes stands for the number of inodes the system has
>   allocated, this can be slightly more than inode-max because
>   Linux allocates them one pageful at a time.
>   
> -Nr_free_inodes represents the number of free inodes (?) and
> -preshrink is nonzero when the nr_inodes > inode-max and the
> -system needs to prune the inode list instead of allocating
> -more.
> +Nr_free_inodes represents the number of free inodes.
>   
>   
>   overflowgid & overflowuid
> 

