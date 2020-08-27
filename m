Return-Path: <SRS0=ySGb=CF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C10C433E1
	for <selinux@archiver.kernel.org>; Thu, 27 Aug 2020 15:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A411622B40
	for <selinux@archiver.kernel.org>; Thu, 27 Aug 2020 15:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="gAr3DdmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgH0Pry (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:47:54 -0400
Received: from mailomta7-sa.btinternet.com ([213.120.69.13]:36371 "EHLO
        sa-prd-fep-040.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726200AbgH0Prx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Aug 2020 11:47:53 -0400
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-040.btinternet.com with ESMTP
          id <20200827154750.HFUE5290.sa-prd-fep-040.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Thu, 27 Aug 2020 16:47:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1598543270; 
        bh=XdYDRHFlIjR9qs5HKzC9Sq7m5R1hXSRe1ReyZCidPrY=;
        h=To:Cc:Message-ID:Subject:MIME-Version:From:Date;
        b=gAr3DdmJceM4O8RKGdGhq1qolm6SjkWz8x645txwqjK5aF8CZULj1VxHeiDITIsZtEW7wawwksxqBSLEcZE/fXfs1hZS9yY7LsZAnT87ZTyIBZaOgzc9y7FOTBDVu+vK38mGPfZvXjN+eebNBlk7So9fbV8cjlg9dVatQu+abQm39dxOVkZNFMttkGUn9yfjUXkRy0e+ktFgtdTZY2kamySFUZ0zwq/rytiUl9NoqxcTrhFx7v3x98wsvSlGAVJnhseY/K6MYkx9NILDrrewOsIk1hq4kxcrCKNqlALGbS3zoD7vdcqnVH4D+/U4osJ6MHU9lj2y8HTajPu66ucK+Q==
Authentication-Results: btinternet.com; none
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedruddvgedgkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefvkffugggtgfgfihfhffesthejredttderjeenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepheetveehveeviedvjeduhfdtleehffeftdfgveefjeefkeejledtfefhtedtfffgnecuffhomhgrihhnpehmrghrtgdrihhnfhhopdhlihgsrhgvshifrghnrdhorhhgnecukfhppedutddrvddrfeekrdelledpkeeirddukeegrdelledrjeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghlohepshgrqdhprhguqdhugihfvghpqddtudekrdgsthhmgidqphhrugdrshihnhgthhhrohhnohhsshdrnhgvthdpihhnvghtpedutddrvddrfeekrdelledpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoegthhhpvggsvghniheslhhinhhugidrmhhitghrohhsohhfthdrtghomheqpdhrtghpthhtohepoeguohhmihhnihgtkhdrghhrihhfthesuggvfhgvnhhsvggtrdhnlheqpdhrtghpthht
        ohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeoshhtvghphhgvnhdrshhmrghllhgvhidrfihorhhksehgmhgrihhlrdgtohhmqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from sa-prd-uxfep-018.btmx-prd.synchronoss.net (10.2.38.99) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340)
        id 5ED9B8A70DD79FE4; Thu, 27 Aug 2020 16:47:50 +0100
Received: from [86.184.99.78]
        by email.bt.com with HTTP; Thu, 27 Aug 2020 16:47:50 +0100
To:     Chris PeBenito <chpebeni@linux.microsoft.com>,
        Dominick Grift <dominick.grift@defensec.nl>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Message-ID: <332168a5.dd08.174309a9344.Webtop.99@btinternet.com>
Subject: Re: Userspace AVC auditing on policy load
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed; delsp=no
Content-Transfer-Encoding: 7bit
User-Agent: OWM Mail 3
X-SID:  99
X-Originating-IP: [86.184.99.78]
From:   Richard Haines <richard_c_haines@btinternet.com>
Date:   Thu, 27 Aug 2020 16:47:50 +0100 (BST)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 2020-08-26 at 15:15 -0400, Chris PeBenito wrote:
> On 8/26/20 3:07 PM, Dominick Grift wrote:
>> Chris PeBenito <chpebeni@linux.microsoft.com> writes:
>>

>>> On 8/26/20 10:46 AM, Stephen Smalley wrote:
>>>> On Wed, Aug 26, 2020 at 10:35 AM Chris PeBenito
>>>> <chpebeni@linux.microsoft.com> wrote:
>>>>> On 8/26/20 9:25 AM, Chris PeBenito wrote:
>>>>>> I was looking into this dbus-broker audit message, which
>>>>>> has the wrong audit type:
>>>>>>

>>>>>> audit[422]: USER_AVC pid=422 uid=999 auid=4294967295
>>>>>> ses=4294967295
>>>>>> subj=system_u:system_r:system_dbusd_t msg='avc:  received
>>>>>> policyload notice
>>>>>> (seqno=2)
>>>>>>

>>>>>> This is due to dbus-broker setting their avc log callback
>>>>>> to send USER_AVC audit
>>>>>> messages for everything that comes to the libselinux log
>>>>>> callback. I think the
>>>>>> right thing to do there is to change it to emit
>>>>>> USER_SELINUX_ERR audit messages
>>>>>> if the log message is SELINUX_ERROR, otherwise log the
>>>>>> message using their
>>>>>> regular method (stderr I think).
>>>>>>

>>>>>> But the question became, why is the userspace AVC not
>>>>>> simply emitting its own
>>>>>> USER_MAC_POLICY_LOAD audit message instead of sending a
>>>>>> message to the log
>>>>>> callback?
>>>>>

>>>>> Ok, I missed that there is a SELINUX_AVC log type and that's
>>>>> how the userspace
>>>>> denial messages are sent out. How about adding
>>>>> SELINUX_POLICYLOAD and
>>>>> SELINUX_ENFORCE log types so that callers can emit
>>>>> appropriate audit messages?
>>>> Do we need two different new types or just one?  Otherwise, I
>>>> don't
>>>> have a problem with adding new ones as long as it doesn't break
>>>> existing applications.
>>>

>>> Regarding the risk of breaking existing applications, I did some
>>> checking on some userspace AVC users and what they do in their
>>> log
>>> callback:
>>>

>>> * systemd only audits SELINUX_AVC and SELINUX_ERROR messages and
>>>    ignores others(as Petr noted)
>>> * xorg-server audits SELINUX_AVC correctly but audits
>>> SELINUX_INFO as
>>>    USER_MAC_POLICY_LOAD and everything else it ignores the type
>>> and
>>>   audits as AUDIT_USER_SELINUX_ERR
>>> * dbus-broker ignores type and audits everything as USER_AVC
>>> * dbus-service ignores type and audits everything as USER AVC
>>> * pam: pam_rootok ignores type and audits everything as USER_AVC
>>> * sepgsql custom AVC implementation (this was news to me)
>>> * shadow-utils only audits SELINUX_AVC and SELINUX_ERROR messages
>>> and
>>>    others go to syslog
>>> * cronie: no callback set
>>>

>>> That's all the ones I could think of.  Which ones am I missing?
>>

>> Probably libreswan, AFAIK that one might also still be using
>> avc_has_perm() instead of selinux_check_access().
>

> You're correct, it is still use avc_has_perm().  There is no log
> callback set here.
>

ipsec-tools (racoon) is another. I did patches for this and LibreSwan a 
few years ago, they never went far:

ipsec-tools: 
https://marc.info/?l=ipsec-tools-devel&m=149441917501329&w=2
LibreSwan: 
https://lists.libreswan.org/pipermail/swan-dev/2017-May/001860.html


