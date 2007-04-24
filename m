Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3ONCijG019138
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 19:12:44 -0400
Received: from mail.and.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3ONCgps024787
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 23:12:42 GMT
Subject: Re: [PATCH 00/33] libsemanage/libsepol object serialization and
	ps-api
From: James Antill <jantill@redhat.com>
To: jbrindle@tresys.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20070423213455.741326000@tresys.com>
References: <20070423213455.741326000@tresys.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uyERRKU5GUCCzYINseCo"
Date: Tue, 24 Apr 2007 19:12:40 -0400
Message-Id: <1177456360.20127.83.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-uyERRKU5GUCCzYINseCo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-04-23 at 17:34 -0400, jbrindle@tresys.com wrote:
> This is the majority of the patches from the policy server release a few =
months ago. This implements object serialization to send objects (eg., bool=
eans, file contexts, etc) across the line to the policy server. It also imp=
lements the line protocol to connect to the policy server and the backend f=
or libsemanage so that semodule, semanage, etc will talk to a policy server=
 instead of doing local operations.
>=20
> The object serialization will also be necessary for the policy representa=
tion branch as we will use this infrastructure to serialize the policy tree=
 for module reading and writing.
>=20
> The only part left for the policy server is the hooks that were implement=
ed in the expander. As the policy representation work is going on and shoul=
d remove the expander entirely these patches will have to wait until we hav=
e enough of the new representation work to implement them there.
>=20
> This is obviously meant only for trunk and the policyrep branch.

 Karl asked me to have a look at this, and I haven't looked at all of
it ... but what I have seen worries me a bit.=20

[patch 22/33]=20


	status =3D semanage_unserialize(handle, data, size, (void **)&temp_size,
NULL, SEMANAGE_SERIAL_UINT32_T);

 This has the same problem I told Karl about, (foo **) doesn't convert
to (void **) in std. C.

[patch 24/33]
int read_n(semanage_handle_t *sh, int socket_fd, int timeout, char *buf,
size_t n)
int flush_n(semanage_handle_t *sh, int socket_fd, int timeout, uint64_t
n)

 Test the result of time() directly against (time_t)-1.
 select only easily handles fds upto FD_SETSIZE.
 timeout parameter is "interesting" in that it can take upto (timeout *
2) easily, and even (n*timeout) seconds for the worst case.
 timeout =3D=3D 0, means you spin on read() with an O_NONBLOCK fd.
 If you get read() =3D=3D 0, Ie. EOF, you spin until the timeout expires.

int read_msg(semanage_handle_t *sh, int socket_fd, int timeout, uint32_t
* message_type,
	     uint64_t * data_length, char **data)

 Having the parameters be: (len, buf) when read is (buf, len) is a bad
idea, IMO.

int write_msg(semanage_handle_t *sh, int socket_fd, uint32_t
message_type,
	      uint64_t data_length, char *data)

 This doesn't handle EINTR, assumes that writting the msg_header will
happen atomically (and won't get EAGAIN etc.).
 Also the use of O_NONBLOCK and a while loop on write are not a good
combination.
=20
int read_server(semanage_handle_t *sh, int socket_fd, uint32_t *
message_type,
		uint64_t * data_length, char **data)

 WTF is the server sending that you can arbitrarily ignore it????


       if (write_msg(handle, fd, PS_PUT_DATABASE, data_length, data))
       if (read_server(handle, fd, &message_type, &data_length, &data))

[patch 25/33]
+static int dbase_ps_flush(semanage_handle_t * handle, dbase_config_t *
dconfig)
{


[...]
       /* Clean up. */
       free(data);

       return STATUS_SUCCESS;

      err:
       ERR(handle, "could not flush database to policy server");
       free(data);
       free(type);
       free(records);
       return STATUS_ERR;
}

 records/type is leaked on the normal path.

static int dbase_ps_cache(semanage_handle_t * handle, dbase_config_t *
dconfig)
{
[...]
	if (semanage_dbase_ps_database_type_serialize(handle,
dbase->database_type, &data, &data_length) !=3D STATUS_SUCCESS)
		goto err;

	if (write_msg(handle, fd, PS_GET_DATABASE, data_length, data))
		goto err;

	data =3D NULL;
	data_length =3D 0;

 This leaks data.


int semanage_ps_begintrans(semanage_handle_t * sh)
{
       uint32_t response_type =3D 0;
       uint64_t response_length =3D 0;
       char *response =3D NULL;

       err =3D write_msg(sh, fd, PS_BEGIN_TRANSACTION, 0, NULL);
       err =3D read_server(sh, fd, &response_type, &response_length,
&response);
}

/*
[...]
 * The file descriptor will be set to non-blocking mode.
 * Return the file descriptor used, -1 if the server could not be
 * found, -2 if the server rejected this connection, or -3 for all
 * other errors.
 */
int semanage_ps_connect(semanage_handle_t * sh)

 Overloading the fd value in this way is pretty hacky.
 Also is_connected is set to 1 early in this function, and isn't reset
to 0 on failures.





int semanage_ps_disconnect(semanage_handle_t * sh)
{
[...]
       err =3D close(sh->u.ps_handle.socket_fd);
       sh->u.ps_handle.socket_fd =3D err;
       return err;
}

 Setting socket_fd to 0, on success, is probably a really bad idea.
 This also doesn't reset is_connected to 0.
=20
=20
int semanage_ps_list_modules(semanage_handle_t * sh,
                             semanage_module_info_t ** modules, int
*num_mods)

 This uses C99 variable declarations, is that intentional?

=20
semanage_ps_begintrans
semanage_ps_install_base_module
semanage_ps_install_module
semanage_ps_remove_module
semanage_ps_upgrade_module
=20
 Are all basically the same function. And there are a few more which
also C&P this function with a bit added on the end.


static int connect_remote(semanage_handle_t * sh)
=20
 Probably at least need a comment that this is IPv4 only, and uses
gethostbyname().
 The return value from inet_ntop() isn't checked.
=20


--=20
James Antill - <james.antill@redhat.com>
setsockopt(fd, IPPROTO_TCP, TCP_CONGESTION, ...);
setsockopt(fd, IPPROTO_TCP, TCP_DEFER_ACCEPT, ...);
setsockopt(fd, SOL_SOCKET,  SO_ATTACH_FILTER, ...);


--=-uyERRKU5GUCCzYINseCo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGLo7n11eXTEMrxtQRAmxYAKC3tKqQ6XkhczrbxXQVXNIIt4QUKACfZ8Ra
g/AuV2SF2grzF8VIny4lf2A=
=FuO6
-----END PGP SIGNATURE-----

--=-uyERRKU5GUCCzYINseCo--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
