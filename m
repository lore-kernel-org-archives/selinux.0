Subject: Re: [PATCH] selinux-testsuite: Add tests for extended socket classes.
To: selinux@tycho.nsa.gov
References: <1481299051-27863-1-git-send-email-sds@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <dde18b9f-58e8-680b-7d91-391029bfd682@tycho.nsa.gov>
Date: Fri, 9 Dec 2016 11:14:10 -0500
MIME-Version: 1.0
In-Reply-To: <1481299051-27863-1-git-send-email-sds@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/09/2016 10:57 AM, Stephen Smalley wrote:
> Add tests for the extended_socket_class policy capability.
> This change includes the following tests:
> - Test that ICMP datagram sockets are mapped to the new icmp_socket
> class and not to rawip_socket for both IPv4 and IPv6.
> 
> - Test that SCTP stream and seqpacket sockets are mapped to the
> new sctp_socket class and not to rawip_socket for both IPv4 and IPv6.
> 
> - Test that Bluetooth sockets are mapped to the new bluetooth_socket
> class and not to socket.
> 
> - Test that AF_ALG sockets are mapped to the new alg_socket class
> and not to socket.
> 
> The tests are only run if the extended_socket_class policy capability
> is present and enabled in the kernel and the base policy, and only if
> the new classes are defined in the base policy.  This avoids breaking
> the testsuite on systems with older kernels, older policies, or
> policies that do not enable the policy capability.

BTW, while creating these tests, I was also trying to test AF_BRIDGE
originally, but it doesn't appear that you can in fact create AF_BRIDGE
sockets AFAICT; socket(AF_BRIDGE, <any>, <any>) seems to always return
EAFNOSUPPORT even though CONFIG_BRIDGE_* is enabled in the kernel
config.  So possibly we don't need a bridge_socket security class?  Not
sure what other address families are similar?

> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  README                                   |  8 +++
>  policy/Makefile                          |  4 ++
>  policy/test_extended_socket_class.te     | 64 +++++++++++++++++++++++
>  tests/Makefile                           |  4 ++
>  tests/extended_socket_class/Makefile     |  4 ++
>  tests/extended_socket_class/sockcreate.c | 89 ++++++++++++++++++++++++++++++++
>  tests/extended_socket_class/test         | 76 +++++++++++++++++++++++++++
>  7 files changed, 249 insertions(+)
>  create mode 100644 policy/test_extended_socket_class.te
>  create mode 100644 tests/extended_socket_class/Makefile
>  create mode 100644 tests/extended_socket_class/sockcreate.c
>  create mode 100755 tests/extended_socket_class/test
> 
> diff --git a/README b/README
> index 8dbbbda..521e965 100644
> --- a/README
> +++ b/README
> @@ -39,6 +39,14 @@ CONFIG_JFS_SECURITY=y
>  CONFIG_XFS_SECURITY=y
>  CONFIG_JFFS2_FS_SECURITY=y
>  
> +# Network protocol implementations.
> +# These are enabled to test the extended socket classes in
> +# tests/extended_socket_class; they are not required
> +# for SELinux operation itself.
> +CONFIG_IP_SCTP=m
> +CONFIG_BT=m
> +CONFIG_CRYPTO_USER_API=m
> +
>  Do not set CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX; it is an
>  option for legacy distributions (Fedora 3 and 4).
>  
> diff --git a/policy/Makefile b/policy/Makefile
> index 16ab3b9..992278b 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -30,6 +30,10 @@ ifeq ($(shell grep -q cap_userns $(POLDEV)/include/support/all_perms.spt && echo
>  TARGETS += test_cap_userns.te
>  endif
>  
> +ifeq ($(shell grep -q icmp_socket $(POLDEV)/include/support/all_perms.spt && echo true),true)
> +TARGETS += test_extended_socket_class.te
> +endif
> +
>  ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
>  TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te, $(TARGETS))
>  endif
> diff --git a/policy/test_extended_socket_class.te b/policy/test_extended_socket_class.te
> new file mode 100644
> index 0000000..4f30c9f
> --- /dev/null
> +++ b/policy/test_extended_socket_class.te
> @@ -0,0 +1,64 @@
> +########################################
> +#
> +# Policy for testing the new socket classes
> +# introduced when the extended_socket_class
> +# policy capability is enabled in policy and
> +# supported by the kernel.
> +
> +attribute extsocktestdomain;
> +
> +#
> +# extended_socket_test(newclass, oldclass)
> +#
> +# Generate a pair of test domains and rules to test
> +# that when the extended_socket_class policy capability
> +# is enabled, the kernel checks permission against the
> +# 'newclass' security class rather than the 'oldclass'
> +# security class.
> +#
> +define(`extended_socket_class_test', `
> +# Domain that is allowed to create $1_socket.
> +type test_$1_t;
> +domain_type(test_$1_t)
> +unconfined_runs_test(test_$1_t)
> +typeattribute test_$1_t extsocktestdomain;
> +typeattribute test_$1_t testdomain;
> +
> +# Allow $1 but not $2.
> +# This is to ensure that the kernel is checking the right class.
> +allow test_$1_t self:$1 create_socket_perms;
> +
> +# Domain that is not allowed to create $1.
> +type test_no_$1_t;
> +domain_type(test_no_$1_t)
> +unconfined_runs_test(test_no_$1_t)
> +typeattribute test_no_$1_t extsocktestdomain;
> +typeattribute test_no_$1_t testdomain;
> +
> +# Allow $2 but not $1.
> +# This is to ensure that the kernel is checking the right class.
> +allow test_no_$1_t self:$2 create_socket_perms;
> +')
> +
> +# Test use of icmp_socket class for ICMP datagram sockets instead of rawip_socket.
> +extended_socket_class_test(icmp_socket, rawip_socket)
> +
> +# Test use of sctp_socket class for SCTP sockets instead of rawip_socket.
> +extended_socket_class_test(sctp_socket, rawip_socket)
> +
> +# Test use of bluetooth_socket for Bluetooth sockets instead of socket.
> +extended_socket_class_test(bluetooth_socket, socket)
> +
> +# Test use of alg_socket for Alg (Crypto API) sockets instead of socket.
> +extended_socket_class_test(alg_socket, socket)
> +
> +#
> +# Common rules for all extended_socket_class test domains.
> +#
> +
> +# Trigger kernel module auto-loading of the network protocol implementations.
> +kernel_request_load_module(extsocktestdomain)
> +
> +# Entry into the test domains via the test program.
> +miscfiles_domain_entry_test_files(extsocktestdomain)
> +userdom_sysadm_entry_spec_domtrans_to(extsocktestdomain)
> diff --git a/tests/Makefile b/tests/Makefile
> index 57a5d12..228b764 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -16,6 +16,10 @@ ifeq ($(shell grep -q cap_userns $(POLDEV)/include/support/all_perms.spt && echo
>  SUBDIRS += cap_userns
>  endif
>  
> +ifeq ($(shell grep -q icmp_socket $(POLDEV)/include/support/all_perms.spt && grep -q 1 /sys/fs/selinux/policy_capabilities/extended_socket_class && echo true),true)
> +SUBDIRS += extended_socket_class
> +endif
> +
>  ifeq ($(DISTRO),RHEL4)
>      SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket mmap nnp overlay unix_socket, $(SUBDIRS))
>  endif
> diff --git a/tests/extended_socket_class/Makefile b/tests/extended_socket_class/Makefile
> new file mode 100644
> index 0000000..8dce555
> --- /dev/null
> +++ b/tests/extended_socket_class/Makefile
> @@ -0,0 +1,4 @@
> +TARGETS=$(patsubst %.c,%,$(wildcard *.c))
> +all: $(TARGETS)
> +clean:
> +	rm -f $(TARGETS)
> diff --git a/tests/extended_socket_class/sockcreate.c b/tests/extended_socket_class/sockcreate.c
> new file mode 100644
> index 0000000..c5802ae
> --- /dev/null
> +++ b/tests/extended_socket_class/sockcreate.c
> @@ -0,0 +1,89 @@
> +#include <sys/types.h>
> +#include <sys/socket.h>
> +#include <netinet/in.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <errno.h>
> +
> +struct nameval {
> +	const char *name;
> +	const int value;
> +};
> +
> +static struct nameval domains[] = {
> +	{ "inet", AF_INET },
> +	{ "inet6", AF_INET6 },
> +	{ "bluetooth", AF_BLUETOOTH },
> +	{ "alg", AF_ALG },
> +	{ NULL, 0 }
> +};
> +
> +static struct nameval types[] = {
> +	{ "stream", SOCK_STREAM },
> +	{ "dgram", SOCK_DGRAM },
> +	{ "seqpacket", SOCK_SEQPACKET },
> +	{ "raw", SOCK_RAW },
> +	{ NULL, 0 }
> +};
> +
> +static struct nameval protocols[] = {
> +	{ "icmp", IPPROTO_ICMP },
> +	{ "icmpv6", IPPROTO_ICMPV6 },
> +	{ "sctp", IPPROTO_SCTP },
> +	{ "default", 0 },
> +	{ NULL, 0 }
> +};
> +
> +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> +
> +static int lookup_value(const char *name, const struct nameval *nvlist)
> +{
> +	const struct nameval *nv;
> +
> +	for (nv = nvlist; nv->name; nv++) {
> +		if (!strcmp(nv->name, name))
> +			return nv->value;
> +	}
> +	return -1;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int sock;
> +	int domain, type, protocol;
> +
> +	if (argc != 4) {
> +		fprintf(stderr, "usage: %s domain type protocol\n", argv[0]);
> +		exit(1);
> +	}
> +
> +	domain = lookup_value(argv[1], domains);
> +	if (domain < 0) {
> +		fprintf(stderr, "%s: unknown domain %s\n", argv[0], argv[1]);
> +		exit(1);
> +	}
> +
> +	type = lookup_value(argv[2], types);
> +	if (type < 0) {
> +		fprintf(stderr, "%s: unknown type %s\n", argv[0], argv[2]);
> +		exit(1);
> +	}
> +
> +	protocol = lookup_value(argv[3], protocols);
> +	if (protocol < 0) {
> +		fprintf(stderr, "%s: unknown protocol %s\n", argv[0], argv[3]);
> +		exit(1);
> +	}
> +
> +	sock = socket(domain, type, protocol);
> +	if (sock < 0) {
> +		fprintf(stderr, "%s: socket(%s/%d, %s/%d, %s/%d): %s\n",
> +			argv[0], argv[1], domain, argv[2], type,
> +			argv[3], protocol, strerror(errno));
> +		exit(1);
> +	}
> +	close(sock);
> +	exit(0);
> +}
> diff --git a/tests/extended_socket_class/test b/tests/extended_socket_class/test
> new file mode 100755
> index 0000000..eb100ee
> --- /dev/null
> +++ b/tests/extended_socket_class/test
> @@ -0,0 +1,76 @@
> +#!/usr/bin/perl
> +
> +use Test;
> +BEGIN { plan tests => 16 };
> +
> +$basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
> +
> +# Enable gid 0 to create ICMP sockets for testing.
> +system("echo 0 0 > /proc/sys/net/ipv4/ping_group_range");
> +
> +# Verify that test_icmp_socket_t can create an ICMP socket.
> +$result = system("runcon -t test_icmp_socket_t -- $basedir/sockcreate inet dgram icmp 2>&1");
> +ok($result, 0);
> +
> +# Verify that test_no_icmp_socket_t cannot create an ICMP socket.
> +$result = system("runcon -t test_no_icmp_socket_t -- $basedir/sockcreate inet dgram icmp 2>&1");
> +ok($result);
> +
> +# Verify that test_icmp_socket_t can create an ICMPv6 socket.
> +$result = system("runcon -t test_icmp_socket_t -- $basedir/sockcreate inet6 dgram icmpv6 2>&1");
> +ok($result, 0);
> +
> +# Verify that test_no_icmp_socket_t cannot create an ICMPv6 socket.
> +$result = system("runcon -t test_no_icmp_socket_t -- $basedir/sockcreate inet6 dgram icmpv6 2>&1");
> +ok($result);
> +
> +# Restore to the kernel defaults - no one allowed to create ICMP sockets.
> +system("echo 1 0 > /proc/sys/net/ipv4/ping_group_range");
> +
> +# Verify that test_sctp_socket_t can create an IPv4 stream SCTP socket.
> +$result = system("runcon -t test_sctp_socket_t -- $basedir/sockcreate inet stream sctp 2>&1");
> +ok($result, 0);
> +
> +# Verify that test_no_sctp_socket_t cannot create an IPv4 stream SCTP socket.
> +$result = system("runcon -t test_no_sctp_socket_t -- $basedir/sockcreate inet stream sctp 2>&1");
> +ok($result);
> +
> +# Verify that test_sctp_socket_t can create an IPv4 seqpacket SCTP socket.
> +$result = system("runcon -t test_sctp_socket_t -- $basedir/sockcreate inet seqpacket sctp 2>&1");
> +ok($result, 0);
> +
> +# Verify that test_no_sctp_socket_t cannot create an IPv4 seqpacket SCTP socket.
> +$result = system("runcon -t test_no_sctp_socket_t -- $basedir/sockcreate inet seqpacket sctp 2>&1");
> +ok($result);
> +
> +# Verify that test_sctp_socket_t can create an IPv6 stream SCTP socket.
> +$result = system("runcon -t test_sctp_socket_t -- $basedir/sockcreate inet6 stream sctp 2>&1");
> +ok($result, 0);
> +
> +# Verify that test_no_sctp_socket_t cannot create an IPv6 stream SCTP socket.
> +$result = system("runcon -t test_no_sctp_socket_t -- $basedir/sockcreate inet6 stream sctp 2>&1");
> +ok($result);
> +
> +# Verify that test_sctp_socket_t can create an IPv6 seqpacket SCTP socket.
> +$result = system("runcon -t test_sctp_socket_t -- $basedir/sockcreate inet6 seqpacket sctp 2>&1");
> +ok($result, 0);
> +
> +# Verify that test_no_sctp_socket_t cannot create an IPv6 seqpacket SCTP socket.
> +$result = system("runcon -t test_no_sctp_socket_t -- $basedir/sockcreate inet6 seqpacket sctp 2>&1");
> +ok($result);
> +
> +# Verify that test_bluetooth_socket_t can create a Bluetooth socket.
> +$result = system("runcon -t test_bluetooth_socket_t -- $basedir/sockcreate bluetooth stream default 2>&1");
> +ok($result, 0);
> +
> +# Verify that test_no_bluetooth_socket_t cannot create a Bluetooth socket.
> +$result = system("runcon -t test_no_bluetooth_socket_t -- $basedir/sockcreate bluetooth stream default 2>&1");
> +ok($result);
> +
> +# Verify that test_alg_socket_t can create a Crypto API socket.
> +$result = system("runcon -t test_alg_socket_t -- $basedir/sockcreate alg seqpacket default 2>&1");
> +ok($result, 0);
> +
> +# Verify that test_no_alg_socket_t cannot create a Crypto API socket.
> +$result = system("runcon -t test_no_alg_socket_t -- $basedir/sockcreate alg seqpacket default 2>&1");
> +ok($result);
> 
