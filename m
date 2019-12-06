Return-Path: <SRS0=TNfp=Z4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE909C43603
	for <selinux@archiver.kernel.org>; Fri,  6 Dec 2019 13:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD22205F4
	for <selinux@archiver.kernel.org>; Fri,  6 Dec 2019 13:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="nj5gER3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfLFNYL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 6 Dec 2019 08:24:11 -0500
Received: from UHIL19PA38.eemsg.mail.mil ([214.24.21.197]:65177 "EHLO
        UHIL19PA38.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfLFNYK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 6 Dec 2019 08:24:10 -0500
X-EEMSG-check-017: 54757396|UHIL19PA38_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,284,1571702400"; 
   d="scan'208";a="54757396"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UHIL19PA38.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Dec 2019 13:24:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1575638648; x=1607174648;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=deXOIYLmJo6sZRImbybDlIExDVGqOLs9acoNHtvFLGw=;
  b=nj5gER3QP1GSEjlKrEyeEilaRG3+67QtssMjHhQxMQVSYNs5BPRB+dZ4
   739CfAPj+F8ajni6Wz7b3pcNEXv1kUoOMubdTPprCrbgkTuK2qqdfOKZM
   ELit/eqdkv1z1NIThSoDByFQWCtiJzmyyYfXLbYypSpltrO+6zhG8nD9w
   x/7wgO5fWC5h7MeMzNlv0sVEmSz5SQUrNAsxonowRkD3A7GyYoMT6K6dF
   +XrSWbhTTBzihMn1oOCI6VDaUD6oFldWdYY8SEthxAnRE7vHnXqG+VQ6m
   ZGN+T6wotZ7k1jE71e1tYBSgbLZzSq1oDc6/mZmxix0eYdGuGki4PeWoD
   w==;
X-IronPort-AV: E=Sophos;i="5.69,284,1571702400"; 
   d="scan'208";a="30833869"
IronPort-PHdr: =?us-ascii?q?9a23=3AuW3UyBJj7BZM0dTvjdmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgfLvzxwZ3uMQTl6Ol3ixeRBMOHsqkC0rqN+P24EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCezbL9oMRm7rgvcusYWjId+N6081g?=
 =?us-ascii?q?bHrnxUdupM2GhmP0iTnxHy5sex+J5s7SFdsO8/+sBDTKv3Yb02QaRXAzo6PW?=
 =?us-ascii?q?814tbrtQTYQguU+nQcSGQWnQFWDAXD8Rr3Q43+sir+tup6xSmaIcj7Rq06VD?=
 =?us-ascii?q?i+86tmTgLjhTwZPDAl7m7Yls1wjLpaoB2/oRx/35XUa5yROPZnY6/RYc8WSW?=
 =?us-ascii?q?9HU8lfTSxBBp63YZUJAeQPIO1Uq5DxqlUKoBe7AwSnGeHhxSJShnLuwKM0ze?=
 =?us-ascii?q?ohHwHF0gIuEd0Bv3bbo8n6OqoJTeC4zrPFwSnfY/5Y2zrw7pXDfBA7ofGLWL?=
 =?us-ascii?q?J9adffyVUxGAPdjlWft4rlNC6I2OQIqWeb6+5gWvyvimU6rAxxuSWgxtw3h4?=
 =?us-ascii?q?nVhoMa1lDE9SJjzIYzPt23UlR3YdGjEJtOriyXMZZ9TMA6Q2xwpSo3xbILtY?=
 =?us-ascii?q?S7cSQX0pgr2RHSZ+Kdf4SV5B/oSfyfLi1ihH1/fbKynxOy8U+9xeLiTsS0y1?=
 =?us-ascii?q?NKrjZdktnLq3ANywTf6siZRft5+UeswSqP2BrJ6uFFPEA0jrDXK58nwr4+kZ?=
 =?us-ascii?q?oTqlrMETPslEXqjK6ZakUk+u+y5+ThfrrmvYOTO5VxigH/NqQigs2/AeImPQ?=
 =?us-ascii?q?gSR2WX5Oux2bL58UD5XblGlOM6n6bHvJzAOMgXvqu5DBVU0oYn5Ra/FTCm0N?=
 =?us-ascii?q?EAkHkcMV1FYwmKj5TpOl7SIPD4Cu2zg1K3kDhx3fzGMbrhAovVInjZjLjhZa?=
 =?us-ascii?q?p961JbyAcr19Bf5o5bCrEbL/LpR0D+rMDXAQc5MwOuwubnDsty1pgFVG2UHq?=
 =?us-ascii?q?+ZMaXSsUOW6eI1JemDepMVtCzhJPgi4v7klWU5lkMFfam1wZsXb2i1Hu94LE?=
 =?us-ascii?q?WdYHrshMoBEGgRswogQ+zllkeCXSRQZ3msRaI84C80CIa8AYfEXICtj+/J4C?=
 =?us-ascii?q?DuJJxdZmlcBhisGHbuep7MD+0NYyKbOMNWmQsEXLmnRpQJ3w2vshP30bxqMq?=
 =?us-ascii?q?zf/ShO8dr42dx04fDDvQ89+CYyDMmH1WyJCWZukTAmXTgziZtjrFR9x1HL6q?=
 =?us-ascii?q?1xh/hVBJQH/P9SehsrPp7biephApb9XRyXLYTBc0qvXtjzWWJ5ddk22dJbJh?=
 =?us-ascii?q?8mStg=3D?=
X-IPAS-Result: =?us-ascii?q?A2BIAABmVepd/wHyM5BkGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF+gXSBbSASKoQriQOGZQaBN4lpiiCHJAkBAQEBAQEBAQE3AQGEQ?=
 =?us-ascii?q?AKCOTgTAhABAQEEAQEBAQEFAwEBbIVDgjspAYJuAQUjBBFRCxgCAiYCAlcGA?=
 =?us-ascii?q?QwGAgEBgl8/gkcDCSWtJX8zhU+DPoFIgQ4ojDF5gQeBOA+CXT6BDoENghiDJ?=
 =?us-ascii?q?oJeBJZxRpcTgjiCOZMbBhuCQYwtizgtjh2cNCKBWCsIAhgIIQ+DJ1ARFIxyF?=
 =?us-ascii?q?45BIwMwkWgBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 06 Dec 2019 13:24:07 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xB6DNrLK102244;
        Fri, 6 Dec 2019 08:23:53 -0500
Subject: Re: [PATCH V2] selinux_testsuite: Add socketpair test
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
References: <20191204164322.27083-1-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <ec375e4d-d60a-3dbb-f653-918d067820a8@tycho.nsa.gov>
Date:   Fri, 6 Dec 2019 08:24:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191204164322.27083-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/4/19 11:43 AM, Richard Haines wrote:
> Test SO_PEERSEC for sockets created by socketpair(2) added in kernel 4.18
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Thanks, applied.

> ---
> V2 Changes:
> In run_parent replace sizeof(peerlabel) with strlen(peerlabel)) and set
> peerlabel[0] = 0;
> Build socketpair unconditionally and check whether to run in test script.
>   
>   policy/test_unix_socket.te     |   7 ++
>   tests/unix_socket/.gitignore   |   1 +
>   tests/unix_socket/Makefile     |   2 +-
>   tests/unix_socket/socketpair.c | 191 +++++++++++++++++++++++++++++++++
>   tests/unix_socket/test         |  32 +++++-
>   5 files changed, 229 insertions(+), 4 deletions(-)
>   create mode 100644 tests/unix_socket/socketpair.c
> 
> diff --git a/policy/test_unix_socket.te b/policy/test_unix_socket.te
> index 7dd3362..0ff790a 100644
> --- a/policy/test_unix_socket.te
> +++ b/policy/test_unix_socket.te
> @@ -60,6 +60,13 @@ allow test_unix_dgram_client_t test_unix_server_t:unix_dgram_socket sendto;
>   allow test_unix_server_t test_unix_client_sockfile_t:sock_file write;
>   allow test_unix_server_t test_unix_dgram_client_t:unix_dgram_socket sendto;
>   
> +# Domain for socketpair(2) process.
> +type test_socketpair_t;
> +domain_type(test_socketpair_t)
> +unconfined_runs_test(test_socketpair_t)
> +typeattribute test_socketpair_t testdomain;
> +typeattribute test_socketpair_t unixsocketdomain;
> +
>   # Allow all of these domains to be entered from the sysadm domain.
>   miscfiles_domain_entry_test_files(unixsocketdomain)
>   userdom_sysadm_entry_spec_domtrans_to(unixsocketdomain)
> diff --git a/tests/unix_socket/.gitignore b/tests/unix_socket/.gitignore
> index f2ad853..05ed268 100644
> --- a/tests/unix_socket/.gitignore
> +++ b/tests/unix_socket/.gitignore
> @@ -1,2 +1,3 @@
>   client
>   server
> +socketpair
> diff --git a/tests/unix_socket/Makefile b/tests/unix_socket/Makefile
> index 5266096..51ba2c6 100644
> --- a/tests/unix_socket/Makefile
> +++ b/tests/unix_socket/Makefile
> @@ -1,4 +1,4 @@
> -TARGETS=client server
> +TARGETS=client server socketpair
>   
>   LDLIBS+= -lselinux
>   
> diff --git a/tests/unix_socket/socketpair.c b/tests/unix_socket/socketpair.c
> new file mode 100644
> index 0000000..d547d10
> --- /dev/null
> +++ b/tests/unix_socket/socketpair.c
> @@ -0,0 +1,191 @@
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <stddef.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <errno.h>
> +#include <sys/types.h>
> +#include <sys/socket.h>
> +#include <selinux/selinux.h>
> +
> +#ifndef SO_PEERSEC
> +#define SO_PEERSEC 31
> +#endif
> +
> +#ifndef SCM_SECURITY
> +#define SCM_SECURITY 0x03
> +#endif
> +
> +void print_usage(char *progname)
> +{
> +	fprintf(stderr,
> +		"usage:  %s stream|dgram\n"
> +		"Where:\n\t"
> +		"stream     Use TCP protocol or:\n\t"
> +		"dgram      use UDP protocol.\n", progname);
> +	exit(-1);
> +}
> +
> +int run_parent(int sock, int type)
> +{
> +	int result, on = 1;
> +	char byte, peerlabel[256];
> +	socklen_t labellen = sizeof(peerlabel);
> +
> +	result = setsockopt(sock, SOL_SOCKET, SO_PASSSEC, &on, sizeof(on));
> +	if (result < 0) {
> +		perror("setsockopt: SO_PASSSEC");
> +		goto err;
> +	}
> +
> +	if (type == SOCK_STREAM) {
> +		result = read(sock, &byte, 1);
> +		if (result < 0) {
> +			perror("read");
> +			goto err;
> +		}
> +
> +		peerlabel[0] = 0;
> +		result = getsockopt(sock, SOL_SOCKET, SO_PEERSEC, peerlabel,
> +				    &labellen);
> +		if (result < 0) {
> +			perror("getsockopt: SO_PEERSEC");
> +			goto err;
> +		}
> +		printf("Parent got peer label=%s\n", peerlabel);
> +
> +		result = write(sock, peerlabel, strlen(peerlabel));
> +		if (result < 0) {
> +			perror("write");
> +			goto err;
> +		}
> +	} else {
> +		struct iovec iov;
> +		struct msghdr msg;
> +		struct cmsghdr *cmsg;
> +		char msglabel[256];
> +		union {
> +			struct cmsghdr cmsghdr;
> +			char buf[CMSG_SPACE(sizeof(msglabel))];
> +		} control;
> +
> +		memset(&iov, 0, sizeof(iov));
> +		iov.iov_base = &byte;
> +		iov.iov_len = 1;
> +		memset(&msg, 0, sizeof(msg));
> +		msg.msg_iov = &iov;
> +		msg.msg_iovlen = 1;
> +		msg.msg_control = &control;
> +		msg.msg_controllen = sizeof(control);
> +		result = recvmsg(sock, &msg, 0);
> +		if (result < 0) {
> +			perror("recvmsg");
> +			goto err;
> +		}
> +
> +		for (cmsg = CMSG_FIRSTHDR(&msg); cmsg;
> +		     cmsg = CMSG_NXTHDR(&msg, cmsg)) {
> +			;
> +			if (cmsg->cmsg_level == SOL_SOCKET &&
> +			    cmsg->cmsg_type == SCM_SECURITY) {
> +				size_t len = cmsg->cmsg_len - CMSG_LEN(0);
> +
> +				if (len > 0 && len < sizeof(msglabel)) {
> +					memcpy(msglabel, CMSG_DATA(cmsg), len);
> +					msglabel[len] = 0;
> +					printf("Parent got SCM_SECURITY=%s\n",
> +					       msglabel);
> +				}
> +			}
> +		}
> +
> +		result = sendto(sock, msglabel, strlen(msglabel), 0,
> +				msg.msg_name, msg.msg_namelen);
> +		if (result < 0) {
> +			perror("sendto");
> +			goto err;
> +		}
> +	}
> +
> +	result = 0;
> +err:
> +	close(sock);
> +	return result;
> +}
> +
> +int run_child(int sock)
> +{
> +	int result;
> +	char byte = 0, label[256], *mycon;
> +
> +	result = write(sock, &byte, 1);
> +	if (result < 0) {
> +		perror("write");
> +		goto err;
> +	}
> +
> +	result = read(sock, label, sizeof(label));
> +	if (result < 0) {
> +		perror("read");
> +		goto err;
> +	}
> +	label[result] = 0;
> +
> +	result = getcon(&mycon);
> +	if (result < 0) {
> +		perror("getcon");
> +		goto err1;
> +	}
> +
> +	if (strcmp(mycon, label)) {
> +		fprintf(stderr, "Child expected %s, got %s\n", mycon, label);
> +		result = -1;
> +		goto err1;
> +	}
> +
> +	result = 0;
> +err1:
> +	free(mycon);
> +err:
> +	close(sock);
> +	return result;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int type, result, sockets[2];
> +
> +	if (argc != 2)
> +		print_usage(argv[0]);
> +
> +	if (!strcmp(argv[1], "stream"))
> +		type = SOCK_STREAM;
> +	else if (!strcmp(argv[1], "dgram"))
> +		type = SOCK_DGRAM;
> +	else
> +		print_usage(argv[0]);
> +
> +	result = socketpair(AF_UNIX, type, 0, sockets);
> +	if (result < 0) {
> +		perror("socketpair");
> +		return -1;
> +	}
> +
> +	result = fork();
> +	if (result < 0) {
> +		perror("fork");
> +		close(sockets[0]);
> +		close(sockets[1]);
> +		return -1;
> +	} else if (result > 0) {
> +		close(sockets[0]);
> +		result = run_parent(sockets[1], type);
> +		return result;
> +
> +	} else {
> +		close(sockets[1]);
> +		result = run_child(sockets[0]);
> +		return result;
> +	}
> +}
> diff --git a/tests/unix_socket/test b/tests/unix_socket/test
> index f5f03e8..c48d1ad 100755
> --- a/tests/unix_socket/test
> +++ b/tests/unix_socket/test
> @@ -1,10 +1,27 @@
>   #!/usr/bin/perl
>   
>   use Test;
> -BEGIN { plan tests => 8 }
>   
> -$basedir = $0;
> -$basedir =~ s|(.*)/[^/]*|$1|;
> +BEGIN {
> +    $basedir = $0;
> +    $basedir =~ s|(.*)/[^/]*|$1|;
> +
> +    $test_count = 8;
> +    $socketpair = 0;
> +
> +    $kvercur = `uname -r`;
> +    chomp($kvercur);
> +
> +    # Test SO_PEERSEC for sockets created by socketpair(2).
> +    $kverminstream = "4.18";
> +    $result        = `$basedir/../kvercmp $kvercur $kverminstream`;
> +    if ( $result >= 0 ) {
> +        $test_count += 2;
> +        $socketpair = 1;
> +    }
> +
> +    plan tests => $test_count;
> +}
>   
>   #
>   # Tests for sockets in the abstract namespace.
> @@ -106,4 +123,13 @@ server_end($pid);
>   # Clean up.
>   system "rm -f $basedir/test_client_sock $basedir/test_server_sock";
>   
> +if ($socketpair) {
> +    #### Test SO_PEERSEC for sockets created by socketpair(2) #####
> +    $result = system "runcon -t test_socketpair_t $basedir/socketpair stream";
> +    ok( $result, 0 );
> +
> +    $result = system "runcon -t test_socketpair_t $basedir/socketpair dgram";
> +    ok( $result, 0 );
> +}
> +
>   exit;
> 

