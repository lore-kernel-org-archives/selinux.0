Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0690CC433DB
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 00:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A96C322D01
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 00:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbhAFABw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Jan 2021 19:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbhAFABw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Jan 2021 19:01:52 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F935C061574
        for <selinux@vger.kernel.org>; Tue,  5 Jan 2021 16:01:12 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id g20so2913909ejb.1
        for <selinux@vger.kernel.org>; Tue, 05 Jan 2021 16:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zfAl9KpSkJTd6+U94OCEriXL161o3FlE2sDMdIxmbKg=;
        b=Nm/doGyRQLbdfDauhHJdBMWjqc8dfsV0Ro8t+lUY4IOId9KByo/HmTzrWnYe+azun7
         4znDTF6xd9f2RL72SvmRnRraFzK+o0ExupZGqeZ9FpLuwM9ojh68bhAvIl2Is6ZT6Ls7
         EwZgjtShg6ffB9qGAHMidgzE8KqBcdWmVaItT8V1RRd4nvVSoRwsWVMI4SxwXmAvkmw7
         6u3VoeUyEdQUB+iGPEYBoXQj/3t7J+5Hyk5gRbKG41FjIx5VK9MW3HTaT8myas7Vb8Ez
         Kvy6Jm/WVyeAELN8jKn8Iv9PqyJ/aBgB61WW/PQdS6HroeC4AQLzPGJ0jnndtWQ2D3ws
         Lxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zfAl9KpSkJTd6+U94OCEriXL161o3FlE2sDMdIxmbKg=;
        b=J8DHfAyKiGRq0XFEsx3Y2l5AK2c9PSST6lWxRTQrW5tVERsUY7pWJHMI0TwnnFab43
         NDgCjAL900l8iaSsEFfjpKI79UHhqfoZ6cRuUhFn488U4GQbrRXjLW9YnqEvXjdcGEYA
         g9JlC6H7Zw91hDz0t+fitxgdZTMcKEMaL0aCUnFAlZRkEQTCW4V+3yyFsZcTpAXllFt4
         3KKAmHdm7I8pfiF0Sv4HvXnduk3OqLc8gSiwqGehKvmi+OBMRBmoP3DW8SOCCweSrve9
         qZaEdnCq0gjEl7HsNvqlB0HVbFPve0cgVJyXNpSVYITtxlXM+FEfNkKcM82+3zmtd3Yk
         jvdg==
X-Gm-Message-State: AOAM532OGvjZVEpwzR2otCQovLTTFZHNEK9J6kLk75ZVDwvFV3hVRm6D
        0QDSg7EBxE0FKQMXuJjQ6W9q4vH+YRAF7T1gFzm+
X-Google-Smtp-Source: ABdhPJy2NH+qJf3iqobhjGlTY0DvacTF962UFEkfYVCmTW7lYKZyjdrP0z6+z04lqkN/DK52natckhmozbFQ2B7nwAY=
X-Received: by 2002:a17:907:4126:: with SMTP id mx6mr1206433ejb.91.1609891270677;
 Tue, 05 Jan 2021 16:01:10 -0800 (PST)
MIME-Version: 1.0
References: <20210104232123.31378-1-stephen.s.brennan@oracle.com>
 <20210105055935.GT3579531@ZenIV.linux.org.uk> <20210105165005.GV3579531@ZenIV.linux.org.uk>
 <20210105195937.GX3579531@ZenIV.linux.org.uk> <87a6tnge5k.fsf@stepbren-lnx.us.oracle.com>
In-Reply-To: <87a6tnge5k.fsf@stepbren-lnx.us.oracle.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 5 Jan 2021 19:00:59 -0500
Message-ID: <CAHC9VhQnQW8RvTzyb4MTAvGZ7b=AHJXS8PzD=egTcpdDz73Yzg@mail.gmail.com>
Subject: Re: [PATCH v4] proc: Allow pid_revalidate() during LOOKUP_RCU
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 5, 2021 at 6:27 PM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
> Al Viro <viro@zeniv.linux.org.uk> writes:
>
> > On Tue, Jan 05, 2021 at 04:50:05PM +0000, Al Viro wrote:
> >
> >> LSM_AUDIT_DATA_DENTRY is easy to handle - wrap
> >>                 audit_log_untrustedstring(ab, a->u.dentry->d_name.name);
> >> into grabbing/dropping a->u.dentry->d_lock and we are done.
> >
> > Incidentally, LSM_AUDIT_DATA_DENTRY in mainline is *not* safe wrt
> > rename() - for long-named dentries it is possible to get preempted
> > in the middle of
> >                 audit_log_untrustedstring(ab, a->u.dentry->d_name.name);
> > and have the bugger renamed, with old name ending up freed.  The
> > same goes for LSM_AUDIT_DATA_INODE...
>
> In the case of proc_pid_permission(), this preemption doesn't seem
> possible. We have task_lock() (a spinlock) held by ptrace_may_access()
> during this call, so preemption should be disabled:
>
> proc_pid_permission()
>   has_pid_permissions()
>     ptrace_may_access()
>       task_lock()
>       __ptrace_may_access()
>       | security_ptrace_access_check()
>       |   ptrace_access_check -> selinux_ptrace_access_check()
>       |     avc_has_perm()
>       |       avc_audit() // note that has_pid_permissions() didn't get a
>       |                   // flags field to propagate, so flags will not
>       |                   // contain MAY_NOT_BLOCK
>       |         slow_avc_audit()
>       |           common_lsm_audit()
>       |             dump_common_audit_data()
>       task_unlock()
>
> I understand the issue of d_name.name being freed across a preemption is
> more general than proc_pid_permission() (as other callers may have
> preemption enabled). However, it seems like there's another issue here.
> avc_audit() seems to imply that slow_avc_audit() would sleep:
>
> static inline int avc_audit(struct selinux_state *state,
>                             u32 ssid, u32 tsid,
>                             u16 tclass, u32 requested,
>                             struct av_decision *avd,
>                             int result,
>                             struct common_audit_data *a,
>                             int flags)
> {
>         u32 audited, denied;
>         audited = avc_audit_required(requested, avd, result, 0, &denied);
>         if (likely(!audited))
>                 return 0;
>         /* fall back to ref-walk if we have to generate audit */
>         if (flags & MAY_NOT_BLOCK)
>                 return -ECHILD;
>         return slow_avc_audit(state, ssid, tsid, tclass,
>                               requested, audited, denied, result,
>                               a);
> }
>
> If there are other cases in here where we might sleep, it would be a
> problem to sleep with the task lock held, correct?

I would expect the problem here to be the currently allocated audit
buffer isn't large enough to hold the full audit record, in which case
it will attempt to expand the buffer by a call to pskb_expand_head() -
don't ask why audit buffers are skbs, it's awful - using a gfp flag
that was established when the buffer was first created.  In this
particular case it is GFP_ATOMIC|__GFP_NOWARN, which I believe should
be safe in that it will not sleep on an allocation miss.

I need to go deal with dinner, so I can't trace the entire path at the
moment, but I believe the potential audit buffer allocation is the
main issue.

-- 
paul moore
www.paul-moore.com
