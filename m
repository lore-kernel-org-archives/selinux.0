Message-ID: <1500998367.22271.11.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Date: Tue, 25 Jul 2017 11:59:27 -0400
In-Reply-To: <20170725155542.32496-1-sds@tycho.nsa.gov>
References: <20170725155542.32496-1-sds@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-iRP59sxtmKnBjwA86uQo"
Mime-Version: 1.0
Subject: Re: [PATCH] selinux-testsuite: Add tests for transitions under
 NNP/nosuid
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--=-iRP59sxtmKnBjwA86uQo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Tue, 2017-07-25 at 11:55 -0400, Stephen Smalley wrote:
> Duplicate the existing tests for transitions under NNP for
> transitions on a nosuid mount, and then augment both the NNP
> and nosuid tests to also test the new support for allowing
> transitions based on nnp_transition and/or nosuid_transition
> permission if the nnp_nosuid_transition policy capability is
> enabled.

NB: To actually exercise the new tests for nnp/nosuid_transition, you
need to rebuild your libsepol and policy with the attached patches
(relative to upstream libsepol and  Fedora selinux-policy SRPM,
respectively) and you need to be running a kernel with the
corresponding kernel patch.

However, this patch can be applied now without causing breakage; the
tests that depend on the kernel patch will be automatically skipped
with kernels and/or policies that do not support nnp_nosuid_transition.

> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  policy/Makefile           |  6 ++-
>  policy/test_nnp.te        | 17 +++++++++
>  policy/test_nosuid.te     | 51 ++++++++++++++++++++++++++
>  tests/Makefile            |  2 +-
>  tests/nnp/test            | 40 +++++++++++++++++++-
>  tests/nosuid/Makefile     |  7 ++++
>  tests/nosuid/checkcon.c   | 41 +++++++++++++++++++++
>  tests/nosuid/execnosuid.c | 55 ++++++++++++++++++++++++++++
>  tests/nosuid/test         | 93
> +++++++++++++++++++++++++++++++++++++++++++++++
>  9 files changed, 309 insertions(+), 3 deletions(-)
>  create mode 100644 policy/test_nosuid.te
>  create mode 100644 tests/nosuid/Makefile
>  create mode 100644 tests/nosuid/checkcon.c
>  create mode 100644 tests/nosuid/execnosuid.c
>  create mode 100755 tests/nosuid/test
> 
> diff --git a/policy/Makefile b/policy/Makefile
> index b728a9e..7cdee96 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -23,7 +23,7 @@ TARGETS = \
>  	test_task_getsid.te test_task_setpgid.te
> test_task_setsched.te \
>  	test_transition.te test_inet_socket.te test_unix_socket.te \
>  	test_mmap.te test_overlayfs.te test_mqueue.te
> test_mac_admin.te \
> -	test_ibpkey.te test_atsecure.te
> +	test_ibpkey.te test_atsecure.te test_nosuid.te
>  
>  ifeq ($(shell [ $(POL_VERS) -ge 24 ] && echo true),true)
>  TARGETS += test_bounds.te
> @@ -57,6 +57,10 @@ ifeq ($(shell grep -q all_file_perms.*map
> $(POLDEV)/include/support/all_perms.sp
>  export M4PARAM = -Dmap_permission_defined
>  endif
>  
> +ifeq ($(shell grep -q nnp_transition
> $(POLDEV)/include/support/all_perms.spt && echo true),true)
> +export M4PARAM += -Dnnp_transition_permission_defined
> +endif
> +
>  ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
>  TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te, $(TARGETS))
>  endif
> diff --git a/policy/test_nnp.te b/policy/test_nnp.te
> index 54ebfd3..b99e406 100644
> --- a/policy/test_nnp.te
> +++ b/policy/test_nnp.te
> @@ -32,3 +32,20 @@ domain_entry_file(test_nnp_notbounded_t,
> test_nnp_notbounded_exec_t)
>  # Run it!  This should fail always.
>  unconfined_runs_test(test_nnp_notbounded_t)
>  unconfined_run_to(test_nnp_notbounded_t, test_nnp_notbounded_exec_t)
> +
> +# A domain to which the unconfined domain is allowed nnp_transition.
> +type test_nnp_nnptransition_t;
> +domain_type(test_nnp_nnptransition_t)
> +typeattribute test_nnp_nnptransition_t testdomain;
> +
> +# The entrypoint type for this domain.
> +type test_nnp_nnptransition_exec_t;
> +files_type(test_nnp_nnptransition_exec_t)
> +domain_entry_file(test_nnp_nnptransition_t,
> test_nnp_nnptransition_exec_t)
> +
> +# Run it!  This should succeed on v4.14 or later.
> +unconfined_runs_test(test_nnp_nnptransition_t)
> +unconfined_run_to(test_nnp_nnptransition_t,
> test_nnp_nnptransition_exec_t)
> +ifdef(`nnp_transition_permission_defined', `
> +allow unconfined_t test_nnp_nnptransition_t:process nnp_transition;
> +')
> diff --git a/policy/test_nosuid.te b/policy/test_nosuid.te
> new file mode 100644
> index 0000000..0d3d2ab
> --- /dev/null
> +++ b/policy/test_nosuid.te
> @@ -0,0 +1,51 @@
> +#################################
> +#
> +# Policy for testing nosuid transitions.
> +#
> +
> +# A domain bounded by the unconfined domain.
> +type test_nosuid_bounded_t;
> +domain_type(test_nosuid_bounded_t)
> +typeattribute test_nosuid_bounded_t testdomain;
> +typebounds unconfined_t test_nosuid_bounded_t;
> +
> +# The entrypoint type for this domain.
> +type test_nosuid_bounded_exec_t;
> +files_type(test_nosuid_bounded_exec_t)
> +domain_entry_file(test_nosuid_bounded_t, test_nosuid_bounded_exec_t)
> +domain_entry_file(unconfined_t, test_nosuid_bounded_exec_t)
> +
> +# Run it!  This should succeed on v3.18 or later, fail on older
> kernels.
> +unconfined_runs_test(test_nosuid_bounded_t)
> +unconfined_run_to(test_nosuid_bounded_t, test_nosuid_bounded_exec_t)
> +
> +# A domain that is not bounded by the unconfined domain.
> +type test_nosuid_notbounded_t;
> +domain_type(test_nosuid_notbounded_t)
> +typeattribute test_nosuid_notbounded_t testdomain;
> +
> +# The entrypoint type for this domain.
> +type test_nosuid_notbounded_exec_t;
> +files_type(test_nosuid_notbounded_exec_t)
> +domain_entry_file(test_nosuid_notbounded_t,
> test_nosuid_notbounded_exec_t)
> +
> +# Run it!  This should fail always.
> +unconfined_runs_test(test_nosuid_notbounded_t)
> +unconfined_run_to(test_nosuid_notbounded_t,
> test_nosuid_notbounded_exec_t)
> +
> +# A domain to which the unconfined domain is allowed
> nosuid_transition.
> +type test_nosuid_nosuidtransition_t;
> +domain_type(test_nosuid_nosuidtransition_t)
> +typeattribute test_nosuid_nosuidtransition_t testdomain;
> +
> +# The entrypoint type for this domain.
> +type test_nosuid_nosuidtransition_exec_t;
> +files_type(test_nosuid_nosuidtransition_exec_t)
> +domain_entry_file(test_nosuid_nosuidtransition_t,
> test_nosuid_nosuidtransition_exec_t)
> +
> +# Run it!  This should succeed on v4.14 or later.
> +unconfined_runs_test(test_nosuid_nosuidtransition_t)
> +unconfined_run_to(test_nosuid_nosuidtransition_t,
> test_nosuid_nosuidtransition_exec_t)
> +ifdef(`nnp_transition_permission_defined', `
> +allow unconfined_t test_nosuid_nosuidtransition_t:process2
> nosuid_transition;
> +')
> diff --git a/tests/Makefile b/tests/Makefile
> index f42fe7e..3edf73c 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -11,7 +11,7 @@ SUBDIRS:= domain_trans entrypoint execshare
> exectrace execute_no_trans \
>  	task_getpgid task_setpgid file ioctl capable_file
> capable_net \
>  	capable_sys dyntrans dyntrace bounds nnp mmap unix_socket
> inet_socket \
>  	overlay checkreqprot mqueue mac_admin infiniband_pkey \
> -	infiniband_endport atsecure
> +	infiniband_endport atsecure nosuid
>  
>  ifeq ($(shell grep -q cap_userns
> $(POLDEV)/include/support/all_perms.spt && echo true),true)
>  ifneq ($(shell ./kvercmp $$(uname -r) 4.7),-1)
> diff --git a/tests/nnp/test b/tests/nnp/test
> index 4c7e010..6dcb5dc 100755
> --- a/tests/nnp/test
> +++ b/tests/nnp/test
> @@ -1,7 +1,23 @@
>  #!/usr/bin/perl
>  
>  use Test;
> -BEGIN { plan tests => 4 }
> +
> +BEGIN {
> +    $test_count          = 4;
> +    $test_nnp_transition = 0;
> +
> +    if (
> +        system(
> +"grep -q 1 /sys/fs/selinux/policy_capabilities/nnp_nosuid_transition
> 2> /dev/null"
> +        ) == 0
> +      )
> +    {
> +        $test_nnp_transition = 1;
> +        $test_count += 2;
> +    }
> +
> +    plan tests => $test_count;
> +}
>  
>  $basedir = $0;
>  $basedir =~ s|(.*)/[^/]*|$1|;
> @@ -38,6 +54,28 @@ $result =
>    system("$basedir/execnnp $basedir/checkcon test_nnp_notbounded_t
> 2>&1");
>  ok($result);         #this should fail
>  
> +if ($test_nnp_transition) {
> +
> +    # Set entrypoint type for nnptransition domain.
> +    system(
> +        "chcon -t test_nnp_nnptransition_exec_t $basedir/checkcon
> $basedir/true"
> +    );
> +
> +    # Transition to nnptransition domain via setexec.
> +    $result =
> +      system(
> +        "$basedir/execnnp runcon -t test_nnp_nnptransition_t
> $basedir/true 2>&1"
> +      );
> +    ok( $result, 0 );    #this should succeed
> +
> +    # Automatic transition to nnptransition domain via exec.
> +    $result =
> +      system(
> +        "$basedir/execnnp $basedir/checkcon test_nnp_nnptransition_t
> 2>&1");
> +    ok( $result, 0 );    #this should succeed
> +
> +}
> +
>  # Cleanup.
>  system("rm -f $basedir/true");
>  
> diff --git a/tests/nosuid/Makefile b/tests/nosuid/Makefile
> new file mode 100644
> index 0000000..239e0f0
> --- /dev/null
> +++ b/tests/nosuid/Makefile
> @@ -0,0 +1,7 @@
> +TARGETS=execnosuid checkcon
> +
> +LDLIBS += -lselinux
> +
> +all: $(TARGETS)
> +clean:
> +	rm -f $(TARGETS)
> diff --git a/tests/nosuid/checkcon.c b/tests/nosuid/checkcon.c
> new file mode 100644
> index 0000000..d8a1e15
> --- /dev/null
> +++ b/tests/nosuid/checkcon.c
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
> +		fprintf(stderr, "usage:  %s expected-type\n",
> argv[0]);
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
> diff --git a/tests/nosuid/execnosuid.c b/tests/nosuid/execnosuid.c
> new file mode 100644
> index 0000000..4324937
> --- /dev/null
> +++ b/tests/nosuid/execnosuid.c
> @@ -0,0 +1,55 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <stdbool.h>
> +#include <unistd.h>
> +#include <sys/utsname.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +
> +int main(int argc, char **argv)
> +{
> +	bool nobounded;
> +	struct utsname uts;
> +	pid_t pid;
> +	int rc, status;
> +
> +	if (argc < 2) {
> +		fprintf(stderr, "usage:  %s command [args...]\n",
> argv[0]);
> +		exit(-1);
> +	}
> +
> +	if (uname(&uts) < 0) {
> +		perror("uname");
> +		exit(-1);
> +	}
> +
> +	nobounded = ((strcmp(argv[argc - 1],
> "test_nosuid_bounded_t") == 0) &&
> +		     (strverscmp(uts.release, "3.18") < 0));
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
> +		if (WEXITSTATUS(status) && nobounded) {
> +			printf("%s:  Kernels < v3.18 do not support
> bounded transitions under NNP.\n",
> +			       argv[0]);
> +			/* pass the test */
> +			exit(0);
> +		}
> +		exit(WEXITSTATUS(status));
> +	}
> +
> +	fprintf(stderr, "Unexpected exit status 0x%x\n", status);
> +	exit(-1);
> +}
> diff --git a/tests/nosuid/test b/tests/nosuid/test
> new file mode 100755
> index 0000000..cd46109
> --- /dev/null
> +++ b/tests/nosuid/test
> @@ -0,0 +1,93 @@
> +#!/usr/bin/perl
> +
> +use Test;
> +
> +BEGIN {
> +    $test_count             = 4;
> +    $test_nosuid_transition = 0;
> +
> +    if (
> +        system(
> +"grep -q 1 /sys/fs/selinux/policy_capabilities/nnp_nosuid_transition
> 2> /dev/null"
> +        ) == 0
> +      )
> +    {
> +        $test_nosuid_transition = 1;
> +        $test_count += 2;
> +    }
> +
> +    plan tests => $test_count;
> +}
> +
> +$basedir = $0;
> +$basedir =~ s|(.*)/[^/]*|$1|;
> +
> +# Create nosuid mount.
> +system("mkdir -p $basedir/testdir");
> +system("mount -t tmpfs -o nosuid none $basedir/testdir");
> +
> +# Set entrypoint type for bounded domain.
> +system("cp $basedir/checkcon $basedir/testdir");
> +system("chcon -t test_nosuid_bounded_exec_t
> $basedir/testdir/checkcon");
> +
> +# Transition to bounded type via setexec.
> +$result = system(
> +"$basedir/execnosuid runcon -t test_nosuid_bounded_t
> $basedir/testdir/checkcon test_nosuid_bounded_t 2>&1"
> +);
> +ok( $result, 0 );    #this should pass
> +
> +# Automatic transition to bounded domain via exec.
> +$result = system(
> +    "$basedir/execnosuid $basedir/testdir/checkcon
> test_nosuid_bounded_t 2>&1");
> +ok( $result, 0 );    #this should pass
> +
> +# Use true as an entrypoint program to test ability to exec at all.
> +system("cp /bin/true $basedir/testdir/true");
> +
> +# Set entrypoint type for notbounded domain.
> +system(
> +"chcon -t test_nosuid_notbounded_exec_t $basedir/testdir/checkcon
> $basedir/testdir/true"
> +);
> +
> +# Transition to notbounded domain via setexec.
> +$result =
> +  system(
> +"$basedir/execnosuid runcon -t test_nosuid_notbounded_t
> $basedir/testdir/true 2>&1"
> +  );
> +ok($result);    #this should fail
> +
> +# Automatic transition to notbounded domain via exec.
> +$result =
> +  system(
> +"$basedir/execnosuid $basedir/testdir/checkcon
> test_nosuid_notbounded_t 2>&1"
> +  );
> +ok($result);    #this should fail
> +
> +if ($test_nosuid_transition) {
> +
> +    # Set entrypoint type for nosuid domain.
> +    system(
> +"chcon -t test_nosuid_nosuidtransition_exec_t
> $basedir/testdir/checkcon $basedir/testdir/true"
> +    );
> +
> +    # Transition to nosuid domain via setexec.
> +    $result =
> +      system(
> +"$basedir/execnosuid runcon -t test_nosuid_nosuidtransition_t
> $basedir/testdir/true 2>&1"
> +      );
> +    ok( $result, 0 );    #this should succeed
> +
> +    # Automatic transition to nosuid domain via exec.
> +    $result =
> +      system(
> +"$basedir/execnosuid $basedir/testdir/checkcon
> test_nosuid_nosuidtransition_t 2>&1"
> +      );
> +    ok( $result, 0 );    #this should succeed
> +
> +}
> +
> +# Cleanup.
> +system("umount $basedir/testdir");
> +system("rmdir $basedir/testdir");
> +
> +exit;
--=-iRP59sxtmKnBjwA86uQo
Content-Disposition: attachment;
	filename*0=0001-libsepol-Define-nnp_nosuid_transition-policy-capabil.pat;
	filename*1=ch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch;
	name="0001-libsepol-Define-nnp_nosuid_transition-policy-capabil.patch";
	charset="UTF-8"

RnJvbSBjNzFlNDA2NmUyNzNmNjY5Y2RkZjk0Y2U2M2VhOTkxMzIyMWQwYmYxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGVwaGVuIFNtYWxsZXkgPHNkc0B0eWNoby5uc2EuZ292PgpE
YXRlOiBGcmksIDE0IEp1bCAyMDE3IDEyOjExOjQwIC0wNDAwClN1YmplY3Q6IFtQQVRDSF0gbGli
c2Vwb2w6IERlZmluZSBubnBfbm9zdWlkX3RyYW5zaXRpb24gcG9saWN5IGNhcGFiaWxpdHkKCkRl
ZmluZSB0aGUgbm5wX25vc3VpZF90cmFuc2l0aW9uIHBvbGljeSBjYXBhYmlsaXR5IHVzZWQgdG8g
ZW5hYmxlClNFTGludXggZG9tYWluIHRyYW5zaXRpb25zIHVuZGVyIE5OUCBvciBub3N1aWQgaWYg
dGhlCm5ucF90cmFuc2l0aW9uIHBlcm1pc3Npb24gb3Igbm9zdWlkX3RyYW5zaXRpb24gcGVybWlz
c2lvbiBpcwphbGxvd2VkIGJldHdlZW4gdGhlIG9sZCBhbmQgbmV3IGNvbnRleHRzLiBXaGVuIHRo
aXMgY2FwYWJpbGl0eSBpcyBub3QKZW5hYmxlZCwgc3VjaCB0cmFuc2l0aW9ucyByZW1haW4gbGlt
aXRlZCB0byBib3VuZGVkIHRyYW5zaXRpb25zIGFzIHRoZXkKd2VyZSBwcmlvciB0byB0aGUgaW50
cm9kdWN0aW9uIG9mIHRoaXMgY2FwYWJpbGl0eS4KClNpZ25lZC1vZmYtYnk6IFN0ZXBoZW4gU21h
bGxleSA8c2RzQHR5Y2hvLm5zYS5nb3Y+Ci0tLQogbGlic2Vwb2wvaW5jbHVkZS9zZXBvbC9wb2xp
Y3lkYi9wb2xjYXBzLmggfCAxICsKIGxpYnNlcG9sL3NyYy9wb2xjYXBzLmMgICAgICAgICAgICAg
ICAgICAgIHwgMSArCiAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL2xpYnNlcG9sL2luY2x1ZGUvc2Vwb2wvcG9saWN5ZGIvcG9sY2Fwcy5oIGIvbGlic2Vwb2wv
aW5jbHVkZS9zZXBvbC9wb2xpY3lkYi9wb2xjYXBzLmgKaW5kZXggMDg3NTQxZDEuLmRjOTM1NmE2
IDEwMDY0NAotLS0gYS9saWJzZXBvbC9pbmNsdWRlL3NlcG9sL3BvbGljeWRiL3BvbGNhcHMuaAor
KysgYi9saWJzZXBvbC9pbmNsdWRlL3NlcG9sL3BvbGljeWRiL3BvbGNhcHMuaApAQCAtMTIsNiAr
MTIsNyBAQCBlbnVtIHsKIAlQT0xJQ1lEQl9DQVBBQklMSVRZX0VYVFNPQ0tDTEFTUywKIAlQT0xJ
Q1lEQl9DQVBBQklMSVRZX0FMV0FZU05FVFdPUkssCiAJUE9MSUNZREJfQ0FQQUJJTElUWV9DR1JP
VVBTRUNMQUJFTCwKKwlQT0xJQ1lEQl9DQVBBQklMSVRZX05OUF9OT1NVSURfVFJBTlNJVElPTiwK
IAlfX1BPTElDWURCX0NBUEFCSUxJVFlfTUFYCiB9OwogI2RlZmluZSBQT0xJQ1lEQl9DQVBBQklM
SVRZX01BWCAoX19QT0xJQ1lEQl9DQVBBQklMSVRZX01BWCAtIDEpCmRpZmYgLS1naXQgYS9saWJz
ZXBvbC9zcmMvcG9sY2Fwcy5jIGIvbGlic2Vwb2wvc3JjL3BvbGNhcHMuYwppbmRleCAwNmE4Njhj
NC4uYjlkYzM1MjYgMTAwNjQ0Ci0tLSBhL2xpYnNlcG9sL3NyYy9wb2xjYXBzLmMKKysrIGIvbGli
c2Vwb2wvc3JjL3BvbGNhcHMuYwpAQCAtMTEsNiArMTEsNyBAQCBzdGF0aWMgY29uc3QgY2hhciAq
cG9sY2FwX25hbWVzW10gPSB7CiAJImV4dGVuZGVkX3NvY2tldF9jbGFzcyIsCS8qIFBPTElDWURC
X0NBUEFCSUxJVFlfRVhUU09DS0NMQVNTICovCiAJImFsd2F5c19jaGVja19uZXR3b3JrIiwJCS8q
IFBPTElDWURCX0NBUEFCSUxJVFlfQUxXQVlTTkVUV09SSyAqLwogCSJjZ3JvdXBfc2VjbGFiZWwi
LAkJLyogUE9MSUNZREJfQ0FQQUJJTElUWV9TRUNMQUJFTCAqLworCSJubnBfbm9zdWlkX3RyYW5z
aXRpb24iLAkvKiBQT0xJQ1lEQl9DQVBBQklMSVRZX05OUF9OT1NVSURfVFJBTlNJVElPTiAqLwog
CU5VTEwKIH07CiAKLS0gCjIuMTMuMgoK


--=-iRP59sxtmKnBjwA86uQo
Content-Disposition: attachment; filename="refpolicy-nnptransition.patch"
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="refpolicy-nnptransition.patch"; charset="UTF-8"

ZGlmZiAtcnUgc2VyZWZwb2xpY3ktMy4xMy4xLm5ucC9wb2xpY3kvZmxhc2svYWNjZXNzX3ZlY3Rv
cnMgc2VyZWZwb2xpY3ktMy4xMy4xL3BvbGljeS9mbGFzay9hY2Nlc3NfdmVjdG9ycwotLS0gc2Vy
ZWZwb2xpY3ktMy4xMy4xLm5ucC9wb2xpY3kvZmxhc2svYWNjZXNzX3ZlY3RvcnMJMjAxNy0wNy0y
NSAwOTo0MDo0NS4zMzMxNDQxNzAgLTA0MDAKKysrIHNlcmVmcG9saWN5LTMuMTMuMS9wb2xpY3kv
Zmxhc2svYWNjZXNzX3ZlY3RvcnMJMjAxNy0wNy0yNSAwOTo0Mjo1Ni44ODkzNjQ3MTYgLTA0MDAK
QEAgLTM4Niw4ICszODYsMTMgQEAKIAlzZXRrZXljcmVhdGUKIAlzZXRzb2NrY3JlYXRlCiAJZ2V0
cmxpbWl0CisJbm5wX3RyYW5zaXRpb24KIH0KIAorY2xhc3MgcHJvY2VzczIKK3sKKwlub3N1aWRf
dHJhbnNpdGlvbgorfQogCiAjCiAjIERlZmluZSB0aGUgYWNjZXNzIHZlY3RvciBpbnRlcnByZXRh
dGlvbiBmb3IgaXBjLXJlbGF0ZWQgb2JqZWN0cwpkaWZmIC1ydSBzZXJlZnBvbGljeS0zLjEzLjEu
bm5wL3BvbGljeS9mbGFzay9zZWN1cml0eV9jbGFzc2VzIHNlcmVmcG9saWN5LTMuMTMuMS9wb2xp
Y3kvZmxhc2svc2VjdXJpdHlfY2xhc3NlcwotLS0gc2VyZWZwb2xpY3ktMy4xMy4xLm5ucC9wb2xp
Y3kvZmxhc2svc2VjdXJpdHlfY2xhc3NlcwkyMDE3LTA3LTI1IDA5OjQwOjQ1LjMzMDE0NDE1OCAt
MDQwMAorKysgc2VyZWZwb2xpY3ktMy4xMy4xL3BvbGljeS9mbGFzay9zZWN1cml0eV9jbGFzc2Vz
CTIwMTctMDctMjUgMDk6NDQ6MzguMzg2MTA5OTkwIC0wNDAwCkBAIC0xMTAsNiArMTEwLDkgQEAK
ICMgQ2FwYWJpbGl0aWVzID49IDMyCiBjbGFzcyBjYXBhYmlsaXR5MgogCisjIFByb2Nlc3MgcGVy
bWlzc2lvbnMgPj0gMzIKK2NsYXNzIHByb2Nlc3MyCisKICMgTW9yZSBTRS1YIFdpbmRvd3Mgc3R1
ZmYKIGNsYXNzIHhfcmVzb3VyY2UJCSMgdXNlcnNwYWNlCiBjbGFzcyB4X2V2ZW50CQkJIyB1c2Vy
c3BhY2UKZGlmZiAtcnUgc2VyZWZwb2xpY3ktMy4xMy4xLm5ucC9wb2xpY3kvbW9kdWxlcy9rZXJu
ZWwvZG9tYWluLnRlIHNlcmVmcG9saWN5LTMuMTMuMS9wb2xpY3kvbW9kdWxlcy9rZXJuZWwvZG9t
YWluLnRlCi0tLSBzZXJlZnBvbGljeS0zLjEzLjEubm5wL3BvbGljeS9tb2R1bGVzL2tlcm5lbC9k
b21haW4udGUJMjAxNy0wNy0yNSAwOTo0MDo0NS4yODAxNDM5NTggLTA0MDAKKysrIHNlcmVmcG9s
aWN5LTMuMTMuMS9wb2xpY3kvbW9kdWxlcy9rZXJuZWwvZG9tYWluLnRlCTIwMTctMDctMjUgMDk6
NDI6MjcuMDg2ODQ1MTAzIC0wNDAwCkBAIC00OSw3ICs0OSw3IEBACiBhdHRyaWJ1dGUgbmFtZWRf
ZmlsZXRyYW5zX2RvbWFpbjsKIAogIyBUcmFuc2l0aW9ucyBvbmx5IGFsbG93ZWQgZnJvbSBkb21h
aW5zIHRvIG90aGVyIGRvbWFpbnMKLW5ldmVyYWxsb3cgZG9tYWluIH5kb21haW46cHJvY2VzcyB7
IHRyYW5zaXRpb24gZHludHJhbnNpdGlvbiB9OworbmV2ZXJhbGxvdyBkb21haW4gfmRvbWFpbjpw
cm9jZXNzIHsgdHJhbnNpdGlvbiBubnBfdHJhbnNpdGlvbiBkeW50cmFuc2l0aW9uIH07CiAKICMg
RG9tYWlucyB0aGF0IGFyZSB1bmNvbmZpbmVkCiBhdHRyaWJ1dGUgdW5jb25maW5lZF9kb21haW5f
dHlwZTsKQEAgLTIzOCw3ICsyMzgsNyBAQAogYWxsb3cgdW5jb25maW5lZF9kb21haW5fdHlwZSB1
bmNvbmZpbmVkX2RvbWFpbl90eXBlOmRidXMgc2VuZF9tc2c7CiAKICMgQWN0IHVwb24gYW55IG90
aGVyIHByb2Nlc3MuCi1hbGxvdyB1bmNvbmZpbmVkX2RvbWFpbl90eXBlIGRvbWFpbjpwcm9jZXNz
IH57IHB0cmFjZSB0cmFuc2l0aW9uIGR5bnRyYW5zaXRpb24gZXhlY21lbSBleGVjc3RhY2sgZXhl
Y2hlYXAgfTsKK2FsbG93IHVuY29uZmluZWRfZG9tYWluX3R5cGUgZG9tYWluOnByb2Nlc3Mgfnsg
cHRyYWNlIHRyYW5zaXRpb24gbm5wX3RyYW5zaXRpb24gZHludHJhbnNpdGlvbiBleGVjbWVtIGV4
ZWNzdGFjayBleGVjaGVhcCB9OwogdHVuYWJsZV9wb2xpY3koYGRlbnlfcHRyYWNlJyxgJyxgCiAJ
YWxsb3cgdW5jb25maW5lZF9kb21haW5fdHlwZSBkb21haW46cHJvY2VzcyBwdHJhY2U7CiAnKQpk
aWZmIC1ydSBzZXJlZnBvbGljeS0zLjEzLjEubm5wL3BvbGljeS9tb2R1bGVzL2tlcm5lbC9rZXJu
ZWwudGUgc2VyZWZwb2xpY3ktMy4xMy4xL3BvbGljeS9tb2R1bGVzL2tlcm5lbC9rZXJuZWwudGUK
LS0tIHNlcmVmcG9saWN5LTMuMTMuMS5ubnAvcG9saWN5L21vZHVsZXMva2VybmVsL2tlcm5lbC50
ZQkyMDE3LTA3LTI1IDA5OjQwOjQ1LjI4NzE0Mzk4NiAtMDQwMAorKysgc2VyZWZwb2xpY3ktMy4x
My4xL3BvbGljeS9tb2R1bGVzL2tlcm5lbC9rZXJuZWwudGUJMjAxNy0wNy0yNSAwOTo0MjoyNy4w
ODc4NDQ5MTcgLTA0MDAKQEAgLTUwNyw3ICs1MDcsNyBAQAogYWxsb3cga2Vybl91bmNvbmZpbmVk
IHVubGFiZWxlZF90OmZpbGVzeXN0ZW0gKjsKIGFsbG93IGtlcm5fdW5jb25maW5lZCB1bmxhYmVs
ZWRfdDphc3NvY2lhdGlvbiAqOwogYWxsb3cga2Vybl91bmNvbmZpbmVkIHVubGFiZWxlZF90OnBh
Y2tldCAqOwotYWxsb3cga2Vybl91bmNvbmZpbmVkIHVubGFiZWxlZF90OnByb2Nlc3MgfnsgcHRy
YWNlIHRyYW5zaXRpb24gZHludHJhbnNpdGlvbiBleGVjbWVtIGV4ZWNzdGFjayBleGVjaGVhcCB9
OworYWxsb3cga2Vybl91bmNvbmZpbmVkIHVubGFiZWxlZF90OnByb2Nlc3MgfnsgcHRyYWNlIHRy
YW5zaXRpb24gbm5wX3RyYW5zaXRpb24gZHludHJhbnNpdGlvbiBleGVjbWVtIGV4ZWNzdGFjayBl
eGVjaGVhcCB9OwogCiBnZW5fcmVxdWlyZShgCiAJYm9vbCBzZWN1cmVfbW9kZV9pbnNtb2Q7CmRp
ZmYgLXJ1IHNlcmVmcG9saWN5LTMuMTMuMS5ubnAvcG9saWN5L3BvbGljeV9jYXBhYmlsaXRpZXMg
c2VyZWZwb2xpY3ktMy4xMy4xL3BvbGljeS9wb2xpY3lfY2FwYWJpbGl0aWVzCi0tLSBzZXJlZnBv
bGljeS0zLjEzLjEubm5wL3BvbGljeS9wb2xpY3lfY2FwYWJpbGl0aWVzCTIwMTctMDctMjUgMDk6
NDA6NDUuMzMwMTQ0MTU4IC0wNDAwCisrKyBzZXJlZnBvbGljeS0zLjEzLjEvcG9saWN5L3BvbGlj
eV9jYXBhYmlsaXRpZXMJMjAxNy0wNy0yNSAwOTo0MjoyNy4wODc4NDQ5MTcgLTA0MDAKQEAgLTcy
LDMgKzcyLDUgQEAKICMgcWlwY3J0cl9zb2NrZXQKICMKIHBvbGljeWNhcCBleHRlbmRlZF9zb2Nr
ZXRfY2xhc3M7CisKK3BvbGljeWNhcCBubnBfbm9zdWlkX3RyYW5zaXRpb247Cg==


--=-iRP59sxtmKnBjwA86uQo--
