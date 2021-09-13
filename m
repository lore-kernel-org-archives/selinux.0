Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B504C433EF
	for <selinux@archiver.kernel.org>; Mon, 13 Sep 2021 19:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E89EE610CE
	for <selinux@archiver.kernel.org>; Mon, 13 Sep 2021 19:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242123AbhIMTZL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Sep 2021 15:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242107AbhIMTZK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Sep 2021 15:25:10 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3CFC061764
        for <selinux@vger.kernel.org>; Mon, 13 Sep 2021 12:23:54 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z94so9782465ede.8
        for <selinux@vger.kernel.org>; Mon, 13 Sep 2021 12:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TcorpZqRElhh8icUXu5/Wjk6aoLV7T6vR6pbFYz8Qd8=;
        b=ydtks7gYR8Uw2VSWHgVC708RYXvso7fLoQELwaGwAFdXGApG/yx/YT3x0w8WaJVnIt
         jz1iNmY7ivcQiEvTRWwmGDExFEUu7rMK2F5RrPB9bePN/kxkkjM83OnVmzvagjtURYXu
         GzfBtaqVf3EO3dlhVdEML4AmUI9BRdXSppNKfEIVkCG6aSCiySdYkzX29FpuI1oLvWC1
         h4nwfc9zh3TF+Ip6k4LFKDBBq1UWZROcHh7K75Gi62wqm76szl3okohEckbIx8tuwiGf
         J85n9Phhxk4rK5n941sYxn3pisPLngMblY8Bz7YAZJ9C7nzVmG8DdIlfs5bSrdwWLHYc
         kyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TcorpZqRElhh8icUXu5/Wjk6aoLV7T6vR6pbFYz8Qd8=;
        b=Yf5JcYlu+XycgSjy3YBh7W6+J9hP1PRDIRMfCZhzz80/djy0h4/Po8bgCZODwkbHPf
         KoyX9FfwRQKLoiU6hnLKxzXscTkS3E67Ngpp+K7cCAT+qNxnpZVHgsJC1QAntFA7pThB
         y8+f9nlyMCIG92FZRvFCSFRyImZyPHNNTOdivas9HqiINOgUks1fCp0YKwc2PlLDTNks
         sjF0Tg500W6kmV8wvZzisNROrOY3JB6f9ebzgkiP6uYs0CmZAfjWhZG9sevPXeI4aNNI
         T0enHO9frNtUvaqedZsy2s3eEFVO8KWmCUiHTzTQ7sySLJmsKku9QRKeqkWfKStqc3l9
         TtnA==
X-Gm-Message-State: AOAM5323e/R/m4hmu6KPJfngNpX0W9M6TlCuc+5njaFIaNtIk8h8WaiX
        6ySj7UKMdUpfc00QHYRuzfm2UamO9yEPbYH7aGMX
X-Google-Smtp-Source: ABdhPJw72PWy+Ek7Yh6HCSEriHIFfULxMHozke1SOnPoaKBF0nb9CB65Q8xJQ9oJd5btFk8BQKk9D+PpKLQkVUJ0dgg=
X-Received: by 2002:aa7:dd4e:: with SMTP id o14mr14479630edw.104.1631561032707;
 Mon, 13 Sep 2021 12:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210824205724.GB490529@madcap2.tricolour.ca> <20210826011639.GE490529@madcap2.tricolour.ca>
 <CAHC9VhSADQsudmD52hP8GQWWR4+=sJ7mvNkh9xDXuahS+iERVA@mail.gmail.com>
 <20210826163230.GF490529@madcap2.tricolour.ca> <CAHC9VhTkZ-tUdrFjhc2k1supzW1QJpY-15pf08mw6=ynU9yY5g@mail.gmail.com>
 <20210827133559.GG490529@madcap2.tricolour.ca> <CAHC9VhRqSO6+MVX+LYBWHqwzd3QYgbSz3Gd8E756J0QNEmmHdQ@mail.gmail.com>
 <20210828150356.GH490529@madcap2.tricolour.ca> <CAHC9VhRgc_Fhi4c6L__butuW7cmSFJxTMxb+BBn6P-8Yt0ck_w@mail.gmail.com>
 <CAHC9VhQD8hKekqosjGgWPxZFqS=EFy-_kQL5zAo1sg0MU=6n5A@mail.gmail.com> <20210910005858.GL490529@madcap2.tricolour.ca>
In-Reply-To: <20210910005858.GL490529@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 13 Sep 2021 15:23:41 -0400
Message-ID: <CAHC9VhSRJYW7oRq6iLCH_UYukeFfE0pEJ_wBLdr1mw2QGUPh-Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/9] Add LSM access controls and auditing to io_uring
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     sgrubb@redhat.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-audit@redhat.com,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 9, 2021 at 8:59 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2021-09-01 15:21, Paul Moore wrote:
> > On Sun, Aug 29, 2021 at 11:18 AM Paul Moore <paul@paul-moore.com> wrote:
> > > On Sat, Aug 28, 2021 at 11:04 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > I did set a syscall filter for
> > > >         -a exit,always -F arch=b64 -S io_uring_enter,io_uring_setup,io_uring_register -F key=iouringsyscall
> > > > and that yielded some records with a couple of orphans that surprised me
> > > > a bit.
> > >
> > > Without looking too closely at the log you sent, you can expect URING
> > > records without an associated SYSCALL record when the uring op is
> > > being processed in the io-wq or sqpoll context.  In the io-wq case the
> > > processing is happening after the thread finished the syscall but
> > > before the execution context returns to userspace and in the case of
> > > sqpoll the processing is handled by a separate kernel thread with no
> > > association to a process thread.
> >
> > I spent some time this morning/afternoon playing with the io_uring
> > audit filtering capability and with your audit userspace
> > ghau-iouring-filtering.v1.0 branch it appears to work correctly.  Yes,
> > the userspace tooling isn't quite 100% yet (e.g. `auditctl -l` doesn't
> > map the io_uring ops correctly), but I know you mentioned you have a
> > number of fixes/improvements still as a work-in-progress there so I'm
> > not too concerned.  The important part is that the kernel pieces look
> > to be working correctly.
>
> Ok, I have squashed and pushed the audit userspace support for iouring:
>         https://github.com/rgbriggs/audit-userspace/commit/e8bd8d2ea8adcaa758024cb9b8fa93895ae35eea
>         https://github.com/linux-audit/audit-userspace/compare/master...rgbriggs:ghak-iouring-filtering.v2.1
> There are test rpms for f35 here:
>         http://people.redhat.com/~rbriggs/ghak-iouring/git-e8bd8d2-fc35/
>
> userspace v2 changelog:
> - check for watch before adding perm
> - update manpage to include filesystem filter
> - update support for the uring filter list: doc, -U op, op names
> - add support for the AUDIT_URINGOP record type
> - add uringop support to ausearch
> - add uringop support to aureport
> - lots of bug fixes
>
> "auditctl -a uring,always -S ..." will now throw an error and require
> "-U" instead.

Thanks Richard.

FYI, I rebased the io_uring/LSM/audit patchset on top of v5.15-rc1
today and tested both with your v1.0 and with your v2.1 branch and the
various combinations seemed to work just fine (of course the v2.1
userspace branch was more polished, less warts, etc.).  I'm going to
go over the patch set one more time to make sure everything is still
looking good, write up an updated cover letter, and post a v3 revision
later tonight with the hope of merging it into -next later this week.

-- 
paul moore
www.paul-moore.com
