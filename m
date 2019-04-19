Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C36C282DA
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 19:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7AA20663
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 19:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="IFwMyS9E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfDSTn7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:43:59 -0400
Received: from ucol19pa10.eemsg.mail.mil ([214.24.24.83]:32338 "EHLO
        UCOL19PA10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbfDSTn7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Apr 2019 15:43:59 -0400
X-Greylist: delayed 3603 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Apr 2019 15:43:58 EDT
X-EEMSG-check-017: 666891569|UCOL19PA10_EEMSG_MP8.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.60,370,1549929600"; 
   d="scan'208";a="666891569"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 19 Apr 2019 17:21:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1555694480; x=1587230480;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=a6roYP5L2YIBverRsHoMdMq0Gs++LeeqzIzbnM3mZl8=;
  b=IFwMyS9E946oQAYMGte0cwz13a6Dt4BjFdjfI9vWMfhlvhWKuPMICGoq
   4KryZXjmLDZUolD0tT07VKj0x14jlNxozOW+vuFwH1CCZhwM7vnGq0Whq
   oUDtXOg9wKliJMqu8k0JglVWVZ1oEiTy8D/OIgMGN5IkEslXVP+7gJGLf
   0+rnYWeI+BK98KciKYmpoDBf7c3SZZXd/8YK/HsYCmM2w5uXMcFoNXgdS
   DIfijAHZT+BlqaroLZEGNdCvdFksLLw69tNBssN870zRuIzzQA8RjLzP+
   r/SapRywdUBFta8Vw6ak7aC3oDn1FZDpO4GYxzZAeHnss++f8mKoU2b9Y
   w==;
X-IronPort-AV: E=Sophos;i="5.60,370,1549929600"; 
   d="scan'208";a="26536760"
IronPort-PHdr: =?us-ascii?q?9a23=3Ad3v7yxZaeu3KD1AmoSu2/vX/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZrsu+bnLW6fgltlLVR4KTs6sC17OP9fuwEjVZqdbZ6TZeKcQKD0?=
 =?us-ascii?q?dEwewt3CUYSPafDkP6KPO4JwcbJ+9lEGFfwnegLEJOE9z/bVCB6le77DoVBw?=
 =?us-ascii?q?mtfVEtfre9FYHdldm42P6v8JPPfQpImCC9YbRvJxmqsAndrMYbjZZ/JqorxB?=
 =?us-ascii?q?bEoXREd/lLyWh1IV6fgwvw6t2/8ZJ+7yhcoe4t+9JFXa7nY6k2ULtUASg8PW?=
 =?us-ascii?q?so/sPrrx7DTQWO5nsYTGoblwdDDhbG4h/nQJr/qzP2ueVh1iaUO832Vq00Vi?=
 =?us-ascii?q?+576h3Uh/oiTwIOCA//WrKl8F/lqNboBampxxi347ZZZyeOfRicq/Be94RWH?=
 =?us-ascii?q?FMVdhNWSNfHoy8bpMPD+sfMuZes4n9vEYFoR+nCQWxGO/j1jpEi3n40q0g1+?=
 =?us-ascii?q?QqDB/I0gouEdkTtHjYtdX4OaMXXe2z0aLGzyjMb+lO1Dng9obIfBAvr/KCU7?=
 =?us-ascii?q?1+fsXey1UgGQzeg1WMqoHoJS+Z2vgDvmWZ6edrSOKhi3QgqwF0ujWvxMkthZ?=
 =?us-ascii?q?XTiYIP1lDI6zhyzYE3Jdy2VEF0e8SkEIdOuyyBK4t3Qt8tQ2FvuCogzL0Goo?=
 =?us-ascii?q?S0cDIFyJQg2R7ScvqKeJWL7BL7TOudPDh1iX1/dL+/mhq+61asx+LiWsWuzV?=
 =?us-ascii?q?pHqDdOnMPWuXAXzRPT79CKSv56/ki8xzmCzxvT6uRYIUAskqrbNoIhzqYwlp?=
 =?us-ascii?q?UNtUTDGTf7mFnsg6+Md0Uk5/Oo5/77YrTmupCcN4h0hhv4MqsygcywHf40Mg?=
 =?us-ascii?q?0PX2if4ei81bvj8lPlQLhSk/E7nabUvIraKMgGvKK1HQBY3pg55xqiFzum1c?=
 =?us-ascii?q?4XnXgDLFJLYhKHiI3pNknMIPH2EfiwmU6skCt1y/3dIr3gAonCLnjEkLv7e7?=
 =?us-ascii?q?Z98FRTxBA8zdBY+ZJYEqsBL+7rWk/tqNzYCQc0PBe1w+bjDNVxzJ8RVXiVAq?=
 =?us-ascii?q?+eK6zdr0WI5v40I+SXa48VvSzyK/kh5/L0kXA5nlodd7Gz3ZQLcHC4AuhmI0?=
 =?us-ascii?q?KBbHrjmNgBC2cLshAiTOzrllKCSzhTaGiyXq8n6DE0EpmmDZvGRo+3gbyB2D?=
 =?us-ascii?q?23EYFRZmBDElqMC2vnd52YW/cQbyKfOtRhnSIAVbigTY8hyB6vuRTky7poMO?=
 =?us-ascii?q?XU4DcUtZH929hv4e3cixUy+SZzD8SH3GHeB11zy1wJQzs31aU3m0t3x02fyu?=
 =?us-ascii?q?Asif1cEZpYoelOWAogKYX0wOlzCtS0UQXEKISnUlGjF9e5CjgrUoh5l90RaE?=
 =?us-ascii?q?9nB4+KkgHI3y3sBaQc0bOMGspnoernw3HtKpMlmD793647ggxjG5YeOA=3D?=
 =?us-ascii?q?=3D?=
X-IPAS-Result: =?us-ascii?q?A2AFAQBCArpc/wHyM5BmHQEBBQEHBQGBUwYBCwGBZiqBO?=
 =?us-ascii?q?jIohA6Ie4wNCCWYSxSBZzwBghKCLgKGGSM2Bw4BAwEBAQQBAQEBAgFsKII6K?=
 =?us-ascii?q?QGCZwEFIw8BBUEQCQIJBQoCAiYCAlcGDQYCAQGCXz+CCYtGm2WBL4VHhGSBC?=
 =?us-ascii?q?ycBi0mBVkCBOAyCXz6ELIMiglcEgSsBkF2USAYDggqFQIxkBhuCC4oPiHeiO?=
 =?us-ascii?q?gUsgVYrCkGBaIFOgkWOJyMDMIEGAQGPagEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 19 Apr 2019 17:21:20 +0000
Received: from localhost.localdomain (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x3JHLJoZ021515;
        Fri, 19 Apr 2019 13:21:19 -0400
Subject: Re: [Non-DoD Source] [PATCH 0/2] checkmodule: allow building modules
 of a specific version
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Gary Tierney <gary.tierney@fastmail.com>, selinux@vger.kernel.org,
        Steve Smalley <sds@tycho.nsa.gov>
References: <20190417163731.3434-1-gary.tierney@fastmail.com>
 <3ef5bbf3-4d1b-26a2-aa18-d32044259064@tycho.nsa.gov>
 <CAFftDdroVYV232N7c997SgP0Owi0J+uFEnzVCdEaJAiKSz86Qw@mail.gmail.com>
 <b845d25a-53bf-97f9-0f8d-fc9df477ad53@tycho.nsa.gov>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <fadcf2d6-9012-ce65-84c3-2646aaf72949@tycho.nsa.gov>
Date:   Fri, 19 Apr 2019 13:21:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b845d25a-53bf-97f9-0f8d-fc9df477ad53@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 4/18/19 1:49 PM, jwcart2 wrote:
> On 4/18/19 11:18 AM, William Roberts wrote:
>> On Thu, Apr 18, 2019 at 6:27 AM jwcart2 <jwcart2@tycho.nsa.gov> wrote:
>>>
>>> On 4/17/19 12:37 PM, Gary Tierney wrote:
>>>> These changes come from a report by a user on the Freenode IRC channel that
>>>> they were unable to build policies for a machine that has an older version of
>>>> libsepol installed.
>>>>
>>>> A new `-c` option that mirrors checkpolicy's own has been added to checkmodule,
>>>> and the output of a simple test is shown below:
>>>>
>>>> $ cat > test.te <<EOF
>>>> module test 1.0;
>>>>
>>>> require {
>>>>       type domain;
>>>>       type file_type;
>>>>       class file { read write };
>>>> }
>>>>
>>>> allow domain file_type : file { read write };
>>>> EOF
>>>> $ obj/usr/bin/checkmodule -m -M -c 10 -o test.mod test.te
>>>> $ checkpolicy/test/dismod test.mod
>>>> Reading policy...
>>>> ... snip ...
>>>> Binary policy module file loaded.
>>>> Module name: test
>>>> Module version: 1.0
>>>> Policy version: 10
>>>>
>>>> Worthy of note, however, is that these policy version numbers differ from those
>>>> used by the kernel policy format.
>>>>
>>>> Gary Tierney (2):
>>>>     checkmodule: add support for specifying module policy version
>>>>     dismod: print policy version of loaded modules
>>>>
>>>>    checkpolicy/checkmodule.8 |  5 ++++-
>>>>    checkpolicy/checkmodule.c | 29 +++++++++++++++++++++++++++--
>>>>    checkpolicy/test/dismod.c |  4 ++--
>>>>    3 files changed, 33 insertions(+), 5 deletions(-)
>>>>
>>>
>>> Acked-by: James Carter <jwcart2@tycho.nsa.gov>
>>
>> James there's a superfluous newline between strtol() and errno.
>>
> 
> Thanks, I missed that.
> 
> I don't see the need for another version of the patches. I can fix that minor 
> issue when I merge the patches tomorrow.
> 

Merged with the extra newline removed.

>>>
>>> -- 
>>> James Carter <jwcart2@tycho.nsa.gov>
>>> National Security Agency
>>
> 
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
