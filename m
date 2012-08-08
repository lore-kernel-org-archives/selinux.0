Message-ID: <1344454290.25533.12.camel@localhost>
Subject: A filename to label translation daemon
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: lennart@poettering.net, sds@tycho.nsa.gov, dwalsh@redhat.com
Date: Wed, 08 Aug 2012 15:31:30 -0400
Content-Type: multipart/mixed; boundary="=-VCb8aGRe1TgGFjVkuCxp"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-VCb8aGRe1TgGFjVkuCxp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

We know that utilities like install disable their SELinux support
because of the enormous amount of time it takes to load the matchpathcon
regex database.  We know that systemd spends time loading the database
at least twice.  Other utilities like the krb5libs complain about the
size and time it takes to load the database.  We've added hacks (I
believe all in Fedora, but maybe upstream as well) which try to pare
down the database to some prefix(es) on database load.  If systemd only
needs to label in /var why load all the stuff for /etc?  These prefix
hacks don't work particularly well as fallback labels (such as
default_t) are hard to capture and the prefixes cannot be long as the
regexes are usually quite short.  They also don't work well with label
equivalencies.

So today I wrote a little daemon which listens in the abstract namespace
for requests and returns the context.  It really really rough, I admit,
but it works quite well.  My first perf numbers looking at /home/eparis
make sense:

$ ./initonce /home/eparis
 0.180 seconds used by the processor.
$ ./initalways /home/eparis
 19.200 seconds used by the processor.
$ ./client /home/eparis
 0.570 seconds used by the processor.

If I init the DB one time and do the same lookup (for /home/eparis) 1000
times it takes .18 seconds.  Doing 1000 lookups init-ing and fini-ing
the db every time it took 19.2.  Connecting to the server and asking
1000 times took .57 seconds.  This means that if you have to do about 48
lookups, it's faster to do your own init.  If <48, you should use the
server.

The I tried again with a different pathname (and get very different
results)

$ ./initonce /var/www/html/cgi-bin
 1.510 seconds used by the processor.
$ ./initalways /var/www/html/cgi-bin
 42.790 seconds used by the processor.
$ ./client /var/www/html/cgi-bin
 0.600 seconds used by the processor.

These I cannot explain.  How the heck is local slower when the time to
init the db is not taken into account at all?  I'm clueless here.  But
still, the client server model doesn't look like a bad idea.

I'm attaching my server, my client, and my 2 local test programs.
Thoughts?

*having the daemon listen and update the db on policy load is a todo

-Eric

--=-VCb8aGRe1TgGFjVkuCxp
Content-Disposition: attachment; filename="client.c"
Content-Type: text/x-csrc; name="client.c"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

#include <errno.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <sys/socket.h>
#include <sys/types.h>
#include <sys/un.h>

#define SOCKET_PATH "selinux.filename.label"
#define MAX_REQUEST_LEN 8192

#define offsetof(st, m)	((size_t)((char *)&((st *)0)->m - (char *)0))

#include <time.h>
clock_t startm, stopm;
#define START if ( (startm = clock()) == -1) {printf("Error calling clock");exit(1);}
#define STOP if ( (stopm = clock()) == -1) {printf("Error calling clock");exit(1);}
#define PRINTTIME printf( "%6.3f seconds used by the processor.\n", ((double)stopm-startm)/CLOCKS_PER_SEC);

static int make_request(char *pathname, mode_t mode)
{
	int rc, sockfd;
	struct sockaddr_un sockaddr_un;
	ssize_t buflen, len;
	char buffer[MAX_REQUEST_LEN];

	/* put the mode at the front of the buffer */
	buflen = snprintf(buffer, sizeof(buffer), "%x %s", mode, pathname);
	if (buflen < 0)
		return -1;
	if (buflen == sizeof(buffer)) {
		errno = -ENOSPC;
		return -1;
	}

	/* create socket to talk to server */
	sockfd = socket(AF_UNIX, SOCK_SEQPACKET, 0);
	if (sockfd < 0)
		return -1;

	/* set up address of the server */
	sockaddr_un.sun_family = AF_UNIX;
	sockaddr_un.sun_path[0] = '\0';
	memcpy(&sockaddr_un.sun_path[1], SOCKET_PATH, strlen(SOCKET_PATH));

	/* this size of addr is really screwy to calculate, there be dragons here */
	len = offsetof(struct sockaddr_un, sun_path) + strlen(SOCKET_PATH) + 1;

	/* connect to server */
	rc = connect(sockfd, (const struct sockaddr *)&sockaddr_un, len);
	if (rc < 0)
		return -1;

	/* send the request */
	len = send(sockfd, buffer, buflen + 1, 0);
	if (len <= 0)
		return -1;

	/* get the context */
	len = recv(sockfd, buffer, MAX_REQUEST_LEN, 0);
	if (len <= 0)
		return -1;

#ifdef VERBOSE
	printf("pathname=%s mode=%x context=%s\n", pathname, mode, buffer);
#endif

	return 0;
}

