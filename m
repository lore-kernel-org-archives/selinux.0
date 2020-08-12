Return-Path: <SRS0=FvZo=BW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B009C433E0
	for <selinux@archiver.kernel.org>; Wed, 12 Aug 2020 08:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EECB32076B
	for <selinux@archiver.kernel.org>; Wed, 12 Aug 2020 08:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHDCraed"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgHLI7A (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Aug 2020 04:59:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20243 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726572AbgHLI7A (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Aug 2020 04:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597222738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eB2hRS7AFMQ0Zo8vTlEhrjo6hCR6JepCpg1tCuW6LbI=;
        b=HHDCraedoJTog6TSX/ISZ+cac4gmYQUPB55rSOTV7DMz5bRdwL0WPRBORqzMi/8qV0ojJ9
        6yjoL//k+wC4OL6Bc2nyZQWPMwm5iGjWP7mAE4FjbgyXz/tLxOUjTSk+ULJomlORS2NKjy
        InMj6e84SuuWk2LrOAI0miOXic7eIp0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-uSUTeaBMNP2CJ6LbZgJsJA-1; Wed, 12 Aug 2020 04:58:54 -0400
X-MC-Unique: uSUTeaBMNP2CJ6LbZgJsJA-1
Received: by mail-lf1-f71.google.com with SMTP id 136so437322lfa.19
        for <selinux@vger.kernel.org>; Wed, 12 Aug 2020 01:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eB2hRS7AFMQ0Zo8vTlEhrjo6hCR6JepCpg1tCuW6LbI=;
        b=iewFHkPxIPYWdDb5prRYlFe1xlAUzGrR8eggj329+89Xwck5eYan7HCt9iVfTJMf8Q
         ZGP5THy3n6ddbcgT3/l6C1Z6Rr73UPtBm6up11D+hk1+HGqzJyYsXV8innE5d6K/gJfa
         82Ho3lPnX9vKROxFtC6SUmEu683JMZ0m4DnXFu+CDO2d7+x/orAtsz9tvcHj5ZVpcZXc
         4uPG3urgt0/2F5zpaJBs6qg0Sc2fpQCmL9QnhGN8Ktpl+5Law8p5enrcmBmEH/UTK6MJ
         X7Vwo98KvVEETHAFwpiX+x0WM692HgliVbBOoAXex9Q+HPVVe1msOoSXM/GyJGSmoTs7
         4QjQ==
X-Gm-Message-State: AOAM530FgDE2w5NOSC6eu3yjJ0Tv/I4d3QcbqjRYpu6sdeRKnxdZWVdg
        7uSzCna2VsEv042H/6wV3I0583XMUNkqQGVC0xm6aoIP+j7PNcPNPWuhaQr4+/DOAMdEXrO30jL
        y+vV28GG4o3pOmKxVYsvEHkJxWwJZllVUaw==
X-Received: by 2002:a05:6512:5c7:: with SMTP id o7mr5362283lfo.124.1597222733458;
        Wed, 12 Aug 2020 01:58:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzY3++1IZjwFf9LSr+DdwVwBG1EdZMbShOTWOI1gQh5c0a6BO/CTl6/ZNXItKAyiO5HK8LAc9e1YGBYdqn+EgI=
X-Received: by 2002:a05:6512:5c7:: with SMTP id o7mr5362261lfo.124.1597222733172;
 Wed, 12 Aug 2020 01:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200807132640.1787455-1-omosnace@redhat.com> <CAEjxPJ6ZOLTG91DzMCw3iat=p=Y0K0So7Yg7zeUnYdivuDAk=Q@mail.gmail.com>
 <CAFqZXNtogqZXMEcLqA=ci7oiVSYvp0QNvq40zmBJ39B7XpgVHA@mail.gmail.com> <CAHC9VhRs5adeioQuacWkkPZyWh=k2NgUpLWyGhGWoq8+3k6ySw@mail.gmail.com>
In-Reply-To: <CAHC9VhRs5adeioQuacWkkPZyWh=k2NgUpLWyGhGWoq8+3k6ySw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 12 Aug 2020 10:58:42 +0200
Message-ID: <CAFqZXNtKMwMneGEdVd+cZGTxK8Uu02JHkGGyNDTdzPFkCHTsXQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] travis: run the full testsuite on a Fedora VM
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 11, 2020 at 5:18 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Aug 11, 2020 at 4:59 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Fri, Aug 7, 2020 at 3:42 PM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On the Debian side, I'd recommend Debian unstable which despite the
> > > name is more stable I think than rawhide and is what I've used for
> > > getting the testsuite up and running on Debian.  That exercises more
> > > of the tests than even Fedora rawhide does currently due to defining
> > > more classes/permissions.
> >
> > Yes, it would definitely improve coverage, but I'd rather pass that
> > baton to someone else at this point.
>
> I've mentioned this before and I feel like this is a good time to
> stress this point again - I think it is very important to work on
> becoming less Fedora/RH centric.  I recognize that this might be a bit
> of a learning curve for most of us as we try to get up to speed with
> different distros and packaging formats (the latter is a pain point
> I'm currently working through with Debian's dpkg), but I think this is
> an important part of helping to increase SELinux adoption.

It's not really about Fedora vs. Debian - it's just that Fedora
recently became a low-hanging fruit thanks to Bill's userspace scripts
and the existing testsuite CI got broken recently by Travis/GCE kernel
upgrade and instead of throwing more kludges on it I wanted to go one
step further and switch it over to the KVM approach. My plan was to
just get something working quickly so I don't need to hold off on
merging patches nor tolerate broken CI. I assure you, if Bill did the
userspace scripts for Debian, I would just copy that and put Fedora on
the backlog ;)

Anyway, if no one picks this up, I most likely eventually will. I just
wanted to make it clear that this is not on my immediate TODO list and
in case someone would like to pick it up, they are encouraged to do so
and won't conflict with my attempts. I'd like to see it happen as much
as you do, but right now I need to catch up with other work so this
will have to wait a bit.

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

