Message-ID: <1495742895.22368.11.camel@tycho.nsa.gov>
Subject: Re: [PATCH v1 2/2] selinux-testsuite: Infiniband endport tests
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dan Jurgens <danielj@mellanox.com>, selinux@tycho.nsa.gov
Date: Thu, 25 May 2017 16:08:15 -0400
In-Reply-To: <1495635523-84017-3-git-send-email-danielj@mellanox.com>
References: <1495635523-84017-1-git-send-email-danielj@mellanox.com>
 <1495635523-84017-3-git-send-email-danielj@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-05-24 at 17:18 +0300, Dan Jurgens wrote:
> From: Daniel Jurgens <danielj@mellanox.com>
> 
> New tests for Infiniband endports. Most users do not have infiniband
> hardware, and if they do the device names can vary.  There is a
> configuration file for enabling the tests and setting environment
> specific configurations.  If the tests are disabled they always show
> as
> passed.
> 
> A special test application was unnecessary, a standard diagnostic
> application is used instead.  This required a change to the make file
> to avoid trying to build an application in the new subdir.
> 
> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
> 
> ---
> v1:
> - Synchronize interface names with refpolicy changes.
> - Allowed access to unlabeled pkeys vs default pkey, default pkey is
> no
> longer labeled in the refpolicy.
> ---
>  README                                       |  7 +++-
>  policy/Makefile                              |  2 +-
>  policy/test_ibendport.te                     | 35
> ++++++++++++++++++++
>  tests/Makefile                               |  4 ++-
>  tests/infiniband_endport/ibendport_test.conf | 14 ++++++++
>  tests/infiniband_endport/test                | 49
> ++++++++++++++++++++++++++++
>  6 files changed, 108 insertions(+), 3 deletions(-)
>  create mode 100644 policy/test_ibendport.te
>  create mode 100644 tests/infiniband_endport/ibendport_test.conf
>  create mode 100644 tests/infiniband_endport/test
> 
> diff --git a/README b/README
> index b64e2de..8e1b391 100644
> --- a/README
> +++ b/README
> @@ -200,7 +200,12 @@ INFINIBAND TESTS
>  ----------------
>  Because running Infiniband tests requires specialized hardware you
> must
>  set up a configuration file for these tests. The tests are disabled
> by
> -default.  See comments in the configuration file for info.
> +default.  See comments in the configuration file for info. The
> endport
> +tests use smpquery, for Fedora it's provided by the infiniband-diags
> +package.
>  
>  Infiniband PKey test conf file:
>  tests/infiniband_pkey/ibpkey_test.conf
> +
> +Infiniband Endport test conf file:
> +tests/infiniband_endport/ibendport_test.conf
> diff --git a/policy/Makefile b/policy/Makefile
> index 46c9fb5..694836b 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -23,7 +23,7 @@ TARGETS = \
>  	test_task_getsid.te test_task_setpgid.te
> test_task_setsched.te \
>  	test_transition.te test_inet_socket.te test_unix_socket.te \
>  	test_mmap.te test_overlayfs.te test_mqueue.te
> test_mac_admin.te \
> -	test_ibpkey.te
> +	test_ibpkey.te test_ibendport.te
>  
>  ifeq ($(shell [ $(POL_VERS) -ge 24 ] && echo true),true)
>  TARGETS += test_bounds.te
> diff --git a/policy/test_ibendport.te b/policy/test_ibendport.te
> new file mode 100644
> index 0000000..8387432
> --- /dev/null
> +++ b/policy/test_ibendport.te
> @@ -0,0 +1,35 @@
> +#################################
> +#
> +# Policy for testing Infiniband Pkey access.
> +#
> +
> +gen_require(`
> +	type bin_t;
> +	type infiniband_mgmt_device_t;
> +')
> +
> +attribute ibendportdomain;
> +
> +# Domain for process.
> +type test_ibendport_manage_subnet_t;
> +domain_type(test_ibendport_manage_subnet_t)
> +unconfined_runs_test(test_ibendport_manage_subnet_t)
> +typeattribute test_ibendport_manage_subnet_t testdomain;
> +typeattribute test_ibendport_manage_subnet_t ibendportdomain;
> +
> +type test_ibendport_t;
> +corenet_ib_endport(test_ibendport_t)
> +
> +dev_rw_infiniband_dev(test_ibendport_manage_subnet_t)
> +dev_rw_sysfs(test_ibendport_manage_subnet_t)
> +
> +allow test_ibendport_manage_subnet_t bin_t:file entrypoint;
> +allow test_ibendport_manage_subnet_t bin_t:file execute;

Just use:
corecmd_bin_entry_type(test_ibendport_manage_subnet_t)


> +allow test_ibendport_manage_subnet_t
> infiniband_mgmt_device_t:chr_file { read write open ioctl};
> +corenet_ib_access_unlabeled_pkeys(test_ibendport_manage_subnet_t)

This interface needs to be wrapped with an ifdef if this file is not
excluded when refpolicy lacks the necessary definitions.

> +
> +allow test_ibendport_manage_subnet_t
> test_ibendport_t:infiniband_endport manage_subnet;

This needs to be conditional on the definition of this class.  You
could either omit the .te file altogether in the Makefile if not
defined, as we do for e.g. cap_userns, icmp_socket, etc, or you need to
 wrap it conditionally as we do for e.g. map permission.

> +
> +# Allow all of these domains to be entered from the sysadm domain.
> +miscfiles_domain_entry_test_files(ibendportdomain)
> +userdom_sysadm_entry_spec_domtrans_to(ibendportdomain)
> diff --git a/tests/Makefile b/tests/Makefile
> index 7dfe2a8..63e6f57 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -12,6 +12,8 @@ SUBDIRS:= domain_trans entrypoint execshare
> exectrace execute_no_trans \
>  	capable_sys dyntrans dyntrace bounds nnp mmap unix_socket
> inet_socket \
>  	overlay checkreqprot mqueue mac_admin infiniband_pkey
>  
> +SUBDIRS_NO_MAKE:= infiniband_endport
> +
>  ifeq ($(shell grep -q cap_userns
> $(POLDEV)/include/support/all_perms.spt && echo true),true)
>  ifneq ($(shell ./kvercmp $$(uname -r) 4.7),-1)
>  SUBDIRS += cap_userns
> @@ -56,7 +58,7 @@ all:
>  
>  test: all
>  	chcon -R -t test_file_t .
> -	@SUBDIRS="$(SUBDIRS)" PATH=/usr/bin:/bin:/usr/sbin:/sbin
> ./runtests.pl
> +	@SUBDIRS="$(SUBDIRS) $(SUBDIRS_NO_MAKE)"
> PATH=/usr/bin:/bin:/usr/sbin:/sbin ./runtests.pl

This works, but elsewhere we've always just put a trivial Makefile with
empty all: and clean: targets in it, e.g. entrypoint/Makefile.  No big
deal either way.

>  
>  clean:
>  	@for subdir in $(SUBDIRS); do \
> diff --git a/tests/infiniband_endport/ibendport_test.conf
> b/tests/infiniband_endport/ibendport_test.conf
> new file mode 100644
> index 0000000..601b290
> --- /dev/null
> +++ b/tests/infiniband_endport/ibendport_test.conf
> @@ -0,0 +1,14 @@
> +# Enable(1)/Disable these tests.
> +SELINUX_INFINIBAND_ENDPORT_TEST=0
> +
> +# Device/port pair that should allow access.
> +# The test uses semanage to allow, because
> +# ibendports are all unlabeled by default
> +# the reference policy. This allows using
> +# the same device and port for both the pass
> +# and fail testing as well.
> +SELINUX_INFINIBAND_ENDPORT_TEST_ALLOWED=mlx5_3 1
> +
> +# Device/port pairs that should deny access.
> +SELINUX_INFINIBAND_ENDPORT_TEST_DENIED=mlx5_2 1
> +
> diff --git a/tests/infiniband_endport/test
> b/tests/infiniband_endport/test
> new file mode 100644
> index 0000000..b4e553d
> --- /dev/null
> +++ b/tests/infiniband_endport/test
> @@ -0,0 +1,49 @@
> +#!/usr/bin/perl
> +
> +use Test;
> +
> +BEGIN { plan tests => 2}
> +
> +$basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
> +
> +my %conf;
> +my $confpath = $basedir."/ibendport_test.conf";
> +open($f, $confpath) or die ("Couldn't open ibtest.conf");
> +while($r = <$f>) {
> +	if ($r =~ /^\s*#/ || $r =~ /^\s*$/) { next; }
> +	chomp $r;
> +	($k,$v) = split(/=/, $r);
> +	$conf{$k} = $v;
> +}
> +
> +if ($conf{SELINUX_INFINIBAND_ENDPORT_TEST} eq 1) {
> +	@allowed_device_port = split(/,/,
> $conf{SELINUX_INFINIBAND_ENDPORT_TEST_ALLOWED});
> +	@denied_device_port = split(/,/,
> $conf{SELINUX_INFINIBAND_ENDPORT_TEST_DENIED});
> +
> +	foreach (@allowed_device_port) {
> +		@dev_port_pair= split(/ /, $_);
> +
> +		system "semanage ibendport -a -t test_ibendport_t -z
> $_ 2>/dev/null";
> +		$result = system "runcon -t
> test_ibendport_manage_subnet_t smpquery PKeyTable -C
> $dev_port_pair[0] -P $dev_port_pair[1] -D 1 2>/dev/null";
> +		system "semanage ibendport -d -t test_ibendport_t -z
> $_ 2>/dev/null";
> +		if($result ne 0) {
> +			last;
> +		}
> +	}
> +	ok($result, 0);
> +
> +        foreach (@denied_device_port) {
> +	        @dev_port_pair= split(/ /, $_);
> +	        $result = system "runcon -t
> test_ibendport_manage_subnet_t smpquery PKeyTable -C
> $dev_port_pair[0] -P $dev_port_pair[1] -D 1 2>/dev/null";
> +
> +		if ($result>>8 eq 0) {
> +			last;
> +		}
> +	}
> +
> +	ok(int($result>>8) ne 0);
> +} else {
> +	ok(1);
> +	ok(1);
> +}
> +exit;