int main(int argc, char *argv[])
{
	mode_t mode = 0;
	int rc, i;

	if (argc < 2) {
		printf("usage: %s filename [mode]\n", argv[0]);
		return 0;
	}

	if (argc >= 3) {
		unsigned long model;

		errno = 0;    /* To distinguish success/failure after call */
		model = strtoul(argv[2], NULL, 16);
		if ((errno == ERANGE && model == ULONG_MAX) ||
		    (errno != 0 && model == 0)) {
			perror("strtol");
			exit(EXIT_FAILURE);
		}
		mode = (mode_t)model;
	}


	START
	for (i = 0; i < 1000; i++) {
		rc = make_request(argv[1], mode);
		if (rc)
			return -1;
	}
	STOP
	PRINTTIME

	return 0;
}

--=-VCb8aGRe1TgGFjVkuCxp
Content-Disposition: attachment; filename="initalways.c"
Content-Type: text/x-csrc; name="initalways.c"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

#include <errno.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include <selinux/selinux.h>

#include <sys/socket.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/un.h>

#define SOCKET_PATH "selinux.filename.label"
#define MAX_LABEL_LEN 4096

#include <time.h>
clock_t startm, stopm;
#define START if ( (startm = clock()) == -1) {printf("Error calling clock");exit(1);}
#define STOP if ( (stopm = clock()) == -1) {printf("Error calling clock");exit(1);}
#define PRINTTIME printf( "%6.3f seconds used by the processor.\n", ((double)stopm-startm)/CLOCKS_PER_SEC);

int main(int argc, char *argv[])
{
	int rc, i;
	mode_t mode = 0;
	security_context_t con;

	if (argc < 2) {
		printf("usage: %s filename [mode]\n", argv[0]);
		return 0;
	}

	if (argc >= 3) {
		unsigned long model;

		errno = 0;    /* To distinguish success/failure after call */
		model = strtoul(argv[2], NULL, 16);
		if ((errno == ERANGE && model == ULONG_MAX) ||
		    (errno != 0 && model == 0)) {
			perror("strtol");
			exit(EXIT_FAILURE);
		}
		mode = (mode_t)model;
	}

	START
	for (i = 0; i < 1000; i++) {
		rc = matchpathcon_init(NULL);
		if (rc < 0)
			return -1;

		rc = matchpathcon(argv[1], mode, &con);
		if (rc < 0)
			return -2;
#ifdef VERBOSE
		printf("pathname=%s mode=%x context=%s\n", argv[1], mode, con);
#endif
		free(con);
		matchpathcon_fini();
	}
	STOP
	PRINTTIME

	return rc;
}

--=-VCb8aGRe1TgGFjVkuCxp
Content-Disposition: attachment; filename="initonce.c"
Content-Type: text/x-csrc; name="initonce.c"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

#include <errno.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include <selinux/selinux.h>

#include <sys/socket.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/un.h>

#define SOCKET_PATH "selinux.filename.label"
#define MAX_LABEL_LEN 4096

#include <time.h>
clock_t startm, stopm;
#define START if ( (startm = clock()) == -1) {printf("Error calling clock");exit(1);}
#define STOP if ( (stopm = clock()) == -1) {printf("Error calling clock");exit(1);}
#define PRINTTIME printf( "%6.3f seconds used by the processor.\n", ((double)stopm-startm)/CLOCKS_PER_SEC);

int main(int argc, char *argv[])
{
	int rc, i;
	mode_t mode = 0;
	security_context_t con;

	if (argc < 2) {
		printf("usage: %s filename [mode]\n", argv[0]);
		return 0;
	}

	if (argc >= 3) {
		unsigned long model;

		errno = 0;    /* To distinguish success/failure after call */
		model = strtoul(argv[2], NULL, 16);
		if ((errno == ERANGE && model == ULONG_MAX) ||
		    (errno != 0 && model == 0)) {
			perror("strtol");
			exit(EXIT_FAILURE);
		}
		mode = (mode_t)model;
	}

	rc = matchpathcon_init(NULL);
	if (rc < 0)
		return -1;

	START
	for (i = 0; i < 1000; i++) {
		rc = matchpathcon(argv[1], mode, &con);
		if (rc < 0)
			return -2;
#ifdef VERBOSE
		printf("pathname=%s mode=%x context=%s\n", argv[1], mode, con);
#endif
		free(con);
	}
	STOP
	PRINTTIME

	matchpathcon_fini();
	return rc;
}

--=-VCb8aGRe1TgGFjVkuCxp
Content-Disposition: attachment; filename="server.c"
Content-Type: text/x-csrc; name="server.c"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

#include <ctype.h>
#include <errno.h>
#include <getopt.h>
#include <limits.h>
#include <poll.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include <selinux/selinux.h>

#include <sys/socket.h>
#include <sys/types.h>
#include <sys/un.h>

#include <systemd/sd-daemon.h>

#define SOCKET_PATH "selinux.filename.label"
#define MAX_REQUEST_LEN 8192
#define MAX_BACKLOG 100
#define RECV_TIMEOUT 250 /* milliseconds */

#define offsetof(st, m)	((size_t)((char *)&((st *)0)->m - (char *)0))

/*
 * Requests are send to the server as single packet of the form:
 * 	snprintf("%x %s", mode, pathname);
 * Responses are sent to the client as string representing the raw context
 */
