Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v48Deno9012474
 for <selinux@tycho.nsa.gov>; Mon, 8 May 2017 09:40:49 -0400
Received: by mail-wr0-f169.google.com with SMTP id w50so44036509wrc.0
 for <selinux@tycho.nsa.gov>; Mon, 08 May 2017 06:40:46 -0700 (PDT)
Received: from julius (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id b45sm5331413edb.36.2017.05.08.06.40.44
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 08 May 2017 06:40:44 -0700 (PDT)
Date: Mon, 8 May 2017 15:40:43 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Why does Python want to read /proc/meminfo
Message-ID: <20170508134043.GC3701@julius>
References: <72df5e72-55ac-5696-ceb6-f50f98a35ea5@gmail.com>
 <87tw4yfs82.fsf@handshake.de>
 <8b1d353c-7f98-5522-4f42-906a7082d47a@gmail.com>
 <20170506180024.GA12984@julius>
 <1494250929.4621.4.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
In-Reply-To: <1494250929.4621.4.camel@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2017 at 09:42:09AM -0400, Stephen Smalley wrote:
> On Sat, 2017-05-06 at 20:00 +0200, Dominick Grift wrote:
> > On Sat, May 06, 2017 at 11:07:34AM -0500, Ian Pilcher wrote:
> > > On 05/06/2017 12:51 AM, dieter wrote:
> > > > Personally, I doubt that you will find a reference.
> > > > Instead, I assume that the reference comes from the C runtime
> > > > library.
> > > > It might hepl optimize memory management to know about "meminfo"
> > > > details.
> > >=20
> > > You're right.=A0=A0Seems that it's glibc's qsort().
> > >=20
> > > So it seems that any service written in Python (or any other
> > > program
> > > that uses qsort) needs to be given read access to most of /proc or
> > > deal
> > > with the (unspecified) consequences of not allowing qsort() to
> > > determine
> > > the amount of memory in the system.
> > >=20
> > > Delightful.
> >=20
> > For SELinux policy writers the above is a minor issue compared to
> > pythons' shutil.copy2() implementation
> > shutil.copy2 behaves like `cp -a` and copies all of the security
> > attriutes with the file.
> >=20
> > This often causes us to give consumers of shutil.copy2() much broader
> > access than strictly needed
> >=20
> > This is also a problem with `cp -a` (so python is not alone in this).
> > I am not sure how python handles shutil.copy2() but it would be much
> > better for us if it would exclude the MAC security attributes when it
> > copies
> >=20
> > Sort of like shutil.copy2_except_MAC_security_attributes or `cp -a-
> > minus-MAC-security-attributes`
> >=20
> > Consider this:
> >=20
> > some consumer of shutil.copy2 copies /etc/shadow to /tmp/myapp-XXXXX
> > and edits it there.
> >=20
> > Because it copies the security context with /etc/shadow, it later
> > needs to be granted to edit files with the security context for
> > shadow files. Effectively forcing us to allow the process to edit
> > files with the shadow security context
> >=20
> > Whereas if it would have excluded the MAC security contexts when it
> > copied the file, we would have just been forced to allow the process
> > to read file with the shadow file context, and not to write to it
> >=20
> > The above is a little surrealistic example but it is a very common
> > issue in general
> >=20
> > for example pip3 does this all the time and so pip3 processes need
> > much broader access than strictly necessary
>=20
> shutil.copy2 behavior wrt SELinux was previously discussed here:
> http://selinux.tycho.nsa.narkive.com/euegPAIr/copying-setting-security-se=
linux-xattr-explicitly
>=20
> As a counterexample for your proposal, suppose that shutil.copy2()
> defaults to not copying the MAC attributes.  Now a process copies
> /etc/shadow to /tmp/myapp-XXXXX and edits it there.  Since we don't
> copy MAC attributes, the file ends up being labeled with whatever type
> and range transition is defined for the process on /tmp, or defaults to
> that of /tmp.  As a result, the /etc/shadow data is now readable under
> whatever type/range that happens to be, and potentially leaks to
> processes not authorized to read /etc/shadow.
>=20
> Given that shutil.copy2 says that it copies metadata, it makes sense to
> at least try to copy SELinux attributes.  I think the only question is
> what to do in case of failure; the earlier thread proposed ignoring
> EACCES in the same way it already ignores several other errors.
>=20
>=20

Yes that is true, but yes then at least don't fail hard if copying the cont=
exts fails as youve suggested so that we can prevent the ralabel in policy =
and get away with it

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlkQdVcACgkQJXSOVTf5
R2lroAv/YQbXJ+3kRi3XKJjphaFhlvOTVtTtUNtbpgYKg5rXKrx+8E21QfMJiIX0
AkwMwUBVu5s4RWDXwH5CU1HoY/te2RSakidTL5k3NyZnhEncql8ybH1UajsyGM/0
XTjAdmh1V8DLonFP7uoiyWIqVIjj/8ME83cFVtHdk3NhY355eutOdWgIxrwFAlgp
KEvgTFP31CDSyVJwke6SXo7aCMxnUP39z4GUrfMCSt8WkYWMH9k+EDbjz3eIlCD+
2sHDFRN+clxWgrhc2rDWKOK5h3iTD2JTH2vuLkDgwqaWm9UOcmGxgD2R4edG4POF
1VykPNwkujVK9PCqd8h4ChsEfNZL7v8rDEr74pHJbCJ1KuHrbKNkHjgKeqQD5rbt
PbxalQoLQpck8KhjBBvBLzpUA8jLcJZAXAv295T5VpNMnnlndr2OYSfKp96CrmAR
ksBmOFR45Lj/mxZVkcaE6ZAmNBUr3i9Z/s3UYAvV4jOAxMiNQfoOTd25L8FToDmX
6sT1vW3k
=6dS3
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--
