Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFFDC433DB
	for <selinux@archiver.kernel.org>; Thu,  7 Jan 2021 22:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52783235FF
	for <selinux@archiver.kernel.org>; Thu,  7 Jan 2021 22:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbhAGWlM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Jan 2021 17:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbhAGWlM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 Jan 2021 17:41:12 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBCBC0612F5
        for <selinux@vger.kernel.org>; Thu,  7 Jan 2021 14:40:31 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id d17so11911092ejy.9
        for <selinux@vger.kernel.org>; Thu, 07 Jan 2021 14:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+XqVUgVy1pNqlxwWd84db3LuiaUvuAHDBIZX+64W06k=;
        b=NWv01/zlyr6q4YPTCOMw9UY+da1CE8yvE6GZIprVi4hP1rB4m6+X4xE6B6p+eM1shE
         0zE5jIDed7UafJJVgMB6ps4K6ZZL2xhShkgG9G/NzeQO5b+qfNC3chpr/tt4pjl5byp/
         CIqStP6l1L3/IcWbmD/46AOc7BYuxJMUuzBYdv8+5r4+HKT+rE6PtzqhBvBDDAAYYAM8
         GpKBoLMnXaSmCjt5fHi0T0v1cbvIMuA0WHOmV9Ax+b5Q1knQxE73WaUPRiyKdQV9E5d0
         1jeQGsSOsRWOasPp3Y1z4wtnXrVsjdPt9zIppPGahZV1grkOPXoOm2q058gj8KL1AspE
         oKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+XqVUgVy1pNqlxwWd84db3LuiaUvuAHDBIZX+64W06k=;
        b=SJ78iQWhj9Xt9qqk2lnEGvGzTPAkBgamVm1kLAgE9ydtXnff11ZHykmFAsAPBsGHaB
         24PBIUJjTDVH9DTtK4qu9GX83sYeQ+EiFzwonwPY5/2ea5/YueN8LYwF+PwtinyrXqAz
         3sT/EM7PoEVNAE6THHBDRGN6cC+/EAl7VMuKrGBEYvc7M+i4d2d5FE0Vv6deM6xpMFF1
         D77TJCNI5bkWorJNuEnhnUgd9Q2SK11Q/TY3c1f0mJu3RsrK5nhcI0b4ZgauZcqz09Yg
         oXIR8vq4OXTXKWe6Unn68IdknpsA3PlQSa2y6R1Q5/JVdU6AmHdZcV3TKYcJaERAxN5z
         mM/A==
X-Gm-Message-State: AOAM5316XK0Ksvc9bo2gHvJwrp9A7lEhqAMrO+EG+PNW1qBE0PFKDy97
        ysGzU/kmJXjLYz3zISBa8EHGQaIOmn0ku+H9Wyy5lQ==
X-Google-Smtp-Source: ABdhPJwZ7WP+sgJ8+ZyhYXNdwlC3xgvuyXpzmUt/hdDxhpxuuYpYzodvyLVmvEcLcEqe1d518K6Uml2VPwoViudSN5w=
X-Received: by 2002:a17:906:351a:: with SMTP id r26mr657411eja.409.1610059230459;
 Thu, 07 Jan 2021 14:40:30 -0800 (PST)
MIME-Version: 1.0
References: <20201112015359.1103333-1-lokeshgidra@google.com>
 <20201112015359.1103333-4-lokeshgidra@google.com> <CAHC9VhS2WNXn2cVAUcAY5AmmBv+=XsthCevofNNuEOU3=jtLrg@mail.gmail.com>
 <CA+EESO5wXubeutVOdbp_LamfP5TyG0r7BO-qnWV=wkd9zWqJ4w@mail.gmail.com> <CAHC9VhSPOHr+ayFK2RADh6u8Dsmp5GYPTWs3HLPtjwbFTgVrfQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSPOHr+ayFK2RADh6u8Dsmp5GYPTWs3HLPtjwbFTgVrfQ@mail.gmail.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Thu, 7 Jan 2021 14:40:19 -0800
Message-ID: <CA+EESO4YOJe6V6R_gng++gYH9BOGjGJQ9nqXyymTkJOWSaOUYg@mail.gmail.com>
Subject: Re: [PATCH v13 3/4] selinux: teach SELinux about anonymous inodes
To:     Paul Moore <paul@paul-moore.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Eric Paris <eparis@parisplace.org>,
        Daniel Colascione <dancol@dancol.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Calin Juravle <calin@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 7, 2021 at 2:30 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Wed, Jan 6, 2021 at 10:55 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > On Wed, Jan 6, 2021 at 7:03 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Wed, Nov 11, 2020 at 8:54 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > > > From: Daniel Colascione <dancol@google.com>
