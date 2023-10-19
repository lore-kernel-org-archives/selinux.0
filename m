Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB89C46CA1
	for <selinux@archiver.kernel.org>; Thu, 19 Oct 2023 13:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbjJSNKs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Oct 2023 09:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235369AbjJSNKq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Oct 2023 09:10:46 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90DF106;
        Thu, 19 Oct 2023 06:10:42 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6ce2bcb131fso278987a34.1;
        Thu, 19 Oct 2023 06:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697721042; x=1698325842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ye6vMdiBk6fCMdBWCFZSgU3VdZTZqteq+5mpIGl0jX0=;
        b=GJMDnDkRA3X+lbF/YFuSc90319T3zD8e2x4zLjyrbCeSZOGZds6lXBIv1LNe7hZcFY
         o7xcjEa4EUFHNrfw3gs7M8ad5IPiNrJ6zg4Ch1GrcdiX8tJRarTQZwKferBJFvREX9Z2
         HtXHpbV7VXKHw/9le78JMkWXqwpdSudeOk6AVK2/xLtDwnN5ZOGdpROJcbjzPeoVQ8gb
         LS4DDLR1b7VWA2Z0yBH5mLxxnYc+E+nKZpFXlQTTBixjHDh9kT2Deo75NkV3jbkz3nmm
         d6U6aoYhSKlJ0p/JcEFbuW7CPeaZTnaiqCoaIE/bAvshqK68QQFZc59yJYQj1IRsK9Y6
         0AHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697721042; x=1698325842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ye6vMdiBk6fCMdBWCFZSgU3VdZTZqteq+5mpIGl0jX0=;
        b=q9tx9/Fyptyxf0tDuFe868wp4a3k6IAcqX6UVXH3qUKWNJL0Bn9KyrOOkW3J2lae3G
         4iVaj04lzpJkeevhe9sorkD/EXrGlM7WtPhUgXxEltwydC45oL77z+AiIAL7E0R/D6Gw
         wgQ3/YcIY/aULh0sysOn49WL+kshpPYRLQWwGir+octQAORJq4N7k4WfgruXmwoM04Ma
         dGanl0O65etF3sFcQ6gm7/hI/wj3PCTVGYMetOq5+DbQY/gddhkfOele6iD1KqWFL7f2
         2ZCPPp6uWdBxQA1uTPd54qHsgPylMTpc89PYY6QINcmX/inXyt7m2UWkwp3GMoCZ10Ym
         JrUQ==
X-Gm-Message-State: AOJu0YzEZ3ptHYOtZKUQIKwt124wZ3aiWZcOqaU8DP6SR6qPrjGhxCVt
        txQnyaLARA4rFN22Oe8rL+G6WuICehOMRJoGGxuVoQsc
X-Google-Smtp-Source: AGHT+IE430VZdkDsbpKvKxWDhEVGR82dqG4XagbT+n0EzWQMp9t2bf8FhO6KPFmDelhSMtZKIw7J4E0XfoJ7Lbza4KM=
X-Received: by 2002:a05:6830:1d43:b0:6bc:fdbd:ccb8 with SMTP id
 p3-20020a0568301d4300b006bcfdbdccb8mr2267424oth.13.1697721041742; Thu, 19 Oct
 2023 06:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231016220835.GH800259@ZenIV> <CAHC9VhTToc-rELe0EyOV4kRtOJuAmPzPB_QNn8Lw_EfMg+Edzw@mail.gmail.com>
 <20231018043532.GS800259@ZenIV>
In-Reply-To: <20231018043532.GS800259@ZenIV>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 19 Oct 2023 09:10:30 -0400
Message-ID: <CAEjxPJ6W8170OtXxyxM2VH+hChtey6Ny814wzpd2Cda+Cmepew@mail.gmail.com>
Subject: Re: [PATCH][RFC] selinuxfs: saner handling of policy reloads
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 18, 2023 at 12:35=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>
> On Tue, Oct 17, 2023 at 04:28:53PM -0400, Paul Moore wrote:
> > Thanks Al.
> >
> > Giving this a very quick look, I like the code simplifications that
> > come out of this change and I'll trust you on the idea that this
> > approach is better from a VFS perspective.
> >
> > While the reject_all() permission hammer is good, I do want to make
> > sure we are covered from a file labeling perspective; even though the
> > DAC/reject_all() check hits first and avoids the LSM inode permission
> > hook, we still want to make sure the files are labeled properly.  It
> > looks like given the current SELinux Reference Policy this shouldn't
> > be a problem, it will be labeled like most everything else in
> > selinuxfs via genfscon (SELinux policy construct).  I expect those
> > with custom SELinux policies will have something similar in place with
> > a sane default that would cover the /sys/fs/selinux/.swapover
> > directory but I did add the selinux-refpol list to the CC line just in
> > case I'm being dumb and forgetting something important with respect to
> > policy.
> >
> > The next step is to actually boot up a kernel with this patch and make
> > sure it doesn't break anything.  Simply booting up a SELinux system
> > and running 'load_policy' a handful of times should exercise the
> > policy (re)load path, and if you want a (relatively) simple SELinux
> > test suite you can find one here:
> >
> > * https://github.com/SELinuxProject/selinux-testsuite
> >
> > The README.md should have the instructions necessary to get it
> > running.  If you can't do that, and no one else on the mailing list is
> > able to test this out, I'll give it a go but expect it to take a while
> > as I'm currently swamped with reviews and other stuff.
>
> It does survive repeated load_policy (as well as semodule -d/semodule -e,
> with expected effect on /booleans, AFAICS).  As for the testsuite...
> No regressions compared to clean -rc5, but then there are (identical)
> failures on both - "Failed 8/76 test programs. 88/1046 subtests failed."
> Incomplete defconfig, at a guess...

All tests passed for me using the defconfig fragment from the selinux-tests=
uite.
