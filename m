Return-Path: <SRS0=TwHm=33=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F4BC04EB5
	for <selinux@archiver.kernel.org>; Fri,  7 Feb 2020 15:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD1520720
	for <selinux@archiver.kernel.org>; Fri,  7 Feb 2020 15:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="lXI6sznq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgBGPsj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Feb 2020 10:48:39 -0500
Received: from UPDC19PA21.eemsg.mail.mil ([214.24.27.196]:43850 "EHLO
        UPDC19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgBGPsi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Feb 2020 10:48:38 -0500
X-EEMSG-check-017: 56352021|UPDC19PA21_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,413,1574121600"; 
   d="scan'208";a="56352021"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 07 Feb 2020 15:48:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581090515; x=1612626515;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=VYJHgycuPWO/L2dcj6an2rSIm6IQDAIauZlSsglQpg4=;
  b=lXI6sznq+3V6vnjpANYJDrLk8rnyRaYJx9J6i0CIYnUAXJK2mY8twNH2
   8c3G0xuNdVyZED5nwNjyPK9NEuXwCu1wSqQSo7BIQiO+Zp3RJJGw3iiEd
   +PLYMSoqyfKNEKhKX56l8r7QMPZOx5vxpwKTVOQHrmVvtciuPLNiPyicM
   3UOJvGH54NaHZK8Q9W4AVS909+DlACPBffZ5NM2HHlwydq23C4efm61yx
   TzmMSSECv7fP5eSJ18jlnVsrSSCRZ55yyjOKkoYYyV/dila48KwyuL1K1
   aTvdVg0GFL6g/41xLLdnw9i+wOEzAJvSZiZOUXEOx8f3/cGRO35BS15za
   A==;
X-IronPort-AV: E=Sophos;i="5.70,413,1574121600"; 
   d="scan'208";a="32813247"
IronPort-PHdr: =?us-ascii?q?9a23=3AF5bNPh2B7FqqKfSXsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesQKf7xwZ3uMQTl6Ol3ixeRBMOHsq4C1red7PGoGTRZp8rY6zZaKN0Efi?=
 =?us-ascii?q?RGoP1epxYnDs+BBB+zB9/RRAt+Iv5/UkR49WqwK0lfFZW2TVTTpnqv8WxaQU?=
 =?us-ascii?q?2nZkJ6KevvB4Hdkdm82fys9J3PeQVIgye2ba9vIBmsogjdq8YbjZFiJ6sxxR?=
 =?us-ascii?q?fEoH9FcPlSyW90OF6fhRnx6tq+8ZJ57yhcp/ct/NNcXKvneKg1UaZWByk8PW?=
 =?us-ascii?q?Av483ruxjDTQ+R6XYZT24bjBlGDRXb4R/jRpv+vTf0ueR72CmBIM35Vqs0Vi?=
 =?us-ascii?q?i476dqUxDnliEKPCMk/W7Ni8xwiKVboA+9pxF63oXZbp2ZOOZ4c6jAZt4RW3?=
 =?us-ascii?q?ZPUdhNWCxAGoO8bpUAD+wdPeZDsoLxo0ICoQaiCQWwAe/izDFHhmXy3aYnze?=
 =?us-ascii?q?ovFw/I1xEkE94XvnnZqND5OaEPWu630abI1y3OYe5I1zfz6IbGcR4vrv+DUr?=
 =?us-ascii?q?1ybcXfxlIiFx/Hg1iKtYDpIz2Y2+YLvmOG7+RgT+Wvi2s/pg9svjig2N8sio?=
 =?us-ascii?q?nXiYIT11vK6CB5z5wxJd28VkF6YcOvHZxLty6HLIt7Wd8iQmF0tyY6zb0Ko5?=
 =?us-ascii?q?i7fDMQx5g9yB7fbOKHfpGO7xn+V+iROS91iG9qdb+wnRq/8VWsxvfiWsS7zl?=
 =?us-ascii?q?pGtDdJn9/RvX4XzRPT8NKISv5l80ek3jaAyh7c5/lfIUAxiarbM5khwqMslp?=
 =?us-ascii?q?YLsUTMACv2mELuga+KbEok4Omo6/n8Yrn8p5+cMYF0igblMqswhsOzG/g4Mw?=
 =?us-ascii?q?gSUGib/uSwzrvj8lHiQLpWlPE2l6jZsJTCKcQaoK62HRNV354+5xuwADqqyt?=
 =?us-ascii?q?QVkWQdIF5bdx+LkZLlN0zWLPD9F/i/glCskDlxx/DBO73sGo7NIWXYkLr6Yb?=
 =?us-ascii?q?Z861JTyAo0zdxF4ZJUEasOLOj8Wk/2qtzUFgU5PBCsw+b7FNV90ZsTWXmKAq?=
 =?us-ascii?q?+eKqPdr1uI6fgpI+aRf4IVtzH9K/8q5/7qk3A1g0MSfa6s3ZEPcnC3AuxmI1?=
 =?us-ascii?q?mFYXrrmtoBCX0Fvhc6TOHxkF2NSyNTZ3KrU6I54TE7D5imApnZSo+xh7yB2T?=
 =?us-ascii?q?+xHodKaWBeFlCMDXDoep2aVPcUci2SOM5hkicfWLi5UYAhzxCutBTiy7pjNO?=
 =?us-ascii?q?Xb5jMXuYjk1Nhv6O3ZjQsy+iBsD8SBz2GNSHl5nmAWSDAox6BwvUt9ylCA0a?=
 =?us-ascii?q?Vjn/NYFcZT5/RMUgc7KJ7cyvZ2C9foWgLOZt2JUkqpQs26ATEtSdI828UBY0?=
 =?us-ascii?q?BhG9WliBDOxDSlA7kSl7yOH5w0/bjQ33/rJ8Zy03zGzrUuj0E6QstTMm2rnr?=
 =?us-ascii?q?Jw+BTJB47OiEWZjL2ner4a3CHQ7meDymuOs1xCXAFsVqXFWGgVZlHKotTh+k?=
 =?us-ascii?q?PCU7iuBKw7MgtGz86DKrFGatn0jVpaR/fuI9XeY2Stm2iuARaE3K+DbI3ve2?=
 =?us-ascii?q?8FxiXSFFAEkxwP/XaBLQU+HTmuo2bfDDxoCFLubFjh8fdxqHylVE841QKKYF?=
 =?us-ascii?q?N717qz5BEVgeaQS/QJ3rILoC0hsSl7HE6h39LKDNqNvw5hfKRaYdMg71ZLzG?=
 =?us-ascii?q?HZuBJnPpymMa9igkUTcxp4v0zwzRV7EIZAntYwrHMs0gVyLbiU0FRbdzOXxZ?=
 =?us-ascii?q?rwIKHYKnHu/BCzbK7bwlLe38iM+qcJ9vs4r0zvvB23GUU49nVqyMNa032B6Z?=
 =?us-ascii?q?XQCwoSUI/+Xlwr+Bh9orHQejM96J/M1X1wLam0tSfP1M4uBOsjzBageM1fMK?=
 =?us-ascii?q?SfGQ/9FM0aAMeuKOg0lFSzch0EO+VSp+YIOJada/aY1ajjGeF6kTavi2gPtJ?=
 =?us-ascii?q?t41ViB8yN6RsbH2JEKx/ze1QyCAXO0lF68tujvkJ1AIDQVGXCyjyPjAcoZa7?=
 =?us-ascii?q?V7Z4cQIX+nOcys3tF3jJOrXGRXsBagCl4d08iuejKZb0b62AxN0AIQu3Pj0S?=
 =?us-ascii?q?K+0ztyuzwvqa+E02rJ2eumPBEMIGlQX0Fri1v2Jom4ydsdWQzgcw8vhV2h+E?=
 =?us-ascii?q?3576lduKl7aWLURAMAZCXyLmd/QoOuubeYJc1C8pUltWNQSuv4KVSbTKPt5h?=
 =?us-ascii?q?gXySXuG0NAyz0hMTKnoJP0m1p9km3ZZHV+tnzUfYRsyB7azNXaSeRW3zZATy?=
 =?us-ascii?q?592hfNAV3pBMWk5dWZkd/4t+m6U2+wHslIfTLD0ZKLtCz943ZjRxK4gabgyZ?=
 =?us-ascii?q?XcDQEm3HqjhJFRXiLSoUO5O9K62g=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DpAAAOhj1e/wHyM5BmGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBe4F9gW0gEiqEFYkDhmcGgRIliXCQdANUCQEBAQEBAQEBATcBAYRAAoJnO?=
 =?us-ascii?q?BMCEAEBAQQBAQEBAQUDAQFshUOCOykBgwEBAQEBAyMEEUEQCw4HAwICJgICV?=
 =?us-ascii?q?wYBDAYCAQGCYz+CVyWuG3V/M4VKg0KBPoEOKow9eYEHgTgMA4JdPoQSg0mCP?=
 =?us-ascii?q?CIEll9jRpdqgkSCTpN4BhubD45knTYiN4EhKwgCGAghD4MnUBgNnCxVIwMwj?=
 =?us-ascii?q?CWCQwEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 07 Feb 2020 15:48:34 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 017FlaaB067298;
        Fri, 7 Feb 2020 10:47:38 -0500
Subject: Re: [PATCH v2] security: selinux: allow per-file labeling for bpffs
To:     Steven Moreland <smoreland@google.com>, paul@paul-moore.com,
        eparis@parisplace.org, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Cc:     "Connor O'Brien" <connoro@google.com>
References: <20200206211430.150615-1-smoreland@google.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a4344c6a-3916-a119-1f5c-5c2129b415f9@tycho.nsa.gov>
Date:   Fri, 7 Feb 2020 10:49:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206211430.150615-1-smoreland@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/6/20 4:14 PM, Steven Moreland wrote:
> From: Connor O'Brien <connoro@google.com>
> 
> Add support for genfscon per-file labeling of bpffs files. This allows
> for separate permissions for different pinned bpf objects, which may
> be completely unrelated to each other.
> 
> Signed-off-by: Connor O'Brien <connoro@google.com>
> Signed-off-by: Steven Moreland <smoreland@google.com>

Is this relative to the next branch of the selinux git tree?
Doesn't apply for me.

> ---
>   security/selinux/hooks.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 116b4d644f68..d7b11188dc8d 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -750,7 +750,8 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>   	if (strcmp(sb->s_type->name, "proc") == 0)
>   		sbsec->flags |= SE_SBPROC | SE_SBGENFS;
>   
> -	if (!strcmp(sb->s_type->name, "debugfs") ||
> +	if (!strcmp(sb->s_type->name, "bpf") ||
> +	    !strcmp(sb->s_type->name, "debugfs") ||
>   	    !strcmp(sb->s_type->name, "tracefs") ||
>   	    !strcmp(sb->s_type->name, "pstore"))
>   		sbsec->flags |= SE_SBGENFS;
> 

