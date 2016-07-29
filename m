Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6TDdsJK001456
 for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2016 09:39:54 -0400
Received: by mail-oi0-f65.google.com with SMTP id w143so7562053oiw.2
 for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2016 06:39:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1469717017-19818-1-git-send-email-sds@tycho.nsa.gov>
References: <1469717017-19818-1-git-send-email-sds@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 29 Jul 2016 09:39:49 -0400
Message-ID: <CAHC9VhTQfcMR8_RCo_hxEjOMsDi_cTrgCO2udPWQAqrVnU6pVg@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: Add test for execstack on thread
 stacks.
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jul 28, 2016 at 10:43 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Test execstack permission checking for thread stacks.
> The test is conditional on Linux >= 4.7.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
> Revised to make it conditional on the kernel version in which
> the corresponding change was merged, so it passes on old and new kernels.
>
>  tests/mmap/Makefile                |  2 ++
>  tests/mmap/mprotect_stack_thread.c | 58 ++++++++++++++++++++++++++++++++++++++
>  tests/mmap/test                    |  8 +++++-
>  3 files changed, 67 insertions(+), 1 deletion(-)
>  create mode 100644 tests/mmap/mprotect_stack_thread.c

With v4.7 released, and the newly added conditionals, I see no reason
not to merge this patch (as well as the userns cap test) into the
master branch.  Can you think of any reason why not?

> diff --git a/tests/mmap/Makefile b/tests/mmap/Makefile
> index f2f486c..e330f3e 100644
> --- a/tests/mmap/Makefile
> +++ b/tests/mmap/Makefile
> @@ -1,5 +1,7 @@
>  TARGETS=$(patsubst %.c,%,$(wildcard *.c))
>
> +LDLIBS += -lpthread
> +
>  all: $(TARGETS)
>
>  clean:
> diff --git a/tests/mmap/mprotect_stack_thread.c b/tests/mmap/mprotect_stack_thread.c
> new file mode 100644
> index 0000000..fed9969
> --- /dev/null
> +++ b/tests/mmap/mprotect_stack_thread.c
> @@ -0,0 +1,58 @@
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <stdbool.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <sys/mman.h>
> +#include <sys/utsname.h>
> +#include <pthread.h>
> +
> +static void *test_thread(void *p)
> +{
> +       char buf[4096];
> +       int rc;
> +       void *ptr;
> +       long pagesize = sysconf(_SC_PAGESIZE);
> +
> +       ptr = (void *) (((unsigned long) buf) & ~(pagesize - 1));
> +
> +       rc = mprotect(ptr, pagesize, PROT_READ | PROT_WRITE | PROT_EXEC);
> +       if (rc < 0) {
> +               perror("mprotect");
> +               exit(1);
> +       }
> +       return NULL;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +       struct utsname uts;
> +       pthread_t thread;
> +
> +       if (argc != 2) {
> +               fprintf(stderr, "usage: %s [pass|fail]\n", argv[0]);
> +               exit(1);
> +       }
> +
> +       if (strcmp(argv[1], "pass") && strcmp(argv[1], "fail")) {
> +               fprintf(stderr, "usage: %s [pass|fail]\n", argv[0]);
> +               exit(1);
> +       }
> +
> +       if (uname(&uts) < 0) {
> +               perror("uname");
> +               exit(1);
> +       }
> +
> +       if (!strcmp(argv[1], "fail") && strverscmp(uts.release, "4.7") < 0) {
> +               printf("%s: Kernels < 4.7 do not check execstack on thread stacks, skipping.\n", argv[0]);
> +               /* pass the test by failing as if it was denied */
> +               exit(1);
> +       }
> +
> +       pthread_create(&thread, NULL, test_thread, NULL);
> +       pthread_join(thread, NULL);
> +       exit(0);
> +}
> +
> diff --git a/tests/mmap/test b/tests/mmap/test
> index 6b1de55..e1c2942 100755
> --- a/tests/mmap/test
> +++ b/tests/mmap/test
> @@ -1,7 +1,7 @@
>  #!/usr/bin/perl
>
>  use Test;
> -BEGIN { plan tests => 30}
> +BEGIN { plan tests => 32}
>
>  $basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
>
> @@ -68,6 +68,12 @@ ok($result, 0);
>  $result = system "runcon -t test_execmem_t $basedir/mprotect_stack 2>&1";
>  ok($result);
>
> +# Test success and failure for thread execstack, independent of execmem.
> +$result = system "runcon -t test_execstack_t $basedir/mprotect_stack_thread pass";
> +ok($result, 0);
> +$result = system "runcon -t test_execmem_t $basedir/mprotect_stack_thread fail 2>&1";
> +ok($result);
> +
>  # Test success and failure for file execute on mmap w/ file shared mapping.
>  $result = system "runcon -t test_file_rwx_t $basedir/mmap_file_shared $basedir/temp_file";
>  ok($result, 0);
> --
> 2.5.5
>



-- 
paul moore
www.paul-moore.com
