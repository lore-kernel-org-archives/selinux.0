Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA73C636CB
	for <selinux@archiver.kernel.org>; Sat, 28 Jan 2023 22:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjA1Wdt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 28 Jan 2023 17:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjA1Wds (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 28 Jan 2023 17:33:48 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE769EC7
        for <selinux@vger.kernel.org>; Sat, 28 Jan 2023 14:33:46 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id z3so5488021pfb.2
        for <selinux@vger.kernel.org>; Sat, 28 Jan 2023 14:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EftB97uXIO+Rbr0P69/Yv7ngTYngtSEUihWE6HFnduY=;
        b=LGR3JjI4TMVWMg5VCmLygkcKXVznjIj2JHI5hWoQlMpH9wQYckywttibV5/GmFgcPo
         zg8CMhzk3LzBMTcEqO+dFzU9TV11IvATr5gdTmSrVpFfomjBd9vdw21HmBP3WPRbgg8H
         PP6SkuDbj95f10612NTD+YKsVDgFpc9mzI+tuyvIaY6QRcA66KWYJUccwE8UiLgU0vsb
         yNoyjMHAMjl4oEfT8as2zxtCOcluEnXwYcsRxA2XhVVxayiMBSctdxg5QVNtMPxwiZw5
         ZhdCgIWCzO7pAjGMDqQHtHV/LJMyBOzHvDT2A4eER8rhB+C5Tf7HPoc4mXFqZu1c4tCa
         /daA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EftB97uXIO+Rbr0P69/Yv7ngTYngtSEUihWE6HFnduY=;
        b=qtV8jPVlkLDyv+vrq1PViLxP5lgoSuVUoRjfNHDEFvmjd6dX4Lqxg7gdF7bO2zeq5C
         KXK04/jVWvfJs52MVXQF0SY/HM6LITTpCmmHYWTO9n9TVTlBFmrkM9Qko+d71nu0Ery6
         JY9wfxuRCIKKlbkEMmuS3qGcJy0uU0sHLrVhGFkbwlozF9o0pxmDGIiWZD02AVn7YrRn
         0gG0l6AWIp2SXIfxU21up0RPqMxts/+IoS+tGUI6qLKYisVcxdo6yd/ELoSrkALzqlEN
         LBX1ZJXRjAUJNmIpxPXdwEr9n9V69dWOq69fW4huuRKhvYv+x83fkMfIsWaUxOc5Fqx7
         fs7A==
X-Gm-Message-State: AFqh2kqea9sB6ULY0NhfNV2GOx32Dw/9nR4T9+zeht1Rdq8jzIHr/IeD
        o4Ez2f04WxYOrKo3SUzi2GwOE+xtdrg+iemtrf1+vFTqfHaw
X-Google-Smtp-Source: AMrXdXsuRFUJLhhGNPwPJitNLKPKXT+ShYx99n2qorR0nhixeBRE2T2fpeD8PS5qhC9xC2N90Uk38/qArFf4zW120iY=
X-Received: by 2002:a63:f017:0:b0:477:bfab:5a81 with SMTP id
 k23-20020a63f017000000b00477bfab5a81mr4545611pgh.64.1674945225284; Sat, 28
 Jan 2023 14:33:45 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=whR4KSGqfEodXMwOMdQBt+V2HHMyz6+CobiydnZE+Vq9Q@mail.gmail.com>
In-Reply-To: <CAHk-=whR4KSGqfEodXMwOMdQBt+V2HHMyz6+CobiydnZE+Vq9Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 28 Jan 2023 17:33:34 -0500
Message-ID: <CAHC9VhR1jRM2K0757sNYS8VvSUxRWOKUJ1unbsZm9LOEM3Up6Q@mail.gmail.com>
Subject: Re: Looking at profile data once again - avc lookup
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Jan 28, 2023 at 4:15 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I happened to do my occasional "let's see what a profile for an
> empty kernel build is", which usually highlights some silly thing we
> do in pathname lookup (because most of the cost is just 'make' doing
> various string handling in user space, and doing variations of
> 'lstat()' to look at file timestamps).
>
> And, as always, avc_has_perm() and avc_has_perm_noaudit() are pretty
> high up there, together with selinux_inode_permission(). It just gets
> called a *lot*.
>
> Now, avc_has_perm_noaudit() should be inlined, but it turns out that
> it isn't because of some bad behavior of the unlikely path. That part
> looks fairly easy to massage away. I'm attaching a largely untested
> patch that makes the generated code look a bit better, in case anybody
> wants to look at it.

I'll take a look, although just a heads-up that I don't generally
merge patches into selinux/next at this point in the -rc cycle unless
they are bug fixes, or some other critical patch; it's likely this
will need to wait until after the upcoming merge window closes.

> But the real reason for this email is to query about 'selinux_state'.
>
> We pass that around as a pointer quite a bit, to the point where
> several function calls have to use stack space for arguments just
> because they have more than six arguments. And from what I can tell,
> it is *always* just a pointer to 'selinux_state', and never anything
> else.

We can, and should, look at those cases where the function parameters
start to spill into the stack space.

> This was all done five years ago by commit aa8e712cee93 ("selinux:
> wrap global selinux state") and I don't see the point. It never seems
> to have gone anywhere, there's no other state that I can find, and all
> it does is add overhead and complexity.
>
> So I'd like to undo that, and go back to the good old days when we
> didn't waste time and effort on passing a pointer that always has the
> same value as an argument.
>
> Comments? Is there some case I've missed?

You're correct in that selinux_state parameters currently always point
back to the single global instance, however there was, and still is, a
point to that patch ... although I will admit it is a long time
coming.  The purpose of this change was to help pave the way for
namespacing SELinux by easing development and helping to reduce
ongoing merge conflicts with the in-development patches.  For a
variety of reasons the namespacing work has languished a bit, but it
hasn't been forgotten and I expect it to gain importance once the LSM
stacking patches land (LSM stacking alone isn't going to solve all of
the problems that many are expecting, it will need to be combined with
LSM-specific namespacing).

-- 
paul-moore.com
