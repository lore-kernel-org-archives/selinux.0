Return-Path: <SRS0=dV66=BO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B34C433E0
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 14:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0BED2065C
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 14:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WRlevT/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgHDOgQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:36:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31783 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbgHDOfQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Aug 2020 10:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596551713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s490s+9MAYOpJxbiTap8sgFIzi5xD/BBHcFEy+DUVOc=;
        b=WRlevT/KuM8RnpEFShTBz17lLBAD9Av+tv6e+6nX5cCaFnuBXjFU0w7wfIfiIZp21X1tj/
        kgNrrVNzfYvHowfdepK2mCqKs6ZNw1CnWrzX4iT0zWCiI8H7Gp4qYOqGvlscFP0a5Mipl4
        VgWUzP3YvMG90HaNxi5w90PCv7cVM6Y=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-sqeRmdQdN5KMvPyZuu45QA-1; Tue, 04 Aug 2020 10:35:08 -0400
X-MC-Unique: sqeRmdQdN5KMvPyZuu45QA-1
Received: by mail-lf1-f70.google.com with SMTP id p12so1442300lfk.21
        for <selinux@vger.kernel.org>; Tue, 04 Aug 2020 07:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s490s+9MAYOpJxbiTap8sgFIzi5xD/BBHcFEy+DUVOc=;
        b=dAsZdt0r7eTUYNOK1X83ReMa/7kkR6ckufnquy0wj3REt35S+ozFq85DAVsa2QvT6b
         aRWuaXSEuS7e8QXItzJxgNOut13CfVyoY9rrWzkBkTYQZLP4A+FbuNJIfIe0JqMOBTEF
         DDBWzTjDWoKT1b80NlCOMjpdCLakHc603UMmsxOg/kD1AzeWqDOMiV4hQMcr/MBZixBv
         gU22jCA8Ibd9VgUJlR4d2mUGoTwZ4fYjJ2druA7Mmf9p2xc/WK/Jh+ztOLHN9e5HG6Jf
         MEFeJcf/+rj+pOuZZ3MY91e+xcuzUGQCDoq9yydFa6fMiSeYJcuAAkKevO7JgTXyZxdY
         VZcw==
X-Gm-Message-State: AOAM533QF8v2iMhkivmVw4X61fsLrMUdxKPaEW7cD/pG1i3wPLQg030o
        NfdTu+hUeLxdDCE/yCqbMgOMULFMm/KrLeCEv68rluMBpXuOnFB6k6V9l4Bz7lmwIXFgaIbe6yC
        AGPKyMSo4LrlGy4VZpnGVPNsSRmFf0h7TAA==
X-Received: by 2002:a2e:86da:: with SMTP id n26mr6485126ljj.311.1596551706507;
        Tue, 04 Aug 2020 07:35:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzppbcxXfQDV2cleQj/lFK8uDEigKHHd4D16rPxcy93g98Of4yK1peYeopcGhl6yY8q3N20XZsh7g0mm6qn0pI=
X-Received: by 2002:a2e:86da:: with SMTP id n26mr6485112ljj.311.1596551706212;
 Tue, 04 Aug 2020 07:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAFqZXNvh9q4qTSN-Fj108JrO8DAfMiDkOzTDHs6n3Pxg+DOtXg@mail.gmail.com>
 <20200803151428.15166-1-william.c.roberts@intel.com> <CAFqZXNtTZio0-9_T9yheg0JmUP-TDa2OsUkgvHrNphGCrjhMVg@mail.gmail.com>
 <CAFftDdpwud0FtuaoUE1ABgYtMwr3+kcF-hww88+eDHdz5oGLSw@mail.gmail.com>
In-Reply-To: <CAFftDdpwud0FtuaoUE1ABgYtMwr3+kcF-hww88+eDHdz5oGLSw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 4 Aug 2020 16:34:55 +0200
Message-ID: <CAFqZXNtVeUZWt99_SY+AYYLgTKqAw0rfs8TY5oN-fpKv8f1vqA@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/ci: license as MIT
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        "Roberts, William C" <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 3, 2020 at 6:44 PM William Roberts <bill.c.roberts@gmail.com> w=
rote:
> On Mon, Aug 3, 2020 at 11:31 AM Ondrej Mosnacek <omosnace@redhat.com> wro=
te:
> >
> > On Mon, Aug 3, 2020 at 5:14 PM <bill.c.roberts@gmail.com> wrote:
> > > From: William Roberts <william.c.roberts@intel.com>
> > >
> > > License the ci scripts with a permissive, OSI approved license, such =
as
> > > MIT.
> > >
> > > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > > ---
> > >  v1: Apache 2.0
> > >  v2: MIT
> > >
> > >  scripts/ci/LICENSE               | 7 +++++++
> > >  scripts/ci/fedora-test-runner.sh | 2 +-
> > >  scripts/ci/travis-kvm-setup.sh   | 2 +-
> > >  3 files changed, 9 insertions(+), 2 deletions(-)
> > >  create mode 100644 scripts/ci/LICENSE
> > >
> > > diff --git a/scripts/ci/LICENSE b/scripts/ci/LICENSE
> > > new file mode 100644
> > > index 000000000000..6cd7b7924ef9
> > > --- /dev/null
> > > +++ b/scripts/ci/LICENSE
> > > @@ -0,0 +1,7 @@
> > > +Copyright <YEAR> <COPYRIGHT HOLDER>
>
> You don't actually need them. They are often never updated anyways
> after the initial. I can just drop that line, wget + git add.
>
> >
> > You should probably put an actual year/name here?
> >
> > > +
> > > +Permission is hereby granted, free of charge, to any person obtainin=
g a copy of this software and associated documentation files (the "Software=
"), to deal in the Software without restriction, including without limitati=
on the rights to use, copy, modify, merge, publish, distribute, sublicense,=
 and/or sell copies of the Software, and to permit persons to whom the Soft=
ware is furnished to do so, subject to the following conditions:
> > > +
> > > +The above copyright notice and this permission notice shall be inclu=
ded in all copies or substantial portions of the Software.
> > > +
> > > +THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPR=
ESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABIL=
ITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHAL=
L THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHE=
R LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING F=
ROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS=
 IN THE SOFTWARE.
> > > diff --git a/scripts/ci/fedora-test-runner.sh b/scripts/ci/fedora-tes=
t-runner.sh
> > > index 569723387f6b..0aaba87c421b 100755
> > > --- a/scripts/ci/fedora-test-runner.sh
> > > +++ b/scripts/ci/fedora-test-runner.sh
> > > @@ -1,5 +1,5 @@
> > >  #!/usr/bin/env bash
> > > -
> > > +# SPDX-License-Identifier: MIT
> >
> > As I said in the v1 thread, also the individual files should contain a
> > copyright line in addition to the SPDX line. See:
> > https://matija.suklje.name/how-and-why-to-properly-write-copyright-stat=
ements-in-your-code#why-have-the-copyright-statement
>
> You don't actually need them and they just clutter the code and as a
> policy, I don't participate in adding to the problem of these big
> blocks
> of copyright statements that need to be maintained and grow per
> contributor. I can just drop the SPDX identifiers, as the LICENSE file
> applies to everything.
>
> With version control, the issues as described by that author are less
> of a problem. We can easily
> trace from whom, by how and when code was modified for any legal
> issues if they were to arise.
>
> We can just keep the LICENSE file, drop the SPDX identifiers and I
> would be 100% in-line with that libselinux is currently doing.

I tend to disagree, but I can live with it if you want to leave it
out. So let me ACK this patch and I'll just remove the template
"Copyright" line from the LICENSE file when applying.

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

--=20
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

