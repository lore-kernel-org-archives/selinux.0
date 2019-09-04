Return-Path: <SRS0=KzaI=W7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218C0C3A5A7
	for <selinux@archiver.kernel.org>; Wed,  4 Sep 2019 12:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68A821883
	for <selinux@archiver.kernel.org>; Wed,  4 Sep 2019 12:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="nxiLCyeI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbfIDMsh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Sep 2019 08:48:37 -0400
Received: from UCOL19PA39.eemsg.mail.mil ([214.24.24.199]:42939 "EHLO
        UCOL19PA39.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbfIDMsh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Sep 2019 08:48:37 -0400
X-EEMSG-check-017: 18318133|UCOL19PA39_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,467,1559520000"; 
   d="scan'208";a="18318133"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA39.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Sep 2019 12:48:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1567601313; x=1599137313;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=pP1is8Ydc4lplylR2YmUUL1TLcEKkO9hImcfzrqnNRY=;
  b=nxiLCyeIetN5lRv8mImpvEfGOKRzuyE47uXh1wZ5w8USVPHR4vdec0VV
   PbjeUtjOz6EtgycUuqxaid/S6voyKY/fP+d7PIteEBHttCICcKiSK34Dc
   N3DcUOIccXWcPKluI2O46bEyC9RqJqfs06K7QrnKGYTuhEzWf8hTZStVZ
   lX/6NIIbxgX2hEVrHZXru5rsphZcTkJqZ+CkaxkChn6XCIChYlNf9qH4y
   NGu5VQkCEchtvYB/iGTCfZuiSkUoOhx40Vp2yEzPLb9CK0y6bvMklVNsW
   wZxmHLVEdfBG2A4+YnKHUcIPJUi8kT7kTlMGF/gKmxubpfDjsFKZCz1lC
   w==;
X-IronPort-AV: E=Sophos;i="5.64,467,1559520000"; 
   d="scan'208";a="27492988"
IronPort-PHdr: =?us-ascii?q?9a23=3ATnk6oxVdSdhphLgecEGCek+mrlvV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbByDt8tkgFKBZ4jH8fUM07OQ7/m6HzVfvN3c6zgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrswndrNQajIliJ6o+yh?=
 =?us-ascii?q?bErGZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXH?=
 =?us-ascii?q?dNUtpNWyBEBI6zYZEPD+4cNuhGqYfzqUYFoR+nCQSiAO7jzzlFjWL006Inye?=
 =?us-ascii?q?QsCRzI0hIuH9wOs3raotv6O6gQXu+pw6fF1inDYvFM1Dvh9ITFfBIsrPeRVr?=
 =?us-ascii?q?xwa8rRzkwvGhvYgFWMt4PlJzOV2foLs2OG8uRgUPigi2ojqw5vojmk28Ahip?=
 =?us-ascii?q?LUiYIO0V3E6SV4z5o1Jd2/UkJ7Z8WkH4FKuyGVMIt2XNovTmd1syg50r0LoY?=
 =?us-ascii?q?O3cScFxZg9xxPTduaLf5aH7x79TuqdPDF1j29/dr2lnRa9602gx/X5VsmzzV?=
 =?us-ascii?q?lFsDJIksLJtnARzxzT7dWHSudl8kehxzmP0wfT5/lYIU8uj6rbKoMhwqUqmp?=
 =?us-ascii?q?oPsUXMAi/2mELsgK+Qakok4fSn5/7iYrXnop+QL450igfgPaQygsGzHOs1Pw?=
 =?us-ascii?q?cUU2Wb5OiwzqPv8ELnTLlQk/E6iqzZv4rbJcQfqK65GQhV0oM75hakEjimy8?=
 =?us-ascii?q?8VnWUHLV1ZeBKHiJLlO1fVIP/iF/u/jFOskClzy/DcIrLhGonNLmTEkLr5Zb?=
 =?us-ascii?q?Zy8VNcyA4owNBH/Z1UF7UBLOv2Wk/2s9zYFAE2PxaozObgDdV3zpkeVn6XAq?=
 =?us-ascii?q?+FLKPStkeF5vkxLOmIZY8Vviv9Kvc+6v7wgn82h0UdcbOq3ZQJcnC4GOppI0?=
 =?us-ascii?q?GDbXrrmNcBHjRCgg1rdOX3jBWnVjlJaj7mR6sh4hkjAZ+iSILEQZqgxreG2X?=
 =?us-ascii?q?H/VoZbYmFAF0CkD3jlbcOHVu0KZSbUJdVuwRIeUr30cJMszRGjskfBzrNjKu?=
 =?us-ascii?q?fFsnkDuYnLyMl+5+qVkwo7szNzEZLOgCm2U2hokzZQFHcN16dlrBk4kwzS3A?=
 =?us-ascii?q?=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2C5AAA8sW9d/wHyM5BlHQEBBQEHBQGBVQYBCwGBbSqBQ?=
 =?us-ascii?q?DIqhCGPDFEBAQaBESWJb48rgXsJAQEBAQEBAQEBNAECAQGEPwKCMiM2Bw4CC?=
 =?us-ascii?q?wEBAQQBAQEBAQYDAQFshTqCOikBgmYBAQEBAyMVUQsVAwICJgICVwYBDAYCA?=
 =?us-ascii?q?QGCXz+BdxSpV4EyhUqDN4FJgQwoAYt3GHiBB4E4DIJfPoQNg0KCWASVTZZXg?=
 =?us-ascii?q?imCKJIzBhuYay2NSppOBiuBWCsIAhgIIQ+DJ4J6jikkAzCBBgEBjB+CVAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 04 Sep 2019 12:48:32 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x84CmVws003223;
        Wed, 4 Sep 2019 08:48:32 -0400
Subject: Re: [PATCH] selinux-testsuite: ensure the cgroups_label tests works
 on old and new systems
To:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
References: <156685561015.29917.5393176418461343562.stgit@chester>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6bee6b4c-db3e-4031-4996-f94ae68abbaa@tycho.nsa.gov>
Date:   Wed, 4 Sep 2019 08:48:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <156685561015.29917.5393176418461343562.stgit@chester>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/26/19 5:40 PM, Paul Moore wrote:
> From: Paul Moore <paul@paul-moore.com>
> 
> Commit 697efc910393 ("selinux-testsuite: fix the cgroups_label test")
> fixed the cgroups_label test on new systems, but it broke old systems.
> Try to use /sys/fs/cgroup/unified first and if that doesn't exist go
> with the new approach introduced in the commit above.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>

This leaves the test system in a broken state, with all of 
/sys/fs/cgroup/unified getting relabeled to test_cgroup_t during the 
test and then switching to unlabeled_t upon the unloading of the test 
policy.  I get a bajillion denials after the testsuite completes from 
anything trying to access /sys/fs/cgroup/unified, and ls -Z 
/sys/fs/cgroup/unified shows it as being unlabeled_t throughout.

> ---
>   tests/cgroupfs_label/test |    6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/cgroupfs_label/test b/tests/cgroupfs_label/test
> index 385b953..91517b4 100755
> --- a/tests/cgroupfs_label/test
> +++ b/tests/cgroupfs_label/test
> @@ -5,7 +5,11 @@ BEGIN { plan tests => 2 }
>   
>   my $ret;
>   
> -my $dir = "/sys/fs/cgroup/selinuxtest";
> +# Older systems use /sys/fs/cgroup/unified, newer use /sys/fs/cgroup.
> +my $dir = "/sys/fs/cgroup/unified";
> +if (! -d $dir) {
> +	$dir = "/sys/fs/cgroup/selinuxtest";
> +}
>   
>   # Create a new cgroupfs directory and relabel it.
>   mkdir("$dir");
> 
> 

