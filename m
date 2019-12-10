Return-Path: <SRS0=5m9B=2A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9F1C43603
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 11:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77EB020726
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 11:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q9X4p238"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfLJLTw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Dec 2019 06:19:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23076 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726915AbfLJLTw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Dec 2019 06:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575976790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cf3T6Hl3tRuYlB9xLwYke0CPYS9mXSIgM9ZXX4m9lck=;
        b=Q9X4p238f9nWLnzeWQJiC6eiIHA6UP6LaAE+GeAYs32xpflVjhWE0vIinq/yA39alY1Qn3
        u0jVb+J/2A6EQycGXVehbBNBxnDuCplAeo1o9XYRR9HC1R0bRzcBM2n39NC+k6SAKJf5Ep
        OFVO11gH6a2MFDwCs2BToS5uGQcqxTc=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-EHqOYpIIMU-_1eU5cSWbgQ-1; Tue, 10 Dec 2019 06:19:48 -0500
Received: by mail-oi1-f199.google.com with SMTP id m12so3321009oic.10
        for <selinux@vger.kernel.org>; Tue, 10 Dec 2019 03:19:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l3GtdF69SigvWfRsyECwt0HEbNAOt7BFtF39cwXKIeE=;
        b=a6Ccbn3yUGleR+oTUZbWO0MZwuByL5atDxz2wFQhafUzlYzMWQp0TWedjcQ5q8XLwL
         8RPyARvxFVsAJjwQVmw2JvNWtTlf5U6D39qSwSV8NO7qSBKYl1ncLb2tB/EB09cvgoS9
         7Cg3u19YBIdJRh7GOZTvbfI2kt8BJlY4cz8kGcpDFdx+veox3H++D+lDty0a3ZWgCW0M
         KwGAxW4rwYQRm9nBE6jUT9BGR2gBBx+yAzziPnnXrVF8oR+bb99jZg11+CrnqQ1PsYxq
         2q4EKo8Bx52Dmrk2ROfkhsuGoLgNUROlzRbYXghcLRxUHwwKwA2vK6Mo6kl6dzciZDx+
         pDUw==
X-Gm-Message-State: APjAAAXEzdU1GdAIu+1gduIxEZYK+gYUjAQW6Q7IxI0fP4SA4kqqBbq+
        lk9YJpiO6z2HpYpqE4sMJzK5oeyyfCVVk1sUSqmGwYCt2n/Ksy7bfcqOIMdHy916SOQ/iGdD8me
        VsC1wkrJGR+bHkK+8Jn1AE+mCLCnpcuWVxw==
X-Received: by 2002:a05:6830:2154:: with SMTP id r20mr8618688otd.66.1575976787991;
        Tue, 10 Dec 2019 03:19:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqzDS77RkPHjUaqERTrdX5ICEZa1u2wwLaziQhmw1f00a5BSuhey+UNhpNDvMVRwjSyE7e1t+gp8V5IhYYNlwLQ=
X-Received: by 2002:a05:6830:2154:: with SMTP id r20mr8618667otd.66.1575976787608;
 Tue, 10 Dec 2019 03:19:47 -0800 (PST)
MIME-Version: 1.0
References: <20191209075756.123157-1-omosnace@redhat.com> <23671223-f841-564c-6ae8-0401bce0fa20@tycho.nsa.gov>
In-Reply-To: <23671223-f841-564c-6ae8-0401bce0fa20@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 10 Dec 2019 12:19:36 +0100
Message-ID: <CAFqZXNvMHEvv0tP7ybFEsH1-CvE5GGC9fEP=yXqEnQmjxgdDjA@mail.gmail.com>
Subject: Re: [PATCH] selinux: reorder hooks to make runtime disable less broken
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
X-MC-Unique: EHqOYpIIMU-_1eU5cSWbgQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Dec 9, 2019 at 2:21 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 12/9/19 2:57 AM, Ondrej Mosnacek wrote:
> > Commit b1d9e6b0646d ("LSM: Switch to lists of hooks") switched the LSM
> > infrastructure to use per-hook lists, which meant that removing the
> > hooks for a given module was no longer atomic. Even though the commit
> > clearly documents that modules implementing runtime revmoval of hooks
> > (only SELinux attempts this madness) need to take special precautions t=
o
> > avoid race conditions, SELinux has never addressed this.
> >
> > By inserting an artificial delay between the loop iterations of
> > security_delete_hooks() (I used 100 ms), booting to a state where
> > SELinux is enabled, but policy is not yet loaded, and running these
> > commands:
> >
> >      while true; do ping -c 1 <some IP>; done &
> >      echo -n 1 >/sys/fs/selinux/disable
> >      kill %1
> >      wait
> >
> > ...I was able to trigger NULL pointer dereferences in various places. I
> > also have a report of someone getting panics on a stock RHEL-8 kernel
> > after setting SELINUX=3Ddisabled in /etc/selinux/config and rebooting
> > (without adding "selinux=3D0" to kernel command-line).
> >
> > Reordering the SELinux hooks such that those that allocate structures
> > are removed last seems to prevent these panics. It is very much possibl=
e
> > that this doesn't make the runtime disable completely race-free, but at
> > least it makes the operation much less fragile.
> >
> > An alternative (and safer) solution would be to add NULL checks to each
> > hook, but doing this just to support the runtime disable hack doesn't
> > seem to be worth the effort...
>
> Personally, I would prefer to just get rid of runtime disable
> altogether; it also precludes making the hooks read-only after
> initialization.  IMHO, selinux=3D0 is the proper way to disable SELinux i=
f
> necessary.  I believe there is an open bugzilla on Fedora related to
> this issue, since runtime disable was originally introduced for Fedora.

I, too, would like to see it gone, but removing it immediately would
likely cause issues for existing users (see [1]). So considering the
removal is going to take some time, I'd prefer to at least stop the
kernel from crashing in the meantime.

I do plan to seriously look at removing the runtime disable entirely,
but that is a longer-term goal. Restoring the logical hook order would
be trivial once the removal is done.

[1] https://bugzilla.redhat.com/show_bug.cgi?id=3D1430944#c2

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

