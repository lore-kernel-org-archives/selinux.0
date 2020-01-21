Return-Path: <SRS0=4+dM=3K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D452C2D0CE
	for <selinux@archiver.kernel.org>; Tue, 21 Jan 2020 14:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B102070C
	for <selinux@archiver.kernel.org>; Tue, 21 Jan 2020 14:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="BJ0RHi+q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgAUOVo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Jan 2020 09:21:44 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37853 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbgAUOVo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Jan 2020 09:21:44 -0500
Received: by mail-lf1-f66.google.com with SMTP id b15so2425998lfc.4
        for <selinux@vger.kernel.org>; Tue, 21 Jan 2020 06:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LaWAsuhw20Bni3MnmjCRP8MnUuoyndyuSnU94kuhLEE=;
        b=BJ0RHi+qQcEUsf0B6LTnGh16oUEwHdiHkzlq/sdQleWujOpgrlNuuN0J1rLWHFmds1
         ZlnkwWw69gh0hP2mYMjsRkF82KXGH3BMiinMsQ/+dajbrOczgTHaC8/2Ryfnjg7LqZWz
         Ti5YcjHl8jiBrsYoj2b05tjm5UQKDtOOJGkZTklO03VB/7nFFiBMwtpw64gvSdTJX5c8
         UbC/oqa5jhz6a7UFtjmD6lmgPOZoWdOSyFUBjKHMQst4BPQMnWmvD4frVh76NgZ3pgwW
         SYpKFa04Y+ExHHT+5Yb18o3clrOnxM0XVpcu0vrr2Q6Ls5SFw+laoCy1ZJb76Ek4u6pE
         b8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LaWAsuhw20Bni3MnmjCRP8MnUuoyndyuSnU94kuhLEE=;
        b=HNNzucZOfzkVzelXgbSW5SqgMFXIs7bxBFlr4N6rr9TUdg3+PUa5dHzyQbn12r6YQg
         PB/rsR95XK25cTFYDKn2O7mSKAl7XZ7/M03DrZnXYpcsDliz32Sz0HCkUjVevsPvYxjO
         AQmcXNcMbDkUkpc5DVsR5rl0imM1Vql4MocCvtdcI+Oi7TaI9vWQYHoZTqD/ghXUY2kg
         GKANP4dJMBBraj3fK6uguX+jEo4930VC29I8OOOQYSEZ1PftH4UtBvGJNmYYGhuj0bOt
         iYNovKlsZp2bUGTHDfiB7wV0xKUt/JaTshOuXMn8fTzckh0mm4wKFGXfU1cF5iEZuzZz
         1xCw==
X-Gm-Message-State: APjAAAU8pZ3RduvCtMoamugSqTV4klZ52IdefReDdJIpzmRlGVkwcx1w
        yQ1BWJQ+oRMMAvCy7NyOjVxsidlVfYhHUW20snZp
X-Google-Smtp-Source: APXvYqwxnOzS5T2gSxHUkl+oMK+gZXYMCcQQH+jM13eR2OdYX68quest8XB6FLUcXmxVMjR/JlPq5fxUpHwn8moL6mw=
X-Received: by 2002:ac2:4833:: with SMTP id 19mr2896678lft.211.1579616502425;
 Tue, 21 Jan 2020 06:21:42 -0800 (PST)
MIME-Version: 1.0
References: <20200117202407.12344-1-sds@tycho.nsa.gov> <CAHC9VhS+YxOEsfDRjiiwkT9PdAdFLigG-n7cyLHL1ykBQED-Hw@mail.gmail.com>
 <CAB9W1A16ixsXmMkfbD7Z0WrXK+B0xWfNpBbOe+jOb6krOWrogw@mail.gmail.com>
In-Reply-To: <CAB9W1A16ixsXmMkfbD7Z0WrXK+B0xWfNpBbOe+jOb6krOWrogw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 21 Jan 2020 09:21:30 -0500
Message-ID: <CAHC9VhSzeNXxy0n2G2m+P4J2xNc=9HyLCL_jVExSiL3GyktHVg@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: fix regression introduced by move_mount(2) syscall
To:     Stephen Smalley <stephen.smalley@gmail.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org,
        omosnace@redhat.com, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 20, 2020 at 10:40 AM Stephen Smalley
<stephen.smalley@gmail.com> wrote:
> On Mon, Jan 20, 2020 at 7:52 AM Paul Moore <paul@paul-moore.com> wrote:
> > This looks good to me too, thanks Stephen.  Because of the nature of
> > this fix, I'm going to merge this into next now, even though we are at
> > -rc7.  Since we are effectively treating this as another mount
> > operation, and reusing the file:mounton permission, I don't believe
> > there should be any widespread access denials on existing distros ...
> > I assume you've at least tested this on Fedora and everything looked
> > okay?
>
> I did basic boot testing plus selinux-testsuite on Fedora without any issues.
> I'm not sure that Linux userspace (at least shipped in distros)
> besides test/sample programs is using the new system calls yet.
> And since anything that performed mounts previously using mount(2)
> would have required mounton permission,
> I would expect anything converted to use the new system calls would
> likewise have that permission already.

It is the last sentence that I was getting at in my reply.  It seems
reasonable to equate moving a mount to mounting a filesystem (which
this patch does), and thus any domain which wants, and should have the
permission, to move a mounted filesystem is likely to already have the
file:mounton permission.

-- 
paul moore
www.paul-moore.com
