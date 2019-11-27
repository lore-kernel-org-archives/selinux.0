Return-Path: <SRS0=LgiC=ZT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC332C432C0
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 15:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817342053B
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 15:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="P9Wszmo9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfK0PV7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:21:59 -0500
Received: from UCOL19PA34.eemsg.mail.mil ([214.24.24.194]:46413 "EHLO
        UCOL19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfK0PV7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Nov 2019 10:21:59 -0500
X-EEMSG-check-017: 55382846|UCOL19PA34_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,249,1571702400"; 
   d="scan'208";a="55382846"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Nov 2019 15:21:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574868117; x=1606404117;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=z3IFdR6RwubbD4TGMNibKLP1PedKZNxZ30ATFghFGyc=;
  b=P9Wszmo9eykN068C+j5TG8Y1QfbDjlhFQfbdPc6DL2Czy/QMQ+hpT0o7
   sGBK0drs2r4SWPlqO8Wo7AS2bfnKp9IN9OuX0yx8qxeW2mtqoZ7qWr6y5
   ZMNN11mactniK5RIBT/q3AyzUzLORHVNzmIl4k+yfO5cJijETEgRwARBF
   8MlvGcny9H2brKUSXr8GQFm7/ULeBSb7VYNg/9rQ/31sy1pngXOuLdGyZ
   W0yKWNN3uDM4lR9IyH8a4/EP3eKqrgDsIZF3dEo9PdSC5WB8zrSGh5Ne3
   0AdofZP3jmlE1+NvqRP0trcCXeZM+dhvxx/C3z3bOKgqOuce0OKTlAERb
   w==;
X-IronPort-AV: E=Sophos;i="5.69,249,1571702400"; 
   d="scan'208";a="36084638"
IronPort-PHdr: =?us-ascii?q?9a23=3AdyoFfBxI0ClQeivXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2uoWIJqq85mqBkHD//Il1AaPAdyArasa1qGJ6+jJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVijexe65+IRS2oAnetMQanZZpJ7osxB?=
 =?us-ascii?q?fOvnZGYfldy3lyJVKUkRb858Ow84Bm/i9Npf8v9NNOXLvjcaggQrNWEDopM2?=
 =?us-ascii?q?Yu5M32rhbDVheA5mEdUmoNjBVFBRXO4QzgUZfwtiv6sfd92DWfMMbrQ704RS?=
 =?us-ascii?q?iu4qF2QxLzliwJKyA2/33WisxojaJUvhShpwBkw4XJZI2ZLedycr/Bcd8fQ2?=
 =?us-ascii?q?dOUNxRVyhcCY2iaYUBAfcKMeJBo4Tzo1YCqB2zDhSuCuzy0D9FnmL407M00+?=
 =?us-ascii?q?ohEg/I0gIvEN0Mv3vIo9v4L7sSXOKvwaXU0TnOYfFb1DHg44bIaBAhpvSMUK?=
 =?us-ascii?q?ptf8rN10YvDwPFgUuWqYf4Ij2V0/4Cs2yf7+V+VeOklmkqqxpsrTi03coslo?=
 =?us-ascii?q?nIiZ4VylDD7yl5xp01KseiRE50Zt6kDoJduieHPIV1WsMvW3xktSk1x7EcuZ?=
 =?us-ascii?q?O3YTIGxIooyhLBcfCLbo6F6Q/5WumLOzd3nndldaq6hxa17Eev1PXxVtKx0F?=
 =?us-ascii?q?ZWtipFlcTMtmwV2xzT9MeHTvx981+92TmVzQDT6/xEIVsumaraLZ4hzLkwlo?=
 =?us-ascii?q?ENvkvfBCP2hEX3g7OWdkUj4OSo7fjoYq76qZOGMo90iwX+Prwvmsy5H+s4Lh?=
 =?us-ascii?q?ADU3WU9OmzzrHu/VD1TK9UgvA5jKXVqo3WKdwepqGjAg9V1ogj6wy4DzejyN?=
 =?us-ascii?q?kYhmQILEledRKbj4nmJ1HOIPfiAfe5mFSjii1nx//BPr3/GpnNNGTMkK/9fb?=
 =?us-ascii?q?Zh7E5R0BIzwspC55JQEbwBOOj8WlL1tNDBCx85NAu0w/z5B9lnyoweXmePCL?=
 =?us-ascii?q?eDMKzOqV+I+v4vI+6UaY8Opjn9L/kl5/jzjX42glIdY6ap0oUNaHyiHfRpPV?=
 =?us-ascii?q?+ZYXzyjdcFC2sKuRA+TOO5wGGFBAZaenL6eqU7/DxzXJqvEIPrXomwhPmE2y?=
 =?us-ascii?q?ChE9tdYWUQThiXHHPpcZiUc+kDZTjUIcJ7lDEAE7+7RNwPzxar4TTmxqJnI+?=
 =?us-ascii?q?ycwSgRsZbuxZAh/OHIvQ0j/jxzScKG2ieCSH8izTBAfCM/wK0q+R818VyEy6?=
 =?us-ascii?q?UtxqUDRNE=3D?=
X-IPAS-Result: =?us-ascii?q?A2DFAABAk95d/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfoF0gRhVIBIqhCuJA4ZaBoE3iWmRRAkBAQEBAQEBAQEjFAEBhEACgiQ4E?=
 =?us-ascii?q?wIQAQEBBAEBAQEBBQMBAWyFNwyCOykBgm0BAQEBAyMVUQsVAwICJgICVwYBD?=
 =?us-ascii?q?AYCAQGCXz8BglIlsWZ1gTKFT4NDgUiBDiiMMHmBB4E4D4JdPoQSg0eCXgSWY?=
 =?us-ascii?q?0aXEII3gjmEZI4zBhuCQHOWbI5IgUKaYyKBWCsIAhgIIQ87gmwJRxEUjkOGa?=
 =?us-ascii?q?SMDMIt8gkEBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 27 Nov 2019 15:21:56 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xARFLp42014516;
        Wed, 27 Nov 2019 10:21:51 -0500
Subject: Re: [PATCH] selinux-testsuite: update the dependencies in README.md
To:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
References: <157486604069.70468.14139138243381994891.stgit@chester>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <b1ccb584-369d-92d6-b5a9-1bd6fd52ecf4@tycho.nsa.gov>
Date:   Wed, 27 Nov 2019 10:22:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <157486604069.70468.14139138243381994891.stgit@chester>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/27/19 9:47 AM, Paul Moore wrote:
> From: Paul Moore <paul@paul-moore.com>
> 
> The new kernel module tests added in a68d583c2a70 ("selinux-testsuite:
> Add kernel module tests") require the kernel-devel package on Fedora,
> make sure we list that in the README.md file.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   README.md |    4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/README.md b/README.md
> index e845df8..4352796 100644
> --- a/README.md
> +++ b/README.md
> @@ -53,6 +53,7 @@ similar dependencies):
>   * attr _(tools used by the overlayfs tests)_
>   * libbpf-devel _(tools used by the bpf tests)_
>   * keyutils-libs-devel _(tools used by the keys tests)_
> +* kernel-devel _(used by the kernel module tests)_
>   
>   On a modern Fedora system you can install these dependencies with the
>   following command:
> @@ -69,7 +70,8 @@ following command:
>   		lksctp-tools-devel \
>   		attr \
>   		libbpf-devel \
> -		keyutils-libs-devel
> +		keyutils-libs-devel \
> +		kernel-devel
>   
>   The testsuite requires a pre-existing base policy configuration of SELinux,
>   using either the old example policy or the reference policy as the baseline.
> 

