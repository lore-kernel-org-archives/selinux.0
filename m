Return-Path: <SRS0=4tRG=2H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FDCC43603
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 13:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDCBC20717
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 13:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="gNtuF7x0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfLQNnu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Dec 2019 08:43:50 -0500
Received: from USFB19PA31.eemsg.mail.mil ([214.24.26.194]:13701 "EHLO
        USFB19PA31.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfLQNnu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Dec 2019 08:43:50 -0500
X-EEMSG-check-017: 36350679|USFB19PA31_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,325,1571702400"; 
   d="scan'208";a="36350679"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA31.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Dec 2019 13:43:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576590228; x=1608126228;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=MBH62dQg4SY2+ALCTXprItjH/Dle8KfQmqQ5hN8NMo8=;
  b=gNtuF7x0jnd7yab0KDUUjRe63PX5np0fNIo58+yYOoGM0U0uzyAolnrc
   JZNTf4qACwOZ6U9GIP138uCkduJnIwPhtY1mQp3UmwzCD6Q/bHBTqNf6s
   xy2g7dzZ1R2dnMzbkk3hGDklFuKis4gWe/cMEpVtkN7pIykSta1KhjZcJ
   qie2AtwsEg117sF2FyvrQybpJo+Ueh5KoUENUfLGP94mcxyAuVVXCMpxU
   kISkWWNLBLtV2+rIY3v9Iz01za/p+5yZP7iUfsqXR+c6fN1VxUcQLGhRP
   qFc9pHtmNIYfVEt5+g+RRhZKABCYpX5MrOOAqfO5SAR+mOaV/U+1HdJ40
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,325,1571702400"; 
   d="scan'208";a="36836683"
IronPort-PHdr: =?us-ascii?q?9a23=3A/2d/FBRQ+wXsISP/n44K7ZVtbdpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67ZByEt8tkgFKBZ4jH8fUM07OQ7/m7HzZYvt3c6zgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrNcajZdgJ6o+yh?=
 =?us-ascii?q?bErGZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXH?=
 =?us-ascii?q?dNUtpNWyBEBI6zYZEPD+4cNuhGqYfzqUYFoR+nCQSsAO7jzzlFjWL006Inye?=
 =?us-ascii?q?QsCRzI0hIuH9wOs3raotv6O6gQXu+pw6fF1inDYvFM1Dvh9ITFfBIsrPeRVr?=
 =?us-ascii?q?xwa8rRzkwvGhvYgFWMt4PlJzOV2foLs2OG8uRgUPigi2ojqw5vojmk28Ahip?=
 =?us-ascii?q?LUiYIO0V3E6SV4z5o1Jd2/UkJ7Z8WkH4FKuyGVMIt2XNovTmd1syg50r0LoY?=
 =?us-ascii?q?O3cScFxZg9xxPTduaLf5aH7x79TuqdPDF1j29/dr2lnRa9602gx/X5VsmzzV?=
 =?us-ascii?q?lFsDJIksLJtnARzxzT7dWHSudl8kehxzmP0wfT5/lYIU8uj6rbKoMhwqUqmp?=
 =?us-ascii?q?oSt0TDECj2mF7og6CKbEkk5uip5PjnYrXhvJOcMZN7ihriPag0n8y/AOA4Ph?=
 =?us-ascii?q?APX2id5+u8yKXu8VD2TbhFlPE7krTVvIrEKckUuKK1GRJZ3p4m6xmlDjem1N?=
 =?us-ascii?q?oYnWMALFJAYB+HlJXmO0rVLfDkDfawn1SskDBxy/DAJb3uGI/BLnfEkLf/Zb?=
 =?us-ascii?q?p98VJTyBIvzdBD4JJZEqkBL+juWk/1r9HYFgU2MxGww+r+DdV90YQeWXiRDa?=
 =?us-ascii?q?ODLKzStlqI7Po1I+aQfI8VpCr9K/896vHzl3A5n0QQfaq30psNbnC3APBmI0?=
 =?us-ascii?q?ScYXb2ntgBFmIKtBIkTOP2kF2CTSJTZ3GqUqIn+D47DIOmDYHeRoGim7GBwi?=
 =?us-ascii?q?i7EYNMZmxcCVCDD23od4OaVPcIci6SJdVhkjMcX7i7V4AhzQ2utBP9y7d/Le?=
 =?us-ascii?q?rb5DMXtYn/29hy4O3Tlgo/+iB0D8SH1GGNSmB0nn4NRzMs26B/u0N9wE+Z0a?=
 =?us-ascii?q?dkm/xYCcBT5/RRXwc9MJ7cyPd6C9boVQ3dYNiEU0ymTcu7DjExVN0x38UCbF?=
 =?us-ascii?q?p6G9WnlhrDxTalA6cJl7yXA5w56qDc0Gb/J8Zz1XbLz6Yhj14hQstAMW2pmL?=
 =?us-ascii?q?Rz+BTUB47MwA2lkPOSfLkYlAvK832OhT6WtVxceBZ5TKGAWHcYfEaQptP8sB?=
 =?us-ascii?q?DsVbirXI87PxNBxMjKEa5DbtnknB0SX/v4EMjPaGK23WGrDFCHwa3aP9miQH?=
 =?us-ascii?q?kUwCiIUBtMqAsU53vTcFFjVyo=3D?=
X-IPAS-Result: =?us-ascii?q?A2BNAABN2vhd/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF+gXSBbSASKoQEiQOGcgQGgRIliWqRRQkBAQEBAQEBAQE3AQGEQ?=
 =?us-ascii?q?AKCPDgTAhABAQEEAQEBAQEFAwEBbIVDgjspAYJ5AQEBAQIBIxVBBQsLGAICJ?=
 =?us-ascii?q?gICVwYNBgIBAYJfP4JTBSCtOXWBMoVPgz+BSIEOKIwyeYEHgTgMA4JdPodZg?=
 =?us-ascii?q?l4ElwxGlzOCPoJCiiSJJAYbmkmrKyKBWCsIAhgIIQ+DJ1ARFI0eF45BIwMwk?=
 =?us-ascii?q?gABAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 17 Dec 2019 13:43:46 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBHDhPic022959;
        Tue, 17 Dec 2019 08:43:25 -0500
Subject: Re: [RFC PATCH] selinux: randomize layout of key structures
To:     Paul Moore <paul@paul-moore.com>
Cc:     Dan Aloni <dan@kernelim.com>, selinux@vger.kernel.org,
        keescook@chromium.org, omosnace@redhat.com, jeffv@google.com
References: <20191213202838.7323-1-sds@tycho.nsa.gov>
 <20191214185002.GA8076@gmail.com>
 <e25e8aec-f3a2-1b35-ee6c-e2c9344db885@tycho.nsa.gov>
 <CAHC9VhQQQ15WjCZ5ijLhx5ttGeosqnwJ3TXcZYJouVqNPotpRw@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <707a7d03-b969-8409-5439-f649d10378db@tycho.nsa.gov>
Date:   Tue, 17 Dec 2019 08:44:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQQQ15WjCZ5ijLhx5ttGeosqnwJ3TXcZYJouVqNPotpRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/16/19 6:46 PM, Paul Moore wrote:
> On Mon, Dec 16, 2019 at 9:21 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 12/14/19 1:50 PM, Dan Aloni wrote:
>>> On Fri, Dec 13, 2019 at 03:28:38PM -0500, Stephen Smalley wrote:
>>>> I would have expected that two kernels built with the same config
>>>> with this enabled would have yielded different struct layouts in
>>>> pahole vmlinux output, but that doesn't appear to be the case. They
>>>> do have different seeds.  Am I doing something wrong?
>>>> Also, does DEBUG_INFO_BTF effectively undermine/negate the benefits of this
>>>> change if enabled?
>>>
>>> There's currently a long-standing bug with the GCC plugin where the
>>> generated debug info is in declaration order, not build order (see:
>>> [1]).  So, to verify it, try looking at the generated machine code.
>>
>> Thanks for that clarification; I can see in the code that the struct
>> layout has changed between the two kernel builds.
> 
> This likely falls under the category of stupid questions, but I'm
> assuming it passed the test suite w/o problems and the system
> generally ran as expected?

Yes, it tested fine for me. It did require a full rebuild to ensure that 
the randomized struct layouts were being used consistently throughout, 
and requires a make mrproper or distclean to remove the random seed 
before rebuilding if you want to generate a new random seed.

> I've also heard some comments about performance concerns, have you
> done any testing?  I'm guessing that isn't a major concern here
> because I don't recall any of the structs marked in this patch going
> through any optimizations, but I could be forgetting something (or
> missing a performance concern with RANDSTRUCT).

I haven't done any specific performance testing, but it will only impact 
users who enable RANDSTRUCT, so it is entirely opt-in, and as you say, 
these structs have not been especially optimized in the first place.

I think these same structures (or at least significant subsets thereof) 
are good candidates for write-rare protections if those ever reach 
mainline.  Haven't seen any progress there in a while.
