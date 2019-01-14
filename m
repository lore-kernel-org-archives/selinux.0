Return-Path: <SRS0=3kls=PW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25D7C43387
	for <selinux@archiver.kernel.org>; Mon, 14 Jan 2019 09:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2F32086D
	for <selinux@archiver.kernel.org>; Mon, 14 Jan 2019 09:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfANJOo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:14:44 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40145 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfANJOo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Jan 2019 04:14:44 -0500
Received: by mail-ot1-f68.google.com with SMTP id s5so18668756oth.7
        for <selinux@vger.kernel.org>; Mon, 14 Jan 2019 01:14:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cnhr7+8733F97AEpF7PC70Gw//4TwkDpXacze17pcNQ=;
        b=K+RCpEYln3QikRQFrvnWNo74diPLXi2+sOB+MCyCNx6KRY2Oonvmu/alTj7gmHwH6T
         fcxnQbYS+LqbwzW3+A+50ZORvxoWPyg5886rY6kBVanN/u7u2nTxruqmdw8eafSdAsli
         anPdBeTA40PgExCjq3DgMy7lx46sH/awN1wKIJ7AYozBv3g6TTpPXSzPJ4Pu8ut0h1I1
         9rZNE+9vDbJH+KwHoPQ6YDCWyefS56REQ6sa3tfycxbysOfiwtTIgoBF2Bntc+Wv9rMK
         YHIIPfKZX3thsTJ+KlwMD8TGen6aL0zgWEHYDyBYkfatMMMgWgRjCTVusVO7DvHAwBGz
         scLg==
X-Gm-Message-State: AJcUukck/mvGEdQBmpyLCxgQfbIxWiUuJ6NocScTW322rrBuFRm/Y1nv
        VRZ/OsNgbhzr8nlAIRMXDaAeI/EW7zkvDgArlPsC5g==
X-Google-Smtp-Source: ALg8bN5reLCVpGJGQQo3AIdud627+jg13G44r06wXKAmmlZ76th7U7pGKnoh6hbfKFtQKXZwm3vgc8HjFva4I75w/RQ=
X-Received: by 2002:a9d:1ea7:: with SMTP id n36mr16454224otn.217.1547457283286;
 Mon, 14 Jan 2019 01:14:43 -0800 (PST)
MIME-Version: 1.0
References: <20190109091028.24485-1-omosnace@redhat.com> <20190111205053.GV2509588@devbig004.ftw2.facebook.com>
In-Reply-To: <20190111205053.GV2509588@devbig004.ftw2.facebook.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 14 Jan 2019 10:14:32 +0100
Message-ID: <CAFqZXNu-bHGmUi80UiyW3djcbedycC+0KUyiQuv9-8b+WmrYuA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Allow initializing the kernfs node's secctx based on
 its parent
To:     Tejun Heo <tj@kernel.org>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        Daniel Walsh <dwalsh@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 11, 2019 at 9:51 PM Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> On Wed, Jan 09, 2019 at 10:10:25AM +0100, Ondrej Mosnacek wrote:
> > The main motivation for this change is that the userspace users of cgroupfs
> > (which is built on kernfs) expect the usual security context inheritance
> > to work under SELinux (see [1] and [2]). This functionality is required for
> > better confinement of containers under SELinux.
>
> Can you please go into details on what the expected use cases are like
> for cgroupfs?  It shows up as a filesystem but isn't a real one and
> has its own permission scheme for delegation and stuff.  If sysfs
> hasn't needed selinux support, I'm having a bit of difficulty seeing
> why cgroupfs would.

I'm not sure what are the exact needs of the container people, but
IIUC the goal is to make it possible to have a subtree labeled with a
specific label (that gets inherited by newly created cgroups in that
subtree by default) so that container processes do not need to be
given permissions for the whole cgroupfs tree.

I'm cc'ing Dan Walsh, who should be able to explain the use cases in
more details. Dan, this is related to the cgroupfs labeling problem
([1] and [2]). See [3] for the root of this discussion.

[1] https://github.com/SELinuxProject/selinux-kernel/issues/39
[2] https://bugzilla.redhat.com/show_bug.cgi?id=1553803
[3] https://lore.kernel.org/selinux/CAFqZXNsxfjwDaCWDrqxP736y_3Jm-r=twaHtkkTDtMuym774Jw@mail.gmail.com/T/


--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
