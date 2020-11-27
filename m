Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A386C2D0E4
	for <selinux@archiver.kernel.org>; Fri, 27 Nov 2020 14:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DFD2206D8
	for <selinux@archiver.kernel.org>; Fri, 27 Nov 2020 14:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dbT30QDJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbgK0OJr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Nov 2020 09:09:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50440 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730041AbgK0OJr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Nov 2020 09:09:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606486185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=meDPKdqd4LzZfPoOuYxIyEjMtj3ik22Yz1rL6E3ciEY=;
        b=dbT30QDJWelUGJ7g5D5aLzplxQwjJMI0703khx8JicKwPPtUdUBlcScOUeoeWRsUbnudAe
        RCIcgLZgI3ia+dTw6cI/Y9Jzizb5rvKswNFMWYEdpMWLR/AGkC6bdi5pdxgU+QE8BbSmoi
        1HuFTs1kvhV+kW3k3ZQkMlvUXstretk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-9uk_VLiOPz28LrXhbT5ZTA-1; Fri, 27 Nov 2020 09:09:43 -0500
X-MC-Unique: 9uk_VLiOPz28LrXhbT5ZTA-1
Received: by mail-lf1-f70.google.com with SMTP id s23so1978573lfi.1
        for <selinux@vger.kernel.org>; Fri, 27 Nov 2020 06:09:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=meDPKdqd4LzZfPoOuYxIyEjMtj3ik22Yz1rL6E3ciEY=;
        b=OTYm5EO3JxigbFtivYnq959dFul092T6mOtqFKF1CP3HUWs7SHwcOM6LpaswoUoug5
         y8IOY1OceoocNnCAq92pCJxqHWuzOpMW0pCSOwhOW/yHcHYIxyZ2d8jckW+PY1pPGAL+
         AnmHrDHr6PFgkW4ciPiE1INtqERJ6uOMBhpVOcd58DQVBdV8kcwtx/Au0gsqNteyT35h
         15FYe9VvhFRJ0Cezq2yuogJ2WZYC6YFGXtTDCJ8/N7w8VqwLWBoHngEspVgKGO2HJcm1
         shnuLWHA/b+g/LulrYSOY02ejw1xQN1fhxeKi80cVlDcxCFEDDG80uDEP5espSbAs0MD
         8BGg==
X-Gm-Message-State: AOAM533rnv8bVg9L50JuDXtILwwunqiXDSK36WhdryiHie9AOXVWKS4K
        pEcc3VEUa37+ljcFc0DOXtUvQ4oHLK/r4lakafVPCPmRJVPCXXo5jZn4BkQDbbm3Owz43TrPgSe
        ZKVI6ZM3Ivz0qtiE2IAfUQhzvkv30LNFSqg==
X-Received: by 2002:a2e:808a:: with SMTP id i10mr3357904ljg.123.1606486180454;
        Fri, 27 Nov 2020 06:09:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJznixCjJkaSd9MWeUMqwF0AOkUKDqPKG2VWTYLNR0mnxCtFd0XnJqFzrVrc9GxzS2xBDK7LQb7YCX8+2Fl71eU=
X-Received: by 2002:a2e:808a:: with SMTP id i10mr3357881ljg.123.1606486180071;
 Fri, 27 Nov 2020 06:09:40 -0800 (PST)
MIME-Version: 1.0
References: <20201125125402.211692-1-lokeshgidra@google.com>
In-Reply-To: <20201125125402.211692-1-lokeshgidra@google.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 27 Nov 2020 15:09:29 +0100
Message-ID: <CAFqZXNsry1zqGND-iBaYmwb_KeCvoat-LQFywf04TAp998sqXQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] selinux-testsuite: Add userfaultfd test
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>, kaleshsingh@google.com,
        calin@google.com, surenb@google.com,
        Jeff Vander Stoep <jeffv@google.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Lokesh,

