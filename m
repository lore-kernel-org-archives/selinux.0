Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C926BC433EF
	for <selinux@archiver.kernel.org>; Tue, 23 Nov 2021 03:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbhKWDR4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Nov 2021 22:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhKWDRz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Nov 2021 22:17:55 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75809C061574
        for <selinux@vger.kernel.org>; Mon, 22 Nov 2021 19:14:48 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id t5so86114284edd.0
        for <selinux@vger.kernel.org>; Mon, 22 Nov 2021 19:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qhoul6ZKL9G3s+4uvGE8jfh/TT4N7bzeqyrK0ucJr0w=;
        b=GnokKZBjJqzB3skKIG8yvx4gFwIX+0e4NmFAmZeqqLx2gQSGMklxMwWjZLABFbpIM/
         JjKfS4E44JDDUW6iJOF1SSbrg4wh0t4EY9pQxezlrU7EsDeDrr7ErS+Muoa9N9Bp36oZ
         b9MkCKszEvE2QP7Lj/mEqcefBXWQivWesRQ3X9cZJmkkjLCj2zb8dTVId8ij5ddQLx7D
         OhwSVjVEsIDVaIrgyY4KHu5mypCmdtlbcizJ0hYKfdKs8tW7jH1pEW+3D5MDJXS2EgkE
         34IkYZqWkCxgXtWCepvzzRE+WxsH2HnvNd6+hgXlaDy0V5PGQq3jYKTM50pXD76dNkmd
         r3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qhoul6ZKL9G3s+4uvGE8jfh/TT4N7bzeqyrK0ucJr0w=;
        b=aQ22AprUCazzyQ4Teg95SVFDDrK86dWemaFbLoKXGBgQsP7lLid6+PEoBhzp3izuNO
         zLg3uo42kl3VKJyGurLbH+v6vUhth1RmxKZyI/K752kC/Piz/CnN2ApqSa4YeqRAvcpU
         9SJXpPn6gGCDcqZwWtftpd2WjCxw/V7wZx975ibQgqMv7f+SCs4/ssLE1qnxwJCSOOEb
         lxc82y5c044nNnp5CI+M1FZdK4kMHpOpxrNzK5/5om3nmUZ9GPINEXuAwRVodcl6W/FB
         rV9GMoCowDZJbvfEYZFoW6WhYLBf8opOC6BburoXzc0+78H6Li4fBVnOEyw25PWpSy9y
         tHSQ==
X-Gm-Message-State: AOAM531fGFzNZO93tnRravAm5HRbSJRtyb3zCp7eeMObO00OG0vlsf9c
        zt51V0+23NWx9qXmujxs99zZ4gtcfaA/wNogP2ze
X-Google-Smtp-Source: ABdhPJy4lezA+D3z31JFJ/O70sVNxSiD4afyGsGvzjTTL2EtQPmoI6GALS507F1Jk9DvCntS1iJRIGqCEPsxKKttdgo=
X-Received: by 2002:a17:907:764b:: with SMTP id kj11mr3083298ejc.307.1637637286922;
 Mon, 22 Nov 2021 19:14:46 -0800 (PST)
MIME-Version: 1.0
References: <163294304032.208242.9097581875096098591.stgit@olly>
 <CAHC9VhQtGcLg3cv6dzB=UeZng+xBOwvC2PrvTfJG6V5ASrbxvw@mail.gmail.com>
 <CAHC9VhREpJ3bkcU+cOz_Cg7KaF=QokngvXyhCpus--=d8HSP_g@mail.gmail.com> <ec1fa864-6611-41c8-b405-41e3d713d590@schaufler-ca.com>
