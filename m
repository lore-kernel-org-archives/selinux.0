Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134CEC43381
	for <selinux@archiver.kernel.org>; Tue, 12 Jan 2021 17:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E37772311D
	for <selinux@archiver.kernel.org>; Tue, 12 Jan 2021 17:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389426AbhALRhV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Jan 2021 12:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390830AbhALRhM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Jan 2021 12:37:12 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EB0C061795
        for <selinux@vger.kernel.org>; Tue, 12 Jan 2021 09:36:31 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id c5so3379673wrp.6
        for <selinux@vger.kernel.org>; Tue, 12 Jan 2021 09:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wfBdHlbPhe9JJVFJ53u2WB3aTeFtdCK9M9opKH7jl0E=;
        b=r+hFbctf7X7hHlEJB3cUCjzH8j2xrYepKGUGArG/haPmHg3VEsQqEoP+bjyfE+JUV4
         7fNlBjtiSaVAjnlZ8OaToJ9zft6m1wHPMAvTu/fKvVnerheKqOs0WRIVdNMN12Jw7COZ
         FVQMfPoZ0h5x0cFG0Z9WY0uT5Hp0zqIxpVoCNdwBTExy689NFmyPnNG3yNlT+FuggQJY
         PcUzwOPS1IslA3+lNcHct75qRyTW9ivKIgWwcPwxQoEltGGD4o6tV3kE9jPcvQfhuuXA
         O6Owucb4wqQ+RuictebWz50p1Hg4HXq7M3petBX90hlXHPZpAra0SIB2ZVih0uotmjgi
         REWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wfBdHlbPhe9JJVFJ53u2WB3aTeFtdCK9M9opKH7jl0E=;
        b=qS7p/bn9i0lA1exZv7Z2N6BsgAvTSNhfg73xiVn0gTslxu4iSdS1eqiOyLlOT92Gyr
         qyNDWSZwdzSh/eeLwgCURMUWWXxmkZOq57CDS+MaXxup6QidNInU1KE9YRiCw7BWlSNO
         ISMgJqV7YjCrLDLoj3dNRY1dkw8KrRuZSHgra2a4K9hTiFUuXnGVc4Aopitr1csHv2SR
         Sp6SYoIfeKopSm+SyaimrN9c1qE4QgwgljiEtZwr7h1d6lhZLcVR3GFHFPvP6JrPbebU
         bEB0o2Dpkw5KZhwn//MpYbcKlNTVj1jpPlnHNp+8vwdAgnqp2FkMyzrO7Se0xDkU0MkS
         FT+A==
X-Gm-Message-State: AOAM530eHwzAewrBTRzrzlnC1MwEputQ0OcftSDmUn6ihAtDTDEobfh0
        EePFMpJ53SeN7qY9eYCvqofwI+uMIaMS/bJr9OTgyA==
X-Google-Smtp-Source: ABdhPJw1Jgdy43yhmaRwTd0pdcF+MsZsBqxx4SqJd+UJxoXstrUpJMKOObpVqUZhNvBXniG6D6ajQpMGbSb4nXVH30o=
X-Received: by 2002:adf:f0d0:: with SMTP id x16mr5603702wro.162.1610472990153;
 Tue, 12 Jan 2021 09:36:30 -0800 (PST)
MIME-Version: 1.0
References: <20210111170622.2613577-1-surenb@google.com> <20210111172213.ab4185a1de916c35f3245021@linux-foundation.org>
In-Reply-To: <20210111172213.ab4185a1de916c35f3245021@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 12 Jan 2021 09:36:18 -0800
Message-ID: <CAJuCfpFdSNTp+PhJ1ztyfbzdVWVHy=qJJPVizXPGizgBQqTKYw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: replace ptrace attach requirement for process_madvise
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Edgar_Arriaga_Garc=C3=ADa?= <edgararriaga@google.com>,
        Tim Murray <timmurray@google.com>,
        linux-mm <linux-mm@kvack.org>, selinux@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 11, 2021 at 5:22 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 11 Jan 2021 09:06:22 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
>
> > process_madvise currently requires ptrace attach capability.
> > PTRACE_MODE_ATTACH gives one process complete control over another
> > process. It effectively removes the security boundary between the
> > two processes (in one direction). Granting ptrace attach capability
> > even to a system process is considered dangerous since it creates an
> > attack surface. This severely limits the usage of this API.
> > The operations process_madvise can perform do not affect the correctness
> > of the operation of the target process; they only affect where the data
> > is physically located (and therefore, how fast it can be accessed).
> > What we want is the ability for one process to influence another process
> > in order to optimize performance across the entire system while leaving
> > the security boundary intact.
> > Replace PTRACE_MODE_ATTACH with a combination of PTRACE_MODE_READ
> > and CAP_SYS_NICE. PTRACE_MODE_READ to prevent leaking ASLR metadata
> > and CAP_SYS_NICE for influencing process performance.
>
> It would be useful to see the proposed manpage update.
>
> process_madvise() was released in 5.10, so this is a
> non-backward-compatible change to a released kernel.
>
> I think it would be OK at this stage to feed this into 5.10.x with a
> cc:stable and suitable words in the changelog explaining why we're
> doing this.

Sure, I will post another patchset that will include manpage update
and will CC:stable. That's of course after Michal's concerns are
addressed.
Thanks!

>
> Alternatively we could retain PTRACE_MODE_ATTACH's behaviour and add
> PTRACE_MODE_READ&CAP_SYS_NICE alongside that.
