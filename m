Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FD5C433E1
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 13:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71EBD2074A
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 13:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="1KZvR4CE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgHYNJn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgHYNJl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 09:09:41 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFF4C061574
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2020 06:09:41 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id b17so8159910ejq.8
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2020 06:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LpD66simFLhm5uNNfMJtAVQc0hDv90GqJgXGm8EJ6IE=;
        b=1KZvR4CEGRaSj8ii3VNK6063Ta3ceDYOR1rnWBqkwoE8Ki+6pkQlIDc2V8zyJ5MTKV
         rbvj1YUgbmxY5sM8Rg3mdjBGjgLToHIqsPLNv4ic5HxNo05KHPqDZBPy6rBWImmcq8M2
         7oHRKdNEZo0rVGw8N3okMFg35K/OFTyrkV1vn1R0iCsLFMT1aEILaTCpsw7RLllQ3nHZ
         ZVr1GzjUEsuTgAZYrHu083aFR7LRLECbPrrAiUw4MWyVPvjlKHy6UrjgxJjkYoRAetmc
         PyTyoz+rLiaTP5ZxXTzwxwP30Un+Z7ksFQOh76MLdwuy/L/Bq0i1e9GN4rxManPFyOJv
         Jz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LpD66simFLhm5uNNfMJtAVQc0hDv90GqJgXGm8EJ6IE=;
        b=bu3NxXqziRsRaYQmJ0eYqu15XUwW8LswvN8C3B7YZ6YxZz7c43WkD6i7uId6dKp+lR
         xp0jzBIa38ogl55OAsHoo59zXuSX3NVTH8nH1XmVisBzLPf1VwzN7DZT1r/GosFVS0jw
         qSqSZ07NLzDurr/R9dONRQVTAMPUNNXF2CmOkgIs1MeK4dqSOAlNtJ2awdgpgqw7EpXu
         TTYZLsKA4UwR8oHvS26daAS+OSPhNUGaLgWZJjZIjzvtprcBDk8ipQ7KsXaxZkcRVyOT
         ODPleE2jrsZadCQwvqe73fGwJdZByem2iuYVjsR95EofAVY2RN9yIFk7f81ICRhqZMAh
         kfbg==
X-Gm-Message-State: AOAM531StaP9iK/pnTY+Gj+WAqa1DVJfwjPZCPRzEk9WlhCanJdiPopk
        GSprCRW/jeBabgt9an+QBt228GJz1obH3JZXr88q
X-Google-Smtp-Source: ABdhPJwrokBfusMcWuMi7eUHNudEdQ29KjimqCko8ixpPwdJdx7ykKXQTAdQvNj3pOML/O9smfYtZLOdzfbeihra9RE=
X-Received: by 2002:a17:906:1993:: with SMTP id g19mr3155181ejd.431.1598360979532;
 Tue, 25 Aug 2020 06:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200819194516.50746-1-stephen.smalley.work@gmail.com> <CAFqZXNs0xG+FgGW3DamHWw+smzHpz_9g86VvhTwa9rM5W=C49w@mail.gmail.com>
