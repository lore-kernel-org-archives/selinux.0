Subject: Re: New rules on restrict kernel module loading
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <CACikiw1N2Cm0gaL2YvHW8738TudyFPgxgJQtZYp8mNOk7bEdCQ@mail.gmail.com>
 <CABXk95C1RzFk3LAJZjjqmmMhQh33qy2AiGgL0wOewr7p==msEg@mail.gmail.com>
 <a9d56ad9-36ba-e1b7-1da4-bbe055ddd1c6@gmail.com>
 <9e898e22-0580-2e1b-4f84-27e63f0ca9b9@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <038286b6-6291-8df5-63d4-f0265bb60778@gmail.com>
Date: Tue, 28 Jun 2016 15:11:16 +0200
MIME-Version: 1.0
In-Reply-To: <9e898e22-0580-2e1b-4f84-27e63f0ca9b9@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UwwNEfHWKxbCkXMalXCXB2UDdMOaRb5D2"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UwwNEfHWKxbCkXMalXCXB2UDdMOaRb5D2
Content-Type: multipart/mixed; boundary="bMgEdxvC2DRnHQt0Fq955NmFrc8qNpOA3"
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Message-ID: <038286b6-6291-8df5-63d4-f0265bb60778@gmail.com>
Subject: Re: New rules on restrict kernel module loading
References: <CACikiw1N2Cm0gaL2YvHW8738TudyFPgxgJQtZYp8mNOk7bEdCQ@mail.gmail.com>
 <CABXk95C1RzFk3LAJZjjqmmMhQh33qy2AiGgL0wOewr7p==msEg@mail.gmail.com>
 <a9d56ad9-36ba-e1b7-1da4-bbe055ddd1c6@gmail.com>
 <9e898e22-0580-2e1b-4f84-27e63f0ca9b9@tycho.nsa.gov>
In-Reply-To: <9e898e22-0580-2e1b-4f84-27e63f0ca9b9@tycho.nsa.gov>

--bMgEdxvC2DRnHQt0Fq955NmFrc8qNpOA3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/28/2016 02:54 PM, Stephen Smalley wrote:
> On 06/28/2016 07:02 AM, Dominick Grift wrote:
>> On 06/22/2016 09:02 PM, Jeffrey Vander Stoep wrote:
>>> selinux@tycho.nsa.gov to bcc
>>>
>>> Hi Ravi,
>>>
>>> The intent is not to restrict which processes may load modules,
>>> but to place restrictions on the origin of the module itself.
>>> Modules, like the kernel, should live on a verity protected
>>> partition.
>>>
>>> If you want system apps to load a kernel module from the system
>>> partition you just need to add an allow rule. e.g.
>>>
>>> # system_app loads /system/lib/module/wlan.ko allow system_app
>>> system_file:system module_load;
>>>
>>> Similar rules may be added for platform_app or system_server.
>>>
>>
>> In Fedora rawhide i see these where the target is "self". example:
>>
>> allow kmod self:system module_load;
>>
>> is that intended?
>=20
> That's the fallback when using init_module() rather than
> finit_module() to load modules, since the kernel does not see the file
> when using init_module().  With init_module(), userspace loads the
> module from the file into memory and passes a (pointer, len) pair to
> the kernel; with finit_module(), userspace opens the module file and
> passes the open file descriptor to the kernel.  Ideally, one would
> convert all users of init_module() to finit_module(), then remove any
> self:system module_load permissions and only allow it for specific
> file types.
>=20

Thanks one final question to make sure i understand this right:

Without the capability sys_module access vector the module_load
permission is "useless". You need both (capability/sys_module plus
system/module_load) to load kernel modules with success?

This is my initial support:

https://github.com/DefenSec/dssp/commit/c877fb7c91d1f404761fed282d88d4001=
2876201

I probably end up leaving this fall back support in. And then add
finit_module() support as the need arises (i have not encountered
finit_module() users yet).

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--bMgEdxvC2DRnHQt0Fq955NmFrc8qNpOA3--

--UwwNEfHWKxbCkXMalXCXB2UDdMOaRb5D2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJXcnd5AAoJECV0jlU3+UdpRdkL+gKZA7MYuPnEAS8dK34foFIh
pnq9Zn68LGI/Lu+Dw1bAWUNB2JwGNNocOpqN+GX0YGQ7dJs44x/4YAPzrTTfbSBg
tv5rh2w1CwzfYtwhW8phw4/TBccrDVevOlSpRcQtZt5NmryjpKi82XMX65rRh12+
dzDli2F1nAFtr7OKc237uuZ8JHaUVY+YfQ6eulqUMbQR5Ynre9vzOEjX4ECSnTVf
r/gxyetLy0FAY6Cwzch8sTzQb7Z2O82HS1hLFG2IA3Lvcc7wodj7+bfKPjZbbW+w
BEA+SOEbzQFz8ecoyhgKsP1OT5cWHdd7ven8QS7q+T4ri8VZuPLztoCjPv0wZKUS
SWUw6QsU2Nm8EqerO2KLrWynrQgrDD6tnBVnhXbpE3A4V3X6qxE5i+EcFUVTm0dw
2cwewWqLAfrQ9M0q4xtqq4V/eiyeYCA6Hkn0NHYHJ1oA1XXOEUl8K+6Hmtlk7UMO
y/sHZ9d1XiHTdNsHaSK32HMS4IOCnZemI4MugyFe7Q==
=HUsh
-----END PGP SIGNATURE-----

--UwwNEfHWKxbCkXMalXCXB2UDdMOaRb5D2--
