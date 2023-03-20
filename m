Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07821C7618A
	for <selinux@archiver.kernel.org>; Mon, 20 Mar 2023 13:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjCTNfk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Mar 2023 09:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjCTNff (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Mar 2023 09:35:35 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A932E387
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 06:35:26 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id z19so2025407plo.2
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 06:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679319326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAy4xtaClArd1W4UOVYdWJlxl8BiYFhJsKia9R7byjI=;
        b=e8mNB3pZRzmO1zqtfqpfcJioW59I8/x4Uv070CzmB2W5r23VrJfe6q07c/w8zRIoAf
         pbXQWsjQz7cIC62bDg/CB1i4DjVyF90xFAogXjcRzskaP54aynsa7/adJI4c8uxUhsbg
         Jc3/v6+LZu0nNlbYyGkkEDKmmEfV5RI0x14dFp9WO6WFkFbqpE6erJFICr+nOycSsldO
         LW9+y4lObT4jUgRzqFmhHR/S++ckt6g4dJLZyeIEKojdEz4mHXMkA5O9Zw4pNpIHqVEj
         u4eWQ+dfXwuVKgeTlV1/HJOBKeHTe3yQtS8QVvD37f6AZmcHeEJEmkcieQ4iYjj2R8YM
         +7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679319326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qAy4xtaClArd1W4UOVYdWJlxl8BiYFhJsKia9R7byjI=;
        b=d4XEnPptffEC77ukFnTJbwuf9rNZYYkHljLhiMrJAeNVN3t9g4Z5MK0RuUz+YazcTw
         3+PoKenLaSYkzZAgUozhDNARNeZ7wih1IgDMOGC61oCx4y/7YItS7IKrH7Mh9XKOomlf
         i38Ut0nnVyXANFSAxQDFMIzLT66cO2QA72nV5Aw0ka8KWSRB6zW6AJyqb2dRVS2MfYQT
         aXvpKqoRuaEmn9fqTuhXci/afEq61Ol8yt7fubRMloH4S6o8SdzBKCmjd5D231mRITEj
         2lcVhR9+7FV/AKtGb5ezvXbpr07EUFOC7McMeHVfI5SK6W9UhetMHWWPJ5YAmahJ7LWM
         na0Q==
X-Gm-Message-State: AO0yUKVfAigmDdAs1YqH/apiaAz/2vwNrxxlNzyxjUnuCJIc5CMfHCFK
        jaJbfaDiySV//xXUpB8eINS237zJs5VntUKt2vA=
X-Google-Smtp-Source: AK7set+9Ixo1EyFow/jenHKXKIOFSVkGSPybXqg+WtF9BunHVNTmtDY9ruH+TWTZockL/LjtAx6gfb2oyO+YQBIdlT4=
X-Received: by 2002:a17:902:a3c7:b0:1a0:51f6:a252 with SMTP id
 q7-20020a170902a3c700b001a051f6a252mr6800417plb.3.1679319325992; Mon, 20 Mar
 2023 06:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <87mt47ga29.fsf@defensec.nl>
In-Reply-To: <87mt47ga29.fsf@defensec.nl>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 20 Mar 2023 09:35:14 -0400
Message-ID: <CAEjxPJ51N4sguZZ6EkXDuCkaQSp1=Z8NODFbLS9B1_143ktuxA@mail.gmail.com>
Subject: Re: cgroup2 labeling question
To:     Dominick Grift <dominick.grift@defensec.nl>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 20, 2023 at 3:25=E2=80=AFAM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
>
> Hi,
>
> I was reading this pull request [1] and looked into how I might be able
> to implement this in policy but there seem to be some technical
> difficulties.
>
> * I already use getfscon to seperate the systemd user.slice because the
>   system manager delegates the user.slice to the user manager.
>
>   (genfscon "cgroup2" "/user.slice" cgroupfile_context)
>
>   In the past the proved to be a racy where systemd attempts to
>   write before the object has the context associated with the genfscon.

I don't understand how this could be racy - genfscon-assigned contexts
should be assigned when the dentry is first instantiated via
inode_donit_with_dentry and therefore the inode shouldn't be
accessible to userspace prior to this initial assignment AFAIK.
Possibly I am missing something.

>   I decided to dontaudit attempts to write to the mislabeled object and
>   it *seems* as if systemd retries until it can write it i.e. when the
>   object carries the expected label and so that seems to work eventually
>   but it looks fragile.
>
> * The challenge with memory pressure implementation [2] is that these
>   "memory.pressure" files end up in random locations under
>   "/system.slice" for example:
>
>   /sys/fs/cgroup/system.slice/systemd-journald.service/memory.pressure
>
>   Where in the above systemd-journald.service might be
>   templated (systemd-journald@FOO.service). Point is that the path is
>   random. genfscon does not support regex and glob. I can't do for exampl=
e:
>
>   (genfscon "cgroup2" "/system.slice/.*/memory.pressure"
>   cgroupfile_context)
>
>   Fortunately cgroup2fs supports relabeling but if systemd has to
>   manually relabel the cgroup files then I would imagine that this is
>   racy as well, and that does not really solve the underlying issue.
>
>   I am looking for ideas and suggestions

Optimally one of two things would happen:
1. The kernel would label the inode correctly when it is first created
(e.g. by augmenting genfscon to support more general matching), or
2. The userspace component that creates these files would label them
correctly at creation (via setfscreatecon() prior to creation).

Pardon my ignorance but what creates these files initially? The kernel
in response to some event or systemd or some other userspace
component?

> [1] https://github.com/SELinuxProject/refpolicy/pull/607
> [2] https://github.com/systemd/systemd/blob/main/docs/MEMORY_PRESSURE.md
