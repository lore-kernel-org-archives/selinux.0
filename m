Return-Path: <SRS0=pnJ1=6L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849E2C54FCB
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 17:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C9D52087E
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 17:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+KbPA0F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgD0RW7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Apr 2020 13:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgD0RW7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Apr 2020 13:22:59 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97682C0610D5
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 10:22:59 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id g14so27506691otg.10
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 10:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oRdVcqHrRQ9OyB4Ed9hhdgxm7YT9q+K1dLTbck9Q5ro=;
        b=F+KbPA0Frdu/clWIBVF9kEBGROm9uyYDCcIupBY6ks9qOdus8becaEfmKnWrjRqzCK
         aRAj5Z1WjP7hgY4cYefutfym+016ixsewZOkfmgISyxpYxLr/gVNMGBLfFF2iyCjTyee
         h3NgSJSTEjcbGpkjX7tWR1tH9yF0EbrGSYEZUqKXS04kzmZH8hlkMYKMOEGbuQAd3TBR
         kBYxJfBAFdvBWd5V3j+3PzYAo4cLekVdquGpMyg0SqagrsYz7Vtjdg4EU2UH5Y36dTPc
         AAqa1ab4/fqD8S4/PzFhep155G0oiz94L2TozwAHE/3dOqvfj7UXK1Zkt7Emuizao/+Y
         Fzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oRdVcqHrRQ9OyB4Ed9hhdgxm7YT9q+K1dLTbck9Q5ro=;
        b=RxsFDE7kIrfUXRQDJdngsDTOL03DV8Evow3Ab5lT4EbHJ3wfVo+P+0vTd0V2QhoG6M
         PKNL1WsLW+IntBv7RXs9fMYeWlvF8pPDUUCspbuVYGM3Rtd+eSby9M489AGy4NgOv2nP
         3ZRKyyXfrgPwRF5kFACNCfNdamhHF4BR4S/l70oOnpePMlFfnphpMlNwK2Cv4oIQQN7H
         Frm3xEIR0QCjTh7DrF8B26MdPFvjI4WnHLW26ARtNYroNrusmmDndiFstQHLyXxk+K15
         7zBESDUSFRNZhmkFi08vR4obo0wNQCse7HKcAXkXBzd6ALr+tuBMPvWvykq5v5iVNri6
         wQKg==
X-Gm-Message-State: AGi0PubYq70baNW/8IwMDVbCkLHX+gXu7jpSMU3ldEU0tqIpRj89sMup
        SWLHoAgQc85kSuk7LyjiaBOiUb8BCZQwI2zu3lp+Ww==
X-Google-Smtp-Source: APiQypIeQhmoijw2Xlyx5e0O1ObDvOe6IxU2IB0i4QauCHT71dLYcXiYbAASJAdehjbG6ky0uNqoxMB2BcwPJpGjfas=
X-Received: by 2002:a9d:2aa9:: with SMTP id e38mr5423137otb.162.1588008178813;
 Mon, 27 Apr 2020 10:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <f4e6ddb4-66ac-45d1-04a6-67bfd9fd225e@gmail.com>
 <ypjla73zwlx4.fsf@defensec.nl> <33246601-c460-46c6-6a5a-fbcbd48d2858@gmail.com>
 <CAB9W1A3d7OyJESduertxmr=p0sN5j5JD=q01x8i8Vi5yKhs5Pg@mail.gmail.com> <50b369ba-cb70-b085-7b12-9c91be6a4e17@gmail.com>
In-Reply-To: <50b369ba-cb70-b085-7b12-9c91be6a4e17@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 27 Apr 2020 13:22:47 -0400
Message-ID: <CAEjxPJ7n7k83_r9iW2-w1t3ujxw9fMUZ7P33cDnpt=2yqV8xPw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: mount selinuxfs nodev,noexec,nosuid
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Stephen Smalley <stephen.smalley@gmail.com>,
        Dominick Grift <dominick.grift@defensec.nl>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 30, 2020 at 2:14 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>
> On 29.3.2020 23.44, Stephen Smalley wrote:
> > On Sun, Mar 29, 2020 at 7:30 AM Topi Miettinen <toiwoton@gmail.com> wrote:
> >>
> >> On 29.3.2020 12.27, Dominick Grift wrote:
> >>> Topi Miettinen <toiwoton@gmail.com> writes:
> >>>
> >>>> Mount selinuxfs with mount flags nodev,noexec and nosuid. It's not
> >>>> likely that this has any effect, but it's visually more pleasing.
> >>>
> >>> will nodev interfere with this?
> >>>
> >>>     File: /sys/fs/selinux/null
> >>>     Size: 0               Blocks: 0          IO Block: 4096   character special file
> >>> Device: 15h/21d Inode: 23          Links: 1     Device type: 1,3
> >>> Access: (0666/crw-rw-rw-)  Uid: (    0/    root)   Gid: (    0/    root)
> >>> Context: sys.id:sys.role:null.isid:s0
> >>> Access: 2020-03-28 13:04:05.578999988 +0100
> >>> Modify: 2020-03-28 13:04:05.578999988 +0100
> >>> Change: 2020-03-28 13:04:05.578999988 +0100
> >>>    Birth: -
> >>>
> >>> /sys/fs/selinux/null: character special (1/3)
> >>
> >> That device does not give me joy. Yes, the patch prevents it from being
> >> used. But I didn't see any problems in the logs, even with something
> >> else mounted over it (adding InaccessiblePaths=/sys/fs/selinux/null to
> >> systemd unit files). The device file was added pretty early to Linux,
> >> perhaps it was needed then, but not anymore?
> >>
> >> Judging from internet searches, maybe it's only used by Android. They
> >> seem to use a forked version of libselinux anyway.
> >
> > /sys/fs/selinux/null is used by the kernel; SELinux closes any open
> > file descriptors not authorized for the new process context upon a
> > context-changing exec, and replaces them with a reference to
> > /sys/fs/selinux/null.  This was introduced because /dev/null couldn't
> > be guaranteed to exist or be available at all times. nodev likely has
> > no effect on this usage because it is probably only checked when a
> > userspace process tries to open it.
>
> Perhaps then the device should not be visible to user space at all, or
> at least not usable (which is the effect of MS_NODEV)? The file
> descriptor replacement thing seems to work also when /sys{,/fs/selinux}
> is not mounted in the mount namespace of the process, at least I haven't
> seen any problems.
>
> > That said, I don't really understand what you think you are gaining by
> > adding these mount options to selinuxfs.  What threat are you
> > mitigating?   It is a kernel pseudo filesystem that doesn't support
> > dynamic file creation by userspace and whose contents are entirely
> > determined by the kernel.
>
> I don't think there's any change to threat situation (a process which
> shouldn't have access to /dev/null, gains access by using
> /sys/fs/selinux/null? Not very credible) or even any other effect from
> this change, but I don't like it when selinuxfs always shows up when I
> grep for filesystems without nodev/noexec/nosuid. So the gain is visual.
>
> What's the purpose and gain of having the filesystem mounted with
> dev,exec,suid, which for other filesystems than selinuxfs are the more
> dangerous options?

I don't think we can switch to nodev since we have been exposing that
null device node forever and
we know of at least one user (Android).  Android started with a
complete fork of libselinux but went
back to following upstream, although they still retain their own
custom additions.  So I think at most we
could add noexec/nosuid here with no risk of userspace breakage.
