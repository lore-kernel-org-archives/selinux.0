Return-Path: <SRS0=B3ih=24=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2B2C33C8C
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 14:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F0424672
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 14:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="YuRPwpiv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgAGOej (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:34:39 -0500
Received: from UPDC19PA22.eemsg.mail.mil ([214.24.27.197]:30438 "EHLO
        UPDC19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbgAGOei (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jan 2020 09:34:38 -0500
X-EEMSG-check-017: 43235837|UPDC19PA22_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,406,1571702400"; 
   d="scan'208";a="43235837"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 07 Jan 2020 14:34:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578407675; x=1609943675;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=+MWYRoxjal3X7JxFXQTJX8Kvm7U+Yis9a3n8KU+Veoc=;
  b=YuRPwpivbVA7l71uWt3PCmrUxb6Bg5t/vFm7wqL10bLnWZq1v0isVgeU
   +cif/ywmaDq07l0mbzjHw1EDbQI7HlE07+JdlcP2ivIYyOtj/bazgnqgN
   LKjgaQ1cA7dJW79Pv3IZfMO+X4yQAAoAJMUl1VVydmq4B7Pd1mQYH5t2/
   0XVduCLrceHiFUbDaR/dy2EGR5rI89wpejXLamUWq7BrNBAWj3vBSAoB6
   Cj8N3jOn3GZL4ckP3fLptTrk/E169PqOIDL7H9XgFiN4Xb+tsJrBhgHkV
   nflxr/z0740wsBF14BzYqGf3hlbHMaQ7wx67zKh5i5CnW9PLmcwgvY3+R
   g==;
X-IronPort-AV: E=Sophos;i="5.69,406,1571702400"; 
   d="scan'208";a="31666708"
IronPort-PHdr: =?us-ascii?q?9a23=3AnIi/mBCG0ydHj2SSOd4yUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPXyp8bcNUDSrc9gkEXOFd2Cra4d0KyM7vyrADNIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+ooQjRucQajpZuJ6QswR?=
 =?us-ascii?q?bVv3VEfPhby3l1LlyJhRb84cmw/J9n8ytOvv8q6tBNX6bncakmVLJUFDspPX?=
 =?us-ascii?q?w7683trhnDUBCA5mAAXWUMkxpHGBbK4RfnVZrsqCT6t+592C6HPc3qSL0/RD?=
 =?us-ascii?q?qv47t3RBLulSwKLCAy/n3JhcNsjaJbuBOhqAJ5w47Ie4GeKf5ycrrAcd8GWW?=
 =?us-ascii?q?ZNW8BcWCJbAoO4coABEewPM+hFpIX5vlcCsx+zCQyqCejyyDFHm2X20LUn3e?=
 =?us-ascii?q?o/HwHI3A8uEdwAv3vbrtr6KKgcXPupzKTK1zjPc+9a1Dn/5YXObxsvoeuMXb?=
 =?us-ascii?q?V1ccfJ1EcvCx3Kjk2QqYP7OTOey/kDs22B4OpkUeKglW4moBx2rzi028gskZ?=
 =?us-ascii?q?LEhp4Vy1/Y9SV5x5w5JdujSEFhe9KkH5xQtz+DOoZwX8gsQHlotT4nxrAJtp?=
 =?us-ascii?q?O3ZigHxIk9yxLBZPGLbZKE7g/lWe2MOzl3nmhld6i6hxuq9EigzfDzWdes3V?=
 =?us-ascii?q?ZRqypFjsHMtncQ1xzP8sSHSuVy/kOm2TuXywDc8PtEIUEplarAMZIhw7gwlp?=
 =?us-ascii?q?QUsUTYACD5hF/6jLOWd0o4+uio7P7rYrP6qZ+HK4B4kAT+MqUqmsCnAOQ4NB?=
 =?us-ascii?q?YBX3SD9Oih27Du8lf1TbVXgvEsjKXUv47WKd4GqqKhBg9ayIcj6xKxDze819?=
 =?us-ascii?q?QYmGEKLElYdxKclIXpJ1HPL+z4Dfe4mVislixryOrcMr3uBZXNMGDPkK39cr?=
 =?us-ascii?q?Zl905c1A0zwMhH551OF7EBJOn+Wlfru9zFCh81Kgm0w+HgCNVnyIwSQ36AAq?=
 =?us-ascii?q?icMKnKq1+H+vovI/WQZI8SoDv9MOYq5/rvjX8/hF8ccrKk3YUYaH+mBPRqOU?=
 =?us-ascii?q?aZbmT2gtcHD2gKuhAyTOvwiF2NSTRTfWq9X7og5jEnD4KrFYPDRoGrgLyc0y?=
 =?us-ascii?q?a3B4ZWaX5aBVCRC3fodpmEWvcVZCKXJc9ujyEEVby/RII6yxGuuxH1y6B9Iu?=
 =?us-ascii?q?rX5CIYr5Tj28Zx5+HJkhEy7zN0XIyh1DS1Rnxw1kYPQCU7lPRnqFF54k+KzK?=
 =?us-ascii?q?w9hvtfD9EV7PRMBENyLpPYzupnG/jsVQ/bONSEUlCrRpOhGz5iYMg2xoo1f0?=
 =?us-ascii?q?tlG9ikxivG1i6uDq5dw6eHH7Qo46nc2D73PM87xHHYgvpyx2I6S9dCYDX1zp?=
 =?us-ascii?q?V08BLeUsuQyRSU?=
X-IPAS-Result: =?us-ascii?q?A2CbAwBRlBRe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXyBf?=
 =?us-ascii?q?YEYVSASKoQJiQOGagaBEiWBAYhtj2GBZwkBAQEBAQEBAQEjFAEBhEACgg04E?=
 =?us-ascii?q?wIQAQEBBAEBAQEBBQMBAWyFNwyCOykBgnoBBSMVQRALFAQCAiYCAlcGAQwGA?=
 =?us-ascii?q?gEBgl8/AYJSJaxLgTKFT4MwgT2BDiiMM3mBB4ERJwwDgig1PoQxJIMEgl4El?=
 =?us-ascii?q?xlGl0CCQIJFhHCOYQYbgkd2hweQG45TnHIigVgrCAIYCCEPgycJRxgNjR4Xi?=
 =?us-ascii?q?RKFLyMDMI5dAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 07 Jan 2020 14:34:33 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 007EXxJB077226;
        Tue, 7 Jan 2020 09:34:00 -0500
Subject: Re: [PATCH v2] selinux: deprecate disabling SELinux and runtime
To:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org
References: <157836784986.560897.13893922675143903084.stgit@chester>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <43f27f76-f3ca-7ea2-7820-da56bb53fd0e@tycho.nsa.gov>
Date:   Tue, 7 Jan 2020 09:35:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <157836784986.560897.13893922675143903084.stgit@chester>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/6/20 10:30 PM, Paul Moore wrote:
> Deprecate the CONFIG_SECURITY_SELINUX_DISABLE functionality.  The
> code was originally developed to make it easier for Linux
> distributions to support architectures where adding parameters to the
> kernel command line was difficult.  Unfortunately, supporting runtime
> disable meant we had to make some security trade-offs when it came to
> the LSM hooks, as documented in the Kconfig help text:
> 
>    NOTE: selecting this option will disable the '__ro_after_init'
>    kernel hardening feature for security hooks.   Please consider
>    using the selinux=0 boot parameter instead of enabling this
>    option.
> 
> Fortunately it looks as if that the original motivation for the
> runtime disable functionality is gone, and Fedora/RHEL appears to be
> the only major distribution enabling this capability at build time
> so we are now taking steps to remove it entirely from the kernel.
> The first step is to mark the functionality as deprecated and print
> an error when it is used (what this patch is doing).  As Fedora/RHEL
> makes progress in transitioning the distribution away from runtime
> disable, we will introduce follow-up patches over several kernel
> releases which will block for increasing periods of time when the
> runtime disable is used.  Finally we will remove the option entirely
> once we believe all users have moved to the kernel cmdline approach.
> 
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

checkpatch.pl has two warnings on this patch, one about the new 
Documentation/ABI/obsolete/sysfs-selinux-disable file not being listed 
in MAINTAINERS (looks like others are) and one about the comment block 
style being wrong.  Also not entirely sure if the file should be 
sysfs-selinux-disable or selinuxfs-disable; it gets mounted under sysfs 
but isn't part of it per se.  Otherwise, LGTM.

> ---
>   Documentation/ABI/obsolete/sysfs-selinux-disable |   26 ++++++++++++++++++++++
>   security/selinux/Kconfig                         |    3 +++
>   security/selinux/selinuxfs.c                     |    6 +++++
>   3 files changed, 35 insertions(+)
>   create mode 100644 Documentation/ABI/obsolete/sysfs-selinux-disable
> 
> diff --git a/Documentation/ABI/obsolete/sysfs-selinux-disable b/Documentation/ABI/obsolete/sysfs-selinux-disable
> new file mode 100644
> index 000000000000..c340278e3cf8
> --- /dev/null
> +++ b/Documentation/ABI/obsolete/sysfs-selinux-disable
> @@ -0,0 +1,26 @@
> +What:		/sys/fs/selinux/disable
> +Date:		April 2005 (predates git)
> +KernelVersion:	2.6.12-rc2 (predates git)
> +Contact:	selinux@vger.kernel.org
> +Description:
> +
> +	The selinuxfs "disable" node allows SELinux to be disabled at runtime
> +	prior to a policy being loaded into the kernel.  If disabled via this
> +	mechanism, SELinux will remain disabled until the system is rebooted.
> +
> +	The preferred method of disabling SELinux is via the "selinux=0" boot
> +	parameter, but the selinuxfs "disable" node was created to make it
> +	easier for systems with primitive bootloaders that did not allow for
> +	easy modification of the kernel command line.  Unfortunately, allowing
> +	for SELinux to be disabled at runtime makes it difficult to secure the
> +	kernel's LSM hooks using the "__ro_after_init" feature.
> +
> +	Thankfully, the need for the SELinux runtime disable appears to be
> +	gone, the default Kconfig configuration disables this selinuxfs node,
> +	and only one of the major distributions, Fedora, supports disabling
> +	SELinux at runtime.  Fedora is in the process of removing the
> +	selinuxfs "disable" node and once that is complete we will start the
> +	slow process of removing this code from the kernel.
> +
> +	More information on /sys/fs/selinux/disable can be found under the
> +	CONFIG_SECURITY_SELINUX_DISABLE Kconfig option.
> diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
> index 996d35d950f7..580ac24c7aa1 100644
> --- a/security/selinux/Kconfig
> +++ b/security/selinux/Kconfig
> @@ -42,6 +42,9 @@ config SECURITY_SELINUX_DISABLE
>   	  using the selinux=0 boot parameter instead of enabling this
>   	  option.
>   
> +	  WARNING: this option is deprecated and will be removed in a future
> +	  kernel release.
> +
>   	  If you are unsure how to answer this question, answer N.
>   
>   config SECURITY_SELINUX_DEVELOP
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 278417e67b4c..adbe2dd35202 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -281,6 +281,12 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
>   	int new_value;
>   	int enforcing;
>   
> +	/* NOTE: we are now officially considering runtime disable as
> +	 *       deprecated, and using it will become increasingly painful
> +	 *       (e.g. sleeping/blocking) as we progress through future
> +	 *       kernel releases until eventually it is removed */
> +	pr_err("SELinux:  Runtime disable is deprecated, use selinux=0 on the kernel cmdline.\n");
> +
>   	if (count >= PAGE_SIZE)
>   		return -ENOMEM;
>   
> 

