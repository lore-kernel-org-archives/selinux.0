Return-Path: <SRS0=qWI8=YK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53009FA372A
	for <selinux@archiver.kernel.org>; Thu, 17 Oct 2019 12:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9EA20854
	for <selinux@archiver.kernel.org>; Thu, 17 Oct 2019 12:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="DCqeoGkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbfJQMEb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 17 Oct 2019 08:04:31 -0400
Received: from USFB19PA33.eemsg.mail.mil ([214.24.26.196]:25183 "EHLO
        USFB19PA33.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfJQMEb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 17 Oct 2019 08:04:31 -0400
X-EEMSG-check-017: 18396017|USFB19PA33_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.67,307,1566864000"; 
   d="scan'208";a="18396017"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA33.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Oct 2019 12:04:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1571313870; x=1602849870;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=sIi8wxpKLvyo2rPRxIml0i514at/0x5tIOkYz8I9dr4=;
  b=DCqeoGkGsclM/OLQ9HJO+7NWbpdjDLt5sTpi7JPu3IM+NPjUvrkRL1M2
   q8vWWOpTnJXnFXf4d2IK/aLo0OxVBBxxUXwEcr2olFS9KZot/exToFJVu
   ljRF5Mh71JKlnwkny35yXOQ+AFV0h18GPtW5NnzAUu7mWN6P5oqxxBXJZ
   C0YOppyO+i9PCnJckQbeMyrVOfhRgIoCiv8MokbRemDrMJvJ5wQyLGCrb
   k47bN5h4xRhYQ2ZVBTnBzno+sG7xTMYtlMuHlIXp8aNU4DWZxMwK0G/6S
   tP2LL85b+vLykEOerymVoUPw3b1tR3Dm5q7MJ2ebo/YcYATFUJAhzmgEL
   g==;
X-IronPort-AV: E=Sophos;i="5.67,307,1566864000"; 
   d="scan'208";a="29078614"
IronPort-PHdr: =?us-ascii?q?9a23=3AXsig4hPoXsYZaIF2z/gl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0Ivz9rarrMEGX3/hxlliBBdydt6sfzbWJ+Py9EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCezbL9oLhi7rwrdu8YWjIB/Nqs/1x?=
 =?us-ascii?q?zFr2dSde9L321oP1WTnxj95se04pFu9jlbtuwi+cBdT6j0Zrw0QrNEAjsoNW?=
 =?us-ascii?q?A1/9DrugLYTQST/HscU34ZnQRODgPY8Rz1RJbxsi/9tupgxCmXOND9QL4oVT?=
 =?us-ascii?q?i+6apgVRHniD0DNzUk7m/ZjMJ+h79frB64pxFyx4vYbYeIP/R8Y6zdZ8sXS3?=
 =?us-ascii?q?dfUMZfVyJPAY2yYIUAAOUDIelWoJLwp0cMoBakGQWgGO3ixz1Oi3Tr3aM6ye?=
 =?us-ascii?q?MhEQTe0QI9A9IBrmzUrNXrO6cUTOu70azIwi/Hb/NSxzj86JXDfxc6of6RRr?=
 =?us-ascii?q?J9atbRyEkzGAPFiVWcs4rlPyiP2egXvGib6PRgWPuphmU6qA9xuiCiytojh4?=
 =?us-ascii?q?TGnI4Yyk3I+T9nzIs6O9G0UlN3bNi5G5VKrS6aLZF5QsY6TmFtvyY116MJtI?=
 =?us-ascii?q?agfCgP1JQn3xnfa+Gbc4SQ4hLsSuKRITBgiXJ5Yr2/nRey8VW7yuHmSsm10E?=
 =?us-ascii?q?pFripCktXWsHACywfT5dSdRvt4/0eh3S6D1wHV6u5aPUA5jbfXJpEuz7Iqlp?=
 =?us-ascii?q?cfrF7PEjH5lUnolqOaa10o+u2y5OTmZrXmqIWcN4hxigzmKaQhh9e/DP8kMg?=
 =?us-ascii?q?kOQ2eb+eO82Kfl/U3iWrpGlPI2kq7HsJzCP8QUura5AxNJ0oYk8xu/FCmp0N?=
 =?us-ascii?q?AZnXkBMVJEdwmKj5bmO17QOvD0F/S/jEq2kDdt2f/GOqftApLXLnjMiL3hZ6?=
 =?us-ascii?q?py61ZAyAovytBS/4pUBascIPL3QULxrMbXDgI9MwCtxubnD9J91pkAVm6VHq?=
 =?us-ascii?q?CZN6bS4he04bc0Lu2NYpIFkCjyJuJj5PP0i3I931gHcvqHx5wSPUukE+xmLk?=
 =?us-ascii?q?PRWn/lhtMMAC9epQYlZPD7g12FFzhIbjC9WLxqtWJzM56vEYqWHtPlu7eGxi?=
 =?us-ascii?q?ruW8AHaw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CmAQCMV6hd/wHyM5BlHAEBAQEBBwEBEQEEBAEBgWoEA?=
 =?us-ascii?q?QELAYFzLIFAMiqEJY86BoE2iXmRLwkBAQEBAQEBAQE0AQIBAYRAAoMDJDcGD?=
 =?us-ascii?q?gIMAQEBBAEBAQEBBQMBAWyFOYI6KYJoAQEBAQIBIwQRQRALGAICJgICVxMGA?=
 =?us-ascii?q?gEBgl8/glMFIK5ldX8zhU2DMYFIgQwoAYwNGHiBB4E4gms+hA2BBIJBgl4El?=
 =?us-ascii?q?i+XIoIsgjKSaQYbmUapfiOBWCsIAhgIIQ+DJ1AQFJAyJQMwgQYBAY1iglQBA?=
 =?us-ascii?q?Q?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 17 Oct 2019 12:04:28 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9HC4RXv010061;
        Thu, 17 Oct 2019 08:04:28 -0400
Subject: Re: [RFC PATCH 11/10] selinux: fix support multiple selinuxfs
 instances
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com
References: <20191016182815.3188-1-sds@tycho.nsa.gov>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <c2db4c56-b4b2-e1b1-5f87-69d46a2b933b@tycho.nsa.gov>
Date:   Thu, 17 Oct 2019 08:04:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191016182815.3188-1-sds@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/16/19 2:28 PM, Stephen Smalley wrote:
> When I rebased the "selinux: support multiple selinuxfs instances"
> patch, I misunderstood the vfs get_tree_keyed() interface and thought
> it eliminated the need for our own custom get_tree() implementation.
> However, it turns out that we cannot use get_tree_keyed() because we
> are already using sb->s_fs_info to store per-instance data and
> get_tree_keyed() uses it for the key.  The resulting behavior was
> that a unique superblock was being created for every selinuxfs mount,
> even within the same selinux namespace, which is not desirable.
> Restore the old logic adapted for the relevant vfs changes.
> 
> This should likely be squashed into the original commit before final
> upstreaming.

FYI, I squashed this into the original commit introducing multiple 
selinuxfs instances and pushed it to the branch.

> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>   security/selinux/selinuxfs.c | 26 +++++++++++++++++++++++++-
>   1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 1ba4d874fc86..6bb0c1611e6f 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -2102,9 +2102,33 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
>   	return ret;
>   }
>   
> +static int selinuxfs_compare(struct super_block *sb, struct fs_context *fc)
> +{
> +	struct selinux_fs_info *fsi = sb->s_fs_info;
> +
> +	return (current_selinux_ns == fsi->ns);
> +}
> +
>   static int sel_get_tree(struct fs_context *fc)
>   {
> -	return get_tree_keyed(fc, sel_fill_super, current_selinux_ns);
> +	struct super_block *sb;
> +	int err;
> +
> +	sb = sget_fc(fc, selinuxfs_compare, set_anon_super_fc);
> +	if (IS_ERR(sb))
> +		return PTR_ERR(sb);
> +
> +	if (!sb->s_root) {
> +		err = sel_fill_super(sb, fc);
> +		if (err) {
> +			deactivate_locked_super(sb);
> +			return err;
> +		}
> +		sb->s_flags |= SB_ACTIVE;
> +	}
> +
> +	fc->root = dget(sb->s_root);
> +	return 0;
>   }
>   
>   static const struct fs_context_operations sel_context_ops = {
> 

