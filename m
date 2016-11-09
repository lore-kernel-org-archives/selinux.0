Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uA9IIXXA025362
 for <selinux@tycho.nsa.gov>; Wed, 9 Nov 2016 13:18:34 -0500
Received: from workstation.home ([185.34.9.224]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0Lp3x6-1cjOZK3FEC-00eqo7 for
 <selinux@tycho.nsa.gov>; Wed, 09 Nov 2016 19:17:54 +0100
Date: Wed, 9 Nov 2016 18:17:53 +0000
From: Gary Tierney <gary.tierney@gmx.com>
To: selinux@tycho.nsa.gov
Subject: Re: [SECILC] does not seem to filter redundant attributes and rules
Message-ID: <20161109181753.GA14141@workstation.home>
References: <a1c00b1d-c5fd-981e-489a-591f3bff3407@gmail.com>
 <823811d5-d5b2-585e-0ff9-5699768f1e91@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
In-Reply-To: <823811d5-d5b2-585e-0ff9-5699768f1e91@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 09, 2016 at 09:52:35AM -0500, James Carter wrote:
> On 11/09/2016 07:40 AM, Dominick Grift wrote:
> >I am in the process of a DSSP rewrite, taking a different approach this
> >time.
> >
> >However I encountered something that seems suboptimal:
> >
> >SECILC seems to not filter redundant attributes and rules
> >
> >Example i have a type attribute and it has rules associated with it.
> >However, the type attribute is not associated with any types.
> >
> >I was hoping that SECILC would be smart enough to determine that it
> >might as well filter both the type attribute as well as the rules
> >associated with it.
> >
> >To reproduce:
> >
> >git clone https://github.com/DefenSec/dssp1-base.git
> >cd dssp1-base
> >secilc `ls *.cil`
> >sesearch -ASCT -s lib.ld_so.read_files_subj_type_attribute policy.30
> >seinfo -xalib.ld_so.read_files_subj_type_attribute policy.30
> >
> >
> >Am i expecting the impossible by expecting SECILC to be smart enough to
> >determine that something is redundant, and that it can be filtered out
> >until it becomes applicable?
> >
> >
>=20
> I don't think that it would be too hard to remove attributes that have no
> types associated with them along with rules containing those attributes. I
> have this nagging feeling, though, that there is a reason that we didn't =
do
> that. I'll have to think about it a bit.
>=20
> Jim
>

I had a hack 'n' slash attempt at this earlier for just avrules by adding
naive checks in avrule_write (libsepol/src/write.c) to check if both the
source and target type_set bitmaps have a cardinality of 0, though couldn't
help but think I was missing something else.  That didn't work in any case,
and didn't seem like the codepath is ever hit when a CIL policy is
written to disk (maybe it's only module policy avrule_write is called for?).

Any hints on where I can start prodding?  Would be nice to get an idea of h=
ow
the binary policy is serialized too.
>=20
> >
> >_______________________________________________
> >Selinux mailing list
> >Selinux@tycho.nsa.gov
> >To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> >To get help, send an email containing "help" to Selinux-request@tycho.ns=
a.gov.
> >
>=20
>=20
> --=20
> James Carter <jwcart2@tycho.nsa.gov>
> National Security Agency
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa=
=2Egov.

--=20
Gary Tierney

GPG fingerprint: 412C 0EF9 C305 68E6 B660  BDAF 706E D765 85AA 79D8
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x706ED76585AA79D8

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYI2hGAAoJEHBu12WFqnnY2qUIAIgeontGG2u0BJV1jLNlvxpI
oFSSawFRfqXDwgRd3KDjS+RzNk5KXseHkFCnS3WFEAtVYfVDbY3/I0G8zESXHiwS
5eK0jq4D5T/0NZhpNoVUtLmpBZBevxacvfqn8pCG//SLIwhqfq7bm3F/r5YqTXhp
jGKP8oJkKFP53BcDIky9W2CrKbNhRTQOUinAStTZ2SBCMWrDdwDCej7DYUfaTgBh
iTLipMNL9eidK7DnFVcZegYAYP2HA4qbbD0l1JFqRpJnIsA5bTikSQUsGSJF4DhD
2uleLDfb1aFR/56IxZp5b4jvesEFzQkuhqg46bbC2wQpCu9CODQdJgvTRSjh4Tg=
=gM/G
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
