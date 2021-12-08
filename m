Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF756C433EF
	for <selinux@archiver.kernel.org>; Wed,  8 Dec 2021 20:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbhLHVAf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Dec 2021 16:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbhLHVAf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Dec 2021 16:00:35 -0500
Received: from markus.defensec.nl (markus.defensec.nl [IPv6:2001:985:d55d::123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33EBC061746
        for <selinux@vger.kernel.org>; Wed,  8 Dec 2021 12:57:02 -0800 (PST)
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by markus.defensec.nl (Postfix) with ESMTPSA id 2E985FC1392;
        Wed,  8 Dec 2021 21:56:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=defensec.nl;
        s=default; t=1638997017;
        bh=5S/97GmIf42kbEqf3UQ0BA4JE3LXNqyE6DpnQvHqTKc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=H/LoJ4T2FbRP+5qyWq3tr/wimPb9t+aixY+vddGC5JVk5vQPrSwKIXY7qnXZXk1iY
         jINAl3V7WS2Q42NKDqeOHYw308OonxB/BSUgVq+a7UyYwqaRMUEp41trmoTC5UWrwJ
         8cj2+UhdcC3FT1H+NmaM7lXBBqmV5Hn3loKfACJw=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Topi Miettinen <toiwoton@gmail.com>, dburgener@linux.microsoft.com,
        selinux@vger.kernel.org
Subject: Re: [PATCH v3] selinux-notebook: New chapter: Hardening SELinux
References: <20211116105335.21864-1-toiwoton@gmail.com>
        <CAHC9VhQXDdnvE=Cc_4FBJMapmcAj_kNA134mE83Yw31rDvwJcQ@mail.gmail.com>
Date:   Wed, 08 Dec 2021 21:56:56 +0100
In-Reply-To: <CAHC9VhQXDdnvE=Cc_4FBJMapmcAj_kNA134mE83Yw31rDvwJcQ@mail.gmail.com>
        (Paul Moore's message of "Wed, 8 Dec 2021 15:20:09 -0500")
Message-ID: <87czm6zug7.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Paul Moore <paul@paul-moore.com> writes:

> On Tue, Nov 16, 2021 at 5:53 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>>
>> Describe some easy and more difficult methods to harden SELinux
>> policies.
>>
>> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>>
>> ---
>> v3:
>>  - Updated with comments from Daniel Burgener and Dominick Grift
>>
>> v2: https://lore.kernel.org/selinux/20211113095547.19406-1-toiwoton@gmail.com/
>>  - Updated with comments from Daniel Burgener
>>  - Fixed issues with PDF generation
>>
>> v1: https://lore.kernel.org/selinux/20211112125605.28915-1-toiwoton@gmail.com/
>> ---
>>  src/hardening.md                 | 205 +++++++++++++++++++++++++++++++
>>  src/implementing_seaware_apps.md |   2 +-
>>  src/reference_policy.md          |   2 +-
>>  src/section_list.txt             |   1 +
>>  src/toc.md                       |   1 +
>>  5 files changed, 209 insertions(+), 2 deletions(-)
>>  create mode 100644 src/hardening.md
>
> Thanks Topi!
>
> Daniel and Dominick, what do you think of this latest version?  Would
> one, or both of you like to tag it with a Reviewed-by?

Thanks Topi!

Reviewed-by: Dominick Grift <dominick.grift@defensec.nl>

>
> --
> paul moore
> www.paul-moore.com

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift
