Return-Path: <SRS0=UID1=TY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C424C072B5
	for <selinux@archiver.kernel.org>; Fri, 24 May 2019 12:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E5420879
	for <selinux@archiver.kernel.org>; Fri, 24 May 2019 12:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=perfinion-com.20150623.gappssmtp.com header.i=@perfinion-com.20150623.gappssmtp.com header.b="uIqRpgoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391418AbfEXMz0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 May 2019 08:55:26 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:42043 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391272AbfEXMz0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 May 2019 08:55:26 -0400
Received: by mail-pg1-f170.google.com with SMTP id 33so2068512pgv.9
        for <selinux@vger.kernel.org>; Fri, 24 May 2019 05:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=veZ+Riqb8h3zdXoWvvtxAtx7Wfrgt7nsugQ3c0LXd2c=;
        b=uIqRpgoOXmiGNoJhYpVMHOpPA7opM2E5Id6aE4xmpe+wXPRy/XIvqE38wbwDJ0WGnh
         kbvA+HE3oKkn9MHVk2/N0/WwahWDm10N+SzE3gBkh97VASjH7wd9uPvwnMirM5QWS4ho
         tLFyjtumIWV3ct3xpJQyeWfd3/eGnQLCtMR74WYrcHNA2jlJjZRNf2q6K7zZG8k89Be5
         C6FllkdFqwGNKlazQDt9kf4+0bGPJ1YAgSS/vA74jAQ+tYWNLYZ8YmsTiKSNDSi3gZbb
         eL/Tuvyv2LJq5vMQVX+wGRmw8duuAKX8YbN0vM9Pd2H5Y/5soJingZ1JOcM0amBfnigD
         kCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=veZ+Riqb8h3zdXoWvvtxAtx7Wfrgt7nsugQ3c0LXd2c=;
        b=ECLjzTpKj7pHIfAx9i8SO+CjweQVsPJHNQfZOGuKzmQI/osX/7G0mmPW514V2Qeo7o
         /+axSDWTdb1l3JSQQiKs84RtDmQwk/TWKBuWZcT+JRsIws28IcRs872pyfFSc/KdAnnm
         uVjA2mmGlV+Ywbt0gPcm8liHmF0n6NsRBbnO/Voz13a+VanYiikv03k53+0q9jaPKFcI
         UQkViHDpkHbKJ7TBHNlAISgSblqeeY8aspSCgjDvs7WFhcHh6ylqNoBmUmnnxGEtfcvP
         Yr+rNuGZ0S4griXqpdSkeRhlzCGneir63xqvFlxXOxp3mG8hoQBM2BRH3yKn+oazb9AD
         CRhA==
X-Gm-Message-State: APjAAAVQTKM2wqOZ/2DlO1kX6aiKncfZeJiFG8BCDA1qwJSj/lr7/FpW
        Rkm+Toe+A/scZ4fFNUK9eCn9sqXJj9RaLw==
X-Google-Smtp-Source: APXvYqwt1E68xOP6kVQoOAlPRfaAEtSVftAyNcZJ/skn7v1Be3qqKjURR2xFJ5f7g9t7zanuCgV4Vw==
X-Received: by 2002:aa7:9115:: with SMTP id 21mr84649424pfh.14.1558702525507;
        Fri, 24 May 2019 05:55:25 -0700 (PDT)
Received: from localhost ([2404:e801:2003:875:c789:3654:bf11:9d87])
        by smtp.gmail.com with ESMTPSA id q17sm3986290pfq.74.2019.05.24.05.55.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 05:55:24 -0700 (PDT)
Date:   Fri, 24 May 2019 20:55:22 +0800
From:   Jason Zaman <jason@perfinion.com>
To:     Laurent Bigonville <bigon@debian.org>
Cc:     selinux@vger.kernel.org
Subject: Re: SELinux integration in sysVinit
Message-ID: <20190524125522.GA48358@baraddur.perfinion.com>
References: <8cef19ba-5055-39fd-873f-73c7ba13cb8e@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cef19ba-5055-39fd-873f-73c7ba13cb8e@debian.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 24, 2019 at 01:17:00PM +0200, Laurent Bigonville wrote:
> Hello,
> 
> There is currently some discussion at [0] about SELinux integration in 
> sysVinit and the fact that somebody wants to delegate the loading of the 
> policy to an other binary than PID1.
> 
> Has somebody a remark or an objection to that proposal?

I object too. There is a *huge* change in functionality. Originally if
you boot with SELinux enforcing, there are only two things that can
happen. Either you end up with the policy loaded or the machine halts.

In the new patch, an attacker can just chmod -x /sbin/selinux-check then
next boot there will be no selinux enabled.

if (access(SELINUX_CHECK, X_OK) != 0) fails, the machine will continue
to boot without SELinux enabled. There is no difference between a user
without /sbin/selinux-check on purpose and an attacker just chmod -x'd
the tool.

SELinux does not protect /sbin anywhere near as much as /etc/selinux
(and doing that would probably be impossible). You'd need to check if
selinux is enabled and enforcing before skipping the loading ... which
is done by calling is_selinux_enabled() which needs linking to
libselinux. The important part of the original design is not
selinux_init_load_policy(), its is_selinux_enabled().

If someone really wants to run sysvinit without libselinux then just
switch to Gentoo, if you're on a non-selinux profile then you dont have
libselinux.so. But I'd definitely not want to have this patch in Gentoo
either.

-- Jason


> I already gave my POV regarding SELinux integration in debian.
> 
> Kind regards,
> 
> Laurent Bigonville
> 
> [0] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=929063
> 
