Subject: Re: policyrep questions
From: James Antill <jantill@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1178724555.16433.19.camel@moss-spartans.epoch.ncsc.mil>
References: <1178663380.2379.11.camel@localhost.localdomain>
	 <1178724555.16433.19.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sGub8P4CQlD5Mekq/Abq"
Date: Wed, 09 May 2007 12:34:54 -0400
Message-Id: <1178728494.12294.69.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-sGub8P4CQlD5Mekq/Abq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-05-09 at 11:29 -0400, Stephen Smalley wrote:

> > 4) We assume NULL-terminated strings all over the place - should we be
> > providing apis with length? Alternatively, should we provide a better
> > string object (since we are currently re-inventing the wheel, why not?)=
.
> > We could pull in something like James Antills Vstr library -
> > http://www.and.org/vstr/ (read and be amazed at the diligence of James)=
.
> > It just seems crazy that our apis are not the safest.
>=20
> I'm not clear that tracking length separately is advantageous for these
> APIs.

 I assume you mean "tracking length separately is not advantageous"?

>   What specific advantages would accrue to libsepol from using
> vstr?  What is the cost (incl. dependencies)?

 I'm not sure you need all the power of Vstr, while it certainly
provides a lot of convenience functions that you could use the main
design focus was on IO strings that travel across the network ... not on
lots of small strings in hashtables etc.
 The Vstr lib. itself has no deps.

 However I am convinced that having just char* is not a suitable string
ADT, tracking the length/size separately never works out well from a
bugs POV.
 Also sepol seems to do a _lot_ of comparisons, being able to implement
"eq" as:

 (s1->len =3D=3D s1->len && !memcmp(s1->ptr, s2->ptr, s1->len)

...is a major win.

--=20
James Antill <jantill@redhat.com>

--=-sGub8P4CQlD5Mekq/Abq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGQfgu11eXTEMrxtQRAqndAJ4gCxbfS0/2foxwi7Y0v83JMyJ41wCfXbyP
lotGRp/jo0vs3zuZG/GuPUE=
=3N8O
-----END PGP SIGNATURE-----

--=-sGub8P4CQlD5Mekq/Abq--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
