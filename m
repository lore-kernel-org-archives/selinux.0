Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7E8C4332F
	for <selinux@archiver.kernel.org>; Tue, 14 Nov 2023 22:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbjKNWYh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Nov 2023 17:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbjKNWYg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Nov 2023 17:24:36 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E429DD
        for <selinux@vger.kernel.org>; Tue, 14 Nov 2023 14:24:33 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a7af20c488so73174957b3.1
        for <selinux@vger.kernel.org>; Tue, 14 Nov 2023 14:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700000672; x=1700605472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/lLeWt7vOF/PJgPrkSuq9lzzhGIQmGMwr1dnmP0LZ8=;
        b=bJHHFj/uhodv7UHgmR0Gsrb1IfjKIxuzAjbCM+LAoqAndwF8CMwkxhrDzfeCqpmEFa
         EhlJmnan0yp2Y8yevgFkjLzJDjFlxxj2AIeQc9f/aWAsygZl+7oop0Y4QXt/JvxD+k1T
         Cj00CXzGtYpOjBFx8kzEnUrb83Hphxy7xS6kJ0nk7PT610E1FT64Wt/MCJkWz/nws4y7
         0HAQPKKhX59+rrvmuUu3TALXtJfNxyyKwZ6WUUHXd6P+IBTwzBQCQalFUS3+74kD8aGY
         EMOWT9AOTyYxgf54ShLsWqLGvcRI1MKLGLp2RzpVbeTK0BvCLQ4aRjR/hZE52WYnRukQ
         Er9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700000672; x=1700605472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/lLeWt7vOF/PJgPrkSuq9lzzhGIQmGMwr1dnmP0LZ8=;
        b=a4DNrne6ZLvMZyYHjL4k7PPH3Ykd33WoGzLDOXZj4qBx358xks1srOl2rpp/xdCQ6x
         G8oQYaqSkImKCFflIxZpgiThHy3n5O0kbvyXdogJkfTmzsUrkRK0ogJ6NEaSNEhQZAEv
         HBfTocauWNh9+Tb5tGok7h9kapdlLqJKcPOQ3/k/75HvqY4NIv9nn4jd8mXLsB70tr8q
         3tXcstx26PxBXMIg3hli0Ww+zYpaWBilVkzpHB4M+0rt/GW0TgH5M11AYFl2alAb/YHa
         QXjrut7mQ/CI1fp+0GjTN3kHYLmIOIjlk3mxxNNyrEcYxpVuwd9gzAubePhBxqEmI1sZ
         SdVg==
X-Gm-Message-State: AOJu0YwHbh4EE5ONdqdtFAHRjCxxCd9RSBExIoQpK1pbggnLuJRnMaGm
        hnNacbVzJygwU5a37QTWIb8seSn7R8CDXVsUH/Z+
X-Google-Smtp-Source: AGHT+IE4NbSQI/ApmHYg+WezQFmQeL5oHdj3CUGVySbuEVawuQXhWijLxzNAWax1cpVpQp2eRaQj+Y2JS+0I4PAh9KQ=
X-Received: by 2002:a25:df83:0:b0:d9b:e8bf:4703 with SMTP id
 w125-20020a25df83000000b00d9be8bf4703mr11018483ybg.10.1700000672338; Tue, 14
 Nov 2023 14:24:32 -0800 (PST)
MIME-Version: 1.0
References: <20231016220835.GH800259@ZenIV> <CAHC9VhTzEiKixwpKuit0CBq3S5F-CX3bT1raWdK8UPuN3xS-Bw@mail.gmail.com>
 <CAEjxPJ4FD4m7wEO+FcH+=LyH2inTZqxi1OT5FkUH485s+cqM2Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ4FD4m7wEO+FcH+=LyH2inTZqxi1OT5FkUH485s+cqM2Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 14 Nov 2023 17:24:21 -0500
Message-ID: <CAHC9VhQQ-xbV-dVvTm26LaQ8F+0iW+Z0SMXdZ9MeDBJ7z2x4xg@mail.gmail.com>
Subject: Re: [PATCH][RFC] selinuxfs: saner handling of policy reloads
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 14, 2023 at 3:57=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Nov 13, 2023 at 11:19=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Mon, Oct 16, 2023 at 6:08=E2=80=AFPM Al Viro <viro@zeniv.linux.org.u=
k> wrote:
> > >
> > > [
> > > That thing sits in viro/vfs.git#work.selinuxfs; I have
> > > lock_rename()-related followups in another branch, so a pull would be=
 more
> > > convenient for me than cherry-pick.  NOTE: testing and comments would
> > > be very welcome - as it is, the patch is pretty much untested beyond
> > > "it builds".
> > > ]
> >
> > Hi Al,
> >
> > I will admit to glossing over the comment above when I merged this
> > into the selinux/dev branch last night.  As it's been a few weeks, I'm
> > not sure if the comment above still applies, but if it does let me
> > know and I can yank/revert the patch in favor of a larger pull.  Let
> > me know what you'd like to do.
>
> Seeing this during testsuite runs:
>
> [ 3550.206423] SELinux:  Converting 1152 SID table entries...
> [ 3550.666195] ------------[ cut here ]------------
> [ 3550.666201] WARNING: CPU: 3 PID: 12300 at fs/inode.c:330 drop_nlink+0x=
57/0x70

How are you running the test suite Stephen?  I haven't hit this in my
automated testing and I did another test run manually to make sure I
wasn't missing it and everything ran clean.

I'm running the latest selinux-testsuite on a current Rawhide system
with kernel 6.7.0-0.rc1.20231114git9bacdd89.17.1.secnext.fc40 (current
Rawhide kernel + the LSM, SELinux, and audit dev trees).

--=20
paul-moore.com
