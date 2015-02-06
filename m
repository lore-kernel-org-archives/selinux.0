From: Paul Moore <pmoore@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH v3] selinux-testsuite: Add tests for exec transitions
 under NO_NEW_PRIVS.
Date: Fri, 06 Feb 2015 17:32:31 -0500
Message-ID: <1607321.abVqrnHGgM@sifl>
In-Reply-To: <1423150970-8272-1-git-send-email-sds@tycho.nsa.gov>
References: <1423150970-8272-1-git-send-email-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thursday, February 05, 2015 10:42:50 AM Stephen Smalley wrote:
> commit 7b0d0b40cd78cadb525df760ee4cac151533c2b5 / v3.18 introduced
> support for bounded transitions under NO_NEW_PRIVS.  Add tests to
> confirm that bounded transitions are permitted under NO_NEW_PRIVS
> and that unbounded transitions are denied under NO_NEW_PRIVS.
> The test logic checks for the correct result on both old (pre-3.18)
> and new (3.18 or later) kernels.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

Merged, thanks.

> diff --git a/policy/Makefile b/policy/Makefile
> index a0a6c88..683f454 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -14,7 +14,7 @@ TARGETS = \
>  	test_entrypoint.te test_execshare.te test_exectrace.te \
>  	test_execute_no_trans.te test_fdreceive.te test_file.te \
>  	test_inherit.te test_ioctl.te test_ipc.te test_link.te test_mkdir.te \
> -	test_open.te test_ptrace.te test_readlink.te \
> +	test_nnp.te test_open.te test_ptrace.te test_readlink.te \
>  	test_relabel.te test_rename.te test_rxdir.te test_setattr.te \
>  	test_setnice.te test_sigkill.te test_stat.te test_sysctl.te \
>  	test_task_create.te test_task_getpgid.te test_task_getsched.te \
> diff --git a/policy/test_nnp.te b/policy/test_nnp.te
> new file mode 100644
> index 0000000..69cd714
> --- /dev/null
> +++ b/policy/test_nnp.te
> @@ -0,0 +1,33 @@
> +#################################
> +#
> +# Policy for testing NO_NEW_PRIVS transitions.
> +#
> +
> +# A domain bounded by the unconfined domain.
> +type test_nnp_bounded_t;
> +domain_type(test_nnp_bounded_t)
> +typeattribute test_nnp_bounded_t testdomain;
> +typebounds unconfined_t test_nnp_bounded_t;
> +
> +# The entrypoint type for this domain.
> +type test_nnp_bounded_exec_t;
> +files_type(test_nnp_bounded_exec_t)
> +domain_entry_file(test_nnp_bounded_t, test_nnp_bounded_exec_t)
> +
> +# Run it!  This should succeed on v3.18 or later, fail on older kernels.
> +unconfined_runs_test(test_nnp_bounded_t)
> +unconfined_run_to(test_nnp_bounded_t, test_nnp_bounded_exec_t)
> +
> +# A domain that is not bounded by the unconfined domain.
> +type test_nnp_notbounded_t;
> +domain_type(test_nnp_notbounded_t)
> +typeattribute test_nnp_notbounded_t testdomain;
> +
> +# The entrypoint type for this domain.
> +type test_nnp_notbounded_exec_t;
> +files_type(test_nnp_notbounded_exec_t)
> +domain_entry_file(test_nnp_notbounded_t, test_nnp_notbounded_exec_t)
> +
> +# Run it!  This should fail always.
> +unconfined_runs_test(test_nnp_notbounded_t)
> +unconfined_run_to(test_nnp_notbounded_t, test_nnp_notbounded_exec_t)
> diff --git a/tests/Makefile b/tests/Makefile
> index 5886403..4cfecdf 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -1,6 +1,6 @@
>  REDHAT_RELEASE=$(shell rpm -q redhat-release)
> 
> -SUBDIRS=domain_trans entrypoint execshare exectrace execute_no_trans
> fdreceive inherit link mkdir msg open ptrace readlink relabel rename rxdir
> sem setattr setnice shm sigkill stat sysctl task_create task_setnice
> task_setscheduler task_getscheduler task_getsid task_getpgid task_setpgid
> wait file ioctl capable_file capable_net capable_sys dyntrans dyntrace
> bounds +SUBDIRS=domain_trans entrypoint execshare exectrace
> execute_no_trans fdreceive inherit link mkdir msg nnp open ptrace readlink
> relabel rename rxdir sem setattr setnice shm sigkill stat sysctl
> task_create task_setnice task_setscheduler task_getscheduler task_getsid
> task_getpgid task_setpgid wait file ioctl capable_file capable_net
> capable_sys dyntrans dyntrace bounds #SUBDIRS=socket unix_socket
> unix_secure
> 
>  ifeq (redhat-release-4, $(findstring redhat-release-4, $(REDHAT_RELEASE)))
> diff --git a/tests/nnp/Makefile b/tests/nnp/Makefile
> new file mode 100644
> index 0000000..4e8e400
> --- /dev/null
> +++ b/tests/nnp/Makefile
> @@ -0,0 +1,7 @@
> +TARGETS=execnnp checkcon
> +
> +LDLIBS += -lselinux
> +
> +all: $(TARGETS)
> +clean:
> +	rm -f $(TARGETS)
> diff --git a/tests/nnp/checkcon.c b/tests/nnp/checkcon.c
> new file mode 100644
> index 0000000..d8a1e15
> --- /dev/null
> +++ b/tests/nnp/checkcon.c
> @@ -0,0 +1,41 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <stdbool.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <selinux/selinux.h>
> +#include <selinux/context.h>
> +
> +int main(int argc, char **argv)
> +{
> +	char *con = NULL;
> +	context_t c;
> +	const char *type;
> +	int rc;
> +
> +	if (argc != 2) {
> +		fprintf(stderr, "usage:  %s expected-type\n", argv[0]);
> +		exit(-1);
> +	}
> +
> +	if (getcon(&con) < 0) {
> +		perror("getcon");
> +		exit(-1);
> +	}
> +
> +	c = context_new(con);
> +	if (!c) {
> +		perror("context_new");
> +		exit(-1);
> +	}
> +
> +	type = context_type_get(c);
> +	if (!type) {
> +		perror("context_type_get");
> +		exit(-1);
> +
> +	}
> +
> +	rc = strcmp(type, argv[1]);
> +	exit(rc);
> +}
> diff --git a/tests/nnp/execnnp.c b/tests/nnp/execnnp.c
> new file mode 100644
> index 0000000..a5a80cf
> --- /dev/null
> +++ b/tests/nnp/execnnp.c
> @@ -0,0 +1,61 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <stdbool.h>
> +#include <unistd.h>
> +#include <sys/utsname.h>
> +#include <sys/prctl.h>
> +
> +int main(int argc, char **argv)
> +{
> +	bool nobounded;
> +	struct utsname uts;
> +	pid_t pid;
> +	int rc, status;
> +
> +	if (argc < 2) {
> +		fprintf(stderr, "usage:  %s command [args...]\n", argv[0]);
> +		exit(-1);
> +	}
> +
> +	if (uname(&uts) < 0) {
> +		perror("uname");
> +		exit(-1);
> +	}
> +
> +	nobounded = ((strcmp(argv[argc-1], "test_nnp_bounded_t") == 0) &&
> +		     (strverscmp(uts.release, "3.18") < 0));
> +
> +	rc = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
> +	if (rc < 0) {
> +		perror("prctl PR_SET_NO_NEW_PRIVS");
> +		exit(-1);
> +	}
> +
> +	pid = fork();
> +	if (pid < 0) {
> +		perror("fork");
> +		exit(-1);
> +	}
> +
> +	if (pid == 0) {
> +		execvp(argv[1], &argv[1]);
> +		perror(argv[1]);
> +		exit(-1);
> +	}
> +
> +	pid = wait(&status);
> +	if (WIFEXITED(status)) {
> +		if (nobounded) {
> +			if (!WEXITSTATUS(status))
> +				exit(-1);
> +			printf("%s:  Kernels < v3.18 do not support bounded transitions 
under
> NNP.\n", argv[0]); +			/* pass the test */
> +			exit(0);
> +		}
> +		exit(WEXITSTATUS(status));
> +	}
> +
> +	fprintf(stderr, "Unexpected exit status 0x%x\n", status);
> +	exit(-1);
> +}
> diff --git a/tests/nnp/test b/tests/nnp/test
> new file mode 100755
> index 0000000..4aaed94
> --- /dev/null
> +++ b/tests/nnp/test
> @@ -0,0 +1,39 @@
> +#!/usr/bin/perl
> +
> +use Test;
> +BEGIN { plan tests => 4}
> +
> +$basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
> +
> +# Remove any leftover programs from prior failed runs.
> +system("rm -f $basedir/true");
> +
> +# Set entrypoint type for bounded domain.
> +system("chcon -t test_nnp_bounded_exec_t $basedir/checkcon");
> +
> +# Transition to bounded type via setexec.
> +$result = system("$basedir/execnnp runcon -t test_nnp_bounded_t
> $basedir/checkcon test_nnp_bounded_t 2>&1"); +ok($result,0); #this should
> pass
> +
> +# Automatic transition to bounded domain via exec.
> +$result = system("$basedir/execnnp $basedir/checkcon test_nnp_bounded_t
> 2>&1"); +ok($result,0); #this should pass
> +
> +# Use true as an entrypoint program to test ability to exec at all.
> +system("cp /bin/true $basedir/true");
> +
> +# Set entrypoint type for notbounded domain.
> +system("chcon -t test_nnp_notbounded_exec_t $basedir/checkcon
> $basedir/true"); +
> +# Transition to notbounded domain via setexec.
> +$result = system("$basedir/execnnp runcon -t test_nnp_notbounded_t
> $basedir/true 2>&1"); +ok($result); #this should fail
> +
> +# Automatic transition to notbounded domain via exec.
> +$result = system("$basedir/execnnp $basedir/checkcon test_nnp_notbounded_t
> 2>&1"); +ok($result); #this should fail
> +
> +# Cleanup.
> +system("rm -f $basedir/true");
> +
> +exit;

-- 
paul moore
security @ redhat