On Wed, Nov 25, 2020 at 1:54 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> Confirm SELinux policies are enforced on userfaultfd operations
> via secure anon-inode interface.
>
> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> ---
>  policy/Makefile                 |  2 +-
>  policy/userfaultfd.cil          | 17 ++++++++++++
>  tests/Makefile                  |  2 +-
>  tests/userfaultfd/Makefile      |  3 ++
>  tests/userfaultfd/test          | 15 ++++++++++
>  tests/userfaultfd/userfaultfd.c | 49 +++++++++++++++++++++++++++++++++
>  6 files changed, 86 insertions(+), 2 deletions(-)
>  create mode 100644 policy/userfaultfd.cil
>  create mode 100644 tests/userfaultfd/Makefile
>  create mode 100755 tests/userfaultfd/test
>  create mode 100644 tests/userfaultfd/userfaultfd.c
>
> diff --git a/policy/Makefile b/policy/Makefile
> index 6c49091..02e7568 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -36,7 +36,7 @@ SUPPORTS_CIL = n
>  endif
>
>  ifeq ($(SUPPORTS_CIL),y)
> -CIL_TARGETS = test_mlsconstrain.cil test_overlay_defaultrange.cil
> +CIL_TARGETS = test_mlsconstrain.cil test_overlay_defaultrange.cil userfaultfd.cil
>  ifeq ($(shell [ $(MAX_KERNEL_POLICY) -ge 32 ] && echo true),true)
>  ifeq ($(shell [ $(POL_VERS) -ge 32 ] && echo true),true)
>  # If other MLS tests get written this can be moved outside of the glblub test
> diff --git a/policy/userfaultfd.cil b/policy/userfaultfd.cil
> new file mode 100644
> index 0000000..0743fff
> --- /dev/null
> +++ b/policy/userfaultfd.cil
> @@ -0,0 +1,17 @@
> +(class anon_inode ())
> +(classcommon anon_inode file)
> +(classorder (unordered anon_inode))
> +(type uffd_t)
> +; Label the UFFD with uffd_t; this can be specialized per domain
> +(typetransition unconfined_t unconfined_t anon_inode "[userfaultfd]"    uffd_t)
> +(allow unconfined_t uffd_t (anon_inode (create)))
> +; Permit read() and ioctl() on the UFFD;
> +; Comment out if you want to test read or basic ioctl enforcement.
> +(allow unconfined_t uffd_t (anon_inode (read)))
> +(allow unconfined_t uffd_t (anon_inode (ioctl)))
> +; Uncomment one of the allowx lines below to test ioctl whitelisting.
> +; Currently the first one is uncommented; comment that out if trying another.
> +; None
> +;(allowx unconfined_t uffd_t (ioctl anon_inode ((0x00))))
> +; UFFDIO_API
> +(allowx unconfined_t uffd_t (ioctl anon_inode ((0xaa3f))))
> diff --git a/tests/Makefile b/tests/Makefile
> index 4c00b5f..3871570 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -27,7 +27,7 @@ SUBDIRS:= domain_trans entrypoint execshare exectrace execute_no_trans \
>         task_setnice task_setscheduler task_getscheduler task_getsid \
>         task_getpgid task_setpgid file ioctl capable_file capable_net \
>         capable_sys dyntrans dyntrace bounds nnp_nosuid mmap unix_socket \
> -       inet_socket overlay checkreqprot mqueue mac_admin atsecure
> +       inet_socket overlay checkreqprot mqueue mac_admin atsecure userfaultfd
>
>  ifeq ($(shell grep -q cap_userns $(POLDEV)/include/support/all_perms.spt && echo true),true)
>  ifneq ($(shell ./kvercmp $$(uname -r) 4.7),-1)
> diff --git a/tests/userfaultfd/Makefile b/tests/userfaultfd/Makefile
> new file mode 100644
> index 0000000..66d02a1
> --- /dev/null
> +++ b/tests/userfaultfd/Makefile
> @@ -0,0 +1,3 @@
> +all: userfaultfd
> +clean:
> +       rm -f userfaultfd
> diff --git a/tests/userfaultfd/test b/tests/userfaultfd/test
> new file mode 100755
> index 0000000..dd42aa8
> --- /dev/null
> +++ b/tests/userfaultfd/test
> @@ -0,0 +1,15 @@
> +#!/usr/bin/perl
> +
> +use Test;
> +
> +BEGIN {
> +    plan tests => 1;
> +}
> +
> +$basedir = $0;
> +$basedir =~ s|(.*)/[^/]*|$1|;
> +
> +$result = system("$basedir/userfaultfd");
> +ok( $result, 0 );

