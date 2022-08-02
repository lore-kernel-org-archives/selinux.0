Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA589C00140
	for <selinux@archiver.kernel.org>; Tue,  2 Aug 2022 21:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbiHBVZd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Aug 2022 17:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbiHBVZT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Aug 2022 17:25:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED5D5FC4
        for <selinux@vger.kernel.org>; Tue,  2 Aug 2022 14:25:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48AE7B82103
        for <selinux@vger.kernel.org>; Tue,  2 Aug 2022 21:25:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D282C4347C
        for <selinux@vger.kernel.org>; Tue,  2 Aug 2022 21:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659475512;
        bh=DRcXHF+hL2akkSQuSU/bab25l1HxDgWat6fbp5QgZhU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QxpXr4zEDid9zQACiU7ixn4JbzdQg/vrTaY6nU4zwljdOhgj4to0p2MpZziBfKxrV
         v2ZJsV0dHKvWwpKoXCMosUiaPQZ7O2AEVykAryz9rWYWy6MHBQSVH/Wk6TCUTBZDq4
         LawtK+Nidmat1TYZU/7PF9hfU/zSylBgQoW7ze/MAwrilKMliQlypdt3J4nRMAdrJf
         rip9Vq0Cxegk3LaQ+Wdfv80D4VFWkHzRNNcpcimZlBhDWKV9KPHt72eEkghMS7dDXE
         dgFocuHYzgJgmtE6MF6T045+CcK1KkUWBJncK/nRZRWslkZfobXRh/F2WuUiiLG27V
         ZmHBOHXePvVjQ==
Received: by mail-yb1-f175.google.com with SMTP id n8so25593519yba.2
        for <selinux@vger.kernel.org>; Tue, 02 Aug 2022 14:25:12 -0700 (PDT)
X-Gm-Message-State: ACgBeo02tX+cv8eeARDTVDLXdayvvcGyS/T3ZZnGjDlUvn9iJZ5D4iNv
        kj49f2tFBCK5eOrCkmXXtQvqw5XYWyNPOMtY64iW/w==
X-Google-Smtp-Source: AA6agR76IZreUuGci5NqrZubzetTIA/QdScJIvyrhjNqtyLp6A9JrFMy5bTInLzADq8lje7PLu8L4AMmL5D5TBPUlpI=
X-Received: by 2002:a0d:f0c7:0:b0:31e:e814:e7d6 with SMTP id
 z190-20020a0df0c7000000b0031ee814e7d6mr20401368ywe.340.1659475500117; Tue, 02
 Aug 2022 14:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220721172808.585539-1-fred@cloudflare.com> <20220722061137.jahbjeucrljn2y45@kafai-mbp.dhcp.thefacebook.com>
 <18225d94bf0.28e3.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <a4db1154-94bc-9833-1665-a88a5eee48de@cloudflare.com> <CAHC9VhQw8LR9yJ9UkA-9aPNETQavt25G-GGSs-_ztg6ZpxNzxA@mail.gmail.com>
In-Reply-To: <CAHC9VhQw8LR9yJ9UkA-9aPNETQavt25G-GGSs-_ztg6ZpxNzxA@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 2 Aug 2022 23:24:49 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7=Cvo9qncMX_5_Wp1zNNWDyh3DxdOLq_ysWxDCs8VC8g@mail.gmail.com>
Message-ID: <CACYkzJ7=Cvo9qncMX_5_Wp1zNNWDyh3DxdOLq_ysWxDCs8VC8g@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Introduce security_create_user_ns()
To:     Paul Moore <paul@paul-moore.com>
Cc:     Frederick Lawler <fred@cloudflare.com>,
        Martin KaFai Lau <kafai@fb.com>, revest@chromium.org,
        jackmanb@chromium.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        shuah@kernel.org, brauner@kernel.org, casey@schaufler-ca.com,
        ebiederm@xmission.com, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, kernel-team@cloudflare.com,
        cgzones@googlemail.com, karl@bigbadwolfsecurity.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 1, 2022 at 5:19 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Mon, Aug 1, 2022 at 9:13 AM Frederick Lawler <fred@cloudflare.com> wrote:
> > On 7/22/22 7:20 AM, Paul Moore wrote:
> > > On July 22, 2022 2:12:03 AM Martin KaFai Lau <kafai@fb.com> wrote:
> > >
> > >> On Thu, Jul 21, 2022 at 12:28:04PM -0500, Frederick Lawler wrote:
> > >>> While creating a LSM BPF MAC policy to block user namespace creation, we
> > >>> used the LSM cred_prepare hook because that is the closest hook to prevent
> > >>> a call to create_user_ns().
> > >>>
> > >>> The calls look something like this:
> > >>>
> > >>> cred = prepare_creds()
> > >>> security_prepare_creds()
> > >>> call_int_hook(cred_prepare, ...
> > >>> if (cred)
> > >>> create_user_ns(cred)
> > >>>
> > >>> We noticed that error codes were not propagated from this hook and
> > >>> introduced a patch [1] to propagate those errors.
> > >>>
> > >>> The discussion notes that security_prepare_creds()
> > >>> is not appropriate for MAC policies, and instead the hook is
> > >>> meant for LSM authors to prepare credentials for mutation. [2]
> > >>>
> > >>> Ultimately, we concluded that a better course of action is to introduce
> > >>> a new security hook for LSM authors. [3]
> > >>>
> > >>> This patch set first introduces a new security_create_user_ns() function
> > >>> and userns_create LSM hook, then marks the hook as sleepable in BPF.
> > >> Patch 1 and 4 still need review from the lsm/security side.
> > >
> > > This patchset is in my review queue and assuming everything checks out, I expect to merge it after the upcoming merge window closes.
> > >
> > > I would also need an ACK from the BPF LSM folks, but they're CC'd on this patchset.
> >
> > Based on last weeks comments, should I go ahead and put up v4 for
> > 5.20-rc1 when that drops, or do I need to wait for more feedback?
>
> In general it rarely hurts to make another revision, and I think
> you've gotten some decent feedback on this draft, especially around
> the BPF LSM tests; I think rebasing on Linus tree after the upcoming
> io_uring changes are merged would be a good idea.  Although as a
> reminder to the BPF LSM folks - I'm looking at you KP Singh :) - I
> need an ACK from you guys before I merge the BPF related patches

Apologies, I was on vacation. I am looking at the patches now.
Reviews and acks coming soon :)

- KP

> (patches {2,3}/4).  For the record, I think the SELinux portion of
> this patchset (path 4/4) is fine.
>

[...]

>
> --
> paul-moore.com
