Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81F0C678D5
	for <selinux@archiver.kernel.org>; Tue,  7 Mar 2023 20:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjCGUrw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Mar 2023 15:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjCGUrw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Mar 2023 15:47:52 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A953A2C2B
        for <selinux@vger.kernel.org>; Tue,  7 Mar 2023 12:47:51 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id p3-20020a17090ad30300b0023a1cd5065fso13093239pju.0
        for <selinux@vger.kernel.org>; Tue, 07 Mar 2023 12:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678222070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/nd40jMMc5nP4QfLusJwPiDlfEpljL6z5ERTeu9ikc=;
        b=Wqnpy2M9RLKgDfQRmXXKkTPywq2ZjVNKLaerJz0f+OlFQqblNHNiOvRhl7HRJ4vwz2
         dSM6UvMwGvcSNNCqUZ/eDaSS92N4VJXxkQkpbASXl8/xHv6upH1xJ6lFaa1DPV2QiH8C
         mdOFFAA9FOhuZIdc4rGHv1MjD/fvIlahxBI9eTJDsC+C13Hdrp7Ef4na8lWGOO6e2TUJ
         pvj8og9916tYXmsCmKPZJCDvKeA+E0VSnWtRFmDwD32T+n0MtgUIC5oy6ZNdWS2nLGCw
         Sfk/odCW50BX6Hec31OukLdRkwuCBW1BMVxjWC7Y4Vdt/Z5UVKGHge5AG18Hu6T0Du0P
         OHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678222070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/nd40jMMc5nP4QfLusJwPiDlfEpljL6z5ERTeu9ikc=;
        b=22edME59M1Sum1iayYgOfnaFsQSAb5mAP0/3UFBW/Xj1uV/5Q1ZkfoHgtgd/DLQhCx
         qhXSJO3IZNtGE1WpT7doJdXA5NwcNLkVmgtvbmuVcqpfElV7SYpLwMc2kTKVx4A3ohO+
         mH6y6OQb0Hv3XXiEIZeQ5dPCe4kqsK/zAuXYvSkQJJYPcxaZj+CW6EIj8CyTxEweTx4s
         ixW0dM60EYD1yHkIDFj6nLrQbrVtpwX7y4LJqPAIvUNqQHXvzjOMxtjf2NRaZ5mVvPjU
         AnUD9JrhXqIxIMGDlFS15mTaAq92LUW0t9Y2LM0saMilijNCXAIF7RiR86xDiBJER13+
         MTaw==
X-Gm-Message-State: AO0yUKVanTpvGPHQG7Xs9le/tPFeW11LX+jxSiRL+td6VrzLdirg3wJO
        hirW2dvOHkccsZaHJqiFbgq3Y4OzEIxDv0ZZHybxDBnk9p16xfeH9g==
X-Google-Smtp-Source: AK7set9E3fZioyBW5a2KY2XKCO+bC7GD9YAfwd+b4/XGI8A72WvSyaXLR/uOAhs+Ky1k25dVYYzfNIkmusXjo0CwTwk=
X-Received: by 2002:a17:902:784a:b0:199:482e:6f93 with SMTP id
 e10-20020a170902784a00b00199482e6f93mr8483646pln.2.1678222070034; Tue, 07 Mar
 2023 12:47:50 -0800 (PST)
MIME-Version: 1.0
References: <20230307204524.214983-1-paul@paul-moore.com>
In-Reply-To: <20230307204524.214983-1-paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 7 Mar 2023 15:47:38 -0500
Message-ID: <CAHC9VhTEiBW50UxYnm8-ZA=V5F2Wos8biXTjX=2UXM5RL_eM7A@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: uninline unlikely parts of avc_has_perm_noaudit()
To:     selinux@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 7, 2023 at 3:45=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> This is based on earlier patch posted to the list by Linus, his
> commit description read:
>
>  "avc_has_perm_noaudit()is one of those hot functions that end up
>   being used by almost all filesystem operations (through
>   "avc_has_perm()") and it's intended to be cheap enough to inline.
>
>   However, it turns out that the unlikely parts of it (where it
>   doesn't find an existing avc node) need a fair amount of stack
>   space for the automatic replacement node, so if it were to be
>   inlined (at least clang does not) it would just use stack space
>   unnecessarily.
>
>   So split the unlikely part out of it, and mark that part noinline.
>   That improves the actual likely part."
>
> The basic idea behind the patch was reasonable, but there were minor
> nits (double indenting, etc.) and the RCU read lock unlock/re-lock in
> avc_compute_av() began to look even more ugly.  This patch builds on
> Linus' first effort by cleaning things up a bit and removing the RCU
> unlock/lock dance in avc_compute_av().
>
> Removing the RCU lock dance in avc_compute_av() is safe as there are
> currently two callers of avc_compute_av(): avc_has_perm_noaudit() and
> avc_has_extended_perms().  The first caller in avc_has_perm_noaudit()
> does not require a RCU lock as there is no avc_node to protect so the
> RCU lock can be dropped before calling avc_compute_av().  The second
> caller, avc_has_extended_perms(), is similar in that there is no
> avc_node that requires RCU protection, but the code is simplified by
> holding the RCU look around the avc_compute_av() call, and given that
> we enter a RCU critical section in security_compute_av() (called from
> av_compute_av()) the impact will likely be unnoticeable.  It is also
> worth noting that avc_has_extended_perms() is only called from the
> SELinux ioctl() access control hook at the moment.
>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/avc.c | 85 ++++++++++++++++++++++++++++--------------
>  1 file changed, 57 insertions(+), 28 deletions(-)

FYI, marked as a RFC as I haven't tested this yet but I felt this was
worth posting early as Linus' original patch was sent as an attachment
and some of you may have missed it as a result.

https://lore.kernel.org/selinux/CAHk-=3DwhR4KSGqfEodXMwOMdQBt+V2HHMyz6+Cobi=
ydnZE+Vq9Q@mail.gmail.com/

--=20
paul-moore.com