In-Reply-To: <CAFqZXNs0xG+FgGW3DamHWw+smzHpz_9g86VvhTwa9rM5W=C49w@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 25 Aug 2020 09:09:28 -0400
Message-ID: <CAHC9VhQT1GLBMY5ajWsVRM=yi-_Mw0Ws5VjmzMbTMAp-feO_DQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4] selinux: convert policy read-write lock to RCU
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        peter enderborg <peter.enderborg@sony.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 20, 2020 at 10:27 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Wed, Aug 19, 2020 at 9:45 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > Convert the policy read-write lock to RCU.  This is significantly
> > simplified by the earlier work to encapsulate the policy data
> > structures and refactor the policy load and boolean setting logic.
> > Move the latest_granting sequence number into the selinux_policy
> > structure so that it can be updated atomically with the policy.
> > Since removing the policy rwlock and moving latest_granting reduces
> > the selinux_ss structure to nothing more than a wrapper around the
> > selinux_policy pointer, get rid of the extra layer of indirection.
> >
> > At present this change merely passes a hardcoded 1 to
> > rcu_dereference_check() in the cases where we know we do not need to
> > take rcu_read_lock(), with the preceding comment explaining why.
> > Alternatively we could pass fsi->mutex down from selinuxfs and
> > apply a lockdep check on it instead.
> >
> > Based in part on earlier attempts to convert the policy rwlock
> > to RCU by Kaigai Kohei [1] and by Peter Enderborg [2].
> >
> > [1] https://lore.kernel.org/selinux/6e2f9128-e191-ebb3-0e87-74bfccb0767f@tycho.nsa.gov/
> > [2] https://lore.kernel.org/selinux/20180530141104.28569-1-peter.enderborg@sony.com/
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
>
> (from v3 comment section:)
> > Remaining open questions include whether I should change selinuxfs
> > to pass down fsi->mutex so that we can use it in a lockdep check
> > for rcu_dereference_check() and whether the sidtab live convert is
> > safe after this change.
>
> FTR, I spent some time pondering on whether there is any bad
> interaction with the sidtab live convert and I couldn't find anything.
> The tricky part was splitting the policy load into load/commit/cancel
> and that seems to have been done correctly.

You and Stephen have obviously spent more time looking at this than I
have, but looking it over this morning it seems reasonable.

> As for rcu_dereference_check(), I'd prefer to pass the fsi->mutex in
> there for better clarity.

I still can't say I'm really loving the write lock side of this, but
short of breaking the boundary between the security server and the
Linux/LSM hook side of the code I'm not sure there is a really good
solution.  I think simply commenting it as Stephen has done is about
the best we can do.

It is my opinion that passing an arbitrary mutex into the security
server code doesn't really accomplish much.  Sure, it gives the caller
some indication that exclusivity is required, but a bare mutex doesn't
really provide any guarantee that the *right* mutex is being used.  If
we wanted to fix that we would need to look at passing down the
selinux_fs_info pointer itself, but then we are back to breaking the
abstraction between the security server and the Linux hook layer.  The
only thing saving us here is that this code is *deep* inside SELinux
and it is *extremely* unlikely that we are going to have any
cross-subsystem abuse which touches this code.  The comment based
approach isn't perfect, but I think it is our best option at this
point in time.

> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > index a48fc1b337ba..838161462756 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> [...]
> > @@ -2174,14 +2208,18 @@ void selinux_policy_commit(struct selinux_state *state,
> >                         pr_info("SELinux: Enabling MLS support...\n");
> >         }
> >
> > +       /* Set latest granting seqno for new policy. */
> > +       if (oldpolicy)
> > +               newpolicy->latest_granting = oldpolicy->latest_granting + 1;
> > +       else
> > +               newpolicy->latest_granting = 1;
> > +       seqno = newpolicy->latest_granting;
>
> This could be written as:
>
>     seqno = newpolicy->latest_granting = oldpolicy ?
> oldpolicy->latest_granting + 1 : 1;
>
> ...which is a bit easier to read to me, but others may differ.

I'll differ :)

I realize multiple assignments look pretty cool in that
hey-I-can-combine-three-lines-of-code-into-one sorta way, but I hate
having to read code like that, especially when you get to that point
where you end up reading more code than you write.

Simple code is easier to read, easier to review, easier to debug, and
easier to maintain.

... and just to be clear, combining multiple assignments on a single
line in combination with a ternary statement is not my idea of
"simple" ;)

> Other than the minor things above, I didn't find any logical issue in
> this patch.
>
> Since the mutex passing is going to be discussed in a separate patch
> and the only other comments I had are minor nits (and which may not
> align with your and/or Paul's preference), here you go:
>
> Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>

Merged into selinux/next, thanks everyone.

-- 
paul moore
www.paul-moore.com
