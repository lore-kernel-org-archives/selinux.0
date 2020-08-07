Return-Path: <SRS0=J0Ra=BR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E90FC433E0
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 12:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EB30221E2
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 12:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UyHMyv+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgHGM2k (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Aug 2020 08:28:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31460 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728423AbgHGM2k (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Aug 2020 08:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596803318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cnw8ntLHK2xXk9wmAX2pPLOPK5SFp59OWgM20VqUhwU=;
        b=UyHMyv+K6VPfJqR00lYDBdDbnLYgka73hKYeFaLWYGNytIcoLQDc1Goh8/UMT+7z9sJkgL
        lIyGL3DMpCQ0H/kd4/uJ0DWpuVpywbvkidRmAjNCp/jJL4zkQfX9DN/KWlTJCNmzob+ttv
        jbnVtmi/R/2Ldo17RcfJ8OBO9/RLo6w=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-YSMEZdppPwmRE3dt81fOUA-1; Fri, 07 Aug 2020 08:28:33 -0400
X-MC-Unique: YSMEZdppPwmRE3dt81fOUA-1
Received: by mail-lj1-f199.google.com with SMTP id t3so381446ljj.1
        for <selinux@vger.kernel.org>; Fri, 07 Aug 2020 05:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cnw8ntLHK2xXk9wmAX2pPLOPK5SFp59OWgM20VqUhwU=;
        b=ebO7NWbB5JWgzqcTvuIeWqKrCflXLrWTKzVbODp7VQDCmgFVj4eofrY0OYBSKpKlPI
         U/OQs90EFqAxwt+Ke33WsAVlN4FW2tWyBoKxRl6ZMSZkYRPmPkdPL7+Ii6QFJEq7MnMp
         oHrEB5qJCrKKGawqerYBGPpon0MGTI1Xn2z8xggKn0Vqgrz67xbf65tCt8M1jrBu0yeS
         3J6r6RURYjjKAO/QnekTPyZuDPtPMgjHvlRvdIdCM8z6rWc5g2FemeKCFfwSsQ6yJMxY
         FABmqgt7UCqxyCRmQmHpYqDMGhiVxp7ZwqunnH242hSfhFdbAvBDJbDer6KrmcJi66zf
         YSTQ==
X-Gm-Message-State: AOAM532aJGWdaGe+uh1IyjaDR1J3Ry26Ahb3udzjlKwVHxboponIPQHr
        JvZTRgk2S1F3TeIfm0U+ePXrNsUE/IrWFh+536ecKPFEV06hTerhj8LI5OlQXFCotPku7szrl8U
        vQ0mTTOhKAIQCQtjzyu8ZfqrhuwL3anmsOQ==
X-Received: by 2002:a2e:7010:: with SMTP id l16mr5955137ljc.38.1596803312218;
        Fri, 07 Aug 2020 05:28:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2vAJwfbRuMcaqLQ6/3Qezn9ekQ6aW+h1VLeKDAsfnRl8r0PKnu/bZxdkt5hKlbh8DxlJEQsCOaA0nKujPV+E=
X-Received: by 2002:a2e:7010:: with SMTP id l16mr5955129ljc.38.1596803311962;
 Fri, 07 Aug 2020 05:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAFqZXNvh9q4qTSN-Fj108JrO8DAfMiDkOzTDHs6n3Pxg+DOtXg@mail.gmail.com>
 <20200803151428.15166-1-william.c.roberts@intel.com> <CAFqZXNtTZio0-9_T9yheg0JmUP-TDa2OsUkgvHrNphGCrjhMVg@mail.gmail.com>
 <CAFftDdpwud0FtuaoUE1ABgYtMwr3+kcF-hww88+eDHdz5oGLSw@mail.gmail.com>
 <CAFqZXNtVeUZWt99_SY+AYYLgTKqAw0rfs8TY5oN-fpKv8f1vqA@mail.gmail.com> <CAFftDdoye_BgA24w8R67x4NWTATovT5-4zdx-k3QR=J1gEypbQ@mail.gmail.com>
In-Reply-To: <CAFftDdoye_BgA24w8R67x4NWTATovT5-4zdx-k3QR=J1gEypbQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 7 Aug 2020 14:28:21 +0200
Message-ID: <CAFqZXNv1gKEXZ0yOasKV9nLxR6d3xs8GVTudVABzUn2qK-xVZA@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/ci: license as MIT
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        "Roberts, William C" <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 4, 2020 at 4:36 PM William Roberts <bill.c.roberts@gmail.com> wrote:
> Sounds good.
>
> On Tue, Aug 4, 2020 at 9:35 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Mon, Aug 3, 2020 at 6:44 PM William Roberts <bill.c.roberts@gmail.com> wrote:
> > > On Mon, Aug 3, 2020 at 11:31 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > >
> > > > On Mon, Aug 3, 2020 at 5:14 PM <bill.c.roberts@gmail.com> wrote:
> > > > > From: William Roberts <william.c.roberts@intel.com>
> > > > >
> > > > > License the ci scripts with a permissive, OSI approved license, such as
> > > > > MIT.
> > > > >
> > > > > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > > > > ---
> > > > >  v1: Apache 2.0
> > > > >  v2: MIT
> > > > >
> > > > >  scripts/ci/LICENSE               | 7 +++++++
> > > > >  scripts/ci/fedora-test-runner.sh | 2 +-
> > > > >  scripts/ci/travis-kvm-setup.sh   | 2 +-
> > > > >  3 files changed, 9 insertions(+), 2 deletions(-)
> > > > >  create mode 100644 scripts/ci/LICENSE
> > > > >
[...]
> > > > > diff --git a/scripts/ci/fedora-test-runner.sh b/scripts/ci/fedora-test-runner.sh
> > > > > index 569723387f6b..0aaba87c421b 100755
> > > > > --- a/scripts/ci/fedora-test-runner.sh
> > > > > +++ b/scripts/ci/fedora-test-runner.sh
> > > > > @@ -1,5 +1,5 @@
> > > > >  #!/usr/bin/env bash
> > > > > -
> > > > > +# SPDX-License-Identifier: MIT
> > > >
> > > > As I said in the v1 thread, also the individual files should contain a
> > > > copyright line in addition to the SPDX line. See:
> > > > https://matija.suklje.name/how-and-why-to-properly-write-copyright-statements-in-your-code#why-have-the-copyright-statement
> > >
> > > You don't actually need them and they just clutter the code and as a
> > > policy, I don't participate in adding to the problem of these big
> > > blocks
> > > of copyright statements that need to be maintained and grow per
> > > contributor. I can just drop the SPDX identifiers, as the LICENSE file
> > > applies to everything.
> > >
> > > With version control, the issues as described by that author are less
> > > of a problem. We can easily
> > > trace from whom, by how and when code was modified for any legal
> > > issues if they were to arise.
> > >
> > > We can just keep the LICENSE file, drop the SPDX identifiers and I
> > > would be 100% in-line with that libselinux is currently doing.
> >
> > I tend to disagree, but I can live with it if you want to leave it
> > out. So let me ACK this patch and I'll just remove the template
> > "Copyright" line from the LICENSE file when applying.
> >
> > Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

Patch applied.

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

