Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E25C433EF
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 14:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 340E9610CE
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 14:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbhINOld (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Sep 2021 10:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbhINOkx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Sep 2021 10:40:53 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE76AC0613F0
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 07:38:52 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id g1so17843844lfj.12
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 07:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8L/bcSxNJ4tzz4pAoPltCZzKKHEXe3XS3TY5gmBtCKY=;
        b=lTvAKlwLed6aHspYjiD3oSfgTWuTPRcU/xPHy1yFqc+U293nqYBS++on328yWwUTvZ
         3Pp0Fx5xFWpd54YbpAfciQPN24Gnx1F2bQSOHKW/gogRX3iquGev4NgfC2l/QvpI7XqH
         2tQuuny6VyuwRNq17tzGFl0mpUVPIsBJZxyKZbZ7mZjlr1Tij1Cshz2ulytYPHhInVkV
         CJvi2u/Nq18IJcLxzeKytgnb3LMtCoZsZLlVSYeciV80xFGOcTTV+42GYmV05XBGhtXc
         nUn4nPUNc8qnO56pa2pZ6aCO6F8srTSCEBrD+N6VhAy5cFuVgV1C49///bVnxELUDhLO
         dnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8L/bcSxNJ4tzz4pAoPltCZzKKHEXe3XS3TY5gmBtCKY=;
        b=mPzDmoJSfKELbUcrGtHcsyKYunpxmB4RyU1TW2f+w8Bsvo82yHrDmVcMIDJq6hIAx1
         wZkTryDwfTMuAcB8jM4gc5dG4OOgikULVh8NEhS74PzCn2x7qvvh0aQr5AHbdV+gy2rt
         UFC4hcotama1aLdjW4zUyeDU7EzbKnF7xGhflBk9s6F2ihsZ3dkMhbiaEdQxFJT9Ny34
         IAlZJk+YjfRoayIVghFaFygP5zTlLJmiE1Q0uI/clqLYma3Y03Rf3yD4+4ksdG26bjbC
         WT7IeVCqz6gddKUo6YSMRMNizBlqmohhLEPMjK7SjoVhXejTZFM6GJ/XfywiXkU6iJGG
         7vUQ==
X-Gm-Message-State: AOAM530woZxd8V1E+jBTfns6hVfQilUHXsNC+QREUwS3UAyJ+AEgLFQm
        Zsz1TOWppBCb47MT84dgktmMlTCblNUhAgeb8uw=
X-Google-Smtp-Source: ABdhPJxor3coUQSw2dmgpnp9J+cMg7aQh9cWfDWiSi2ShBf3x6BhsWsZQlfINGBr0/CFK/Vg0HM9Dc87u3dZSFMr6OU=
X-Received: by 2002:ac2:57cb:: with SMTP id k11mr7508206lfo.70.1631630331056;
 Tue, 14 Sep 2021 07:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <2439a94e3a0c83964af66681dadc016769a6e167.camel@fb.com>
In-Reply-To: <2439a94e3a0c83964af66681dadc016769a6e167.camel@fb.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 14 Sep 2021 10:38:39 -0400
Message-ID: <CAEjxPJ6Rp+kPoLc9DvZFv=pZZ4LTT+w=A6JUS7iVLpa8R3QFxQ@mail.gmail.com>
Subject: Re: [RFC] Signals upon avc denial
To:     Josh Gao <jmgao@fb.com>, Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "jeffv@google.com" <jeffv@google.com>,
        "tweek@google.com" <tweek@google.com>, Nick Kralevich <nnk@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Sep 13, 2021 at 10:09 PM Josh Gao <jmgao@fb.com> wrote:
>
> People working on Oculus (and from my past experience and current
> discussions with the Googlers CCed here, people working on Android)
> have been frustrated with the difficulty of tracking down the precise
> caller that triggers an selinux denial, since it might be multiple
> layers deep in transitive dependencies of the process that actually
> gets blamed. Thi=C3=A9baud implemented a tracepoint which can be used to
> interactively track down a denial, but it has some shortcomings:
>
> - it requires a tracer running as root (or some equivalently scary set
>   of capabilities), so it's not really feasible to run it across our
>   deployment of dogfood devices
>
> - trace output doesn't provide the full context of the process, so
>   AFAIK, it's not possible to do things like unwind through JIT
>   compiled functions, or print syscall arguments that are on the heap
>
> - it's asynchronous, so you can't go in with a debugger and inspect
>   program state to figure out why the failing syscall was made in the
>   first place
>
> In an ideal world, an selinux failure would have the same sort of
> diagnostic tooling as a SIGSEGV. To do this, I propose that we let
> processes opt-in to receiving a signal when an avc denial occurs. If a
> user wants to debug interactively, they can set it to SIGSTOP manually;
> on systems like Android where libc registers a signal handler that
> collects a bug report and forwards it through a crash reporting
> pipeline, the system can set it to that signal automatically.
>
> I'm guessing that the best interface for this is a file in procfs at
> somewhere along the lines of /proc/$PID/selinux/audit_signal, taking a
> signal number. It's probably useful to be able to correlate this with
> an audit serial number, so perhaps we should add an si_code value for
> this, with a field in siginfo_t?
>
> To keep this from inadvertently allowing signals to be sent on systems
> that would otherwise prevent them entirely, we can add a new access
> vectors in process2 to get/set the audit signal.
>
> I think the setting should be maintained across fork; I'm not sure
> whether it should be reset on exec. AT_SECURE transitions almost
> definitely should, but I'm not sure about the utility of inheriting it
> in the first place: if it's configured to a signal that's set by libc,
> and libc itself triggers an audit before it gets around to registering
> a signal handler, the process will mysteriously disappear.
>
> I have a patch against 4.9 that implements most of this [1], but I
> wanted to run this by the upstream mailing list to get some feedback
> before reimplementing it on linux-next.
>
> Thanks,
> Josh
>
> 1: https://gist.github.com/jmgao/9c17bcc93d65472d9dd2a17362ed4075

We already have a /proc/$PID/attr directory for LSM-related process attribu=
tes.
Simple enough to add a new attribute there if we want it to be
general/applicable to other
LSMs. That interface only allows a task to modify its own attributes
(see proc_pid_attr_write);
I assume that suffices here?  Other attributes set that way (e.g.
fscreate / create_sid) are similarly
inherited across fork and unconditionally reset on execve.

Currently in the case of SELinux those attribute values are stored in
the cred security blob, which
used to be the task security blob (hence the legacy
task_security_struct name) before creds existed.
Later LSM revived support for a separate task security blob for the
sake of TOMOYO so that does exist
if needed but SELinux doesn't currently allocate or use it. AppArmor
switched to using it for its task-specific
state after it was restored; SELinux could split its current
task_security_struct into two parts (per-cred and
per-task) and do likewise if that is worthwhile (not sure).

With respect to the implementation, it is generally frowned upon to
embed SELinux-specific fields and code
in the core kernel (versus wrapping in a LSM security field and hooks)
and I think most if not all of what
you want is achievable through existing security fields and hooks once
you add a new attribute to /proc/pid/attr.
