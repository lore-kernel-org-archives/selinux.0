Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2L5XO3O025681
	for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2012 01:33:24 -0400
Date: Wed, 21 Mar 2012 05:33:31 +0000
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jan Stancek <jstancek@redhat.com>
Cc: selinux@tycho.nsa.gov, serge@hallyn.com, Jeffrey Burke <jburke@redhat.com>
Subject: Re: selinux-testsuite patches for RHEL5/6/7a
Message-ID: <20120321053331.GA18955@mail.hallyn.com>
References: <4F67040B.2000804@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F67040B.2000804@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks, Jan, I will take a look at this soon.

-serge

Quoting Jan Stancek (jstancek@redhat.com):
> Hi,
> 
> Couple months ago, selinux-testsuite has been removed from LTP and
> is currently hosted at:
> http://git.selinuxproject.org/git/?p=users/serge/selinux-testsuite.git;a=summary
> 
> After discussing this with Serge on LTP mailing list, he suggested
> this mailing list as likely candidate for future selinux-testsuite
> issues.
> 
> I'm attaching 7 patches. Some of these are backports from LTP, that
> didn't make it to current repo. Others are to make selinux-testsuite
> runnable in automated testing environment (beaker/rhts) for
> RHEL5/6/7a and Fedora16.
> 
> Jan Stancek (7):
>   fix hang on ppc64 and s390x
>   include test_bounds if version -ge 24
>   mkdir: look for selinuxfs
>   policy: allow to use leaked fd and console
>   rhel5: policy allow to use leaked fd and console
>   sigiotask: use pty, fix SIGIO race
>   test_global.te: add gen_require on privileged roles
> 
>  policy/Makefile                |    4 +++-
>  policy/redhat/5/test_file.te   |   13 +++++++++++++
>  policy/redhat/5/test_global.te |    5 +++++
>  policy/test_file.te            |   13 +++++++++++++
>  policy/test_global.te          |    9 +++++++++
>  policy/test_policy.if          |    5 +++++
>  tests/file/Makefile            |    1 +
>  tests/file/test_sigiotask.c    |   34 ++++++++++++++++++++++++++++------
>  tests/mkdir/test               |   17 ++++++++++++++++-
>  tests/msg/msgctl.c             |    2 +-
>  tests/msg/msgget.c             |    2 +-
>  tests/msg/msgrcv.c             |    2 +-
>  tests/msg/msgsnd.c             |    2 +-
>  tests/ptrace/wait              |    3 ++-
>  tests/sem/semctl.c             |    2 +-
>  tests/sem/semget.c             |    2 +-
>  tests/sem/semop.c              |    2 +-
>  17 files changed, 102 insertions(+), 16 deletions(-)
> 
> Regards,
> Jan

