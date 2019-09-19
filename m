Return-Path: <SRS0=jdxV=XO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28272C3A5A6
	for <selinux@archiver.kernel.org>; Thu, 19 Sep 2019 13:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73EA21D56
	for <selinux@archiver.kernel.org>; Thu, 19 Sep 2019 13:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="oClT9Nfs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389234AbfISNg3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Sep 2019 09:36:29 -0400
Received: from mailomta9-re.btinternet.com ([213.120.69.102]:41262 "EHLO
        re-prd-fep-041.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388819AbfISNg3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Sep 2019 09:36:29 -0400
Received: from re-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.54.8])
          by re-prd-fep-041.btinternet.com with ESMTP
          id <20190919133624.BTFD6647.re-prd-fep-041.btinternet.com@re-prd-rgout-005.btmx-prd.synchronoss.net>;
          Thu, 19 Sep 2019 14:36:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1568900184; 
        bh=nHBYpjens2ya9kKk/7VjwsupSUgDloPr/ORw3LgCX+o=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:MIME-Version;
        b=oClT9NfsxxGW2u4av1F501lQGOfEqQ22qO25r1wGKlhZJPFybpPcpXaQJ7saAsKnBx2JCMfQkNWUSQ9DLPIuIa0WppYTAEr2z+ton/DpNX7uuuP0JPzZ2CfiaxZPqci50KOJGgroqzG1eDhmNb4nA9fxQXJvQHrriasBRXA8ELTqcGbzCXbL0X1IyYs0rWI4Oiy8+kErfwAejxxYxOAdqF5YsddaMnvcg9ZVtMYz1pPyVeqsDEyq12Xw8Qz+Ugjbg1sQx8S3RV7pnpdez+zQM9l8mjY958gTLkTxjSJ7xVa7RAn8IVP5uSyMJ4ZS4ByhVsjEgKZrk1QbgRXVqWTxjQ==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [31.49.59.204]
X-OWM-Source-IP: 31.49.59.204 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedufedrvddtgdeikecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucffohhmrghinheplhhkmhhlrdhorhhgnecukfhppeefuddrgeelrdehledrvddtgeenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrgeelrdehledrvddtgedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssehhohhtmhgrihhlrdgtohhmqedprhgtphhtthhopeeoshgushesthihtghhohdrnhhsrgdrghhovheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.49.59.204) by re-prd-rgout-005.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5D834EE500072657; Thu, 19 Sep 2019 14:36:24 +0100
Message-ID: <eecba7e2230c21591a6a9a8cce79cc91aac5516a.camel@btinternet.com>
Subject: Re: [PATCH V4 1/3] selinux-testsuite: Add BPF tests
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org,
        paul@paul-moore.com
Date:   Thu, 19 Sep 2019 14:36:22 +0100
In-Reply-To: <38ef3983-987f-692b-fe1d-14ed15a7a507@tycho.nsa.gov>
References: <20190917145640.25629-1-richard_c_haines@btinternet.com>
         <20190917145640.25629-2-richard_c_haines@btinternet.com>
         <38ef3983-987f-692b-fe1d-14ed15a7a507@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 2019-09-18 at 10:58 -0400, Stephen Smalley wrote:
