Return-Path: <SRS0=2vFY=3C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1078AC33C9A
	for <selinux@archiver.kernel.org>; Mon, 13 Jan 2020 10:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47562080D
	for <selinux@archiver.kernel.org>; Mon, 13 Jan 2020 10:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tov5xuqQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbgAMKAk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Jan 2020 05:00:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20784 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725978AbgAMKAk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Jan 2020 05:00:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578909638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+Ofz5cGqlCAg0ob1EDru1R0PIDxRoCJIGrPX3XZZto8=;
        b=Tov5xuqQ0onCn/9C/AOAarEHNOkKIsoTjowzcCo3bLAle+NlDnXfxu0ovr3fddwIea3lob
        YsaQkzy1FnwlQw4RJe8XYUGrpc0HeZS/lszsQ/E3c9HIAWad8WVHsK0lZxEVTHbWYq8xPK
        6SwKylQq2xlxxGBW9CPKly5ALjmMo50=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-8CE1DHwANtytbyzyhKFBnA-1; Mon, 13 Jan 2020 05:00:36 -0500
X-MC-Unique: 8CE1DHwANtytbyzyhKFBnA-1
Received: by mail-ot1-f72.google.com with SMTP id v2so6151132otq.2
        for <selinux@vger.kernel.org>; Mon, 13 Jan 2020 02:00:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Ofz5cGqlCAg0ob1EDru1R0PIDxRoCJIGrPX3XZZto8=;
        b=uOitxL1t4UTeAVfz9CoqsB4j7G5VrjQcgWJQBuf2l4WHpSkmGCr4E71zrKxLQkXeKu
         Ok0n12AlaNOy6LXINSkQpMjzkF1aU5bgQTjEt9+200CbcbePDxd0UrCkSzQu4/6cKk3H
         F+YStuBRdSYDmc91pDFSzkbkx82FE1FHbt0R4uIJprEL2sgBxU5JkHIdqcxebBN+u8nC
         YtSOG5vSzpSXNpPwKdBoH67w9X6xdC8mOH1fhhU0Mbk0kj9bKWfnYoFi5XPVDCX5y4UD
         fW6Op/ZZW6thXDKK2ePYFwdzQpT65soINmypkTGP+K/KqG/YgKjHK42TZA/z23PbysDW
         724A==
X-Gm-Message-State: APjAAAUN5K+WD8VReiVzu/JWZeALOJ9tgKDfdm9D6tuIjfJ7PWniH84S
        oY9Cyxqu04VyolhjyGWHVf+BElUkDY/+TIP1ZlcYPU+RoCchYzglAXeCmMnPeDV+Hm+URQrRqKj
        xtdg6MonURmil7gyjsQsDHD7xAwdBu/BqoA==
X-Received: by 2002:aca:4d4f:: with SMTP id a76mr12380848oib.26.1578909635644;
        Mon, 13 Jan 2020 02:00:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqyyDHfR9EetLXjZlojl+iDPnylhCcmxzjimaWB3o0hB60YmN/zBC/3pTi4V9y5GzcagWfcZGdbYwTneD6QLF+w=
X-Received: by 2002:aca:4d4f:: with SMTP id a76mr12380831oib.26.1578909635349;
 Mon, 13 Jan 2020 02:00:35 -0800 (PST)
MIME-Version: 1.0
References: <20200108140958.870283-1-omosnace@redhat.com> <CAHC9VhS7fWscz-dOwwBDdzoeUr4-7Yt410RSEZPctoNBTnAsJw@mail.gmail.com>
In-Reply-To: <CAHC9VhS7fWscz-dOwwBDdzoeUr4-7Yt410RSEZPctoNBTnAsJw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 13 Jan 2020 11:00:23 +0100
Message-ID: <CAFqZXNvzz9GSJjBgYLV3MPVKvxx4nKSGquVxy=0gRj4n=veuOg@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: reorder hooks to make runtime disable less broken
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 10, 2020 at 9:38 PM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Jan 8, 2020 at 9:10 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > Commit b1d9e6b0646d ("LSM: Switch to lists of hooks") switched the LSM
> > infrastructure to use per-hook lists, which meant that removing the
> > hooks for a given module was no longer atomic. Even though the commit
> > clearly documents that modules implementing runtime revmoval of hooks
> > (only SELinux attempts this madness) need to take special precautions to
> > avoid race conditions, SELinux has never addressed this.
> >
> > By inserting an artificial delay between the loop iterations of
> > security_delete_hooks() (I used 100 ms), booting to a state where
> > SELinux is enabled, but policy is not yet loaded, and running these
> > commands:
> >
> >     while true; do ping -c 1 <some IP>; done &
> >     echo -n 1 >/sys/fs/selinux/disable
> >     kill %1
> >     wait
> >
> > ...I was able to trigger NULL pointer dereferences in various places. I
> > also have a report of someone getting panics on a stock RHEL-8 kernel
> > after setting SELINUX=disabled in /etc/selinux/config and rebooting
> > (without adding "selinux=0" to kernel command-line).
> >
> > Reordering the SELinux hooks such that those that allocate structures
> > are removed last seems to prevent these panics. It is very much possible
> > that this doesn't make the runtime disable completely race-free, but at
> > least it makes the operation much less fragile.
> >
> > Fixes: b1d9e6b0646d ("LSM: Switch to lists of hooks")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >
> > Changes in v2:
> >  - rebased on latest selinux/next
> >  - added comment above selinux_nf_ip_exit() call to ensure it remains
> >    ordered correctly
> >
> >  security/selinux/hooks.c | 101 +++++++++++++++++++++++++++------------
> >  1 file changed, 70 insertions(+), 31 deletions(-)
>
> Thanks Ondrej, I've merged this into selinux/next and added the stable
> kernel CC.  Normally when we mark something for stable I send it up to
> Linus during the -rcX development phase, but I think this case is
> somewhat unique in that it isn't widespread (and there is no
> indication it will become widespread) and it requires privilege to
> trigger.  Also, while not a major factor, we are at -rc5 which means
> we are very near the end of the -rcX cycle and I'd rather not
> accidentally break something else this late in an attempt to fix such
> a limited problem.
>
> Comments and objections are welcome ;)

No objections. I'm perfectly fine with that in this case :)

Thanks,

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

