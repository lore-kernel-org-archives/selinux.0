Return-Path: <SRS0=ZFtm=DI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACE0C4727C
	for <selinux@archiver.kernel.org>; Thu,  1 Oct 2020 14:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 852F72087D
	for <selinux@archiver.kernel.org>; Thu,  1 Oct 2020 14:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qj55J9d1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732388AbgJAOSs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Oct 2020 10:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732213AbgJAOSr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Oct 2020 10:18:47 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86400C0613D0
        for <selinux@vger.kernel.org>; Thu,  1 Oct 2020 07:18:46 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id z26so5702743oih.12
        for <selinux@vger.kernel.org>; Thu, 01 Oct 2020 07:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kbIib5vT29zFfozxUB2Qj+JDb6XOuMvHdsI1iSWKUaI=;
        b=Qj55J9d19fMG2qJVBQS2/I9XXKbE6nNYzBfUlwcpHQq3Mb/RjeCn6doDUTk82+jOzY
         U7Jx/fvLLZz4D6N0prWkvzXzp5T3M5PTsVYRPT2sN68ENKl9YWhoTGwMxzH0zW+twdtW
         Y0GFtqWj5ApgabBQ3CidHWmWgHFyIug2d6NzOtoBDWYFD6rBIQl0jpfD+prNlWAUMp06
         w+PDK+4+Fem6YL9rcNcOWT1M7HxP2qdEi3ve4gLHqXDHtFB0gEiRrM9XUOMiwOlQGPfn
         F0VqL/MxUFKs17b14MyKZ0voz3vcJSkZIPyoQ8xHnX1EE2I8+zGWFoyZC7jC3jpbqRfa
         UxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kbIib5vT29zFfozxUB2Qj+JDb6XOuMvHdsI1iSWKUaI=;
        b=tSmy6hIaNI186gZrt/yUnycM60/BUaTa8n2FnBkz2NjkgF8UjygHDxEAJzHk1uqMA7
         5PKmnQIGWNKXPUhcM0SP2e54RDjDQb3OZqU0VwVwzt0T4QR8lsnr1bVrjLQQAKLWVxH/
         eyAsc64DPdbwRSkGLKCKMkYysaABJjTGqwzl/5w1A5pKjVZWO2MZ1mtxOyzJ3puSgUBq
         zcx0rfv3Xg1WvSpNN59D7/r4gwmrbTuCnCFQFjbVY4mAU670oLr6WBvpqBrbF7goPCNi
         KYQXmc84GnhNgJH2ZqK6JB2f+KEb2yJ29JARBzGnaSBAWa8lVUNLLwLSq/RMhTT8BZL+
         tshg==
X-Gm-Message-State: AOAM532Y7R4fRZuhXb2KX0I6gJZExUAftp+XXQE9+QPuTVTR8Pa5OtYo
        1Sr+KUeC4G027VcbVQRXUVijYERPGUSdTPXK0tje0BkP
X-Google-Smtp-Source: ABdhPJzP4BnfJ17a9WMCsjvH7nwO4Lin2okUCEDMyStgZzSIU7J5XQ1xXJLwsofLR99OvZJsIC7lPdI0f9Vf5Eq1qOQ=
X-Received: by 2002:aca:44c6:: with SMTP id r189mr138077oia.140.1601561925882;
 Thu, 01 Oct 2020 07:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200930145031.910190-1-plautrba@redhat.com> <20200930145031.910190-4-plautrba@redhat.com>
 <CAEjxPJ6PHe7DqYh6mLGu+mjMLY43r4tbQzoiXH0=wgSuyVSpcw@mail.gmail.com> <20200930155614.GA864960@fedora.redhat.com>
In-Reply-To: <20200930155614.GA864960@fedora.redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 1 Oct 2020 10:18:35 -0400
Message-ID: <CAEjxPJ41ryHsDCnpX7qRLJNw5t=vYX_UEb1z=kW91O10Je6nDA@mail.gmail.com>
Subject: Re: [PATCH 4/4] libsemanage: Bump libsemanage.so version
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 30, 2020 at 11:56 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> On Wed, Sep 30, 2020 at 11:22:21AM -0400, Stephen Smalley wrote:
> > On Wed, Sep 30, 2020 at 10:51 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> > >
> > > It's due to the previous ABI incompatible change
> > >
> > > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> >
> > My only real question is what are the implications for distros for
> > this change?  Would Fedora end up having to carry both so versions for
> > a time?  Or can you cleanly switch from the old to the new without
> > disruption?
> >
>
> Fedora and other distribution will need to temporary ship something like libsepol-compat and
> libsemanage-compat with libsepol.so.1 resp libsemanage.so.1 in order not to
> break buildroots. Also all packages which require so.1, see bellow, will have to
> be rebuilt against so.2
>
> # dnf repoquery --whatrequires libsepol.'so.1()(64bit)'
> libselinux-utils-0:3.1-3.fc34.x86_64
> libsemanage-0:3.1-2.fc33.x86_64
> libsepol-devel-0:3.1-3.fc33.x86_64
> parted-0:3.3-6.fc34.x86_64
> policycoreutils-0:3.1-4.fc33.x86_64
> python3-setools-0:4.3.0-5.fc33.x86_64
> secilc-0:3.1-2.fc33.x86_64
>
> # dnf -C repoquery --whatrequires 'libsemanage.so.1()(64bit)'
> libsemanage-devel-0:3.1-2.fc33.x86_64
> policycoreutils-0:3.1-4.fc33.x86_64
> python3-libsemanage-0:3.1-2.fc33.x86_64
> shadow-utils-2:4.8.1-4.fc33.x86_64
> sssd-common-0:2.3.1-4.fc33.x86_64
> sssd-ipa-0:2.3.1-4.fc33.x86_64
>
> I've experienced with this, builds are available in
> https://copr.fedorainfracloud.org/coprs/plautrba/selinux-fedora/
>
> E.g. for libsemanage, I've added
>
> +%set_build_flags
> +CFLAGS="$CFLAGS -fno-semantic-interposition"
> +sed -i 's/LIBVERSION = 2/LIBVERSION = 1/' src/Makefile
> +%make_build
> +cp src/libsemanage.so.1 ${RPM_BUILD_ROOT}/%{_libdir}/libsemanage.so.1
>
> to the spec file in order to get libsemanage.so.1 which is shipped by
> libsemanage.so.1

The parted dependency looks suspect; seems to be an incorrect linking
with libsepol despite not directly calling any sepol functions.
Aside from that, if we have to bump the so version and deal with
compat packages anyway, should we go ahead and purge all of the other
deprecated functions in libsepol and libsemanage (grep -ri deprecated
libsepol libsemanage)?