> > > >
> > > > This change uses the anon_inodes and LSM infrastructure introduced in
> > > > the previous patches to give SELinux the ability to control
> > > > anonymous-inode files that are created using the new
> > > > anon_inode_getfd_secure() function.
> > > >
> > > > A SELinux policy author detects and controls these anonymous inodes by
> > > > adding a name-based type_transition rule that assigns a new security
> > > > type to anonymous-inode files created in some domain. The name used
> > > > for the name-based transition is the name associated with the
> > > > anonymous inode for file listings --- e.g., "[userfaultfd]" or
> > > > "[perf_event]".
> > > >
> > > > Example:
> > > >
> > > > type uffd_t;
> > > > type_transition sysadm_t sysadm_t : anon_inode uffd_t "[userfaultfd]";
> > > > allow sysadm_t uffd_t:anon_inode { create };
> > > >
> > > > (The next patch in this series is necessary for making userfaultfd
> > > > support this new interface.  The example above is just
> > > > for exposition.)
> > > >
> > > > Signed-off-by: Daniel Colascione <dancol@google.com>
> > > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > > > ---
> > > >  security/selinux/hooks.c            | 56 +++++++++++++++++++++++++++++
> > > >  security/selinux/include/classmap.h |  2 ++
> > > >  2 files changed, 58 insertions(+)
> > > >
> > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > index 6b1826fc3658..d092aa512868 100644
> > > > --- a/security/selinux/hooks.c
> > > > +++ b/security/selinux/hooks.c
> > > > @@ -2927,6 +2927,61 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
> > > >         return 0;
> > > >  }
> > > >
> > > > +static int selinux_inode_init_security_anon(struct inode *inode,
> > > > +                                           const struct qstr *name,
> > > > +                                           const struct inode *context_inode)
> > > > +{
> > > > +       const struct task_security_struct *tsec = selinux_cred(current_cred());
> > > > +       struct common_audit_data ad;
> > > > +       struct inode_security_struct *isec;
> > > > +       int rc;
> > > > +
> > > > +       if (unlikely(!selinux_initialized(&selinux_state)))
> > > > +               return 0;
> > > > +
> > > > +       isec = selinux_inode(inode);
> > > > +
> > > > +       /*
> > > > +        * We only get here once per ephemeral inode.  The inode has
> > > > +        * been initialized via inode_alloc_security but is otherwise
> > > > +        * untouched.
> > > > +        */
> > > > +
> > > > +       if (context_inode) {
> > > > +               struct inode_security_struct *context_isec =
> > > > +                       selinux_inode(context_inode);
> > > > +               if (context_isec->initialized != LABEL_INITIALIZED)
> > > > +                       return -EACCES;
> > > > +
> > > > +               isec->sclass = context_isec->sclass;
> > >
> > > Taking the object class directly from the context_inode is
> > > interesting, and I suspect problematic.  In the case below where no
> > > context_inode is supplied the object class is set to
> > > SECCLASS_ANON_INODE, which is correct, but when a context_inode is
> > > supplied there is no guarantee that the object class will be set to
> > > SECCLASS_ANON_INODE.  This could both pose a problem for policy
> > > writers (how do you distinguish the anon inode from other normal file
> > > inodes in this case?) as well as an outright fault later in this
> > > function when we try to check the ANON_INODE__CREATE on an object
> > > other than a SECCLASS_ANON_INODE object.
> > >
> > Thanks for catching this. I'll initialize 'sclass' unconditionally to
> > SECCLASS_ANON_INODE in the next version. Also, do you think I should
> > add a check that context_inode's sclass must be SECCLASS_ANON_INODE to
> > confirm that we never receive a regular inode as context_inode?
>
> This is one of the reasons why I was asking if you ever saw the need
> to use a regular inode here.  It seems much safer to me to add a check
> to ensure that context_inode is SECCLASS_ANON_INODE and return an
> error otherwise; I would also suggest emitting an error using pr_err()
> with something along the lines of "SELinux:  initializing anonymous
> inode with inappropriate inode" (or something similar).
>
Thanks. I'll do that.

> If something changes in the future we can always reconsider this restriction.
>
> > > It works in the userfaultfd case because the context_inode is
> > > originally created with this function so the object class is correctly
> > > set to SECCLASS_ANON_INODE, but can we always guarantee that to be the
> > > case?  Do we ever need or want to support using a context_inode that
> > > is not SECCLASS_ANON_INODE?
> >
> > I don't think there is any requirement of supporting context_inode
> > which isn't anon-inode. And even if there is, as you described
> > earlier, for ANON_INODE__CREATE to work the sclass has to be
> > SECCLASS_ANON_INODE. I'll appreciate comments on this from others,
> > particularly Daniel and Stephen who originally discussed and
> > implemented this patch.
>
> I would encourage you not to wait too long for additional feedback
> before sending the next revision.

Certainly. I'll send next version in a day or two.
>
> --
> paul moore
> www.paul-moore.com
