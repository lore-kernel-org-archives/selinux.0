Return-Path: <SRS0=kzV7=AE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F115C433E1
	for <selinux@archiver.kernel.org>; Tue, 23 Jun 2020 13:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BD2220723
	for <selinux@archiver.kernel.org>; Tue, 23 Jun 2020 13:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbsTEgS0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732713AbgFWN3B (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Jun 2020 09:29:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41247 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732597AbgFWN3A (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Jun 2020 09:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592918939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kQ0uQ5LktH5pw48R905A3s6eunXajyDsnvnNFSLzCM4=;
        b=IbsTEgS0tjSEOlDgl0dQNWN4z4k5mGkjGvJn4ndk2QBy/xsCAoNpXW4/4pglznxVGLfTDX
        51HlNrAKyz7zsUEHtwOpJ4ExJHsQuKJgnKtkFk3NBmkhQs5+CJd5LC72HzceeqfPsBpiaX
        fXkXt4tPGj0y062Qh1Y0c2KCoQkEoAA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317--r9rGLWpMUGNA56XdLAvQA-1; Tue, 23 Jun 2020 09:28:57 -0400
X-MC-Unique: -r9rGLWpMUGNA56XdLAvQA-1
Received: by mail-lf1-f70.google.com with SMTP id z12so3809917lfe.11
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2020 06:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kQ0uQ5LktH5pw48R905A3s6eunXajyDsnvnNFSLzCM4=;
        b=J6M9Erd5espp8i83urfEJEFl6ngA5bqXQ7/dRVc7QlNtJJt050hZqbCy4CpCYrV1Jp
         CIs7ihnEq8dcPnOFRaE6nDME8q0p1qrmkEesW4jgMbkl10Flqh0b3QWlCuTOKCr8yXD8
         rRCgSp6bxzgoJNruPCdOke7c59FbgtRugxv+8pzaO60UOMajw5DDrumMHL2v2N/CKugn
         lu6vvJwFgNFZYcoPl0s5NS8AfjQSalicTECNY2JnmyyaUSqwHsXs/4DUfkNO+xIPzLrD
         nlC5p4mpW1yUKtvxuuI5TnUGPyc9efbLRC5QIZYTc0bM6k4zI9I405tqi+NMGPbCjatF
         cuQQ==
X-Gm-Message-State: AOAM532T49Ka+T5IWNL/P556dFQmDLjS+FbwaPenkK81uympIX3eyOOD
        KSS1mGPuiUfftrWcdISUcB4VTeQg1nrPLEl9nfnkAE4hiYtk8YFvdCCcTrV3AdZyhkRClhAddjz
        X88bSwvnum1MDI2LF/qLYNWQJmV3apjHKog==
X-Received: by 2002:a2e:b4e6:: with SMTP id s6mr2677981ljm.372.1592918935574;
        Tue, 23 Jun 2020 06:28:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxboZH2v3MLEQhxdu7IwhIxyfiU8sEilVbCEU8mJlkYkwAFEM8my69MgPe1DC72R4n6jpJwtegg91B9e41DS+Q=
X-Received: by 2002:a2e:b4e6:: with SMTP id s6mr2677971ljm.372.1592918935387;
 Tue, 23 Jun 2020 06:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200623123702.401338-1-omosnace@redhat.com> <20200623123702.401338-3-omosnace@redhat.com>
 <CAEjxPJ6OPt0r2Dv2u2Skt=ojKTVpNMcvDFKkoyw50naHetLC7Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ6OPt0r2Dv2u2Skt=ojKTVpNMcvDFKkoyw50naHetLC7Q@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 23 Jun 2020 15:28:44 +0200
Message-ID: <CAFqZXNuajPrS0KSg=mcA=nRCACf6o_vscbY00pX=j9aYupVZOw@mail.gmail.com>
Subject: Re: [PATCH testsuite 2/4] travis: add missing node to fake selinuxfs
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 23, 2020 at 3:13 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Jun 23, 2020 at 8:37 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Since commit e95fe9503816 ("Add tests for default_range glblub") we look
> > at $(SELINUXFS)/initial_contexts/kernel to determine the type of the
> > policy. However, this node is not provided by the fake selinuxfs created
> > by our CI scripts, leading to non-fatal errors like this:
> >
> > [...]
> > make[1]: Entering directory '/home/travis/build/WOnder93/selinux-testsuite/policy'
> > cat: /tmp/fake-selinuxfs/initial_contexts/kernel: No such file or directory
> > [...]
> >
> > Create that node and fill it with the ussual kernel context to silence
> > the errors.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Not objecting to fixing this but wondered if you had considered
> extending the .travis.yml to actually run the testsuite in a
> SELinux-enabled VM as per the selinux .travis.yml.

Maybe eventually, but for now I wanted to at least fix what we have now,

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

