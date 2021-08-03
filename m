Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C598AC4338F
	for <selinux@archiver.kernel.org>; Tue,  3 Aug 2021 17:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A08E660F70
	for <selinux@archiver.kernel.org>; Tue,  3 Aug 2021 17:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238071AbhHCRXP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 Aug 2021 13:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237804AbhHCRXN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 Aug 2021 13:23:13 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA205C06175F
        for <selinux@vger.kernel.org>; Tue,  3 Aug 2021 10:23:01 -0700 (PDT)
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id BC8E02A006A;
        Tue,  3 Aug 2021 19:22:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl BC8E02A006A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1628011380;
        bh=+n2641+lo9Ogf6ohQIu+bAsZA+kQmMxtyN3D9ZSHokA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=avTpQlUH3assnvWjhDmiMpbUK/TL81w1k/U2qDMnNIM5ONpT1TPI3480jer6yHS2x
         YtPyutcXmMurGDazVW1bfvpDHjCObC505XKhsoeW3qRC7hzLGWshml7rkkDJHmniiK
         vQMrncl8bxuqWUc7fpIB7iWDQ0ps6zvoo5HvKiMc=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     "Weber, Matthew L Collins" <Matthew.Weber@collins.com>
Cc:     "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "Graziano, David D Collins" <david.graziano@collins.com>
Subject: Re: LSM policy options for new GPIO kernel driver interface
References: <CY1P110MB0102ED0206E9498C742F6DC0F2EF9@CY1P110MB0102.NAMP110.PROD.OUTLOOK.COM>
Date:   Tue, 03 Aug 2021 19:22:56 +0200
In-Reply-To: <CY1P110MB0102ED0206E9498C742F6DC0F2EF9@CY1P110MB0102.NAMP110.PROD.OUTLOOK.COM>
        (Matthew L. Collins Weber's message of "Mon, 2 Aug 2021 17:08:14
        +0000")
Message-ID: <87im0m789b.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

"Weber, Matthew L Collins" <Matthew.Weber@collins.com> writes:

> All,
>
> Since the 5.10 kernel, the GPIO subsystem has migrated from a sysfs
> based GPIO export method [1] (everything is a file) to a character
> device[2] + library[3].  The new framework[2] provides users with
> signal debouncing and other features that benefit embedded products.
> The legacy method[1] allowed fine policy control of who can export /
> set / get the GPIO state.  We have not found a similar security policy
> path with the new approach.  Has anyone brainstormed strategies for
> the new character device-based interface without adding a userspace
> broker to enforce another level of rules?  The ideal case would be to
> keep all the controls within the SELinux refpolicy such that testing
> can be all-inclusive.
>
> I'd be interested in what people think, such that I can prepare a
> university research project submission for Fall 2021 to build a
> prototype.

Disclaimer: I am not qualified to give advice

SELinux supports IOCTL allow-listing and so access to the various GPIO
IOCTL can probably already be controlled.

So for example you can probably already control access to things like:

GPIO_GET_CHIPINFO_IOCTL
GPIO_GET_LINEINFO_UNWATCH_IOCTL
GPIO_V2_GET_LINEINFO_IOCTL
GPIO_V2_GET_LINEINFO_WATCH_IOCTL
GPIO_V2_GET_LINE_IOCTL
GPIO_V2_LINE_SET_CONFIG_IOCTL
GPIO_V2_LINE_GET_VALUES_IOCTL
GPIO_V2_LINE_SET_VALUES_IOCTL

Other than that you could consider adding LSM hooks for GPIO object
related syscalls and adding SELinux check for GPIO syscall operations
but not sure if that adds any value to the above.

>
> Best Regards,
> --
> Matt Weber
>
> [1] https://www.kernel.org/doc/html/latest/driver-api/gpio/legacy.html#sysfs-interface-for-userspace-optional
> [2] https://www.kernel.org/doc/html/latest/driver-api/gpio/using-gpio.html
> [3] https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/about/

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
