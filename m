Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C513EC43603
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 12:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70256206D3
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 12:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="ipRfkaK8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfLPMHB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 07:07:01 -0500
Received: from 5.mo179.mail-out.ovh.net ([46.105.43.140]:51133 "EHLO
        5.mo179.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbfLPMHA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 07:07:00 -0500
X-Greylist: delayed 151841 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Dec 2019 07:06:59 EST
Received: from player690.ha.ovh.net (unknown [10.108.16.68])
        by mo179.mail-out.ovh.net (Postfix) with ESMTP id B9CF2152D8E
        for <selinux@vger.kernel.org>; Mon, 16 Dec 2019 12:31:31 +0100 (CET)
Received: from awhome.eu (p4FF918CF.dip0.t-ipconnect.de [79.249.24.207])
        (Authenticated sender: postmaster@awhome.eu)
        by player690.ha.ovh.net (Postfix) with ESMTPSA id ABFB2D382197;
        Mon, 16 Dec 2019 11:31:28 +0000 (UTC)
Subject: Re: "watch" - Problem when using kernel >= 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1576495856;
        bh=IuxQ5PfMqtdN8RK9r9789R45uRu7r0Qqslk75uocZUs=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=ipRfkaK8VQzx0obicwFvx9adZ9TVaM2a7gKLsafcQqce0GMwb8p6e7+9xW6l/waOZ
         q/pFlcWs1V1pWP87hxcUwl/rHX9YJ0p7FaP4MPHf1akN5E9HgAXjeqzAztpjFfi7Bg
         XSW0YvLXFqlhSfySmdFDCXdcltR0ca7yekurV/AE=
To:     selinux@vger.kernel.org, acgoide@tycho.nsa.gov, paul@paul-moore.com
References: <9d54debb-7031-4d93-38b7-62c853289512@wetzel-home.de>
 <20191214203034.GA233591@brutus.lan>
From:   Alexander Wetzel <alexander@wetzel-home.de>
Message-ID: <362fa2a9-91c7-ebb4-3283-f53b852aa3d7@wetzel-home.de>
Date:   Mon, 16 Dec 2019 12:31:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191214203034.GA233591@brutus.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 7715510587443649536
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvddthedgfedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeehnecuhfhrohhmpeetlhgvgigrnhguvghrucghvghtiigvlhcuoegrlhgvgigrnhguvghrseifvghtiigvlhdqhhhomhgvrdguvgeqnecukfhppedtrddtrddtrddtpdejledrvdegledrvdegrddvtdejnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheiledtrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheprghlvgigrghnuggvrhesfigvthiivghlqdhhohhmvgdruggvpdhrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

>> Dec  8 14:49:01 web kernel: audit: type=1400 audit(1575812941.870:2069):
>> avc:  denied  { watch } for  pid=2826 comm="crond"
>> path="/var/spool/cron/crontabs" dev="sda3" ino=2539899
>> scontext=system_u:system_r:crond_t tcontext=system_u:object_r:cron_spool_t
>> tclass=dir permissive=0
>>
>> I ended up reverting commit ac5656d8a4cd ("fanotify, inotify, dnotify,
>> security: add security hook for fs notifications") and asked in the gentoo
>> forum - so far without success (link above) - how that should work properly.
>>
>> If there is a way to use an unmodified kernel >= 5.4.0 with older (so far
>> all current) selinux tools and policies I did miss it.
>>
>> Do you have a pointer how I can keep the commit ac5656d8a4cd in a selinux
>> enabled system in enforcing mode without breaking all file change
>> notifications?
>>
>> Alexander
> 
> I do not believe there is a regression. However support in the policy for this functionality may be lagging behind (be non existent as of now).
> You could try this as a temporary workaround:
> 
> echo "(handleunknown allow)" > mytest.cil && sudo semodule -i mytest.cil
> 
> If that works then that should tell selinux to ignore the watch access vector permissions (and any other permission unknown to the policy).
> 

Thank you very much, that was the tip I was missing

While the workaround itself is not working
$ echo "(handleunknown allow)" > mytest.cil && sudo semodule -i mytest.cil
Password:
Policy can not have more than one handleunknown
Failed to verify cil database
Failed to verify cil database
/usr/sbin/semodule:  Failed!

that was the "knob" I was missing and with your tip I found the way how 
this is intended to be handled.

I've now simply executed these commands

echo "handle-unknown = allow" >> /etc/selinux/semanage.conf
semodule -B

Which solves the issue without any reverts.

Alexander
