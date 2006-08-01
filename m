Subject: Re: gnuTAR support for SELinux context (beta)
From: James Antill <jantill@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1154456909.3582.139.camel@moss-spartans.epoch.ncsc.mil>
References: <1154453240.2103.27.camel@code.and.org>
	 <1154456909.3582.139.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-oP53GMLRGMBwPXwSJLsK"
Date: Tue, 01 Aug 2006 15:02:19 -0400
Message-Id: <1154458939.2103.69.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-oP53GMLRGMBwPXwSJLsK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-08-01 at 14:28 -0400, Stephen Smalley wrote:
> On Tue, 2006-08-01 at 13:27 -0400, James Antill wrote:
> >In a similar vein
> > you can ignore any selinux context information by using --no-selinux
> > when you extract, or --no-xattrs to ignore all xattr information.

> What about just saving the selinux contexts by default if they are
> present on the files being archived (and likewise extracting them by
> default if present in the archive)?  Otherwise, users have to take
> explicit action to save and restore the file contexts and will continue
> to "lose" them by default.

 Note that --xattrs is on by default for extracting, you have to use the
--no-* varients to not extract that info. from the archive. So if you
pass --selinux or --xattrs on the create command line, it just works.
 There are backwards compatibility concerns with enabling even --selinux
by default for creating archives (older versions of GNUtar will spew
warnings, and give error exit codes).

 It's also not obvious it should happen, consider files created in /tmp
and tar'd ... extracting them with tmp_t is probably not what you want.
Dito things like untar'ing an archive of html in /var/www/html (on the
other hand, untar'ing php will only ever work if it has the right
context in the archive).

--=20
James Antill <jantill@redhat.com>

--=-oP53GMLRGMBwPXwSJLsK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)

iD8DBQBEz6U711eXTEMrxtQRAnJgAJ9zfvQYcijq8Mryudjebrvr7u133gCgvkYX
NsSWicnzC3djrfVEJqAW77M=
=tgaT
-----END PGP SIGNATURE-----

--=-oP53GMLRGMBwPXwSJLsK--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
