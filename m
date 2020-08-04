Return-Path: <SRS0=dV66=BO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFF5C433DF
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 14:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBC542065C
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 14:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpOta0OR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgHDOhB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbgHDOgu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Aug 2020 10:36:50 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BF2C06174A
        for <selinux@vger.kernel.org>; Tue,  4 Aug 2020 07:36:50 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id y18so25931925ilp.10
        for <selinux@vger.kernel.org>; Tue, 04 Aug 2020 07:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3kb4xC5dQIZYE3/a8KKbjB+g0yzajCOqNT3jTdxe8Ic=;
        b=ZpOta0OR+G14EO15E4KeHxKR1CyeDmtgnDOnnBb2QOZkQPV/ze5RuGE/Sd4MbFGCdv
         ekVVcM35Y9ZWNtok8fC7AOa+FsGtYwmyDNUzOKRhcDeS5YQ5ukHlzfuY7Wh8hnoZOOzO
         SFs8dJkx7IN7dlYAsEItWUzXrnibYk+WjietucKaQ0LvQRG2IsHsO3XWq8ZBGJGAf9A0
         fXFgKVvq+gAbUzenaM5e81oqgpB/ziSrgaYIzmJWJhSOR0UaCvJDwc0uIr/DPUErI6K3
         92OOr8MfvnZ4uXc8zDnn5caNISjIYQIVZgKqhPwrOjRBvtpHLBmEPmBrMQieYw8HcjEe
         Xc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3kb4xC5dQIZYE3/a8KKbjB+g0yzajCOqNT3jTdxe8Ic=;
        b=X0TEyJjtRS4qMRp5q0Ncj1Ni5jRDIaAUs4i3VrLdj17vgmJ/S4T1dZiW0HCQok0vVw
         g+sdQUfCyNKA6Xi7ZyGz+eiDsCk2wKWGRz9x+GiszNEsJYNTW7N1GPKe1JHdKSIyhhGW
         wlV/k1Z5XPsafY9F1p3nc/jBRnngWTtSiF3nmlLX/0DSTIMaJ/Y/XzCupbffl11W3cas
         VL8IcuAo2fGwZ54ogTsVDXNGkOXAbi/0S/iL/WFu79z4BG16Pz2NidGPww8nss939MOi
         v3sZSsBTp50JIObwIF7KNkmi7ry/xE9KPhDwet+iQ72PNH3J8ojyPaNn0InO4em/0EjW
         IGAw==
X-Gm-Message-State: AOAM533zvsHnwOU+T8PtsciG/v//+KjHTCXKM657t/tD4CQaaTFtJEWU
        gl3iRxJluG34opondGH2vzMlxgMcNrr0SNbiR70=
X-Google-Smtp-Source: ABdhPJzduKLyL5o8OibILBxQOcCimhwIOXhFv8Ni01Bges9MdxHFL/BAe/JfXfKoWIMDti8ntP3FGtpTbbI2mBonJQA=
X-Received: by 2002:a05:6e02:1213:: with SMTP id a19mr5026482ilq.129.1596551809429;
 Tue, 04 Aug 2020 07:36:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAFqZXNvh9q4qTSN-Fj108JrO8DAfMiDkOzTDHs6n3Pxg+DOtXg@mail.gmail.com>
 <20200803151428.15166-1-william.c.roberts@intel.com> <CAFqZXNtTZio0-9_T9yheg0JmUP-TDa2OsUkgvHrNphGCrjhMVg@mail.gmail.com>
 <CAFftDdpwud0FtuaoUE1ABgYtMwr3+kcF-hww88+eDHdz5oGLSw@mail.gmail.com> <CAFqZXNtVeUZWt99_SY+AYYLgTKqAw0rfs8TY5oN-fpKv8f1vqA@mail.gmail.com>
In-Reply-To: <CAFqZXNtVeUZWt99_SY+AYYLgTKqAw0rfs8TY5oN-fpKv8f1vqA@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Tue, 4 Aug 2020 09:36:37 -0500
Message-ID: <CAFftDdoye_BgA24w8R67x4NWTATovT5-4zdx-k3QR=J1gEypbQ@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/ci: license as MIT
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        "Roberts, William C" <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Sounds good.

