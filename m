Return-Path: <SRS0=hhxa=X4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4AEC4CED1
	for <selinux@archiver.kernel.org>; Thu,  3 Oct 2019 16:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0FBF2054F
	for <selinux@archiver.kernel.org>; Thu,  3 Oct 2019 16:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="GQyOSC4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406490AbfJCQy6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:54:58 -0400
Received: from USAT19PA22.eemsg.mail.mil ([214.24.22.196]:35264 "EHLO
        USAT19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406262AbfJCQwz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Oct 2019 12:52:55 -0400
X-EEMSG-check-017: 35162777|USAT19PA22_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.67,253,1566864000"; 
   d="scan'208";a="35162777"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 03 Oct 2019 16:52:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1570121573; x=1601657573;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=NcfdMLGSdwiFh2TLEDiZCZRDoueaqiacGcmG8ezqKd0=;
  b=GQyOSC4SfibRaCOjeChxSIOT8LibulEDHtl4c4UR5U8KcukIdacOBL8c
   ppVmGH3Xr1A+hMMGDHWQvNU99Qhxh1C1tLtJ7LhWdJzh6av50ADPBlIzf
   a4PwsXGXzK4+ZXRJp/BdExn/NMjQVeJ5fv1jrJbjU7SNDRvHCcupd1lpY
   keDE/iq5U8j9GWvCFcfxj8sXssCh0NrlkhJOupemw+VMC05Fj0SMfbzDL
   u3AE0eetFn5XXFLntLbZFawpG40kLm8L6N2xQ7Mo6Qxzojt3BNyaqdhao
   iqoauZZnyyYzxwAHBbFuwqvr5SofAGzjqACTMPQKbNjhx5tBpD4Zd7yb2
   A==;
X-IronPort-AV: E=Sophos;i="5.67,253,1566864000"; 
   d="scan'208";a="33715801"
IronPort-PHdr: =?us-ascii?q?9a23=3AvcPXuhL/nPvCKVRUOdmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXKv78rarrMEGX3/hxlliBBdydt6sfzbaG+Pm4AiQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagb75+Nhq7oAbeusULnYdvJLs6xw?=
 =?us-ascii?q?fUrHdPZ+lY335jK0iJnxb76Mew/Zpj/DpVtvk86cNOUrj0crohQ7BAAzsoL2?=
 =?us-ascii?q?465MvwtRneVgSP/WcTUn8XkhVTHQfI6gzxU4rrvSv7sup93zSaPdHzQLspVz?=
 =?us-ascii?q?mu87tnRRn1gyocKTU37H/YhdBxjKJDoRKuuRp/w5LPYIqIMPZyZ77Rcc8GSW?=
 =?us-ascii?q?ZEWMteWTZBAoehZIURCeQPM/tTo43kq1YAqRayAA+hD/7txDBVnH/7xbA03f?=
 =?us-ascii?q?ovEQ/G3wIuEdwBv3vWo9rpO6kfSvy1wavSwDnfc/9b1zXw5Y7VeR4hu/GMWr?=
 =?us-ascii?q?dwfNLMx0kzCQzFllWQppLjPziIy+oNtnKU7+5kVe2xi28stgZ8oiOyycc3kY?=
 =?us-ascii?q?TJmoIUxUzE9SV+2oo1I8a4R1Rhbd6rF5tQqTiXOo1rSc0hW2FloDs2x7IJtJ?=
 =?us-ascii?q?KhfCUG1Y4rywDQZvCZaYSE/xTuX/uLLzhinnJqYre/ig638Uin1+LzSNG50E?=
 =?us-ascii?q?1PripZitnMsW0N1wDL5siHVPR9+kCh1C6T1w/J8OFEIF00lbHBJ549wr8/ip?=
 =?us-ascii?q?oTsUPZEi/whEr2l7OZel8h+uip7+TrerTmppmCOI9okgzyL6sjl8OlDek4Lw?=
 =?us-ascii?q?QCRXaX9Oui2LH54EH1WLBKgec3kqndvpDaP8MbpquhDg9Oz4kj8A2yDyum0d?=
 =?us-ascii?q?sEnXkHK0hJeBScj4fzIV3OL/f4Demnj1S2jDhr3+zGPqHmApjVKXjDlbDhfa?=
 =?us-ascii?q?1760FG1AU808tS54hKBb4cIPL8QFPxuMbEAR8+Ngy+2/znB8ll1oMCRWKPBb?=
 =?us-ascii?q?eUMLjMvl+M5+IvJfSMZYAOtTbjJPgq+eTugWU6mVADZ6mp24UYaHSiEvRhOU?=
 =?us-ascii?q?WZbmLmgs0dHmcSogo+UOvqhUWaUTFJenayW7kx5ikhB4K7CYfPX4WtgLuG3C?=
 =?us-ascii?q?ehAJJafHxJCleJEX3wbYWLR+8MaD6OIs9mijEEUL2hRJUl1RGvtw/30KBnIf?=
 =?us-ascii?q?TJ9S0Yr53jyMJ56PHUlRE3pnRICJG61W2XQmM8u2QTQTY90aM39Ut4zUyF2K?=
 =?us-ascii?q?N1q+ZVGdxa+7VCVQJscdbHwuh7Dc3ichzOc83PS1u8RNiiRzYrQZZ5+9YTZw?=
 =?us-ascii?q?5YHNK4g1iXxyO3B5cNnqGPQZkz9bjRmXP2IpAu5WzB0fwak1Q+QsZJfVajj6?=
 =?us-ascii?q?p7+hmbU5XFiG2Fhq2qcuIaxyeL+2Cdmznd9HpEWRJ9BP2WFUsUYVHb+JGgvR?=
 =?us-ascii?q?LP?=
X-IPAS-Result: =?us-ascii?q?A2BhAABIJpZd/wHyM5BlGwEBAQEDAQEBDAMBAQGBVgMBA?=
 =?us-ascii?q?QELAYFzKoFAMiqEIo8qAQEBAQEBBoE2iXWRLAkBAQEBAQEBAQE0AQIBAYRAA?=
 =?us-ascii?q?oJFIzcGDgIMAQEBBAEBAQEBBQMBAWyFOYI6KQGCaAEFIwQRQRALDgoCAiYCA?=
 =?us-ascii?q?lcGAQwGAgEBgl8/gXcUrnp/M4VNgzGBSIEMKAGMDRh4gQeBESeCaz6EDYNEg?=
 =?us-ascii?q?lgEjF0PiTWBNJVjgi2CL5JjBhuZQC2NfptBI4FYKwgCGAghD4MnUBAUgVsXj?=
 =?us-ascii?q?j8lAzCBBgEBjgGCVAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 03 Oct 2019 16:52:52 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x93GqljJ004852;
        Thu, 3 Oct 2019 12:52:47 -0400
Subject: Re: [PATCH] selinux: fix context string corruption in
 convert_context()
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Cc:     Milos Malik <mmalik@redhat.com>
References: <20191003135922.29498-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <384722fe-a040-15c6-933b-1e2cf091b203@tycho.nsa.gov>
Date:   Thu, 3 Oct 2019 12:52:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191003135922.29498-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/3/19 9:59 AM, Ondrej Mosnacek wrote:
> string_to_context_struct() may garble the context string, so we need to
> copy back the contents again from the old context struct to avoid
> storing the corrupted context.
> 
> Since string_to_context_struct() tokenizes (and therefore truncates) the
> context string and we are later potentially copying it with kstrdup(),
> this may eventually cause pieces of uninitialized kernel memory to be
> disclosed to userspace (when copying to userspace based on the stored
> length and not the null character).
> 
> How to reproduce on Fedora and similar:
>      # dnf install -y memcached
>      # systemctl start memcached
>      # semodule -d memcached
>      # load_policy
>      # load_policy
>      # systemctl stop memcached
>      # ausearch -m AVC
>      type=AVC msg=audit(1570090572.648:313): avc:  denied  { signal } for  pid=1 comm="systemd" scontext=system_u:system_r:init_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=process permissive=0 trawcon=73797374656D5F75007400000000000070BE6E847296FFFF726F6D000096FFFF76
> 
> Reported-by: Milos Malik <mmalik@redhat.com>
> Fixes: ee1a84fdfeed ("selinux: overhaul sidtab to fix bug and improve performance")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/ss/services.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 3a29e7c24ba9..a5813c7629c1 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1946,7 +1946,14 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
>   		rc = string_to_context_struct(args->newp, NULL, s,
>   					      newc, SECSID_NULL);
>   		if (rc == -EINVAL) {
> -			/* Retain string representation for later mapping. */
> +			/*
> +			 * Retain string representation for later mapping.
> +			 *
> +			 * IMPORTANT: We need to copy the contents of oldc->str
> +			 * back into s again because string_to_context_struct()
> +			 * may have garbled it.
> +			 */
> +			memcpy(s, oldc->str, oldc->len);
>   			context_init(newc);
>   			newc->str = s;
>   			newc->len = oldc->len;
> 

