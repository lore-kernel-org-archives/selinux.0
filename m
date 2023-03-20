Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BDCC6FD1D
	for <selinux@archiver.kernel.org>; Mon, 20 Mar 2023 16:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjCTQl1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Mar 2023 12:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjCTQkr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Mar 2023 12:40:47 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902112A6C7
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 09:35:45 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-54184571389so234157737b3.4
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 09:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1679330142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qj1mCpAV4hH5mL3/ABHbLoDVfGKN+FB37WuF2Gz03t4=;
        b=GPJ5n6098OsoqhwOobavSLlaEMw0YMqK8+iBRFBbGzLn/wYPR64Pc7aTI/PnqsDr+i
         cccuIfAvj9SMMp3NIji2UKXNNUiSPlc4CRbftJ1o6GJIEFNtJV5dHScF3skYSpSEf4Fe
         Fpb1BiI0qZnfOI/8wKczNp9+2YBRzBVJ7Lv39Eassw9JvKpuVCeY9o3xIq/YS7s0WZtc
         fCBgkid/8Ko51zWzH+7kPjWwxss+BJjuwYNSPvmSA5Csh8sUsU/LT0UwJ1A8yFHk7gUP
         fJCuyDRwvxIOopZKCaduavBZTqaYywHFzznU5UeBT5SGtQ7xpDbXxkULFx1Tz301QbYG
         mAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679330142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qj1mCpAV4hH5mL3/ABHbLoDVfGKN+FB37WuF2Gz03t4=;
        b=PQ7qw/xR8w9Logwc7zBYJBpJ6HfTrH9/9rqooZkfrB2jea7krPc8SEMF4Pxole15kP
         Oa5P05fsx6n3pyxIGQUXNwuuznkgVR2VxMU9XcEg702DUTQmYx946Nj4GuFGqiMdUum3
         G/PldQXclm2EsEjVLFyXV+dpVyzQ3saczLVYPNuVsWW3aySaCZ8owNElfPQeRYAeBzeM
         zO3SJBLQBfl8HVDcYoDejlX+i4TQ+wSnXGwW82lMP24kQAbl2UDj3kbmIfZBBYhkR0Qk
         S9P7DXcngjqgMsI+pjBZraZKNrOK3xVQAcQgVNZSRdvKcGT4vgq79tsATvM+JLU/Pa8i
         zs2A==
X-Gm-Message-State: AO0yUKVbRHdcKVOASP+k8DP/4fnuL0i9RhywbKetR9/HqstY7+6xqYBC
        lXxx8HXgciYS3X7XzKNakwQMPLG98a2w9pb/Tc1hRdyv0Nu2iKM=
X-Google-Smtp-Source: AK7set90dR1IH+nMe3u010udJ6VBLPEc/AOtIdf7fDqBLgfnn54hyn1XMUWl0TdI8sj2SC7K2Goo7MR1BBgRVKF76xI=
X-Received: by 2002:a81:4419:0:b0:544:cd0e:2f80 with SMTP id
 r25-20020a814419000000b00544cd0e2f80mr5971093ywa.8.1679330142170; Mon, 20 Mar
 2023 09:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230316202355.349179-1-paul@paul-moore.com> <CAEjxPJ4cC+KAD1AQyJE8M3e_3-gXck5SmQeTS6ww8A_nEy=eeQ@mail.gmail.com>
 <CAHC9VhRrcH1--3sTAAcxmuFerW1snSDdTiKuTxpAa7A9LN1aPA@mail.gmail.com>
In-Reply-To: <CAHC9VhRrcH1--3sTAAcxmuFerW1snSDdTiKuTxpAa7A9LN1aPA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 20 Mar 2023 12:35:31 -0400
Message-ID: <CAHC9VhT6MncNo15p879fDWRy4d4QLiNjZotTjHQdGBWU-BMg-g@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: remove the 'checkreqprot' functionality
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 17, 2023 at 12:42=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> On Fri, Mar 17, 2023 at 8:26=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Thu, Mar 16, 2023 at 4:34=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
> > > We originally promised that the SELinux 'checkreqprot' functionality
> > > would be removed no sooner than June 2021, and now that it is March
> > > 2023 it seems like it is a good time to do the final removal.  The
> > > deprecation notice in the kernel provides plenty of detail on why
> > > 'checkreqprot' is not desirable, with the key point repeated below:
> > >
> > >   This was a compatibility mechanism for legacy userspace and
> > >   for the READ_IMPLIES_EXEC personality flag.  However, if set to
> > >   1, it weakens security by allowing mappings to be made executable
> > >   without authorization by policy.  The default value of checkreqprot
> > >   at boot was changed starting in Linux v4.4 to 0 (i.e. check the
> > >   actual protection), and Android and Linux distributions have been
> > >   explicitly writing a "0" to /sys/fs/selinux/checkreqprot during
> > >   initialization for some time.
> > >
> > > Along with the official deprecation notice, we have been discussing
> > > this on-list and directly with several of the larger SELinux-based
> > > distros and everyone is happy to see this feature finally removed.
> > > In an attempt to catch all of the smaller, and DIY, Linux systems
> > > we have been writing a deprecation notice URL into the kernel log,
> > > along with a growing ssleep() penalty, when admins enabled
> > > checkreqprot at runtime or via the kernel command line.  We have
> > > yet to have anyone come to us and raise an objection to the
> > > deprecation or planned removal.
> > >
> > > It is worth noting that while this patch removes the checkreqprot
> > > functionality, it leaves the user visible interfaces (kernel command
> > > line and selinuxfs file) intact, just inert.  This should help
> > > prevent breakages with existing userspace tools that correctly, but
> > > unnecessarily, disable checkreqprot at boot or runtime.  Admins
> > > that attempt to enable checkreqprot will be met with a removal
> > > message in the kernel log.
> > >
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> >
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Thanks Stephen.  I'm going to hold off on merging this into
> selinux/next until Monday, partially to give people some additional
> time to comment/object, and partially because I don't want to blow up
> anyone's system over the weekend ;)

I just merged this into selinux/next.

--=20
paul-moore.com
