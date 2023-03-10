Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF724C6FA99
	for <selinux@archiver.kernel.org>; Fri, 10 Mar 2023 13:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjCJNrr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Mar 2023 08:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjCJNrq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Mar 2023 08:47:46 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A1028E58
        for <selinux@vger.kernel.org>; Fri, 10 Mar 2023 05:47:45 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so5221393pjp.2
        for <selinux@vger.kernel.org>; Fri, 10 Mar 2023 05:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678456065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+j2Vvv6yuQckaVvHFVBHmL9/engBcMfOvwzB0p82s0=;
        b=JIB8fh13R8VSoKEN2cAbdYnvzPb0hwImqnJknqnABI59TmnWjXRmvA3tbPUK2swlNF
         Sj/7GuZq/PWyS3aVF6CeafZQueevk4a1EEIRGVntN77h/TOeqp9OUchE0Wb5pfyEw/Vb
         yufj+jMl1owhrBa0hXdsdujHB+NegkwU0MOqRELigPHNjXKu2VI+/0bnlOna5/w7ZjsC
         lHy74D7n3mfR61yH6MZPnD2KLXR2dIiAZZ3GndwIRHRk5AaKpYMM4symvuWxdnanPCHJ
         KbW0Xv5G3xikWZpNuL5YHwhh8EXwh0M2XSPW2NePubvaIfb3EHt6lXxCxBAHGzQ5onR1
         ztbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678456065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+j2Vvv6yuQckaVvHFVBHmL9/engBcMfOvwzB0p82s0=;
        b=D85+Ms87MHo6GYV54IGeMvHO9qB2MF5RCzWbC/JpajeUzqUqXQ5SPhSXhZL5tV/0Wl
         rvYDfhGml78Dybqr41qKGGEYaTP+SzXbe399e8Tv/YQGSx/2nlIShSbDTq3yR+QXS3RU
         4ZKn3JStohNhZ4DiwDQtovu4xvYtAZWrJP3Bl7obABJd5dlN3AIvQv6Zu/LPYrH/EyT+
         QTr+D3k44kEbCjgUSw7sFq2OBwWdlqLtE/pLCCttpMrPn0DqDClsHkJtn6veHYLDMChO
         r5uVtvFTR2AXIMTrsc0+MGIbu1gRFetlYui+XVC5g5R0FwJU8G2fmpHbVJjWXvWmgEQE
         JmBQ==
X-Gm-Message-State: AO0yUKWums9zIoPFh8X8uH8BgLpD5hQ7Bz4oUlKA4FmWZ24+N8J1vMAJ
        W7JC9EXDYIPzP1qger6YmGyg63BY3Av1SO65Yhg=
X-Google-Smtp-Source: AK7set//rE+w9gjhFtUZKl3Gn44CkpcrphehKy27ZYwHZMr9K4Q8R2LsIL+C3jvuwLwLTMcOxe/+YVUC2cPjhtlKhXI=
X-Received: by 2002:a17:903:4285:b0:19a:9984:558c with SMTP id
 ju5-20020a170903428500b0019a9984558cmr9860752plb.6.1678456064779; Fri, 10 Mar
 2023 05:47:44 -0800 (PST)
MIME-Version: 1.0
References: <20230309191741.15063-1-stephen.smalley.work@gmail.com>
 <CAHC9VhTCScrPmzrzSVPqF0G==4+qxd=KSeBw7s3T_46rDgKoXQ@mail.gmail.com>
 <CAEjxPJ4R0U7TL3EAjU8_nnbmgoSaO+DN9SoB+PuC1HkOcrfAuw@mail.gmail.com> <CAHC9VhQ1-SeA+XS-Y2M5OydM79qu+GA0L770_A0Zf2C6wN80kw@mail.gmail.com>
