Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F85C4332F
	for <selinux@archiver.kernel.org>; Mon, 13 Nov 2023 04:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjKMEwf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 12 Nov 2023 23:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKMEwe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 12 Nov 2023 23:52:34 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC47A1719
        for <selinux@vger.kernel.org>; Sun, 12 Nov 2023 20:52:28 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-da37522a363so4083282276.0
        for <selinux@vger.kernel.org>; Sun, 12 Nov 2023 20:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699851148; x=1700455948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqpdxDuCTExBDFimA29aIt9QbMDBK5Nyi8KvqThUl6I=;
        b=NFgkejKfCKobyj8TvQ8EWtt6Du4w0Eikmw1hmtN4Ryws2JhZUkUdCc/DelQhcvkeps
         ahIYJJMt7DyDED/M+bV+dUjH3UfkbxFw03nyCfzAk+T64fY7U5XTBFJU21zvR75lRiES
         O3IWEXQ5hTK0oyHlU8s07PuPDiCYp0RhNvoPygAkANuUT0PSjS/IlPJpSmW7/zl4QN3Q
         pLRkAkQDx1k95zAjRT1/n4yAQkGWl7OjfhZXqrUOR6Y3E2lBlYlsjUQMW84fnZGS4BRK
         GcgwiuaeFJ2CuHuLerFcCldBgJyxPk/xZPpO67zRejbNgxCJciaD/0NhGhSfRmMjb+cQ
         o94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699851148; x=1700455948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqpdxDuCTExBDFimA29aIt9QbMDBK5Nyi8KvqThUl6I=;
        b=A01m6XgVHQ54Grk/I3MUGwpVW1W5rrlkeUGvMNuSZ6/pN/q9Mp0ULXjOTl6TNGTGyn
         LE5ZmeuXS+IUx5mTTpyU/4sENjDBGAuITmOAXd7qOEgXev1xSOPB3SqoVHFog5/a09zr
         6REx/kZvhw9eCQNNbzrID4KkCzM5WzKo2cGheiH4Gj8ZNvBdJM4IXXrYsPau9Zwa4d/f
         G4zu79Yb2BmGcPjSJ6pYwfNPtASLwnylR8FZQiGhpN60MfblJvl3MX3XNwWIgCy1hbmD
         JA0Ps1BBI4XAg4IrBmgcdF3PnvcEbth8K+ntYNvrmS7UKOZOddLYz5fJiw2sewFOXUAe
         rMbQ==
X-Gm-Message-State: AOJu0YyD9y/V465Ip+gwTFL6/LNq8IHvbhtD0MzVMvdFJMyQrQgyjTqr
        9LX1glekwl6WNOV6OpAcwOpdIZtosxLV1v6CPM485Am4sjtmsfI=
X-Google-Smtp-Source: AGHT+IEJr9d3iIrip3mCSCKkkgoGOeOVGMZx6p2n0ee+f34Hz8BksR5u3cTPCE1izwQIAuLIHlfkh8211n/DhT3hi9U=
X-Received: by 2002:a25:40c6:0:b0:da0:c746:3866 with SMTP id
 n189-20020a2540c6000000b00da0c7463866mr4777895yba.41.1699851147903; Sun, 12
 Nov 2023 20:52:27 -0800 (PST)
MIME-Version: 1.0
References: <da1d9efd-fdc1-4651-8a7a-30ae4a399926@linux.microsoft.com>
In-Reply-To: <da1d9efd-fdc1-4651-8a7a-30ae4a399926@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 12 Nov 2023 23:52:17 -0500
Message-ID: <CAHC9VhSfTDoPee5_qXyh0QpjeMSsx5RmWOQgmk1NGC87kn0nsg@mail.gmail.com>
Subject: Re: Proposed feature: fine-grained file descriptors in SELinux
To:     Chris PeBenito <chpebeni@linux.microsoft.com>
Cc:     SElinux mailing list <selinux@vger.kernel.org>, brauner@kernel.org,
        bluca@debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 9, 2023 at 1:26=E2=80=AFPM Chris PeBenito
<chpebeni@linux.microsoft.com> wrote:
>
> systemd is increasing usage of memfds, pidfds, etc.  This is resulting
> in a need for wide inheritance of fds across the system.  For example in
> a lot of systemd interfaces that have a pid field now have a comparable
> pidfd interface.  dbus-broker and polkit are similarly updated.
>
> Some references from an All Systems Go! talk:
> https://cfp.all-systems-go.io/media/all-systems-go-2023/submissions/T3LJA=
M/resources/ASG_2023_PID_FD-ize_all_the_things_E98Zw9Q.pdf
>   This is from a few months ago; the switch to PIDFDs is nearly
> complete, and we're already seeing denials for this usage.
>
>
> Since file descriptors are increasing use as references for various
> operations, I think it would be useful to have a finer-grained fd class,
> so we can limit file descriptor inheritance, particularly as it looks
> like systemd/pid1 will need to inherit pidfd file descriptors from
> possibly all domains.  Specifically, I propose adding new permissions to
> the fd class, such as use_pidfd and use_memfd.  Then systemd can use
> pidfds from any domain, but only use regular fds from trusted domains.
>
> Thoughts?

I think adding some granularity to the fd:use permission makes sense,
although I'm wondering if we are better served by creating new object
classes for these new types of reference fds, e.g. pidfd:use,
memfd:user, etc.?  When I read "use_pidfd" my first thought is that we
are encoding an object class in the permission.

Have you looked at the associated kernel code yet?  I suspect we might
need to augment the existing memfd/pidfd/etc. code paths with an
additional LSM hook to be able to mark the fd's LSM/SELinux state with
class info, but I'm not sure off the top of my head.

--=20
paul-moore.com
