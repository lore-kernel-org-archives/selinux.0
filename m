Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3P4kLjZ030364
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 00:46:21 -0400
Received: from mail.and.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3P4kKEA013172
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 04:46:21 GMT
Subject: Re: [PATCH 00/33] libsemanage/libsepol object serialization and
	ps-api
From: James Antill <jantill@redhat.com>
To: jbrindle@tresys.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1177456360.20127.83.camel@code.and.org>
References: <20070423213455.741326000@tresys.com>
	 <1177456360.20127.83.camel@code.and.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-eAUClcdu6gom7mt0WwQX"
Date: Wed, 25 Apr 2007 00:46:19 -0400
Message-Id: <1177476379.20127.86.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-eAUClcdu6gom7mt0WwQX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-04-24 at 19:12 -0400, James Antill wrote:
> On Mon, 2007-04-23 at 17:34 -0400, jbrindle@tresys.com wrote:
> > This is the majority of the patches from the policy server release a fe=
w months ago. This implements object serialization to send objects (eg., bo=
oleans, file contexts, etc) across the line to the policy server. It also i=
mplements the line protocol to connect to the policy server and the backend=
 for libsemanage so that semodule, semanage, etc will talk to a policy serv=
er instead of doing local operations.
> >=20
> > The object serialization will also be necessary for the policy represen=
tation branch as we will use this infrastructure to serialize the policy tr=
ee for module reading and writing.
> >=20
> > The only part left for the policy server is the hooks that were impleme=
nted in the expander. As the policy representation work is going on and sho=
uld remove the expander entirely these patches will have to wait until we h=
ave enough of the new representation work to implement them there.
> >=20
> > This is obviously meant only for trunk and the policyrep branch.
>=20
>  Karl asked me to have a look at this, and I haven't looked at all of
> it ... but what I have seen worries me a bit.


 Here's the first parts:

[patch 01]
=20
int sepol_serialize(sepol_handle_t * handle,
		    const void *datum,
		    size_t datum_length,
		    unsigned int datum_type, char **data, uint64_t * size)
		   =20
 This is better fixed by Karl's suggestion of not having a single function,=
 but having datum_length which is ignored for SEPOL_SERIAL_INT32_T etc. is =
confusing.

 The serialization for SEPOL_SERIAL_STRING:
  Why are you using snprintf()?
  You are moving datum_length into status (size_t into int), which is just =
asking for pain.

int sepol_unserialize(sepol_handle_t * handle,
		char **data, uint64_t * size,
		void **datum,
		size_t ** datum_length,
		unsigned int datum_type)

SEPOL_SERIAL_STRING_ARRAY:
                               /* Datum. */
				*datum =3D
					calloc(sizeof(char *),
							sizeof(char *) * (**datum_length));

 I'm pretty sure you want calloc(sizeof(char *), **datum_length);

[patch 10]

=20
 int dbase_serialize(struct semanage_handle *handle,
		    dbase_config_t * dconfig,
		    char **data, uint64_t * data_length)

 size_t can still be 32bits, so storing uint64_t's in it might be bad.
 I'm not sure I understand what the completed_count is doing, are you leaki=
ng anything if the calloc() fails? I think you want to free upto count all =
the time.=20

[patch 12]
 semanage_serialize is an exact copy of sepol_serialize, AFAICS, so see abo=
ve.
=20
[patch 16]

 I assume semanage_fcontext_get_con(fcontext) doesn't allocate anything, st=
ill it'd be nice to not call it twice and just reuse con.
=20
 I worry about having semanage_fcontext_unserialize() leave fcontext alloca=
ted on failure. A bunch of code does this with arrays ... but even so.
=20
[patch 21]
=20
 Dito. user_extra is left allocated on the failure path, in semanage_user_e=
xtra_unserialize.
 Dito. user is left allocated on the failure path, in semanage_user_unseria=
lize.
=20
[patch 22]
 =20
 for (i =3D 0; i < *modules_size; i++) {
		/* Module name. */
		status =3D semanage_unserialize(handle, data, size, (void **)&(*modules)[=
i].name, &temp_size, SEMANAGE_SERIAL_STRING);
		if (status !=3D STATUS_SUCCESS)
			goto cleanup;

		/* Module version. */
		status =3D semanage_unserialize(handle, data, size, (void **)&(*modules)[=
i].version, &temp_size, SEMANAGE_SERIAL_STRING);
		if (status !=3D STATUS_SUCCESS)
		        goto cleanup;
}

 temp_size is allocated on _each call_ to unserialize.=20
=20
[patch 23]
=20
 Why are you calling serialize twice, INT32_T is a fixed size, no?

--=20
James Antill <jantill@redhat.com>

--=-eAUClcdu6gom7mt0WwQX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGLt0a11eXTEMrxtQRAi0kAJ90KNBodl2p9DsQFMJe+euiSOF+1QCgiuWy
+izg4YUAagnqjzJP4Iics6o=
=nF2Z
-----END PGP SIGNATURE-----

--=-eAUClcdu6gom7mt0WwQX--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