> On 9/17/19 10:56 AM, Richard Haines wrote:
> > This adds basic BPF tests for map and prog functions.
> > 
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > ---
> >   README.md              |  4 ++-
> >   defconfig              |  5 +++
> >   policy/Makefile        |  4 +++
> >   policy/test_bpf.te     | 78
> > ++++++++++++++++++++++++++++++++++++++++++
> >   tests/Makefile         |  7 ++++
> >   tests/bpf/.gitignore   |  2 ++
> >   tests/bpf/Makefile     | 10 ++++++
> >   tests/bpf/bpf_common.c | 53 ++++++++++++++++++++++++++++
> >   tests/bpf/bpf_common.h | 34 ++++++++++++++++++
> >   tests/bpf/bpf_test.c   | 77
> > +++++++++++++++++++++++++++++++++++++++++
> >   tests/bpf/test         | 64 ++++++++++++++++++++++++++++++++++
> >   11 files changed, 337 insertions(+), 1 deletion(-)
> >   create mode 100644 policy/test_bpf.te
> >   create mode 100644 tests/bpf/.gitignore
> >   create mode 100644 tests/bpf/Makefile
> >   create mode 100644 tests/bpf/bpf_common.c
> >   create mode 100644 tests/bpf/bpf_common.h
> >   create mode 100644 tests/bpf/bpf_test.c
> >   create mode 100755 tests/bpf/test
> > 
> > diff --git a/README.md b/README.md
> > index 26784f8..1396c8e 100644
> > --- a/README.md
> > +++ b/README.md
> > @@ -51,6 +51,7 @@ similar dependencies):
> >   * iptables _(to load the `iptables SECMARK` rules during
> > `inet_socket` tests)_
> >   * lksctp-tools-devel _(to build the SCTP test programs)_
> >   * attr _(tools used by the overlayfs tests)_
> > +* libbpf-devel _(tools used by the bpf tests)_
> >   
> >   On a modern Fedora system you can install these dependencies with
> > the
> >   following command:
> > @@ -65,7 +66,8 @@ following command:
> >   		netlabel_tools \
> >   		iptables \
> >   		lksctp-tools-devel \
> > -		attr
> > +		attr \
> > +		libbpf-devel
> >   
> >   The testsuite requires a pre-existing base policy configuration
> > of SELinux,
> >   using either the old example policy or the reference policy as
> > the baseline.
> > diff --git a/defconfig b/defconfig
> > index d7f0ea5..cb57f22 100644
> > --- a/defconfig
> > +++ b/defconfig
> > @@ -62,3 +62,8 @@ CONFIG_ANDROID_BINDER_IPC=y
> >   # This will configure the Dynamically Allocated Binder Devices
> > added
> >   # to 5.0+ kernels:
> >   CONFIG_ANDROID_BINDERFS=y
> > +
> > +# Test BPF + check in selinux_file_receive and
> > selinux_binder_transfer_files.
> > +# They are not required for SELinux operation itself.
> > +CONFIG_BPF=y
> > +CONFIG_BPF_SYSCALL=y
> > diff --git a/policy/Makefile b/policy/Makefile
> > index 305b572..16a4469 100644
> > --- a/policy/Makefile
> > +++ b/policy/Makefile
> > @@ -71,6 +71,10 @@ ifeq ($(shell grep -q
> > corenet_sctp_bind_all_nodes $(POLDEV)/include/kernel/coren
> >   TARGETS += test_sctp.te
> >   endif
> >   
> > +ifeq ($(shell grep -q bpf $(POLDEV)/include/support/all_perms.spt
> > && echo true),true)
> > +TARGETS += test_bpf.te
> > +endif
> > +
> >   ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
> >   TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te,
> > $(TARGETS))
> >   endif
> > diff --git a/policy/test_bpf.te b/policy/test_bpf.te
> > new file mode 100644
> > index 0000000..89d240c
> > --- /dev/null
> > +++ b/policy/test_bpf.te
> > @@ -0,0 +1,78 @@
> > +#
> > +################# BPF selinux-testsuite policy module
> > ######################
> > +#
> > +
> > +attribute bpfdomain;
> > +
> > +################################### Main
> > ###################################
> > +type test_bpf_t;
> > +domain_type(test_bpf_t)
> > +unconfined_runs_test(test_bpf_t)
> > +typeattribute test_bpf_t testdomain;
> > +typeattribute test_bpf_t bpfdomain;
> > +
> > +allow test_bpf_t self:process { setrlimit };
> > +#allow test_bpf_t self:capability { sys_resource sys_admin };
> > +allow test_bpf_t self:capability { sys_resource };
> > +allow test_bpf_t self:bpf { map_create map_read map_write
> > prog_load prog_run };
> > +
> > +############################## Deny map_create
> > #############################
> > +type test_bpf_deny_map_create_t;
> > +domain_type(test_bpf_deny_map_create_t)
> > +unconfined_runs_test(test_bpf_deny_map_create_t)
> > +typeattribute test_bpf_deny_map_create_t testdomain;
> > +typeattribute test_bpf_deny_map_create_t bpfdomain;
> > +
> > +allow test_bpf_deny_map_create_t self:process { setrlimit };
> > +allow test_bpf_deny_map_create_t self:capability { sys_resource };
> > +allow test_bpf_deny_map_create_t self:bpf { map_read map_write
> > prog_load prog_run };
> > +
> > +############################## Deny map_read
> > ##############################
> > +type test_bpf_deny_map_read_t;
> > +domain_type(test_bpf_deny_map_read_t)
> > +unconfined_runs_test(test_bpf_deny_map_read_t)
> > +typeattribute test_bpf_deny_map_read_t testdomain;
> > +typeattribute test_bpf_deny_map_read_t bpfdomain;
> > +
> > +allow test_bpf_deny_map_read_t self:process { setrlimit };
> > +allow test_bpf_deny_map_read_t self:capability { sys_resource };
> > +allow test_bpf_deny_map_read_t self:bpf { map_create map_write
> > prog_load prog_run };
> > +
> > +############################## Deny map_write
> > ##############################
> > +type test_bpf_deny_map_write_t;
> > +domain_type(test_bpf_deny_map_write_t)
> > +unconfined_runs_test(test_bpf_deny_map_write_t)
> > +typeattribute test_bpf_deny_map_write_t testdomain;
> > +typeattribute test_bpf_deny_map_write_t bpfdomain;
> > +
> > +allow test_bpf_deny_map_write_t self:process { setrlimit };
> > +allow test_bpf_deny_map_write_t self:capability { sys_resource };
> > +allow test_bpf_deny_map_write_t self:bpf { map_create map_read
> > prog_load prog_run };
> > +
> > +############################## Deny prog_load
> > ##############################
> > +type test_bpf_deny_prog_load_t;
> > +domain_type(test_bpf_deny_prog_load_t)
> > +unconfined_runs_test(test_bpf_deny_prog_load_t)
> > +typeattribute test_bpf_deny_prog_load_t testdomain;
> > +typeattribute test_bpf_deny_prog_load_t bpfdomain;
> > +
> > +allow test_bpf_deny_prog_load_t self:process { setrlimit };
> > +allow test_bpf_deny_prog_load_t self:capability { sys_resource };
> > +allow test_bpf_deny_prog_load_t self:bpf { map_create map_read
> > map_write prog_run };
> > +
> > +############################## Deny prog_run
> > ###############################
> > +type test_bpf_deny_prog_run_t;
> > +domain_type(test_bpf_deny_prog_run_t)
> > +unconfined_runs_test(test_bpf_deny_prog_run_t)
> > +typeattribute test_bpf_deny_prog_run_t testdomain;
> > +typeattribute test_bpf_deny_prog_run_t bpfdomain;
> > +
> > +allow test_bpf_deny_prog_run_t self:process { setrlimit };
> > +allow test_bpf_deny_prog_run_t self:capability { sys_resource };
> > +allow test_bpf_deny_prog_run_t self:bpf { map_create map_read
> > map_write prog_load };
> > +
> > +#
> > +############ Allow these domains to be entered from sysadm domain
> > ############
> > +#
> > +miscfiles_domain_entry_test_files(bpfdomain)
> > +userdom_sysadm_entry_spec_domtrans_to(bpfdomain)
> > diff --git a/tests/Makefile b/tests/Makefile
> > index 63aa325..80187b7 100644
> > --- a/tests/Makefile
> > +++ b/tests/Makefile
> > @@ -42,6 +42,13 @@ ifeq ($(shell grep -q binder
> > $(POLDEV)/include/support/all_perms.spt && test -e
> >   SUBDIRS += binder
> >   endif
> >   
> > +ifeq ($(shell grep -q bpf $(POLDEV)/include/support/all_perms.spt
> > && echo true),true)
> > +ifneq ($(shell ./kvercmp $$(uname -r) 4.4),-1)
> 
> The SELinux checks for bpf weren't introduced until Linux v4.15.

Fixed
> 
> > +SUBDIRS += bpf
> > +export CFLAGS += -DHAVE_BPF
> > +endif
> > +endif
> > +
> >   ifeq ($(shell grep "^SELINUX_INFINIBAND_ENDPORT_TEST="
> > infiniband_endport/ibendport_test.conf | cut -d'=' -f 2),1)
> >   SUBDIRS += infiniband_endport
> >   endif
> > diff --git a/tests/bpf/.gitignore b/tests/bpf/.gitignore
> > new file mode 100644
> > index 0000000..1919ff8
> > --- /dev/null
> > +++ b/tests/bpf/.gitignore
> > @@ -0,0 +1,2 @@
> > +bpf_test
> > +bpf_common
> > diff --git a/tests/bpf/Makefile b/tests/bpf/Makefile
> > new file mode 100644
> > index 0000000..46817a5
> > --- /dev/null
> > +++ b/tests/bpf/Makefile
> > @@ -0,0 +1,10 @@
> > +TARGETS = bpf_test
> > +DEPS = bpf_common.c bpf_common.h
> > +LDLIBS += -lselinux -lbpf
> > +
> > +all: $(TARGETS)
> > +
> > +clean:
> > +	rm -f $(TARGETS)
> > +
> > +$(TARGETS): $(DEPS)
> > diff --git a/tests/bpf/bpf_common.c b/tests/bpf/bpf_common.c
> > new file mode 100644
> > index 0000000..738c607
> > --- /dev/null
> > +++ b/tests/bpf/bpf_common.c
> > @@ -0,0 +1,53 @@
> > +#include "bpf_common.h"
> > +
> > +int create_bpf_map(void)
> > +{
> > +	int map_fd, key;
> > +	long long value = 0;
> > +
> > +	map_fd = bpf_create_map(BPF_MAP_TYPE_ARRAY, sizeof(key),
> > +				sizeof(value), 256, 0);
> > +	if (map_fd < 0) {
> > +		fprintf(stderr, "Failed to create BPF map: %s\n",
> > +			strerror(errno));
> > +		return -1;
> > +	}
> > +
> > +	return map_fd;
> > +}
> > +
> > +int create_bpf_prog(void)
> > +{
> > +	int prog_fd;
> > +	size_t insns_cnt;
> > +
> > +	struct bpf_insn prog[] = {
> > +		BPF_MOV64_IMM(BPF_REG_0, 1),
> > +		BPF_EXIT_INSN(),
> > +	};
> > +	insns_cnt = sizeof(prog) / sizeof(struct bpf_insn);
> > +
> > +	prog_fd = bpf_load_program(BPF_PROG_TYPE_SOCKET_FILTER, prog,
> > +				   insns_cnt, "GPL", 0, NULL, 0);
> > +
> > +	if (prog_fd < 0) {
> > +		fprintf(stderr, "Failed to load BPF prog: %s\n",
> > +			strerror(errno));
> > +		return -1;
> > +	}
> > +
> > +	return prog_fd;
> > +}
> > +
> > +void bpf_setrlimit(void)
> > +{
> > +	int result;
> > +	struct rlimit r = { RLIM_INFINITY, RLIM_INFINITY };
> > +
> > +	result = setrlimit(RLIMIT_MEMLOCK, &r);
> 
> Is this required?  Why must it be unlimited especially for such
> trivial 
> map/prog examples?

Most examples I've seen do this, however reading [1] I've now updated
and added comment:
/*
 * The default RLIMIT_MEMLOCK is normally 64K, however BPF map requires
 * more than this so double it unless RLIM_INFINITY is set.
 */

[1] https://lkml.org/lkml/2019/7/17/713

> 
> > +	if (result < 0) {
> > +		fprintf(stderr, "Failed to set resource limit: %s\n",
> > +			strerror(errno));
> > +		exit(-1);
> > +	}
> > +}
> > diff --git a/tests/bpf/bpf_common.h b/tests/bpf/bpf_common.h
> > new file mode 100644
> > index 0000000..44ac28f
> > --- /dev/null
> > +++ b/tests/bpf/bpf_common.h
> > @@ -0,0 +1,34 @@
> > +#include <stdio.h>
> > +#include <unistd.h>
> > +#include <string.h>
> > +#include <stdlib.h>
> > +#include <errno.h>
> > +#include <stdbool.h>
> > +#include <selinux/selinux.h>
> > +#include <bpf/bpf.h>
> > +#include <linux/bpf.h>
> > +#include <sys/resource.h>
> > +
> > +extern int create_bpf_map(void);
> > +extern int create_bpf_prog(void);
> > +extern void bpf_setrlimit(void);
> > +
> > +/* edited eBPF instruction library */
> > +/* Short form of mov, dst_reg = imm32 */
> > +#define BPF_MOV64_IMM(DST, IMM)				\
> > +	((struct bpf_insn) {				\
> > +		.code  = BPF_ALU64 | BPF_MOV | BPF_K,	\
> > +			 .dst_reg = DST,				\
> > +				    .src_reg = 0,				
> > \
> > +					       .off   = 0,			
> > 	\
> > +							.imm   = IMM })
> > +
> > +/* Program exit */
> > +#define BPF_EXIT_INSN()				\
> > +	((struct bpf_insn) {			\
> > +		.code  = BPF_JMP | BPF_EXIT,	\
> > +			 .dst_reg = 0,			\
> > +				    .src_reg = 0,			\
> > +					       .off   = 0,			
> > \
> > +							.imm   = 0 })
> > +
> > diff --git a/tests/bpf/bpf_test.c b/tests/bpf/bpf_test.c
> > new file mode 100644
> > index 0000000..3c6a29c
> > --- /dev/null
> > +++ b/tests/bpf/bpf_test.c
> > @@ -0,0 +1,77 @@
> > +#include "bpf_common.h"
> > +
> > +static void usage(char *progname)
> > +{
> > +	fprintf(stderr,
> > +		"usage:  %s -m|-p [-v]\n"
> > +		"Where:\n\t"
> > +		"-m    Create BPF map fd\n\t"
> > +		"-p    Create BPF prog fd\n\t"
> > +		"-v Print information.\n", progname);
> > +	exit(-1);
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +	int opt, result, fd;
> > +	bool verbose = false;
> > +	char *context;
> > +
> > +	enum {
> > +		MAP_FD = 1,
> > +		PROG_FD
> > +	} bpf_fd_type;
> > +
> > +	while ((opt = getopt(argc, argv, "mpv")) != -1) {
> > +		switch (opt) {
> > +		case 'm':
> > +			bpf_fd_type = MAP_FD;
> > +			break;
> > +		case 'p':
> > +			bpf_fd_type = PROG_FD;
> > +			break;
> > +		case 'v':
> > +			verbose = true;
> > +			break;
> > +		default:
> > +			usage(argv[0]);
> > +		}
> > +	}
> > +
> > +	result = getcon(&context);
> > +	if (result < 0) {
> > +		fprintf(stderr, "Failed to obtain SELinux context\n");
> > +		exit(-1);
> > +	}
> > +
> > +	if (verbose)
> > +		printf("Process context:\n\t%s\n", context);
> > +
> > +	free(context);
> > +
> > +	/* If BPF enabled, then need to set limits */
> > +	bpf_setrlimit();
> > +
> > +	switch (bpf_fd_type) {
> > +	case MAP_FD:
> > +		if (verbose)
> > +			printf("Creating BPF map\n");
> > +
> > +		fd = create_bpf_map();
> > +		break;
> > +	case PROG_FD:
> > +		if (verbose)
> > +			printf("Creating BPF prog\n");
> > +
> > +		fd = create_bpf_prog();
> > +		break;
> > +	default:
> > +		usage(argv[0]);
> > +	}
> > +
> > +	if (fd < 0)
> > +		return fd;
> > +
> > +	close(fd);
> > +	return 0;
> > +}
> > diff --git a/tests/bpf/test b/tests/bpf/test
> > new file mode 100755
> > index 0000000..ee00a19
> > --- /dev/null
> > +++ b/tests/bpf/test
> > @@ -0,0 +1,64 @@
> > +#!/usr/bin/perl
> > +use Test::More;
> > +
> > +BEGIN {
> > +    $basedir = $0;
> > +    $basedir =~ s|(.*)/[^/]*|$1|;
> > +
> > +    $test_count = 7;
> > +
> > +    # allow info to be shown during tests
> > +    $v = $ARGV[0];
> > +    if ($v) {
> > +        if ( $v ne "-v" ) {
> > +            plan skip_all => "Invalid option (use -v)";
> > +        }
> > +    }
> > +    else {
> > +        $v = " ";
> > +    }
> > +
> > +    plan tests => $test_count;
> > +}
> > +
> > +#
> > +# These tests are run with: kernel.unprivileged_bpf_disabled =
> > FALSE
> > +#
> > +
> > +#
> > +################ Core BPF Tests #######################
> > +#
> > +# BPF map - BPF_MAP_TYPE_ARRAY
> > +$result = system "runcon -t test_bpf_t $basedir/bpf_test -m $v";
> > +ok( $result eq 0 );
> > +
> > +# BPF prog - BPF_PROG_TYPE_SOCKET_FILTER
> > +$result = system "runcon -t test_bpf_t $basedir/bpf_test -p $v";
> > +ok( $result eq 0 );
> > +
> > +# Deny map_create permission
> > +$result =
> > +  system "runcon -t test_bpf_deny_map_create_t $basedir/bpf_test
> > -m $v 2>&1";
> > +ok($result);
> > +
> > +# Deny map_read permission
> > +$result =
> > +  system "runcon -t test_bpf_deny_map_read_t $basedir/bpf_test -m
> > $v 2>&1";
> > +ok($result);
> > +
> > +# Deny map_write permission
> > +$result =
> > +  system "runcon -t test_bpf_deny_map_write_t $basedir/bpf_test -m
> > $v 2>&1";
> > +ok($result);
> > +
> > +# Deny prog_load permission
> > +$result =
> > +  system "runcon -t test_bpf_deny_prog_load_t $basedir/bpf_test -p
> > $v 2>&1";
> > +ok($result);
> > +
> > +# Deny prog_run permission
> > +$result =
> > +  system "runcon -t test_bpf_deny_prog_run_t $basedir/bpf_test -p
> > $v 2>&1";
> > +ok($result);
> > +
> > +exit;
> > 

