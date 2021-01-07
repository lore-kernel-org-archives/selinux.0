Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14F9C433E0
	for <selinux@archiver.kernel.org>; Thu,  7 Jan 2021 06:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 837CD22E00
	for <selinux@archiver.kernel.org>; Thu,  7 Jan 2021 06:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbhAGGtZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Jan 2021 01:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbhAGGtY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 Jan 2021 01:49:24 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390E1C0612F4
        for <selinux@vger.kernel.org>; Wed,  6 Jan 2021 22:48:44 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id cw27so6716688edb.5
        for <selinux@vger.kernel.org>; Wed, 06 Jan 2021 22:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RLAlO81/OOpoaOtVVy80ewmJpmaJE41epY7yFdnMcBA=;
        b=GjlzRTBd8LKQTA2WmB2wAkmDxV8kKLYNC07+0DFVYXCNznoADMJgSM25XFhhko4crW
         ToIe4V26nO98K67u7fLQgUNZVdWC5zQFUG8JJaaTokuVIZZ2lgjNvdLP2kM6vxnyM8S4
         xkTE2mXVSUzicIv1jXMswHn1rKQmMpPhf3UK4lCoYuI0GqIbpW9KMqqB2qbUinR5ThWo
         2ykyk7AuOJ3noMDCyWljgwsLn3BoVLDa4zizINlbYB438stRJ8NaRj4qxBkeC1PYgqWC
         qedIQgQwfnB3h13jE+wbNqnO7jJy4xPzb1Zzp6BgSI7aRYBeGHOoggWlnbydMYdVv8aX
         kuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RLAlO81/OOpoaOtVVy80ewmJpmaJE41epY7yFdnMcBA=;
        b=NfPMOPypisF2E1ZOx6GzWDUWPokd/SNmKOSbMOB5IZbaAQ3mtimiDCcYA6xncJ5ey0
         cTQh5IJmZwRFA1gBzXR51C+na08BkQqtR6W3zmXRfSzIkR3irsKaDbWpT3HQej4DHU7Q
         HCB+6KXggwZHQ13pYbIbrbVR9CdgJL7X5kJ1eu1NS+8nuknjk1/M9VLFc+142Kn2iQnr
         JANbQ/ufky9+rUu1WPzjT+UF37r8Ve8cCfXvI4emznamn5v6s94wtGC3uMOAXvshisMS
         +cGVU7A/eFDquSyd2i8aFJ89PBSl8uM8XQ9xCXdi7FprAJLSsjzR0iBlmxHvjcB2Bic2
         JWUg==
X-Gm-Message-State: AOAM531UAvt2AeVFr3wnCrGRrbLq4P3kli1ZzQP0iO/BkhpQdgeHRYdf
        nbF1yQYqKZ4+BHaNTptibxntlRriOrkSDJEFMDdm8g==
X-Google-Smtp-Source: ABdhPJxqaJdzQs63tDWyU6KMR2mV9R+IUNrteZNvWhghZ07vQAGvt9BltT8jVGxbvRunpeGBLr0gYn6ap7FqKDxEDRY=
X-Received: by 2002:aa7:da03:: with SMTP id r3mr561945eds.155.1610002122656;
 Wed, 06 Jan 2021 22:48:42 -0800 (PST)
MIME-Version: 1.0
References: <20201211230119.1818009-1-lokeshgidra@google.com> <CAFqZXNspYbKxmqyeEjLg-zsgrvLEJ86a9OGLwYU7TFWpfHnOyA@mail.gmail.com>
In-Reply-To: <CAFqZXNspYbKxmqyeEjLg-zsgrvLEJ86a9OGLwYU7TFWpfHnOyA@mail.gmail.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Wed, 6 Jan 2021 22:48:31 -0800
Message-ID: <CA+EESO4Snwu-OvRvnp-HVy7ajR1u536WYu_c3eq1eCbhabvk+A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] selinux-testsuite: Add userfaultfd test
To:     Ondrej Mosnacek <omosnace@redhat.com>
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