On Tue, Aug 4, 2020 at 9:35 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Mon, Aug 3, 2020 at 6:44 PM William Roberts <bill.c.roberts@gmail.com>=
 wrote:
> > On Mon, Aug 3, 2020 at 11:31 AM Ondrej Mosnacek <omosnace@redhat.com> w=
rote:
> > >
> > > On Mon, Aug 3, 2020 at 5:14 PM <bill.c.roberts@gmail.com> wrote:
> > > > From: William Roberts <william.c.roberts@intel.com>
> > > >
> > > > License the ci scripts with a permissive, OSI approved license, suc=
h as
> > > > MIT.
> > > >
> > > > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > > > ---
> > > >  v1: Apache 2.0
> > > >  v2: MIT
> > > >
> > > >  scripts/ci/LICENSE               | 7 +++++++
> > > >  scripts/ci/fedora-test-runner.sh | 2 +-
> > > >  scripts/ci/travis-kvm-setup.sh   | 2 +-
> > > >  3 files changed, 9 insertions(+), 2 deletions(-)
> > > >  create mode 100644 scripts/ci/LICENSE
> > > >
> > > > diff --git a/scripts/ci/LICENSE b/scripts/ci/LICENSE
> > > > new file mode 100644
> > > > index 000000000000..6cd7b7924ef9
> > > > --- /dev/null
> > > > +++ b/scripts/ci/LICENSE
> > > > @@ -0,0 +1,7 @@
> > > > +Copyright <YEAR> <COPYRIGHT HOLDER>
> >
> > You don't actually need them. They are often never updated anyways
> > after the initial. I can just drop that line, wget + git add.
> >
> > >
> > > You should probably put an actual year/name here?
> > >
> > > > +
> > > > +Permission is hereby granted, free of charge, to any person obtain=
ing a copy of this software and associated documentation files (the "Softwa=
re"), to deal in the Software without restriction, including without limita=
tion the rights to use, copy, modify, merge, publish, distribute, sublicens=
e, and/or sell copies of the Software, and to permit persons to whom the So=
ftware is furnished to do so, subject to the following conditions:
> > > > +
> > > > +The above copyright notice and this permission notice shall be inc=
luded in all copies or substantial portions of the Software.
> > > > +
> > > > +THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EX=
PRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTAB=
ILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SH=
ALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALIN=
GS IN THE SOFTWARE.
> > > > diff --git a/scripts/ci/fedora-test-runner.sh b/scripts/ci/fedora-t=
est-runner.sh
> > > > index 569723387f6b..0aaba87c421b 100755
> > > > --- a/scripts/ci/fedora-test-runner.sh
> > > > +++ b/scripts/ci/fedora-test-runner.sh
> > > > @@ -1,5 +1,5 @@
> > > >  #!/usr/bin/env bash
> > > > -
> > > > +# SPDX-License-Identifier: MIT
> > >
> > > As I said in the v1 thread, also the individual files should contain =
a
> > > copyright line in addition to the SPDX line. See:
> > > https://matija.suklje.name/how-and-why-to-properly-write-copyright-st=
atements-in-your-code#why-have-the-copyright-statement
> >
> > You don't actually need them and they just clutter the code and as a
> > policy, I don't participate in adding to the problem of these big
> > blocks
> > of copyright statements that need to be maintained and grow per
> > contributor. I can just drop the SPDX identifiers, as the LICENSE file
> > applies to everything.
> >
> > With version control, the issues as described by that author are less
> > of a problem. We can easily
> > trace from whom, by how and when code was modified for any legal
> > issues if they were to arise.
> >
> > We can just keep the LICENSE file, drop the SPDX identifiers and I
> > would be 100% in-line with that libselinux is currently doing.
>
> I tend to disagree, but I can live with it if you want to leave it
> out. So let me ACK this patch and I'll just remove the template
> "Copyright" line from the LICENSE file when applying.
>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> --
> Ondrej Mosnacek
> Software Engineer, Platform Security - SELinux kernel
> Red Hat, Inc.
>
