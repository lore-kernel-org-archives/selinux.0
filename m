Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D365FC4361B
	for <selinux@archiver.kernel.org>; Fri, 11 Dec 2020 15:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86FD820657
	for <selinux@archiver.kernel.org>; Fri, 11 Dec 2020 15:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405443AbgLKOoZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Dec 2020 09:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404393AbgLKOoG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Dec 2020 09:44:06 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F75C0613CF
        for <selinux@vger.kernel.org>; Fri, 11 Dec 2020 06:43:26 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id b9so12708985ejy.0
        for <selinux@vger.kernel.org>; Fri, 11 Dec 2020 06:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T8lauiobIgtBp3hAWZtQpP5b5hbtCrRBojzDQvNBIHY=;
        b=ivR0Z+85vfTF2Pj/j9Fz0B9Zv5kKtu7pgRuNQ2MUqbzqd5zZmZHxL326krEBJQ+0fk
         ADRLJcjBXz/UBywoHqdLiI5JN+XKFnwBhL6k0eQ7Zf4HN471FPn56k6AnwcqRWCIUmY9
         +ceQQrMIbuGNJ/GG8j/7OwLK5deZ/QgELrv7K2TslBYQoQf+gSGZeYiTEfpYYpKnq6Up
         c9hA3SGqftbQx+nO4EQCf2GMi6/0zFkr6hptJJmMaCtAJS74nJtJ3l+wGaxgFny77rpq
         s02EfqNNNTt9PqU6BbOtany0ukVPBQIZd09R5qsNRTSIsfuUjyaprNSLYS4ElbLBivct
         mrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T8lauiobIgtBp3hAWZtQpP5b5hbtCrRBojzDQvNBIHY=;
        b=sP4TUjdAMz1RwpXT4ssk6T9MGHyZn7BohQik1IH4IkRjJ9R/HmFPPsrhQyPeb0ja44
         Doqqnl2tyvyrOy4aScYTL/VHao9rD6HTMFcsg77zjAUiblogMmm1J8TynqAfEZDai8sS
         nfltc5UDylRve943rIcWdrU3qCARPKlYCcH8pX8/AcafNZY/gH7MMdGQltrs0vER5IhC
         69wtOgT3/ZqW9wZAvJQtqg9yNkAoG2nJ329NQ6f1EYPB7PheJypHOrwffJ74UvNRs2KP
         cLTURDZvCq2dYm4kV2kaZLVEOiOgJkAYzQQv3wvJkxuugmAOJ60ZGw6jdC35QNbmDRsv
         mYWw==
X-Gm-Message-State: AOAM533S1wVBJa/MU0AfasKm7MacqxcOLqzxTZWhi2Hku7CP74rIoDSf
        U5SyYxM5HLCen7/1+PoADwSNcGTnqsOwmUFoxs/nWg==
X-Google-Smtp-Source: ABdhPJx6CMkEPgesoHNc2IGQOR6RYCJFJYJ8xjgdMckc1S2rUiOV388dGbjSEHTREnf5/uouAJQ8r0V368LlAP4C4gY=
X-Received: by 2002:a17:906:7c49:: with SMTP id g9mr11418451ejp.185.1607697804427;
 Fri, 11 Dec 2020 06:43:24 -0800 (PST)
MIME-Version: 1.0
References: <20201125125402.211692-1-lokeshgidra@google.com>
 <CAFqZXNsry1zqGND-iBaYmwb_KeCvoat-LQFywf04TAp998sqXQ@mail.gmail.com>
 <CA+EESO7KW+ixSoFKOE_aH7P=rgUSuOL6y6TZfg_4Pez-Caw8LA@mail.gmail.com>
 <CAFqZXNtYVrE2GWQtWhTMt2zTKkPaAeZtw95cvuRR9_DbDmKoCA@mail.gmail.com>
 <CA+EESO4EL3ZE4J-Xyoky5fz=nC7WYp3H8eCfKom7hBfkO=FiDg@mail.gmail.com> <CAFqZXNvbGgQVtx3pCX_YyQj6tH7ctb97+8wqryaDjkBtp5BuKw@mail.gmail.com>
