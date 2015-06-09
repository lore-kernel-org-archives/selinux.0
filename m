Message-ID: <55770CB0.9020500@tycho.nsa.gov>
Date: Tue, 09 Jun 2015 11:56:32 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH] net/unix: support SCM_SECURITY for stream sockets
References: <1433864854-21660-1-git-send-email-sds@tycho.nsa.gov>
In-Reply-To: <1433864854-21660-1-git-send-email-sds@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="------------050402050706020600050806"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------050402050706020600050806
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 06/09/2015 11:47 AM, Stephen Smalley wrote:
> SCM_SECURITY was originally only implemented for datagram sockets,
> not for stream sockets.  However, SCM_CREDENTIALS is supported on
> Unix stream sockets.  For consistency, implement Unix stream support
> for SCM_SECURITY as well.  Also clean up the existing code and get
> rid of the superfluous UNIXSID macro.
> 
> Motivated by https://bugzilla.redhat.com/show_bug.cgi?id=1224211,
> where systemd was using SCM_CREDENTIALS and assumed wrongly that
> SCM_SECURITY was also supported on Unix stream sockets.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
> 
> This is an RFC for security folks before I send this along to netdev.
> The patch is relative to net-next, not security-next.
> 
>  include/net/af_unix.h |  1 -
>  net/unix/af_unix.c    | 20 ++++++++++++++++----
>  2 files changed, 16 insertions(+), 5 deletions(-)

Sample test programs attached.

Before:
$ ./server-stream sock1 &
$ ./client-stream sock1
./client-stream: sent   100 bytes
./server-stream: Got SCM_CREDENTIALS=(pid 22067, uid 1000, gid 1000)
./server-stream: Got SCM_SECURITY=system_u:object_r:unlabeled_t:s0

After:
./client-stream: sent   100 bytes
./server-stream: Got SCM_CREDENTIALS=(pid 25490, uid 1000, gid 1000)
./server-stream: Got
SCM_SECURITY=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023



--------------050402050706020600050806
Content-Type: text/plain; charset=UTF-8;
 name="server-stream.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="server-stream.c"

#define _GNU_SOURCE
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <stdio.h>

#ifndef SCM_SECURITY
#define SCM_SECURITY 0x03
#endif

static const int on = 1;

int
main(int argc, char **argv)
{
	char buff[65536];
	int sock, newsock;
	int result;
	int sunlen;
	struct sockaddr_un sun, remote_sun;
	socklen_t rsize = sizeof (remote_sun);
	struct iovec iov;
	struct msghdr msg;
	struct cmsghdr *cmsg;
	char label[256];
	union {
		struct cmsghdr cmsghdr;
		char buf[CMSG_SPACE(sizeof(struct ucred)) +
			 CMSG_SPACE(sizeof label)];
	} control;

	if (argc != 2) {
		fprintf(stderr, "usage:  %s socket-name\n", argv[0]);
		exit(1);
	}

	if ((sock = socket(AF_UNIX, SOCK_STREAM, 0)) < 0) {
		perror("socket");
		return -1;
	}

	if ((result = setsockopt(sock, SOL_SOCKET, SO_PASSSEC,
				 &on, sizeof (on)))) {
		perror("setsockopt: ");
		close(sock);
		return -1;
	}

	if ((result = setsockopt(sock, SOL_SOCKET, SO_PASSCRED,
				 &on, sizeof (on)))) {
		perror("setsockopt: ");
		close(sock);
		return -1;
	}

	bzero(&sun, sizeof (struct sockaddr_un));
	sun.sun_family = AF_UNIX;
	strcpy(sun.sun_path, argv[1]);
	sunlen = strlen(sun.sun_path) + 1 + sizeof (short);

	unlink(sun.sun_path);
	if (bind(sock, (struct sockaddr *) &sun, sunlen) < 0) {
		perror("bind");
		close(sock);
		return -1;
	}

	if (listen(sock, SOMAXCONN)) {
		perror("listen");
		close(sock);
		return -1;
	}

	newsock = accept(sock, (struct sockaddr *)&remote_sun, &rsize);
	if (newsock < 0) {
		perror("accept");
		close(sock);
		return -1;
	}

	memset(buff, 0, sizeof buff);
	memset(&iov, 0, sizeof iov);
	iov.iov_base = buff;
	iov.iov_len = sizeof(buff);
	memset(&msg, 0, sizeof msg);
	msg.msg_iov = &iov;
	msg.msg_iovlen = 1;
	msg.msg_control = &control;
	msg.msg_controllen = sizeof control;
	result = recvmsg(newsock, &msg, 0);
	if (result < 0) {
		perror("recvmsg");
		exit(1);
	}
	for (cmsg = CMSG_FIRSTHDR(&msg); cmsg; cmsg = CMSG_NXTHDR(&msg, cmsg)) {
		if (cmsg->cmsg_level == SOL_SOCKET &&
		    cmsg->cmsg_type == SCM_CREDENTIALS &&
		    cmsg->cmsg_len == CMSG_LEN(sizeof(struct ucred))) {
			struct ucred ucred;
			memcpy(&ucred, CMSG_DATA(cmsg), sizeof(struct ucred));
			printf("%s: Got SCM_CREDENTIALS=(pid %u, uid %u, gid %u)\n",
			       argv[0], ucred.pid, ucred.uid, ucred.gid);
		}
		if (cmsg->cmsg_level == SOL_SOCKET &&
		    cmsg->cmsg_type == SCM_SECURITY) {
			size_t len = cmsg->cmsg_len - CMSG_LEN(0);
			if (len > 0) {
				memcpy(label, CMSG_DATA(cmsg), len);
				label[len] = 0;
				printf("%s: Got SCM_SECURITY=%s\n", argv[0],
				       label);
			}

		}
	}
	close(sock);
	unlink(sun.sun_path);
	return (0);
}


--------------050402050706020600050806
Content-Type: text/plain; charset=UTF-8;
 name="client-stream.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="client-stream.c"

#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>

static const int sendbytes = 100;	/* Send this much data */

int
main(int argc, char **argv)
{
	char data[sendbytes];
	int sock;
	int result;
	struct sockaddr_un sun;
	int sunlen;

	if (argc != 2) {
		fprintf(stderr, "usage:  %s socket-name\n", argv[0]);
		exit(1);
	}

	memset(data, 'X', sendbytes);

	if ((sock = socket(AF_UNIX, SOCK_STREAM, 0)) < 0) {
		perror("socket");
		return -1;
	}

	bzero(&sun, sizeof (struct sockaddr_un));
	sun.sun_family = AF_UNIX;
	strcpy(sun.sun_path, argv[1]);
	sunlen = strlen(sun.sun_path) + 1 + sizeof (short);

	result = connect(sock, (struct sockaddr *) &sun, sunlen);
	if (result < 0) {
		perror("connect");
		close(sock);
		return -1;
	}

	result = write(sock, data, sendbytes);
	if (result < 0) {
		perror("write");
		close(sock);
		return -1;
	}

	printf("%s: sent %5d bytes\n", argv[0], result);
	close(sock);
	return (0);
}


--------------050402050706020600050806--
