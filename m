Subject: Re: New rules on restrict kernel module loading
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <CACikiw1N2Cm0gaL2YvHW8738TudyFPgxgJQtZYp8mNOk7bEdCQ@mail.gmail.com>
 <CABXk95C1RzFk3LAJZjjqmmMhQh33qy2AiGgL0wOewr7p==msEg@mail.gmail.com>
 <a9d56ad9-36ba-e1b7-1da4-bbe055ddd1c6@gmail.com>
 <9e898e22-0580-2e1b-4f84-27e63f0ca9b9@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <93f091ed-6a9c-b582-6717-e124bff190d6@gmail.com>
Date: Wed, 29 Jun 2016 11:36:10 +0200
MIME-Version: 1.0
In-Reply-To: <9e898e22-0580-2e1b-4f84-27e63f0ca9b9@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MpmJMkveKthGddLrB7eFprh1GmhWnGXxo"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MpmJMkveKthGddLrB7eFprh1GmhWnGXxo
Content-Type: multipart/mixed; boundary="iv8wFD30aSQ3QQ6k23jbIVNT9oNV5sg1k"
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Message-ID: <93f091ed-6a9c-b582-6717-e124bff190d6@gmail.com>
Subject: Re: New rules on restrict kernel module loading
References: <CACikiw1N2Cm0gaL2YvHW8738TudyFPgxgJQtZYp8mNOk7bEdCQ@mail.gmail.com>
 <CABXk95C1RzFk3LAJZjjqmmMhQh33qy2AiGgL0wOewr7p==msEg@mail.gmail.com>
 <a9d56ad9-36ba-e1b7-1da4-bbe055ddd1c6@gmail.com>
 <9e898e22-0580-2e1b-4f84-27e63f0ca9b9@tycho.nsa.gov>
In-Reply-To: <9e898e22-0580-2e1b-4f84-27e63f0ca9b9@tycho.nsa.gov>

--iv8wFD30aSQ3QQ6k23jbIVNT9oNV5sg1k
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

I suspect that something is broken here then (although i might be wrong)

systemd-udevd seems to be using finit_module() but selinux still checks
"self" instead of a module file type. (whereas i would have expected the
latter)

I see that there is no selinux test-suite test implemented for this
functionality.

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--iv8wFD30aSQ3QQ6k23jbIVNT9oNV5sg1k--

--MpmJMkveKthGddLrB7eFprh1GmhWnGXxo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJXc5aOAAoJECV0jlU3+UdpbmIL/iw+HK0ZpNyz2btExQ5JDk5j
mnebIlzXO/MZmNSZCjDdgVjlEzL/JPvAWhSVIwM1Xw+d68QBJRcIbt/GeF2loN21
Wzlv8zeFzPv11mvt5Tv/ECWq8ZJOb4+2iixMuifyfwzmub5E7Y4n9hiVIvdxS9Ed
V8Y/icB263AQXmXZhM+8Yr0dtWLiSVWMnN3SEQUyE5eVUu6N9aMP4zXcppFA946A
5687Vss2x8klPzebrzuV5XE9mWbrrN3UJj8XqA7LUGHNzWx+bpc5Hc37eP7bNjx5
5AnKzpCI34XoDg0LtrDj/bDLGvMl0C23T6Ho6jYXAOf6+hJ+KGcC1reFqF1nNu0I
/BnIjAGVHWeeCeUW3Ajc6MrLLt73FkW7caheA3BCkxxBJpl3XsQTioZQamfuxa8J
BcCOINt0aeKxU4jHFqpUaj0DkLzZ/MeknZrJaFj37aIt9MHDmsSmar589RkuU1RI
fIv217P+wbk97Ly0tTsaEKGnbaJS0Xr0mxNJsKbCEA==
=gJQk
-----END PGP SIGNATURE-----

--MpmJMkveKthGddLrB7eFprh1GmhWnGXxo--
