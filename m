Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA89C25B6B
	for <selinux@archiver.kernel.org>; Wed, 25 Oct 2023 21:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjJYVMJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 25 Oct 2023 17:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYVMJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 25 Oct 2023 17:12:09 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B43E18A
        for <selinux@vger.kernel.org>; Wed, 25 Oct 2023 14:12:03 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1eb33c06d08so117454fac.0
        for <selinux@vger.kernel.org>; Wed, 25 Oct 2023 14:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698268322; x=1698873122; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LwRxlH+I45w4eKcgZaN4wEJQCprT/vAigJAp6Mr4rWM=;
        b=QfVoG+azEUB5dJ+CvAu36uNkpYY9541ibDprzzt3tabZ2Xx5bhxpw1BvU6su9l40Az
         NyaDbVPs22yjg6LiFZRMXWyeLC2VVeOHLGRNRPLuXYnIqOPn/q9vrUWXS2Nho8TgH2Nv
         Un60wXvNP01tgm3uCBrHbe/yUWjSDW4Xa31fChzDmXs9Qmfr+YkYQvWAImt6tUUoZLej
         4ITnvDTSkZn6J5l092ryCrXPeHds6NNFDy9DH8rpkVtPh3OB7jQqVi73hEHy9Z+L038y
         zNuDTr3sz4Z29El0mnaq0Mxlc9kLwSKVTR+vGO6IPkliAVg6Ry/LNsBC8ssO5LQYve72
         E9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698268322; x=1698873122;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LwRxlH+I45w4eKcgZaN4wEJQCprT/vAigJAp6Mr4rWM=;
        b=EafdqXrKC03+3+54fHkbIRNkA3liOVEop5Qc6PqpKXs1cS6y/SnTF8jrzTgLgin9Jg
         UoF+cCe0nDVdrFlYYTeL0506Sga+ZHiOFS8DOT7R8+idgreVmuQdGpMczX6n6e8/oeBT
         TuilCIK1vCsUT9t8+cKw9U+lQuUN7outEM5xFTl3o4xSXjh8rkIOvman+GpB+hpq6Dpu
         YCxGhNFRYdV19wzTJ7agiQn0p9Z7k3Lm8Yt1moj2uW+1pz8Fk9ehq55vrs4sLCXZdmAA
         CkCHkDEb5YxqFzeLzVtKXW495RHfyuVdybGfP4rtSIuwmQlaZBJvcGAKNEi3ggD0MlQT
         1Xyw==
X-Gm-Message-State: AOJu0Yy4g5rTeiU6vXDSD5+Q1DFDMaXgF58PgfjBP9mstHo6AEBu6lkW
        K2cr8BRlXxdZGLxHMrhNxEdOXm3dSxJo7ySXCL0G
X-Google-Smtp-Source: AGHT+IH0r6cisfSEXFqLjnaxnsnDpduWgVfuqyWDbgY9cv24A4K/vroEoiFl4fQ7CGPWDflsKpNJ66ibj6b+eY5RjEQ=
X-Received: by 2002:a05:6870:1b86:b0:1ea:21cc:67f3 with SMTP id
 hm6-20020a0568701b8600b001ea21cc67f3mr21444386oab.4.1698268322544; Wed, 25
 Oct 2023 14:12:02 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 25 Oct 2023 17:11:51 -0400
Message-ID: <CAHC9VhS1wwgH6NNd+cJz4MYogPiRV8NyPDd1yj5SpaxeUB4UVg@mail.gmail.com>
Subject: ANN: kernel git branches and process changes
To:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello all,

As of today I'm making some changes to the LSM, SELinux, and audit
kernel git repositories to make it easier to get changes into
linux-next and to provide a more formal approach to dealing with
significant changes that may need some time in a "staging" branch
before inclusion into a main development branch.  Just as before, I've
documented the kernel development process in the README.md located in
the main/default branch of each kernel git repository, but I'm also
including the new process below.  If anyone has any questions please
speak up.

It may take me a day or two to fully setup the new branches in each
repository, but given where we are at in the current development cycle
I don't expect this to have any major impacts.  If this does
significantly impact any work in progress, please let me know and I
promise we'll figure something out.

Thanks for your understanding.

## Kernel Source Branches and Development Process

### Kernel Source Branches

There are four primary git branches associated with the development process:
stable-X.Y, dev, dev-staging, and next.  In addition to these four primary
branches there are also topic specific, work in progress branches that start
with a "working-" prefix; these branches can generally be ignored unless you
happen to be involved in the development of that particular topic.  The
management of these topic branches can vary depending on a number of factors,
but the details of each branch will be communicated in the relevant discussion
threads on the upstream mailing list.

