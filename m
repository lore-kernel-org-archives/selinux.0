Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90ACC61D97
	for <selinux@archiver.kernel.org>; Wed, 22 Nov 2023 18:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343980AbjKVSPF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Nov 2023 13:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344034AbjKVSPE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Nov 2023 13:15:04 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACBFD4A
        for <selinux@vger.kernel.org>; Wed, 22 Nov 2023 10:15:00 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-db406b5ceddso84471276.0
        for <selinux@vger.kernel.org>; Wed, 22 Nov 2023 10:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700676899; x=1701281699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xsKojepMstQykpndCpLRWISd1f4HeAHfNp14TvqpkM=;
        b=ZyHag/58nHwdKsmXQvWdMcakiXshtvosw++B7FEn3xPEX/PuwJItEcP8hD+3e2JaMb
         XJ3ScXSbJwt4Zt/TF7lexWiANP/MKUbCYkdMV1A9fRwntZPJjSb6T80G9fD+7hp7wRnk
         fjOtTvr2NRPcbdtnl6A6TEmYHZnl3PL6yt5ZrD/SyijOQfyDwPR5ahtHRpIKtsNsEMr2
         JFDbmOk4iZNlCOsLH7V9+SWtWbS1sposC7XEOi3IfsL+smEAH6jrSizCNup7mJhwPQF+
         9oIIx4qSPtJWWf+mIK6PyqTuXEBm5Xj6dDC1TJKQgHbeHtKE1xv7SuJ+bAH8j+kaBO9u
         sg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700676899; x=1701281699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xsKojepMstQykpndCpLRWISd1f4HeAHfNp14TvqpkM=;
        b=pqIia1YdyPm/nfKQg6XqU/PGNXzl1fZi99gOXXClfXNwmC27YF/vok09wY0g/Krnv9
         cT86L9ZEvmlGsXKTBkXKJY5bCaAxaG4X7ifghvOdCDWMcWQOhEoys62hO4z6Egax6IAr
         eelOJoGJhsnux3VQFSBTbxFkIn8DX1bWVlYbllsSva84znU4vRl4U/8IDpn53drAdofX
         /FR5xLp3Rmyxk8loujOSmoc3YxMQayQ8N8j1iS7CMrdYTqKB3MOAM7VjomjUWL+7nQ6g
         UDu9g2ButfclT0OprErXblJTpKQjazis+J27H13U06obSuR3xTw68MYdvfmZjacaM1DM
         7Z3g==
X-Gm-Message-State: AOJu0YxKll164VDsyHL6SMYIvTvj0J32lz6bSkeuE7MSWyvHw7Pj+S8M
        gb2G5Mr4C8U46mTEotT2kuevZWTNNQaV0qQG+kbnAiobH6iwFpY=
X-Google-Smtp-Source: AGHT+IEoRvlLNDPKpIhMN00eY/EVxoF3O9ejgPktZLhe4eL0+NelTUL3bqMhzYAvZLWdeYc2BBJ3J2rGpiHQ4urOePo=
X-Received: by 2002:a25:8d8b:0:b0:dae:b67e:7cd4 with SMTP id
 o11-20020a258d8b000000b00daeb67e7cd4mr2652370ybl.46.1700676899570; Wed, 22
 Nov 2023 10:14:59 -0800 (PST)
MIME-Version: 1.0
References: <20231103172953.24667-3-jsatterfield.linux@gmail.com>
 <d419ff729567246c50cf52b885e76903.paul@paul-moore.com> <CALMFcesyueiXg_8Z=LVhKjy7eYnE=3vJS0daTEC7+Z5GKxa4Cg@mail.gmail.com>
In-Reply-To: <CALMFcesyueiXg_8Z=LVhKjy7eYnE=3vJS0daTEC7+Z5GKxa4Cg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 22 Nov 2023 13:14:48 -0500
Message-ID: <CAHC9VhR6xJmFGqBUyr7QkC3vOArL2e6iysL7P-9SV1Pv=1TYVA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] selinux: fix conditional avtab slot hint
To:     Jacob Satterfield <jsatterfield.linux@gmail.com>
Cc:     selinux@vger.kernel.org, stephen.smalley.work@gmail.com,
        omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 22, 2023 at 12:35=E2=80=AFPM Jacob Satterfield
<jsatterfield.linux@gmail.com> wrote:
> On Mon, Nov 20, 2023 at 8:29=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > I'm a concerned about all the work we have to do just to count the
> > conditional rules.  Other than not working with existing binary
> > policies, have you looked at bumping the policy version and introducing
> > a binary format change that would include the number of conditional
> > rules?
>
> Thanks for raising the issue. I had considered adding the total size
> of the conditional table to the binary policy, but I wasn't sure if it
> would be substantive enough to warrant bumping the policy version.

I appreciate the thoughtfulness, but the version field in the policy
is 32-bits and we are currently up to policy format v33 so we've still
got a few version numbers to play with :)

> As
> you point out, the counting work will be needed for existing binary
> policies making this patch necessary for the default case, but if you
> are concerned about the performance penalty this patch brings (which
> is less than the gain provided by the avtab array patch), then there
> are two threads to possibly be worked on.

To be clear, I'm not thinking about supporting this for existing
policies, just the new policy format; the existing policy versions
would behave as they do now ... although if we do the array conversion
we will likely need to do some type of realloc()/retry or something, I
dunno, I'll leave that to you to brainstorm ;)

> One is to rework this patch to include more invasive changes to count
> rules without actually reading and destroying nodes thus saving cycles
> but requiring more lines of code. Because policy parsing is not
> handled separately from the construction of the policydb structure
> (they are deeply intertwined), I was reluctant to add more complexity
> just to have a parse-only code path. Would you prefer speed or simpler
> logic for older policies?

That's the problem we have right now.  We have to do a lot of work
(allocations, etc.) that we throw away in the case where we are
counting, not to mention that bolting on the count-only functionality
is kinda hacky/ugly (not your fault, that is just the way the code is
right now).  As you mention, the alternative is to significantly
rework how we parse/load the policy, and that isn't a very exciting
prospect as far as I'm concerned.

I'm not sure if moving over to flex array is a win, I suspect that
whatever we gain in memory savings we lose in not having direct
access.  I dunno, maybe it wouldn't be too bad.

I'm open to ideas here ... I'm looking for something that would
support the improvements for a new policy with an explicit count,
while still falling back to something that works "reasonably well" in
the current case where we have to guess.  In this case "reasonably
well" means no worse than current in terms of performance and memory
use while not over complicating the code.

--=20
paul-moore.com