In-Reply-To: <CAHC9VhQ1-SeA+XS-Y2M5OydM79qu+GA0L770_A0Zf2C6wN80kw@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 10 Mar 2023 08:47:33 -0500
Message-ID: <CAEjxPJ57usjUurU0Rkgzcv6evYDeyJrX-msROH6QagYRkOxsug@mail.gmail.com>
Subject: Re: [PATCH] selinux: stop passing selinux_state pointers and their offspring
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, torvalds@linux-foundation.org,
        omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 9, 2023 at 4:15=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Thu, Mar 9, 2023 at 3:55=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Thu, Mar 9, 2023 at 3:48=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > >
> > > On Thu, Mar 9, 2023 at 2:18=E2=80=AFPM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > >
> > > > Linus observed that the pervasive passing of selinux_state pointers
> > > > introduced by me in commit aa8e712cee93 ("selinux: wrap global seli=
nux
> > > > state") adds overhead and complexity without providing any
> > > > benefit. The original idea was to pave the way for SELinux namespac=
es
> > > > but those have not yet been implemented and there isn't currently
> > > > a concrete plan to do so. Remove the passing of the selinux_state
> > > > pointers, reverting to direct use of the single global selinux_stat=
e,
> > > > and likewise remove passing of child pointers like the selinux_avc.
> > > > The selinux_policy pointer remains as it is needed for atomic switc=
hing
> > > > of policies.
> > > >
> > > > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > ---
> > > >  security/selinux/avc.c                 | 197 ++++-----
> > > >  security/selinux/hooks.c               | 549 ++++++++++-----------=
----
> > > >  security/selinux/ibpkey.c              |   2 +-
> > > >  security/selinux/ima.c                 |  37 +-
> > > >  security/selinux/include/avc.h         |  29 +-
> > > >  security/selinux/include/avc_ss.h      |   3 +-
> > > >  security/selinux/include/conditional.h |   4 +-
> > > >  security/selinux/include/ima.h         |  10 +-
> > > >  security/selinux/include/security.h    | 171 +++-----
> > > >  security/selinux/netif.c               |   2 +-
> > > >  security/selinux/netlabel.c            |  17 +-
> > > >  security/selinux/netnode.c             |   4 +-
> > > >  security/selinux/netport.c             |   2 +-
> > > >  security/selinux/selinuxfs.c           | 208 ++++------
> > > >  security/selinux/ss/services.c         | 346 +++++++---------
> > > >  security/selinux/ss/services.h         |   1 -
> > > >  security/selinux/status.c              |  44 +-
> > > >  security/selinux/xfrm.c                |  20 +-
> > > >  18 files changed, 651 insertions(+), 995 deletions(-)
> > >
> > > It looks like this patch was a bit too big for the mailing list; I'm
> > > trimming my reply to get this discussion on the list.
> > >
> > > I strongly dislike merging patches that haven't hit the list, but I d=
o
> > > recognize that this is a bit of an unusual case.  Have you tried
> > > breaking this up into two (three?) patches?  I imagine that should be
> > > possible, although I worry that the time required to do that would be
> > > prohibitive given the change itself.
> > >
> > > If that doesn't work, an alternative might be to file a PR against ou=
r
> > > kernel subsystem mirror on GitHub and posting a link to the PR here.
> > > I don't want to encourage this as a general way of submitting SELinux
> > > kernel patches, but I could make an exception here.
> > >
> > > https://github.com/SELinuxProject/selinux-kernel
> >
> > I'm open to suggestions but didn't see an obvious way to split it in a
> > manner that keeps everything in a working state after each patch.
> > checkpatch.pl didn't complain about the size - not sure if that is a
> > change in policy.
>
> I'm not sure checkpatch.pl is the right place for that anyway as every
> list could have a different policy.
>
> FWIW, many years ago I was told to keep the diffstat under a thousand
> lines as a general rule.  While I've seen patches go over that limit
> and hit various @vger lists, I personally try to keep my patches under
> that 1k limit, and generally that isn't too hard.  This really is a
> bit of a special case I think.
>
> > Created a PR here:
> > https://github.com/SELinuxProject/selinux-kernel/pull/64
>
> Thanks, I'll work from that.

For those following along on the mailing list, the kernel test robot
reported a problem with the original patch when lockdep is enabled, so
I generated a v2 patch and updated the PR (same link above).
