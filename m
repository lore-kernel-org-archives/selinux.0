Message-ID: <55520DB7.3080605@redhat.com>
Date: Tue, 12 May 2015 16:27:03 +0200
From: Petr Lautrbach <plautrba@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: is_selinux_enabled(): drop no-policy-loaded
 test.
References: <1429278141-7728-1-git-send-email-sds@tycho.nsa.gov>
 <5550B134.6050606@redhat.com> <5550B1FE.5040304@tycho.nsa.gov>
 <5550B368.5020600@redhat.com> <5550B663.1070000@tycho.nsa.gov>
 <5550B6D4.4070002@tycho.nsa.gov> <5550B899.7060603@redhat.com>
 <5550C212.6090702@tycho.nsa.gov> <5551F7F4.5050907@redhat.com>
 <5551F886.40100@tycho.nsa.gov> <55520569.8030306@redhat.com>
 <55520757.8080509@tycho.nsa.gov>
In-Reply-To: <55520757.8080509@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nOrF3qHGFuBP0FQFfhgMaK1rheu2msTeB"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nOrF3qHGFuBP0FQFfhgMaK1rheu2msTeB
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 05/12/2015 03:59 PM, Stephen Smalley wrote:
> On 05/12/2015 09:51 AM, Petr Lautrbach wrote:
>> On 05/12/2015 02:56 PM, Stephen Smalley wrote:
>>> BTW, in trying to test these scenarios, I did a yum remove
>>> selinux-policy-targeted at one point and was surprised to find that I=

>>> couldn't subsequently do a yum install selinux-policy-targeted.  It
>>> would always fail.  Ultimately I found that if I created an empty
>>> /etc/selinux/targeted/contexts/files/file_contexts file and then trie=
d
>>> installing it, it would work.  So I guess rpm -i fails if there is no=

>>> file_contexts file?  That doesn't seem right.
>>>
>>
>> That's correct. rpm does a verification of a transaction and one of th=
e
>> steps is to check files labels. It uses selinux_file_context_path() to=

>> get a file path and if it can't open this file, it fails as it can't
>> confirm whether contexts are ok or not. Empty file_contexts file means=

>> that there's no conflict.
>>
>> If you want to skip this check, you can use:
>>
>> rpm -i --nocontexts ...
>> or
>> yum install --setopt=3Dtsflags=3Dnocontexts
>>
>> or just reboot and install selinux-policy-targeted with disabled SELin=
ux.
>=20
> But it seems wrong that it fails silently, with no indication to the
> user what went wrong or how to fix it.
>=20
> # yum remove selinux-policy-targeted
> ...
> # yum install selinux-policy-targeted
> ...
> Running transaction check
> Running transaction test
> Transaction test succeeded
> Running transaction (shutdown inhibited)
> selinux-policy-targeted-3.13.1-105.13.fc21.noarch was supposed to be
> installed but is not!
>   Verifying  : selinux-policy-targeted-3.13.1-105.13.fc21.noarch
>     1/1
>   Verifying  : selinux-policy-targeted-3.13.1-105.13.fc21.noarch
>     2/1
>=20
> Failed:
>   selinux-policy-targeted.noarch 0:3.13.1-105.13.fc21
>=20
>=20
> Complete!
>=20
> # yumdownloader selinux-policy-targeted
> # rpm -i selinux-policy-targeted-3.13.1-105.13.fc21.noarch.rpm
> # echo $?
> 1
> # rpm -q selinux-policy-targeted
> package selinux-policy-targeted is not installed
>=20

I've filed a bug about it -
https://bugzilla.redhat.com/show_bug.cgi?id=3D1220822

Thanks,

Petr
--=20
Petr Lautrbach
SELinux Solutions
Red Hat

Better technology. Faster innovation. Powered by community collaboration.=

See how it works at redhat.com.


--nOrF3qHGFuBP0FQFfhgMaK1rheu2msTeB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVUg23AAoJEGOorUuYLENzm2YP/3BnroHK/EDSs+QfJxHU1vnw
LY3qrIU/i6/5aW0Gf+ZRFWMFHH5UwtPT23uPkFryp8L4JSwR1Ic0lFzFsXJcwJ59
+VgHNIXoZgqMqBJQ/zJuJ8Yod6lemwcgT4ztFOx6UflgdSeWK47hRZFM62CgHZkw
dqOMYsHxzVv2nrFPLn1XVrWUy8rp3FeoywJFTqpflRCRK0vZPk3LS2Lty/0Qe1P8
Oqs7KK2GMwE+lWKU+JFps+N+TNw/OdPaqngpYDSxwpjNn1bZ9p2jqU0T4xPv24qD
9S9MURcOqNutcJpBrrCWkhHKEbkK9xvXB/EMXSebqCaL5o8eX8hvVh39aqsdoE+g
uFGfDCp8RXirkQmW6I9XMdg2duwJ9bJsXVZ5PtKZxsaLlP80qkeOGWFWEuwLu2IW
38UN1/Y8/lgtzthABWHU9S0DW43RaevlvdmuQpt8yMxSLvA+SXWV5Wy/5lfltOXZ
a1VWdMAe7pZPimV+NlR9ba/uFeiHbR9J0q7Qsq4GnSAkD3GufTDlwrqYRF9t/NJj
ZMAeXtzXQFKqu9eQBmEGVo8RdN83nclG2cJ0tu7xBtD66f97mnbJ8m1eiJIpPaBE
WIqmvNR1nVsAHQ7yDP9D3YxFmKvuiOKfQhluOKog7cfpfnm9PW08HBHdubiLITs8
h1J8FbMOZozYy6Kia+UC
=4yqg
-----END PGP SIGNATURE-----

--nOrF3qHGFuBP0FQFfhgMaK1rheu2msTeB--