static void handle_request(int fd)
{
	int rc;
	ssize_t len;
	char buffer[MAX_REQUEST_LEN + 1];
	char *pathname;
	unsigned long model;
	mode_t mode;
	security_context_t con = NULL;
	struct pollfd pollfd;

	pollfd.fd = fd;
	pollfd.events = POLLIN;

	/* don't hang forever if the client sux */
	rc = poll(&pollfd, 1, RECV_TIMEOUT);
	if (rc <= 0)
		goto out;

	/* get the request */
	len = recv(fd, buffer, sizeof(buffer), 0);
	if (len <= 0)
		goto out;

	/* just to be safe! */
	buffer[MAX_REQUEST_LEN] = '\0';

	/*
	 * Yes, I could use sscanf("%x %s") but it would needlessly duplicate
	 * pathname.  Whereas strtoul leaves me a pointer to it in buffer
	 */

	/* parse the mode portion to a mode_t */
	errno = 0;    /* To distinguish success/failure after call */
	model = strtoul(buffer, &pathname, 16);
	if ((errno == ERANGE && model == ULONG_MAX) ||
	    (errno != 0 && model == 0))
		goto out;
	mode = (mode_t)model;

	/* skip whitespace between mode and pathname */
	while (pathname < &buffer[MAX_REQUEST_LEN - 1] && isspace(pathname[0]))
		pathname++;

	/* pathname now points at the pathname part of the buffer! */
	if (pathname >= &buffer[MAX_REQUEST_LEN - 1] || !pathname[0])
		goto out;

	/* do the lookup */
	rc = matchpathcon(pathname, mode, &con);
	if (rc < 0) {
		if (errno == ENOENT) {
			con = strdup("<<none>>");
			if (!con)
				goto out;
		} else {
			goto out;
		}
	}

	/* send the response */
	len = send(fd, con, strlen(con) + 1, 0);
	if (len <= 0)
		goto out;

#ifdef VERBOSE
	printf("pathname=%s mode=%x context=%s\n", pathname, mode, con);
#endif
out:
	free(con);
	close(fd);
}

static void usage(char *progname)
{
	fprintf(stderr, "usage: %s [-f,--foreground] [-s,--socket fd]\n", progname);
	exit(EXIT_FAILURE);
}

int main(int argc, char *argv[])
{
	int rc, clientfd, c;
	int serverfd = -1;
	size_t len;
	struct sockaddr_un sockaddr_un;
	int option_index = 0;
	int foreground = 0;
	static struct option long_options[] = {
		{"foreground", no_argument, 0, 'f'},
		{"socket", required_argument, 0, 's'},
		{0, 0, 0, 0}
	};

	while (1) {
		c = getopt_long(argc, argv, "fs:", long_options, &option_index);
		if (c == -1)
			break;

		switch (c) {
		case 'f':
			foreground = 1;
			break;
		case 's':
			serverfd = strtol(optarg, NULL, 0);
			if (serverfd < 0) {
				fprintf(stderr, "invalid socket fd\n");
				usage(argv[0]);
			}
			break;
		case '?':
		default:
			usage(argv[0]);
			break;
		};
	}

	c = sd_listen_fds(0);
	if (c > 1) {
		fprintf(stderr, "Too many file descriptors received.\n");
		exit(EXIT_FAILURE);
	} else if (c == 1)
		serverfd = SD_LISTEN_FDS_START + 0;

	if (!foreground)
		daemon(0, 0);

	/* init the label regex db */
	rc = matchpathcon_init(NULL);
	if (rc < 0) {
		perror("matchpathcon_init");
		return errno;
	}

	/* if we didn't get the serverfd from systemd or command line, do it outselves */
	if (serverfd == -1) {
		/* create the socket on which we will listen */
		serverfd = socket(AF_UNIX, SOCK_SEQPACKET, 0);
		if (serverfd < 0) {
			perror("socket");
			return errno;
		}

		/* set up out address */
		sockaddr_un.sun_family = AF_UNIX;
		sockaddr_un.sun_path[0] = '\0';
		memcpy(&sockaddr_un.sun_path[1], SOCKET_PATH, strlen(SOCKET_PATH));

		/* calculating the length of the address is magic since it starts with nul.
	 	* there be dragons in here! */
		len = offsetof(struct sockaddr_un, sun_path) + strlen(SOCKET_PATH) + 1;

		/* bind the socket to the address */
		rc = bind(serverfd, (const struct sockaddr *)&sockaddr_un, len);
		if (rc < 0) {
			perror("bind");
			return errno;
		}

		/* start listening for connections */
		rc = listen(serverfd, MAX_BACKLOG);
		if (rc < 0) {
			perror("listen");
			return errno;
		}
	} /* if (serverfd == -1) */

	/* work yo! */
	while (1) {
		clientfd = accept(serverfd, NULL, 0);
		if (clientfd < 0) {
			perror("accept");
			return errno;
		}

		handle_request(clientfd);
	}
	close(serverfd);
	return rc;
}

--=-VCb8aGRe1TgGFjVkuCxp--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
