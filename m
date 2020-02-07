Return-Path: <SRS0=TwHm=33=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47274C2BA83
	for <selinux@archiver.kernel.org>; Fri,  7 Feb 2020 18:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E89220726
	for <selinux@archiver.kernel.org>; Fri,  7 Feb 2020 18:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Uk5qSdvR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgBGSLj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Feb 2020 13:11:39 -0500
Received: from UPDC19PA23.eemsg.mail.mil ([214.24.27.198]:21480 "EHLO
        UPDC19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgBGSLj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Feb 2020 13:11:39 -0500
X-EEMSG-check-017: 56597871|UPDC19PA23_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,414,1574121600"; 
   d="scan'208";a="56597871"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 07 Feb 2020 18:11:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581099094; x=1612635094;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=K7jj1GrHZg8AAeT/X2O4ajUwp0SOVaygIuVhfSYglgg=;
  b=Uk5qSdvRiAaLj5pn+tyIKaDGubRmJKFPcRrihW3VKC9r24qK0N/lnMKd
   CWjbVXQDB/0IdB8KNZ+4pvjTf9nFTTy9XXVNguBKrFPy/dmAkN8/2GsHl
   3JIPAGMSG9unhDIeLNh0RzQRmR4QbxY6MdyHjl2tiEfq18hYN5+rq55/X
   KQdY9S/YZAAfNDeN6aE+IqJ8SIyU5KrUcGXPtsSRwbo9rJh1JXFP8tw79
   gof3bDCpW2mZz5JnH5geKJJQR0nAd4sX+NxoEPOpe5/y+OX2KvJ4Q93UX
   twXT5lZhaoPTtsi98y+DNt6cKRDgbw+0wCaN0ThQ/q22Gk8fSus9oiGHf
   w==;
X-IronPort-AV: E=Sophos;i="5.70,414,1574121600"; 
   d="scan'208";a="32823065"
IronPort-PHdr: =?us-ascii?q?9a23=3Af6Z2aRIIWs2Eb6i8+tmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXLP/+rarrMEGX3/hxlliBBdydt6sYzbeL+Pm4CSRAuc/H7ClZNsQUFl?=
 =?us-ascii?q?cssoY/p0QYGsmLCEn2frbBThcRO4B8bmJj5GyxKkNPGczzNBX4q3y26iMOSF?=
 =?us-ascii?q?2kbVImbuv6FZTPgMupyuu854PcYxlShDq6fLh+MAi6oR/eu8ULjoZuMKY8xx?=
 =?us-ascii?q?vGrndVZ+hbxn5jKVaPkxrh/Mu984Nv/ipKt/4968JMVLjxcrglQ7BfEDkoKX?=
 =?us-ascii?q?0+6tfxtRnEQwuP538cXXsTnxFVHQXL7wz0U4novCfiueVzxCeVPcvtTbApQj?=
 =?us-ascii?q?ui9LtkSAXpiCgcKTE09nzch9Fqg6JapBKhoAF/w5LRbYqIOvdyYr/RcNUHTm?=
 =?us-ascii?q?daQM1fSzJODZ+9b4sXDuoOI+BYr5Xmp1ATqReyHBSgCP/zxjNNgHL507c60+?=
 =?us-ascii?q?A8Gg/Y2gIuEc8FvHDNoNj7MKoeVOa4x7TKwzredfNbwSrz5pbGch4hov+CU7?=
 =?us-ascii?q?x/fsXTxkYzGA3IlUmQpI7/Mj+JyugAvWqW4ux9XuyvkW4nrARxryCyyMcwlI?=
 =?us-ascii?q?bJnoIVxU7C9S5k3Yg1IMe3SEp/YdG6EJpbqiaXN5BrTcM5WGxopCY7xaEGuZ?=
 =?us-ascii?q?68ZiQKzo8nyATFZ/yIdIiI/AvuWeCMKjl7nHJoYK+zihm9/ES6yuDwS9O43E?=
 =?us-ascii?q?hFoyZbiNXAq3YA3AHJ5MedUPty5EKh1C6K1wDU9+5LP1g5lbHeK5492r4wkY?=
 =?us-ascii?q?cTsVjbEi/2hkr2iKiWe104+uey8eTnY6jmpoSGO491jAH+PKMumtehDuskKA?=
 =?us-ascii?q?QOQ2ia9vi81L3k50H5RqlFjuYqnaXDtZDaJMAbqra4Aw9TzIkj9w6yAyqp3d?=
 =?us-ascii?q?kXh3UKLE9JdAiZg4XmJV3COu30Ae+6g1u2kTdrw/7GPqfmApXINnXDi6rufa?=
 =?us-ascii?q?1m5k5AyAs80dBf55VOBrEHO/L8QFX9tNPfDh8nKwC02froCM1h1oMCXmKCGr?=
 =?us-ascii?q?SZMKbVsV+S+O0vJ/ODZIkItzvmJPgl4PnujXA9mVADZ6WmwZwXaHWgFPR8P0?=
 =?us-ascii?q?qZeWbsgssGEWoSpgoxVvHqiFmZXD5LfXmyQqY86ig+CIKhCofDXJ6ijKad0y?=
 =?us-ascii?q?e8G51cfnpGBUyUEXf0a4WEXO8BZzyKIsB7iDwEVKOhRpQ51R60rg/6yqFnLv?=
 =?us-ascii?q?LQ+iICqZ3sysJ55+rJlRE97TZ0FdiS03mRT2FomWMFXzw2075hrkxm1liD1q?=
 =?us-ascii?q?94g/9DGNNP5/NJSAA6NZvdz+xnDtD+QAXBfs2GSFy+WNWpHSkxTs4tw98Je0?=
 =?us-ascii?q?tyAdOijgzE3yqsGLIaibqLBJsx8qLH0Hj9PcF9y2zJ1KM5lVkpXtNPNXG6hq?=
 =?us-ascii?q?547wXcG5LGk1+el6axbqQRxzTC9GGewmqUu0FYURN/Xb/ZUnAYY0vctc756V?=
 =?us-ascii?q?/aT7+yFbQnNRNMydKFKqtMatzll1FGROr/N9TdeG+xmmGwBQqWybOIdoblZ2?=
 =?us-ascii?q?Id3CDFAkgejw8T5WqGNRQ5Biq5uGLREjhuFVPpY0Px/uhzs227TkAqwAGQdU?=
 =?us-ascii?q?Fh1KS6+gQThfOCT/MfxLUEuD0uqz9sBlayw8rWC8acpwpmZKhcZdI94FFa1W?=
 =?us-ascii?q?PWrgB9PYKvL7pkhlEAdwR6pF3u1xppBYVai8Qqr20lzBB0Ka2G1FNNbTSY3Y?=
 =?us-ascii?q?r/OrfPMGn94Aiva7LK2lHZyNuW+bkA6O4+q1r9uAGlD1Yi/Gt93NlQyHaT/J?=
 =?us-ascii?q?PKAxcIUZL2U0Y46gJ2qK3dYik4/4nUz2FjMbGosj/e3NIkHPcqyhGmf9dZN6?=
 =?us-ascii?q?OEDgjyHtYVB8ipL+wqlFypYQweMO9O8640OpDuS/zT47KmIutm1Behl2lD6Y?=
 =?us-ascii?q?ZxmhaX8i1mR+rB2ZotzPaf0Q+KETz7iQHl+tj+hIRsfTgPGi+6zi/+CchaYa?=
 =?us-ascii?q?g2NYsTAH2vOOWvz89/nIbpUnVVslm5CBdO28KkYhGVaF/V1g1K0kEWvHnhnj?=
 =?us-ascii?q?G3i3R9lS0uqIKS2ivL2OukcwAIfiZAT3NllkzEKI64ldcbUA6jaA1t3Aei41?=
 =?us-ascii?q?e8w7VQp4x+KXXeRQFDeC2yZ3pvVqq2q6qqfcFC8tUrvD9RXeD6ZkqVDvb5oh?=
 =?us-ascii?q?0Hw2bgEnFYyTQTaT6noNP6kgZ8hWbbK2x86DLadNt2yBOa+NHVQNZY2DYcQy?=
 =?us-ascii?q?h0zzLQAwuSJd6sqO6Imo/Dv+b2bGeoUpleYGG/1o+bnDeq7m1tRxuklra8nc?=
 =?us-ascii?q?OxQlty6jPyy9Q/DXaAlx37eIS+kv3hYO8=3D?=
X-IPAS-Result: =?us-ascii?q?A2DpAADwpz1e/wHyM5BmGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBe4F9gW0gEiqEFYkDhmcGgTeJcJB0A1QJAQEBAQEBAQEBNwEBhEACgmc4E?=
 =?us-ascii?q?wIQAQEBBAEBAQEBBQMBAWyFQ4I7KQGDAQEBAQEDIwQRQRALDgcDAgImAgJXB?=
 =?us-ascii?q?gEMBgIBAYJjP4JXJa5ddX8zhUqDbIE+gQ4qjD15gQeBOA+CXT6HW4I8IgSWX?=
 =?us-ascii?q?2NGl2qCRIJOk3gGG5sPjmSdNiI3gSErCAIYCCEPgydQGA2cLFUjAzCOaAEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 07 Feb 2020 18:11:05 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 017IA9pv143157;
        Fri, 7 Feb 2020 13:10:09 -0500
Subject: Re: [PATCH v3] security: selinux: allow per-file labeling for bpffs
To:     Steven Moreland <smoreland@google.com>, paul@paul-moore.com,
        eparis@parisplace.org, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Cc:     "Connor O'Brien" <connoro@google.com>
References: <20200207180148.235161-1-smoreland@google.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <63fdead2-bb8d-55ea-2d8f-41fc90d036d8@tycho.nsa.gov>
Date:   Fri, 7 Feb 2020 13:12:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200207180148.235161-1-smoreland@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/7/20 1:01 PM, Steven Moreland wrote:
> From: Connor O'Brien <connoro@google.com>
> 
> Add support for genfscon per-file labeling of bpffs files. This allows
> for separate permissions for different pinned bpf objects, which may
> be completely unrelated to each other.
> 
> Signed-off-by: Connor O'Brien <connoro@google.com>
> Signed-off-by: Steven Moreland <smoreland@google.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/hooks.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d9e8b2131a65..18f8cd47729c 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -699,6 +699,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>   	if (!strcmp(sb->s_type->name, "debugfs") ||
>   	    !strcmp(sb->s_type->name, "tracefs") ||
>   	    !strcmp(sb->s_type->name, "binderfs") ||
> +	    !strcmp(sb->s_type->name, "bpf") ||
>   	    !strcmp(sb->s_type->name, "pstore"))
>   		sbsec->flags |= SE_SBGENFS;
>   
> 

