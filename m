Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B52EC54EAA
	for <selinux@archiver.kernel.org>; Mon, 30 Jan 2023 17:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237540AbjA3ROf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 Jan 2023 12:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbjA3ROb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 30 Jan 2023 12:14:31 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581183EC44
        for <selinux@vger.kernel.org>; Mon, 30 Jan 2023 09:14:29 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id g9so6226718pfk.13
        for <selinux@vger.kernel.org>; Mon, 30 Jan 2023 09:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eSrWzE+t3kxPp8JnvZY7c1nfKyO1l+9FE/gLc1tY13o=;
        b=Pbx6nEwmF5kN5WktkXN37iRaFqYH0BdyPjA5OqGxeMO1JTZ+PDcw7Dpta6TV/IjiUz
         RjSGvedxWTzsCt7ygRPS/SxlYgDK4mMjVa1UZel8NY11qtiMWbivm5RhVf1hc1B/sMBH
         z0EZ1doicyxY2GnC8qeS5DnxM/HjXlTdB/ZJviQhlXp6njLyu4BLeBxCDldQGyE3fC4I
         Ha1o//CLRH/xOThqeHo/N013qO5pUDnLfoAABxjaAdkYgeNR2H/fh3qiGkWXvIVnZ+12
         GDOSmBrZZ4AkqYWHXKLWYa8tEoQzSzCVj1YAZtToNzXkujYkVpncQg91eUiGVFwogGbX
         BjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eSrWzE+t3kxPp8JnvZY7c1nfKyO1l+9FE/gLc1tY13o=;
        b=BvT2T0ov6wCe48yeGEtlr3Vgdzy1i8/aoG7zMtZasuZayGJ3/K9X4Ll1AokGna93t4
         e+kGRvc2KlqljzaoEL+xSRBJXW+WhNyzGa8l5v2BWWpfG6ZV3FmsPNIHNT8zd+f6m6uv
         nlqzgWSAFhUh8i3X96RL9+oY2nJ49Ndx+jMAVjlkpQACTg3nG0VRcykFJC3cxw50dMhW
         7aoUQGtlvLAVut6G96QdzjBnoKCLuTza1efFDrTOmg1Uie5uT1lzAd75lFImQYNcmVq8
         d0ugTE6zXNcIEf+mpqw53WckwR7/d+rDdipsuIqqoSiczLUf+NHUuhpJ3QfneRH1k+tD
         YjzA==
X-Gm-Message-State: AO0yUKW1IKVtP2D9uwfa9Fr+DjDxL7Dzk0Ihbl+bzP9tnYDQvDcqutec
        Vh02RIDTIFWVOES4QLRxm+hCOMljO/N1w2fZ7NUF
X-Google-Smtp-Source: AK7set+i5bK0CDjX+DYr2JIzs8qO51DA70buMb5BPBW2FtMM5faxhyplvfqk3LjTv1UYpoySCTCr1VT7Fv/paOnMuAw=
X-Received: by 2002:a05:6a00:1892:b0:593:dec8:4384 with SMTP id
 x18-20020a056a00189200b00593dec84384mr293921pfh.67.1675098868596; Mon, 30 Jan
 2023 09:14:28 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=whR4KSGqfEodXMwOMdQBt+V2HHMyz6+CobiydnZE+Vq9Q@mail.gmail.com>
 <CAHC9VhR1jRM2K0757sNYS8VvSUxRWOKUJ1unbsZm9LOEM3Up6Q@mail.gmail.com> <CAHk-=whLndwMFSF_OAWdqxXYXUev_H9YqEkXQ1_PKoPO8u=G2g@mail.gmail.com>
In-Reply-To: <CAHk-=whLndwMFSF_OAWdqxXYXUev_H9YqEkXQ1_PKoPO8u=G2g@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 30 Jan 2023 12:14:17 -0500
Message-ID: <CAHC9VhRWz2N6ezZckSwtZvM3J75prdq7ckaoQgAO+ECz527qCw@mail.gmail.com>
Subject: Re: Looking at profile data once again - avc lookup
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Jan 29, 2023 at 2:37 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sat, Jan 28, 2023 at 2:33 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > I'll take a look, although just a heads-up that I don't generally
> > merge patches into selinux/next at this point in the -rc cycle unless
> > they are bug fixes, or some other critical patch; it's likely this
> > will need to wait until after the upcoming merge window closes.
>
> Yeah, that patch was not some kind of "please apply this urgent fix",
> more of a "I'm looking at path walking again, and the selinux code is
> more expensive than the *actual* path walk is" heads up.

Yep, just wanted to set expectations so you wouldn't be surprised to
not see this during the upcoming merge window.

> > > Comments? Is there some case I've missed?
> >
> > You're correct in that selinux_state parameters currently always point
> > back to the single global instance, however there was, and still is, a
> > point to that patch ... although I will admit it is a long time
> > coming.
>
> Honestly, considering that the selinux code is literally more
> expensive than THE REAL WORKLOAD it is checking, I really want people
> to take a second look.

WE WILL

> If some new feature makes that crazy-expensive thing *worse*, we have issues.
>
> If it's been that way for five years with no progress, and no clear
> indication that it's even some high-priority issue that lots of people
> are asking for, maybe that should be a big hint.

To be fair, people *are* asking SELinux namespacing, but there are
some very thorny problems that remain unsolved.  However, after the
merge window we should consider moving away from passing the
selinux_state as a parameter and just using it as a global resource.

-- 
paul-moore.com
