From: Stephen Smalley <sds@tycho.nsa.gov>
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
References: <20180515082553.30310-1-richard_c_haines@btinternet.com>
 <0c5025b1-b90e-3e8f-b6f9-7ff080f5f772@tycho.nsa.gov>
Message-ID: <0193e640-4792-57b1-2408-a6944731baf4@tycho.nsa.gov>
Date: Tue, 15 May 2018 09:43:43 -0400
MIME-Version: 1.0
In-Reply-To: <0c5025b1-b90e-3e8f-b6f9-7ff080f5f772@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Subject: Re: [RFC PATCH 1/1] selinux-testsuite: Add binder tests
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/15/2018 09:36 AM, Stephen Smalley wrote:
> On 05/15/2018 04:25 AM, Richard Haines via Selinux wrote:
>> Add binder tests. See tests/binder/test_binder.c for details on
>> message flows to test security_binder*() functions.
>>
>> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>> ---
>>  README.md                   |   8 +
>>  defconfig                   |   8 +
>>  policy/Makefile             |   2 +-
>>  policy/test_binder.te       |  83 +++++++
>>  tests/Makefile              |   2 +-
>>  tests/binder/Makefile       |   7 +
>>  tests/binder/check_binder.c |  80 +++++++
>>  tests/binder/test           | 131 +++++++++++
>>  tests/binder/test_binder.c  | 543 ++++++++++++++++++++++++++++++++++++++++++++
>>  9 files changed, 862 insertions(+), 2 deletions(-)
>>  create mode 100644 policy/test_binder.te
>>  create mode 100644 tests/binder/Makefile
>>  create mode 100644 tests/binder/check_binder.c
>>  create mode 100644 tests/binder/test
>>  create mode 100644 tests/binder/test_binder.c
>>
>> diff --git a/README.md b/README.md
>> index c9f3b2b..60a249e 100644
>> --- a/README.md
>> +++ b/README.md
>> @@ -141,6 +141,14 @@ directory or you can follow these broken-out steps:
>>  The broken-out steps allow you to run the tests multiple times without
>>  loading policy each time.
>>  
>> +Note that if leaving the test policy in-place for further testing, the
>> +policy build process changes a boolean:
>> +   On policy load:   setsebool allow_domain_fd_use=0
>> +   On policy unload: setsebool allow_domain_fd_use=1
>> +The consequence of this is that after a system reboot, the boolean
>> +defaults to true. Therefore if running the fdreceive or binder tests,
>> +reset the boolean to false, otherwise some tests will fail.
> 
> This isn't accurate - we aren't doing setsebool -P so the boolean change is not persistent across
> reboots.  It will persist across policy reloads however because the kernel preserves booleans across
> policy reloads.

Sorry, never mind - I misread the text above.  You are correct.

