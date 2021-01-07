Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E21C433E0
	for <selinux@archiver.kernel.org>; Thu,  7 Jan 2021 10:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E58092313B
	for <selinux@archiver.kernel.org>; Thu,  7 Jan 2021 10:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbhAGKVH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Jan 2021 05:21:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21648 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726326AbhAGKVG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 Jan 2021 05:21:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610014778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4+9jQIgcF2CPiEhTHN8UP/cKCNMW1TuW5ZhZMir82F4=;
        b=iWIaA844gYNn2PPKuQOTZT3Ag8My4Z7N0mRzqf6789I9THi841EnmOjzOoExkNrRl8pcTZ
        o8p+0yKJUhsz03J6P6XoY0yziigG0FGnhtZBwcAHS2IYGOCkuwWv37DFOMaYDHXgRrw4SU
        /zJTgLSh2SRVXBC1NB4nGW6LvcjlQBU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-xgFRcUaZO32zw6HiKLepdw-1; Thu, 07 Jan 2021 05:19:36 -0500
X-MC-Unique: xgFRcUaZO32zw6HiKLepdw-1
Received: by mail-lf1-f72.google.com with SMTP id x186so6136665lff.7
        for <selinux@vger.kernel.org>; Thu, 07 Jan 2021 02:19:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4+9jQIgcF2CPiEhTHN8UP/cKCNMW1TuW5ZhZMir82F4=;
        b=K/WaJhJedssnALDuinvG+dIODFqZ9DNACe4AXudPQFHH+jHojbKpqO39HCW0rk/cgS
         LUQHFv5G9AVnbVr2gOj4LJJpXt5QMFsasZq3guR6/A30W1YjvKSLDvYPJQAUnb3art9G
         fzz6XZdBJVz9T8JpZYCBt49MY6vF7aym/GiRdi2ZCzerqDtlpgck+iOpVIXnvjXR/xOq
         M4YuBlZ672zXrvjdotJw04uD/Exe5Uy8O0khMeUelylSRBShkH1K6b2JNc8c+L9DKrwt
         MlcnJH+XG68kn1PLR0JqxQ2qSbrOpM3QvEu84tkp7YDcGgWPsf6YK4XTp714/yelSpyX
         irhQ==
X-Gm-Message-State: AOAM532lh3214KCNRyApsluUpBLxMB5ucMXwpsmPRIrUK3/LCfZDZKEB
        VYEeCRssrZjFbpuKpP8xK23FPkgdz2FCuKduUkfH4FNyseOrjV4uAIbesRp/wtrhZOEo4VB1c45
        +qJk7ENpzlBm51L9bCXQoNNCr/6w3nIvLtw==
X-Received: by 2002:a2e:96d8:: with SMTP id d24mr3773984ljj.62.1610014775288;
        Thu, 07 Jan 2021 02:19:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxffoTr/LNvFqPai1Vx5tAdyUDagcI0+RZPyEa/Fw1GwGyNq7o4fXtrd9ksQv0qhtqTgPC1Mrx9YJgd+GRBcoU=
X-Received: by 2002:a2e:96d8:: with SMTP id d24mr3773970ljj.62.1610014774973;
 Thu, 07 Jan 2021 02:19:34 -0800 (PST)
MIME-Version: 1.0
References: <20201211230119.1818009-1-lokeshgidra@google.com>
 <CAFqZXNspYbKxmqyeEjLg-zsgrvLEJ86a9OGLwYU7TFWpfHnOyA@mail.gmail.com> <CA+EESO4Snwu-OvRvnp-HVy7ajR1u536WYu_c3eq1eCbhabvk+A@mail.gmail.com>
