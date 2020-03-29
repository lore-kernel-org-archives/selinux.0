Return-Path: <SRS0=79IL=5O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A106CC43331
	for <selinux@archiver.kernel.org>; Sun, 29 Mar 2020 20:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A5020748
	for <selinux@archiver.kernel.org>; Sun, 29 Mar 2020 20:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCgFmxos"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgC2Uoo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:44:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51190 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbgC2Uon (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 29 Mar 2020 16:44:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id d198so17612592wmd.0
        for <selinux@vger.kernel.org>; Sun, 29 Mar 2020 13:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+XBsb7HKuHXt4hgp/nyU0597HwG9QAbmztVRaxvPU7E=;
        b=dCgFmxosj7W1FKmoO3gfIDbshyDKTBhyVS/IWrwLl0jydFDHcbY5s1n2vu/Vqi8uy3
         jD7AmoVIQAc3Qv0R8XMQkmYfXkZQklLTCcP4vrQVHg8iVLVqdMFK1FW822UZlWErubem
         TcygJIKl3X5kacE0/jz+nnXgClRmVjg6aGhxdvmL+iBk7VacniIn+rsv++0pHOsmEpDH
         jci6wdC807EWRdZAEr2cRgUwUDtk+JHtjajn8n9+es0uHuBRPVCUa1qvykipOZsJPy7l
         Ppm8/mbw0DPWJk5/TaKlMeFJ8NypGXBjewgVyACNbBO3sQ2pTo4TFylSz6mBBrm3phYV
         BHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+XBsb7HKuHXt4hgp/nyU0597HwG9QAbmztVRaxvPU7E=;
        b=TsKAOhHcs3b4/vZMCW/FecVO5wyVT58HdtdMkHDA1u1YY7W+iIjqz8D5oZqSSwaABT
         +RYFadiZ56+szJtMeLwAAGWqvFjvjI5JZR+Zab6hyIEa//gQ4BdS+rmKOk+NgXcfOwnF
         tOoxuT/Fur8Dt7g82ktOC0XVzHXgci7Y14GuyWrlrVeTiM1hxsEyeJF46FbQKUQLYMS5
         9XdPkjyIWB9Z1INQyoP0jjYAbpTRn84af/mUoRozhDyWRPmmuDemQjEBgt7v1dq6HBD3
         YPrbWUjs3HeqBAAhG0QVr/uA2zSMm6OWMdweShEib13x6A+OYtwSZG+xKiMv8FSRAk00
         H92Q==
X-Gm-Message-State: ANhLgQ2tRgJdadYJGw5WBQ29lRubdDVlxbr0HEV8/GkFAmTcZlPSo3AR
        XsWPMLvXYc6yf/vHz6+h9rP0OZHLyH2XNf4jsgrfsQ==
X-Google-Smtp-Source: ADFU+vux7ZbOjphe+VLCi+LtAcBKMpuyRRIRwveTtuzykg5y9jFDiExd3btpu1tu4R7f/0qDSHH7rKDdQNMgTHjoqO8=
X-Received: by 2002:a05:600c:257:: with SMTP id 23mr10247393wmj.155.1585514682078;
 Sun, 29 Mar 2020 13:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <f4e6ddb4-66ac-45d1-04a6-67bfd9fd225e@gmail.com>
 <ypjla73zwlx4.fsf@defensec.nl> <33246601-c460-46c6-6a5a-fbcbd48d2858@gmail.com>
In-Reply-To: <33246601-c460-46c6-6a5a-fbcbd48d2858@gmail.com>
From:   Stephen Smalley <stephen.smalley@gmail.com>
Date:   Sun, 29 Mar 2020 16:44:29 -0400
Message-ID: <CAB9W1A3d7OyJESduertxmr=p0sN5j5JD=q01x8i8Vi5yKhs5Pg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: mount selinuxfs nodev,noexec,nosuid
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Dominick Grift <dominick.grift@defensec.nl>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Mar 29, 2020 at 7:30 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>
> On 29.3.2020 12.27, Dominick Grift wrote:
> > Topi Miettinen <toiwoton@gmail.com> writes:
> >
> >> Mount selinuxfs with mount flags nodev,noexec and nosuid. It's not
> >> likely that this has any effect, but it's visually more pleasing.
> >
> > will nodev interfere with this?
> >
> >    File: /sys/fs/selinux/null
> >    Size: 0               Blocks: 0          IO Block: 4096   character special file
> > Device: 15h/21d Inode: 23          Links: 1     Device type: 1,3
> > Access: (0666/crw-rw-rw-)  Uid: (    0/    root)   Gid: (    0/    root)
> > Context: sys.id:sys.role:null.isid:s0
> > Access: 2020-03-28 13:04:05.578999988 +0100
> > Modify: 2020-03-28 13:04:05.578999988 +0100
> > Change: 2020-03-28 13:04:05.578999988 +0100
> >   Birth: -
> >
> > /sys/fs/selinux/null: character special (1/3)
>
> That device does not give me joy. Yes, the patch prevents it from being
> used. But I didn't see any problems in the logs, even with something
> else mounted over it (adding InaccessiblePaths=/sys/fs/selinux/null to
> systemd unit files). The device file was added pretty early to Linux,
> perhaps it was needed then, but not anymore?
>
> Judging from internet searches, maybe it's only used by Android. They
> seem to use a forked version of libselinux anyway.

/sys/fs/selinux/null is used by the kernel; SELinux closes any open
file descriptors not authorized for the new process context upon a
context-changing exec, and replaces them with a reference to
/sys/fs/selinux/null.  This was introduced because /dev/null couldn't
be guaranteed to exist or be available at all times. nodev likely has
no effect on this usage because it is probably only checked when a
userspace process tries to open it.

That said, I don't really understand what you think you are gaining by
adding these mount options to selinuxfs.  What threat are you
mitigating?   It is a kernel pseudo filesystem that doesn't support
dynamic file creation by userspace and whose contents are entirely
determined by the kernel.
