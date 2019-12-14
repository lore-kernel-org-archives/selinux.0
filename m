Return-Path: <SRS0=NFTj=2E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6423C43603
	for <selinux@archiver.kernel.org>; Sat, 14 Dec 2019 20:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 356CE214D8
	for <selinux@archiver.kernel.org>; Sat, 14 Dec 2019 20:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="WfHDSFOP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfLNUQS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 14 Dec 2019 15:16:18 -0500
Received: from 9.mo7.mail-out.ovh.net ([46.105.60.248]:59708 "EHLO
        9.mo7.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfLNUQS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 14 Dec 2019 15:16:18 -0500
X-Greylist: delayed 12601 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Dec 2019 15:16:18 EST
Received: from player734.ha.ovh.net (unknown [10.108.57.226])
        by mo7.mail-out.ovh.net (Postfix) with ESMTP id 90197142AC4
        for <selinux@vger.kernel.org>; Sat, 14 Dec 2019 17:40:58 +0100 (CET)
Received: from awhome.eu (p57B7EAA4.dip0.t-ipconnect.de [87.183.234.164])
        (Authenticated sender: postmaster@awhome.eu)
        by player734.ha.ovh.net (Postfix) with ESMTPSA id 87924D373498;
        Sat, 14 Dec 2019 16:40:55 +0000 (UTC)
To:     selinux@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1576341627;
        bh=PX5c0hnu32u4SGNecXgJaF+xxS0X/wQruR2oSRtw2GQ=;
        h=To:Cc:From:Subject:Date;
        b=WfHDSFOPq+oZyS6dNKPW6uKknskDrtVQybXk7cep0hkmWTIJYFgr/tDpYjzNK+XlD
         3cWQt6jQIljlep4w273kWTdAcP/cAsF+qJrt0sKI1kuRkgIeInLO7TcF0ToLeFGG0a
         GFVpT+NaEvwdMGomyHM9PLN74oqTeh+wBqQLvPtw=
Cc:     acgoide@tycho.nsa.gov, paul@paul-moore.com
From:   Alexander Wetzel <alexander@wetzel-home.de>
Subject: "watch" - Problem when using kernel >= 5.4
Message-ID: <9d54debb-7031-4d93-38b7-62c853289512@wetzel-home.de>
Date:   Sat, 14 Dec 2019 17:40:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 1196268654371478528
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvddtuddgleefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefvhffukffffgggtgfgsehtjeertddtfeejnecuhfhrohhmpeetlhgvgigrnhguvghrucghvghtiigvlhcuoegrlhgvgigrnhguvghrseifvghtiigvlhdqhhhomhgvrdguvgeqnecuffhomhgrihhnpehgvghnthhoohdrohhrghenucfkpheptddrtddrtddrtddpkeejrddukeefrddvfeegrdduieegnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeegrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheprghlvgigrghnuggvrhesfigvthiivghlqdhhohhmvgdruggvpdhrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

I've a strange problem with selinux when switching a kernel >= 5.4.0 and 
since this could be an unintended regression I want to report it here, too.

There are two threads in the Gentoo forum with more details:
https://forums.gentoo.org/viewtopic-t-1105128.html (started by me)
https://forums.gentoo.org/viewtopic-t-1104916.html (looks like the same 
underlying issue)

In a nutshell commit ac5656d8a4cd ("fanotify, inotify, dnotify, 
security: add security hook for fs notifications") added new hooks for 
fs notifications which also seem to requite updated user space and 
policies which seem to be unavailable as for now.

So when updating the kernel to >= 5.4.0 all processes trying to register 
for file notifications will be blocked. And at least I was unable to 
add rules for the new permission "watch", even after updating all 
selinux tools/libraries and policies to the upstream git versions - as 
provided by Gentoo's -9999 version of the packages.

Dec  8 14:49:01 web kernel: audit: type=1400 audit(1575812941.870:2069): 
avc:  denied  { watch } for  pid=2826 comm="crond" 
path="/var/spool/cron/crontabs" dev="sda3" ino=2539899 
scontext=system_u:system_r:crond_t 
tcontext=system_u:object_r:cron_spool_t tclass=dir permissive=0

I ended up reverting commit ac5656d8a4cd ("fanotify, inotify, dnotify, 
security: add security hook for fs notifications") and asked in the 
gentoo forum - so far without success (link above) - how that should 
work properly.

If there is a way to use an unmodified kernel >= 5.4.0 with older (so 
far all current) selinux tools and policies I did miss it.

Do you have a pointer how I can keep the commit ac5656d8a4cd in a 
selinux enabled system in enforcing mode without breaking all file 
change notifications?

Alexander





