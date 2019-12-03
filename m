Return-Path: <SRS0=8r5V=ZZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF28C432C0
	for <selinux@archiver.kernel.org>; Tue,  3 Dec 2019 15:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38532073C
	for <selinux@archiver.kernel.org>; Tue,  3 Dec 2019 15:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="BgsolOZ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfLCPPW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 Dec 2019 10:15:22 -0500
Received: from USAT19PA20.eemsg.mail.mil ([214.24.22.194]:44429 "EHLO
        USAT19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfLCPPW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 Dec 2019 10:15:22 -0500
X-EEMSG-check-017: 56442129|USAT19PA20_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,273,1571702400"; 
   d="scan'208";a="56442129"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 03 Dec 2019 15:15:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1575386102; x=1606922102;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=7CjzItRHIN6Ec4kkmWekTYfAdAbstFbXI5ZB+bqhtik=;
  b=BgsolOZ3CBHNgJxAT6LkISQLd5RRN4t8LBfzeVBZUm0EbJuq9ZnOuRk+
   Xkzezr4VwCN+4la21mCYo0V+ZRpvoYZY/Z/qaZxoS8aRcorqRSPqxQfbw
   3DBddSoailXiVytxbFlHImmnioWgnDSkwxLYpm7Zo5f+opVBob+UyDVXv
   2lwgDE6zw3XnX5tkC/EU/qNt8pmz7fGbqGCVjdkoj5jEzkTLGqh9HcJad
   AiYtT/+jxQk/1rkgs3ExtZyfi6KSlmGgtOMVzwBBXq7FruK/QfwhZA/h/
   FYC5I8stx3Q/ouL8QntmrXaDwe0GWnYX+gATgPCwGv/g9H6omoFjkrdsM
   w==;
X-IronPort-AV: E=Sophos;i="5.69,273,1571702400"; 
   d="scan'208";a="30690824"
IronPort-PHdr: =?us-ascii?q?9a23=3Ahl4ctRBayqCuK5r3T9GlUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPX/p8bcNUDSrc9gkEXOFd2Cra4d0KyP7P+rBjdIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+roQjTtMQajolvJ6gswR?=
 =?us-ascii?q?bVv3VEfPhby3l1LlyJhRb84cmw/J9n8ytOvv8q6tBNX6bncakmVLJUFDspPX?=
 =?us-ascii?q?w7683trhnDUBCA5mAAXWUMkxpHGBbK4RfnVZrsqCT6t+592C6HPc3qSL0/RD?=
 =?us-ascii?q?qv47t3RBLulSwKLCAy/n3JhcNsjaJbuBOhqAJ5w47Ie4GeKf5ycrrAcd8GWW?=
 =?us-ascii?q?ZNW8BcWCJbAoO4coABEewPM+hFpIX5vlcDox+zCQyqCejyyDFHm2X20LUn3e?=
 =?us-ascii?q?o/HwHI3A8uEdwAv3vbrtr6KKgcXPupzKTK1zjPc+9a1Dn/5YXObxsvoeuMXb?=
 =?us-ascii?q?V1ccfJ1EcvCx3Kjk2QqYP7OTOey/kDs22B4OpkUeKglW4moBx2rzi028gskZ?=
 =?us-ascii?q?LEhp4Vy1/Y9SV5x5w5JdujSEFhe9KkH5xQtz+DOoZwX8gsQHlotT4nxrAJtp?=
 =?us-ascii?q?O3ZigHxIk9yxLBZPGLbZKE7g/lWe2MOzl3nmhld6i6hxuq9EigzfDzWdes3V?=
 =?us-ascii?q?ZRqypFjsHMtncQ1xzP8sSHSuVy/kOm2TuXywDc8PtEIUEplarAMZIhw7gwlp?=
 =?us-ascii?q?QUsUTYACD5hF/6jLOWd0o4+uio7P7rYrP6qZ+HK4B4kAT+MqUqmsCnAOQ4NB?=
 =?us-ascii?q?YBX3SD9Oih27Du8lf1TbVXgvEsjKXUv47WKd4GqqKhBg9ayIcj6xKxDze819?=
 =?us-ascii?q?QYmGEKLElYdxKclIXpJ1HPL+z4Dfe4mVislixryOrcMr3uBZXNMGDPkK39cr?=
 =?us-ascii?q?Zl905c1A0zwMhF55JVFr4BIOj8WlXsu9PAEhA2Kwy0zPzmCNV7yIweQnmCDb?=
 =?us-ascii?q?SFMKPTt1+I+vwgI/OKZIALpDbxMeQq5/nrjXUhg18SYbGp3YcLaHC/BvlmOF?=
 =?us-ascii?q?uWYX7tgtcHDGcLsREzTPLliFKcSz5ffXWyULwm5jE9Fo2mCZ3PRoe3gLyOj2?=
 =?us-ascii?q?+HGchsZ2tGA0qAWVfhdoOJQL9YciOZIsZ7ngsPYrioSokszjmkqA7817d9KO?=
 =?us-ascii?q?fIvCYfsMSnnMN44+zViAEa6zN5FYKe3nuLQmUymXkHFBEs26UqmlBw0leO1+?=
 =?us-ascii?q?BDhvVcEdFCr6dSXhwSKY/Xz+s8Dcv7HA3GYIHaGx6dXty6DGRpHZoKyNgUbh?=
 =?us-ascii?q?M4Qo7zgw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DaAwAOe+Zd/wHyM5BlHAEBAQEBBwEBEQEEBAEBgX4Cg?=
 =?us-ascii?q?XKBbAEgEiqEK4kDhlkBAQEBAQEGgRIliWmRRAkBAQEBAQEBAQE3AQGEQAKCM?=
 =?us-ascii?q?TkFDQIQAQEBBAEBAQEBBQMBAWyFQ4I7KQGCbQEBAQECASMVRgsLGAICJgICV?=
 =?us-ascii?q?wYBDAYCAQGCXz+CRwMJBSCwFXWBMoVPgyuBSIEOKAGML3mBB4E4DAOCXT6CG?=
 =?us-ascii?q?4U+gl4ElmtGlxKCOII5kxoGG5okLY4dnC8hgVgrCAIYCCEPgydQERSbSiMDM?=
 =?us-ascii?q?JF5AQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 03 Dec 2019 15:15:01 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xB3FEpY9180714;
        Tue, 3 Dec 2019 10:14:53 -0500
Subject: Re: [PATCH 1/1] selinux-testsuite: Add perf_event tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
References: <20191201145238.265621-1-richard_c_haines@btinternet.com>
 <20191201145238.265621-2-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a715e047-7973-2847-96c4-5f26cd29adb2@tycho.nsa.gov>
Date:   Tue, 3 Dec 2019 10:15:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191201145238.265621-2-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/1/19 9:52 AM, Richard Haines wrote:
> Test perf_event permissions.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---

> diff --git a/policy/test_perf_event.te b/policy/test_perf_event.te
> new file mode 100644
> index 0000000..8b612bc
> --- /dev/null
> +++ b/policy/test_perf_event.te
<snip>
> +neverallow test_perf_no_admin_t self:capability { sys_admin };

I don't particularly object to this, but I wanted to note that these 
neverallows are not being checked by default (expand-check=0 in 
/etc/selinux/semanage.conf) and in fact, if one were to enable 
expand-check, it would not be possible to insert the test policy module 
without triggering some neverallow and/or typebounds failures because 
the test policy intentionally violates such invariants at points.

Even the base Fedora policy doesn't appear to pass neverallow checking 
at present; if you enable expand-check=1 in /etc/selinux/semanage.conf 
and semodule -B, it fails (at least for me).

So your neverallow rules in the test policy are at best documentation.
