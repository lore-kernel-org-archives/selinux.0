Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s17H3fvV002869
 for <selinux@tycho.nsa.gov>; Fri, 7 Feb 2014 12:03:41 -0500
Received: from localhost ([31.16.147.91]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M4GRv-1VLVIa2aHb-00rrQr for <selinux@tycho.nsa.gov>;
 Fri, 07 Feb 2014 18:03:36 +0100
Date: Fri, 7 Feb 2014 18:03:25 +0100
From: Ole Kliemann <ole@plastictree.net>
To: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: RFC - Display context information using iproute2 ss utility
Message-ID: <20140207170325.GA10040@telmora.telvanni>
References: <1391790157.3514.YahooMailNeo@web87902.mail.ir2.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
In-Reply-To: <1391790157.3514.YahooMailNeo@web87902.mail.ir2.yahoo.com>
Sender: telvanni@gmx.net
Cc: selinux list <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2014 at 04:22:37PM +0000, Richard Haines wrote:
> I've been patching the iproute2 "ss" utility to display the SELinux
> security contexts for process and sockets, however I'm not sure
> whether the socket contexts are correct (I expected most to show
> system_u:object_r:....).=20
>=20
> I'm taking the socket contexts from /proc/PID/fd as was mentioned in
> a previous email regarding socket contexts - is this correct ??

I was doing it that way and it seemed to work, I could even=20
change the context using 'chcon /proc/PID/fd'.

But I have no idea whether it is supposed to be a reliable way or=20
any other methods exist. The whole sockfs thing kept me rather=20
wondering...

>=20
> I've attached the patch that is built against:
>=20
> git clone git://git.kernel.org/pub/scm/linux/kernel/git/shemminger/iprout=
e2.git
>=20
> Also is it possible to obtain a sockets peer context from userspace
> using the /proc/PID/fd information as it would be useful to show this.
>=20
> Richard

> From 7d61b9f9e5098a594305364e1380c492eef52091 Mon Sep 17 00:00:00 2001
> From: Richard Haines <richard_c_haines@btinternet.com>
> Date: Fri, 7 Feb 2014 15:02:53 +0000
> Subject: [PATCH] ss: Add support for retrieving SELinux contexts
>=20
> The SELinux contexts can be added to the output using the -Z option.
> The process and socket contexts are retrieved but for netlink sockets:
> if valid process show process context, if pid =3D 0 show kernel initial
> context, if unknown show "not available".
>=20
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  configure     |  16 +++++
>  man/man8/ss.8 |  19 ++++++
>  misc/Makefile |  12 ++++
>  misc/ss.c     | 209 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
------
>  4 files changed, 235 insertions(+), 21 deletions(-)
>=20
> diff --git a/configure b/configure
> index da01c19..854837e 100755
> --- a/configure
> +++ b/configure
> @@ -231,6 +231,19 @@ EOF
>      rm -f $TMPDIR/ipsettest.c $TMPDIR/ipsettest
>  }
> =20
> +check_selinux()
> +# SELinux is a compile time option in the ss utility
> +{
> +	SELINUX_LIB=3D$(${PKG_CONFIG} --silence-errors libselinux --libs)
> +	if [ -n "$SELINUX_LIB" ]
> +	then
> +	echo "HAVE_SELINUX:=3Dy" >>Config
> +	echo "yes"
> +    else
> +	echo "no"
> +	fi
> +}
> +
>  echo "# Generated config based on" $INCLUDE >Config
>  check_toolchain
> =20
> @@ -253,3 +266,6 @@ check_ipt_lib_dir
> =20
>  echo -n "libc has setns: "
>  check_setns
> +
> +echo -n "SELinux support: "
> +check_selinux
> diff --git a/man/man8/ss.8 b/man/man8/ss.8
> index 807d9dc..2fbed36 100644
> --- a/man/man8/ss.8
> +++ b/man/man8/ss.8
> @@ -53,6 +53,22 @@ Print summary statistics. This option does not parse s=
ocket lists obtaining
>  summary from various sources. It is useful when amount of sockets is so =
huge
>  that parsing /proc/net/tcp is painful.
>  .TP
> +.B \-Z, \-\-context
> +Show SELinux security contexts. Both the process and socket contexts will
> +be displayed (for those with socket file descriptors). For=20
> +.BR netlink (7)
> +sockets, the context displayed is as follows:
> +.RS
> +.RS
> +.IP "1." 4
> +If a valid process show pid context.
> +.IP "2." 4
> +If destination is kernel (pid =3D 0) show kernel initial context.
> +.IP "3." 4
> +If allocated by the kernel or netlink user show context as "not availabl=
e".
> +.RE
> +.RE
> +.TP
>  .B \-b, \-\-bpf
>  Show socket BPF filters (only administrators are allowed to get these in=
formation).
>  .TP
> @@ -103,6 +119,9 @@ Please take a look at the official documentation (Deb=
ian package iproute-doc) fo
>  .B ss -t -a
>  Display all TCP sockets.
>  .TP
> +.B ss -t -a -Z
> +Display all TCP sockets with process and socket SELinux security context=
s.
> +.TP
>  .B ss -u -a
>  Display all UDP sockets.
>  .TP
> diff --git a/misc/Makefile b/misc/Makefile
> index a59ff87..a946a85 100644
> --- a/misc/Makefile
> +++ b/misc/Makefile
> @@ -8,6 +8,18 @@ include ../Config
>  all: $(TARGETS)
> =20
>  ss: $(SSOBJ)
> +ifeq ($(HAVE_SELINUX),y)
> +	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(SSOBJ) $(LDLIBS) -lselinux
> +else
> +	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(SSOBJ) $(LDLIBS)
> +endif
> +
> +ss.o: ss.c
> +ifeq ($(HAVE_SELINUX),y)
> +	$(CC) $(CFLAGS) -DHAVE_SELINUX -c $+
> +else
> +	$(CC) $(CFLAGS) -c $+
> +endif
> =20
>  nstat: nstat.c
>  	$(CC) $(CFLAGS) $(LDFLAGS) -o nstat nstat.c -lm
> diff --git a/misc/ss.c b/misc/ss.c
> index 764ffe2..1e1d3fb 100644
> --- a/misc/ss.c
> +++ b/misc/ss.c
> @@ -40,6 +40,9 @@
>  #include <linux/filter.h>
>  #include <linux/packet_diag.h>
>  #include <linux/netlink_diag.h>
> +#if HAVE_SELINUX
> +#include <selinux/selinux.h>
> +#endif
> =20
>  int resolve_hosts =3D 0;
>  int resolve_services =3D 1;
> @@ -50,6 +53,11 @@ int show_users =3D 0;
>  int show_mem =3D 0;
>  int show_tcpinfo =3D 0;
>  int show_bpf =3D 0;
> +#if HAVE_SELINUX
> +int show_context =3D 0;
> +/* If show_users & show_context only do user_ent_hash_build() once */
> +int user_ent_hash_build_init =3D 0;
> +#endif
> =20
>  int netid_width;
>  int state_width;
> @@ -207,7 +215,11 @@ struct user_ent {
>  	unsigned int	ino;
>  	int		pid;
>  	int		fd;
> -	char		process[0];
> +	char	*process;
> +#if HAVE_SELINUX
> +	security_context_t	process_ctx;
> +	security_context_t	socket_ctx;
> +#endif
>  };
> =20
>  #define USER_ENT_HASH_SIZE	256
> @@ -220,20 +232,29 @@ static int user_ent_hashfn(unsigned int ino)
>  	return val & (USER_ENT_HASH_SIZE - 1);
>  }
> =20
> -static void user_ent_add(unsigned int ino, const char *process, int pid,=
 int fd)
