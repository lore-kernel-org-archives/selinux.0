Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0CG7hAB010080
 for <selinux@tycho.nsa.gov>; Thu, 12 Jan 2017 11:07:46 -0500
Received: by mail-vk0-f68.google.com with SMTP id n19so1739380vkd.3
 for <selinux@tycho.nsa.gov>; Thu, 12 Jan 2017 08:07:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484080670-31273-1-git-send-email-sds@tycho.nsa.gov>
References: <1484080670-31273-1-git-send-email-sds@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 12 Jan 2017 11:07:37 -0500
Message-ID: <CAHC9VhS-nhecSHW0X50busSvn3A1vfu6aZMsbuir+Nngzyq2YA@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: remove wait test
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Jan 10, 2017 at 3:37 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> With the removal of the security_task_wait() hook, we also need to
> drop the corresponding test from the selinux testsuite.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  policy/Makefile     |  2 +-
>  policy/test_wait.te | 45 --------------------------------
>  tests/Makefile      |  2 +-
>  tests/wait/Makefile |  6 -----
>  tests/wait/child.c  |  7 -----
>  tests/wait/parent.c | 74 -----------------------------------------------------
>  tests/wait/test     | 15 -----------
>  7 files changed, 2 insertions(+), 149 deletions(-)
>  delete mode 100644 policy/test_wait.te
>  delete mode 100644 tests/wait/Makefile
>  delete mode 100644 tests/wait/child.c
>  delete mode 100644 tests/wait/parent.c
>  delete mode 100755 tests/wait/test

Looks good.  I can go ahead and merge this while I'm merging a bunch
of other stuff today ...