In-Reply-To: <ec1fa864-6611-41c8-b405-41e3d713d590@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 22 Nov 2021 22:14:35 -0500
Message-ID: <CAHC9VhQdBTC1GWH-02B7Lb3WtamJvQpNk+OCafururcis=AyQA@mail.gmail.com>
Subject: Re: [PATCH] lsm: security_task_getsecid_subj() -> security_current_getsecid_subj()
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 22, 2021 at 7:40 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 11/22/2021 3:12 PM, Paul Moore wrote:
> > On Fri, Nov 19, 2021 at 5:52 PM Paul Moore <paul@paul-moore.com> wrote:
> >> On Wed, Sep 29, 2021 at 3:17 PM Paul Moore <paul@paul-moore.com> wrote:
> >>> The security_task_getsecid_subj() LSM hook invites misuse by allowing
> >>> callers to specify a task even though the hook is only safe when the
> >>> current task is referenced.  Fix this by removing the task_struct
> >>> argument to the hook, requiring LSM implementations to use the
> >>> current task.  While we are changing the hook declaration we also
> >>> rename the function to security_current_getsecid_subj() in an effort
> >>> to reinforce that the hook captures the subjective credentials of the
> >>> current task and not an arbitrary task on the system.
> >>>
> >>> Signed-off-by: Paul Moore <paul@paul-moore.com>
> >>> ---
> >>>   include/linux/lsm_hook_defs.h         |    3 +--
> >>>   include/linux/lsm_hooks.h             |    8 +++-----
> >>>   include/linux/security.h              |    4 ++--
> >>>   kernel/audit.c                        |    4 ++--
> >>>   kernel/auditfilter.c                  |    3 +--
> >>>   kernel/auditsc.c                      |   10 +++++++++-
> >>>   net/netlabel/netlabel_unlabeled.c     |    2 +-
> >>>   net/netlabel/netlabel_user.h          |    2 +-
> >>>   security/apparmor/lsm.c               |   13 ++++++++++---
> >>>   security/integrity/ima/ima_appraise.c |    2 +-
> >>>   security/integrity/ima/ima_main.c     |   14 +++++++-------
> >>>   security/security.c                   |    6 +++---
> >>>   security/selinux/hooks.c              |   19 +++----------------
> >>>   security/smack/smack.h                |   16 ----------------
> >>>   security/smack/smack_lsm.c            |    9 ++++-----
> >>>   15 files changed, 48 insertions(+), 67 deletions(-)
> >> I never saw any comments, positive or negative, on this patch so I'll
> >> plan on merging it early next week.  If you've got objections, now is
> >> the time to speak up.
> >
> > I just merged this patch, with the AppArmor tweak suggested by Serge,
> > into selinux/next.  Thanks everyone.
>
> Has the security tree been abandoned as a path for general LSM
> changes? Except for the initial Landlock pull and a couple touch-ups
> to capabilities nothing has gone in via security this year. This
> change should have gone in through security, not selinux. I'm glad
> that this change is going in, don't get me wrong on that. I am
> somewhat concerned about the LSM infrastructure work I'm doing,
> and how it's going to get upstream. The diffstats from that look
> a lot like the one here. I seriously doubt that taking the full
> set of changes for stacking through the Smack tree is going to fly. ;)

I don't think there is ever a clear answer when you have a patch(set)
that crosses subsystem boundaries, there is always going to be a bit
of awkwardness and merge-fun for those affected.  If something touches
SELinux, and this patch qualifies as far as I'm concerned, I tend to
offer to take it via the SELinux tree (mostly for selfish reasons as
it helps with merge conflicts) unless James wants to pull it via the
LSM tree; in almost all of those cases James has deferred the changes
to the SELinux tree.  In this particular case I guess I didn't
explicitly ask about the LSM tree vs the SELinux tree, but the patch
has been on-list for weeks and it wasn't snatched up so I felt like
pulling it into the SELinux tree was justified.  If nothing else,
between the SELinux, audit, and netlabel changes I guess I can claim
some level of merge authority ;)

However, regardless of this particular patchset, I agree that the LSM
stacking patches should almost surely go in via the LSM tree.

-- 
paul moore
www.paul-moore.com
