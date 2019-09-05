Return-Path: <SRS0=j8XY=XA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF442C3A5A5
	for <selinux@archiver.kernel.org>; Thu,  5 Sep 2019 12:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20A02184B
	for <selinux@archiver.kernel.org>; Thu,  5 Sep 2019 12:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ibFQc6Uu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731306AbfIEMYn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:24:43 -0400
Received: from USAT19PA21.eemsg.mail.mil ([214.24.22.195]:44707 "EHLO
        USAT19PA21.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731294AbfIEMYn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Sep 2019 08:24:43 -0400
X-EEMSG-check-017: 24092631|USAT19PA21_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,470,1559520000"; 
   d="scan'208";a="24092631"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA21.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 05 Sep 2019 12:24:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1567686258; x=1599222258;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=oeTS0MeppC9qUZjrwzssszPhBPe94z00rrQTQ72VdpQ=;
  b=ibFQc6UufIiHfKdtNwQ3daLdizjAkESU+njtIZ9hyiMoLH42w7OJMa/T
   UmrKDcsLU0tEUm2VXdugSJeAlxsvvNwh/9Y/8RAcYgVcVedolvnAqd4yf
   bHeUlH5cDXqaQWn/V98AsZ5PwGTtidTf0cNe+ncZXPKaGllrHlI/h+hFl
   wPxj2J7DxmtOlyAaTXuyxtP56CraUpKi6IUkjisBN7aTjVBW3iUoo2v7W
   pAqi1jA+BYtitAtA0PPfaqEVlc0CwCsbMxeQgjbdDjXjkLmdDonRxrie7
   5Q06mtnQDOIbtV7ZUWs7MvmJD5Vs86inhcQY2GNtR8a7P/ZZ5gdhnkKQE
   w==;
X-IronPort-AV: E=Sophos;i="5.64,470,1559520000"; 
   d="scan'208";a="32395377"
IronPort-PHdr: =?us-ascii?q?9a23=3AfImsqxFNcHjuNqEdADgXnp1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7zr8iwAkXT6L1XgUPTWs2DsrQY0rCQ6v+/EjBdqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba5sIBmssAnctMsbjYRtJ6sx1x?=
 =?us-ascii?q?DEvmZGd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U6VWACwpPG?=
 =?us-ascii?q?4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Ui?=
 =?us-ascii?q?ms4qt3VBPljjoMOiUn+2/LlMN/kKNboAqgpxNhxY7UfJqVP+d6cq/EYN8WWX?=
 =?us-ascii?q?ZNUsNXWiNPGIO8a5YEAfQHM+hWsoLxo0ICoBW6CAWpAu7k1z1GiWLs3aAizu?=
 =?us-ascii?q?ovDw/G0gwjEdwAvnvbo9f6O7sdX+2u0KnFzy/OY+9K1Trz6oXFdA0qr/GWXb?=
 =?us-ascii?q?J3dMrc0VQhFx/bgVWIqYzqITWV3fkQvWie9eVgUeavhHAnqgpspTWv3dojip?=
 =?us-ascii?q?LSi4IJylHL6SV5wIEvKd2+U050e8SoEJRXtyGELoZ7RN4pTWJwuCsi17ELtp?=
 =?us-ascii?q?G2cDIKxZg63RLTdfOKf5aS7h7+UuuaPC12i2h/eL2lgha/6U2gyurhWcaqyF?=
 =?us-ascii?q?tKtS9FksXUtnAKyhzT9tCLSvtj8Uel3jaCzxzT5fteIUA1iKrbMIQtwqIwl5?=
 =?us-ascii?q?UPsUTDGTX6mEPqg6+Nakoo4O2o6+XjYrn+p5+cMZF7ih3mP6gzlcGyDv40Pw?=
 =?us-ascii?q?gTU2SB5+ix26Pv8VfkTLlSi/05iKjZsJTUJcQBoa65BhdY0p0+5BakFDqmzN?=
 =?us-ascii?q?QZkmUHLFJCYh6HiZPpNEvULPD3Cve/nUygkC13yPDeIr3hHpLNI2DbkLj7YL?=
 =?us-ascii?q?Z971VRyBIpwtBC45JYE7QBIPX0Wk/rqtPUFAM2Mwuxw+z/EtVyypseWX6TAq?=
 =?us-ascii?q?+eKK7SqkGH5uYuI+mKeY8Uty3wK+Yq5/Hwl381g1wdcrez3ZsRdn+4Gu5qI0?=
 =?us-ascii?q?KDYXrj0Z89FjIytxc6BMntj0ePGWpLbmu2d7o1+zV+DYWhF4qFTYeo1vjJxy?=
 =?us-ascii?q?q/H5tLdkhYBV2WV3TlbYOJX7ELci3BDNVml2k/SbW5S4InnSqrvQv+xqsvev?=
 =?us-ascii?q?HY4QUEpJnj055z/OSVmhYso28nR/+B2n2AGjkn1lgDQCU7ieUm+h1w?=
X-IPAS-Result: =?us-ascii?q?A2DlAQB6/XBd/wHyM5BlHQEBBQEHBQGBVgUBCwGBbSqBQ?=
 =?us-ascii?q?DIqhCGPC04BAQEBAQaBNolvkSYJAQEBAQEBAQEBNAECAQGEPwKCNiM3Bg4CC?=
 =?us-ascii?q?wEBAQQBAQEBAQYDAQFshTqCOikBgmYBAQEBAgEjFVELFQMCAiYCAlcGAQwGA?=
 =?us-ascii?q?gEBgl8/gXcFD6lQgTKFS4M6gUmBDCgBi3cYeIEHgTiCaz6HT4JYBJVVlluCK?=
 =?us-ascii?q?YIokjoGG5h1LYoOgz+abSKBWCsIAhgIIQ+DJ4J6jikkAzCBBgEBj0IBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 05 Sep 2019 12:24:17 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x85COGDm015534;
        Thu, 5 Sep 2019 08:24:16 -0400
Subject: Re: [PATCH] selinux-testsuite: don't break the system after running
 the cgroups_label tests
To:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
References: <156763458867.12445.11356660144461085311.stgit@chester>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <1f03f9a2-1bbe-c593-3cf0-3393f8dac943@tycho.nsa.gov>
Date:   Thu, 5 Sep 2019 08:24:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <156763458867.12445.11356660144461085311.stgit@chester>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/4/19 6:03 PM, Paul Moore wrote:
> From: Paul Moore <paul@paul-moore.com>
> 
> Commit be0ca8feeb9b ("selinux-testsuite: ensure the cgroups_label
> tests works on old and new systems"), and perhaps an earlier related
> commit, broke systems after the tests were run by operating on
> /sys/fs/cgroup/unified directly and not a sub-directory.  Fix this
> by restoring the old (sub-directory) behavior.
> 
> Reported-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Tested-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   0 files changed

That's a little odd.

> 
> diff --git a/tests/cgroupfs_label/test b/tests/cgroupfs_label/test
> index 13f0434..3accca0 100755
> --- a/tests/cgroupfs_label/test
> +++ b/tests/cgroupfs_label/test
> @@ -6,8 +6,11 @@ BEGIN { plan tests => 2 }
>   my $ret;
>   
>   # Older systems use /sys/fs/cgroup/unified, newer use /sys/fs/cgroup.
> -my $dir = "/sys/fs/cgroup/unified";
> -if ( !-d $dir ) {
> +my $dir;
> +if ( -d "/sys/fs/cgroup/unified" ) {
> +    $dir = "/sys/fs/cgroup/unified/selinuxtest";
> +}
> +else {
>       $dir = "/sys/fs/cgroup/selinuxtest";
>   }
>   
> 

