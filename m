Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6N7Eu1T007786
 for <selinux@tycho.nsa.gov>; Thu, 23 Jul 2015 03:14:56 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 by mx1.redhat.com (Postfix) with ESMTPS id 4972691EA7
 for <selinux@tycho.nsa.gov>; Thu, 23 Jul 2015 07:14:53 +0000 (UTC)
Received: from hulk.w.lan (dhcp-10-40-3-129.brq.redhat.com [10.40.3.129])
 by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 t6N7Epi2012942
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
 for <selinux@tycho.nsa.gov>; Thu, 23 Jul 2015 03:14:52 -0400
Subject: Re: [GIT PULL] policycoreutils: fix PEP8 issues
To: selinux@tycho.nsa.gov
References: <20150717142834.GA20679@meriadoc.Home>
 <55AF977C.9020705@tycho.nsa.gov>
 <20150722143111.GA20676@meriadoc.perfinion.com>
 <55AFAAD5.80108@tycho.nsa.gov>
From: Petr Lautrbach <plautrba@redhat.com>
Message-ID: <55B09467.6030807@redhat.com>
Date: Thu, 23 Jul 2015 09:14:47 +0200
MIME-Version: 1.0
In-Reply-To: <55AFAAD5.80108@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PwEGQwBohkmoqe2gH2kbpsGEHOpnjHIla"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PwEGQwBohkmoqe2gH2kbpsGEHOpnjHIla
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 07/22/2015 04:38 PM, Stephen Smalley wrote:
> On 07/22/2015 10:31 AM, Jason Zaman wrote:
>> On Wed, Jul 22, 2015 at 09:15:40AM -0400, Stephen Smalley wrote:
>>> On 07/17/2015 10:28 AM, Jason Zaman wrote:
>>>> Commit message:
>>>>
>>>>     policycoreutils: Fix PEP8 issues
>>>>
>>>>     When trying to get policycoreutils working in python3, I kept ru=
nning
>>>>     into TabErrors:
>>>>
>>>>         Traceback (most recent call last):
>>>>           File "/usr/lib/python-exec/python3.3/semanage", line 27, i=
n <module>
>>>>             import seobject
>>>>           File "/usr/lib64/python3.3/site-packages/seobject.py", lin=
e 154
>>>>             context =3D "%s%s" % (filler, raw)
>>>>                                            ^
>>>>         TabError: inconsistent use of tabs and spaces in indentation=

>>>>
>>>>     Python3 is a lot stricter than python2 regarding whitespace and =
looks like
>>>>     previous commits mixed the two.  When fixing this, I took the ch=
ance to fix
>>>>     other PEP8 style issues at the same time.
>>>>
>>>>     This commit was made using:
>>>>     $ file $(find . -type f) | grep -i python > pyfiles
>>>>     $ autopep8 --in-place --ignore=3DE501,E265 $(cat pyfiles)
>>>>
>>>>     The ignore E501 is long lines since there are many that would be=
 wrapped
>>>>     otherwise, and E265 is block comments that start with ## instead=
 of just #.
>>>
>>> If this was generated entirely via autopep8, I'd prefer to take this
>>> other patch series first:
>>> http://marc.info/?l=3Dselinux&m=3D143743932419386&w=3D2
>>> as it will be easier to redo the autopep8 on top than the other way a=
round.
>>
>> Yes it was 100% automated, I can re-generate it now that those have be=
en
>> applied or I can wait till a bit later once the semanage.py fixes are =
in
>> or you could just run it yourself and commit it. which would you prefe=
r?
>>
>> The important part will be to make sure that all commits afterwards ar=
e
>> also following pep8.
>=20
> I'll ask if Red Hat has any other patches they care to submit for
> policycoreutils python code before performing the conversion.
>=20
>=20

I'm just looking into it.

=46rom the top of my head there should be only one other patch in Fedora
which makes a python module seobject/__init__.py from seobject.py for
python3. Other changes are either indentation fixes or should be already
covered by patches sent by my colleagues few days ago.

I hope I'll provide a relevant patch set today.


Petr
--=20
Petr Lautrbach



--PwEGQwBohkmoqe2gH2kbpsGEHOpnjHIla
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVsJRqAAoJEGOorUuYLENzODsQALfu1hN4PH3h2Lwc20Et2WwG
NaGlDPAZFvPIoZ1S3bbalJWrphtraS9PLBgAwmNd3ERZ9pgKldcFgDP41WcoF61o
xOhxDqwVKCgW3pwzaDmue7fg9+c9WWGrCb9AlzXWvlXW5fVU0N0fG7MznS5NxpNq
x2itxIUuYX9XKxYwUJTzTFVRhgpFucmT+/5cdNI9ImdrwckDdxPFc9onLkn6oo2o
OUDkQDoOiEh8SSTGWihFOUByTih5Su5y8quuPgfA6VBWZaUnuV6fFc0GINco6zUj
V9JxMukqjz7w5VCmA0I9fhR0tO5fCyaLuQU1VZ47RKq3JU8nQo5+xYgcpLx2yfE6
rLCIuxflsVmoBCAluboNiwwwhNpe2ynotp+M5eB0wUIIe74XLCv34AlQ3smIwYcA
Fqv/rizk4xoQpJfxT+89NLQyRtqCpm0fme0B5WJHqEfm10faX5PcXFS0Q8n6Rtyf
77+WFrBsxsEVCVxooJBXTo4MRuPVwen2TqjtUJyZOT89CUzVJwW5qAZkDhvlNZ4L
aia+xQg5vEk7ruxw4UeCoW0oYr6bqSUQGop+7tiKFGsQKaC/xWKQwo52Pr3PJDKb
XXyiWL3N46UGNeor2O0MkJYKnFWr5MYhRXxXVHoZ55AFvMjiitr45Tx8eBgatBf6
WcBcg1/kxcL81vQOFwCY
=WOFp
-----END PGP SIGNATURE-----

--PwEGQwBohkmoqe2gH2kbpsGEHOpnjHIla--
