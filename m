Return-Path: <SRS0=2vFY=3C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEDFC33CAD
	for <selinux@archiver.kernel.org>; Mon, 13 Jan 2020 14:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7ADC20661
	for <selinux@archiver.kernel.org>; Mon, 13 Jan 2020 14:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="N/1kd1hw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgAMOUh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Jan 2020 09:20:37 -0500
Received: from USFB19PA32.eemsg.mail.mil ([214.24.26.195]:64782 "EHLO
        USFB19PA32.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgAMOUh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Jan 2020 09:20:37 -0500
X-EEMSG-check-017: 44052971|USFB19PA32_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,429,1571702400"; 
   d="scan'208";a="44052971"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA32.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Jan 2020 14:20:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578925235; x=1610461235;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=2p244gbWEfgg+S1TFtBUbu8OFiSUwtK33bvU3fU9t6g=;
  b=N/1kd1hwysJD3P65tYpCN88o/SY/xagqs6yewMlWBBlSmdaxTdJdEpZB
   O3YklSo+5CLTz0nliK+CITs6MB2mvTX0J+fBBPUTkdzl6TqGcKX5W9miX
   8Kq67PgsOd/ODJwhQ5yDHez0uqMHaSlbU4P708YmLgCVoBG6CONkoqmu9
   YoiyHM1jOe6Nreoe7o3iNGQsi/+Ul+mfPVFtInhjIjIdqy96kknp4Jsqx
   hJ5qFpZ63xe96RB0x0eh2wMhiznTHitVO0/Mgq9/UO6rWWlgRt16NfxjE
   D3S0XLqAq8IlJ/Hx+FZiL2qZAqnQOqKy1McXIYruX5wjp6DliwdAaand+
   w==;
X-IronPort-AV: E=Sophos;i="5.69,429,1571702400"; 
   d="scan'208";a="31866632"
IronPort-PHdr: =?us-ascii?q?9a23=3ADaAN1hFI2a3CspgwEdV1zp1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7yosuwAkXT6L1XgUPTWs2DsrQY0rGQ6f+4EjJYqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba58IRmsswnctNUajYRjJ6ot1x?=
 =?us-ascii?q?DEvmZGd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U6VWACwpPG?=
 =?us-ascii?q?4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Ui?=
 =?us-ascii?q?ms4qt3VBPljjoMOiUn+2/LlMN/kKNboAqgpxNhxY7UfJqVP+d6cq/EYN8WWX?=
 =?us-ascii?q?ZNUsNXWiNPGIO8a5YEAfQHM+hWsoLxo0ICoBW6CAWpAu7k1z1GiWLs3aAizu?=
 =?us-ascii?q?ovER/I3AIjEdwAvnvbo9f6O7sdX+2u0KnFzi/OY+9K1Trz6oXFdA0qr/GWXb?=
 =?us-ascii?q?J3dMrc0VQhFx/bgVWIqYzqITWV3fkQvWie9eVgUeavhHAnqgpspTWv3dojip?=
 =?us-ascii?q?LSi4IJylHL6SV5wIEvKd2+U050e8SoEJRXtyGELoZ7RN4pTWJwuCsi17ELtp?=
 =?us-ascii?q?G2cDIKxZg63RLTdfOKf5aS7h7+UuuaPC12i2h/eL2lgha/6U2gyurhWcaqyF?=
 =?us-ascii?q?tKtS9FksXUtnAKyhzT9tCLSvtj8Uel3jaCzxzT5fteIUA1iKrbMIQtwr82lp?=
 =?us-ascii?q?odtkTDBTH5l1nsgK+KdkQr5uio6+P9brXgupCcLJN7hhv7MqQvnsyzGeU4Mg?=
 =?us-ascii?q?4QUGiH4emwybLu8ELjTLhKk/E6iLfVvZ/EKcgBu6K1GwpV3Zwi6xa7ATemyt?=
 =?us-ascii?q?MYnXwfIVJeZR2HlJPkO03OIf/kDfe/hE6gkDFwx//cJLHhDZLNLmbbnLf7Yb?=
 =?us-ascii?q?l981JcyBY0zd1H4JJUD7YBIOn1WkDrqNPXEAQ0MxaqzOn6CNVyzJ8eVXiTDa?=
 =?us-ascii?q?+eNaPYqUWI6f43I+mQeI8Vvy7wK+M76P7qjH85n0IdfKay0JsJZ3C3AO5mL1?=
 =?us-ascii?q?+aYXXymNcBF3kFvg4kQOztkl2CXiZZZ2yuUKIk+jE7FIWmAJ/bRo+2nbyB2i?=
 =?us-ascii?q?e6EYdQZm1dEFCDD2rnd4WeVPcQci6dPshhkjlXHYSmHqgn2QujtkffzKFhJ+?=
 =?us-ascii?q?HZ+WVMspfkz9587OD7jxw+9TVoSc+a1jfJB3p5mmIOWi8ewq9yuwp+x02F3K?=
 =?us-ascii?q?w+hOZXRvJJ4PYcaRs3LZ7RyaRBDtn2Xg/QNoOSRE2OXsStATZ3SMk4hdAJfR?=
 =?us-ascii?q?AuSJ2Zkhnf0n/yUPcunLuRCclxq/mN0g=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2D+AABvexxe/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBe4F9gWwBIBIqhAyJA4ZsBoE3iW6RSAkBAQEBAQEBAQE3AQGEQAKCHDgTA?=
 =?us-ascii?q?hABAQEEAQEBAQEFAwEBbIVDgjspAYJ6AQUjDwEFQRAJAg4KAgImAgJXBgEMB?=
 =?us-ascii?q?gIBAYJjP4JXJY0tm3SBMokXgT2BDiiMM3mBB4E4D4JdPoQjgzaCXgSNMIo7i?=
 =?us-ascii?q?COOOXWCQYJIk18GG5psjludByKBWCsIAhgIIQ+DJ1AYDZZlIwMwilyCQgEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 13 Jan 2020 14:20:34 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00DEJvhT259984;
        Mon, 13 Jan 2020 09:19:57 -0500
Subject: Re: [PATCH testsuite] tests/prlimit: avoid invalid limit combinations
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Cc:     Paul Bunyan <pbunyan@redhat.com>
References: <20200110143756.20101-1-omosnace@redhat.com>
 <f0a648c5-c105-f239-c6cc-7f827987a638@tycho.nsa.gov>
Message-ID: <78157c11-4d6f-c424-6e2e-a99bd3113098@tycho.nsa.gov>
Date:   Mon, 13 Jan 2020 09:21:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <f0a648c5-c105-f239-c6cc-7f827987a638@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/10/20 9:54 AM, Stephen Smalley wrote:
> On 1/10/20 9:37 AM, Ondrej Mosnacek wrote:
>> There is a bug in the prlimit test that causes invalid limit
>> combinations (soft > hard) to be created, leading to false failures.
>>
>> Consider for example an old setting of X for both soft and hard limit.
>> In such case the hard limit test tries to set the limits to X (soft) and
>> X/2 (hard), which always fails with -EINVAL.
>>
>> This patch fixes the logic to clamp the soft limit to keep it from
>> exceeding the hard limit. In such case the soft limit will also be
>> changed, but this can't be avoided.
>>
>> Fixes: 0782228ef06b ("selinux-testsuite: Add tests for prlimit(2) 
>> permission checks")
>> Reported-by: Paul Bunyan <pbunyan@redhat.com>
>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> 
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

Applied.

> 
>> ---
>>   tests/prlimit/parent.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/tests/prlimit/parent.c b/tests/prlimit/parent.c
>> index be320f0..11c0c25 100644
>> --- a/tests/prlimit/parent.c
>> +++ b/tests/prlimit/parent.c
>> @@ -147,6 +147,12 @@ int main(int argc, char **argv)
>>                   newrlim.rlim_max = 1024;
>>               else
>>                   newrlim.rlim_max = oldrlim.rlim_max / 2;
>> +            if (newrlim.rlim_cur > newrlim.rlim_max)
>> +                /*
>> +                 * This will change also soft limit, but
>> +                 * what else can you do in such case...
>> +                 */
>> +                newrlim.rlim_cur = newrlim.rlim_max;
>>           }
>>       }
>>
> 

