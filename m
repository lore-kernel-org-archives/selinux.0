Return-Path: <SRS0=n8ca=RC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20DEC43381
	for <selinux@archiver.kernel.org>; Wed, 27 Feb 2019 17:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C1020842
	for <selinux@archiver.kernel.org>; Wed, 27 Feb 2019 17:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paulo.ac header.i=@paulo.ac header.b="O+Z1XbLf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfB0Rqg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:46:36 -0500
Received: from mail.paulo.ac ([51.15.136.203]:51060 "EHLO mail.paulo.ac"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbfB0Rqg (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 27 Feb 2019 12:46:36 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.paulo.ac (Postfix) with ESMTP id 52CDB1C10AE;
        Wed, 27 Feb 2019 17:46:34 +0000 (UTC)
Received: from localhost (unknown [179.162.9.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.paulo.ac (Postfix) with ESMTPSA id 38B1E1C05C7;
        Wed, 27 Feb 2019 17:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=paulo.ac; s=201902;
        t=1551289592; bh=ZreVIz03jRgc+0M4D7q8KYs7jho7lHmfLJckks719Bo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=O+Z1XbLfEA5VJtn4f6D1NIFUu3Pj/r3Cco+YjKSlCszjEmih9h15T2M3uNkIPjJDp
         Up+Jv7tOKHM8S4bLsXzXjHDxQN48jG+LVILtrkSlevnKT7LjntnUxlnT2uPSzLTxV8
         xcFm1mQOBwD4+fkGJnyR9PwegZQwT8GPKhvlMCGNQzNAdUWql/+CnAv2gtMzcXUBB0
         V3zuRrS8SbkCdcGXWj72JZo2iCnUDMYibbIqXFxoNUo0qsRQRGO3VTYbijPm6+tbKE
         GjLDLBIrE991f2czNkgg2fGGIza7gGlU9mcVr7AFqNo2c7rWUcVoEN5xx3vfbqByCk
         lvJmbSMWecZtw==
From:   Paulo Alcantara <paulo@paulo.ac>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH] selinux: use kernel linux/socket.h definitions for PF_MAX
In-Reply-To: <CAHC9VhSaMcD232ZzXuS16usQL2DHSZRy5JqtFZWkjV+h6eUztw@mail.gmail.com>
References: <20190225005528.28371-1-paulo@paulo.ac> <87y36170y2.fsf@paulo.ac> <CAHC9VhSaMcD232ZzXuS16usQL2DHSZRy5JqtFZWkjV+h6eUztw@mail.gmail.com>
Date:   Wed, 27 Feb 2019 14:43:16 -0300
Message-ID: <87bm2xm8jv.fsf@paulo.ac>
MIME-Version: 1.0
Content-Type: text/plain
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Paul Moore <paul@paul-moore.com> writes:

> On Wed, Feb 27, 2019 at 12:07 PM Paulo Alcantara <paulo@paulo.ac> wrote:
>> Paulo Alcantara <paulo@paulo.ac> writes:
>> > When compiling genheaders and mdp from a newer host kernel, the
>> > following error happens:
>> >
>> >     In file included from scripts/selinux/genheaders/genheaders.c:18:
>> >     ./security/selinux/include/classmap.h:238:2: error: #error New
>> >     address family defined, please update secclass_map.  #error New
>> >     address family defined, please update secclass_map.  ^~~~~
>> >     make[3]: *** [scripts/Makefile.host:107:
>> >     scripts/selinux/genheaders/genheaders] Error 1 make[2]: ***
>> >     [scripts/Makefile.build:599: scripts/selinux/genheaders] Error 2
>> >     make[1]: *** [scripts/Makefile.build:599: scripts/selinux] Error 2
>> >     make[1]: *** Waiting for unfinished jobs....
>> >
>> > Instead of relying on the host definition, include linux/socket.h in
>> > classmap.h to have PF_MAX.
>> >
>> > Signed-off-by: Paulo Alcantara <paulo@paulo.ac>
>> > ---
>> >  scripts/selinux/genheaders/genheaders.c | 1 -
>> >  scripts/selinux/mdp/mdp.c               | 1 -
>> >  security/selinux/include/classmap.h     | 1 +
>> >  3 files changed, 1 insertion(+), 2 deletions(-)
>>
>> Ping?
>>
>> Could someone please take a look at this issue?
>
> It looks fine to me, but I typically don't merge patches this late in
> the development window (we are at -rc8), unless it is a serious bug
> fix.

Fair enough.

>> It's quite easy to reproduce on my host (4.20+) when building an
>> unpatched 4.14 kernel ...
>
> While this is a good patch that does fix a real but, the fact that it
> has been broken for several releases tells me this is not a serious
> bug and not likely worth the risk for the upcoming merge window
> (however small it may be).  There has been a lot of good work put into
> mdp very recently, and I expect to merge that, as well as your fix,
> once the upcoming merge window closes.

Looks good to me. Thanks!

Paulo
