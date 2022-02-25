Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B45C433EF
	for <selinux@archiver.kernel.org>; Fri, 25 Feb 2022 18:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiBYSSU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 25 Feb 2022 13:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiBYSSS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 25 Feb 2022 13:18:18 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF4BD006B
        for <selinux@vger.kernel.org>; Fri, 25 Feb 2022 10:17:45 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id 9so4908463ily.11
        for <selinux@vger.kernel.org>; Fri, 25 Feb 2022 10:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nm1eERrg8QDTPCsLNsG13mocNpZXJWrPQxbp3Pqr/O0=;
        b=LrlfXrTX+QxWh8wUSC0Vc6h1EJHK8bDM+gv9X0431xQynF9lp/x7PAVokMD9j9c7np
         UpM9S/YUQnAZWuVcCIBSDeoxxgHir0vY4shQLn0dWHdHsNdfsb6hKR8aw8KMVOX453eu
         6GlgE6hoCl/WfP364bdXe4EkcrDYVi4fIm+y1rB7TrO0VHw3RlqEAXi8VWj6NrK3ajJc
         8fSvFfItHAf4DZRE6ebcNofroeIeFT9MjUcMA1wJ7y8FG8scMNInxCZJ+TN2ENFhGLAf
         wlYGLhNIhujG0fEtqgY86K+WGMNHA2tFAhTAwFTVPuoLTkfRkHWbrIB64vKnKysMf96D
         aJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nm1eERrg8QDTPCsLNsG13mocNpZXJWrPQxbp3Pqr/O0=;
        b=Cn0pMyI7cqYMmbdaPZt0/l570i9/ClaVc1tIxyOyHiCvUg7IL2GVqYNo+/fXKKXNGz
         bQl5xF3L3Dmqz+hmKGRE+ysVnL+acXl5KDFUWEnmnilvEBGNJAqQb3/TKF47xGshycpG
         kVmVaPXbnYb1DqecU3oMe6u2e93lZZr5Hh0KKUlCsvVNjd/LOYF1tq13vqhLHJNOqZIh
         tpUZoAOuMHsCFn56VdtMd1VirrLxOkixIDcom4KgRjFJLW66PwYtqVzE4+9keM9p3aB5
         gH1qkqlR0CF8OYb0QlJs2f26VzRy9UV9oTn03/bBYWN15mkJobkQ1ulBy2lc1WnCIKQb
         o6JA==
X-Gm-Message-State: AOAM531Oxs0noGYI91PfLP/75Vi/B+J/APbYkrCnb5kSMIRlh5OxWmuY
        2mdXccAgQ2hIUAUVrczd1PJrfg+aAiPD4Ale18+LtQ==
X-Google-Smtp-Source: ABdhPJxsTPK5RtHCNw8uXoUXlBNjPtA2SXEwcUKP5Iehw0GUHKTdV9i+YhCq+TbSg+5YUrbwKP1QG2EYv/sjXRYCwyY=
X-Received: by 2002:a05:6e02:dd4:b0:2bd:ef9f:cf99 with SMTP id
 l20-20020a056e020dd400b002bdef9fcf99mr7188195ilj.275.1645813064833; Fri, 25
 Feb 2022 10:17:44 -0800 (PST)
MIME-Version: 1.0
References: <20220224181953.1030665-1-axelrasmussen@google.com>
 <fd265bb6-d9be-c8a3-50a9-4e3bf048c0ef@schaufler-ca.com> <CAJHvVcgbCL7+4bBZ_5biLKfjmz_DKNBV8H6NxcLcFrw9Fbu7mw@mail.gmail.com>
 <0f74f1e4-6374-0e00-c5cb-04eba37e4ee3@schaufler-ca.com> <YhhF0jEeytTO32yt@xz-m1.local>
In-Reply-To: <YhhF0jEeytTO32yt@xz-m1.local>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Fri, 25 Feb 2022 10:17:06 -0800
Message-ID: <CAJHvVciO1GUbmL+Rxi-psGT8V=LyTfGT-Hyigtaebx1Xf+z6fw@mail.gmail.com>
Subject: Re: [PATCH] userfaultfd, capability: introduce CAP_USERFAULTFD
To:     Peter Xu <peterx@redhat.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Serge Hallyn <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Thanks for the detailed explanation Casey!

On Thu, Feb 24, 2022 at 6:58 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Feb 24, 2022 at 04:39:44PM -0800, Casey Schaufler wrote:
> > What I'd want to see is multiple users where the use of CAP_USERFAULTD
> > is independent of the use of CAP_SYS_PTRACE. That is, the programs would
> > never require CAP_SYS_PTRACE. There should be demonstrated real value.
> > Not just that a compromised program with CAP_SYS_PTRACE can do bad things,
> > but that the programs with CAP_USERFAULTDD are somehow susceptible to
> > being exploited to doing those bad things. Hypothetical users are just
> > that, and often don't materialize.
>
> I kind of have the same question indeed..
>
> The use case we're talking about is VM migration, and the in-question
> subject is literally the migration process or thread.  Isn't that a trusted
> piece of software already?
>
> Then the question is why the extra capability (in CAP_PTRACE but not in
> CAP_UFFD) could bring much risk to the system.  Axel, did I miss something
> important?

For me it's just a matter of giving the live migration process as
little power as I can while still letting it do its job.

Live migration is somewhat trusted, and certainly if it can mess with
the memory contents of its own VM, that's no concern. But there are
other processes or threads running alongside it to manage other parts
of the VM, like attached virtual disks. Also it's probably running on
a server which also hosts other VMs, and I think it's a common design
to have them all run as the same user (although, they may be running
in other containers).

So, it seems unfortunate to me that the live migration process can
just ptrace() any of these other things running alongside it.

Casey is right that we can restrict what it can do with e.g. SELinux
or seccomp-ebpf or whatever else. But it seems to me a more fragile
design to give the permissions and then restrict them, vs. just never
giving those permissions in the first place.

In any case though, it sounds like folks are more amenable to the
device node approach. Honestly, I got that impression from Andrea as
well when we first talked about this some months ago. So, I can pursue
that approach instead.

>
> Thanks,

>
> --
> Peter Xu
>
