Return-Path: <SRS0=HWnL=XN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8794DC4CEC4
	for <selinux@archiver.kernel.org>; Wed, 18 Sep 2019 15:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B3E21907
	for <selinux@archiver.kernel.org>; Wed, 18 Sep 2019 15:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="fpRLjQte"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbfIRPNH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Sep 2019 11:13:07 -0400
Received: from UCOL19PA37.eemsg.mail.mil ([214.24.24.197]:55742 "EHLO
        UCOL19PA37.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfIRPNH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Sep 2019 11:13:07 -0400
X-EEMSG-check-017: 24094303|UCOL19PA37_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,521,1559520000"; 
   d="scan'208";a="24094303"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA37.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Sep 2019 15:12:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568819578; x=1600355578;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=hZTcc/RMBTNJylyxVdSzuekrUPTSoMbPeZRDsstvFSg=;
  b=fpRLjQtebAbgsTef+OvEZEgCPDcjGFuVQKFRJB4vnxPD2OlDyJGJ7T96
   XVtnK/JBBVu3hNm4zyB8v68cW5ipiichkTAzaJVM7m1bkIwNpagxImQjp
   hRnRniIwDO7su3fcMIpQ+5ND6KYiwpH3EH3h8XhFZOiIHZgTezMWUKYR2
   6jpdsolXLkt04RQsPRMMG/hlUQY0DUm4kx4mzcmoFDXspiBtQFjsWSXWh
   uyXa+jrMx9CbmqB1Yzsc2stBUW7kEzYz6AIG3CWU1i4t9L/8MMxx/eqfQ
   pB/rFzkH4hmUAbLw56MXQaBlLCjubW0p4gLgfeezCeL5egM1iKFUuI2/x
   w==;
X-IronPort-AV: E=Sophos;i="5.64,521,1559520000"; 
   d="scan'208";a="28051279"
IronPort-PHdr: =?us-ascii?q?9a23=3Axf92rhxb0t96qDvXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0uoVKPad9pjvdHbS+e9qxAeQG9mCsLQd26GG6OigATVGvc/b9ihaMdRlbF?=
 =?us-ascii?q?wssY0uhQsuAcqIWwXQDcXBSGgEJvlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk?=
 =?us-ascii?q?2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+IA+5oAnMuMQam5ZuJ6U+xh?=
 =?us-ascii?q?bKrHZDZuBayX91KV6JkBvw+9m88IR//yhMvv4q6tJNX7j9c6kkV7JTES4oM3?=
 =?us-ascii?q?oy5M3ltBnDSRWA634BWWgIkRRGHhbI4gjiUpj+riX1uOx92DKHPcLtVrA7RS?=
 =?us-ascii?q?6i76ZwRxD2jioMKiM0/3vWisx0i6JbvQ6hqhliyIPafI2ZKPxzdb7GcNgEWW?=
 =?us-ascii?q?ROQNpeVy1ZAoO9cYQPCfYBPf1FpIX5vlcCsAeyCRWpCO7pxDBInHv21rAk3e?=
 =?us-ascii?q?onHw/NwQgsE8sAvXnQqdn4MroZX+Kow6nS1TjNcu1Y2Tn95obLfB4ur/6DUr?=
 =?us-ascii?q?BsfsTe0kQvCwHIg0+MpYD5MT6Y1OIAuHWb4ep6UuKvjnYqpRxtojex3scsip?=
 =?us-ascii?q?fGhoQIwV7Z8CV22oI1JdmmR097fNWpF4BQuDyBN4ZtXsMjQ31nuCY9yrEcv5?=
 =?us-ascii?q?67ZzIFxI4oxx7YdfyKao6F6Q/gWuaJOTp0mX1odb2lixuy7ESs0PPwW8aq3F?=
 =?us-ascii?q?pQsyZIlMTHuGoX2BzJ8MeHT+Nw/kKm2TmSyQ/e8vpEIUUolarDLJ4h36Iwmo?=
 =?us-ascii?q?ITsUvdGi/2n137jLOMeUU+++io9v/nbq/6pp6cK4B0igb+Pr4omsOjGuQ3Lh?=
 =?us-ascii?q?ICX22a+eS4zLHj/Ev5T6tWjvAuj6XUv5/XKd4bq6KkGQNZzIku5wilAzu7yN?=
 =?us-ascii?q?gYmGMILFNBeBKJlYjpPFTOLejjDfiimFShiytrxvDaMb3hBZXBNH7DkKz7cr?=
 =?us-ascii?q?pn5E5czxQzwchF551IErEBPO7zWkjpudzCDx82Lwy0zPz9CNpgzowRRXqAAq?=
 =?us-ascii?q?+DP6PTt1+H+PkvLvKXa48JuTb9LeQl6OD0jX8/h1AdYbOl0ocQaHC9Bv5mOV?=
 =?us-ascii?q?mWYWLwgtcdFmcHphE+Q/LuiF2DVz5TenmzUrki5jE0Fo2mF53PRoOzj7yb2i?=
 =?us-ascii?q?e0AJlWanpBClCWHnfib5+EVOsUaCKOPs9hlSQJVaC7RI880RGjrxf6xKB6Lu?=
 =?us-ascii?q?rQ4yEYsJXj1N9v5+LNjx096Tt0D8HOm12KGlt1lWMBXTN+/Kl+p0FmggOZ0K?=
 =?us-ascii?q?N4iuZUItdk5/pIVAohHZTAzupmBsr0Vx6HddCMHhLuWdiiADcsXvovzNIUJU?=
 =?us-ascii?q?VwAdOvilbExSXuS6ccirijHJUp9ufZ2H/rKoB2zHOV+rMmigwdXsZXNWCgzp?=
 =?us-ascii?q?V6/gzXCp+Bx16VjI62ZK8c22jL727Fwm2Q6hILGDVsWLnICChMLnDdqs70sw?=
 =?us-ascii?q?abFO6j?=
X-IPAS-Result: =?us-ascii?q?A2BFBAAtSIJd/wHyM5BmHAEBAQQBAQcEAQGBZ4FuKoFAM?=
 =?us-ascii?q?iqEIo8PTQEBAQEBAQaBESWJdJEoCQEBAQEBAQEBATQBAgEBhD8CgwMjOBMCD?=
 =?us-ascii?q?AEBAQQBAQEBAQUDAQFshTmCOikBgmYBAQEBAgEjFUYLCxgCAiYCAlcGAQkDB?=
 =?us-ascii?q?gIBAYJfP4FrAwkFD7BVgTKFTIMwgUmBDCiMCRh4gQeBEScMgWF+PoEOgQyCF?=
 =?us-ascii?q?BaDC4JYBIxliRiBMpVOgiyCLpJQBhuCNotwinuOEJsbIYFYKwgCGAghD4MnU?=
 =?us-ascii?q?BAUgVoXjj4kAzCBBgEBj24BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 18 Sep 2019 15:12:57 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8IFCtR5021752;
        Wed, 18 Sep 2019 11:12:55 -0400
Subject: Re: [PATCH V4 2/3] selinux-testsuite: Add BPF support to fdreceive
 test
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org, paul@paul-moore.com
References: <20190917145640.25629-1-richard_c_haines@btinternet.com>
 <20190917145640.25629-3-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <e3a7f75d-10bd-8020-477f-39a99973473d@tycho.nsa.gov>
Date:   Wed, 18 Sep 2019 11:12:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190917145640.25629-3-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/17/19 10:56 AM, Richard Haines wrote:
> Add BPF map & prog functions to test fdreceive security_file_receive path()
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>   policy/Makefile              |  2 +-
>   policy/test_fdreceive_bpf.te | 60 +++++++++++++++++++++++
>   tests/bpf/Makefile           |  7 +++
>   tests/bpf/test               | 55 ++++++++++++++++++++-
>   tests/fdreceive/Makefile     | 14 +++++-
>   tests/fdreceive/client.c     | 93 ++++++++++++++++++++++++++++++++----
>   6 files changed, 218 insertions(+), 13 deletions(-)
>   create mode 100644 policy/test_fdreceive_bpf.te
> 
> diff --git a/policy/Makefile b/policy/Makefile
> index 16a4469..4ca5486 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -72,7 +72,7 @@ TARGETS += test_sctp.te
>   endif
>   
>   ifeq ($(shell grep -q bpf $(POLDEV)/include/support/all_perms.spt && echo true),true)
> -TARGETS += test_bpf.te
> +TARGETS += test_bpf.te test_fdreceive_bpf.te
>   endif
>   
>   ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
> diff --git a/policy/test_fdreceive_bpf.te b/policy/test_fdreceive_bpf.te
> new file mode 100644
> index 0000000..961de79
> --- /dev/null
> +++ b/policy/test_fdreceive_bpf.te
> @@ -0,0 +1,60 @@
> +#################################
> +#
> +# Policy for testing BPF file descriptor transfer via socket IPC
> +#
> +
> +attribute fdreceivebpfdomain;
> +
> +# Domain for bpf client process.
> +type test_fdreceive_bpf_client_t;
> +domain_type(test_fdreceive_bpf_client_t)
> +unconfined_runs_test(test_fdreceive_bpf_client_t)
> +typeattribute test_fdreceive_bpf_client_t fdreceivebpfdomain;
> +typeattribute test_fdreceive_bpf_client_t testdomain;
> +allow test_fdreceive_bpf_client_t test_fdreceive_file_t:file { rw_file_perms };
> +allow test_fdreceive_bpf_client_t test_file_t:sock_file { rw_sock_file_perms };
> +allow test_fdreceive_bpf_client_t test_fdreceive_server_t:unix_stream_socket { connectto };
> +allow test_fdreceive_bpf_client_t self:bpf { map_create map_read map_write prog_load prog_run };

Does the client require all of these bpf permissions?

> +allow test_fdreceive_bpf_client_t self:capability { sys_resource };
> +allow test_fdreceive_bpf_client_t self:process { setrlimit };
> +# Server side rules:
> +allow test_fdreceive_server_t test_fdreceive_bpf_client_t:fd { use };
> +allow test_fdreceive_server_t test_fdreceive_bpf_client_t:bpf { map_read map_write };
> +allow test_fdreceive_server_t test_fdreceive_bpf_client_t:bpf { prog_run} ;
> +
> +# Domain for bpf client2 process - Removes BPF prog_run perm from server.
> +# Tests security_file_receive flow.
> +type test_fdreceive_bpf_client2_t;
> +domain_type(test_fdreceive_bpf_client2_t)
> +unconfined_runs_test(test_fdreceive_bpf_client2_t)
> +typeattribute test_fdreceive_bpf_client2_t fdreceivebpfdomain;
> +typeattribute test_fdreceive_bpf_client2_t testdomain;
> +allow test_fdreceive_bpf_client2_t test_fdreceive_file_t:file { rw_file_perms };
> +allow test_fdreceive_bpf_client2_t test_file_t:sock_file { rw_sock_file_perms };
> +allow test_fdreceive_bpf_client2_t test_fdreceive_server_t:unix_stream_socket { connectto };
> +allow test_fdreceive_bpf_client2_t self:bpf { prog_load prog_run };
> +allow test_fdreceive_bpf_client2_t self:capability { sys_resource };
> +allow test_fdreceive_bpf_client2_t self:process { setrlimit };
> +# Server side rules:
> +allow test_fdreceive_server_t test_fdreceive_bpf_client2_t:fd { use };

Seemingly lacks more than just prog_run, e.g. also lacks 
map_read/map_write.  Don't know if it matters but just want to be sure 
it is intentional and that the test will exercise the desired check 
enforcement unambiguously.

> +
> +# Domain for bpf client3 process - Removes BPF map_read perm from server.
> +# Tests security_file_receive flow.
> +type test_fdreceive_bpf_client3_t;
> +domain_type(test_fdreceive_bpf_client3_t)
> +unconfined_runs_test(test_fdreceive_bpf_client3_t)
> +typeattribute test_fdreceive_bpf_client3_t fdreceivebpfdomain;
> +typeattribute test_fdreceive_bpf_client3_t testdomain;
> +allow test_fdreceive_bpf_client3_t test_fdreceive_file_t:file { rw_file_perms };
> +allow test_fdreceive_bpf_client3_t test_file_t:sock_file { rw_sock_file_perms };
> +allow test_fdreceive_bpf_client3_t test_fdreceive_server_t:unix_stream_socket { connectto };
> +allow test_fdreceive_bpf_client3_t self:bpf { map_create map_read map_write };
> +allow test_fdreceive_bpf_client3_t self:capability { sys_resource };
> +allow test_fdreceive_bpf_client3_t self:process { setrlimit };
> +# Server side rules:
> +allow test_fdreceive_server_t test_fdreceive_bpf_client3_t:fd { use };
> +allow test_fdreceive_server_t test_fdreceive_bpf_client3_t:bpf { map_write };

Similarly lacks prog_run in addition to map_read.

> +
> +# Allow all of these domains to be entered from the sysadm domain.
> +miscfiles_domain_entry_test_files(fdreceivebpfdomain)
> +userdom_sysadm_entry_spec_domtrans_to(fdreceivebpfdomain)
> diff --git a/tests/bpf/Makefile b/tests/bpf/Makefile
> index 46817a5..3513179 100644
> --- a/tests/bpf/Makefile
> +++ b/tests/bpf/Makefile
> @@ -2,9 +2,16 @@ TARGETS = bpf_test
>   DEPS = bpf_common.c bpf_common.h
>   LDLIBS += -lselinux -lbpf
>   
> +# export so that BPF_ENABLED entries get built correctly on local build
> +export CFLAGS += -DHAVE_BPF
> +
> +BPF_ENABLED = ../fdreceive
> +
>   all: $(TARGETS)
> +	@set -e; for i in $(BPF_ENABLED); do $(MAKE) -C $$i all ; done
>   
>   clean:
>   	rm -f $(TARGETS)
> +	@set -e; for i in $(BPF_ENABLED); do $(MAKE) -C $$i clean ; done
>   
>   $(TARGETS): $(DEPS)
> diff --git a/tests/bpf/test b/tests/bpf/test
> index ee00a19..36f1f32 100755
> --- a/tests/bpf/test
> +++ b/tests/bpf/test
> @@ -4,8 +4,10 @@ use Test::More;
>   BEGIN {
>       $basedir = $0;
>       $basedir =~ s|(.*)/[^/]*|$1|;
> +    $fdr_basedir = "$basedir/../fdreceive/";
>   
> -    $test_count = 7;
> +    $test_count     = 7;
> +    $test_fdreceive = 0;
>   
>       # allow info to be shown during tests
>       $v = $ARGV[0];
> @@ -18,6 +20,14 @@ BEGIN {
>           $v = " ";
>       }
>   
> +    # Test if fdreceive is BPF enabled
> +    $result = system("$fdr_basedir/client -t $basedir/test_sock 2>/dev/null");
> +
> +    if ( $result >> 8 eq 0 ) {
> +        $test_fdreceive = 1;
> +        $test_count += 4;
> +    }
> +

Do we need this to be conditional?  Isn't it better to just fail if they 
didn't build correctly?

>       plan tests => $test_count;
>   }
>   
> @@ -61,4 +71,47 @@ $result =
>     system "runcon -t test_bpf_deny_prog_run_t $basedir/bpf_test -p $v 2>&1";
>   ok($result);
>   
> +if ($test_fdreceive) {
> +    #
> +    ################ BPF Tests for fdreceive #######################
> +    #
> +    # Remove any leftover test file from prior failed runs.
> +    system("rm -rf $basedir/test_sock");
> +
> +    # Start server process in test_fdreceive_server_t.
> +    system("mkfifo $basedir/flag");
> +    if ( ( $pid = fork() ) == 0 ) {
> +        exec
> +"runcon -t test_fdreceive_server_t $fdr_basedir/server $basedir/flag $basedir/test_sock";
> +    }
> +
> +    # Wait for it to initialize.
> +    system("read -t 5 <>$basedir/flag");
> +
> +    # Test BPF map & prog fd on transfer:
> +    $result = system
> +"runcon -t test_fdreceive_bpf_client_t -- $fdr_basedir/client -m $basedir/test_sock";
> +    ok( $result eq 0 );
> +
> +    $result = system
> +"runcon -t test_fdreceive_bpf_client_t -- $fdr_basedir/client -p $basedir/test_sock";
> +    ok( $result eq 0 );
> +
> +    # Remove BPF prog_run permission from server:
> +    $result = system
> +"runcon -t test_fdreceive_bpf_client2_t -- $fdr_basedir/client -p $basedir/test_sock";
> +    ok($result);
> +
> +    # Remove BPF map_read permission from server:
> +    $result = system
> +"runcon -t test_fdreceive_bpf_client3_t -- $fdr_basedir/client -m $basedir/test_sock";
> +    ok($result);
> +
> +    # Kill the server.
> +    kill KILL, $pid;
> +
> +    # Clean up.
> +    system "rm -rf $basedir/test_sock $basedir/flag";
> +}
> +
>   exit;
> diff --git a/tests/fdreceive/Makefile b/tests/fdreceive/Makefile
> index bc33f1b..895f91c 100644
> --- a/tests/fdreceive/Makefile
> +++ b/tests/fdreceive/Makefile
> @@ -1,3 +1,13 @@
> -all: client server
> +TARGETS = client server
> +
> +ifneq (,$(findstring -DHAVE_BPF,$(CFLAGS)))
> +	DEPS = ../bpf/bpf_common.c ../bpf/bpf_common.h
> +	LDLIBS += -lbpf
> +endif
> +
> +all: $(TARGETS)
> +
>   clean:
> -	rm -f client server
> +	rm -f $(TARGETS)
> +
> +client: $(DEPS)
> diff --git a/tests/fdreceive/client.c b/tests/fdreceive/client.c
> index de40bc7..770cc99 100644
> --- a/tests/fdreceive/client.c
> +++ b/tests/fdreceive/client.c
> @@ -8,11 +8,29 @@
>   #include <stdio.h>
>   #include <stdlib.h>
>   
> +#if HAVE_BPF
> +#include "../bpf/bpf_common.h"
> +#endif
> +
> +static void usage(char *progname)
> +{
> +	fprintf(stderr,
> +		"usage:  %s [-m|-p|t] [file] addr\n"
> +		"\nWhere:\n\t"
> +		"-m    Create BPF map fd\n\t"
> +		"-p    Create BPF prog fd\n\t"
> +		"-t    Test if BPF enabled\n\t"
> +		"   If -m or -p not supplied, create a file fd using:\n\t"
> +		"file  Test file fd sent to server\n\t"
> +		"addr  Servers address\n", progname);
> +	exit(-1);
> +}
> +
>   int main(int argc, char **argv)
>   {
>   	struct sockaddr_un sun;
> -	char buf[1024];
> -	int s, sunlen, ret, buflen;
> +	char buf[1024], *addr = NULL;
> +	int opt, s, sunlen, ret, buflen;
>   	struct msghdr msg = { 0 };
>   	struct iovec iov;
>   	struct cmsghdr *cmsg;
> @@ -20,15 +38,71 @@ int main(int argc, char **argv)
>   	char cmsgbuf[CMSG_SPACE(sizeof myfd)];
>   	int *fdptr;
>   
> -	if (argc != 3) {
> -		fprintf(stderr, "usage:  %s testfile address\n", argv[0]);
> -		exit(-1);
> +	enum {
> +		FILE_FD,
> +		MAP_FD,
> +		PROG_FD,
> +		BPF_TEST
> +	} client_fd_type;
> +
> +	client_fd_type = FILE_FD;
> +
> +	while ((opt = getopt(argc, argv, "mpt")) != -1) {
> +		switch (opt) {
> +		case 'm':
> +			client_fd_type = MAP_FD;
> +			break;
> +		case 'p':
> +			client_fd_type = PROG_FD;
> +			break;
> +		case 't':
> +			client_fd_type = BPF_TEST;
> +			break;
> +		}
>   	}
>   
> -	myfd = open(argv[1], O_RDWR);
> -	if (myfd < 0) {
> -		perror(argv[1]);
> +	if ((client_fd_type == FILE_FD && (argc - optind) != 2) ||
> +	    (client_fd_type > FILE_FD && (argc - optind) != 1))
> +		usage(argv[0]);
> +
> +	switch (client_fd_type) {
> +	case FILE_FD:
> +		myfd = open(argv[optind], O_RDWR);
> +		if (myfd < 0) {
> +			perror(argv[optind]);
> +			exit(-1);
> +		}
> +
> +		addr = argv[optind + 1];
> +		printf("client: Using a file fd\n");
> +		break;
> +#if HAVE_BPF
> +	case MAP_FD:
> +		/* If BPF enabled, then need to set limits */
> +		bpf_setrlimit();
> +		addr = argv[optind];
> +		myfd = create_bpf_map();
> +		printf("client: Using a BPF map fd\n");
> +		break;
> +	case PROG_FD:
> +		bpf_setrlimit();
> +		addr = argv[optind];
> +		myfd = create_bpf_prog();
> +		printf("client: Using a BPF prog fd\n");
> +		break;
> +	case BPF_TEST:
> +		exit(0);
> +		break;
> +#else
> +	case MAP_FD:
> +	case PROG_FD:
> +	case BPF_TEST:
> +		fprintf(stderr, "BPF not supported by Client\n");
>   		exit(-1);
> +		break;
> +#endif
> +	default:
> +		usage(argv[0]);
>   	}
>   
>   	s = socket(AF_UNIX, SOCK_STREAM, 0);
> @@ -38,7 +112,8 @@ int main(int argc, char **argv)
>   	}
>   
>   	sun.sun_family = AF_UNIX;
> -	strcpy(sun.sun_path, argv[2]);
> +	strcpy(sun.sun_path, addr);
> +
>   	sunlen = strlen(sun.sun_path) + 1 + sizeof(short);
>   	ret = connect(s, (struct sockaddr *)&sun, sunlen);
>   	if (ret < 0) {
> 