In-Reply-To: <CAFqZXNvbGgQVtx3pCX_YyQj6tH7ctb97+8wqryaDjkBtp5BuKw@mail.gmail.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Fri, 11 Dec 2020 06:43:13 -0800
Message-ID: <CA+EESO6CimjatwBS8fiqBGEJ86As-KywWti4uyiH=KLHnTk5Kw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] selinux-testsuite: Add userfaultfd test
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

On Fri, Dec 11, 2020 at 5:52 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Fri, Dec 11, 2020 at 2:40 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > On Fri, Dec 11, 2020 at 1:11 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > On Fri, Dec 11, 2020 at 1:52 AM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > > > Hi Ondrej,
> > > > On Fri, Nov 27, 2020 at 6:09 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > >
> > > > > Hi Lokesh,
> > > > >
> > > > > On Wed, Nov 25, 2020 at 1:54 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > > > > > Confirm SELinux policies are enforced on userfaultfd operations
> > > > > > via secure anon-inode interface.
> > > > > >
> > > > > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > > > > > ---
> > > > > >  policy/Makefile                 |  2 +-
> > > > > >  policy/userfaultfd.cil          | 17 ++++++++++++
> > > > > >  tests/Makefile                  |  2 +-
> > > > > >  tests/userfaultfd/Makefile      |  3 ++
> > > > > >  tests/userfaultfd/test          | 15 ++++++++++
> > > > > >  tests/userfaultfd/userfaultfd.c | 49 +++++++++++++++++++++++++++++++++
> > > > > >  6 files changed, 86 insertions(+), 2 deletions(-)
> > > > > >  create mode 100644 policy/userfaultfd.cil
> > > > > >  create mode 100644 tests/userfaultfd/Makefile
> > > > > >  create mode 100755 tests/userfaultfd/test
> > > > > >  create mode 100644 tests/userfaultfd/userfaultfd.c
> > > > > >
> > > > > > diff --git a/policy/Makefile b/policy/Makefile
> > > > > > index 6c49091..02e7568 100644
> > > > > > --- a/policy/Makefile
> > > > > > +++ b/policy/Makefile
> > > > > > @@ -36,7 +36,7 @@ SUPPORTS_CIL = n
> > > > > >  endif
> > > > > >
> > > > > >  ifeq ($(SUPPORTS_CIL),y)
> > > > > > -CIL_TARGETS = test_mlsconstrain.cil test_overlay_defaultrange.cil
> > > > > > +CIL_TARGETS = test_mlsconstrain.cil test_overlay_defaultrange.cil userfaultfd.cil
> > > > > >  ifeq ($(shell [ $(MAX_KERNEL_POLICY) -ge 32 ] && echo true),true)
> > > > > >  ifeq ($(shell [ $(POL_VERS) -ge 32 ] && echo true),true)
> > > > > >  # If other MLS tests get written this can be moved outside of the glblub test
> > > > > > diff --git a/policy/userfaultfd.cil b/policy/userfaultfd.cil
> > > > > > new file mode 100644
> > > > > > index 0000000..0743fff
> > > > > > --- /dev/null
> > > > > > +++ b/policy/userfaultfd.cil
> > > > > > @@ -0,0 +1,17 @@
> > > > > > +(class anon_inode ())
> > > > > > +(classcommon anon_inode file)
> > > > > > +(classorder (unordered anon_inode))
> > > > > > +(type uffd_t)
> > > > > > +; Label the UFFD with uffd_t; this can be specialized per domain
> > > > > > +(typetransition unconfined_t unconfined_t anon_inode "[userfaultfd]"    uffd_t)
> > > > > > +(allow unconfined_t uffd_t (anon_inode (create)))
> > > > > > +; Permit read() and ioctl() on the UFFD;
> > > > > > +; Comment out if you want to test read or basic ioctl enforcement.
> > > > > > +(allow unconfined_t uffd_t (anon_inode (read)))
> > > > > > +(allow unconfined_t uffd_t (anon_inode (ioctl)))
> > > > > > +; Uncomment one of the allowx lines below to test ioctl whitelisting.
> > > > > > +; Currently the first one is uncommented; comment that out if trying another.
> > > > > > +; None
> > > > > > +;(allowx unconfined_t uffd_t (ioctl anon_inode ((0x00))))
> > > > > > +; UFFDIO_API
> > > > > > +(allowx unconfined_t uffd_t (ioctl anon_inode ((0xaa3f))))
> > > > > > diff --git a/tests/Makefile b/tests/Makefile
> > > > > > index 4c00b5f..3871570 100644
> > > > > > --- a/tests/Makefile
> > > > > > +++ b/tests/Makefile
> > > > > > @@ -27,7 +27,7 @@ SUBDIRS:= domain_trans entrypoint execshare exectrace execute_no_trans \
> > > > > >         task_setnice task_setscheduler task_getscheduler task_getsid \
> > > > > >         task_getpgid task_setpgid file ioctl capable_file capable_net \
> > > > > >         capable_sys dyntrans dyntrace bounds nnp_nosuid mmap unix_socket \
> > > > > > -       inet_socket overlay checkreqprot mqueue mac_admin atsecure
> > > > > > +       inet_socket overlay checkreqprot mqueue mac_admin atsecure userfaultfd
> > > > > >
> > > > > >  ifeq ($(shell grep -q cap_userns $(POLDEV)/include/support/all_perms.spt && echo true),true)
> > > > > >  ifneq ($(shell ./kvercmp $$(uname -r) 4.7),-1)
> > > > > > diff --git a/tests/userfaultfd/Makefile b/tests/userfaultfd/Makefile
> > > > > > new file mode 100644
> > > > > > index 0000000..66d02a1
> > > > > > --- /dev/null
> > > > > > +++ b/tests/userfaultfd/Makefile
> > > > > > @@ -0,0 +1,3 @@
> > > > > > +all: userfaultfd
> > > > > > +clean:
> > > > > > +       rm -f userfaultfd
> > > > > > diff --git a/tests/userfaultfd/test b/tests/userfaultfd/test
> > > > > > new file mode 100755
> > > > > > index 0000000..dd42aa8
> > > > > > --- /dev/null
> > > > > > +++ b/tests/userfaultfd/test
> > > > > > @@ -0,0 +1,15 @@
> > > > > > +#!/usr/bin/perl
> > > > > > +
> > > > > > +use Test;
> > > > > > +
> > > > > > +BEGIN {
> > > > > > +    plan tests => 1;
> > > > > > +}
> > > > > > +
> > > > > > +$basedir = $0;
> > > > > > +$basedir =~ s|(.*)/[^/]*|$1|;
> > > > > > +
> > > > > > +$result = system("$basedir/userfaultfd");
> > > > > > +ok( $result, 0 );
> > > > >
> > > > > This is a good start, but it is only a very basic test :)
> > > > >
> > > > > I would expect at least these tests here:
> > > > > 1. that an userfaultfd node created by a domain *without* the
> > > > > transition rule gets the context of the creating process (should be
> > > > > possible by calling fgetxattr(2) on the fd),
> > > > > 2. that an userfaultfd node created by a domain *with* the transition
> > > > > rule gets the context specified by the rule,
> > > > > 3. that a process with context that is *allowed* to { create read
> > > > > write [...] } a given userfaultfd type by the policy *can* indeed
> > > > > successfully perform these operations (or at least that the error
> > > > > returned is not -EACCESS),
> > > > > 4. that a process with context that is *NOT allowed* to { create read
> > > > > write [...] } a given userfaultfd type by the policy *cannot* perform
> > > > > these operations and the error returned is -EACCESS.
> > > > >
> > > > > (The more permissions you can test the better, but I'd like to see at
> > > > > least the three (create, read, write).)
> > > > >
> > > > > For this, you will need to define several process types in the test
> > > > > policy and run the test program(s) with a specific type using runcon
> > > > > (see e.g. policy/test_link.te and tests/link/test for a simple
> > > > > example). I suggest using the CIL module only for adding the class and
> > > > > permissions and a separate .te file to define the process and
> > > > > userfaultfd types (so that you can use the unconfined_runs_test()
> > > > > interface for common permissions needed for the process types).
> > > > >
> > > > I'm having a bit of a hard time managing the test policy in a cil
> > > > module and a .te file. My inexperience with SELinux could be a reason
> > > > :)
> > > >
> > > > I defined 'anon_inode' class, like in this patch in the CIL module as follows:
> > > > (class anon_inode ())
> > > > (classcommon anon_inode file)
> > > > (classorder (unordered anon_inode))
> > > >
> > > > But then when I used anon_inode in the .te file as follows:
> > > > ...
> > > > type uffd_t;
> > > > type_transition test_userfaultfd_t test_userfaultfd_t : anon_inode
> > > > uffd_t "[userfaultfd]";
> > > > allow test_userfaultfd_t uffd_t:anon_inode { create ioctl read };
> > > >
> > > > I get a compile error:
> > > > test_policy.te:<line#>:ERROR 'unknown class anon_inode' at token ';' on line ...
> > > >
> > > > Any advice on where I am making mistakes?
> > >
> > > Ouch! No, the mistake is mine :) I forgot that the classes/permissions
> > > added via CIL won't be available in the refpolicy build
> > > infrastructure... But I think it should be possible to define the
> > > types and add basic rules for them in .te and only add the necessary
> > > userfaultfd rules in the .cil file:
> > >
> > > test_userfaultfd_newclass.cil:
> > > ```
> > > (class anon_inode ())
> > > (classcommon anon_inode file)
> > > (classorder (unordered anon_inode))
> > > (typeattributeset cil_gen_require test_userfaultfd_t)
> > > (typeattributeset cil_gen_require uffd_t)
> > > (typetransition test_userfaultfd_t test_userfaultfd_t anon_inode
> > > "[userfaultfd]" uffd_t)
> > > (allow test_userfaultfd_t uffd_t (anon_inode (create ioctl read)))
> > > [...]
> > > ```
> > >
> > > test_userfaultfd.te:
> > > ```
> > > type uffd_t;
> > > type test_userfaultfd_t;
> > > domain_type(test_userfaultfd_t)
> > > unconfined_runs_test(test_userfaultfd_t)
> > > typeattribute test_userfaultfd_t testdomain;
> > > [...]
> > > ```
> > >
> > Thanks for your prompt reply.
> >
> > IIUC, if I have to add policy for another process (say without read
> > permission), I''ll have to add the following lines in addition to the
> > above lines right:
> >
> > in test_userfaultfd_newclass.cil
> > ```
> > (typeattributeset cil_gen_require test_noread_userfaultfd_t)
> > (typetransition test_noread_userfaultfd_t test_noread_userfaultfd_t
> > anon_inode "[userfaultfd]" uffd_t)
> > (allow test_noread_userfaultfd_t uffd_t (anon_inode (create ioctl)))
> > [...]
> > ```
> > and in test_userfaultfd.te
> > ```
> > type test_noread_userfaultfd_t;
> > domain_type(test_noread_userfaultfd_t)
> > unconfined_runs_test(test_noread_userfaultfd_t)
> > typeattribute test_noread_userfaultfd_t testdomain;
> > [...]
> > ```
> >
> > Basically, in order to be able to use domain_type() and
> > unconfined_runs_test() interface, I need to write part of the policy
> > in the .te file. Is that right?
>
> Yes, exactly.