This is a good start, but it is only a very basic test :)

I would expect at least these tests here:
1. that an userfaultfd node created by a domain *without* the
transition rule gets the context of the creating process (should be
possible by calling fgetxattr(2) on the fd),
2. that an userfaultfd node created by a domain *with* the transition
rule gets the context specified by the rule,
3. that a process with context that is *allowed* to { create read
write [...] } a given userfaultfd type by the policy *can* indeed
successfully perform these operations (or at least that the error
returned is not -EACCESS),
4. that a process with context that is *NOT allowed* to { create read
write [...] } a given userfaultfd type by the policy *cannot* perform
these operations and the error returned is -EACCESS.

(The more permissions you can test the better, but I'd like to see at
least the three (create, read, write).)

For this, you will need to define several process types in the test
policy and run the test program(s) with a specific type using runcon
(see e.g. policy/test_link.te and tests/link/test for a simple
example). I suggest using the CIL module only for adding the class and
permissions and a separate .te file to define the process and
userfaultfd types (so that you can use the unconfined_runs_test()
interface for common permissions needed for the process types).

You will likely also need to communicate different locations of
failures / error codes from the test program(s) to the script via exit
code. See tests/keys for an example of such pattern (though you can
use a different approach as long as it gets the job done :)

Sorry for requiring all the effort, but we're trying to keep
reasonably high standards for tests here. It's sometimes a PITA, but
it pays off in the long run ;)

Thanks,

> +
> +exit;
> diff --git a/tests/userfaultfd/userfaultfd.c b/tests/userfaultfd/userfaultfd.c
> new file mode 100644
> index 0000000..9baebd9
> --- /dev/null
> +++ b/tests/userfaultfd/userfaultfd.c
> @@ -0,0 +1,49 @@
> +#include <stdio.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +
> +#include <sys/types.h>
> +#include <sys/ioctl.h>
> +#include <sys/syscall.h>
> +
> +#include <linux/userfaultfd.h>
> +
> +void print_api(const struct uffdio_api *api)
> +{
> +       printf("api: %llu\n", api->api);
> +       printf("features: %llu\n", api->features);
> +       printf("ioctls: %llu\n", api->ioctls);
> +
> +       printf("\n");
> +}
> +
> +int main (void)
> +{
> +       long uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
> +       if (uffd < 0) {
> +               perror("syscall(userfaultfd)");
> +               return -1;
> +       }
> +
> +       struct uffdio_api api = {0};
> +       api.api = UFFD_API;
> +       if (ioctl(uffd, UFFDIO_API, &api) < 0) {
> +               perror("UFFDIO_API");
> +               return -1;
> +       }
> +
> +       print_api(&api);
> +
> +       struct uffd_msg msg = {0};
> +       ssize_t count = read(uffd, &msg, sizeof(msg));
> +       if (count < 0) {
> +               // Expected to fail as no memory range registered.
> +               return 0;
> +       } else if (count == 0) {
> +               printf("read EOF\n\n");
> +       }
> +
> +       printf("read uffd\n\n");
> +
> +       return 0;
> +}
> --
> 2.28.0
>

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

