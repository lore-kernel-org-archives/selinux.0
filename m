Return-Path: <SRS0=2SWW=27=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97633C282DD
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 14:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F14B2080D
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 14:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="qUkLMN5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgAJObp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jan 2020 09:31:45 -0500
Received: from UCOL19PA37.eemsg.mail.mil ([214.24.24.197]:26214 "EHLO
        UCOL19PA37.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbgAJObo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jan 2020 09:31:44 -0500
X-EEMSG-check-017: 70612803|UCOL19PA37_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,417,1571702400"; 
   d="scan'208";a="70612803"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA37.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Jan 2020 14:31:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578666703; x=1610202703;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=xId5BtuFqkdNIP0U6y0BiiQocaf1u191KNmgHjWICMY=;
  b=qUkLMN5dZw6KXWd0slNAZSpLSbQp3O1VboIQ/2jQaq1YG2M5Ope4eV9x
   UGpp/EYU6K++rMp8Pi6b0nrKTB/5wcftLZNK+P9eEeNs7iixi2MlZHZTp
   oUGafOpnTHVyYdecYbYeh0i4LzKNBtsbti6W8emjxgcfI4yIWzDy4UU16
   E44TAm9D263gR1/OO5vudQpDy8JO9hQn+R7LuoJJT1g5U7FznWWTfz0hq
   CReSyVHL6IxOoRrrmcunBejjgAoOGvd2wWjVXL9PnIX/ewp8GgRNy4s+W
   zvLxjCowD0Sof4xhhnOft5wQtfIMTDs1l+MxAa+dd29qYik0Ag75OsOgk
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,417,1571702400"; 
   d="scan'208";a="37603501"
IronPort-PHdr: =?us-ascii?q?9a23=3AeslTYxGi8FFcpK21mitJEJ1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7zoMqwAkXT6L1XgUPTWs2DsrQY0rGQ6f67EjFRqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba58IRmsswnct8cbjYRiJ6s11x?=
 =?us-ascii?q?DEvmZGd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U6VWACwpPG?=
 =?us-ascii?q?4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Ui?=
 =?us-ascii?q?ms4qt3VBPljjoMODAj8GHTl8d+kqRVrhy8rBB72oLZYIWYOP94c6jAf90VWH?=
 =?us-ascii?q?BBU95MWSJfDIOyb4gBAeQPMulXrYbyu1QAoACiBQSvHu7j1iNEi3H00KA8zu?=
 =?us-ascii?q?8vERvG3AslH98WrXrUsMv6NL8SUe+ryqnD0CjNb/ZM1jf57IjHbBAgquyLUL?=
 =?us-ascii?q?JrbMXR0lIiFx/Fj1qMqYzlOCmZ1uIWs2eB9eZgWuWvi3A+pgx3vzOhxd8sh5?=
 =?us-ascii?q?HUio8axV3I7yV0zJsvKdGmR0N3f8SoHIZWuiqHLYV5WNkiTHttuCsiz70Gvo?=
 =?us-ascii?q?O0czYSxZQ8wh7fd+SHc4+V4hL/TOqRISl3hHZieL+nmxa961KgyuzhVsmvyl?=
 =?us-ascii?q?pKryxFktfLtnAWyRPc9tKLSud9/0i92TaP0Brf6udYLkAviaXXMZshwr80lp?=
 =?us-ascii?q?YLsETDGDH5mFnugaOLeUgp9fKk5uT6brn8uJOROJF4hhvjPqg2n8ywG+U4Mg?=
 =?us-ascii?q?wAX2iB/uS80aXu/VbkT7VRlfA2jqnYv4zaJcQcvKK5BRRV3Zw55xawCDemzs?=
 =?us-ascii?q?wUnWMbI1JdZBKHk4/pNknSL/D3DPa/hFKsnylwx/3dMb3hBZLNLnfHkLj/eL?=
 =?us-ascii?q?Zy8U9cyA4pwd9D4JJUD6kLIOjvVU/pqNzYEhg5PhSvw+n5DNV914UeWX+AA6?=
 =?us-ascii?q?KCLqPSvkGH5vg1L+mPeoAVojD9JOYh5/L0in85g1AdLuGV2s48aGq5BehnKk?=
 =?us-ascii?q?OuTuTwnswKEWpC6gExXuvshUaqXjlUaHK/Wqs94ncwD4fwSc/YS4SshqGR9D?=
 =?us-ascii?q?m0E4cQZW1cDF2IV3DyeNaqQfAJPRmOL9dhnzpMbr2oT4ssxFn6rwPh46Z2Je?=
 =?us-ascii?q?rTvCsDvNTs08YjtL6brg076TEhV5fV6GqKVWwh2z5ZSg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AZAQDhiBhe/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBe4F9gWwBIBKEM4kDhmQBAQEBAQEGgRIliW6RSAkBAQEBAQEBAQE3AQGEQ?=
 =?us-ascii?q?AKCFjgTAhABAQEEAQEBAQEFAwEBbIVDgjspgnsBBSMPAQVRCxgCAiYCAlcGA?=
 =?us-ascii?q?QwIAQGCYz+CVyWrb4EyhUmDQoE9gQ4ojDN5gQeBOAwDgl0+gQ6GS4JeBI0wi?=
 =?us-ascii?q?jmXToJBgkiTXwYbmmqOWp0FIoFYKwgCGAghD4MoTxgNoTMjA5FgAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 10 Jan 2020 14:31:42 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00AEV8VC022050;
        Fri, 10 Jan 2020 09:31:08 -0500
Subject: Re: [RFC PATCH 3/3] libselinux: add policy capability test binary
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
References: <20200110141509.21098-1-cgzones@googlemail.com>
 <20200110141509.21098-4-cgzones@googlemail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a29daabd-e6f2-4f22-3830-b00bd8bf63aa@tycho.nsa.gov>
Date:   Fri, 10 Jan 2020 09:32:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200110141509.21098-4-cgzones@googlemail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/10/20 9:15 AM, Christian Göttsche wrote:
> ---
>   libselinux/utils/.gitignore       |  1 +
>   libselinux/utils/polcap_enabled.c | 30 ++++++++++++++++++++++++++++++
>   2 files changed, 31 insertions(+)
>   create mode 100644 libselinux/utils/polcap_enabled.c
> 
> diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitignore
> index 3ef34374..bfe1db4d 100644
> --- a/libselinux/utils/.gitignore
> +++ b/libselinux/utils/.gitignore
> @@ -12,6 +12,7 @@ getpidcon
>   getsebool
>   getseuser
>   matchpathcon
> +polcap_enabled
>   policyvers
>   sefcontext_compile
>   selabel_digest
> diff --git a/libselinux/utils/polcap_enabled.c b/libselinux/utils/polcap_enabled.c
> new file mode 100644
> index 00000000..e984d1e4
> --- /dev/null
> +++ b/libselinux/utils/polcap_enabled.c
> @@ -0,0 +1,30 @@
> +#include <errno.h>
> +#include <stdio.h>
> +#include <string.h>
> +
> +#include <selinux/selinux.h>
> +
> +int main(int argc, char **argv)
> +{
> +	int ret;
> +
> +	if (argc != 2) {
> +		printf("usage: %s polcap_name\n", argv[0]);
> +		return 1;
> +	}
> +
> +	ret = security_is_policy_capability_enabled(argv[1]);
> +
> +	if (ret == 1)
> +		printf("enabled\n");
> +	else if (ret == 0)
> +		printf("disabled\n");
> +	else if (errno == ENOTSUP)
> +		printf("not supported\n");
> +	else {
> +		printf("error (%d): %s\n", errno, strerror(errno));
> +		return 1;
> +	}
> +
> +	return 0;
> +}

For new libselinux utilities, let's try to use some kind of unique 
prefix to help avoid collisions for distros that install these programs. 
  selinux_ should be fine.


