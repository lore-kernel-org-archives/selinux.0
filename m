Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0068C433F5
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 15:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A902D6103B
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 15:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbhINPCc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Sep 2021 11:02:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27183 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234089AbhINPCc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Sep 2021 11:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631631674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f4doVZdRhwwzGkMFAoRi2PUNaC9z4kzqnDQ6De1+mEk=;
        b=Y53JofNK1EGyD5cIt2cehClYrsSMeKGmy2ehe6TD7dqeKQjE+D1fnIL0B91N4EXaT5Bd6/
        pG35x6FcVw3EruoKY/dOUF9mgy678L6eHt2qWN/Q8oA61Xx5MQfTIpkQOIb+tcx5Ir7geb
        gyNjJzW+T0A6Dm9LOMg0TASx9/1Trb0=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-MEUFN3PlPp6NfxE3xX1VeQ-1; Tue, 14 Sep 2021 11:01:12 -0400
X-MC-Unique: MEUFN3PlPp6NfxE3xX1VeQ-1
Received: by mail-io1-f69.google.com with SMTP id g2-20020a6b7602000000b005be59530196so16514533iom.0
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 08:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f4doVZdRhwwzGkMFAoRi2PUNaC9z4kzqnDQ6De1+mEk=;
        b=fyi+Gmcn9JPE33QfWHIb8EnQUduEh/gX6EIBuYzCQajyc0RfuKEGZRYiDpGLTHXaUP
         3JRiaQucAqbV6EzU8jxtwUxM5kc19N9qUrIu2d6W9UrM3qXiMBQBFvLsq++ufBePdi9Y
         f8rXHOQAsfC2W94TrFGmKaWjGoTe9nButV5gjrJP9Oo6R8ggzCcWR9g1001e25dFlyQN
         LcLb1Eetx3ojBjVjwg7fhe3GlPjt5VnWEoLx2HZogcsZoGRlZqK14z7G4H0SMmkYxUZe
         CN3g/dYg5SXmpJH9OAdYgTc4WLa+w9NZb3kgVV2eD6EtmuN3rNwt6/CG5rt4DB24UUJ8
         xnOA==
X-Gm-Message-State: AOAM531wRJMP7Cpfb0SBHpJt2N8rLZxfsQcVGf0S2KlMbe6i6ieN2vIr
        fz1tj0ibonZGZi9Ugo36tAO981QZoB5hV+KQ0OwhSEUXDa+syBms2iPVb1QVQyppAtehkdG2k89
        BRSEkP0oNdhHKTHCu5ET4MvDtjA6TfUhoFA==
X-Received: by 2002:a05:6e02:1b88:: with SMTP id h8mr12302574ili.29.1631631671752;
        Tue, 14 Sep 2021 08:01:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaAeiekMMKeZruAEeYbCxZpJjpmCzKAy5WCzmfRtD8PhxXBHVBLZZb+MFaozIMIyxqQwE9MVbD21EwvnT+xp8=
X-Received: by 2002:a05:6e02:1b88:: with SMTP id h8mr12302560ili.29.1631631671531;
 Tue, 14 Sep 2021 08:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <79dcd300-a441-cdba-e523-324733f892ca@schaufler-ca.com>
 <YTEEPZJ3kxWkcM9x@redhat.com> <YTENEAv6dw9QoYcY@redhat.com>
 <3bca47d0-747d-dd49-a03f-e0fa98eaa2f7@schaufler-ca.com> <YTEur7h6fe4xBJRb@redhat.com>
 <1f33e6ef-e896-09ef-43b1-6c5fac40ba5f@schaufler-ca.com> <YTYr4MgWnOgf/SWY@work-vm>
 <496e92bf-bf9e-a56b-bd73-3c1d0994a064@schaufler-ca.com> <YUCa6pWpr5cjCNrU@redhat.com>
 <CAPL3RVHB=E_s1AW1sQMEgrLYJ8ADCdr=qaKsDrpYjVzW-Apq8w@mail.gmail.com> <YUCybaYK/0RLvY9J@redhat.com>
In-Reply-To: <YUCybaYK/0RLvY9J@redhat.com>
From:   Bruce Fields <bfields@redhat.com>
Date:   Tue, 14 Sep 2021 11:01:00 -0400
Message-ID: <CAPL3RVGXWtakCS9bvE60gWp0tcsduJFKfoU4aoqANRgp7HvFow@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] Relax restrictions on user.* xattr
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, virtio-fs@redhat.com,
        Daniel Walsh <dwalsh@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        stephen.smalley.work@gmail.com,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 14, 2021 at 10:32 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> open_by_handle_at() requires CAP_DAC_READ_SEARCH.

Or some sort of access to the network.  If you can send rpc requests
to the nfs server that appear to be from someone with access to the
export, you can guess filehandles that allow access to objects under
that directory.  You'll need access to particular objects, but you
won't need read or lookup access to the directory.

You can prevent that if you set things up right, but these
filehandle-issues are poorly understood, and people often forget to
take them into account.

--b.

> And if you have
> CAP_DAC_READ_SEARCH, you don't need to even guess file handles. You
> should be able to read/search through all directories, IIUC.
>
> So how does one make sure that shared directory on host is not
> accessible to unprivileged entities. If making directory accessible
> to root only is weaker security, what are the options for stronger
> security.

