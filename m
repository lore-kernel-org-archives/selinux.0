Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3ABC433E1
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 16:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58A9020782
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 16:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FEAdo4yr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgHYQpt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:45:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43469 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725805AbgHYQps (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 12:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598373946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hc9VQT6v1cksnWAtd9m4h86n2EB1eTtHlm7DT25pQFM=;
        b=FEAdo4yrwy+YdrVg4EphOy2c1uavdfCvvSXf4R+V1eG78pG4MKc3dwYOnimBirklimTNIA
        BeGhnYC4FN6ftKB5zj3U8grpK0Z3TIiKgPC1xL3yhUq09kiU1lxgHKAQsKSZsl4poncXdu
        meobXK27IvHSNq53OdTF+SwIs/uvMK0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-QPPy6fOIN1mEKVI3AyNkRA-1; Tue, 25 Aug 2020 12:45:44 -0400
X-MC-Unique: QPPy6fOIN1mEKVI3AyNkRA-1
Received: by mail-lj1-f200.google.com with SMTP id l15so3963840lji.3
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2020 09:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hc9VQT6v1cksnWAtd9m4h86n2EB1eTtHlm7DT25pQFM=;
        b=Kgq6lq2qJsW85gS0XalPA1Ek/5NjrwmyNrFSK+7t31nVaS3PIBXVZWMv1grD39/JqR
         c3VW67qJhUcS6L7jFh+CaPgtG4Y4TUVA3kz4UH7BKIqHKjfS3WQQKnNS29xyPM0lDrOu
         CW3yNiLWkeyggp2DWuOHYcfjrjwQju9e9iyJKPe5oW9W7At7SscDO4c5zACL622cFUwr
         cY/h/FYzrfFU8uOh4I6egmMW/VaJcMyHsROmRCrxYskBNLLrEORJXtrip9BOOuKo3KDs
         JnqzFqK+FIXakMXBe3ghvNZM+Bry2TrBmEhHCiIZr9OGeDHfTeiCIEMBcumhrQvxvLx0
         Ah/w==
X-Gm-Message-State: AOAM533bhgZtmQGy5cOwq1TMMUVxFfiUx7Izsk8RRQhYKZFa5whJIRL3
        7oaAOK6iajULq6A+ojXdWwTJtI9N8plkXqNKDC2RvcagCK9idukMJbJZ5B2nl4S4lHAnVPUMgbu
        ayv98395wa+lrfe5JdxIefjv+bTdITQtNzw==
X-Received: by 2002:ac2:4add:: with SMTP id m29mr5194924lfp.189.1598373942931;
        Tue, 25 Aug 2020 09:45:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9s+ubsVexBMd5w7PqQGfSGCVL9Ps+MD8SkCFqbqqOJRAv9YAu1taiFw9AQKZOjJpfaTEgyDcxbW/Ga9klAJA=
X-Received: by 2002:ac2:4add:: with SMTP id m29mr5194919lfp.189.1598373942652;
 Tue, 25 Aug 2020 09:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200825065953.1566718-1-omosnace@redhat.com> <20200825065953.1566718-2-omosnace@redhat.com>
 <CAEjxPJ4JKHKFgF9VobJTrMBDhaqC0EKorC=qfm=t77Krd-Npsw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4JKHKFgF9VobJTrMBDhaqC0EKorC=qfm=t77Krd-Npsw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 25 Aug 2020 18:45:31 +0200
Message-ID: <CAFqZXNtOd7VXQWh9B3fnmY0MUy0HLHh75u_=6UE7UaTO2ZjYSw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] selinux: switch unnecessary GFP_ATOMIC allocs to GFP_KERNEL
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 25, 2020 at 5:01 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Aug 25, 2020 at 3:00 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > There seems to be no reason to use GFP_ATOMIC in these cases.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  security/selinux/hooks.c       |  6 +++---
> >  security/selinux/ss/policydb.c | 10 +++++-----
> >  security/selinux/ss/services.c |  4 ++--
> >  3 files changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 89d3753b7bd5d..4de962daffbde 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -6854,7 +6854,7 @@ static int selinux_lockdown(enum lockdown_reason what)
> >
> >         if (WARN(invalid_reason, "Invalid lockdown reason")) {
> >                 audit_log(audit_context(),
> > -                         GFP_ATOMIC, AUDIT_SELINUX_ERR,
> > +                         GFP_KERNEL, AUDIT_SELINUX_ERR,
> >                           "lockdown_reason=invalid");
> >                 return -EINVAL;
> >         }
>
> Have you audited all callers of security_locked_down() to ensure that
> they are never holding any locks around the call?  That's the only one
> I saw that might be a problem now or in the future.

Hm... didn't realize there were so many :) I'll try to go over them.

As a side note, it would be nice if we had the may (not) sleep
requirements documented somehow for each hook at the LSM level,
ideally with a might_sleep() check at the beginning of each
secuity_*() function that is expected to be called only from a
non-atomic context... Some hooks already have arguments that specify
this (inode_permission, inode_follow_link), but for others it is just
implicit. I'll put this on my long-term TODO list...

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

