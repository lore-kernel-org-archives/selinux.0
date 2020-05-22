Return-Path: <SRS0=crGG=7E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE1FC433E0
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 13:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B677A20B80
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 13:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1vIg28L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbgEVNsr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 May 2020 09:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbgEVNsr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 May 2020 09:48:47 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9618C061A0E
        for <selinux@vger.kernel.org>; Fri, 22 May 2020 06:48:46 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id r25so9346429oij.4
        for <selinux@vger.kernel.org>; Fri, 22 May 2020 06:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=snyOcpd6k9Yor8+jeZdGfcMyaaM5cUVrsKiDWc75zO8=;
        b=L1vIg28LyWAfSeEQxY25kAu5oD4FlBAE8qqwbWTfovD1s3oxkR2fDbFuxYw7CcOSKw
         /GG0zSY9hjFHFULYYcSc3+xhRYoBQHM0VcCD6WjH1MPzCxms021i6o5BoCJdzvkJXMxI
         /K/RpcJdZH2ZFi38gU3YH9asjHZYISJrXSast9boF6GCG7jmg7nirIu8ESp8YQtj2A2E
         B3iu55prEjwHkrHSrJfi35lPFaxqHLzJWk8L21JcGApbhNlYLCnJUN0DX5+v5rWjteu1
         b1Z21RYitsmRnKFJTZQudFnhmj455KDRN44Si7BlfsJNkM3qeqgNZgRTTHsMgfdw3+W/
         rNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=snyOcpd6k9Yor8+jeZdGfcMyaaM5cUVrsKiDWc75zO8=;
        b=fxi9JMp+/Ids2ICv1mtSnsCY1BXY2O/Nq7SlZ5sTd4d+u5UQQeJrpWCwSpZce6uaN6
         YVJwi9HHV+SrV+lSR7EkWeEA7PnYTTzLNDtpsIAdhsTG5JvZqMnZ60uqXOGYJ4EUzFEA
         JgNDClBNTILlFOog/TlqFCVoZ5367+enuB+4yVFrlfBFei97Kfq4wcC8Oo4Qzh5eJXwx
         XwFuRH2mwOmaAquKf1jv0eNGTKJ/FtNIzhqPBSthVLXjDz587TetZeBlsQTWHJgiD1C/
         JfaPoOU1lv+O6s2tfSuAsOQQFlrZmnrrG+eCgfnvQJsVOczDSoHhbXTub4LldlMV4tIS
         goAg==
X-Gm-Message-State: AOAM532fnG1pYR/YcBd6moNk050spQ1JEsVV5DjcHZDiVimp2+LG6x7j
        Ctkrit+uAECdGVOklvZ3zRD+/LEmUHB0ceEXsLY=
X-Google-Smtp-Source: ABdhPJx3iWLRprSiufoM/rvpOg5ZOllzoxtZaYLTO4p5zUdIGA9qblfccv7ZJuBAP2Zxg5kVXJXLKiu6kB6qBEtMja0=
X-Received: by 2002:aca:c704:: with SMTP id x4mr2563101oif.92.1590155325735;
 Fri, 22 May 2020 06:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAFqZXNveic7xQQkZY=9jZKeG7_DFR+fSJzgsOj9eLAYdmQY=Uw@mail.gmail.com>
In-Reply-To: <CAFqZXNveic7xQQkZY=9jZKeG7_DFR+fSJzgsOj9eLAYdmQY=Uw@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 22 May 2020 09:48:34 -0400
Message-ID: <CAEjxPJ4JpmaNzeUxH3sJGJW=8ZYv5JyrKQosWS=gJQ2k5FNn=w@mail.gmail.com>
Subject: Re: Question about SELinux and hard resource limits
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Michal Sekletar <msekleta@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 22, 2020 at 5:00 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> H alli,
>
> while debugging an AVC that started popping up after a change of
> default RLIMIT_NOFILE on RHEL-8, I came across the SELinux setrlimit
> check, where I don't quite understand what is the motivation for
> requiring permission also for lowering the hard limit. The code
> comments [1] [2], as well as the prlimit hook's commit message [3],
> explain that the hard limit is used as the reset value when inheriting
> the parent's limits is not allowed and I understand that raising a
> task's hard limit can have unwanted security consequences due to that,
> but I don't quite see what's the concern with lowering it. Yes, the
> child process would indirectly "inherit" this limit even when
> inheriting is denied, but it could only get a lower value than
> otherwise, which doesn't sound like a security risk.
>
> In a situation where setrlimit is denied by default, this seems to
> "punish" the processes that want to play fair and lower their limits
> to the minimum they need. So what would be the security implications
> of always allowing a process to lower its hard limits?
>
> Thanks,
>
> [1] https://elixir.bootlin.com/linux/latest/source/security/selinux/hooks.c#L4092
> [2] https://elixir.bootlin.com/linux/latest/source/security/selinux/hooks.c#L2465
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=791ec491c372f49cea3ea7a7143454a9023ac9d4

Originally introduced here:
https://lore.kernel.org/lkml/1072714025.845.92.camel@moss-spartans.epoch.ncsc.mil/

The threat scenario is one where a process lowers its limit prior to a
domain-changing execve() in order to induce a failure in the new
program that leads to a security vulnerability.  Specific motivating
example:
https://lore.kernel.org/selinux/Pine.LNX.4.33.0306060554430.10200-300000@vox.rv.nailabs.com/

That said, I'm not sure that this check (or rlimitinh) are effectively
leveraged in Linux (or Android) today, so it may be that it isn't
providing practical benefit.  Some analysis perhaps of existing
policies and past CVEs (e.g. would/could it have made a difference)
might be interesting.
