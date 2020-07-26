Return-Path: <SRS0=OFWW=BF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F45FC433E1
	for <selinux@archiver.kernel.org>; Sun, 26 Jul 2020 16:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B56202073E
	for <selinux@archiver.kernel.org>; Sun, 26 Jul 2020 16:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="HoyevgcW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgGZQDq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 26 Jul 2020 12:03:46 -0400
Received: from agnus.defensec.nl ([80.100.19.56]:56160 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbgGZQDq (ORCPT <rfc822;selinux@vger.kernel.org>);
        Sun, 26 Jul 2020 12:03:46 -0400
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 3880F2A0FFC;
        Sun, 26 Jul 2020 18:03:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 3880F2A0FFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1595779422;
        bh=Ewfw5YmZmBt3RKZBzAgG5vRXmtdO8b6JZ3A59FRp30M=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=HoyevgcWkWdeCVIidHhEkf7OChT30VWxzPjARMsNef/wb4faZZbm7kiDI78SDmfDM
         EJhQ8Zcm4kbAeXhQMrErQNt4ifUbLVIXg5fM13plGy0YFtcKHMYPONjn5RCt82moOj
         vNfghymc2htYHy2V31/TAkK5+1f01t499Y6JLTh4=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Ian Pilcher <arequipeno@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Subject: Re: File context rule not working
References: <31fac4d5-3c2e-75b5-5759-52322d8dd733@gmail.com>
Date:   Sun, 26 Jul 2020 18:03:37 +0200
In-Reply-To: <31fac4d5-3c2e-75b5-5759-52322d8dd733@gmail.com> (Ian Pilcher's
        message of "Sun, 26 Jul 2020 10:03:00 -0500")
Message-ID: <ypjl1rkynu06.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ian Pilcher <arequipeno@gmail.com> writes:

> I'm tearing my hair out trying to figure out why this rule isn't
> matching.
>
>   /usr(/local)?/bin/raidcheck    system_u:object_r:raidcheck_exec_t:s0

Some suggestions in order of likelyness.

It might be that due to the (/local)? part another entry that is more
specific takes precedence. (try splitting the spec into two lines, or
even better make /usr/local/bin the equivalence of /usr/bin). You might
also be able to make it make it more specific by adding the -- filespec,
which you probably should have done anyway (always be as specific as
possible):

/usr(/local)?/bin/raidcheck -- system_u:object_r:raidcheck_exec_t:s0

Maybe these are hardlinks?

Maybe there are equivalence rules in place for these locations. Then you
would have to make the spec apply to the location of which this location
is the equivalence.

>
> The rule shows up in the output of 'semanage fcontext -l', so it's
> loaded, but either /usr/bin/raidcheck and /usr/local/bin/raidcheck  are
> still being set to bin_t.
>
> Is there any way to get restorecon to show the steps that it takes to
> determine the context for a file?

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
