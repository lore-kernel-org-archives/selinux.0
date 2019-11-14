Return-Path: <SRS0=pcBM=ZG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2B8C432C3
	for <selinux@archiver.kernel.org>; Thu, 14 Nov 2019 17:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A9220718
	for <selinux@archiver.kernel.org>; Thu, 14 Nov 2019 17:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="FLv8EMHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfKNR45 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Nov 2019 12:56:57 -0500
Received: from UCOL19PA37.eemsg.mail.mil ([214.24.24.197]:59145 "EHLO
        UCOL19PA37.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfKNR4y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Nov 2019 12:56:54 -0500
X-EEMSG-check-017: 49442139|UCOL19PA37_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,304,1569283200"; 
   d="scan'208";a="49442139"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA37.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Nov 2019 17:56:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1573754209; x=1605290209;
  h=subject:from:to:references:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=yf6AyfCSToW3iJmlKGGJqCtPz30XxKK6Sn11JGk2ybc=;
  b=FLv8EMHfXmjR7EoQUxTpR5xFHVY8bE31Kf2sr4TJK72fiXG9DeyKXblb
   XxzbNvCbqo5C+iYIS+dhzMLwe3qY6arC8a1C2DtvfQvdpBVHEocWGILaN
   Fvu+UO1nieFjwPcXcgA719dGmW03pDPKdEvEpRGGVI/HU4LXvzojBu2Kp
   DwDNBahoIYv9Z8FiMw32O5Vf6sZXNA3Jak8OHYkzAA4MWffh+r2/KPsnP
   ivdUqQzIYTNRc460J4gw8tE2/QR08sOKmP0wFcS7Qp0XKc7puXG3McCz8
   ieDD7sO54saK51u/NOG44LsteTHLuCI2n5yE2p6kqfNTzDIQShECxF9Dp
   A==;
X-IronPort-AV: E=Sophos;i="5.68,304,1569283200"; 
   d="scan'208";a="30118488"
IronPort-PHdr: =?us-ascii?q?9a23=3AhEn19B1JNJctaQhBsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseMULfad9pjvdHbS+e9qxAeQG9mCsLQd0LGd6vi9EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCezbL9oMRm7owvcusYLjYd+Kqs61w?=
 =?us-ascii?q?fErGZPd+lK321jOEidnwz75se+/Z5j9zpftvc8/MNeUqv0Yro1Q6VAADspL2?=
 =?us-ascii?q?466svrtQLeTQSU/XsTTn8WkhtTDAfb6hzxQ4r8vTH7tup53ymaINH2QLUpUj?=
 =?us-ascii?q?ms86tnVBnlgzocOjUn7G/YlNB/jKNDoBKguRN/xZLUYJqIP/Z6Z6/RYM8WSX?=
 =?us-ascii?q?ZEUstXWSNBGIe8ZJYRAeQHM+hTso3xq0IAoBa6AAWhAv7kxD1ViX/sxaA0zu?=
 =?us-ascii?q?QvHx/I3AIjEdwBvnvbo9fpO6kdSu210KvFwC/fY/9K1zrw6o7FeQ0hr/GWWr?=
 =?us-ascii?q?JwdNLcx1QzFwzbllWQqZLqPzWI3eoQtmiU9e5gVeaxhG8ntgp8pSOvydo3io?=
 =?us-ascii?q?TSmoIUykzL9SV+wIovI924U1R0bcSrEJtXqSGXLo17Sd4hTWFwoCs217ILtJ?=
 =?us-ascii?q?GhcCUK1Zgr3QDTZvOZf4SS/x7uUvuaLy1ii3J/Yr2/gg6/8U2nyuLhSMa5yE?=
 =?us-ascii?q?1Kri9ZktnUsXANygDT5tCHSvRj+keh3i6C1xzJ5eFeIEA0iLHbJ4Q9wr8wip?=
 =?us-ascii?q?UTsUPDEjXwmErql6+Zal8o+u2p6+Tjernmp5mcOJFoigzmL6gjlcOyDf44Pw?=
 =?us-ascii?q?QTRWSX5+ux2KP58UHkWLlKi+c5kqjdsJDUP8Qboau5DhdO0ok+8BayFCum0d?=
 =?us-ascii?q?QEknkHK1JJYhSHj5PzNF3UL/D4Cum/j0y2kDh33/DGIqHhApLVI3jZkbfuYb?=
 =?us-ascii?q?Z95FRGyAUu1d9Q+4pbCrEbL/LyXE/+qsfYAwQiPAyowubnDsl92Z0EWWKJHK?=
 =?us-ascii?q?CZLLnevkOP5uIqO+OMfpMauC7hK/g54P7jlWQ5lkEZfamo25sXdX+5E+94I0?=
 =?us-ascii?q?WWf3XsmM0NEWQUsQokSuzlllmCXSRUZ3aoUKJvrg08XbinBofKXIzloLWA2i?=
 =?us-ascii?q?qgVslMZ2tGA0qAJnzfd4yFXfoXQCiOI8l9nyYCWKTnQIgkg1XmrwL+yrx6Ps?=
 =?us-ascii?q?LK9SAC85Huzt5446vUjx5h2yZzCpGmz2yVT2xy1lgNTjsy0bE39Vdx0X+fwK?=
 =?us-ascii?q?N4hLpeDtUV6PRXBFRpfaXAxvB3XoihEjnKec2EHRP/GYSr?=
X-IPAS-Result: =?us-ascii?q?A2BOAQB0lM1d/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF+AoFyLIFBMiqEKY8JVAaBESWJZpFDCQEBAQEBAQEBATQBAgEBh?=
 =?us-ascii?q?EACgiAkOQUNAg4BAQEEAQEBAQEFAwEBbIVDgjspAYJtAQUjFVELGAICJgICV?=
 =?us-ascii?q?wYBDAYCAQGCXz+CRwMJJbJdgTKJCoFIgQ4oAYwUGHiBB4E4DIJfPoIbhTqCX?=
 =?us-ascii?q?gSWVkWXA4I0gjaTEAYbgj6MG4srLY4anBYhgVgrCAIYCCEPgydQERSffiMDM?=
 =?us-ascii?q?IEFAQGREQEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 14 Nov 2019 17:56:48 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xAEHumA3013213;
        Thu, 14 Nov 2019 12:56:48 -0500
Subject: Re: [PATCH V2] selinux-testsuite: Add key_socket tests
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
References: <20191112171557.3067-1-richard_c_haines@btinternet.com>
 <fcd7dcc3-899f-2cb7-54d6-1f82100ed0e2@tycho.nsa.gov>
Message-ID: <3248f905-6d5d-acc8-6003-ace0d6177397@tycho.nsa.gov>
Date:   Thu, 14 Nov 2019 12:56:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <fcd7dcc3-899f-2cb7-54d6-1f82100ed0e2@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/14/19 9:24 AM, Stephen Smalley wrote:
> On 11/12/19 12:15 PM, Richard Haines wrote:
>> Test relevant key management socket permissions.
>>
>> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> 
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

Sorry, on second thought I had a question below.

<snip>
>> diff --git a/policy/test_key_socket.te b/policy/test_key_socket.te
>> new file mode 100644
>> index 0000000..5c36c72
>> --- /dev/null
>> +++ b/policy/test_key_socket.te
>> @@ -0,0 +1,75 @@
>> +#
>> +############## Test key management socket 'key_socket' 
>> #####################
>> +#
>> +attribute keysockdomain;
>> +
>> +type test_key_sock_t;
>> +domain_type(test_key_sock_t)
>> +unconfined_runs_test(test_key_sock_t)
>> +typeattribute test_key_sock_t testdomain;
>> +typeattribute test_key_sock_t keysockdomain;
>> +
>> +# key_socket rules:
>> +allow test_key_sock_t self:rawip_socket { create };

Why was the above rule on rawip_socket necessary (and likewise for the 
other domains)?

>> +allow test_key_sock_t self:capability { net_admin };
>> +allow test_key_sock_t self:key_socket { create write read setopt };
>> +# For CONFIG_NET_KEY=m
>> +allow test_key_sock_t kernel_t:system { module_request };