> 
>> +
>>  4) Review the test results.
>>  
>>  As each test script is run, the name of the script will be displayed followed
>> diff --git a/defconfig b/defconfig
>> index 7dce8bc..dc6ef30 100644
>> --- a/defconfig
>> +++ b/defconfig
>> @@ -51,3 +51,11 @@ CONFIG_CRYPTO_USER=m
>>  # This is enabled to test overlayfs SELinux integration.
>>  # It is not required for SELinux operation itself.
>>  CONFIG_OVERLAY_FS=m
>> +
>> +# Android binder implementations.
>> +# These are enabled to test the binder controls in
>> +# tests/binder; they are not required for SELinux operation itself.
>> +CONFIG_ANDROID=y
>> +CONFIG_ANDROID_BINDER_IPC=y
>> +CONFIG_ANDROID_BINDER_DEVICES="binder"
>> +# CONFIG_ANDROID_BINDER_IPC_SELFTEST is not set
> 
> I don't think we need the last line.
> 
>> diff --git a/policy/Makefile b/policy/Makefile
>> index 8ed5e46..5a9d411 100644
>> --- a/policy/Makefile
>> +++ b/policy/Makefile
>> @@ -25,7 +25,7 @@ TARGETS = \
>>  	test_task_getsid.te test_task_setpgid.te test_task_setsched.te \
>>  	test_transition.te test_inet_socket.te test_unix_socket.te \
>>  	test_mmap.te test_overlayfs.te test_mqueue.te test_mac_admin.te \
>> -	test_ibpkey.te test_atsecure.te
>> +	test_ibpkey.te test_atsecure.te test_binder.te
> 
> Likely need to make this conditional on the binder class being defined in the policy;
> see similar logic for e.g. cap_userns, icmp_socket, etc.  Otherwise policy won't build
> on earlier Fedora/RHEL before definition of the binder class.
> 
>>  
>>  ifeq ($(shell [ $(POL_VERS) -ge 24 ] && echo true),true)
>>  TARGETS += test_bounds.te
>> diff --git a/policy/test_binder.te b/policy/test_binder.te
>> new file mode 100644
>> index 0000000..c4ad2ae
>> --- /dev/null
>> +++ b/policy/test_binder.te
>> @@ -0,0 +1,83 @@
>> +
>> +attribute binderdomain;
>> +
>> +#
>> +################################## Manager ###################################
>> +#
>> +type test_binder_mgr_t;
>> +domain_type(test_binder_mgr_t)
>> +unconfined_runs_test(test_binder_mgr_t)
>> +typeattribute test_binder_mgr_t testdomain;
>> +typeattribute test_binder_mgr_t binderdomain;
>> +allow test_binder_mgr_t self:binder { set_context_mgr call };
>> +allow test_binder_mgr_t device_t:chr_file { ioctl open read write map };
> 
> Wondering if we should define a .fc file with /dev/binder and a proper binder_device_t type
> and restorecon it before the test.  But not clear it is worth it.  Never mind.
> 
>> +allow test_binder_mgr_t self:capability { sys_nice };
> 
> Needed or just to suppress noise in the audit?
> 
>> +allow test_binder_client_t test_binder_mgr_t:fd use;
>> +
>> +#
>> +################################# Client ####################################
>> +#
>> +type test_binder_client_t;
>> +domain_type(test_binder_client_t)
>> +unconfined_runs_test(test_binder_client_t)
>> +typeattribute test_binder_client_t testdomain;
>> +typeattribute test_binder_client_t binderdomain;
>> +allow test_binder_client_t self:binder { call };
>> +allow test_binder_client_t test_binder_mgr_t:binder { call transfer impersonate };
> 
> Are you actually exercising impersonate?  I largely didn't expect it to ever be used in Android itself,
> just included the check because I saw that it was technically possible as far as the kernel interface
> is concerned.
> 
>> +allow test_binder_client_t device_t:chr_file { ioctl open read write map };
>> +# For fstat:
>> +allow test_binder_client_t device_t:chr_file getattr;
>> +
>> +#
>> +############################## Client no call ################################
>> +#
>> +type test_binder_client_no_call_t;
>> +domain_type(test_binder_client_no_call_t)
>> +unconfined_runs_test(test_binder_client_no_call_t)
>> +typeattribute test_binder_client_no_call_t testdomain;
>> +typeattribute test_binder_client_no_call_t binderdomain;
>> +allow test_binder_client_no_call_t device_t:chr_file { ioctl open read write map };
>> +
>> +#
>> +############################ Client no transfer #############################
>> +#
>> +type test_binder_client_no_transfer_t;
>> +domain_type(test_binder_client_no_transfer_t)
>> +unconfined_runs_test(test_binder_client_no_transfer_t)
>> +typeattribute test_binder_client_no_transfer_t testdomain;
>> +typeattribute test_binder_client_no_transfer_t binderdomain;
>> +allow test_binder_client_no_transfer_t test_binder_mgr_t:binder { call };
>> +allow test_binder_client_no_transfer_t device_t:chr_file { ioctl open read write map };
>> +
>> +#
>> +########################## Manager no fd {use} ###############################
>> +#
>> +type test_binder_mgr_no_fd_t;
>> +domain_type(test_binder_mgr_no_fd_t)
>> +unconfined_runs_test(test_binder_mgr_no_fd_t)
>> +typeattribute test_binder_mgr_no_fd_t testdomain;
>> +typeattribute test_binder_mgr_no_fd_t binderdomain;
>> +allow test_binder_mgr_no_fd_t self:binder { set_context_mgr call };
>> +allow test_binder_mgr_no_fd_t device_t:chr_file { ioctl open read write map };
>> +allow test_binder_mgr_no_fd_t self:capability { sys_nice };
>> +allow test_binder_client_t test_binder_mgr_no_fd_t:binder { call transfer };
>> +
>> +#
>> +########################### Client no impersonate ############################
>> +#
>> +type test_binder_client_no_im_t;
>> +domain_type(test_binder_client_no_im_t)
>> +unconfined_runs_test(test_binder_client_no_im_t)
>> +typeattribute test_binder_client_no_im_t testdomain;
>> +typeattribute test_binder_client_no_im_t binderdomain;
>> +allow test_binder_client_no_im_t self:binder { call };
>> +allow test_binder_client_no_im_t test_binder_mgr_t:binder { call transfer };
>> +allow test_binder_client_no_im_t device_t:chr_file { ioctl open read write map };
>> +allow test_binder_client_no_im_t test_binder_mgr_t:fd use;
>> +allow test_binder_client_no_im_t device_t:chr_file getattr;
>> +
>> +#
>> +############ Allow these domains to be entered from sysadm domain ############
>> +#
>> +miscfiles_domain_entry_test_files(binderdomain)
>> +userdom_sysadm_entry_spec_domtrans_to(binderdomain)
>> diff --git a/tests/Makefile b/tests/Makefile
>> index 27ed6eb..7607c22 100644
>> --- a/tests/Makefile
>> +++ b/tests/Makefile
>> @@ -10,7 +10,7 @@ SUBDIRS:= domain_trans entrypoint execshare exectrace execute_no_trans \
>>  	task_setnice task_setscheduler task_getscheduler task_getsid \
>>  	task_getpgid task_setpgid file ioctl capable_file capable_net \
>>  	capable_sys dyntrans dyntrace bounds nnp_nosuid mmap unix_socket \
>> -        inet_socket overlay checkreqprot mqueue mac_admin atsecure
>> +        inet_socket overlay checkreqprot mqueue mac_admin atsecure binder
> 
> Likely needs to be conditional on binder class being defined in policy as with cap_userns,
> and also depends on e.g. linux/android/binder.h existing?  Otherwise will break build on earlier
> Fedora/RHEL releases.
> 
>>  
>>  ifeq ($(shell grep -q cap_userns $(POLDEV)/include/support/all_perms.spt && echo true),true)
>>  ifneq ($(shell ./kvercmp $$(uname -r) 4.7),-1)
>> diff --git a/tests/binder/Makefile b/tests/binder/Makefile
>> new file mode 100644
>> index 0000000..a60eeb3
>> --- /dev/null
>> +++ b/tests/binder/Makefile
>> @@ -0,0 +1,7 @@
>> +TARGETS = check_binder test_binder
>> +
>> +LDLIBS += -lselinux
>> +
>> +all: $(TARGETS)
>> +clean:
>> +	rm -f $(TARGETS)
>> diff --git a/tests/binder/check_binder.c b/tests/binder/check_binder.c
>> new file mode 100644
>> index 0000000..3d553a0
>> --- /dev/null
>> +++ b/tests/binder/check_binder.c
>> @@ -0,0 +1,80 @@
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <unistd.h>
>> +#include <fcntl.h>
>> +#include <errno.h>
>> +#include <stdbool.h>
>> +#include <sys/mman.h>
>> +#include <sys/ioctl.h>
>> +#include <linux/android/binder.h>
>> +
>> +static void usage(char *progname)
>> +{
>> +	fprintf(stderr,
>> +		"usage:  %s [-v]\n"
>> +		"Where:\n\t"
>> +		"-v Print binder version.\n", progname);
>> +	exit(-1);
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +	int opt, result, fd;
>> +	char *driver = "/dev/binder";
>> +	bool verbose;
>> +	void *mapped;
>> +	size_t mapsize = 1024;
>> +	struct binder_version vers;
>> +
>> +	while ((opt = getopt(argc, argv, "v")) != -1) {
>> +		switch (opt) {
>> +		case 'v':
>> +			verbose = true;
>> +			break;
>> +		default:
>> +			usage(argv[0]);
>> +		}
>> +	}
>> +
>> +	fd = open(driver, O_RDWR | O_CLOEXEC);
>> +	if (fd < 0) {
>> +		fprintf(stderr, "Cannot open: %s error: %s\n",
>> +			driver, strerror(errno));
>> +		exit(-1);
>> +	}
>> +
>> +	/* Need this or no VMA error from kernel */
>> +	mapped = mmap(NULL, mapsize, PROT_READ, MAP_PRIVATE, fd, 0);
>> +	if (mapped == MAP_FAILED) {
>> +		fprintf(stderr, "mmap error: %s\n", strerror(errno));
>> +		close(fd);
>> +		exit(-1);
>> +	}
>> +
>> +	result = ioctl(fd, BINDER_VERSION, &vers);
>> +	if (result < 0) {
>> +		fprintf(stderr, "ioctl BINDER_VERSION: %s\n",
>> +			strerror(errno));
>> +		goto brexit;
>> +	}
>> +
>> +	if (vers.protocol_version != BINDER_CURRENT_PROTOCOL_VERSION) {
>> +		fprintf(stderr,
>> +			"Binder kernel version: %d differs from user space version: %d\n",
>> +			vers.protocol_version,
>> +			BINDER_CURRENT_PROTOCOL_VERSION);
>> +		result = -1;
>> +		goto brexit;
>> +	}
>> +
>> +	if (verbose)
>> +		fprintf(stderr, "Binder kernel version: %d\n",
>> +			vers.protocol_version);
>> +
>> +brexit:
>> +	munmap(mapped, mapsize);
>> +	close(fd);
>> +
>> +	return result;
>> +}
>> diff --git a/tests/binder/test b/tests/binder/test
>> new file mode 100644
>> index 0000000..434ae32
>> --- /dev/null
>> +++ b/tests/binder/test
>> @@ -0,0 +1,131 @@
>> +#!/usr/bin/perl
>> +use Test::More;
>> +
>> +BEGIN {
>> +    $basedir = $0;
>> +    $basedir =~ s|(.*)/[^/]*|$1|;
>> +
>> +    # allow binder info to be shown
>> +    $v = $ARGV[0];
>> +    if ($v) {
>> +        if ( $v ne "-v" ) {
>> +            plan skip_all => "Invalid option (use -v)";
>> +        }
>> +    }
>> +
>> +    # check if binder driver available and the kernel/userspace versions.
>> +    if ( system("$basedir/check_binder 2> /dev/null") != 0 ) {
>> +        plan skip_all =>
>> +          "Binder not supported or kernel/userspace versions differ";
>> +    }
>> +    else {
>> +        plan tests => 6;
>> +    }
>> +}
>> +
>> +if ($v) {
> 
> Duplicating the test cases for $v and !$v seems prone to inconsistency in the future;
> can't we just embed $v into the command string being executed?
> 
>> +    if ( ( $pid = fork() ) == 0 ) {
>> +        exec "runcon -t test_binder_mgr_t $basedir/test_binder -v manager";
>> +    }
>> +
>> +    select( undef, undef, undef, 0.25 );    # Give it a moment to initialize.
>> +
>> +    # Verify that authorized client can transact with the manager.
>> +    $result =
>> +      system "runcon -t test_binder_client_t $basedir/test_binder -v client";
>> +    ok( $result eq 0 );
> 
> This test is failing for me (with or without -v):
> # ./test -v
> 1..6
> Manager PID: 5608 Process context:
> 	unconfined_u:unconfined_r:test_binder_mgr_t:s0-s0:c0.c1023
> Client PID: 5609 Process context:
> 	unconfined_u:unconfined_r:test_binder_client_t:s0-s0:c0.c1023
> Client read_consumed: 28
> Manager read_consumed: 72
> Client command: BR_NOOP
> Manager command: BR_NOOP
> Client command: BR_INCREFS
> Manager command: BR_TRANSACTION
> Client command: BR_TRANSACTION_COMPLETE
> BR_TRANSACTION data:
> 	handle: 0
> 	cookie: 0
> 	code: 0
> 	flag: TF_ACCEPT_FDS
> 	sender pid: 5609
> 	sender euid: 0
> 	data_size: 24
> 	offsets_size: 8
> Sending BC_REPLY
> Manager read_consumed: 8
> Manager command: BR_NOOP
> Manager command: BR_TRANSACTION_COMPLETE
> Client read_consumed: 72
> Client command: BR_NOOP
> Client command: BR_REPLY
> BR_REPLY data:
> 	handle: 0
> 	cookie: 0
> 	code: 0
> 	flag: TF_ACCEPT_FDS
> 	sender pid: 0
> 	sender euid: 0
> 	data_size: 24
> 	offsets_size: 8
> Retrieved Managers fd: 4 st_dev: 6
> Client read_consumed: 8
> Client using Managers FD command: BR_NOOP
> Client using Managers FD command: BR_FAILED_REPLY
> Client using Managers received FD failed response
> Manager read_consumed: 4
> Manager command: BR_NOOP
> not ok 1
> #   Failed test at ./test line 36.

Just realized that I was testing with a kernel that still had Casey's stacking support enabled.
Will re-try without that.

> 
> 
>> +
>> +    # Verify that client cannot call manager (no call perm).
>> +    $result = system
>> +"runcon -t test_binder_client_no_call_t $basedir/test_binder -v client 2>&1";
>> +    ok( $result >> 8 eq 9 );
>> +
>> +    # Verify that client cannot communicate with manager (no impersonate perm).
>> +    $result = system
>> +"runcon -t test_binder_client_no_im_t $basedir/test_binder -v client 2>&1";
>> +    ok( $result >> 8 eq 102 );
>> +
>> +    # Verify that client cannot communicate with manager (no transfer perm).
>> +    $result = system
>> +"runcon -t test_binder_client_no_transfer_t $basedir/test_binder -v client 2>&1";
>> +    ok( $result >> 8 eq 9 );
>> +
>> +    # Kill the manager.
>> +    kill TERM, $pid;
>> +
>> +    # Verify that client cannot become a manager (no set_context_mgr perm).
>> +    $result =
>> +      system
>> +      "runcon -t test_binder_client_t $basedir/test_binder -v manager 2>&1";
>> +    ok( $result >> 8 eq 4 );
>> +
>> +# Start manager to test that selinux_binder_transfer_file() fails when fd { use } is denied by policy.
>> +    if ( ( $pid = fork() ) == 0 ) {
>> +        exec
>> +          "runcon -t test_binder_mgr_no_fd_t $basedir/test_binder -v manager";
>> +    }
>> +
>> +    select( undef, undef, undef, 0.25 );    # Give it a moment to initialize.
>> +
>> +# Verify that authorized client can communicate with the server, however the fd passed will not be valid for manager
>> +# domain and binder will return BR_FAILED_REPLY.
>> +    $result =
>> +      system
>> +      "runcon -t test_binder_client_t $basedir/test_binder -v client 2>&1";
>> +    ok( $result >> 8 eq 9 );
>> +
>> +    # Kill the manager
>> +    kill TERM, $pid;
>> +}
>> +else {
>> +    if ( ( $pid = fork() ) == 0 ) {
>> +        exec "runcon -t test_binder_mgr_t $basedir/test_binder manager";
>> +    }
>> +
>> +    select( undef, undef, undef, 0.25 );    # Give it a moment to initialize.
>> +
>> +    # Verify that authorized client can transact with the manager.
>> +    $result =
>> +      system "runcon -t test_binder_client_t $basedir/test_binder client";
>> +    ok( $result eq 0 );
>> +
>> +    # Verify that client cannot call manager (no call perm).
>> +    $result = system
>> +      "runcon -t test_binder_client_no_call_t $basedir/test_binder client 2>&1";
>> +    ok( $result >> 8 eq 9 );
>> +
>> +    # Verify that client cannot communicate with manager (no impersonate perm).
>> +    $result = system
>> +      "runcon -t test_binder_client_no_im_t $basedir/test_binder client 2>&1";
>> +    ok( $result >> 8 eq 102 );
>> +
>> +    # Verify that client cannot communicate with manager (no transfer perm).
>> +    $result = system
>> +"runcon -t test_binder_client_no_transfer_t $basedir/test_binder client 2>&1";
>> +    ok( $result >> 8 eq 9 );
>> +
>> +    # Kill the manager.
>> +    kill TERM, $pid;
>> +
>> +    # Verify that client cannot become a manager (no set_context_mgr perm).
>> +    $result =
>> +      system "runcon -t test_binder_client_t $basedir/test_binder manager 2>&1";
>> +    ok( $result >> 8 eq 4 );
>> +
>> +# Start manager to test that selinux_binder_transfer_file() fails when fd { use } is denied by policy.
>> +    if ( ( $pid = fork() ) == 0 ) {
>> +        exec "runcon -t test_binder_mgr_no_fd_t $basedir/test_binder manager";
>> +    }
>> +
>> +    select( undef, undef, undef, 0.25 );    # Give it a moment to initialize.
>> +
>> +# Verify that authorized client can communicate with the server, however the fd passed will not be valid for manager
>> +# domain and binder will return BR_FAILED_REPLY.
>> +    $result =
>> +      system "runcon -t test_binder_client_t $basedir/test_binder client 2>&1";
>> +    ok( $result >> 8 eq 9 );
>> +
>> +    # Kill the manager
>> +    kill TERM, $pid;
>> +}
>> +exit;
>> diff --git a/tests/binder/test_binder.c b/tests/binder/test_binder.c
>> new file mode 100644
>> index 0000000..8881cce
>> --- /dev/null
>> +++ b/tests/binder/test_binder.c
>> @@ -0,0 +1,543 @@
>> +/*
>> + * This is a simple binder client/server(manager) that only uses the
>> + * raw ioctl commands. It does not rely on a 'service manager' as in
>> + * the Android world as it only uses one 'target' = 0.
>> + *
>> + * The transaction/reply flow is basically:
>> + *      Client                                  Manager
>> + *     ========                                =========
>> + *
>> + *                                        Becomes context manager
>> + *   Send transaction
>> + *   requesting file
>> + *   descriptor from
>> + *    the Manager
>> + *         --------------------------------------->
>> + *                                       Manager replies with its
>> + *                                        binder file descriptor
>> + *         <--------------------------------------
>> + *     Check fd valid, if so send
>> + *  TF_ONE_WAY transaction to Manager
>> + *  using the received fd
>> + *          --------------------------------------->
>> + *                                        End of tests so Manager
>> + *                                          waits to be killed
>> + *   Client exits
>> + *
>> + * Using binder test policy the following will be validated:
>> + *    security_binder_set_context_mgr() binder { set_context_mgr }
>> + *    security_binder_transaction()     binder { call impersonate }
>> + *    security_binder_transfer_binder() binder { transfer }
>> + *    security_binder_transfer_file()   fd { use }
>> + *
>> + * TODO security_binder_transfer_file() uses BPF if configured in kernel.
>> + */
>> +
>> +#include <errno.h>
>> +#include <fcntl.h>
>> +#include <inttypes.h>
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <unistd.h>
>> +#include <sys/stat.h>
>> +#include <stdbool.h>
>> +#include <sys/mman.h>
>> +#include <sys/ioctl.h>
>> +#include <selinux/selinux.h>
>> +#include <linux/android/binder.h>
>> +
>> +static uint32_t target; /* This will be set to '0' as only need one target */
>> +static bool verbose;
>> +
>> +static int binder_parse(int fd, uintptr_t ptr, size_t size, char *text);
>> +
>> +static void usage(char *progname)
>> +{
>> +	fprintf(stderr,
>> +		"usage:  %s [-v] manager | client\n"
>> +		"Where:\n\t"
>> +		"-v       Print context and command information.\n\t"
>> +		"manager  Act as binder context manager.\n\t"
>> +		"client   Act as binder client.\n"
>> +		"\nNote: Ensure this boolean command is run when "
>> +		"testing after a reboot:\n\t"
>> +		"setsebool allow_domain_fd_use=0\n", progname);
>> +	exit(1);
>> +}
>> +
>> +static const char *cmd_name(uint32_t cmd)
>> +{
>> +	switch (cmd) {
>> +	case BR_NOOP:
>> +		return "BR_NOOP";
>> +	case BR_TRANSACTION_COMPLETE:
>> +		return "BR_TRANSACTION_COMPLETE";
>> +	case BR_INCREFS:
>> +		return "BR_INCREFS";
>> +	case BR_ACQUIRE:
>> +		return "BR_ACQUIRE";
>> +	case BR_RELEASE:
>> +		return "BR_RELEASE";
>> +	case BR_DECREFS:
>> +		return "BR_DECREFS";
>> +	case BR_TRANSACTION:
>> +		return "BR_TRANSACTION";
>> +	case BR_REPLY:
>> +		return "BR_REPLY";
>> +	case BR_FAILED_REPLY:
>> +		return "BR_FAILED_REPLY";
>> +	case BR_DEAD_REPLY:
>> +		return "BR_DEAD_REPLY";
>> +	case BR_DEAD_BINDER:
>> +		return "BR_DEAD_BINDER";
>> +	case BR_ERROR:
>> +		return "BR_ERROR";
>> +	/* fallthrough */
>> +	default:
>> +		return "Unknown command";
>> +	}
>> +}
>> +
>> +void print_trans_data(struct binder_transaction_data *txn)
>> +{
>> +	printf("\thandle: %ld\n", (unsigned long)txn->target.handle);
>> +	printf("\tcookie: %lld\n", txn->cookie);
>> +	printf("\tcode: %u\n", txn->code);
>> +	switch (txn->flags) {
>> +	case TF_ONE_WAY:
>> +		printf("\tflag: TF_ONE_WAY\n");
>> +		break;
>> +	case TF_ROOT_OBJECT:
>> +		printf("\tflag: TF_ROOT_OBJECT\n");
>> +		break;
>> +	case TF_STATUS_CODE:
>> +		printf("\tflag: TF_STATUS_CODE\n");
>> +		break;
>> +	case TF_ACCEPT_FDS:
>> +		printf("\tflag: TF_ACCEPT_FDS\n");
>> +		break;
>> +	default:
>> +		printf("Unknown flag: %u\n", txn->flags);
>> +	}
>> +	printf("\tsender pid: %u\n", txn->sender_pid);
>> +	printf("\tsender euid: %u\n", txn->sender_euid);
>> +	printf("\tdata_size: %llu\n", txn->data_size);
>> +	printf("\toffsets_size: %llu\n", txn->offsets_size);
>> +}
>> +
>> +
>> +static int send_reply(int fd, struct binder_transaction_data *txn_in)
>> +{
>> +	int result;
>> +	unsigned int writebuf[1024];
>> +	struct flat_binder_object obj;
>> +	struct binder_write_read bwr;
>> +	struct binder_transaction_data *txn;
>> +
>> +	if (txn_in->flags == TF_ONE_WAY) {
>> +		if (verbose)
>> +			printf("No reply to BC_TRANSACTION as flags = TF_ONE_WAY\n");
>> +		return 0;
>> +	}
>> +
>> +	if (verbose)
>> +		printf("Sending BC_REPLY\n");
>> +
>> +	writebuf[0] = BC_REPLY;
>> +	txn = (struct binder_transaction_data *)(&writebuf[1]);
>> +
>> +	memset(txn, 0, sizeof(*txn));
>> +	txn->target.handle = txn_in->target.handle;
>> +	txn->cookie = txn_in->cookie;
>> +	txn->code = txn_in->code;
>> +	txn->flags = TF_ACCEPT_FDS;
>> +
>> +	memset(&obj, 0, sizeof(struct flat_binder_object));
>> +	obj.hdr.type = BINDER_TYPE_FD;
>> +	obj.flags = 0x7f | FLAT_BINDER_FLAG_ACCEPTS_FDS;
>> +	obj.binder = txn->target.handle;
>> +	obj.cookie = txn->cookie;
>> +	/* The binder fd is used for testing as it allows policy to set
>> +	 * whether the Client/Manager can be allowed access (fd use) or
>> +	 * not. For example test_binder_mgr_t has:
>> +	 *        allow test_binder_client_t test_binder_mgr_t:fd use;
>> +	 * whereas test_binder_mgr_no_fd_t does not allow this fd use.
>> +	 *
>> +	 * This also allows a check for the impersonate permission later as
>> +	 * the Client will use this (the Managers fd) to send a transaction.
>> +	 */
>> +	obj.handle = fd;
>> +
>> +	txn->data_size = sizeof(struct flat_binder_object);
>> +	txn->data.ptr.buffer = (uintptr_t)&obj;
>> +	txn->data.ptr.offsets = (uintptr_t)&obj +
>> +				sizeof(struct flat_binder_object);
>> +	txn->offsets_size = sizeof(binder_size_t);
>> +
>> +	memset(&bwr, 0, sizeof(bwr));
>> +	bwr.write_buffer = (unsigned long)writebuf;
>> +	bwr.write_size = sizeof(writebuf[0]) + sizeof(*txn);
>> +
>> +	result = ioctl(fd, BINDER_WRITE_READ, &bwr);
>> +	if (result < 0) {
>> +		fprintf(stderr, "%s ioctl BINDER_WRITE_READ: %s\n",
>> +			__func__, strerror(errno));
>> +		return -1;
>> +	}
>> +
>> +	return result;
>> +}
>> +
>> +/* This retrieves the requested Managers file descriptor, then using this
>> + * sends a simple transaction to trigger the impersonate permission.
>> + */
>> +static void extract_fd_and_respond(struct binder_transaction_data *txn_in)
>> +{
>> +	int result;
>> +	uint32_t cmd;
>> +	struct stat sb;
>> +	struct binder_write_read bwr;
>> +	struct flat_binder_object *obj;
>> +	struct binder_transaction_data *txn;
>> +	unsigned int readbuf[32];
>> +	unsigned int writebuf[1024];
>> +	binder_size_t *offs = (binder_size_t *)(uintptr_t)txn_in->data.ptr.offsets;
>> +
>> +	/* Get the fbo that contains the Managers binder file descriptor. */
>> +	obj = (struct flat_binder_object *)
>> +	      (((char *)(uintptr_t)txn_in->data.ptr.buffer) + *offs);
>> +
>> +	/* fstat this just to see if a valid fd */
>> +	result = fstat(obj->handle, &sb);
>> +	if (result < 0) {
>> +		fprintf(stderr, "Not a valid fd: %s\n", strerror(errno));
>> +		exit(100);
>> +	}
>> +
>> +	if (verbose)
>> +		printf("Retrieved Managers fd: %d st_dev: %ld\n",
>> +		       obj->handle, sb.st_dev);
>> +
>> +	/* Send response using Managers fd to trigger impersonate check. */
>> +	writebuf[0] = BC_TRANSACTION;
>> +	txn = (struct binder_transaction_data *)(&writebuf[1]);
>> +	memset(txn, 0, sizeof(*txn));
>> +	txn->target.handle = target;
>> +	txn->cookie = 0;
>> +	txn->code = 0;
>> +	txn->flags = TF_ONE_WAY;
>> +
>> +	txn->data_size = 0;
>> +	txn->data.ptr.buffer = (uintptr_t)NULL;
>> +	txn->data.ptr.offsets = (uintptr_t)NULL;
>> +	txn->offsets_size = 0;
>> +
>> +	memset(&bwr, 0, sizeof(bwr));
>> +	bwr.write_buffer = (unsigned long)writebuf;
>> +	bwr.write_size = sizeof(writebuf[0]) + sizeof(*txn);
>> +
>> +	bwr.read_size = sizeof(readbuf);
>> +	bwr.read_consumed = 0;
>> +	bwr.read_buffer = (uintptr_t)readbuf;
>> +
>> +	result = ioctl(obj->handle, BINDER_WRITE_READ, &bwr);
>> +	if (result < 0) {
>> +		fprintf(stderr,
>> +			"CLIENT ioctl BINDER_WRITE_READ: %s\n",
>> +			strerror(errno));
>> +		exit(101);
>> +	}
>> +
>> +	if (verbose)
>> +		printf("Client read_consumed: %lld\n", bwr.read_consumed);
>> +
>> +	cmd = binder_parse(obj->handle, (uintptr_t)readbuf,
>> +			   bwr.read_consumed,
>> +			   "Client using Managers FD");
>> +
>> +	if (cmd == BR_FAILED_REPLY ||
>> +	    cmd == BR_DEAD_REPLY ||
>> +	    cmd == BR_DEAD_BINDER) {
>> +		fprintf(stderr,
>> +			"Client using Managers received FD failed response\n");
>> +		exit(102);
>> +	}
>> +}
>> +
>> +/* Parse response, reply as required and then return last CMD */
>> +static int binder_parse(int fd, uintptr_t ptr, size_t size, char *text)
>> +{
>> +	uintptr_t end = ptr + (uintptr_t)size;
>> +	uint32_t cmd;
>> +
>> +	while (ptr < end) {
>> +		cmd = *(uint32_t *)ptr;
>> +		ptr += sizeof(uint32_t);
>> +
>> +		if (verbose)
>> +			printf("%s command: %s\n", text, cmd_name(cmd));
>> +
>> +		switch (cmd) {
>> +		case BR_NOOP:
>> +			break;
>> +		case BR_TRANSACTION_COMPLETE:
>> +			break;
>> +		case BR_INCREFS:
>> +		case BR_ACQUIRE:
>> +		case BR_RELEASE:
>> +		case BR_DECREFS:
>> +			ptr += sizeof(struct binder_ptr_cookie);
>> +			break;
>> +		case BR_TRANSACTION: {
>> +			struct binder_transaction_data *txn =
>> +				(struct binder_transaction_data *)ptr;
>> +
>> +			if (verbose) {
>> +				printf("BR_TRANSACTION data:\n");
>> +				print_trans_data(txn);
>> +			}
>> +
>> +			/* The manager sends reply that will contain its fd */
>> +			if (send_reply(fd, txn) < 0) {
>> +				fprintf(stderr, "send_reply() failed.\n");
>> +				return -1;
>> +			}
>> +			ptr += sizeof(*txn);
>> +			break;
>> +		}
>> +		case BR_REPLY: {
>> +			struct binder_transaction_data *txn =
>> +				(struct binder_transaction_data *)ptr;
>> +
>> +			if (verbose) {
>> +				printf("BR_REPLY data:\n");
>> +				print_trans_data(txn);
>> +			}
>> +
>> +			/* Client extracts the Manager fd, and responds */
>> +			extract_fd_and_respond(txn);
>> +			ptr += sizeof(*txn);
>> +			break;
>> +		}
>> +		case BR_DEAD_BINDER:
>> +			break;
>> +		case BR_FAILED_REPLY:
>> +			break;
>> +		case BR_DEAD_REPLY:
>> +			break;
>> +		case BR_ERROR:
>> +			ptr += sizeof(uint32_t);
>> +			break;
>> +		default:
>> +			if (verbose)
>> +				printf("%s Parsed unknown command: %d\n",
>> +				       text, cmd);
>> +			return -1;
>> +		}
>> +	}
>> +
>> +	return cmd;
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +	int opt, option, result, fd, count;
>> +	uint32_t cmd;
>> +	pid_t pid;
>> +	char *driver = "/dev/binder";
>> +	char *context;
>> +	void *mapped;
>> +	size_t mapsize = 2048;
>> +	struct binder_write_read bwr;
>> +	struct flat_binder_object obj;
>> +	struct binder_transaction_data *txn;
>> +	unsigned int readbuf[32];
>> +	unsigned int writebuf[1024];
>> +
>> +	target = 0; /* Only need one target - the Manager */
>> +	verbose = false;
>> +
>> +	while ((opt = getopt(argc, argv, "v")) != -1) {
>> +		switch (opt) {
>> +		case 'v':
>> +			verbose = true;
>> +			break;
>> +		default:
>> +			usage(argv[0]);
>> +		}
>> +	}
>> +
>> +	if ((argc - optind) != 1)
>> +		usage(argv[0]);
>> +
>> +	if (!strcmp(argv[optind], "manager"))
>> +		option = 1;
>> +	else if (!strcmp(argv[optind], "client"))
>> +		option = 2;
>> +	else
>> +		usage(argv[0]);
>> +
>> +	fd = open(driver, O_RDWR | O_CLOEXEC);
>> +	if (fd < 0) {
>> +		fprintf(stderr, "Cannot open %s error: %s\n", driver,
>> +			strerror(errno));
>> +		exit(1);
>> +	}
>> +
>> +	/* Need this or "no VMA" error from kernel */
>> +	mapped = mmap(NULL, mapsize, PROT_READ, MAP_PRIVATE, fd, 0);
>> +	if (mapped == MAP_FAILED) {
>> +		fprintf(stderr, "mmap error: %s\n", strerror(errno));
>> +		close(fd);
>> +		exit(2);
>> +	}
>> +
>> +	/* Get our context and pid */
>> +	result = getcon(&context);
>> +	if (result < 0) {
>> +		fprintf(stderr, "Failed to obtain SELinux context\n");
>> +		result = 3;
>> +		goto brexit;
>> +	}
>> +	pid = getpid();
>> +
>> +	switch (option) {
>> +	case 1: /* manager */
>> +		if (verbose) {
>> +			printf("Manager PID: %d Process context:\n\t%s\n",
>> +			       pid, context);
>> +		}
>> +
>> +		result = ioctl(fd, BINDER_SET_CONTEXT_MGR, 0);
>> +		if (result < 0) {
>> +			fprintf(stderr,
>> +				"Failed to become context manager: %s\n",
>> +				strerror(errno));
>> +			result = 4;
>> +			goto brexit;
>> +		}
>> +
>> +		readbuf[0] = BC_ENTER_LOOPER;
>> +		bwr.write_size = sizeof(readbuf[0]);
>> +		bwr.write_consumed = 0;
>> +		bwr.write_buffer = (uintptr_t)readbuf;
>> +
>> +		bwr.read_size = 0;
>> +		bwr.read_consumed = 0;
>> +		bwr.read_buffer = 0;
>> +
>> +		result = ioctl(fd, BINDER_WRITE_READ, &bwr);
>> +		if (result < 0) {
>> +			fprintf(stderr,
>> +				"Manager ioctl BINDER_WRITE_READ: %s\n",
>> +				strerror(errno));
>> +			result = 5;
>> +			goto brexit;
>> +		}
>> +
>> +		while (true) {
>> +			bwr.read_size = sizeof(readbuf);
>> +			bwr.read_consumed = 0;
>> +			bwr.read_buffer = (uintptr_t)readbuf;
>> +
>> +			result = ioctl(fd, BINDER_WRITE_READ, &bwr);
>> +			if (result < 0) {
>> +				fprintf(stderr,
>> +					"Manager ioctl BINDER_WRITE_READ: %s\n",
>> +					strerror(errno));
>> +				result = 6;
>> +				goto brexit;
>> +			}
>> +
>> +			if (bwr.read_consumed == 0)
>> +				continue;
>> +
>> +			if (verbose)
>> +				printf("Manager read_consumed: %lld\n",
>> +				       bwr.read_consumed);
>> +
>> +			cmd = binder_parse(fd, (uintptr_t)readbuf,
>> +					   bwr.read_consumed, "Manager");
>> +		}
>> +		break;
>> +
>> +	case 2: /* client */
>> +		if (verbose) {
>> +			printf("Client PID: %d Process context:\n\t%s\n",
>> +			       pid, context);
>> +		}
>> +
>> +		writebuf[0] = BC_TRANSACTION;
>> +		txn = (struct binder_transaction_data *)(&writebuf[1]);
>> +		memset(txn, 0, sizeof(*txn));
>> +		txn->target.handle = target;
>> +		txn->cookie = 0;
>> +		txn->code = 0;
>> +		txn->flags = TF_ACCEPT_FDS;
>> +
>> +		memset(&obj, 0, sizeof(struct flat_binder_object));
>> +		obj.hdr.type = BINDER_TYPE_WEAK_BINDER;
>> +		obj.flags = 0x7f | FLAT_BINDER_FLAG_ACCEPTS_FDS;
>> +		obj.binder = target;
>> +		obj.handle = 0;
>> +		obj.cookie = 0;
>> +
>> +		txn->data_size = sizeof(struct flat_binder_object);
>> +		txn->data.ptr.buffer = (uintptr_t)&obj;
>> +		txn->data.ptr.offsets = (uintptr_t)&obj +
>> +					sizeof(struct flat_binder_object);
>> +		txn->offsets_size = sizeof(binder_size_t);
>> +
>> +		memset(&bwr, 0, sizeof(bwr));
>> +		bwr.write_buffer = (unsigned long)writebuf;
>> +		bwr.write_size = sizeof(writebuf[0]) + sizeof(*txn);
>> +
>> +		/* Expect client to get max two responses:
>> +		 *	1) From the above BC_TRANSACTION
>> +		 *	2) The responding BC_REPLY from send_reply()
>> +		 * unless an error.
>> +		 */
>> +		count = 0;
>> +		while (count != 2) {
>> +			bwr.read_size = sizeof(readbuf);
>> +			bwr.read_consumed = 0;
>> +			bwr.read_buffer = (uintptr_t)readbuf;
>> +
>> +			result = ioctl(fd, BINDER_WRITE_READ, &bwr);
>> +			if (result < 0) {
>> +				fprintf(stderr,
>> +					"Client ioctl BINDER_WRITE_READ: %s\n",
>> +					strerror(errno));
>> +				result = 8;
>> +				goto brexit;
>> +			}
>> +
>> +			if (verbose)
>> +				printf("Client read_consumed: %lld\n",
>> +				       bwr.read_consumed);
>> +
>> +			cmd = binder_parse(fd, (uintptr_t)readbuf,
>> +					   bwr.read_consumed, "Client");
>> +
>> +			if (cmd == BR_FAILED_REPLY ||
>> +			    cmd == BR_DEAD_REPLY ||
>> +			    cmd == BR_DEAD_BINDER) {
>> +				result = 9;
>> +				goto brexit;
>> +			}
>> +			count++;
>> +		}
>> +		break;
>> +
>> +	default:
>> +		result = -1;
>> +	}
>> +
>> +brexit:
>> +	free(context);
>> +	munmap(mapped, mapsize);
>> +	close(fd);
>> +
>> +	return result;
>> +}
>>
> 
