Return-Path: <SRS0=4+dM=3K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9B4C2D0CE
	for <selinux@archiver.kernel.org>; Tue, 21 Jan 2020 18:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E7F21734
	for <selinux@archiver.kernel.org>; Tue, 21 Jan 2020 18:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="O8/tXBZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgAUS4b (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Jan 2020 13:56:31 -0500
Received: from UHIL19PA38.eemsg.mail.mil ([214.24.21.197]:15022 "EHLO
        UHIL19PA38.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgAUS4a (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Jan 2020 13:56:30 -0500
X-EEMSG-check-017: 68220203|UHIL19PA38_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,346,1574121600"; 
   d="scan'208";a="68220203"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA38.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 21 Jan 2020 18:56:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579632978; x=1611168978;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=CbuZdviu4Lkk32wKikbGW1JHa9HhT0hvaeMD+gFg/cQ=;
  b=O8/tXBZT0BdHELIBa7/POb8+19zYBT/gCkMPq6vgZw0DoMly9Ypo6Ri0
   Ukh8AlmJlJIlaGP9aXxMydVIipUpxS3WR+a8KYIUg2Mau8uoa/XtQGi6H
   R6mPIAIXzoJA9rOQlirwtHhkhnkNZnkYlNSKe2asmDhERKdDpXzZIuNDl
   yzyGBeacoQVAhPWm+ZKsyFdiqABV4NYBFpGApM9kLfGwHK+/phsram2I+
   MMCfTZh4m6Sqo87p2bC6Lj9dT3rxRs6+Kf2b+nDW5CQL4eVaB1Jgk/oq9
   q5hRYDzn97unqX6pGgeT5Ow35meiaD4InCNlGMygMyIsEzKtPRRQcs6Z4
   A==;
X-IronPort-AV: E=Sophos;i="5.70,346,1574121600"; 
   d="scan'208";a="38060449"
IronPort-PHdr: =?us-ascii?q?9a23=3ANZqKixO+vMycCcKVurkl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/3+oMbcNUDSrc9gkEXOFd2Cra4d16yP4+u5ADJIoc7Y9ixbK9oUD1?=
 =?us-ascii?q?5NoP5VtjRoONSCB0z/IayiRA0BN+MGamVY+WqmO1NeAsf0ag6aiHSz6TkPBk?=
 =?us-ascii?q?e3blItdaz6FYHIksu4yf259YHNbAVUnjq9Zq55IAmroQnLucQanIRvJrwsxh?=
 =?us-ascii?q?bKrXdEZvlayGJ1Ll6Xgxrw+9288ZF+/yleof4t69JMXaDndKkkULJUCygrPX?=
 =?us-ascii?q?oo78PxrxnDSgWP5noYUmoIlxdDHhbI4hLnUJrvqyX2ruVy1jWUMs3wVrA0RC?=
 =?us-ascii?q?+t77x3Rx/yiScILCA2/WfKgcFtlq1boRahpxtiw47IZYyeKfRzcr/Bcd4cWG?=
 =?us-ascii?q?FMRdhaWTBfDYygbosPF+sBMvher4nhvFsFsB+yCRCxCO/z1jNEg3n70qMg0+?=
 =?us-ascii?q?QlDArIwgouEdwTu3jQtdn4OqMfXeWzwaLVzzvMculW1C/g5obWfBAvofKCU7?=
 =?us-ascii?q?x+fsXey0YgCwzLg06MqYHnJT6ZyvgBvmaZ4udmSOmhi3QnqwZ0ojW328kslp?=
 =?us-ascii?q?fGhpoVyl/a8yVy3Zs7JdiiR05/Zd6rDptRvDydOottX8wiWHpluDo6y7IauZ?=
 =?us-ascii?q?67ezIGyJI8xxHFcfCHfI+I4gz6WeuXPDx2h2pldaqiixu9/kWs0O3xWtSu3F?=
 =?us-ascii?q?pUoSdJjMPAum0L2hfO8MaIUOF98V2k2TuX0gDT7fxLLl4smKrALp4h3qYwlp?=
 =?us-ascii?q?0OsUTfBiP2mFv5jKuRdkg85uin8f7nYrT7pp+HLYN0iwf+MqopmsykH+s3Lh?=
 =?us-ascii?q?ICX3Sb+Oug1L3j+lf1QLNWgf0tjqbVqpXaJcUfpqKhAg9V1Jgs6wqnAju739?=
 =?us-ascii?q?kVkmMLIVJYdB6dkYTkNE/CLOrlAfunhlSjijZrx/TIPr37BZXNK2DOkKz8cr?=
 =?us-ascii?q?Zm8ENc1Aoywsxf55JTEL0BJunzVVXruNzXCR85LRS4w/z7B9VlyoMeRWWPD7?=
 =?us-ascii?q?eDMKPTrVCI5vggI/ORa4ANpDnyM/gl6OTvjX8/h1AdZrKk0oALaHC5GPRmP1?=
 =?us-ascii?q?uWYWDqgtgfDWcGpBYxTOvviFeaSz5ce26yX74g5jE8EI+mFpnMRoSsgLyHwS?=
 =?us-ascii?q?e6EYZbZn5JCl+SC3fkbYaEVOkWaCKUPMBhliYIVb+7S48uzRuurhP1y6J7Lu?=
 =?us-ascii?q?rI/S0VrYrj28Jo5+3Xjhwy7SZ7D9mZ022USmF0mWQIRyUo06xlvUN9zVKD27?=
 =?us-ascii?q?Big/NEDdxT++9JUgAiOJ7byux6DMvyWgTbcdiVVlmrWc+mDi8sQdIx2dAOf1?=
 =?us-ascii?q?xxFMmljhDGjGKWBOovlreLDYY4uoLV3n78PI4p0XfN1KA7g24tdctGNGurnY?=
 =?us-ascii?q?Z16wnVG4PTlUiF0a2tcPJYlDXA8GaF0Hqmok5VSkhzXL/DUHRZYVHZ6ZzB71?=
 =?us-ascii?q?7GB5qpDq4qel9ZwNOGArNDd9msiFJBXvqlM9PbNSb5vGG8HxuKjpaLd4zjcG?=
 =?us-ascii?q?gelHHaDU8flQkY8F6cOAQ+DzvnqGXbWm9AD1XqNnjw/PF+pXXzdUo9ywWHfg?=
 =?us-ascii?q?U1zLau0gIEjvybDfUI1/QLvzl3+GY8J0q0w9+DU4nInAFmZqgJJIpmsVo=3D?=
X-IPAS-Result: =?us-ascii?q?A2CfAwBjSCde/wHyM5BlHQEBAQkBEQUFAYF7gXgFgW0gE?=
 =?us-ascii?q?iqEEokDhmcBAQEGgTeJbpFJCQEBAQEBAQEBATcBAYRAAoI2OBMCEAEBAQQBA?=
 =?us-ascii?q?QEBAQUDAQFshUOCOykBgnoBBSMVUQsYAgImAgJXBgEMBgIBAYJjP4JLAwklr?=
 =?us-ascii?q?yGBMoVKgy6BPoEOKowueYEHgTgPgl0+ghuFPoI8IgSNOIl6RpdagkOCSZNiB?=
 =?us-ascii?q?huad45enRcigVgrCAIYCCEPgydQGA2WZSMDMI4NAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 21 Jan 2020 18:56:17 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00LItYWM145270;
        Tue, 21 Jan 2020 13:55:34 -0500
Subject: Re: [PATCH 2/2] selinux-testsuite: Add fs*(2) API filesystem tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
References: <20200120111113.23349-1-richard_c_haines@btinternet.com>
 <20200120111113.23349-3-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <bf9f4218-ee4d-ffc5-d0db-7f8f678d0090@tycho.nsa.gov>
Date:   Tue, 21 Jan 2020 13:56:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200120111113.23349-3-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/20/20 6:11 AM, Richard Haines wrote:
> Test filesystem permissions using the fsopen(2), fsconfig(2), fsmount(2),
> fspick(2) and fsmount(2) api's introduced in kernel 5.2.
> 
> Also tests move_mount(2) using open_tree(2).
> 
> These tests use common code from tests/filesystem.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
<snip>
> diff --git a/tests/fs_filesystem/test b/tests/fs_filesystem/test
> new file mode 100755
> index 0000000..bda7fcf
> --- /dev/null
> +++ b/tests/fs_filesystem/test
> @@ -0,0 +1,833 @@
> +#!/usr/bin/perl
> +use Test::More;
<snip>
> +    # Set to '1' for testing 'hooks.c selinux_move_mount() FILE__MOUNTON'
> +    # Once kernel patch is mainline, add kernel version test.
> +    $test_move_mount = 0;
> +    if ($test_move_mount) {
> +        $test_count += 3;
> +    }

Wondering what we want the test above for test_move_mount to ultimately 
be.  It could be the first kernel version to include my fix.  That would 
avoid testsuite failures on kernels 5.2 through 5.5 assuming the fix is 
queued for 5.6.  On the other hand, it can be argued that the testsuite 
should fail on those kernels and the fix might end up going to stable 
and being back-ported to stable updates to those kernels, in which case 
testing those kernel versions may ultimately be useful.  Paul, what's 
your preference here?
