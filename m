Return-Path: <SRS0=lyW+=Z2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBC8C43603
	for <selinux@archiver.kernel.org>; Wed,  4 Dec 2019 20:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E1020659
	for <selinux@archiver.kernel.org>; Wed,  4 Dec 2019 20:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="MLiyWZM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfLDUer (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Dec 2019 15:34:47 -0500
Received: from UCOL19PA36.eemsg.mail.mil ([214.24.24.196]:43344 "EHLO
        UCOL19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727911AbfLDUer (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Dec 2019 15:34:47 -0500
X-EEMSG-check-017: 57028244|UCOL19PA36_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,278,1571702400"; 
   d="scan'208";a="57028244"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Dec 2019 20:34:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1575491686; x=1607027686;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=HelV4Dto+SOqY2G2q9pw2Huco3qkVNsZMyP3VSGY8AU=;
  b=MLiyWZM4E/O+9Z5NQS3MZtybSoyBxahsGW7r8J81/NiU0tE+4PF/20nh
   OlBYWuyRlvRFxvy2jASWU2g7QH2n067Vn2NQU1w7z0Lnp39f+xVgpEjll
   CkqwErHeV1wcRcI/9/HMJYh1wesKfakVoNw+sn1PH4TgBJYlM03Lrs51P
   noR/XW1tO5ZBcRaicC2rvp/TqRp8j82eQ90KPVUjdZIQjLQWgJ79G2pMq
   Nb+snB5WhRqzhWIrHxyoF/rxeJExEa6vVkKz1xiljjSqfpZfFZW7+iD4x
   FMLpmS3d9NgYPS7LbaXYgEPQvtZ5avAi3zAFOFEEq5OqypTU45ib08jfT
   w==;
X-IronPort-AV: E=Sophos;i="5.69,278,1571702400"; 
   d="scan'208";a="36346178"
IronPort-PHdr: =?us-ascii?q?9a23=3AIBTPzRCiMFRG6vJ/p8LHUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPX/pMbcNUDSrc9gkEXOFd2Cra4d0KyP7PGrADdcqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba58IRmssAnctM0bjYR/Jqs/xR?=
 =?us-ascii?q?bCv2dFdflRyW50P1yYggzy5t23/J5t8iRQv+wu+stdWqjkfKo2UKJVAi0+P2?=
 =?us-ascii?q?86+MPkux/DTRCS5nQHSWUZjgBIAwne4x7kWJr6rzb3ufB82CmeOs32UKw0VD?=
 =?us-ascii?q?G/5KplVBPklCEKPCMi/WrJlsJ/kr5UoBO5pxx+3YHUZp2VNOFjda/ZZN8WWH?=
 =?us-ascii?q?ZNUtpUWyFHDIy8dY8PBPcfM+heoYf2ul8CoQKwCASoAe/izCJDiH3r0q0gy+?=
 =?us-ascii?q?kvDB/I3AIgEdwNvnrbotr6O6UOXu6616TI0TfOYulK1Tvh5oXFcBYsquyMU7?=
 =?us-ascii?q?JqdsrRzFEiGR7ZjlqOsYzlPy2a1uIQuGaG6upvT+avi2o5pABxvzOiwdwshZ?=
 =?us-ascii?q?TSho8O1lDF9Tl2wIYyJdGiTk57esSrHIFftyGdKYt7W8UvSHxrtiYi0rAKpJ?=
 =?us-ascii?q?G2cScQxJkn2hLTceKLfoeW7h75SeqcJypzimh/d7KlnRmy9FCtyuj7Vsapzl?=
 =?us-ascii?q?lHtjFFktzQtnAV0BzT99SHRuN9/ki/3TaP0Bje6v1eLkAulKrbNoUhzqQxlp?=
 =?us-ascii?q?oVv0TDGTT2l1vqg6OMakUl+vSn6+TgYrn8oJ+TK5R0hR3kPqQrm8y/Bfw0Mg?=
 =?us-ascii?q?kIX2eF5eSxzKDv8EL2TblQjvA6j7PVvI7VKMgFvKK1HhdZ0oM55Ba+Czem3s?=
 =?us-ascii?q?4YnX4CLF9dYxKIkpPpNkrSIPH4Efi/g1OsnC1tx/DdJLLtGJrNLn/dkLv5Z7?=
 =?us-ascii?q?Zy91ZcyBYvzdBY/59UELABL+7zWkDrrtzXEwc2PBCszObnEtp914UeVnyUAq?=
 =?us-ascii?q?KCK6zSrV6I5uQzI+aSfo8VvijyK+Q/6/Hyin85nEcXfbO10psPdHC4AvNmLl?=
 =?us-ascii?q?2CYXXyhtcBEGEKvhcxTeHxll2CXiBcZ2yoU6I/+D47EoSmApnHRoy3h7yBxi?=
 =?us-ascii?q?i7TdVqYTV8C1uMGG3kP6WNWvEBc2rGOM5qkjUeWY+qfI8o1Bejryfw17thMu?=
 =?us-ascii?q?fO/CAE85nk0Y4xr/bekRA06CxcEcuQySeOQntyk2dOQCU5j45lpkko8UuOya?=
 =?us-ascii?q?h1hbRjENVX4/5YGlMhOYX00/1xC9e0XBnIONiOVgD1EZ2dHTgtQ4dpkJc1aE?=
 =?us-ascii?q?FnFoDn10uS0g=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DFAAA5F+hd/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfoF0gW0gEiqEK4kDhmIGgTeJaZFECQEBAQEBAQEBATcBAYRAAoI0OBMCE?=
 =?us-ascii?q?AEBAQQBAQEBAQUDAQFshUOCOykBgm0BAQEBAgEjFUYLCxgCAiYCAlcGAQwGA?=
 =?us-ascii?q?gEBgl8/gkcDCQUgsCl1gTKFT4MtgUiBDiiMMXmBB4E4D4JdPoIbhT6CXgSWc?=
 =?us-ascii?q?UaXE4I4gjmTGwYbgkGMLYs4LY4dnDQigVgrCAIYCCEPgydQERSbSiMDMJFoA?=
 =?us-ascii?q?QE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 04 Dec 2019 20:34:45 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xB4KYYPK235359;
        Wed, 4 Dec 2019 15:34:35 -0500
Subject: Re: [V2 PATCH 1/1] selinux-testsuite: Add perf_event tests
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
References: <20191204121403.2505-1-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <b0f794e5-c0e1-81d3-c1df-98da1e943bac@tycho.nsa.gov>
Date:   Wed, 4 Dec 2019 15:34:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191204121403.2505-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/4/19 7:14 AM, Richard Haines wrote:
> Test perf_event permissions.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
> V2 Changes:
> Remove neverallows from policy
> Check /proc/sys/kernel/perf_event_paranoid, if < 2 then bypass the
> capability { sys_admin } test.
> 

> diff --git a/policy/test_perf_event.te b/policy/test_perf_event.te
> new file mode 100644
> index 0000000..bdf3938
> --- /dev/null
> +++ b/policy/test_perf_event.te
> @@ -0,0 +1,104 @@
> +#
> +######### Check watch_queue for key changes policy module ##########
> +#
> +attribute perfdomain;
> +
> +################# Allow perf_event { * } ##########################
> +type test_perf_t;
> +domain_type(test_perf_t)
> +unconfined_runs_test(test_perf_t)
> +typeattribute test_perf_t testdomain;
> +typeattribute test_perf_t perfdomain;
> +
> +allow test_perf_t self:capability { sys_admin };
> +allow test_perf_t device_t:chr_file { ioctl open read write };

Why is device_t:chr_file access required by the perf test?  What device 
node is being accessed?

> +allow test_perf_t self:perf_event { open cpu kernel tracepoint read write };
> +allow_map(test_perf_t, device_t, chr_file)

Ditto
