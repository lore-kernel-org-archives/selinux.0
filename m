Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6O7hlec008110
 for <selinux@tycho.nsa.gov>; Fri, 24 Jul 2015 03:43:47 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
 (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
 by mx1.redhat.com (Postfix) with ESMTPS id D8112AC842
 for <selinux@tycho.nsa.gov>; Fri, 24 Jul 2015 07:43:44 +0000 (UTC)
Received: from hulk.w.lan (dhcp-10-40-3-129.brq.redhat.com [10.40.3.129])
 by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 t6O7hh3S032377
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
 for <selinux@tycho.nsa.gov>; Fri, 24 Jul 2015 03:43:44 -0400
Subject: Re: [GIT PULL] policycoreutils: fix PEP8 issues
To: selinux@tycho.nsa.gov
References: <20150717142834.GA20679@meriadoc.Home>
 <55AF977C.9020705@tycho.nsa.gov>
 <20150722143111.GA20676@meriadoc.perfinion.com>
 <55AFAAD5.80108@tycho.nsa.gov> <55B09467.6030807@redhat.com>
From: Petr Lautrbach <plautrba@redhat.com>
Message-ID: <55B1ECAE.7000905@redhat.com>
Date: Fri, 24 Jul 2015 09:43:42 +0200
MIME-Version: 1.0
In-Reply-To: <55B09467.6030807@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RsOoumnjAhIqsmVaUIRoqfqIM1jlpgIjG"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RsOoumnjAhIqsmVaUIRoqfqIM1jlpgIjG
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 07/23/2015 09:14 AM, Petr Lautrbach wrote:
> On 07/22/2015 04:38 PM, Stephen Smalley wrote:
>> On 07/22/2015 10:31 AM, Jason Zaman wrote:
>>> On Wed, Jul 22, 2015 at 09:15:40AM -0400, Stephen Smalley wrote:
>>>> On 07/17/2015 10:28 AM, Jason Zaman wrote:
>>>>> Commit message:
>>>>>
>>>>>     policycoreutils: Fix PEP8 issues
>>>>>
>>>>>     When trying to get policycoreutils working in python3, I kept r=
unning
>>>>>     into TabErrors:
>>>>>
>>>>>         Traceback (most recent call last):
>>>>>           File "/usr/lib/python-exec/python3.3/semanage", line 27, =
in <module>
>>>>>             import seobject
>>>>>           File "/usr/lib64/python3.3/site-packages/seobject.py", li=
ne 154
>>>>>             context =3D "%s%s" % (filler, raw)
>>>>>                                            ^
>>>>>         TabError: inconsistent use of tabs and spaces in indentatio=
n
>>>>>
>>>>>     Python3 is a lot stricter than python2 regarding whitespace and=
 looks like
>>>>>     previous commits mixed the two.  When fixing this, I took the c=
hance to fix
>>>>>     other PEP8 style issues at the same time.
>>>>>
>>>>>     This commit was made using:
>>>>>     $ file $(find . -type f) | grep -i python > pyfiles
>>>>>     $ autopep8 --in-place --ignore=3DE501,E265 $(cat pyfiles)
>>>>>
>>>>>     The ignore E501 is long lines since there are many that would b=
e wrapped
>>>>>     otherwise, and E265 is block comments that start with ## instea=
d of just #.
>>>>
>>>> If this was generated entirely via autopep8, I'd prefer to take this=

>>>> other patch series first:
>>>> http://marc.info/?l=3Dselinux&m=3D143743932419386&w=3D2
>>>> as it will be easier to redo the autopep8 on top than the other way =
around.
>>>
>>> Yes it was 100% automated, I can re-generate it now that those have b=
een
>>> applied or I can wait till a bit later once the semanage.py fixes are=
 in
>>> or you could just run it yourself and commit it. which would you pref=
er?
>>>
>>> The important part will be to make sure that all commits afterwards a=
re
>>> also following pep8.
>>
>> I'll ask if Red Hat has any other patches they care to submit for
>> policycoreutils python code before performing the conversion.
>>
>>
>=20
> I'm just looking into it.
>=20
> From the top of my head there should be only one other patch in Fedora
> which makes a python module seobject/__init__.py from seobject.py for
> python3. Other changes are either indentation fixes or should be alread=
y
> covered by patches sent by my colleagues few days ago.
>=20
> I hope I'll provide a relevant patch set today.

It seems that there's only seobject.py which needs to be ported to
python 3. I would start with the indent conversion as it's needed anyway
and then we could provide a patch with python 3 support based on this
conversion.

Petr
--=20
Petr Lautrbach



--RsOoumnjAhIqsmVaUIRoqfqIM1jlpgIjG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVseyuAAoJEGOorUuYLENzOswP+wURcyTAB3yLLrYroneY0Dw5
hHYO851Ii2Rg7vMNyON89/gtN1bXAzej/hVIGrQcYdZHONx+/NNQS9ElZUtKLFIr
NrorBonFP46rxPvHKWyV1q6aW6/cnkAf0Q495WEtBDGUprC+w1lHPpuqK41hGI2t
QUxc+sxPjY3sf70JesSN1UHrTwUgsV6oUR07csvR/AxUGL4M8+JLVuvNbn+FRPuS
LC/1ktWwJB8iY1kF+8qnOB5u7Ds6LC8ZT17F7OSxwufOYK2nDhZfbodA9tJnMO1b
ahD75Wdwhq5YF03YAPrhkldiKtpkimoQNUGU7CHFqx1O8YZNrycvrQY2p3Z5GkMs
TAQR8GLAJhCK7TCEGIpWOAOqc3xZSyl5du/9FvJS8tkjKjg13bx5HZwJGIVxtOQx
eiWOBfcBapdOrUbAm5vvTaU2Z5t7KtVs1Qtl/3J035oV7xw98zhLNlMhHItik5DJ
K7dU4byOq/cVzHnvGtlHAjpiCF2thYUkUzQilbtRoyGzZv/Mgq1uhi9Owsy32B+4
fI174eyYybal8AquG6rrAJCnekmgECxBXeNS5IZq3W7rVolFNQuloZvPjg0QNNNC
J7iFHUTkHbSyXIL4/2Gtf1wgGjue0jKU2cNAkI6+RLAXtcDLT3Rk2JF33XC6ewAm
KCFtrtcTkq7auleMXOfq
=ogS+
-----END PGP SIGNATURE-----

--RsOoumnjAhIqsmVaUIRoqfqIM1jlpgIjG--
