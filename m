Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30161C64EC4
	for <selinux@archiver.kernel.org>; Fri, 10 Mar 2023 16:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjCJQ6p (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Mar 2023 11:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCJQ6V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Mar 2023 11:58:21 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF441CBDE
        for <selinux@vger.kernel.org>; Fri, 10 Mar 2023 08:56:47 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id bd34so4056723pfb.3
        for <selinux@vger.kernel.org>; Fri, 10 Mar 2023 08:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678467407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kJSn3HJWddd3T9137cV2/lHmvzoImZs3CGf6h0iAZ8=;
        b=CTUOfwHW773BhRpvJFhQleOkdxSx7l+ZjUZbbbXjSWEEtzina/aHBT6/8Nq/lYxzcB
         duFPA74dPIbumFB2S+VnlW8Vj/l9LWOkc/CHFfeoE2yZg5NnjqQBEdkCeIN+s9dFtA1q
         m5/rlvnQxoz3lcVwkqdnGLtUe80gjraqgSNZwxX9fe3WEpQ98ulX6WPbgJslGxY7aTzj
         W8HOt1qolVljLwFVyujnQBSXubwIM6xOrvBO8VPF2u2JU7q77c2VWQ5e+0NiBcKuqRSR
         uwigwYwTS9mBBgO9SagoPuPXqHtqEivo1+kV+JtvlQpP+jgIo0xLNd1VLNHA38NSF92k
         DQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678467407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kJSn3HJWddd3T9137cV2/lHmvzoImZs3CGf6h0iAZ8=;
        b=kesWwnDKJB8OaUivlAPHWvP0Lqm6pZnQOezctYfCsjK0mF9zW+W9jrlWPGYzVib1Np
         tbJfQGpAUXQYDgs7+2ZSoIm/RHfY88tSDt0r4YFttEIrpnYz/09fc9pd3iNtJ8gM3Bxj
         8F9G+En/pnyZyZ1W7hdod660QIsLK0A8wlouw1LsF0gP5TslUhc0Wxg6joVtj9fQXQNu
         dh4uJUUKxT5HmNnqf1jdrqEij5CExeGBF9fLDEhPnwb2CpIkL7hyY/Kew+gI78Q2h191
         wTywpcpkpRSgjNeBpC2ClW8PPCzNIGrpJSdfOQmb1dj1WJfxKljxXHUONB8jRX9asMMD
         BzBg==
X-Gm-Message-State: AO0yUKUrvW1j5iNVQvvmJwL8UEytAC7KZ7Pq8EOgtg5m5LifroLPY5Gp
        8qcueRI+eP2Pylf/FB86Uu1JdsPnCwCvutC4zAed
X-Google-Smtp-Source: AK7set/yAsB8h4NdEToSOP8MEyhlYJ9LOWABbo920pBfURoWjaG9iIeeEBVDAm1y+sWq/f03Z+M2I7xhHIs5PbUPimo=
X-Received: by 2002:a63:8c1d:0:b0:503:2535:44c3 with SMTP id
 m29-20020a638c1d000000b00503253544c3mr8977866pgd.4.1678467407208; Fri, 10 Mar
 2023 08:56:47 -0800 (PST)
MIME-Version: 1.0
References: <20230309191741.15063-1-stephen.smalley.work@gmail.com>
 <CAHC9VhTCScrPmzrzSVPqF0G==4+qxd=KSeBw7s3T_46rDgKoXQ@mail.gmail.com>
 <CAEjxPJ4R0U7TL3EAjU8_nnbmgoSaO+DN9SoB+PuC1HkOcrfAuw@mail.gmail.com>
 <CAHC9VhQ1-SeA+XS-Y2M5OydM79qu+GA0L770_A0Zf2C6wN80kw@mail.gmail.com>
 <CAEjxPJ57usjUurU0Rkgzcv6evYDeyJrX-msROH6QagYRkOxsug@mail.gmail.com>
 <CAHC9VhTh5JK_+9NY7FRzG1MYp6ZO9d80ubfhi0dcXKzCJJ0WkQ@mail.gmail.com> <CAEjxPJ7eQUPpfSk_AObUCowh4v2qO1jn6Fis+Cx8Y0vcVB7zCw@mail.gmail.com>
In-Reply-To: <CAEjxPJ7eQUPpfSk_AObUCowh4v2qO1jn6Fis+Cx8Y0vcVB7zCw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Mar 2023 11:56:36 -0500
Message-ID: <CAHC9VhQ3ZHDNpPvsiCPzHiY=psnLwxXrLnNJo_7Hjv=N9yJWZg@mail.gmail.com>
Subject: Re: [PATCH] selinux: stop passing selinux_state pointers and their offspring
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     selinux@vger.kernel.org, torvalds@linux-foundation.org,
        omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 10, 2023 at 11:53=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Fri, Mar 10, 2023 at 10:11=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Fri, Mar 10, 2023 at 8:47=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Thu, Mar 9, 2023 at 4:15=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > > On Thu, Mar 9, 2023 at 3:55=E2=80=AFPM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > On Thu, Mar 9, 2023 at 3:48=E2=80=AFPM Paul Moore <paul@paul-moor=
e.com> wrote:
> > > > > > On Thu, Mar 9, 2023 at 2:18=E2=80=AFPM Stephen Smalley
> > > > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > > >
> > > > > > > Linus observed that the pervasive passing of selinux_state po=
inters
> > > > > > > introduced by me in commit aa8e712cee93 ("selinux: wrap globa=
l selinux
> > > > > > > state") adds overhead and complexity without providing any
> > > > > > > benefit. The original idea was to pave the way for SELinux na=
mespaces
> > > > > > > but those have not yet been implemented and there isn't curre=
ntly
> > > > > > > a concrete plan to do so. Remove the passing of the selinux_s=
tate
> > > > > > > pointers, reverting to direct use of the single global selinu=
x_state,
> > > > > > > and likewise remove passing of child pointers like the selinu=
x_avc.
> > > > > > > The selinux_policy pointer remains as it is needed for atomic=
 switching
> > > > > > > of policies.
> > > > > > >
> > > > > > > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > > > > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.co=
m>
> > > > > > > ---
> > > > > > >  security/selinux/avc.c                 | 197 ++++-----
> > > > > > >  security/selinux/hooks.c               | 549 ++++++++++-----=
----------
> > > > > > >  security/selinux/ibpkey.c              |   2 +-
> > > > > > >  security/selinux/ima.c                 |  37 +-
> > > > > > >  security/selinux/include/avc.h         |  29 +-
> > > > > > >  security/selinux/include/avc_ss.h      |   3 +-
> > > > > > >  security/selinux/include/conditional.h |   4 +-
> > > > > > >  security/selinux/include/ima.h         |  10 +-
> > > > > > >  security/selinux/include/security.h    | 171 +++-----
> > > > > > >  security/selinux/netif.c               |   2 +-
> > > > > > >  security/selinux/netlabel.c            |  17 +-
> > > > > > >  security/selinux/netnode.c             |   4 +-
> > > > > > >  security/selinux/netport.c             |   2 +-
> > > > > > >  security/selinux/selinuxfs.c           | 208 ++++------
> > > > > > >  security/selinux/ss/services.c         | 346 +++++++--------=
-
> > > > > > >  security/selinux/ss/services.h         |   1 -
> > > > > > >  security/selinux/status.c              |  44 +-
> > > > > > >  security/selinux/xfrm.c                |  20 +-
> > > > > > >  18 files changed, 651 insertions(+), 995 deletions(-)
> > > > > >
> > > > > > It looks like this patch was a bit too big for the mailing list=
; I'm
> > > > > > trimming my reply to get this discussion on the list.
> > > > > >
> > > > > > I strongly dislike merging patches that haven't hit the list, b=
ut I do
> > > > > > recognize that this is a bit of an unusual case.  Have you trie=
d
> > > > > > breaking this up into two (three?) patches?  I imagine that sho=
uld be
> > > > > > possible, although I worry that the time required to do that wo=
uld be
> > > > > > prohibitive given the change itself.
> > > > > >
> > > > > > If that doesn't work, an alternative might be to file a PR agai=
nst our
> > > > > > kernel subsystem mirror on GitHub and posting a link to the PR =
here.
> > > > > > I don't want to encourage this as a general way of submitting S=
ELinux
> > > > > > kernel patches, but I could make an exception here.
> > > > > >
> > > > > > https://github.com/SELinuxProject/selinux-kernel
> > > > >
> > > > > I'm open to suggestions but didn't see an obvious way to split it=
 in a
> > > > > manner that keeps everything in a working state after each patch.
> > > > > checkpatch.pl didn't complain about the size - not sure if that i=
s a
> > > > > change in policy.
> > > >
> > > > I'm not sure checkpatch.pl is the right place for that anyway as ev=
ery
> > > > list could have a different policy.
> > > >
> > > > FWIW, many years ago I was told to keep the diffstat under a thousa=
nd
> > > > lines as a general rule.  While I've seen patches go over that limi=
t
> > > > and hit various @vger lists, I personally try to keep my patches un=
der
> > > > that 1k limit, and generally that isn't too hard.  This really is a
> > > > bit of a special case I think.
> > > >
> > > > > Created a PR here:
> > > > > https://github.com/SELinuxProject/selinux-kernel/pull/64
> > > >
> > > > Thanks, I'll work from that.
> > >
> > > For those following along on the mailing list, the kernel test robot
> > > reported a problem with the original patch when lockdep is enabled, s=
o
> > > I generated a v2 patch and updated the PR (same link above).
> >
> > That's interesting.  Does that mean that your original patch made it
> > to the mailing list but somehow didn't make it to the lore archive?  I
> > just (re)checked and there is no record of your patch in the archive
> > or the patchwork instance.
> >
> > How did the kernel test robot get the patch to test?  Does it know to
> > go fetch GH PR URLs?
>
> The email from the robot referenced the PR so it appears to be
> watching for PRs to certain GH repositories and automatically testing
> them.

Huh, interesting.  Thanks.

--=20
paul-moore.com
