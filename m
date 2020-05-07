Return-Path: <SRS0=z4nS=6V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BBBC38A2A
	for <selinux@archiver.kernel.org>; Thu,  7 May 2020 13:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AC0F2073A
	for <selinux@archiver.kernel.org>; Thu,  7 May 2020 13:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCWnkCYn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgEGNdH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 May 2020 09:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725964AbgEGNdG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 May 2020 09:33:06 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFABC05BD43
        for <selinux@vger.kernel.org>; Thu,  7 May 2020 06:33:05 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id z25so4332517otq.13
        for <selinux@vger.kernel.org>; Thu, 07 May 2020 06:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b5kgmcmd7thpsSXtj1Tx6un0olDopmYbnE+vIHKYoI0=;
        b=kCWnkCYnzrIYTLesWVXMPyXOsBbO51o6wDLhDD5kCV7l1/K2T49zM3ADHy+EcZOAv/
         DarRRKt0YN3agY3cj4y3g4UIOzAOLF8rgc/dODX/mYJKJBhQjZqXoqtOO/evQIrg3oQ1
         cQ+J2vpqZ1FzXpnywTx7xnwBeaFK7skdrN3TgmRurBSicMgpB1REkPW27RwuFSU6uDG/
         YQrIKeJLfSk//vM9rS5gaAAdzKV+/N9NoxYOEYDvho89+XzvuwBs2LbkfewR6sv4A721
         vgd0qiwTDmogGgw9dXUrpRViRdWt2ObydGAl2NEXbOnl8CVMaLijnkG1aUfXwWq1kxce
         CEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b5kgmcmd7thpsSXtj1Tx6un0olDopmYbnE+vIHKYoI0=;
        b=pkpIX8dKyBMdtMpaBOW0dpM+9IUFNSJYKIOpPYwqo3mueFYjom669z/zterS3KM4Wv
         jH3D/nZeAyEfLcMmVo1j7/KOH3EgMitFTsRg2Q0gLYTuRTCIpB06hyzjJEzk2/pkLmY2
         zuon1rEjUJdYI0TkVzEKUPNnkEJ5Iwxg8BOM+1IDqXgrznVbZhXhyXiO/BS6r6T1/iW8
         iXRhR59NmGPbV+MxZqOHYvr5Ns83jnGK1cmfkJcXP03yLhm695EPcoICfabaq9VaMCIu
         5dow6M3GmRB8Wfiq11FYjLwx6225Uqn1BmJp3JPULQEg6nD83jkfBbHWul+LdvVO/2pQ
         i1hw==
X-Gm-Message-State: AGi0PuYkBDa+5dO8WNNoppj7qx56TPoFnGFmIKsNSQW0hAXPHSCIg20q
        ldSMP/c62zgVyJu//1TQQn7BGTBBXShytGEbGjVaMyXV
X-Google-Smtp-Source: APiQypJbUBGIFDULksraOXf1gs5LteqyHgWpuG6ekVTQ5gbTObqtJm1I9e+fH3972n4Ut7oVDY012Xh6K3IF9UXDocE=
X-Received: by 2002:a05:6830:448:: with SMTP id d8mr9787309otc.89.1588858384235;
 Thu, 07 May 2020 06:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200506005339.13641-1-stephen.smalley.work@gmail.com>
 <CAFftDdrD-FJ8wBk=XOkvdnkvA5o10w5pJs31H9dEhtW1zU8EHA@mail.gmail.com>
 <CAEjxPJ452zaoFwy++cKqh_Ap2rM1ezEZN83mBhN4ndHHaQ4q5Q@mail.gmail.com>
 <3838641.zh4Wi6GlAV@liv> <cf747e50-ca5b-429f-1af2-afaa16ee29be@debian.org>
 <CAEjxPJ6Uo83L5C9UELy5w_V2wuptSHiHoMMLN4oh75x70-ZzAQ@mail.gmail.com> <20200507131322.GA69292@workstation>
In-Reply-To: <20200507131322.GA69292@workstation>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 7 May 2020 09:32:53 -0400
Message-ID: <CAEjxPJ7_Gb=9kFpizkRoEn9f27qVkXZPxd8KJnezjg9G4T1VbA@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: update to work on Debian
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Laurent Bigonville <bigon@debian.org>,
        Russell Coker <russell@coker.com.au>,
        William Roberts <bill.c.roberts@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 7, 2020 at 9:13 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> On Thu, May 07, 2020 at 08:51:59AM -0400, Stephen Smalley wrote:
> > On Thu, May 7, 2020 at 4:46 AM Laurent Bigonville <bigon@debian.org> wr=
ote:
> > >
> > > Le 6/05/20 =C3=A0 18:37, Russell Coker a =C3=A9crit :
> > > > On Thursday, 7 May 2020 1:50:46 AM AEST Stephen Smalley wrote:
> > > >> on that running instance, but not to specify custom kernel paramet=
ers
> > > >> initially or to reboot the system before proceeding with further
> > > >> commands (if anyone knows differently, speak up). We'd have to get=
 to
> > > >> the point where enabling SELinux in Debian is possible without
> > > >> requiring a reboot at all.  And then we'd have to wait for that
> > > >> support to find its way into one of the Ubuntu images supported by
> > > >> travis-ci.  Might be easier to just get travis-ci to support Fedor=
a or
> > > >> CentOS images in the first place. Regardless, allowing the testsui=
te
> > > >> to be run by users of other distributions is worthwhile IMHO.
> > > > In the past there hasn't been much demand for a smoother installati=
on process.
> > > > If you are setting up a traditional Unix server system the Debian S=
E Linux
> > > > installation thing doesn't make things much more difficult.  Past c=
omplaints
> > > > about it have been more about an imagined difficulty of using SE Li=
nux and have
> > > > ended when I showed and wrote about how to do it (one time I showed
> > > > screenshots of the process in an LCA lightning talk and didn't have=
 problems
> > > > with time).
> > > >
> > > > I don't think that the people who maintain the Debian installation =
related
> > > > packages would have a great objection to adding SE Linux features, =
although it
> > > > might take a bit of time for it to migrate from Debian to Ubuntu.
> > > >
> > > > We can make this a priority.
> > > >
> > > If people are using preseed installations (kickstart equivalent), I
> > > think that enabling SELinux in the installer shouldn't be too difficu=
lt
> > > (installing the needed packages, modifying the files and relabeling w=
ith
> > > fixfiles). It's obviously not user friendly, but the question is what=
's
> > > the target here.
> >
> > The visionary end state goal would be to allow one to specify some
> > kind of option in a travis-ci configuration and get a SELinux-enabled
> > image on which we could perform travis-ci validation of
> > selinux-testsuite, selinux userspace, and maybe even the kernel.  I
> > don't think that is possible in the near term though and will require
> > changes to travis-ci itself.  At the moment our travis-ci validation
> > of the testsuite and userspace is limited to building and in the
> > latter case running some limited tests that do not depend on having
> > SELinux on the host.
> >
> > The nearer term goal is to minimize obstacles to using SELinux in
> > Debian, one of which is the need to install Debian and then install
> > SELinux as a separate step (with two reboots along the way) rather
> > than an installer option.  We can't use that approach in travis-ci
> > AFAICT because we cannot reboot the instance and then proceed with
> > testing.  If we can tell the installer to include the necessary grub
> > and pam configurations up front and to label the filesystems during
> > installation (which can happen even while SELinux is disabled in the
> > kernel; only requires filesystem xattr support), then we can avoid the
> > need for any extra reboots post install.
> >
>
> I'm experimenting with using Fedora CI for this, see https://src.fedorapr=
oject.org/rpms/policycoreutils/pull-request/15
>
> It uses Fedora Rawhide images and runs
> https://src.fedoraproject.org/fork/plautrba/rpms/policycoreutils/blob/a96=
22b610a0f7cfb968d4cb216c9c5c42e87b6dd/f/tests/upstream/runtest.sh
> script which is part of this PR
>
>
> You can see a failure in Fedora CI:
> https://jenkins-continuous-infra.apps.ci.centos.org/blue/organizations/je=
nkins/fedora-rawhide-pr-pipeline/detail/fedora-rawhide-pr-pipeline/3441/pip=
eline/
> -> Artifacts -> package-tests/logs/FAIL-upstream.log -
> https://jenkins-continuous-infra.apps.ci.centos.org/job/fedora-rawhide-pr=
-pipeline/3441/artifact/package-tests/logs/FAIL-upstream.log
>
> So far there's only userspace build and tests but it can be used for
> selinux-testsuite and (Fedora) kernel.
>
> It has one downside, it can be triggered only by a pull request on https:=
//src.fedoraproject.org/rpms/policycoreutils

Interesting, thanks.  Regrettably the make test cases in the userspace
tree are fairly limited (and can't be too extensive if they are going
to keep working on travis-ci since they cannot presume SELinux in the
host).  In practice, I usually also test changes to the userspace by
running the selinux-testsuite, which exercises rebuilding policy and
confirms various runtime behaviors that are not exercised by the
userspace make test, and by rebuilding refpolicy (or Fedora policy
would also work) and comparing against what the previous version
yielded.  We also likely ought to be re-testing setools upon changes
to the userspace and vice versa.  They are all rather intertwined.