> diff --git a/policy/Makefile b/policy/Makefile
> index 992278b..6a9e6e4 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -20,7 +20,7 @@ TARGETS = \
>         test_task_create.te test_task_getpgid.te test_task_getsched.te \
>         test_task_getsid.te test_task_setpgid.te test_task_setsched.te \
>         test_transition.te test_inet_socket.te test_unix_socket.te \
> -       test_wait.te test_mmap.te test_overlayfs.te test_mqueue.te
> +       test_mmap.te test_overlayfs.te test_mqueue.te
>
>  ifeq ($(shell [ $(POL_VERS) -ge 24 ] && echo true),true)
>  TARGETS += test_bounds.te
> diff --git a/policy/test_wait.te b/policy/test_wait.te
> deleted file mode 100644
> index 78c8861..0000000
> --- a/policy/test_wait.te
> +++ /dev/null
> @@ -1,45 +0,0 @@
> -#################################
> -#
> -# Policy for testing the task_wait hook
> -#
> -
> -attribute waitdomain;
> -
> -# Domain for parent process.
> -type test_wait_parent_t;
> -domain_type(test_wait_parent_t)
> -unconfined_runs_test(test_wait_parent_t)
> -typeattribute test_wait_parent_t waitdomain;
> -typeattribute test_wait_parent_t testdomain;
> -
> -# Domain for child process that can be reaped by the parent.
> -type test_wait_child_t;
> -domain_type(test_wait_child_t)
> -unconfined_runs_test(test_wait_child_t)
> -typeattribute test_wait_child_t waitdomain;
> -typeattribute test_wait_child_t testdomain;
> -
> -# Domain for child process that cannot be reaped by the parent.
> -type test_wait_notchild_t;
> -domain_type(test_wait_notchild_t)
> -unconfined_runs_test(test_wait_notchild_t)
> -typeattribute test_wait_notchild_t waitdomain;
> -typeattribute test_wait_notchild_t testdomain;
> -
> -# Allow all of these domains to be entered from the sysadm domain.
> -miscfiles_domain_entry_test_files(waitdomain)
> -userdom_sysadm_entry_spec_domtrans_to(waitdomain)
> -
> -# Grant permissions for a domain transition from parent to child,
> -# including the ability to wait on the child.
> -domain_trans(test_wait_parent_t, test_file_t, test_wait_child_t)
> -allow test_wait_parent_t test_wait_child_t:fd use;
> -allow test_wait_child_t test_wait_parent_t:fd use;
> -allow test_wait_child_t test_wait_parent_t:fifo_file rw_file_perms;
> -allow test_wait_child_t test_wait_parent_t:process sigchld;
> -
> -# Permit the parent to transition to the notchild, but don't
> -# grant the permission to wait on it.
> -allow test_wait_parent_t test_wait_notchild_t:process transition;
> -allow test_wait_notchild_t test_wait_parent_t:fd use;
> -allow test_wait_notchild_t test_file_t:file entrypoint;
> diff --git a/tests/Makefile b/tests/Makefile
> index 228b764..53f256a 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -8,7 +8,7 @@ SUBDIRS:=domain_trans entrypoint execshare exectrace execute_no_trans \
>         fdreceive inherit link mkdir msg open ptrace readlink relabel rename \
>         rxdir sem setattr setnice shm sigkill stat sysctl task_create \
>         task_setnice task_setscheduler task_getscheduler task_getsid \
> -       task_getpgid task_setpgid wait file ioctl capable_file capable_net \
> +       task_getpgid task_setpgid file ioctl capable_file capable_net \
>         capable_sys dyntrans dyntrace bounds nnp mmap unix_socket inet_socket \
>         overlay checkreqprot mqueue
>
> diff --git a/tests/wait/Makefile b/tests/wait/Makefile
> deleted file mode 100644
> index 1cf884c..0000000
> --- a/tests/wait/Makefile
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -TARGETS=parent child
> -LDLIBS += -lselinux
> -
> -all: $(TARGETS)
> -clean:
> -       rm -f $(TARGETS)
> diff --git a/tests/wait/child.c b/tests/wait/child.c
> deleted file mode 100644
> index d80c613..0000000
> --- a/tests/wait/child.c
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -#include <stdlib.h>
> -
> -int main(void)
> -{
> -       exit(0);
> -}
> -
> diff --git a/tests/wait/parent.c b/tests/wait/parent.c
> deleted file mode 100644
> index c4d1800..0000000
> --- a/tests/wait/parent.c
> +++ /dev/null
> @@ -1,74 +0,0 @@
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <unistd.h>
> -#include <sys/types.h>
> -#include <sys/wait.h>
> -#include <signal.h>
> -#include <selinux/selinux.h>
> -#include <selinux/context.h>
> -
> -int main(int argc, char **argv)
> -{
> -       int pid, rc, status;
> -       security_context_t context_s;
> -       context_t context;
> -
> -       if (argc != 3) {
> -               fprintf(stderr, "usage:  %s newdomain program\n", argv[0]);
> -               exit(-1);
> -       }
> -
> -       rc = getcon(&context_s);
> -       if (rc < 0) {
> -               fprintf(stderr, "%s:  unable to get my context\n", argv[0]);
> -               exit(-1);
> -
> -       }
> -
> -       context = context_new(context_s);
> -       if (!context) {
> -               fprintf(stderr, "%s:  unable to create context structure\n", argv[0]);
> -               exit(-1);
> -       }
> -
> -       if (context_type_set(context, argv[1])) {
> -               fprintf(stderr, "%s:  unable to set new type\n", argv[0]);
> -               exit(-1);
> -       }
> -
> -       freecon(context_s);
> -       context_s = context_str(context);
> -       if (!context_s) {
> -               fprintf(stderr, "%s:  unable to obtain new context string\n", argv[0]);
> -               exit(-1);
> -       }
> -
> -       rc = setexeccon(context_s);
> -       if (rc < 0) {
> -               fprintf(stderr, "%s:  unable to set exec context to %s\n", argv[0], context_s);
> -               exit(-1);
> -       }
> -
> -       pid = fork();
> -       if (pid < 0) {
> -               perror("fork");
> -               exit(-1);
> -       } else if (pid == 0) {
> -               rc = execv(argv[2], argv + 2);
> -               perror(argv[3]);
> -               exit(1);
> -       }
> -
> -       pid = wait(&status);
> -       if (pid < 0) {
> -               perror("wait");
> -               exit(1);
> -       }
> -
> -       if (WIFEXITED(status)) {
> -               exit(WEXITSTATUS(status));
> -       }
> -
> -       exit(-1);
> -}
> -
> diff --git a/tests/wait/test b/tests/wait/test
> deleted file mode 100755
> index 6302885..0000000
> --- a/tests/wait/test
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -#!/usr/bin/perl
> -
> -use Test;
> -BEGIN { plan tests => 2}
> -
> -$basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
> -
> -# Verify that test_wait_parent_t can wait on test_wait_child_t.
> -$result = system ("runcon -t test_wait_parent_t -- $basedir/parent test_wait_child_t $basedir/child 2>&1");
> -ok($result, 0);
> -
> -# Verify that test_wait_parent_t cannot wait on test_wait_notchild_t.
> -$result = system ("runcon -t test_wait_parent_t -- $basedir/parent test_wait_notchild_t $basedir/child 2>&1");
> -ok($result);
> -
> --
> 2.7.4
>



-- 
paul moore
www.paul-moore.com