Thanks for confirming. With the above rules compilation is working
fine, but the test fails

Based on the tests/link/test, the command I'm using in the test script is:
$result = system "runcon -t test_userfaultfd_t $basedir/userfaultfd";

The error message is:
runcon: 'userfaultfd/userfaultfd': permission denied

Any suggestions?
>
> >
> > > We don't have an established way of handling the testing of new
> > > classes/permissions in the testsuite before they are defined in the
> > > distribution policy, but I think we could try this way here. The
> > > downside is that the rules are not in one place, but we can later
> > > merge everything into one .te file once the new class is widely
> > > available in the distribution policies.
> > >
> > > > > You will likely also need to communicate different locations of
> > > > > failures / error codes from the test program(s) to the script via exit
> > > > > code. See tests/keys for an example of such pattern (though you can
> > > > > use a different approach as long as it gets the job done :)
> > > > >
> > > > > Sorry for requiring all the effort, but we're trying to keep
> > > > > reasonably high standards for tests here. It's sometimes a PITA, but
> > > > > it pays off in the long run ;)
> > > > >
> > > > > Thanks,
> > > > >
> > > > > > +
> > > > > > +exit;
> > > > > > diff --git a/tests/userfaultfd/userfaultfd.c b/tests/userfaultfd/userfaultfd.c
> > > > > > new file mode 100644
> > > > > > index 0000000..9baebd9
> > > > > > --- /dev/null
> > > > > > +++ b/tests/userfaultfd/userfaultfd.c
> > > > > > @@ -0,0 +1,49 @@
> > > > > > +#include <stdio.h>
> > > > > > +#include <fcntl.h>
> > > > > > +#include <unistd.h>
> > > > > > +
> > > > > > +#include <sys/types.h>
> > > > > > +#include <sys/ioctl.h>
> > > > > > +#include <sys/syscall.h>
> > > > > > +
> > > > > > +#include <linux/userfaultfd.h>
> > > > > > +
> > > > > > +void print_api(const struct uffdio_api *api)
> > > > > > +{
> > > > > > +       printf("api: %llu\n", api->api);
> > > > > > +       printf("features: %llu\n", api->features);
> > > > > > +       printf("ioctls: %llu\n", api->ioctls);
> > > > > > +
> > > > > > +       printf("\n");
> > > > > > +}
> > > > > > +
> > > > > > +int main (void)
> > > > > > +{
> > > > > > +       long uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
> > > > > > +       if (uffd < 0) {
> > > > > > +               perror("syscall(userfaultfd)");
> > > > > > +               return -1;
> > > > > > +       }
> > > > > > +
> > > > > > +       struct uffdio_api api = {0};
> > > > > > +       api.api = UFFD_API;
> > > > > > +       if (ioctl(uffd, UFFDIO_API, &api) < 0) {
> > > > > > +               perror("UFFDIO_API");
> > > > > > +               return -1;
> > > > > > +       }
> > > > > > +
> > > > > > +       print_api(&api);
> > > > > > +
> > > > > > +       struct uffd_msg msg = {0};
> > > > > > +       ssize_t count = read(uffd, &msg, sizeof(msg));
> > > > > > +       if (count < 0) {
> > > > > > +               // Expected to fail as no memory range registered.
> > > > > > +               return 0;
> > > > > > +       } else if (count == 0) {
> > > > > > +               printf("read EOF\n\n");
> > > > > > +       }
> > > > > > +
> > > > > > +       printf("read uffd\n\n");
> > > > > > +
> > > > > > +       return 0;
> > > > > > +}
> > > > > > --
> > > > > > 2.28.0
> > > > > >
> > > > >
> > > > > --
> > > > > Ondrej Mosnacek
> > > > > Software Engineer, Platform Security - SELinux kernel
> > > > > Red Hat, Inc.
> > > > >
> > > >
> > >
> > >
> > > --
> > > Ondrej Mosnacek
> > > Software Engineer, Platform Security - SELinux kernel
> > > Red Hat, Inc.
> > >
> >
>
>
> --
> Ondrej Mosnacek
> Software Engineer, Platform Security - SELinux kernel
> Red Hat, Inc.
>
