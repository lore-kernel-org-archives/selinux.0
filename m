Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858AFC433B4
	for <selinux@archiver.kernel.org>; Sat,  3 Apr 2021 15:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 445D7611CE
	for <selinux@archiver.kernel.org>; Sat,  3 Apr 2021 15:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbhDCPVq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 3 Apr 2021 11:21:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48638 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236791AbhDCPVo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 3 Apr 2021 11:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617463301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0vsf++MBJa1jivteBPSF/34krmYzVn/gmykMb/mq8dg=;
        b=I78U1gFqqUDcJ7ojUZeZerghCFHbp5TgztGtEz5woguflpBnE5s/coyuPPzZhYwhpzeFoM
        mCfUWODdXklAuwlaWjj6jEF7jL7xu2uXYow9E8tXevVSOHSuWSDLqzclonKu7SM3WvKc9w
        JlAOsSSf1FCAmQ4W9VtJzvQK4WHbLz0=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-wHbuBSI9NoaMROFv_mm6vg-1; Sat, 03 Apr 2021 11:21:38 -0400
X-MC-Unique: wHbuBSI9NoaMROFv_mm6vg-1
Received: by mail-yb1-f199.google.com with SMTP id v6so12392334ybk.9
        for <selinux@vger.kernel.org>; Sat, 03 Apr 2021 08:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0vsf++MBJa1jivteBPSF/34krmYzVn/gmykMb/mq8dg=;
        b=ThpF0Ll8Z10LO5qChN2u1VA4NEcQBIRsIQsKW0iZpCCWhevR/7PcirNBltQ3cJsDGp
         qzS/LhqtYoulWo16LjgciIjLF1HqxvVRabqVpGPhyYICqrk7epYM1pqJHmthGHT9kGKS
         qEQ9DL1m/mflPjJQlZTyWpd+SvrfTN07buG1ri43DKFQeMTxBuiKzsZu48TOXRO85eqZ
         lle/lJxQy9OBpJ5gJ/2O4m4JAq0rCx1I5NOD28o1ojo4x7pnBX3KlZu27z14tBIWAPPK
         RgKgvKZZb0nmkhKGtS2MY4clZjcj4A/MbPitgnEl0j5cKwgKEUGWDmJiKqsuoXnUa0TT
         4gHQ==
X-Gm-Message-State: AOAM533D44o9aHlr6i5zyr/Q2+caIekiZLiWrKUUMlB6wVWL/kDmIrzl
        LtwZlFUpg8uT//XAxhpcghUeKvYRPAFU5WOquXk2GuFFrn7Fwrf6GcmNV0lFpIu+Xc1pbHNHoAv
        XAwtoqj3Hs+//NMBag3QAYhlM1ZuGSA8Iaw==
X-Received: by 2002:a25:2f8a:: with SMTP id v132mr19737459ybv.227.1617463297370;
        Sat, 03 Apr 2021 08:21:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweNaoqZkAs/HxZilG78ocsi0GHzFpO5xzV+B11PkgNrpXgetqHqwaKaz2WcyDodNj7gqVjYaseQtUBh2TpXmg=
X-Received: by 2002:a25:2f8a:: with SMTP id v132mr19737440ybv.227.1617463297156;
 Sat, 03 Apr 2021 08:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <3c63e34b-e54f-9b01-bad4-8fde8528a64d@linux.microsoft.com> <CAHC9VhTD2iXw7CkxgwnOx1zNN_AqMV+x1Vy8FijdMQE1m4AOJA@mail.gmail.com>
In-Reply-To: <CAHC9VhTD2iXw7CkxgwnOx1zNN_AqMV+x1Vy8FijdMQE1m4AOJA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sat, 3 Apr 2021 17:21:24 +0200
Message-ID: <CAFqZXNvZCiE=cKhjBqvxOmebDi3vNr0gS563cCMqTTwpcM6JAw@mail.gmail.com>
Subject: Re: [BUG] Oops in sidtab_context_to_sid
To:     Paul Moore <paul@paul-moore.com>
Cc:     Vijay Balakrishna <vijayb@linux.microsoft.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Apr 3, 2021 at 4:33 PM Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Apr 2, 2021 at 6:35 PM Vijay Balakrishna
> <vijayb@linux.microsoft.com> wrote:
> >
> > Seeing oops in 5.4.83 sidtab_context_to_sid().  I checked with Tyler (copied),  he said it might be
> >
> > https://lore.kernel.org/selinux/CAFqZXNu8s5edDbSZuSutetTsy58i08vPuP2h-n9=kT34HcPc4w@mail.gmail.com/
> >
> > Ondrej, can you confirm?  Unfortunately, we don't have a on demand repro.
>
> I'm guessing this may be the problem that Tyler reported earlier and
> which appeared to be fixed by the patch below:
>
> https://lore.kernel.org/selinux/20210318215303.2578052-3-omosnace@redhat.com

Nope, if that's really 5.4.83 with no extra backports, then it can't
be this issue as it has been introduced only in v5.10.

Looking at the code in 5.4.83, my initial guess is that it could be a
memory ordering race between
sidtab_reverse_lookup()/sidtab_rcache_push() and
sidtab_rcache_search(). I think the sidtab_rcache_push() call at
security/selinux/ss/security.c:326 should in fact be after the
smp_store_release() call. Note that the sidtab_rcache_*() functions
have been replaced in commit 66f8e2f03c02 ("selinux: sidtab reverse
lookup hash table") with a different mechanism, which AFAICT doesn't
have the same issue.

If that's really it, it will likely be *very* hard to reproduce, so
you may be unable to verify the fix.

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

