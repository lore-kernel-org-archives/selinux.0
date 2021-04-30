Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8269BC433B4
	for <selinux@archiver.kernel.org>; Fri, 30 Apr 2021 12:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5805261477
	for <selinux@archiver.kernel.org>; Fri, 30 Apr 2021 12:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbhD3Mls (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Apr 2021 08:41:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26904 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232974AbhD3Mks (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Apr 2021 08:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619786399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=97B74o1cR1B0ddqM5EK4cE+tc2y9fDKRFbhbhA3esSs=;
        b=EblnJewxxVF/EOaTqTqFUh9BJhTquKVNh1OELVjsVPRNlmkLngC5YfTWLpJFqyT+trzO8A
        uMU75aqUWDWVJaqHqIHZQAoEKfXNOOxX/CJn+TF6AwosHnvU0lWLji2RrqPTIGJHZxCt05
        q968n4B573lLyDj1uJ5Hg7tcplPLf68=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-kvhyE9YANn6ZHgUB2Rgljg-1; Fri, 30 Apr 2021 08:39:45 -0400
X-MC-Unique: kvhyE9YANn6ZHgUB2Rgljg-1
Received: by mail-yb1-f198.google.com with SMTP id u3-20020a2509430000b02904e7f1a30cffso49658704ybm.8
        for <selinux@vger.kernel.org>; Fri, 30 Apr 2021 05:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=97B74o1cR1B0ddqM5EK4cE+tc2y9fDKRFbhbhA3esSs=;
        b=BvpEL901OkMpUlf3n7Mvne6dt7ijVu0MvPqc6cg9EAVQu0CuqbF6wnW4nnFcKCQMFY
         fdsfYhrVKGmG2Riki7Xrq35bY5B6BXRbuqZoX6ct3PtP+/1bsW+ZKC77taiYcb6O1iRE
         42ORD226LxdPGLxRr37NGkb8Z7mdE83FkKGX9jSxUFlyABQiXG6htAzG3KyW78isetLE
         eaq5C7IftlW1Q9kTdIxB8X5zFLOqSWcNB9/UD+mzeCID4Pqka8JTE2qYUvh5M9OYl6bM
         DTyeA8Q4SzAzWumhC8PSqiEGONBDdyelIx41ePT30CtN6ulaCKZnPEwIPJDf0vmzMfYY
         r7Yw==
X-Gm-Message-State: AOAM533kMiqjpI4IQslxYjNKeYJ2sMcTrRgOTW9rGF79G8HglK4C752H
        er1UD31spNHgK23K2v0kBFQXn21dh9GuxwDoKUL3qGV1HBbXMRUrb4ZnfF1LfGsUdExO4Tg+0yO
        CypA7+0rLftkWTBrW5dWgx/n+loWogBA1ZA==
X-Received: by 2002:a25:d090:: with SMTP id h138mr6391243ybg.227.1619786385229;
        Fri, 30 Apr 2021 05:39:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUA6dqSZqgozs1yxD9EIIC/FIdEzAJQkWuM9bZZhWh4GYruJOXCLxMSuw0QDaNXWtc2/oNpjqnfLcLU3g6Y7Q=
X-Received: by 2002:a25:d090:: with SMTP id h138mr6391208ybg.227.1619786384959;
 Fri, 30 Apr 2021 05:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210430091119.607754-1-omosnace@redhat.com> <87bl9wyphu.fsf@defensec.nl>
In-Reply-To: <87bl9wyphu.fsf@defensec.nl>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 30 Apr 2021 14:39:33 +0200
Message-ID: <CAFqZXNvnzsfiXxfcgo-pjzi=3iKeN7k0YkFX6C=j2y_8nxkytQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] policy: only define anon_inode class if not
 defined in system policy
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Apr 30, 2021 at 1:35 PM Dominick Grift
<dominick.grift@defensec.nl> wrote:
> Ondrej Mosnacek <omosnace@redhat.com> writes:
>
> > When the system policy already defines this class, loading the test
> > policy fails with:
> >
> > Re-declaration of class anon_inode
> > Previous declaration of class at /var/lib/selinux/targeted/tmp/modules/100/base/cil:1003
> > Bad class declaration at /var/lib/selinux/targeted/tmp/modules/400/test_userfaultfd/cil:2
> > /usr/sbin/semodule:  Failed!
> >
> > Fix this by only including the anon_inode class declarations when it's
> > not found in the system policy headers.
>
> Reference policy does not have a "all_perms.spt" AFAIK. This might only work
> with Fedora.

Could be, but this pattern is already used elsewhere in the testsuite,
so for now this'll have to do...

>
> >
> > Fixes: 2ea007924363 ("selinux-testsuite: Add userfaultfd test")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  policy/Makefile                  | 3 +++
> >  policy/test_anon_inode_class.cil | 4 ++++
> >  policy/test_userfaultfd.cil      | 5 -----
> >  3 files changed, 7 insertions(+), 5 deletions(-)
> >  create mode 100644 policy/test_anon_inode_class.cil
> >
> > diff --git a/policy/Makefile b/policy/Makefile
> > index 91364d5..dee55a2 100644
> > --- a/policy/Makefile
> > +++ b/policy/Makefile
> > @@ -39,6 +39,9 @@ ifeq ($(SUPPORTS_CIL),y)
> >  CIL_TARGETS = test_mlsconstrain.cil test_overlay_defaultrange.cil
> >  # userfaultfd test policy uses also xperms
> >  ifeq ($(shell [ $(MOD_POL_VERS) -ge 18 -a $(MAX_KERNEL_POLICY) -ge 30 ] && echo true),true)
> > +ifneq ($(shell grep -q anon_inode $(POLDEV)/include/support/all_perms.spt && echo true),true)
> > +CIL_TARGETS += test_anon_inode_class.cil
> > +endif
> >  CIL_TARGETS += test_userfaultfd.cil
> >  TARGETS += test_userfaultfd.te
> >  endif
> > diff --git a/policy/test_anon_inode_class.cil b/policy/test_anon_inode_class.cil
> > new file mode 100644
> > index 0000000..3e36599
> > --- /dev/null
> > +++ b/policy/test_anon_inode_class.cil
> > @@ -0,0 +1,4 @@
> > +; Define new class anon_inode
> > +(class anon_inode ())
> > +(classcommon anon_inode file)
> > +(classorder (unordered anon_inode))
> > diff --git a/policy/test_userfaultfd.cil b/policy/test_userfaultfd.cil
> > index 18d5f3f..f6a6791 100644
> > --- a/policy/test_userfaultfd.cil
> > +++ b/policy/test_userfaultfd.cil
> > @@ -1,8 +1,3 @@
> > -; Define new class anon_inode
> > -(class anon_inode ())
> > -(classcommon anon_inode file)
> > -(classorder (unordered anon_inode))
> > -
> >  ; Allow all anonymous inodes
> >  (typeattributeset cil_gen_require test_notransition_uffd_t)
> >  (allow test_notransition_uffd_t self (anon_inode (create getattr ioctl read)))
>
> --
> gpg --locate-keys dominick.grift@defensec.nl
> Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
> Dominick Grift
>


-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

