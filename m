Return-Path: <SRS0=LgiC=ZT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC98C432C0
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 15:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F7220665
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 15:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i8fh8mhK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfK0Pjy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:39:54 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40842 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726634AbfK0Pjx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Nov 2019 10:39:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574869193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ic8EIKHDRlp0CYlWwj0vqQnIPCm7Fivr4Alyj5CP0I=;
        b=i8fh8mhKwzPv9b8cpv7C+Z37QeluHyxbXiT6Tz+ZaU4GwzdKoEctqYG119jVt4YjEyx7+n
        vgHqcnzEMAmPkbb5U20JJzgz4Y7HmDZZpVYVR/YWv1Kj6VVsg5S19LvAsQTLL24OLXgTok
        0fKRJ4SXLIM92Smqcy44NiQ4Vt2zSLk=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-SDRNUbeZMDiiAX9okR7U4w-1; Wed, 27 Nov 2019 10:39:51 -0500
Received: by mail-oi1-f200.google.com with SMTP id b5so639765oii.8
        for <selinux@vger.kernel.org>; Wed, 27 Nov 2019 07:39:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sHXModGOm/dayXjsn/7Ja8I1YLMOU4ZNV5w8YxG9tUc=;
        b=eB0/eoeukN2LD8/XAYBjJYHgFG8kKNNmek3m6XhIYfot2J5uPxcyEMwrVSGuBxu0bq
         D8HuDuNwHysnKmKN4pXKcfMg5kyQdFc1ZchLW1FVixA0v19YmayZZoohdfYnc+7EBRVf
         gncJtLpsuMc++4NDMCtbF3qFcWhOllSbzi0FOqbH8OneqauvuDoeXQqPpWLgBpws4+GA
         11hGsR2mcGKmbfdpCG6ZPikDc596C2WpoJm9K4taAioxPgPkZI/wP88Nv2hnev3x4J6J
         DPFJAbeItWZyDru0Z19YRTZM4JirK7y3pcLhdq7PsEfgGx/mLwcnr/xFEcAOV2XcFisi
         HA+Q==
X-Gm-Message-State: APjAAAVDZAxa+WzSOKm/IhGCmYPL7SaKj6QZWzQvoddJmKRjgp3fdX05
        bLTEO9WLGgadArp+ePV81a4tJM08/eRDWqc0oXPlUAqVTr1IDUSepjhtzgWl1lc8pHiQcFCEKc0
        wYjXhgq+dAEZ9hz0d6/IqyU30RUoODgM3cA==
X-Received: by 2002:a9d:6e83:: with SMTP id a3mr3894237otr.367.1574869190889;
        Wed, 27 Nov 2019 07:39:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqyPfkF2mO+u9PuvwGWO7lToyq+2VdHtVvrxLiro3kAGIJfw6l+qqN+efR69T53X/oX2tOeJNrKUGNBUw6NelMU=
X-Received: by 2002:a9d:6e83:: with SMTP id a3mr3894212otr.367.1574869190499;
 Wed, 27 Nov 2019 07:39:50 -0800 (PST)
MIME-Version: 1.0
References: <157486604069.70468.14139138243381994891.stgit@chester>
 <CAFqZXNs5jcOOnhzT8=DQgzaf9RtBZ1=oqTU83pjVLMqPb-rzHA@mail.gmail.com> <574b6648-8698-65e0-23c4-5ddb096b36c6@tycho.nsa.gov>
In-Reply-To: <574b6648-8698-65e0-23c4-5ddb096b36c6@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 27 Nov 2019 16:39:53 +0100
Message-ID: <CAFqZXNtm3H02aFTinZ0OGtezFdVJ66dQV9YXx2ABm-3z-UtWoQ@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: update the dependencies in README.md
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
X-MC-Unique: SDRNUbeZMDiiAX9okR7U4w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 27, 2019 at 4:24 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 11/27/19 10:21 AM, Ondrej Mosnacek wrote:
> > On Wed, Nov 27, 2019 at 3:47 PM Paul Moore <paul@paul-moore.com> wrote:
> >> From: Paul Moore <paul@paul-moore.com>
> >>
> >> The new kernel module tests added in a68d583c2a70 ("selinux-testsuite:
> >> Add kernel module tests") require the kernel-devel package on Fedora,
> >> make sure we list that in the README.md file.
> >
> > Thanks, I should have thought of this when reviewing the patch :)
> >
> >>
> >> Signed-off-by: Paul Moore <paul@paul-moore.com>
> >> ---
> >>   README.md |    4 +++-
> >>   1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/README.md b/README.md
> >> index e845df8..4352796 100644
> >> --- a/README.md
> >> +++ b/README.md
> >> @@ -53,6 +53,7 @@ similar dependencies):
> >>   * attr _(tools used by the overlayfs tests)_
> >>   * libbpf-devel _(tools used by the bpf tests)_
> >>   * keyutils-libs-devel _(tools used by the keys tests)_
> >> +* kernel-devel _(used by the kernel module tests)_
> >>
> >>   On a modern Fedora system you can install these dependencies with th=
e
> >>   following command:
> >> @@ -69,7 +70,8 @@ following command:
> >>                  lksctp-tools-devel \
> >>                  attr \
> >>                  libbpf-devel \
> >> -               keyutils-libs-devel
> >> +               keyutils-libs-devel \
> >> +               kernel-devel
> >
> > I'm wondering whether we should rather put kernel-devel-$(uname -r)
> > here, to make sure that the right package is installed that
> > corresponds to the running kernel version (which may not be the latest
> > version that dnf will fetch). Or if the use of shell expansion feels
> > too clever, then we should at last document that the command may not
> > always install the version that is needed.
>
> I'm often testing kernels I build myself and not via rpm.

Right, then the command would just fail... :/ But it might be slightly
faster to realize that you can just delete the kernel-devel line from
the command when you're running a local kernel build, than figuring
out why the test failed to build after a successful run of the command
(in the non-latest stock kernel scenario). But I'm fine with just
documenting it if we want to keep it simple.

>
> >
> >>
> >>   The testsuite requires a pre-existing base policy configuration of S=
ELinux,
> >>   using either the old example policy or the reference policy as the b=
aseline.
> >
> > --
> > Ondrej Mosnacek <omosnace at redhat dot com>
> > Software Engineer, Security Technologies
> > Red Hat, Inc.

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