On Wed, Jan 6, 2021 at 2:01 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Sat, Dec 12, 2020 at 12:01 AM Lokesh Gidra <lokeshgidra@google.com> wrote:
> >
> > Confirm SELinux policies are enforced on userfaultfd operations
> > via secure anon-inode interface.
> >
> > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > ---
> >  policy/Makefile                 |   4 +-
> >  policy/test_userfaultfd.cil     |  52 ++++++++++
> >  policy/test_userfaultfd.te      |  49 +++++++++
> >  tests/Makefile                  |   2 +-
> >  tests/userfaultfd/Makefile      |   5 +
> >  tests/userfaultfd/test          |  39 +++++++
> >  tests/userfaultfd/userfaultfd.c | 175 ++++++++++++++++++++++++++++++++
> >  7 files changed, 323 insertions(+), 3 deletions(-)
> >  create mode 100644 policy/test_userfaultfd.cil
> >  create mode 100644 policy/test_userfaultfd.te
> >  create mode 100644 tests/userfaultfd/Makefile
> >  create mode 100755 tests/userfaultfd/test
> >  create mode 100644 tests/userfaultfd/userfaultfd.c
>
> Thanks, this looks very good! I have just a few minor comments below.
>
> First nit: There are some whitespace issues with your patch:
> ```
> $ curl https://patchwork.kernel.org/series/400871/mbox/ | git am
> [...]
> .git/rebase-apply/patch:318: trailing whitespace.
>
> .git/rebase-apply/patch:381: space before tab in indent.
>     // Create a thread that will process the userfaultfd events
> .git/rebase-apply/patch:388: trailing whitespace.
>
>  warning: 3 lines add whitespace errors.
>  Applying: selinux-testsuite: Add userfaultfd test
> ```
>
> >
> > diff --git a/policy/Makefile b/policy/Makefile
> > index 6c49091..3e00875 100644
> > --- a/policy/Makefile
> > +++ b/policy/Makefile
> > @@ -29,14 +29,14 @@ TARGETS = \
> >         test_task_getsid.te test_task_setpgid.te test_task_setsched.te \
> >         test_transition.te test_unix_socket.te \
> >         test_mmap.te test_overlayfs.te test_mqueue.te \
> > -       test_ibpkey.te test_atsecure.te test_cgroupfs.te
> > +       test_ibpkey.te test_atsecure.te test_cgroupfs.te test_userfaultfd.te
> >
> >  ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
> >  SUPPORTS_CIL = n
> >  endif
> >
> >  ifeq ($(SUPPORTS_CIL),y)
> > -CIL_TARGETS = test_mlsconstrain.cil test_overlay_defaultrange.cil
> > +CIL_TARGETS = test_mlsconstrain.cil test_overlay_defaultrange.cil test_userfaultfd.cil
> >  ifeq ($(shell [ $(MAX_KERNEL_POLICY) -ge 32 ] && echo true),true)
> >  ifeq ($(shell [ $(POL_VERS) -ge 32 ] && echo true),true)
> >  # If other MLS tests get written this can be moved outside of the glblub test
> > diff --git a/policy/test_userfaultfd.cil b/policy/test_userfaultfd.cil
> > new file mode 100644
> > index 0000000..b0f44af
> > --- /dev/null
> > +++ b/policy/test_userfaultfd.cil
> > @@ -0,0 +1,52 @@
> > +; Define new class anon_inode
> > +(class anon_inode ())
> > +(classcommon anon_inode file)
> > +(classorder (unordered anon_inode))
> > +
> > +; Allow all anonymous inodes
> > +(typeattributeset cil_gen_require test_notransition_uffd_t)
> > +(allow test_notransition_uffd_t self (anon_inode (create getattr ioctl read)))
> > +
> > +(typeattributeset cil_gen_require uffd_t)
> > +
> > +; Allow all operations on UFFD
> > +(typeattributeset cil_gen_require test_uffd_t)
> > +(typetransition test_uffd_t test_uffd_t anon_inode "[userfaultfd]"    uffd_t)
> > +(allow test_uffd_t uffd_t (anon_inode (create getattr ioctl read)))
> > +
> > +; Don't allow any operation on UFFD
> > +(typeattributeset cil_gen_require test_nocreate_uffd_t)
> > +(typetransition test_nocreate_uffd_t test_nocreate_uffd_t anon_inode "[userfaultfd]"    uffd_t)
> > +
> > +; Don't allow getattr operation on UFFD
> > +(typeattributeset cil_gen_require test_nogetattr_uffd_t)
> > +(typetransition test_nogetattr_uffd_t test_nogetattr_uffd_t anon_inode "[userfaultfd]"    uffd_t)
> > +(allow test_nogetattr_uffd_t uffd_t (anon_inode (create)))
> > +
> > +; Don't allow any ioctl operation on UFFD
> > +(typeattributeset cil_gen_require test_noioctl_uffd_t)
> > +(typetransition test_noioctl_uffd_t test_noioctl_uffd_t anon_inode "[userfaultfd]"    uffd_t)
> > +(allow test_noioctl_uffd_t uffd_t (anon_inode (create getattr)))
> > +
> > +; Only allow UFFDIO_API ioctl
> > +(typeattributeset cil_gen_require test_api_ioctl_uffd_t)
> > +(typetransition test_api_ioctl_uffd_t test_api_ioctl_uffd_t anon_inode "[userfaultfd]"    uffd_t)
> > +(allow test_api_ioctl_uffd_t uffd_t (anon_inode (create getattr ioctl read)))
> > +(allowx test_api_ioctl_uffd_t uffd_t (ioctl anon_inode ((0xaa3f))))
> > +
> > +; Only allow UFFDIO_API and UFFDIO_REGISTER ioctls
> > +(typeattributeset cil_gen_require test_register_ioctl_uffd_t)
> > +(typetransition test_register_ioctl_uffd_t test_register_ioctl_uffd_t anon_inode "[userfaultfd]"    uffd_t)
> > +(allow test_register_ioctl_uffd_t uffd_t (anon_inode (create getattr ioctl read)))
> > +(allowx test_register_ioctl_uffd_t uffd_t (ioctl anon_inode ((0xaa3f 0xaa00))))
> > +
> > +; Only allow UFFDIO_API, UFFDIO_REGISTER and UFFDIO_COPY ioctls, which are most used.
> > +(typeattributeset cil_gen_require test_copy_ioctl_uffd_t)
> > +(typetransition test_copy_ioctl_uffd_t test_copy_ioctl_uffd_t anon_inode "[userfaultfd]"    uffd_t)
> > +(allow test_copy_ioctl_uffd_t uffd_t (anon_inode (create getattr ioctl read)))
> > +(allowx test_copy_ioctl_uffd_t uffd_t (ioctl anon_inode ((0xaa3f 0xaa00 0xaa03))))
> > +
> > +; Don't allow read operation on UFFD.
> > +(typeattributeset cil_gen_require test_noread_uffd_t)
> > +(typetransition test_noread_uffd_t test_noread_uffd_t anon_inode "[userfaultfd]"    uffd_t)
> > +(allow test_noread_uffd_t uffd_t (anon_inode (create getattr ioctl)))
> > diff --git a/policy/test_userfaultfd.te b/policy/test_userfaultfd.te
> > new file mode 100644
> > index 0000000..aca9406
> > --- /dev/null
> > +++ b/policy/test_userfaultfd.te
> > @@ -0,0 +1,49 @@
> > +#################################
> > +#
> > +# Policy for testing userfaultfd operations
> > +#
> > +
> > +attribute test_uffd_domain;
> > +
> > +type uffd_t;
> > +
> > +define(`userfaultfd_domain_type',`
> > +       type $1;
> > +       domain_type($1)
> > +       unconfined_runs_test($1)
> > +       typeattribute $1 test_uffd_domain;
> > +       typeattribute $1 testdomain;
> > +')
> > +
> > +# Domain for confirming that without transition rule the userfaultfd
> > +# gets process' context
> > +userfaultfd_domain_type(test_notransition_uffd_t)
> > +
> > +# Domain for process that has all the permissions to use userfaultfd
> > +userfaultfd_domain_type(test_uffd_t)
> > +
> > +# Domain for process that cannot create userfaultfd
> > +userfaultfd_domain_type(test_nocreate_uffd_t)
> > +
> > +# Domain for process that cannot get attributed of userfaultfd
> > +userfaultfd_domain_type(test_nogetattr_uffd_t)
> > +
> > +# Domain for process which can only use UFFDIO_API ioctl on userfaultfd
> > +userfaultfd_domain_type(test_api_ioctl_uffd_t)
> > +
> > +# Domain for process which can use UFFDIO_API and UFFDIO_REGISTER ioctls
> > +# on userfaultfd
> > +userfaultfd_domain_type(test_register_ioctl_uffd_t)
> > +
> > +# Domain for process which can use UFFDIO_API, UFFDIO_REGISTER and
> > +# UFFDIO_COPY ioctls on userfaultfd
> > +userfaultfd_domain_type(test_copy_ioctl_uffd_t)
> > +
> > +# Domain for proces that cannot perform any ioctl operations on userfaultfd
> > +userfaultfd_domain_type(test_noioctl_uffd_t)
> > +
> > +# Domain for process that cannot read from userfaultfd
> > +userfaultfd_domain_type(test_noread_uffd_t)
> > +
> > +# Allow all of these domains to be executed
> > +allow test_uffd_domain test_file_t:file { entrypoint map execute };
>
> This can be replaced with:
> miscfiles_domain_entry_test_files(test_uffd_domain)
>
> And I would also move the unconfined_runs_test() call here and add
> userdom_sysadm_entry_spec_domtrans_to() (AFAIK the latter is needed
> when the testsuite is run under an MLS policy):
> unconfined_runs_test(test_uffd_domain)
> userdom_sysadm_entry_spec_domtrans_to(test_uffd_domain)
>
> (domain_type() is more basic, so I'd leave that one near the type
> definition in the userfaultfd_domain_type() macro.)
>
> > diff --git a/tests/Makefile b/tests/Makefile
> > index 4c00b5f..3871570 100644
> > --- a/tests/Makefile
> > +++ b/tests/Makefile
> > @@ -27,7 +27,7 @@ SUBDIRS:= domain_trans entrypoint execshare exectrace execute_no_trans \
> >         task_setnice task_setscheduler task_getscheduler task_getsid \
> >         task_getpgid task_setpgid file ioctl capable_file capable_net \
> >         capable_sys dyntrans dyntrace bounds nnp_nosuid mmap unix_socket \
> > -       inet_socket overlay checkreqprot mqueue mac_admin atsecure
> > +       inet_socket overlay checkreqprot mqueue mac_admin atsecure userfaultfd
>
> We'll either need some check for the kernel version here in the
> Makefile (so that the test isn't run on older kernels) or even better,
> the test script could detect if the support is present and skip the
> tests in that case. I noticed that on current kernels the fgetxattr()
> call in userfaultfd.c returns -EOPNOTSUPP, so that could easily be
> used as a check.
>
> See e.g. tests/cgroupfs_label/test for an example how to conditionally
> skip all subtests (essentially just do 'plan skip_all => "message";'
> in BEGIN {} when kernel support is not present).
>
> >
> >  ifeq ($(shell grep -q cap_userns $(POLDEV)/include/support/all_perms.spt && echo true),true)
> >  ifneq ($(shell ./kvercmp $$(uname -r) 4.7),-1)
> > diff --git a/tests/userfaultfd/Makefile b/tests/userfaultfd/Makefile
> > new file mode 100644
> > index 0000000..0daa759
> > --- /dev/null
> > +++ b/tests/userfaultfd/Makefile
> > @@ -0,0 +1,5 @@
> > +userfaultfd:
> > +       cc userfaultfd.c -o userfaultfd -pthread
> > +all: userfaultfd
> > +clean:
> > +       rm -f userfaultfd
> > diff --git a/tests/userfaultfd/test b/tests/userfaultfd/test
> > new file mode 100755
> > index 0000000..f587e0c
> > --- /dev/null
> > +++ b/tests/userfaultfd/test
> > @@ -0,0 +1,39 @@
> > +#!/usr/bin/perl
> > +
> > +use Test;
> > +
> > +BEGIN {
> > +    plan tests => 9;
> > +}
> > +
> > +$basedir = $0;
> > +$basedir =~ s|(.*)/[^/]*|$1|;
> > +
> > +$result = system "runcon -t test_notransition_uffd_t $basedir/userfaultfd test_notransition_uffd_t";
> > +ok( $result, 0 );
> > +
> > +$result = system "runcon -t test_uffd_t $basedir/userfaultfd uffd_t";
> > +ok( $result, 0 );
> > +
> > +$result = system "runcon -t test_nocreate_uffd_t $basedir/userfaultfd uffd_t";
> > +ok( $result >> 8, 1 );
> > +
> > +$result = system "runcon -t test_nogetattr_uffd_t $basedir/userfaultfd uffd_t";
> > +ok( $result >> 8, 2 );
> > +
> > +$result = system "runcon -t test_noioctl_uffd_t $basedir/userfaultfd uffd_t";
> > +ok( $result >> 8, 4 );
> > +
> > +$result = system "runcon -t test_api_ioctl_uffd_t $basedir/userfaultfd uffd_t";
> > +ok( $result >> 8, 5 );
> > +
> > +$result = system "runcon -t test_noread_uffd_t $basedir/userfaultfd uffd_t";
> > +ok( $result >> 8, 6 );
> > +
> > +$result = system "runcon -t test_register_ioctl_uffd_t $basedir/userfaultfd uffd_t";
> > +ok( $result >> 8, 7 );
> > +
> > +$result = system "runcon -t test_copy_ioctl_uffd_t $basedir/userfaultfd uffd_t";
> > +ok( $result, 0 );
>
> I'm fine with this as a basic coverage.
>
Thanks for reviewing the patch. I'll send another patch in a day or
two to address all your comments.

> Just wondering if we should test also passing a userfaultfd to another
> process (which seems to be supported). But I don't think it' a high
> priority and I won't require it. If you feel like it, you can work on
> it in a separate follow up patch, so that this patch is not blocked on
> review of the additional code.

If you think testing this is required, then I'm fine with following up
with another patch for it.
>
> > +
> > +exit;
> > diff --git a/tests/userfaultfd/userfaultfd.c b/tests/userfaultfd/userfaultfd.c
> > new file mode 100644
> > index 0000000..b2ac621
> > --- /dev/null
> > +++ b/tests/userfaultfd/userfaultfd.c
> > @@ -0,0 +1,175 @@
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <poll.h>
> > +#include <pthread.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +
> > +#include <sys/ioctl.h>
> > +#include <sys/mman.h>
> > +#include <sys/types.h>
> > +#include <sys/syscall.h>
> > +#include <sys/xattr.h>
> > +
> > +#include <linux/userfaultfd.h>
> > +
> > +int page_size;
> > +
> > +void* fault_handler_thread(void* arg)
> > +{
> > +       long uffd = (long)arg;
> > +       struct uffd_msg msg = {0};
> > +       struct uffdio_copy uffdio_copy = {0};
> > +       ssize_t nread;
> > +       char* page = (char *) mmap(NULL, page_size,  PROT_READ | PROT_WRITE,
> > +                       MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> > +       if (page == MAP_FAILED) {
> > +               perror("mmap");
> > +               exit(-1);
> > +       }
> > +       memset(page, 'a', page_size);
> > +
> > +       // Loop, handling incoming events on the userfaultfd file descriptor
> > +       for (;;) {
> > +               // poll on uffd waiting for an event
> > +               struct pollfd pollfd;
> > +               int nready;
> > +               pollfd.fd = uffd;
> > +               pollfd.events = POLLIN;
> > +               nready = poll(&pollfd, 1, -1);
> > +               if (nready == -1) {
> > +                       perror("poll");
> > +                       exit(-1);
> > +               }
> > +
> > +               /* Read an event from the userfaultfd */
> > +               nread = read(uffd, &msg, sizeof(msg));
> > +               if (nread == 0) {
> > +                       printf("EOF on userfaultfd!\n");
> > +                       exit(-1);
> > +               }
> > +
> > +               if (nread == -1) {
> > +                       if (errno == EACCES) {
> > +                               exit(6);
> > +                       }
> > +                       perror("read");
> > +                       exit(-1);
> > +               }
> > +
> > +               // We expect only one kind of event; verify that assumption
> > +               if (msg.event != UFFD_EVENT_PAGEFAULT) {
> > +                       fprintf(stderr, "Unexpected event on userfaultfd\n");
> > +                       exit(-1);
> > +               }
> > +
> > +               uffdio_copy.src = (unsigned long) page;
> > +
> > +               // Align fault address to page boundary
> > +               uffdio_copy.dst = (unsigned long) msg.arg.pagefault.address &
> > +                                                  ~(page_size - 1);
> > +               uffdio_copy.len = page_size;
> > +               uffdio_copy.mode = 0; // Wake-up thread thread waiting for page-fault resolution
> > +               uffdio_copy.copy = 0; // Used by kernel to return how many bytes copied
> > +               if (ioctl(uffd, UFFDIO_COPY, &uffdio_copy) < 0) {
> > +                       if (errno == EACCES) {
> > +                               exit(7);
> > +                       }
> > +                       perror("ioctl-UFFDIO_COPY");
> > +                       exit(-1);
> > +               }
> > +       }
> > +}
> > +
> > +int main (int argc, char* argv[])
> > +{
> > +       char* addr;
> > +       struct uffdio_api api = {0};
> > +       struct uffdio_register uffdio_register = {0};
> > +       char selinux_ctxt[128];
> > +       pthread_t thr; // ID of thread that handles page faults
> > +       ssize_t ret;
> > +
> > +       long uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
> > +       if (uffd < 0) {
> > +               if (errno == EACCES) {
> > +                       return 1;
> > +               }
> > +               perror("syscall(userfaultfd)");
> > +               return -1;
> > +       }
> > +
> > +       // Check security context of uffd
> > +        ret = fgetxattr(uffd, "security.selinux", selinux_ctxt, 1024);
> > +        if (ret < 0) {
> > +               if (errno == EACCES) {
> > +                       return 2;
> > +               }
> > +                perror("fgetxattr");
> > +                return -1;
> > +        }
> > +        selinux_ctxt[ret] = 0;
> > +       if (strstr(selinux_ctxt, argv[1]) == NULL) {
> > +               fprintf(stderr, "Couldn't find the right selinux context. "
> > +                               "got:%s expected:%s\n", selinux_ctxt, argv[1]);
> > +               return 3;
> > +       }
> > +
> > +       api.api = UFFD_API;
> > +       if (ioctl(uffd, UFFDIO_API, &api) < 0) {
> > +               if (errno == EACCES) {
> > +                       return 4;
> > +               }
> > +               perror("UFFDIO_API");
> > +               return -1;
> > +       }
> > +
> > +       page_size = sysconf(_SC_PAGE_SIZE);
> > +       /* Create a private anonymous mapping. The memory will be
> > +        * demand-zero paged--that is, not yet allocated. When we
> > +        * actually touch the memory, it will be allocated via
> > +        * the userfaultfd.
> > +        */
> > +       addr = (char*) mmap(NULL, page_size, PROT_READ | PROT_WRITE,
> > +                       MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> > +       if (addr == MAP_FAILED) {
> > +               perror("mmap");
> > +               return -1;
> > +       }
> > +
> > +       /* Register the memory range of the mapping we just created for
> > +        * handling by the userfaultfd object. In mode, we request to track
> > +        * missing pages (i.e., pages that have not yet been faulted in).
> > +        */
> > +       uffdio_register.range.start = (unsigned long) addr;
> > +       uffdio_register.range.len = page_size;
> > +       uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
> > +       if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) < 0) {
> > +               if (errno == EACCES) {
> > +                       return 5;
> > +               }
> > +               perror("ioctl-UFFDIO_REGISTER");
> > +               return -1;
> > +       }
> > +
> > +       // Create a thread that will process the userfaultfd events
> > +       ret = pthread_create(&thr, NULL, fault_handler_thread, (void *) uffd);
> > +       if (ret != 0) {
> > +               errno = ret;
> > +               perror("pthread_create");
> > +               return -1;
> > +       }
> > +
> > +       /* Acces to the registered memory range should invoke the 'missing'
> > +        * userfaultfd page fault, which should get handled by the thread
> > +        * created above.
> > +        */
> > +       if (addr[42] != 'a') {
> > +               fprintf(stderr, "Didn't read the expected value after userfaultfd event\n");
> > +               return -1;
> > +       }
> > +
> > +       return 0;
> > +}
> > --
> > 2.28.0
> >
>
> --
> Ondrej Mosnacek
> Software Engineer, Platform Security - SELinux kernel
> Red Hat, Inc.
>