#### stable-X.Y branch

The stable-X.Y branch is intended for stable kernel patches and is based on
Linus' X.Y-rc1 tag, or a later X.Y.Z stable kernel release tag as needed.
If serious problems are identified and a patch is developed during the kernel's
release candidate cycle, it may be a candidate for stable kernel marking and
inclusion into the stable-X.Y branch.  The main Linux kernel's documentation
on stable kernel patches has more information both on what patches may be
stable kernel candidates, and how to mark those patches appropriately; upstream
mailing list discussions on the merits of marking the patch for stable can also
be expected.  Once a patch has been merged into the stable-X.Y branch and spent
a day or two in the next branch (see the next branch notes), it will be sent to
Linus for merging into the next release candidate or final kernel release (see
the notes on pull requests in this document).  If the patch has been properly
marked for stable, the other stable kernel trees will attempt to backport the
patch as soon as it is present in Linus' tree, see the main Linux kernel
documentation for more details.

Unless specifically requested, developers should not base their patches on the
stable-X.Y branch.  Any merge conflicts that arise from merging patches
submitted upstream will be handled by the maintainer, although help and/or may
be requested in extreme cases.

#### dev branch

The dev branch is intended for development patches targeting the upcoming merge
window, and is based on Linus' latest X.Y-rc1 tag, or a later rc tag as needed
to avoid serious bugs, merge conflicts, or other significant problems.  This
branch is the primary development branch where the majority of patches are
merged during the normal kernel development cycle.  Patches merged into the
dev branch will be present in the next branch (see the next branch notes) and
will be sent to Linus during the next merge window.

Developers should use the dev branch a stable basis for their own development
work, only under extreme circumstances will the dev branch be rebased during
the X.Y-rc cycle and the maintainer will be responsible for resolving any
merge conflicts, although help and/or may be requested in extreme cases.

#### dev-staging branch

The dev-staging branch is intended for development patches that are not
targeting a specific merge window.  The dev-staging branch exists as a staging
area for the main dev branch and as such its use will be unpredictable and it
will be rebased as needed.  Patches merged into the dev-staging branch will be
present in the next branch (see the next branch notes) and should find their
way into the primary dev branch at some point in the future, although that is
not guaranteed.

Unless specifically requested, developers should not use the dev-staging branch
as a basis for any development work.

#### next branch

The next branch is a composite branch built by merging the latest stable-X.Y,
dev, and dev-staging branches in that order.  The main focus of the next branch
is to provide a single branch for linux-next integration testing that contains
all of the commits from the component branches.  The next branch will be
updated whenever there is a change to any one of the component branches, but it
will remain frozen during the merge window so as to cooperate with the wishes
of the linux-next team.

While developers can use the next branch as a basis for development, the dev
branch would likely be a more suitable, and stable, base.

### Kernel Development Process

After Linus closes the kernel merge window closes upstream, the stable-X.Y
branch associated with the current kernel release candidate, the dev branch,
and potentially the dev-staging branch (see the dev-staging branch notes) will
be reset to match the latest vX.Y-rc1 tag in Linus' tree.  The next branch, as
a composite branch composed from these branches, will be updated as a result.

During the development cycle that starts with the close of the kernel merge
window and ends with the tagged kernel release, patches will be accepted into
the stable-X.Y and dev branches as described in their respective sections in
this document.  While patches will be accepted into the stable-X.Y branch at
any point in time, significant changes will likely not be accepted into the dev
branch when there are two or less weeks left in the development cycle; this
typically means that only critical bugfixes are accepted once the vX.Y-rc6
kernel is released.  During this time the next branch will be regenerated on an
as needed basis based on changes in the component branches, and pull requests
will be sent as needed to Linus for patches in the stable-X.Y branch.

Once Linus releases the final vX.Y kernel and the merge window opens, two
things will happen.  The first is that the dev branch will be duplicated into
a new stable-X'.Y' branch, representing the new upcoming kernel release, and
the second is that a pull request will be sent from this branch for inclusion
into the current merge window.  During the merge window process the dev and
next branches should be frozen, although there is a possibility that some
patches may be merged merged into dev-staging for testing or process related
reasons.

#### Pull Requests for Linus

In order to send a pull request to Linus, either for a critical bugfix or as
part of the merge window, a signed git tag must be created that points to the
pull request point.  The tag should be named using the "{subsystem}-pr-{date}"
format and can be generated with the following git command:

```
% git tag -s -m "{subsystem}/stable-X'.Y' PR {date}" {subsystem}-pr-{date}
```

Once the signed tag has been created, it should be used as the basis for the
pull request.

-- 
paul-moore.com
