Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6F8C4332F
	for <selinux@archiver.kernel.org>; Thu,  6 Oct 2022 15:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiJFPgS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Oct 2022 11:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbiJFPgQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Oct 2022 11:36:16 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6BABC469
        for <selinux@vger.kernel.org>; Thu,  6 Oct 2022 08:36:14 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id q11so1165547ilj.10
        for <selinux@vger.kernel.org>; Thu, 06 Oct 2022 08:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kBsN+WV474YxARCF7+nqmiK1jJMhN3dpQirfp2PoxlI=;
        b=JjMbJ/6iXZaadLFSJQk/HRtX7HrZ/RZDwb2mntZuqfcRGukztaLnaRtozSNqvZ38A4
         YIoQ/S3pghhDMLpw8KTrVksZJi+qZfmtmFFtL6r+hlek1RDiFjHhO28+25YkHLvlCc/G
         2ton1aYig3VnJwiK390amDUqhjkwHT2v8cCIJriuz9pU8Vq1hyKD89eS6KbebFUKLB7f
         StxxrRJteAZtp0mitV1ByWgBDUKx7ejR8uKWfR+ZopLjyxWlWBgzgq30TO7uWMlo0TOX
         Ot9J/qTOjnGajAnOuylFkpSg9k4OtDzH80hAqWJVInjfgYhV53xWDOLUG2oWhzMmJmJ7
         oo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kBsN+WV474YxARCF7+nqmiK1jJMhN3dpQirfp2PoxlI=;
        b=wuDbp6sIvWzPsoP6miDiXLNK7A+Up2pU3YPMqjempEOnXfwbi6ET8KjsqHAG0CGTwA
         p/GFRXXwemzD0myFzROvAb26gMs/Gubm07oZX1oGs4DvLdSyE5REMikG/CKM7TmD6ru5
         wgNjgzGYnn6quBNDJb51zPYcrKD58I4bcODN3b5DBdZyuMwZ7CHtAfrUgVzVf3vCZ3VU
         kL+5EW43svMek/le0+jiGkB6ztqf+NRTTVHM/qXyBs+vxUMv6D/rRK7u5N95avkcbNnd
         TiffQ0beMHjLb/ReQJ9upav9OzeDVusvTHKUpMOgS0ngv3ERpJ+too1nYEMknf0K/BAq
         i7/g==
X-Gm-Message-State: ACrzQf27SRmUDHyZ/zNsTgFZQViAeF1HMQHKh/GqUPUTx/Sq7syEsAdo
        IOF5SVHX+ls8l9s1qEL72KHSaXCsR126sI/iE52pUg==
X-Google-Smtp-Source: AMsMyM4b3/P730KDfkxwcyTWlRlnjgpSRQAwOlc/NfsO6cxtR79rz7+RL4b861zTtxfuwZkTO8fgQgVJ7C0o9SGCGVA=
X-Received: by 2002:a05:6e02:1989:b0:2f6:45ca:410d with SMTP id
 g9-20020a056e02198900b002f645ca410dmr99039ilf.187.1665070573386; Thu, 06 Oct
 2022 08:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221006082735.1321612-1-keescook@chromium.org>
 <20221006082735.1321612-2-keescook@chromium.org> <20221006090506.paqjf537cox7lqrq@wittgenstein>
 <CAG48ez0sEkmaez9tYqgMXrkREmXZgxC9fdQD3mzF9cGo_=Tfyg@mail.gmail.com> <86CE201B-5632-4BB7-BCF6-7CB2C2895409@chromium.org>
In-Reply-To: <86CE201B-5632-4BB7-BCF6-7CB2C2895409@chromium.org>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 6 Oct 2022 17:35:37 +0200
Message-ID: <CAG48ez2h29CschY7GPiyg7eZT9B4UnBeKtS6AksyD8iDqs25Bg@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/exec: Explicitly unshare fs_struct on exec
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Jorge Merlino <jorge.merlino@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Todd Kjos <tkjos@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Prashanth Prahlad <pprahlad@redhat.com>,
        Micah Morton <mortonm@chromium.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 6, 2022 at 5:25 PM Kees Cook <keescook@chromium.org> wrote:
> On October 6, 2022 7:13:37 AM PDT, Jann Horn <jannh@google.com> wrote:
> >On Thu, Oct 6, 2022 at 11:05 AM Christian Brauner <brauner@kernel.org> wrote:
> >> On Thu, Oct 06, 2022 at 01:27:34AM -0700, Kees Cook wrote:
> >> > The check_unsafe_exec() counting of n_fs would not add up under a heavily
> >> > threaded process trying to perform a suid exec, causing the suid portion
> >> > to fail. This counting error appears to be unneeded, but to catch any
> >> > possible conditions, explicitly unshare fs_struct on exec, if it ends up
> >>
> >> Isn't this a potential uapi break? Afaict, before this change a call to
> >> clone{3}(CLONE_FS) followed by an exec in the child would have the
> >> parent and child share fs information. So if the child e.g., changes the
> >> working directory post exec it would also affect the parent. But after
> >> this change here this would no longer be true. So a child changing a
> >> workding directoro would not affect the parent anymore. IOW, an exec is
> >> accompanied by an unshare(CLONE_FS). Might still be worth trying ofc but
> >> it seems like a non-trivial uapi change but there might be few users
> >> that do clone{3}(CLONE_FS) followed by an exec.
> >
> >I believe the following code in Chromium explicitly relies on this
> >behavior, but I'm not sure whether this code is in active use anymore:
> >
> >https://source.chromium.org/chromium/chromium/src/+/main:sandbox/linux/suid/sandbox.c;l=101?q=CLONE_FS&sq=&ss=chromium
>
> Oh yes. I think I had tried to forget this existed. Ugh. Okay, so back to the drawing board, I guess. The counting will need to be fixed...
>
> It's possible we can move the counting after dethread -- it seems the early count was just to avoid setting flags after the point of no return, but it's not an error condition...

Random idea that I haven't thought about a lot:

One approach might be to not do it by counting, but instead have a
flag on the fs_struct that we set when someone does a clone() with
CLONE_FS but without CLONE_THREAD? Then we'd end up with the following
possible states for fs_struct:

 - single-process, normal
 - single-process, pending execve past check_unsafe_exec() (prevent
concurrent CLONE_FS)
 - shared between processes

The slight difference from the old semantics would be that once you've
used CLONE_FS without CLONE_THREAD, you can never do setuid execve()
from your current process again (without calling unshare()), even if
the child disappears in the meantime. I think that might be an
acceptably small UAPI break.