> +#if HAVE_SELINUX
> +static void user_ent_add(unsigned int ino, char *process,
> +							int pid, int fd,
> +							security_context_t proc_ctx,
> +							security_context_t sock_ctx)
> +#else
> +static void user_ent_add(unsigned int ino, char *process, int pid, int f=
d)
> +#endif
>  {
>  	struct user_ent *p, **pp;
> -	int str_len;
> =20
> -	str_len =3D strlen(process) + 1;
> -	p =3D malloc(sizeof(struct user_ent) + str_len);
> +	p =3D malloc(sizeof(struct user_ent));
>  	if (!p)
>  		abort();
>  	p->next =3D NULL;
>  	p->ino =3D ino;
>  	p->pid =3D pid;
>  	p->fd =3D fd;
> -	strcpy(p->process, process);
> +	p->process =3D strdup(process);
> +#if HAVE_SELINUX
> +	p->process_ctx =3D strdup(proc_ctx);
> +	p->socket_ctx =3D strdup(sock_ctx);
> +#endif
> =20
>  	pp =3D &user_ent_hash[user_ent_hashfn(ino)];
>  	p->next =3D *pp;
> @@ -247,6 +268,17 @@ static void user_ent_hash_build(void)
>  	char name[1024];
>  	int nameoff;
>  	DIR *dir;
> +#if HAVE_SELINUX
> +    security_context_t pid_context;
> +    security_context_t sock_context;
> +	security_context_t no_ctx =3D "not available";
> +
> +	/* If show_users & show_context only do this once */
> +	if (user_ent_hash_build_init !=3D 0)
> +		return;
> +
> +	user_ent_hash_build_init =3D 1;
> +#endif
> =20
>  	strcpy(name, root);
>  	if (strlen(name) =3D=3D 0 || name[strlen(name)-1] !=3D '/')
> @@ -261,19 +293,24 @@ static void user_ent_hash_build(void)
>  	while ((d =3D readdir(dir)) !=3D NULL) {
>  		struct dirent *d1;
>  		char process[16];
> +		char *p;
>  		int pid, pos;
>  		DIR *dir1;
>  		char crap;
> =20
>  		if (sscanf(d->d_name, "%d%c", &pid, &crap) !=3D 1)
>  			continue;
> -
> +#if HAVE_SELINUX
> +		if (getpidcon(pid, &pid_context) !=3D 0)
> +			pid_context =3D strdup(no_ctx);
> +#endif
>  		sprintf(name + nameoff, "%d/fd/", pid);
>  		pos =3D strlen(name);
>  		if ((dir1 =3D opendir(name)) =3D=3D NULL)
>  			continue;
> =20
>  		process[0] =3D '
--6TrnltStXW4iwmi0--
