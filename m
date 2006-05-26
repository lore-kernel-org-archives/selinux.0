Subject: Re: [patch] Full relabel audit event
From: James Antill <jantill@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: redhat-lspp <redhat-lspp@redhat.com>, linux-audit@redhat.com,
        selinux@tycho.nsa.gov
In-Reply-To: <1148663120.20976.235.camel@moss-spartans.epoch.ncsc.mil>
References: <1148590901.8828.22.camel@code.and.org>
	 <1148663120.20976.235.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BTdVaTnnOYtt8bP4Dayc"
Date: Fri, 26 May 2006 13:47:27 -0400
Message-Id: <1148665647.8828.36.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-BTdVaTnnOYtt8bP4Dayc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-05-26 at 13:05 -0400, Stephen Smalley wrote:
> On Thu, 2006-05-25 at 17:01 -0400, James Antill wrote:
> >  The attached patch implements the full relabel audit event (Ie. an
> > audit event occurs when a full relabel occurs, ie. when /.autorelabel
> > exists at boot).
> >  Note that although the code is correct, this patch doesn't actually
> > work due to kernel bugs[1].
> >=20
> >  It'll be in Fedora development as part of policycoreutils-1.30.10-3
> > onwards.
> >=20
> > [1] see the thread on linux-audit if you want the details.
>=20
> Hmmm...what is it that you actually want to do here?  If you only care
> about auditing autorelabel events, then I'd suggest generating the audit
> message from the autorelabel portion of rc.sysinit (via a helper, I
> suppose), not from setfiles itself.

 This is all that we care about, but the solution of creating a helper
to just be called before setfiles was considered suboptimal against just
putting the code inside setfiles (I know Steve is very much against
anything which acts like logger for the audit subsystem).

> Not sure which thread you are referring to; I don't see prior discussion
> of a relabel audit event in the linux-audit archives.

 The thread is for the kernel problem that makes the above patch not
actually work, see the thread "Re: audit 1.2.2 released".

--=20
James Antill <jantill@redhat.com>

--=-BTdVaTnnOYtt8bP4Dayc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEdz8v11eXTEMrxtQRAiINAJ40naOtXw7U3F+xgDM6BWKdAz/qPgCghjLF
Aam+6C9poxAEf9kXx2BJcP4=
=9T3p
-----END PGP SIGNATURE-----

--=-BTdVaTnnOYtt8bP4Dayc--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
