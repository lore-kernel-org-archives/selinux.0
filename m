Return-Path: <SRS0=KDcg=XZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC07EC32792
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 13:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7B921855
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 13:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ht6uwl+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbfI3Ncu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 Sep 2019 09:32:50 -0400
Received: from USFB19PA36.eemsg.mail.mil ([214.24.26.199]:13732 "EHLO
        USFB19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729738AbfI3Nct (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 30 Sep 2019 09:32:49 -0400
X-EEMSG-check-017: 13312376|USFB19PA36_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,567,1559520000"; 
   d="scan'208";a="13312376"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 Sep 2019 13:32:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1569850368; x=1601386368;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=bCkWqGp1A01TU0AHUUKsBWtEw1WsGYwwMBO0wgc21AQ=;
  b=ht6uwl+RVX8dwwLI+YL46OF9+7Jpk0oL5CO5t2e5IrmPWcMTWPScSB8D
   EXekPuPvN0yLLe6ZOKP/jAE21JZtV/DCjXZoRlOyQTFiZFd3ELTEwJ85M
   9ISsn0+gn1kpnhjoSMPbzJByC9d5VEgC6K4usTHPfZmUxTzqcyMes39Lp
   1S+7YpSJV6ZeA9S50HfT7YfXhWUvMmQRA1KFg5hUKYnSiFBOY7vlwSgrZ
   O7wkWwBGBRSJV/6qQy7/53UY+Qk6xEPvKJ7NUAipNYMB7tSKd+MVCw3WN
   pfgGRhKqw0xCXlhJWdj2zCd4W5ZuwcECK0d6HjoU+I+GvunXP70XrKDSZ
   g==;
X-IronPort-AV: E=Sophos;i="5.64,567,1559520000"; 
   d="scan'208";a="28453026"
IronPort-PHdr: =?us-ascii?q?9a23=3A0LZiFR1g3jeknJz6smDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseIeLPad9pjvdHbS+e9qxAeQG9mCsLQY0aGL4+jJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVijexe7x/IAu5oQjRtcQdnJdvJLs2xh?=
 =?us-ascii?q?bVuHVDZv5YxXlvJVKdnhb84tm/8Zt++ClOuPwv6tBNX7zic6s3UbJXAjImM3?=
 =?us-ascii?q?so5MLwrhnMURGP5noHXWoIlBdDHhXI4wv7Xpf1tSv6q/Z91SyHNsD4Ubw4RT?=
 =?us-ascii?q?Kv5LpwRRT2lCkIKSI28GDPisxxkq1bpg6hpwdiyILQeY2ZKeZycr/Ycd4cS2?=
 =?us-ascii?q?VBRMJRXDFfDI26YYUEEu4NMf9WooT5olcDqwa1CwuxC+P10jJGm2H43aM63e?=
 =?us-ascii?q?oiHw/J0gMvENASv3rbt9j1KKUfXPqpwKXUwzjObfVb0ir95ojSdRAhpOmBU6?=
 =?us-ascii?q?9sccXP0UkvFx3KjlONooL4OjOazOANs2yF4OtgSOmijHUnpBxqojW02sctip?=
 =?us-ascii?q?XGhoISylze8yV525w6Kce3SE58f96pCZ1dvDyZOYtuWs4uXm5ltSkgxrAGpJ?=
 =?us-ascii?q?K3ZjYGxZs5yxLFdvCKdZWD7Aj5W+aLOzh4gWpoeLe4hxmv70et0vb8Vsyo0F?=
 =?us-ascii?q?ZSqSpFj8XMumgN1xPN7siHTeNw/lu71jaV1gDT9/pELVoolavbN5Ehwrkwmo?=
 =?us-ascii?q?AVsUvfBS/5hF/6jKqXdkUg4uSo6uLnbav6ppKEKoN5hQ7zPr4ul8CiG+g0LA?=
 =?us-ascii?q?cDU3aB9eihzLHj+Ff2QLROjv04iKnZt5XaKNwApqGkGA9YyZoj6hajADem19?=
 =?us-ascii?q?QUh38HLElfdx6dgIjpPE/OLOjiDfijm1SsjCtrx/feM73mB5XNKWPDkLH7cr?=
 =?us-ascii?q?lh9UFR0xAzws5C6JJUEL4BPOj/VVP2tNzdFhU5KRC7w/77CNVh0YMTQXmPDb?=
 =?us-ascii?q?GdMKPTt1+I++0uLvKSZI8apjn9MeIp5/3wgn8jn18SY62p0YEQaHCiEfQ1a3?=
 =?us-ascii?q?meNF3qjs0MEy8vuRE4RefnixXWVjtUfHC7VK8U/Dw3CIu6S4zEQ9bpyKeM2C?=
 =?us-ascii?q?a9A41+eG9LEBaPHG3ueoHCXO0DOwyIJco0qSAJTbisTcca0BiqsALrg+58Iv?=
 =?us-ascii?q?H85jwTtZWl0sN8oeLUi0dhpnRPE82B3jTVHClPlWQSSmpzhfsurA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BYDAByApJd/wHyM5BmHQEBBQEMBQGBZ4F0KoFAMiqEI?=
 =?us-ascii?q?o5wUAMGgREliXWRKgkBAQEBAQEBAQE0AQIBAYRAAoNDIzgTAgwBAQEEAQEBA?=
 =?us-ascii?q?QEFAwEBbIU5gjopAYJoAQUjFVELDgoCAiYCAlcGAQwGAgEBgl8/gXcUrTyBM?=
 =?us-ascii?q?oVNgyaBSIEMKIwOGHiBB4E4DIJfPodPglgElgqXDYIsgi6SVwYbmTaOIZswI?=
 =?us-ascii?q?YFYKwgCGAghD4MnUBAUkC8lAzCBBgEBj3gBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 30 Sep 2019 13:32:47 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8UDWkNU022449;
        Mon, 30 Sep 2019 09:32:46 -0400
Subject: Re: [PATCH testsuite 2/3] policy: add fallbacks for Fedora-specific
 macros
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20190930104850.5482-1-omosnace@redhat.com>
 <20190930104850.5482-3-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <c7521035-8608-c24e-4056-c58aa02de387@tycho.nsa.gov>
Date:   Mon, 30 Sep 2019 09:32:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190930104850.5482-3-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/30/19 6:48 AM, Ondrej Mosnacek wrote:
> dev_rw_infiniband_dev() and mount_rw_pid_files() are not defined in
> refpolicy. Fall back to dev_rw_generic_files() and
> mount_rw_runtime_files() if they are not defined.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>   policy/test_policy.if | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/policy/test_policy.if b/policy/test_policy.if
> index 40e7499..e31345e 100644
> --- a/policy/test_policy.if
> +++ b/policy/test_policy.if
> @@ -71,3 +71,17 @@ interface(`userdom_search_generic_user_home_dirs', `
>       userdom_search_user_home_content($1)
>   ')
>   ')
> +
> +# Workarounds for refpolicy:
> +
> +ifdef(`dev_rw_infiniband_dev', `', ` dnl
> +interface(`dev_rw_infiniband_dev', `
> +    dev_rw_generic_files($1)
> +')
> +')

dev_rw_infiniband_dev allows access to character and block devices 
labeled infiniband_device_t.  dev_rw_generic_files() allows access to 
_regular_ files labeled device_t. dev_rw_generic_chr_files() and 
dev_rw_generic_blk_files() would be the equivalent interfaces. 
Alternatively, we could wrap the calls in the test_ib*.te files with 
ifdefs as we do for e.g. corenet_ib_pkey and other interfaces. 
Regardless, I don't think the infiniband tests will presently work on a 
system with only refpolicy.

> +
> +ifdef(`mount_rw_pid_files', `', ` dnl
> +interface(`mount_rw_pid_files', `
> +    mount_rw_runtime_files($1)
> +')
> +')
> 

