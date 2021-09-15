Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA627C433FE
	for <selinux@archiver.kernel.org>; Wed, 15 Sep 2021 13:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4094600AA
	for <selinux@archiver.kernel.org>; Wed, 15 Sep 2021 13:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbhIONlY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Sep 2021 09:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbhIONlX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Sep 2021 09:41:23 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A441BC061574
        for <selinux@vger.kernel.org>; Wed, 15 Sep 2021 06:40:04 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id s12so1265874ljg.0
        for <selinux@vger.kernel.org>; Wed, 15 Sep 2021 06:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V+4duhIR1J4kPcgYwRMPD2IvOj4buFCKFfrM7rP9qF4=;
        b=J0SMdbylPja++XFPyNABBFRkvN9EwRSRbVUAFalVHSXfijpHRkbeADymYh/FRXIme2
         gf7UT4L4tJau/zerCXV5Njo6owkKhlgcorpzmv/lHXPlAlPoRd3cyYgbijdxEpfPbUvG
         KeA3S5ob0bTY38ljB0cM9mFhX4livKP/mwTrjy+Cr1rbRV62+ulDBpiHopmft93Z89gQ
         EbyDM86NqgJ6TMKOoEweRhh15juzpCt8HhzYGPE//ow2GX5uDL2/Z6j4R6jI5nFSYiDB
         lqoaMkNLKxRK8BKzLKFi75MvLjlxNqkYv/BP+hdnLDd3F0mn2oMXvR8A5qB4HF3i0XaR
         WhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V+4duhIR1J4kPcgYwRMPD2IvOj4buFCKFfrM7rP9qF4=;
        b=rChoBi7tcSioVxI5jD0HGMQdTizb5djodY4ZZaTg76S5ARQZ4HTZQGfOl8C8KZKMTc
         wkesI0s/EIw4qTSpSeD3uXkwYemvlK1lJ2Z9UUzBAsjsf+QmLLcb6cEmQzbAcubWjIP+
         xcV9QDWAR9ROP3k7E1JuVrAzOG5pI+/b6XBHCC662Kx4k0ifOI8faBt0cYo9fCBXxoat
         TZ1Ng2pImHOkwtoMMCXbomWjQzJyQUsZ9k12bHhPf0tqUsKT7PD1TvzF2icKXGmSXsmQ
         MEgYK1yO13/moGe9oLfVcQpNyyin7tg4ukM3/q5gg8817bmmaJO4fAhqyVa+4bWsqTZ2
         FSJw==
X-Gm-Message-State: AOAM532XUjheYTJJMCnYWvYLNjBDSApJ56e0/5KK87SLP3H7oIEX3vlU
        u91J3svG+gl+HQT/YLUYri2QggZDXKcTm9MdjVI=
X-Google-Smtp-Source: ABdhPJw36H1T5/rYrLb6LIuTLjkl3QyB8uvwS582QSqBwOPLDrmcrtIL487cL/NuUapIk7T256/z4XvcAeoQGPOznsg=
X-Received: by 2002:a05:651c:512:: with SMTP id o18mr20983923ljp.199.1631713202889;
 Wed, 15 Sep 2021 06:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <2439a94e3a0c83964af66681dadc016769a6e167.camel@fb.com>
 <CAEjxPJ6Rp+kPoLc9DvZFv=pZZ4LTT+w=A6JUS7iVLpa8R3QFxQ@mail.gmail.com> <6051546ef6299b0a1e3ae545f3640280187f7c13.camel@fb.com>
In-Reply-To: <6051546ef6299b0a1e3ae545f3640280187f7c13.camel@fb.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 15 Sep 2021 09:39:51 -0400
Message-ID: <CAEjxPJ5qUknxN3jzH2d35G9xpPzXdFO8Rzi1CJT3uU8pMDDmsg@mail.gmail.com>
Subject: Re: [RFC] Signals upon avc denial
To:     Josh Gao <jmgao@fb.com>
Cc:     "omosnace@redhat.com" <omosnace@redhat.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "jeffv@google.com" <jeffv@google.com>,
        "tweek@google.com" <tweek@google.com>, Nick Kralevich <nnk@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 15, 2021 at 2:27 AM Josh Gao <jmgao@fb.com> wrote:
>
> On Tue, 2021-09-14 at 10:38 -0400, Stephen Smalley wrote:
> > Currently in the case of SELinux those attribute values are stored in
> > the cred security blob, which
> > used to be the task security blob (hence the legacy
> > task_security_struct name) before creds existed.
> > Later LSM revived support for a separate task security blob for the
> > sake of TOMOYO so that does exist
> > if needed but SELinux doesn't currently allocate or use it. AppArmor
> > switched to using it for its task-specific
> > state after it was restored; SELinux could split its current
> > task_security_struct into two parts (per-cred and
> > per-task) and do likewise if that is worthwhile (not sure).
>
> My understanding is that `struct cred` is a per-task attribute, not
> per-thread-group, so different threads can have different task security
> blobs. Do you know if this is possible without doing something weird
> like setuid in a multithreaded process?

You can't just set the audit signal once in the first thread before
creating multiple threads and let the child threads inherit it across
clone(2)?
Currently ->exit_signal and ->pdeath_signal are part of task_struct,
so it seems consistent to put this into something per-task,
whether part of task->security or task->cred->security. If not and it
needs to be shared across a thread group, I guess you could try to
get a new security field added to the appropriate structure instead.
