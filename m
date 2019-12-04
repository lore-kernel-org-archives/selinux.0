Return-Path: <SRS0=lyW+=Z2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A261C43603
	for <selinux@archiver.kernel.org>; Wed,  4 Dec 2019 21:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FED5206DB
	for <selinux@archiver.kernel.org>; Wed,  4 Dec 2019 21:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="YJE1JOTB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfLDVGI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Dec 2019 16:06:08 -0500
Received: from UHIL19PA37.eemsg.mail.mil ([214.24.21.196]:50188 "EHLO
        UHIL19PA37.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbfLDVGH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Dec 2019 16:06:07 -0500
X-EEMSG-check-017: 54227058|UHIL19PA37_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,278,1571702400"; 
   d="scan'208";a="54227058"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA37.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Dec 2019 21:06:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1575493566; x=1607029566;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=3pVTVMsjTwAMulC0NqXj1BPn2liqKsgHz9qR2v6oPQw=;
  b=YJE1JOTB9mIUkBdxFk9R7McGvQCD6hu2wJDh8NilzORQ92iRRbthRwed
   QXkW2Ik9piZdY7N47ALph7y1dBoFSVmd0IChIMqfAFEfwLM7tpgWTJwLT
   XUwtmCj8yFAv0vpHVAdxqTt+Ln/l+Kk0Awg4DPqj1FQd5eI5srKHwLMtN
   QQTRe3x7CJu8NVjz0pyIc5pfHqQWaJiagCNA3uB44jx7bNd5+FDC4y+su
   kMHLlgN09NkKQ0Ss8vTG/+sexlrNLJ5F8k6AqMq6FY+TfDsAINNJitHrV
   EDCR9YpoPP9DJ89eZwODfVM2zEZ8AZsiKquxjAQA8hCkYlwJihoTkx2ff
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,278,1571702400"; 
   d="scan'208";a="36348433"
IronPort-PHdr: =?us-ascii?q?9a23=3ANxWXohzi72PO3y7XCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2u4VIJqq85mqBkHD//Il1AaPAdyArasb2qGP7/mocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalvIBi0qQjdudQajIR/Jq0s1h?=
 =?us-ascii?q?bHv3xEdvhMy2h1P1yThRH85smx/J5n7Stdvu8q+tBDX6vnYak2VKRUAzs6PW?=
 =?us-ascii?q?874s3rrgTDQhCU5nQASGUWkwFHDBbD4RrnQ5r+qCr6tu562CmHIc37SK0/VD?=
 =?us-ascii?q?q+46t3ThLjlTwKPCAl/m7JlsNwjbpboBO/qBx5347Ue5yeOP5ncq/AYd8WWW?=
 =?us-ascii?q?9NU8BfWCxbBoO3cpUBAewPM+1Fq4XxvlUDoB+7CQSqGejhyCJHhmXu0KMnze?=
 =?us-ascii?q?ohHwHI0g8uEd0Av3vbrsn6OqgJXOCpzqTF1ynPY+9Y1Dr/7oXDbxAvoeuLXb?=
 =?us-ascii?q?J1acff1FUvGB3djlWQt4PlOS6e2PkIs2eB6+pgUfygim46oAx2uTig29wsh5?=
 =?us-ascii?q?LVhoMV1l/E9SJ5zJwzJd2jUkF3e9GkEJxOtyyDMYZ9X8AsQ3lwtSonxbALto?=
 =?us-ascii?q?S3cSgXxJg92RLSZOKLf5KV7h/lSe2fOy13hGh/d7K6nxuy9E+gxfDiWcSsy1?=
 =?us-ascii?q?ZKqzZFksHLtnAQyxzf8siHReV5/kemwTuPyxrc6vtFIUApjqrXMZ8hwrg+lp?=
 =?us-ascii?q?oUqkTMADP5lF/qjK6Wakok+u+o5/7hYrr6vZ+TK5V4igT/MqQqgsC/AOI4PR?=
 =?us-ascii?q?YSX2WD5Oix27Lu8Vf5TblXlPE6jKbUvI7AKcgGvqK5BhVa0ocn6xaxFTem19?=
 =?us-ascii?q?EYkGEcLF1YYxKKlJTpOlHSL/D4CvezmVKskCxxyPzcMb3hBYvNImDZkLj9Zb?=
 =?us-ascii?q?Z991JcyA0rwNBF5pJbFrEBL+jpWkDsrNPXEgc2MwyuzObmDtVyyJgeVHmUDa?=
 =?us-ascii?q?+FMaPSt0OI6fw1I+mKeoAVpCzxJOQi5/7rlXU5g0MSfbG13ZsLb3C1Bu9mLF?=
 =?us-ascii?q?udYXrthNcBDGgLsxEgTOzlllKCSyRfZ3WsUKIm4DE0FoamAZ3ERoC3j7zSlB?=
 =?us-ascii?q?u8S6dXbWBPEFzEMX7pcYifE6MWaSmSK9VtpTczVbGgTYI6/RuytQnmxqBhI/?=
 =?us-ascii?q?aS8Sod49arz9Vx5uvOhTks+jFuSceQyWeASydzhGxbaSUx2fVEvUFlylqFmZ?=
 =?us-ascii?q?N9ivhcGM0bs+hFSS8mJJXcyKp8ENm0VQXfKITaAG26S8mrVGliBuk6xMUDNg?=
 =?us-ascii?q?MkQISv?=
X-IPAS-Result: =?us-ascii?q?A2BdAABQH+hd/wHyM5BkGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF+gXSBbSASKoQriQOGYQaBEiWJaYoghyQJAQEBAQEBAQEBNwEBh?=
 =?us-ascii?q?EACgjQ4EwIQAQEBBAEBAQEBBQMBAWyFQ4I7KQGCbgEFIwQRUQsYAgImAgJXB?=
 =?us-ascii?q?gEMBgIBAYJfP4JHAwklsRJ/M4VPgy+BSIEOKIwxeYEHgTgMA4JdPoEOgQ2CG?=
 =?us-ascii?q?IMmgl4ElnFGlxOCOII5kxsGG4JBjC2LOC2OHZw0IoFYKwgCGAghD4MnUBEUj?=
 =?us-ascii?q?HIXjkEjAzCRaAEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 04 Dec 2019 21:05:56 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xB4L5kJA244858;
        Wed, 4 Dec 2019 16:05:47 -0500
Subject: Re: [PATCH V2] selinux_testsuite: Add socketpair test
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org
References: <20191204164322.27083-1-richard_c_haines@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8f208f1a-c06c-1676-0afe-8dd69100c89e@tycho.nsa.gov>
Date:   Wed, 4 Dec 2019 16:06:06 -0500
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

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

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

