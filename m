Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5D7c1IN006188
 for <selinux@tycho.nsa.gov>; Tue, 13 Jun 2017 03:38:01 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id 9E8181A0C0
 for <selinux@tycho.nsa.gov>; Tue, 13 Jun 2017 09:37:42 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 530X6qryVUOI for <selinux@tycho.nsa.gov>;
 Tue, 13 Jun 2017 09:37:40 +0200 (CEST)
Received: from [IPv6:2a02:a03f:3c40:e900:e51f:1cf3:5207:af65] (unknown
 [IPv6:2a02:a03f:3c40:e900:e51f:1cf3:5207:af65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id E3BB11A074
 for <selinux@tycho.nsa.gov>; Tue, 13 Jun 2017 09:37:39 +0200 (CEST)
To: selinux <selinux@tycho.nsa.gov>
From: Laurent Bigonville <bigon@debian.org>
Subject: SO_PEERSEC on socket connected to the same process
Message-ID: <7f094e66-6131-f126-9e23-771d1520904f@debian.org>
Date: Tue, 13 Jun 2017 09:37:39 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------7CD698E49C16D2B64AC1D251"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------7CD698E49C16D2B64AC1D251
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Currently the dbus-daemon is not returning anything when asked about its 
own security context (using GetConnectionSELinuxSecurityContext or 
GetConnectionCredentials methods). This cause some issues[0] with 
systemd now that it's enforcing the policy for user sessions again.

I already made a patch that has been merged[1][2] upstream in the 
GetConnectionSELinuxSecurityContext case and it now returns the SELinux 
context of the dbus-daemon process itself.

For the GetConnectionCredentials case, upstream wanted a generic way of 
getting the security label and went the way of using SO_PEERSEC on a 
socket connected to itself.

But for some reasons it's always returning unlabeled_t. Note that the 
same value is returned by the getpeercon() function as well.

I've made a small test case (see attached file) and tested it on both 
debian and RHEL7.

Is this somehow expected? Is this a bug?

Cheers,

Laurent Bigonville

[0]https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=864221
[1]https://bugs.freedesktop.org/show_bug.cgi?id=101315
[2] https://phabricator.freedesktop.org/rDBUSdcf02f80656d

--------------7CD698E49C16D2B64AC1D251
Content-Type: text/x-csrc;
 name="so_peersec.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="so_peersec.c"

#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>
#include <stdio.h>
#include <selinux/selinux.h>

int main(void) {

	int socks[2];
	char buf[1024] = "";
	int len = sizeof(buf);
	char *context = NULL;

	if (getcon_raw(&context) < 0)
		perror("getcon_raw");
	printf("getcon: %s\n", context);
	freecon(context);

	if (socketpair (AF_UNIX, SOCK_STREAM, 0, socks) < 0)
		perror("socketpair");

	if (getsockopt (socks[0], SOL_SOCKET, SO_PEERSEC, &buf, &len) < 0)
		perror("getsockopt 1");
	printf("socket 1: %s\n", buf);

	len = sizeof(buf);

	if (getsockopt (socks[1], SOL_SOCKET, SO_PEERSEC, &buf, &len) < 0)
		perror("getsockopt 2");
	printf("socket 2: %s\n", buf);

	if (getpeercon_raw(socks[0], &context) < 0)
		perror("getpeercon_raw 1");
	printf("getpeercon 1: %s\n", context);
	freecon(context);

	if (getpeercon_raw(socks[1], &context) < 0)
		perror("getpeercon_raw 2");
	printf("getpeercon 2: %s\n", context);
	freecon(context);

	close(socks[0]);
	close(socks[1]);


	return 0;
}

--------------7CD698E49C16D2B64AC1D251--