> >From c94a8894e989760140f975c893f73a3bc9ba57b3 Mon Sep 17 00:00:00 2001
> From: Jan Stancek <jstancek@redhat.com>
> Date: Wed, 18 Jan 2012 15:52:17 +0100
> Subject: [PATCH 1/7] fix hang on ppc64 and s390x
> 
> char is by default unsigned here, so code like:
>   while ((ch = getopt(argc, argv, "k:-n:")) != EOF)
> will loop forever.
> 
> Change it to int.
> Also change ptrace/wait to sleep without opening tty and
> busy looping. (as in upstream ltp-20101031)
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  tests/msg/msgctl.c |    2 +-
>  tests/msg/msgget.c |    2 +-
>  tests/msg/msgrcv.c |    2 +-
>  tests/msg/msgsnd.c |    2 +-
>  tests/ptrace/wait  |    3 ++-
>  tests/sem/semctl.c |    2 +-
>  tests/sem/semget.c |    2 +-
>  tests/sem/semop.c  |    2 +-
>  8 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/tests/msg/msgctl.c b/tests/msg/msgctl.c
> index cddfd16..56e2955 100644
> --- a/tests/msg/msgctl.c
> +++ b/tests/msg/msgctl.c
> @@ -6,7 +6,7 @@
>  
>  int main(int argc, char **argv)
>  {
> -	char ch;
> +	int ch;
>  	int key = 0x8888;
>  	int id;
>  	int error;
> diff --git a/tests/msg/msgget.c b/tests/msg/msgget.c
> index 00ed831..44f37d0 100644
> --- a/tests/msg/msgget.c
> +++ b/tests/msg/msgget.c
> @@ -6,7 +6,7 @@
>  
>  int main(int argc, char **argv)
>  {
> -	char ch;
> +	int ch;
>  	int key = 0x8888;
>  	int id;
>  	int perms = 0444;
> diff --git a/tests/msg/msgrcv.c b/tests/msg/msgrcv.c
> index e4966af..b23c801 100644
> --- a/tests/msg/msgrcv.c
> +++ b/tests/msg/msgrcv.c
> @@ -13,7 +13,7 @@ struct msgbuf {
>  
>  int main(int argc, char **argv)
>  {
> -	char ch;
> +	int ch;
>  	int key = 0x8888;
>  	int id;
>  	int error;
> diff --git a/tests/msg/msgsnd.c b/tests/msg/msgsnd.c
> index 8ebe489..e200aef 100644
> --- a/tests/msg/msgsnd.c
> +++ b/tests/msg/msgsnd.c
> @@ -14,7 +14,7 @@ struct msgbuf {
>  
>  int main(int argc, char **argv)
>  {
> -	char ch;
> +	int ch;
>  	int key = 0x8888;
>  	int id;
>  	int error;
> diff --git a/tests/ptrace/wait b/tests/ptrace/wait
> index 6d354db..6a0b6bb 100755
> --- a/tests/ptrace/wait
> +++ b/tests/ptrace/wait
> @@ -1,4 +1,5 @@
>  #!/usr/bin/perl
>  
> -while (<>) {
> +while () {
> +    sleep 1;
>  }
> diff --git a/tests/sem/semctl.c b/tests/sem/semctl.c
> index a6bef73..765095d 100644
> --- a/tests/sem/semctl.c
> +++ b/tests/sem/semctl.c
> @@ -18,7 +18,7 @@ union semun {
>  
>  int main(int argc, char **argv)
>  {
> -	char ch;
> +	int ch;
>  	int num = 1;
>  	int key = 0x8888;
>  	int id;
> diff --git a/tests/sem/semget.c b/tests/sem/semget.c
> index 155e028..0d86c67 100644
> --- a/tests/sem/semget.c
> +++ b/tests/sem/semget.c
> @@ -6,7 +6,7 @@
>  
>  int main(int argc, char **argv)
>  {
> -	char ch;
> +	int ch;
>  	int num = 1;
>  	int key = 0x8888;
>  	int id;
> diff --git a/tests/sem/semop.c b/tests/sem/semop.c
> index 9388dde..c65e59e 100644
> --- a/tests/sem/semop.c
> +++ b/tests/sem/semop.c
> @@ -6,7 +6,7 @@
>  
>  int main(int argc, char **argv)
>  {
> -	char ch;
> +	int ch;
>  	int num = 1;
>  	int key = 0x8888;
>  	int id;
> -- 
> 1.7.1
> 

> >From 3788eab4ef02bdbd3f830c9867d2442e4e0ddfad Mon Sep 17 00:00:00 2001
> From: Jan Stancek <jstancek@redhat.com>
> Date: Wed, 18 Jan 2012 08:22:03 -0500
> Subject: [PATCH 2/7] include test_bounds if version -ge 24
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  policy/Makefile |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/policy/Makefile b/policy/Makefile
> index 301f918..5791c2b 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -16,7 +16,9 @@ test_sigkill.te test_stat.te test_sysctl.te test_task_create.te \
>  test_task_getpgid.te test_task_getsched.te test_task_getsid.te \
>  test_task_setpgid.te test_task_setsched.te test_transition.te test_wait.te
>  
> -ifeq ($(VERS),24)
> +VERS_GE_24 := $(shell [ $(VERS) -ge 24 ] && echo true )
> +
> +ifeq ($(VERS_GE_24),true)
>  TARGETS+= test_bounds.te
>  endif
>  
> -- 
> 1.7.1
> 

> >From 5994b19bd60f78fb81caeca9c7898452159d0f2b Mon Sep 17 00:00:00 2001
> From: Jan Stancek <jstancek@redhat.com>
> Date: Wed, 18 Jan 2012 08:54:00 -0500
> Subject: [PATCH 3/7] mkdir: look for selinuxfs
> 
> This test relied on having selinuxfs at /selinux,
> which is no longer true for new distros (Fedora16).
> 
> This patch will look for selinuxfs in mount output,
> and then it tries few known locations.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  tests/mkdir/test |   17 ++++++++++++++++-
>  1 files changed, 16 insertions(+), 1 deletions(-)
> 
> diff --git a/tests/mkdir/test b/tests/mkdir/test
> index f64eaed..4f00c8d 100755
> --- a/tests/mkdir/test
> +++ b/tests/mkdir/test
> @@ -5,7 +5,22 @@ BEGIN { plan tests => 5}
>  
>  $basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
>  
> -$mls = `cat /selinux/mls`;
> +$selinux_mntpoint = `mount | grep "^selinuxfs" | awk '{ORS="";print \$3}'`;
> +if (-e "$selinux_mntpoint/mls") {
> +    print "selinuxfs found at: $selinux_mntpoint\n";
> +} else {
> +    print "selinuxfs not found in mount list\n";
> +    @locations = ('/selinux', '/sys/fs/selinux');
> +    foreach (@locations) {
> +        if (-e "$_/mls") {
> +            $selinux_mntpoint = $_;
> +            print "selinuxfs found at: $selinux_mntpoint\n";
> +            last;
> +        }
> +    }
> +}
> +
> +$mls = `cat $selinux_mntpoint/mls`;
>  if ($mls eq 1) {
>  	$suffix = ":s0";
>  } else {
> -- 
> 1.7.1
> 

> >From 7d2b3559eae554f05c61c2e04fef340ccb4a8ce3 Mon Sep 17 00:00:00 2001
> From: Jan Stancek <jstancek@redhat.com>
> Date: Thu, 19 Jan 2012 14:54:39 +0100
> Subject: [PATCH 4/7] policy: allow to use leaked fd and console
> 
> Tests running automatically are started by init,
> and some fds may leak to test itself.
> 
> So while test works when run manually, it was failing
> in automated environment. Allowing tests to use leaked fd/console
> fixes this issue.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  policy/test_global.te |    3 +++
>  policy/test_policy.if |    5 +++++
>  2 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/policy/test_global.te b/policy/test_global.te
> index b4a08d4..cf39fb5 100644
> --- a/policy/test_global.te
> +++ b/policy/test_global.te
> @@ -63,6 +63,9 @@ require {
>  	type devtty_t;
>  	type null_device_t;
>  	type zero_device_t;
> +	type init_t;
> +	type initrc_t;
> +	type console_device_t;
>  }
>  allow testdomain { root_t etc_t bin_t sbin_t lib_t usr_t devpts_t }:dir list_dir_perms;
>  allow testdomain lib_t:file read_file_perms;
> diff --git a/policy/test_policy.if b/policy/test_policy.if
> index 264a099..5f4000f 100644
> --- a/policy/test_policy.if
> +++ b/policy/test_policy.if
> @@ -41,6 +41,11 @@ interface(`unconfined_runs_test',`
>        allow $1 unconfined_devpts_t:chr_file { read write ioctl getattr };
>        allow $1 unconfined_t:fifo_file { read write ioctl getattr };
>        allow $1 unconfined_t:process { sigchld };
> +
> +      # allow to use leaked fd from init/init scripts
> +      allow $1 init_t:fd use;
> +      allow $1 initrc_t:fd use;
> +      allow $1 console_device_t:chr_file { read write ioctl };
>  ')
>  
>  ifdef(`userdom_sysadm_entry_spec_domtrans_to',`', ` dnl
> -- 
> 1.7.1
> 

> >From 59d732b5a80fd6e145e7e0e202c04bf3aabaae32 Mon Sep 17 00:00:00 2001
> From: Jan Stancek <jstancek@redhat.com>
> Date: Thu, 19 Jan 2012 14:20:13 +0100
> Subject: [PATCH 5/7] rhel5: policy allow to use leaked fd and console
> 
> This is for tests running automatically, started by init,
> fds may leak to test. Also allow to use console device.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  policy/redhat/5/test_global.te |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/policy/redhat/5/test_global.te b/policy/redhat/5/test_global.te
> index 1cd5d92..f40494d 100644
> --- a/policy/redhat/5/test_global.te
> +++ b/policy/redhat/5/test_global.te
> @@ -63,11 +63,16 @@ require {
>  	type devtty_t;
>  	type null_device_t;
>  	type zero_device_t;
> +	type init_t;
> +	type initrc_t;
> +	type console_device_t;
>  }
>  allow testdomain { root_t etc_t bin_t sbin_t lib_t usr_t devpts_t }:dir r_dir_perms;
>  allow testdomain lib_t:{ file lnk_file } r_file_perms;
>  allow testdomain etc_t:file r_file_perms;
>  allow testdomain { devtty_t null_device_t zero_device_t }:chr_file rw_file_perms;
> +allow testdomain { init_t initrc_t }:fd use;
> +allow testdomain { console_device_t }:chr_file { read write ioctl };
>  miscfiles_read_localization(testdomain)
>  domain_use_interactive_fds(testdomain)
>  seutil_read_config(testdomain)
> -- 
> 1.7.1
> 

> >From d359e74c31b7a860ddb0aab7f0ccd9cd790c5e38 Mon Sep 17 00:00:00 2001
> From: Jan Stancek <jstancek@redhat.com>
> Date: Thu, 19 Jan 2012 14:15:45 +0100
> Subject: [PATCH 6/7] sigiotask: use pty, fix SIGIO race
> 
> ctermid returns controlling terminal, which may not be present
> in some situations, e.g. running in automated test environment.
> 
> Make a pty and use that for test.
> 
> $ ps afx -o pid,comm:50,tty
> 30625 rc                                                 ?
> 30705  \_ S99test                                        ?
> 30706      \_ test.sh                                    ?
> 30709          \_ test_sigiotask                         ?
> 30711          |   \_ wait_io                            ?
> 
> Also move sleep right after fork.
> If the fcntl occurs before child sets up its signal handler
> and there is some new data on tty then it will die by SIGIO.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  policy/redhat/5/test_file.te |   13 +++++++++++++
>  policy/test_file.te          |   13 +++++++++++++
>  tests/file/Makefile          |    1 +
>  tests/file/test_sigiotask.c  |   34 ++++++++++++++++++++++++++++------
>  4 files changed, 55 insertions(+), 6 deletions(-)
> 
> diff --git a/policy/redhat/5/test_file.te b/policy/redhat/5/test_file.te
> index b484a6e..698626f 100644
> --- a/policy/redhat/5/test_file.te
> +++ b/policy/redhat/5/test_file.te
> @@ -19,6 +19,12 @@ domain_obj_id_change_exemption(test_nofileop_t)
>  typeattribute test_nofileop_t fileopdomain;
>  typeattribute test_nofileop_t testdomain;
>  
> +require {
> +	type ptmx_t;
> +	type devpts_t;
> +}
> +
> +
>  # Type for temp test files
>  type fileop_file_t;
>  files_type(fileop_file_t)
> @@ -72,13 +78,20 @@ allow test_nofileop_t fileop_t:fd use;
>  allow fileop_t test_nofileop_t:fd use;
>  allow fileop_t test_nofileop_t:fifo_file rw_file_perms;
>  allow fileop_t test_nofileop_t:process sigchld;
> +allow fileop_t ptmx_t:chr_file { read write };
>  
>  # Permissions for the 'good' domain...
>  allow test_fileop_t fileop_file_t:file { setattr rw_file_perms};
>  allow test_fileop_t fileop_file_t:file { execute relabelfrom relabelto };
>  allow test_fileop_t fileop_t:process { signal };
> +allow test_fileop_t ptmx_t:chr_file { read write ioctl };
> +allow test_fileop_t devpts_t:filesystem getattr;
> +allow test_fileop_t self:capability sys_admin;
>  
>  # Permissions for the 'bad' domain...
>  allow test_nofileop_t nofileop_rw_file_t:file { read write append relabelfrom };
>  allow test_nofileop_t nofileop_ra_file_t:file { read append };
>  allow test_nofileop_t fileop_file_t:file { relabelto };
> +allow test_nofileop_t ptmx_t:chr_file { read write ioctl };
> +allow test_nofileop_t devpts_t:filesystem getattr;
> +allow test_nofileop_t self:capability sys_admin;
> diff --git a/policy/test_file.te b/policy/test_file.te
> index 53a1af4..0d4525d 100644
> --- a/policy/test_file.te
> +++ b/policy/test_file.te
> @@ -21,6 +21,12 @@ domain_obj_id_change_exemption(test_nofileop_t)
>  typeattribute test_nofileop_t fileopdomain;
>  typeattribute test_nofileop_t testdomain;
>  
> +require {
> +	type ptmx_t;
> +	type devpts_t;
> +}
> +
> +
>  # Type for temp test files
>  type fileop_file_t;
>  files_type(fileop_file_t)
> @@ -71,13 +77,20 @@ allow test_nofileop_t fileop_t:fd use;
>  allow fileop_t test_nofileop_t:fd use;
>  allow fileop_t test_nofileop_t:fifo_file rw_file_perms;
>  allow fileop_t test_nofileop_t:process sigchld;
> +allow fileop_t ptmx_t:chr_file { read write };
>  
>  # Permissions for the 'good' domain...
>  allow test_fileop_t fileop_file_t:file { setattr rw_file_perms};
>  allow test_fileop_t fileop_file_t:file { execute relabelfrom relabelto };
>  allow test_fileop_t fileop_t:process { signal };
> +allow test_fileop_t ptmx_t:chr_file { open read write ioctl };
> +allow test_fileop_t devpts_t:filesystem getattr;
> +allow test_fileop_t self:capability sys_admin;
>  
>  # Permissions for the 'bad' domain...
>  allow test_nofileop_t nofileop_rw_file_t:file { open read write append relabelfrom };
>  allow test_nofileop_t nofileop_ra_file_t:file { open read append };
>  allow test_nofileop_t fileop_file_t:file { relabelto };
> +allow test_nofileop_t ptmx_t:chr_file { open read write ioctl };
> +allow test_nofileop_t devpts_t:filesystem getattr;
> +allow test_nofileop_t self:capability sys_admin;
> diff --git a/tests/file/Makefile b/tests/file/Makefile
> index cea3d50..a9ff509 100644
> --- a/tests/file/Makefile
> +++ b/tests/file/Makefile
> @@ -1,5 +1,6 @@
>  TARGETS=$(patsubst %.c,%,$(wildcard *.c))
>  LDLIBS += -lselinux
> +test_sigiotask: LDLIBS += -lutil
>  all: $(TARGETS)
>  clean:
>  	rm -f $(TARGETS)
> diff --git a/tests/file/test_sigiotask.c b/tests/file/test_sigiotask.c
> index ee33d0d..7f50217 100644
> --- a/tests/file/test_sigiotask.c
> +++ b/tests/file/test_sigiotask.c
> @@ -13,6 +13,7 @@
>  #include<signal.h>
>  #include<asm/ioctls.h>
>  #include <libgen.h>
> +#include <pty.h>
>  
>  /*
>   * Test the sigio operations by creating a child and registering that process
> @@ -27,12 +28,25 @@ int main(int argc, char **argv) {
>    pid_t pid;
>    char key = '\r';
>  
> -  fd = open(ctermid(NULL), O_RDWR, 0);
> -  
> -  if(fd == -1) {
> -    perror("test_sigiotask:open");
> +  /*
> +   * ctermid returns controlling terminal, which could be console, pts,..
> +   * It may not be present in some situations, e.g. running in automated test
> +   * environment, where init/service spawning this test has not ctty:
> +   * if (fork() > 0) {
> +   *   _exit(0);
> +   * }
> +   * setsid();
> +   */
> +  pid_t ret;
> +  int master, slave;
> +
> +  ret = openpty(&master, &slave, NULL, NULL, NULL);
> +  if (ret == -1)
> +  {
> +    perror("test_sigiotask:openpty");
>      exit(2);
>    }
> +  fd = slave;
>  
>   /*
>    * Spawn off the child process to handle the information protocol.
> @@ -55,6 +69,14 @@ int main(int argc, char **argv) {
>      }
>    }
>  
> +  /* Allow the child time to start up.
> +   * If the fcntls below occurs before child sets up its signal handler
> +   * and there is some new data on tty then it will die by SIGIO.
> +   * Example 1: fd is /dev/console and kernel prints message to it
> +   * Example 2: if you run it through ptrace, ptrace will print to the same fd
> +   */
> +  sleep(1);
> +
>    /*
>     * parent process
>     */
> @@ -82,7 +104,6 @@ int main(int argc, char **argv) {
>      exit(2);
>    }
>  
> -  sleep(1);          /* Allow the child time to start up */
>    rc = ioctl(fd, TIOCSTI, &key);  /* Send a key to the tty device */
>    if( rc == -1 ) {
>      perror("test_sigiotask:write");
> @@ -91,7 +112,8 @@ int main(int argc, char **argv) {
>    close(fd);
>    wait(&rc);
>    if( WIFEXITED(rc) ) {   /* exit status from child is normal? */
> -    printf("%s:  exiting with %d\n", argv[0], WIFEXITED(rc));
> +    printf("%s:  child exited OK %d\n", argv[0], WIFEXITED(rc));
> +    printf("%s:  exiting with %d\n", argv[0], WEXITSTATUS(rc));
>      exit(WEXITSTATUS(rc));
>    } else {
>      printf("%s:  error exit\n", argv[0]);
> -- 
> 1.7.1
> 

> >From 0642409e23203addb83f1fb290e982dd08f5d161 Mon Sep 17 00:00:00 2001
> From: Jan Stancek <jstancek@redhat.com>
> Date: Wed, 18 Jan 2012 08:57:33 -0500
> Subject: [PATCH 7/7] test_global.te: add gen_require on privileged roles
> 
> in version 26, (Fedora 16), this is required to compile policy
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  policy/test_global.te |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/policy/test_global.te b/policy/test_global.te
> index cf39fb5..77121ae 100644
> --- a/policy/test_global.te
> +++ b/policy/test_global.te
> @@ -7,6 +7,12 @@ policy_module(test_policy,1.0.0)
>  #
>  attribute testdomain;
>  
> +gen_require(`
> +	role staff_r;
> +	role system_r;
> +	role sysadm_r;
> +')
> +
>  # Authorize sysadm_r and system_r for the test domains.
>  role sysadm_r types testdomain;
>  role system_r types testdomain;
> -- 
> 1.7.1
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