In-Reply-To: <CA+EESO4Snwu-OvRvnp-HVy7ajR1u536WYu_c3eq1eCbhabvk+A@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 7 Jan 2021 11:19:18 +0100
Message-ID: <CAFqZXNt+RFjrCs2fPdpfjHYNtoBwVOQeEHa=k=ZUG0m5nSLAEQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] selinux-testsuite: Add userfaultfd test
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Calin Juravle <calin@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 7, 2021 at 7:48 AM Lokesh Gidra <lokeshgidra@google.com> wrote:
> On Wed, Jan 6, 2021 at 2:01 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Sat, Dec 12, 2020 at 12:01 AM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > >
> > > Confirm SELinux policies are enforced on userfaultfd operations
> > > via secure anon-inode interface.
> > >
> > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > > ---
> > >  policy/Makefile                 |   4 +-
> > >  policy/test_userfaultfd.cil     |  52 ++++++++++
> > >  policy/test_userfaultfd.te      |  49 +++++++++
> > >  tests/Makefile                  |   2 +-
> > >  tests/userfaultfd/Makefile      |   5 +
> > >  tests/userfaultfd/test          |  39 +++++++
> > >  tests/userfaultfd/userfaultfd.c | 175 ++++++++++++++++++++++++++++++++
> > >  7 files changed, 323 insertions(+), 3 deletions(-)
> > >  create mode 100644 policy/test_userfaultfd.cil
> > >  create mode 100644 policy/test_userfaultfd.te
> > >  create mode 100644 tests/userfaultfd/Makefile
> > >  create mode 100755 tests/userfaultfd/test
> > >  create mode 100644 tests/userfaultfd/userfaultfd.c
> >
> > Thanks, this looks very good! I have just a few minor comments below.
> >
> > First nit: There are some whitespace issues with your patch:
> > ```
> > $ curl https://patchwork.kernel.org/series/400871/mbox/ | git am
> > [...]
> > .git/rebase-apply/patch:318: trailing whitespace.
> >
> > .git/rebase-apply/patch:381: space before tab in indent.
> >     // Create a thread that will process the userfaultfd events
> > .git/rebase-apply/patch:388: trailing whitespace.
> >
> >  warning: 3 lines add whitespace errors.
> >  Applying: selinux-testsuite: Add userfaultfd test
> > ```
> >
> > >
> > > diff --git a/policy/Makefile b/policy/Makefile
> > > index 6c49091..3e00875 100644
> > > --- a/policy/Makefile
> > > +++ b/policy/Makefile
> > > @@ -29,14 +29,14 @@ TARGETS = \
> > >         test_task_getsid.te test_task_setpgid.te test_task_setsched.te \
> > >         test_transition.te test_unix_socket.te \
> > >         test_mmap.te test_overlayfs.te test_mqueue.te \
> > > -       test_ibpkey.te test_atsecure.te test_cgroupfs.te
> > > +       test_ibpkey.te test_atsecure.te test_cgroupfs.te test_userfaultfd.te
> > >
> > >  ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
> > >  SUPPORTS_CIL = n
> > >  endif
> > >
> > >  ifeq ($(SUPPORTS_CIL),y)
> > > -CIL_TARGETS = test_mlsconstrain.cil test_overlay_defaultrange.cil
> > > +CIL_TARGETS = test_mlsconstrain.cil test_overlay_defaultrange.cil test_userfaultfd.cil
> > >  ifeq ($(shell [ $(MAX_KERNEL_POLICY) -ge 32 ] && echo true),true)
> > >  ifeq ($(shell [ $(POL_VERS) -ge 32 ] && echo true),true)
> > >  # If other MLS tests get written this can be moved outside of the glblub test
> > > diff --git a/policy/test_userfaultfd.cil b/policy/test_userfaultfd.cil
> > > new file mode 100644
> > > index 0000000..b0f44af
> > > --- /dev/null
> > > +++ b/policy/test_userfaultfd.cil
> > > @@ -0,0 +1,52 @@
> > > +; Define new class anon_inode
> > > +(class anon_inode ())
> > > +(classcommon anon_inode file)
> > > +(classorder (unordered anon_inode))
> > > +
> > > +; Allow all anonymous inodes
> > > +(typeattributeset cil_gen_require test_notransition_uffd_t)
> > > +(allow test_notransition_uffd_t self (anon_inode (create getattr ioctl read)))
> > > +
> > > +(typeattributeset cil_gen_require uffd_t)
> > > +
> > > +; Allow all operations on UFFD
> > > +(typeattributeset cil_gen_require test_uffd_t)
> > > +(typetransition test_uffd_t test_uffd_t anon_inode "[userfaultfd]"    uffd_t)
> > > +(allow test_uffd_t uffd_t (anon_inode (create getattr ioctl read)))
> > > +
> > > +; Don't allow any operation on UFFD
> > > +(typeattributeset cil_gen_require test_nocreate_uffd_t)
> > > +(typetransition test_nocreate_uffd_t test_nocreate_uffd_t anon_inode "[userfaultfd]"    uffd_t)
> > > +
> > > +; Don't allow getattr operation on UFFD
> > > +(typeattributeset cil_gen_require test_nogetattr_uffd_t)
> > > +(typetransition test_nogetattr_uffd_t test_nogetattr_uffd_t anon_inode "[userfaultfd]"    uffd_t)
> > > +(allow test_nogetattr_uffd_t uffd_t (anon_inode (create)))
> > > +
> > > +; Don't allow any ioctl operation on UFFD
> > > +(typeattributeset cil_gen_require test_noioctl_uffd_t)
> > > +(typetransition test_noioctl_uffd_t test_noioctl_uffd_t anon_inode "[userfaultfd]"    uffd_t)
> > > +(allow test_noioctl_uffd_t uffd_t (anon_inode (create getattr)))
> > > +
> > > +; Only allow UFFDIO_API ioctl
> > > +(typeattributeset cil_gen_require test_api_ioctl_uffd_t)
> > > +(typetransition test_api_ioctl_uffd_t test_api_ioctl_uffd_t anon_inode "[userfaultfd]"    uffd_t)
> > > +(allow test_api_ioctl_uffd_t uffd_t (anon_inode (create getattr ioctl read)))
> > > +(allowx test_api_ioctl_uffd_t uffd_t (ioctl anon_inode ((0xaa3f))))
> > > +
> > > +; Only allow UFFDIO_API and UFFDIO_REGISTER ioctls
> > > +(typeattributeset cil_gen_require test_register_ioctl_uffd_t)
> > > +(typetransition test_register_ioctl_uffd_t test_register_ioctl_uffd_t anon_inode "[userfaultfd]"    uffd_t)
> > > +(allow test_register_ioctl_uffd_t uffd_t (anon_inode (create getattr ioctl read)))
> > > +(allowx test_register_ioctl_uffd_t uffd_t (ioctl anon_inode ((0xaa3f 0xaa00))))
> > > +
> > > +; Only allow UFFDIO_API, UFFDIO_REGISTER and UFFDIO_COPY ioctls, which are most used.
> > > +(typeattributeset cil_gen_require test_copy_ioctl_uffd_t)
> > > +(typetransition test_copy_ioctl_uffd_t test_copy_ioctl_uffd_t anon_inode "[userfaultfd]"    uffd_t)
> > > +(allow test_copy_ioctl_uffd_t uffd_t (anon_inode (create getattr ioctl read)))
> > > +(allowx test_copy_ioctl_uffd_t uffd_t (ioctl anon_inode ((0xaa3f 0xaa00 0xaa03))))
> > > +
> > > +; Don't allow read operation on UFFD.
> > > +(typeattributeset cil_gen_require test_noread_uffd_t)
> > > +(typetransition test_noread_uffd_t test_noread_uffd_t anon_inode "[userfaultfd]"    uffd_t)
> > > +(allow test_noread_uffd_t uffd_t (anon_inode (create getattr ioctl)))
> > > diff --git a/policy/test_userfaultfd.te b/policy/test_userfaultfd.te
> > > new file mode 100644
> > > index 0000000..aca9406
> > > --- /dev/null
> > > +++ b/policy/test_userfaultfd.te
> > > @@ -0,0 +1,49 @@
> > > +#################################
> > > +#
> > > +# Policy for testing userfaultfd operations
> > > +#
> > > +
> > > +attribute test_uffd_domain;
> > > +
> > > +type uffd_t;
> > > +
> > > +define(`userfaultfd_domain_type',`
> > > +       type $1;
> > > +       domain_type($1)
> > > +       unconfined_runs_test($1)
> > > +       typeattribute $1 test_uffd_domain;
> > > +       typeattribute $1 testdomain;
> > > +')
> > > +
> > > +# Domain for confirming that without transition rule the userfaultfd
> > > +# gets process' context
> > > +userfaultfd_domain_type(test_notransition_uffd_t)
> > > +
> > > +# Domain for process that has all the permissions to use userfaultfd
> > > +userfaultfd_domain_type(test_uffd_t)
> > > +
> > > +# Domain for process that cannot create userfaultfd
> > > +userfaultfd_domain_type(test_nocreate_uffd_t)
> > > +
> > > +# Domain for process that cannot get attributed of userfaultfd
> > > +userfaultfd_domain_type(test_nogetattr_uffd_t)
> > > +
> > > +# Domain for process which can only use UFFDIO_API ioctl on userfaultfd
> > > +userfaultfd_domain_type(test_api_ioctl_uffd_t)
> > > +
> > > +# Domain for process which can use UFFDIO_API and UFFDIO_REGISTER ioctls
> > > +# on userfaultfd
> > > +userfaultfd_domain_type(test_register_ioctl_uffd_t)
> > > +
> > > +# Domain for process which can use UFFDIO_API, UFFDIO_REGISTER and
> > > +# UFFDIO_COPY ioctls on userfaultfd
> > > +userfaultfd_domain_type(test_copy_ioctl_uffd_t)
> > > +
> > > +# Domain for proces that cannot perform any ioctl operations on userfaultfd
> > > +userfaultfd_domain_type(test_noioctl_uffd_t)
> > > +
> > > +# Domain for process that cannot read from userfaultfd
> > > +userfaultfd_domain_type(test_noread_uffd_t)
> > > +
> > > +# Allow all of these domains to be executed
> > > +allow test_uffd_domain test_file_t:file { entrypoint map execute };
> >
> > This can be replaced with:
> > miscfiles_domain_entry_test_files(test_uffd_domain)
> >
> > And I would also move the unconfined_runs_test() call here and add
> > userdom_sysadm_entry_spec_domtrans_to() (AFAIK the latter is needed
> > when the testsuite is run under an MLS policy):
> > unconfined_runs_test(test_uffd_domain)
> > userdom_sysadm_entry_spec_domtrans_to(test_uffd_domain)
> >
> > (domain_type() is more basic, so I'd leave that one near the type
> > definition in the userfaultfd_domain_type() macro.)
> >
> > > diff --git a/tests/Makefile b/tests/Makefile
> > > index 4c00b5f..3871570 100644
> > > --- a/tests/Makefile
> > > +++ b/tests/Makefile
> > > @@ -27,7 +27,7 @@ SUBDIRS:= domain_trans entrypoint execshare exectrace execute_no_trans \
> > >         task_setnice task_setscheduler task_getscheduler task_getsid \
> > >         task_getpgid task_setpgid file ioctl capable_file capable_net \
> > >         capable_sys dyntrans dyntrace bounds nnp_nosuid mmap unix_socket \
> > > -       inet_socket overlay checkreqprot mqueue mac_admin atsecure
> > > +       inet_socket overlay checkreqprot mqueue mac_admin atsecure userfaultfd
> >
> > We'll either need some check for the kernel version here in the
> > Makefile (so that the test isn't run on older kernels) or even better,
> > the test script could detect if the support is present and skip the
> > tests in that case. I noticed that on current kernels the fgetxattr()
> > call in userfaultfd.c returns -EOPNOTSUPP, so that could easily be
> > used as a check.
> >
> > See e.g. tests/cgroupfs_label/test for an example how to conditionally
> > skip all subtests (essentially just do 'plan skip_all => "message";'
> > in BEGIN {} when kernel support is not present).
> >
> > >
> > >  ifeq ($(shell grep -q cap_userns $(POLDEV)/include/support/all_perms.spt && echo true),true)
> > >  ifneq ($(shell ./kvercmp $$(uname -r) 4.7),-1)
> > > diff --git a/tests/userfaultfd/Makefile b/tests/userfaultfd/Makefile
> > > new file mode 100644
> > > index 0000000..0daa759
> > > --- /dev/null
> > > +++ b/tests/userfaultfd/Makefile
> > > @@ -0,0 +1,5 @@
> > > +userfaultfd:
> > > +       cc userfaultfd.c -o userfaultfd -pthread
> > > +all: userfaultfd
> > > +clean:
> > > +       rm -f userfaultfd
> > > diff --git a/tests/userfaultfd/test b/tests/userfaultfd/test
> > > new file mode 100755
> > > index 0000000..f587e0c
> > > --- /dev/null
> > > +++ b/tests/userfaultfd/test
> > > @@ -0,0 +1,39 @@
> > > +#!/usr/bin/perl
> > > +
> > > +use Test;
> > > +
> > > +BEGIN {
> > > +    plan tests => 9;
> > > +}
> > > +
> > > +$basedir = $0;
> > > +$basedir =~ s|(.*)/[^/]*|$1|;
> > > +
> > > +$result = system "runcon -t test_notransition_uffd_t $basedir/userfaultfd test_notransition_uffd_t";
> > > +ok( $result, 0 );
> > > +
> > > +$result = system "runcon -t test_uffd_t $basedir/userfaultfd uffd_t";
> > > +ok( $result, 0 );
> > > +
> > > +$result = system "runcon -t test_nocreate_uffd_t $basedir/userfaultfd uffd_t";
> > > +ok( $result >> 8, 1 );
> > > +
> > > +$result = system "runcon -t test_nogetattr_uffd_t $basedir/userfaultfd uffd_t";
> > > +ok( $result >> 8, 2 );
> > > +
> > > +$result = system "runcon -t test_noioctl_uffd_t $basedir/userfaultfd uffd_t";
> > > +ok( $result >> 8, 4 );
> > > +
> > > +$result = system "runcon -t test_api_ioctl_uffd_t $basedir/userfaultfd uffd_t";
> > > +ok( $result >> 8, 5 );
> > > +
> > > +$result = system "runcon -t test_noread_uffd_t $basedir/userfaultfd uffd_t";
> > > +ok( $result >> 8, 6 );
> > > +
> > > +$result = system "runcon -t test_register_ioctl_uffd_t $basedir/userfaultfd uffd_t";
> > > +ok( $result >> 8, 7 );
> > > +
> > > +$result = system "runcon -t test_copy_ioctl_uffd_t $basedir/userfaultfd uffd_t";
> > > +ok( $result, 0 );
> >
> > I'm fine with this as a basic coverage.
> >
> Thanks for reviewing the patch. I'll send another patch in a day or
> two to address all your comments.
>
> > Just wondering if we should test also passing a userfaultfd to another
> > process (which seems to be supported). But I don't think it' a high
> > priority and I won't require it. If you feel like it, you can work on
> > it in a separate follow up patch, so that this patch is not blocked on
> > review of the additional code.
>
> If you think testing this is required, then I'm fine with following up
> with another patch for it.

No, I don't consider it required. I was just trying to say that _if_
you'd want to be proactive and add it, then it would be better to do
in a separate patch, so that we can merge the basic coverage faster :)

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

