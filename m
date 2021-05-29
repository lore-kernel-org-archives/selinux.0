Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2920C4708E
	for <selinux@archiver.kernel.org>; Sat, 29 May 2021 18:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C41D761175
	for <selinux@archiver.kernel.org>; Sat, 29 May 2021 18:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbhE2SuX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 29 May 2021 14:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhE2SuW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 29 May 2021 14:50:22 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD06DC061763
        for <selinux@vger.kernel.org>; Sat, 29 May 2021 11:48:45 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id a25so8616329edr.12
        for <selinux@vger.kernel.org>; Sat, 29 May 2021 11:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PxkN5674Gdo7C/DvFwdmRlPrHnz0qD2VW7zEeao9HA0=;
        b=egZtDVPv+pEmzpQcYmGqbrNNZyRf7Aqgebz64H8qjXLqaTKcUwlR3bcfeOXQVoQ0/I
         7zwI+0FvRjoKaxZUkV7/qMK527UOii8JwIHXsmWt3289bVTzi9jLS7DrylJywuRK85RH
         XBY1R3AHPL69XeC7SFpUqb6jYFOv1/r8nNtp8fKORkkIuxQaK7l7pwk6KrKXFhlZQCGE
         EcOZJePRxsnnGa9NxCm+Hg9bBxdVgKUxA06srzViIJ8xJs6i38G7NVkfnqvzrPg5uWam
         tPUgQZGd1V/osaT50MNDtOL3E3SbY3nnfIen9INxBSbFY2ZNJ5UWnlfEyLDqOf4fSzeX
         BIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PxkN5674Gdo7C/DvFwdmRlPrHnz0qD2VW7zEeao9HA0=;
        b=npj1UBdvu0fnaKYwyIAhmUCIq4UuKhXQKYBvNrAj3iFpfIIpE7DA8RFpe+J/BwGnD2
         WklZHdtY4vBQkimsZ15zz/tsG7D9A8hT8rDJgZLhAHAV5CkGZ9DwMvG3FaNZQDas59h4
         kSKYVnXUj+5XbDfQ26Mq4EJ758cgjJHQe3MII7UBhdfNR4tAOeGt6XtCHV6vUou0r1yY
         Jra23/k/gI9lr51KogYXp+3aoPKsILlV7s6bBgT5vXJs6eqRdDCwYTuC74Jiq7WZZcVU
         fU7dH/SyCF3yxeSu6yEDvfK6rvrj3j2hF561GU3aYU57GEH57LcvjNk6mfNe3JsuRrbl
         Sarg==
X-Gm-Message-State: AOAM533dCxFIK5gZ6Zappm4jmSZPlZQkp8mpJpvIc62mLhD76cqR//bC
        OIwkf07snyTuOPjfCSS0uRMaV2PykUIi46XHg8/4
X-Google-Smtp-Source: ABdhPJyUKpixSoshzQJyPJqEx0bgxxFA8s58ydUH/2LXx1S03FTwjdX+rXFI9WK5gl/+d4oHpjX3EfrlNm+PVmnhJgQ=
X-Received: by 2002:a05:6402:430b:: with SMTP id m11mr16690557edc.31.1622314124071;
 Sat, 29 May 2021 11:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210517092006.803332-1-omosnace@redhat.com> <CAHC9VhTasra0tU=bKwVqAwLRYaC+hYakirRz0Mn5jbVMuDkwrA@mail.gmail.com>
 <01135120-8bf7-df2e-cff0-1d73f1f841c3@iogearbox.net> <CAHC9VhR-kYmMA8gsqkiL5=poN9FoL-uCyx1YOLCoG2hRiUBYug@mail.gmail.com>
 <c7c2d7e1-e253-dce0-d35c-392192e4926e@iogearbox.net>
In-Reply-To: <c7c2d7e1-e253-dce0-d35c-392192e4926e@iogearbox.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 29 May 2021 14:48:33 -0400
Message-ID: <CAHC9VhS1XRZjKcTFgH1+n5uA-CeT+9BeSP5jvT2+RE5ougLpUg@mail.gmail.com>
Subject: Re: [PATCH v2] lockdown,selinux: avoid bogus SELinux lockdown
 permission checks
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>, jolsa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 28, 2021 at 2:28 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> In the case of tracing, it's different. You install small programs that are
> triggered when certain events fire. Random example from bpftrace's README [0],
> you want to generate a histogram of syscall counts by program. One-liner is:
>
>    bpftrace -e 'tracepoint:raw_syscalls:sys_enter { @[comm] = count(); }'
>
> bpftrace then goes and generates a BPF prog from this internally. One way of
> doing it could be to call bpf_get_current_task() helper and then access
> current->comm via one of bpf_probe_read_kernel{,_str}() helpers ...

I think we can all agree that the BPF tracing is a bit chaotic in the
sense that the tracing programs can be executed in various
places/contexts and that presents some challenges with respect to
access control and auditing.  If you are following the io_uring stuff
that is going on now you can see a little of what is required to make
audit work properly in the various io_uring contexts and that is
relatively small compared to what is possible with BPF tracing.  Of
course this assumes I've managed to understand bpf tracing properly
this morning, and I very well may still be missing points and/or
confused about some of the important details.  Corrections are
welcome.

Daniel's patch side steps that worry by just doing the lockdown
permission check when the BPF program is loaded, but that isn't a
great solution if the policy changes afterward.  I was hoping there
might be some way to perform the permission check as needed, but the
more I look the more that appears to be difficult, if not impossible
(once again, corrections are welcome).

I'm now wondering if the right solution here is to make use of the LSM
notifier mechanism.  I'm not yet entirely sure if this would work from
a BPF perspective, but I could envision the BPF subsystem registering
a LSM notification callback via register_blocking_lsm_notifier(), see
if Infiniband code as an example, and then when the LSM(s) policy
changes the BPF subsystem would get a notification and it could
revalidate the existing BPF programs and take block/remove/whatever
the offending BPF programs.  This obviously requires a few things
which I'm not sure are easily done, or even possible:

1. Somehow the BPF programs would need to be "marked" at
load/verification time with respect to their lockdown requirements so
that decisions can be made later.  Perhaps a flag in bpf_prog_aux?

2. While it looks like it should be possible to iterate over all of
the loaded BPF programs in the LSM notifier callback via
idr_for_each(prog_idr, ...), it is not clear to me if it is possible
to safely remove, or somehow disable, BPF programs once they have been
loaded.  Hopefully the BPF folks can help answer that question.

3. Disabling of BPF programs might be preferable to removing them
entirely on LSM policy changes as it would be possible to make the
lockdown state less restrictive at a future point in time, allowing
for the BPF program to be executed again.  Once again, not sure if
this is even possible.

Related, the lockdown LSM should probably also grow LSM notifier
support similar to selinux_lsm_notifier_avc_callback(), for example
either lock_kernel_down() or lockdown_write() might want to do a
call_blocking_lsm_notifier(LSM_POLICY_CHANGE, NULL) call.

-- 
paul moore
www.paul-moore.com
