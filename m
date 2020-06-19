Return-Path: <SRS0=1V8V=AA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11610C433E0
	for <selinux@archiver.kernel.org>; Fri, 19 Jun 2020 12:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF95520776
	for <selinux@archiver.kernel.org>; Fri, 19 Jun 2020 12:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZbZCyViK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731917AbgFSMzE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Jun 2020 08:55:04 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57043 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728081AbgFSMzE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Jun 2020 08:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592571302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T8whRm2NeAPFoeJbeXpYgIbhYjGEZ9Z5ngJJrKZQ2tg=;
        b=ZbZCyViK+FnIdwD6EGgDWLE8hCcUnEywIp+RjmF+Vs0jKC5Sbqic/i+X6WKu1VogRDQxUf
        +R39lIB87zafanLss/E6QokXYAHZYzLyVY0MjKUieMaWfZxf5TZNkGUh46/uiJVPwDJ1Xv
        /TLLlTNPFGuR/3VJqOPBH0FwJu6blYc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-V3XA0R1pNo2GfLevs28IGw-1; Fri, 19 Jun 2020 08:55:00 -0400
X-MC-Unique: V3XA0R1pNo2GfLevs28IGw-1
Received: by mail-lf1-f72.google.com with SMTP id u24so510111lfl.23
        for <selinux@vger.kernel.org>; Fri, 19 Jun 2020 05:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T8whRm2NeAPFoeJbeXpYgIbhYjGEZ9Z5ngJJrKZQ2tg=;
        b=KOyGAnvlNTF7aOGjC/tHZHoO0/5vaQrhw1z3uFjtAQF6hYs1k5/QiIP+/E6X5bkG2m
         NoiEgin3qb4QcfiAiU+R3uhAkxtfHa3ctEUfv+dRMt6r8UhPs2oUZICoShFbPtzBnQGm
         Cx3c5ZvWkK9fiAgpw3l+lDX1VNUwmErSbOoQzQFVb2/PvWUTMWYblyP0qwkCksi8ugbL
         bUS1YVdH4pIdSKRCBe6Ws5ClNAr+XMt2Jb/kJOLPB5oopby9RSqis72/DGCEoSARiIV4
         TW0o6wGgGFgZG0FY0754MmQgUzzGq1kJjr8f7CjQQtDpy6ES3BJCeafTFzAYSDCBv81w
         agMA==
X-Gm-Message-State: AOAM533BM8vCos91DX1NK7ZUTU2NWRdoO6lB0U9N0YywhufZHKbt6XAX
        2cj7gSZ3VuKI4unx7D43fiU0AsYEiT4Bpcj92+b5RU4b4uVJaLoQ7LFCLFE5TUCqFdfenxSvvyz
        lRWwyB+TI0DnLrrpCaskUy6YZo2Iz+GpHrA==
X-Received: by 2002:a19:11:: with SMTP id 17mr1905753lfa.125.1592571299173;
        Fri, 19 Jun 2020 05:54:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdJADOflJQArFYWtZfKHD1oPNPZBVStCWZ5zgrz7dladr9bdToeqdPjiRDkCBVMRWhAjfAZ2JJESEXJHcxuug=
X-Received: by 2002:a19:11:: with SMTP id 17mr1905747lfa.125.1592571298979;
 Fri, 19 Jun 2020 05:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <SELinuxProject/selinux+700041658+stillfailing@travis-ci.org>
 <5eeca9a6c6c3f_13f81db917afc6197f@travis-tasks-8545cf558d-gwbmp.mail> <20200619124723.GD785659@localhost.localdomain>
In-Reply-To: <20200619124723.GD785659@localhost.localdomain>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 19 Jun 2020 14:54:47 +0200
Message-ID: <CAFqZXNtnPU++Foy+SdeVwMFqJ14tEsNnqOFHZEsbUHmYs_-0rw@mail.gmail.com>
Subject: Re: Still Failing: SELinuxProject/selinux#444 (master - b3d8b99)
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 19, 2020 at 2:48 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> On Fri, Jun 19, 2020 at 12:03:51PM +0000, Travis CI wrote:
> > Build Update for SELinuxProject/selinux
> > -------------------------------------
> >
> > Build: #444
> > Status: Still Failing
> >
> > Duration: 17 mins and 45 secs
> > Commit: b3d8b99 (master)
> > Author: Petr Lautrbach
> > Message: Update VERSIONs to 3.1-rc2 for release.
> >
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> >
> > View the changeset: https://github.com/SELinuxProject/selinux/compare/08f5e3017721...b3d8b99f0cb0
> >
> > View the full build log and details: https://travis-ci.org/github/SELinuxProject/selinux/builds/700041658?utm_medium=notification&utm_source=email
> >
>
> Seems to be related to outage in Fedora infrastructure -
> https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject.org/thread/MAGJJTVR777ARZ4TVMBQQ3YK6RC7ODE6/
>
> There's also ongoing datacentre move -
> https://lists.fedoraproject.org/archives/list/devel-announce@lists.fedoraproject.org/thread/5DNRZ4OUUNGSUJONQLEXXP3CKME43SCE/

Have you tried just restarting the build? Looking at the logs, it
successfully connected to 152.19.134.145 when downloading the image,
but then failed to connect to the same IP when downloading the
checksum file, which would suggest the connection is just flaky and
not completely down.

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

