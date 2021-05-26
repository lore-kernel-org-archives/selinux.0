Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F6EC47088
	for <selinux@archiver.kernel.org>; Wed, 26 May 2021 11:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3CC761248
	for <selinux@archiver.kernel.org>; Wed, 26 May 2021 11:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbhEZLqu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 May 2021 07:46:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23614 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232884AbhEZLqs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 May 2021 07:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622029517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Uw+/IY4PFLhc9QD0XQTD8Vq22Bv9V1A42B8cw/tcfQ=;
        b=PV4ISET/MSGNoR/qinkk7kLUo05DbFd2wCawswmA/6OoQbDcBLBD8iWLorabdZbPb6XZLe
        9JVBO7DR4iE5KnBFOBDs6a0uNyZFPkYMNiCpbQ8xXo8IMd36F7fLgCGBxmywPFXuLJbGLY
        dKx66nnHCQY5wyWFFMoH58/tD6iwHNY=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-VXR7LLi4N0y5wAgjiGNijA-1; Wed, 26 May 2021 07:45:15 -0400
X-MC-Unique: VXR7LLi4N0y5wAgjiGNijA-1
Received: by mail-yb1-f200.google.com with SMTP id d63-20020a254f420000b02904f91ef33453so1340002ybb.12
        for <selinux@vger.kernel.org>; Wed, 26 May 2021 04:45:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Uw+/IY4PFLhc9QD0XQTD8Vq22Bv9V1A42B8cw/tcfQ=;
        b=Sf73YjdyUGu32Tg5ogttsMWZo77HDJm85S3TACYV9S4XtkRyNZC+3P/z4lrAyONS2c
         OxzBzgbXWf7b4YgZH+icdp+UsrLA4tbnXLmCNVGaMBDZbYv1SGvEegTR3X8xOxEM5uG3
         iItAz0AyOwSsJHAP/rBnrBqkFwvHKbJdvbvnyJ8+moFWAmXpTPhX1LZO5Tyg9L6E+6rZ
         oSk0+9QFBn2x5Y4lzYopbzZ+4kcxAvYmmNZQ/B0AsMWxgHd0cZ9ZPWN7ewbfnlO5O39M
         kVo7YZKdcQswa675wjvhsOYAjHv2ndSeJ+SEmSj7ECSBuMi4fHvyp7X8gYtsiOs7rUqM
         Afdw==
X-Gm-Message-State: AOAM532SeZD5ryS3VbLO8u0OfGHOyOsYOvRUzdKH7T0A0e6QcBjxKLPu
        Q/EN+9Q/572QjgvgJ6kJk14AnP0NeufNe5jO3xnTYqKCgy8tIduBs6Bxs2J3UuSpY73GV3pujCW
        gp6Gp3VlgWUcNbKDsn2FwtV49cdSMFHm6ug==
X-Received: by 2002:a25:f50e:: with SMTP id a14mr48352357ybe.172.1622029514557;
        Wed, 26 May 2021 04:45:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7JX0t9Q+MjZUdNuGYqNNwFWjv7mwlUzB5zjT5J9a7c3DzGoUhB3CdgL/OZI5wwTVrJZE9FoOnkmowu6kRXnk=
X-Received: by 2002:a25:f50e:: with SMTP id a14mr48352333ybe.172.1622029514339;
 Wed, 26 May 2021 04:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210517092006.803332-1-omosnace@redhat.com> <87o8d9k4ln.fsf@mpe.ellerman.id.au>
In-Reply-To: <87o8d9k4ln.fsf@mpe.ellerman.id.au>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 26 May 2021 13:44:59 +0200
Message-ID: <CAFqZXNtUvrGxT6UMy81WfMsfZsydGN5k-VGFBq8yjDWN5ARAWw@mail.gmail.com>
Subject: Re: [PATCH v2] lockdown,selinux: avoid bogus SELinux lockdown
 permission checks
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, network dev <netdev@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 17, 2021 at 1:00 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
> Ondrej Mosnacek <omosnace@redhat.com> writes:
> > Commit 59438b46471a ("security,lockdown,selinux: implement SELinux
> > lockdown") added an implementation of the locked_down LSM hook to
> > SELinux, with the aim to restrict which domains are allowed to perform
> > operations that would breach lockdown.
> >
> > However, in several places the security_locked_down() hook is called in
> > situations where the current task isn't doing any action that would
> > directly breach lockdown, leading to SELinux checks that are basically
> > bogus.
> >
> > Since in most of these situations converting the callers such that
> > security_locked_down() is called in a context where the current task
> > would be meaningful for SELinux is impossible or very non-trivial (and
> > could lead to TOCTOU issues for the classic Lockdown LSM
> > implementation), fix this by modifying the hook to accept a struct cred
> > pointer as argument, where NULL will be interpreted as a request for a
> > "global", task-independent lockdown decision only. Then modify SELinux
> > to ignore calls with cred == NULL.
> >
> > Since most callers will just want to pass current_cred() as the cred
> > parameter, rename the hook to security_cred_locked_down() and provide
> > the original security_locked_down() function as a simple wrapper around
> > the new hook.
> >
> > The callers migrated to the new hook, passing NULL as cred:
> > 1. arch/powerpc/xmon/xmon.c
> >      Here the hook seems to be called from non-task context and is only
> >      used for redacting some sensitive values from output sent to
> >      userspace.
>
> It's hard to follow but it actually disables interactive use of xmon
> entirely if lockdown is in confidentiality mode, and disables
> modifications of the kernel in integrity mode.
>
> But that's not really that important, the patch looks fine.
>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

Thanks, Michael!

James/Paul, is there anything blocking this patch from being merged?
Especially the BPF case is causing real trouble for people and the
only workaround is to broadly allow lockdown::confidentiality in the
policy.

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

