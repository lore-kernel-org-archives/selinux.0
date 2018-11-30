Return-Path: <SRS0=81+4=OJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376EFC04EB8
	for <selinux@archiver.kernel.org>; Fri, 30 Nov 2018 16:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F532146F
	for <selinux@archiver.kernel.org>; Fri, 30 Nov 2018 16:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F532146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbeLADOS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:14:18 -0500
Received: from uhil19pa12.eemsg.mail.mil ([214.24.21.85]:29018 "EHLO
        uhil19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeLADOS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Nov 2018 22:14:18 -0500
X-EEMSG-check-008: 361683326|UHIL19PA12_EEMSG_MP10.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by uhil19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 30 Nov 2018 16:04:29 +0000
X-IronPort-AV: E=Sophos;i="5.56,299,1539648000"; 
   d="scan'208";a="18308156"
IronPort-PHdr: =?us-ascii?q?9a23=3A6381QRWQ9x7e07kxtsXY8N2KMEHV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbRCFt8tkgFKBZ4jH8fUM07OQ7/iwHzRYqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba9xIRmssQndqtQdjJd/JKo21h?=
 =?us-ascii?q?bHuGZDdf5MxWNvK1KTnhL86dm18ZV+7SleuO8v+tBZX6nicKs2UbJXDDI9M2?=
 =?us-ascii?q?Ao/8LrrgXMTRGO5nQHTGoblAdDDhXf4xH7WpfxtTb6tvZ41SKHM8D6Uaw4VD?=
 =?us-ascii?q?K/5KpwVhTmlDkIOCI48GHPi8x/kqRboA66pxdix4LYeZyZOOZicq/Ye94VS3?=
 =?us-ascii?q?BBXsJMXCJfBI2yYZYEA+4YMepFs4Xxol0Dpga8CwaxHuPi0iJGiGH43aM60O?=
 =?us-ascii?q?ovHw/J0wMiEN0Sv3rZt8n1OaUIXOyp0KXFwzfOYvVL0jn98ojIdRUhrOmRU7?=
 =?us-ascii?q?Jsb8XR0UkvGB3Djl6NtILlOima1uAJs2eF7+trSOWii3U6pAFquTWv2scthZ?=
 =?us-ascii?q?XJhoIS0FzE8z55z5wvKd23T057f8epHZ1NvC+UMIt2R9ktQ2BuuCsiz70Jo5?=
 =?us-ascii?q?+7fCwTxJs93R7Qd/yHc4mW4h39TuqePTB4hHdjdbmihBiy6VCtxvDzW8S7yl?=
 =?us-ascii?q?pHrjdJnsPSun0CyRDf8NWLR/1g9Um7wzmPzRrc6uRcLEAxkqrUNoAuz6Yrlp?=
 =?us-ascii?q?oWrUTDBij2mFjqjKOOdkUr5Oyo6+P/b7X6vJCcLY50ihzlMqg0hsy+Afg3Mg?=
 =?us-ascii?q?gJX2SB/+SzyKbj8lHjTLVPj/02lrHVsJHcJcsFuq60GxJZ34ks5hqlDzqqzc?=
 =?us-ascii?q?4UkWcIIV5bYh6LkpDlO1TUL/D5Cfe/jU6skDBux/3eJb3uH47NI2PfkLbhYb?=
 =?us-ascii?q?l960lcxBA1zdBE/Z1YEL4BIPXtWkPprtzXEgc5MxCow+bgENhyzYIeWWaLAq?=
 =?us-ascii?q?ODLKzeq0WI5uU0LOaSfo8VpC39JuMq5/7rl3A5mFsdcbO10psQbXCyBu5mLF?=
 =?us-ascii?q?mBYXrwntcBFn8HvhEgQ+zuiV2CVyNTZnmpUqIi6TE0FpimAZ3ARo+zmryB2j?=
 =?us-ascii?q?m0HplMamBBEFCMHiSgS4LRZPYIbCObJ4dblTYJT6S6A9sr1BWq8gS80b1tI/?=
 =?us-ascii?q?DI4QUXsJvi0J5+4OiF0Vkp+Dh1CdmN+3+CQnsynW4SQTIymqdlrh9T0FCGhJ?=
 =?us-ascii?q?NkjuRYGNob3PZAVgM3JNaI1OBhI8zjUQLGONGSQRCpRcvwUmJ5dc4439JbOx?=
 =?us-ascii?q?U1IN6llB2WmnPzW7I=3D?=
X-IPAS-Result: =?us-ascii?q?A2AvAAC4XgFc/wHyM5BjGwEBAQEDAQEBBwMBAQGBVAMBA?=
 =?us-ascii?q?QELAYFaKWaBAieDeZQhTAYGgQgtiREOkCMwCAGEQAKDNCI3Bg0BAwEBAQEBA?=
 =?us-ascii?q?QIBbBwMgjYkAYJiAQUjFVELDgoCAiYCAiE2BgEMBgIBAYJePwGBaQMIDQ+mI?=
 =?us-ascii?q?YEvhUCCRA2CFwWBC4sPF3iBB4E4gmuCV0cDgUABAYMiglcCj3A2j2EuCY4Kg?=
 =?us-ascii?q?ycGGIFMj1OIe4Vvi08igVUrCAIYCCEPO4JshgiKcSEDMAEBAYECAQGLC4I+A?=
 =?us-ascii?q?QE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 30 Nov 2018 16:04:28 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wAUG4SKE030591;
        Fri, 30 Nov 2018 11:04:28 -0500
Subject: Re: Kernel Ueventd KConfig
To:     William Roberts <bill.c.roberts@gmail.com>, selinux@vger.kernel.org
References: <CAFftDdrK7mWf6j8TAB2f9XgvJU7a+7ssV6K_prZQk2m12Gv6rA@mail.gmail.com>
 <CAFftDdpmenVrbDp6f2tizjChmoOQYM=B22ydi6veRcuFDuucYg@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <42e8cf66-7a65-f304-85b2-8ea7c2dee0e9@tycho.nsa.gov>
Date:   Fri, 30 Nov 2018 11:06:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CAFftDdpmenVrbDp6f2tizjChmoOQYM=B22ydi6veRcuFDuucYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/30/18 10:24 AM, William Roberts wrote:
> On Fri, Nov 30, 2018 at 7:23 AM William Roberts
> <bill.c.roberts@gmail.com> wrote:
>>
>> I long time ago we had a discussion about disabling a KConfig when you
>> see denials like:
> 
> (tab + enter == send)
> 
> allow kernel chr_file create.
> 
> I can't find anything on it, and there's some certain KConfig setting
> to turn off, does anyone recall?

CONFIG_DEVTMPFS, see 
https://www.mail-archive.com/seandroid-list@tycho.nsa.gov/msg02389.html 
and https://www.mail-archive.com/seandroid-list@tycho.nsa.gov/msg02393.html.


