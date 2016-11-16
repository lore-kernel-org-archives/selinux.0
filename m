Subject: Re: what is the purpose of security initial sid?
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <61dffb53-5ce0-bde4-9c3e-d40f8eda5efb@gmail.com>
 <20968774-8d14-0843-c3ce-f7658864404b@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <068368d2-6d91-ce5d-7743-cb7a36601432@gmail.com>
Date: Wed, 16 Nov 2016 20:17:03 +0100
MIME-Version: 1.0
In-Reply-To: <20968774-8d14-0843-c3ce-f7658864404b@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QqoaL64xobSxuR23B1CxIsFWijTWL8RMo"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QqoaL64xobSxuR23B1CxIsFWijTWL8RMo
Content-Type: multipart/mixed; boundary="FMn2A1HwV2NJEnE54wqGgFaURfI31HQw8";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Message-ID: <068368d2-6d91-ce5d-7743-cb7a36601432@gmail.com>
Subject: Re: what is the purpose of security initial sid?
References: <61dffb53-5ce0-bde4-9c3e-d40f8eda5efb@gmail.com>
 <20968774-8d14-0843-c3ce-f7658864404b@tycho.nsa.gov>
In-Reply-To: <20968774-8d14-0843-c3ce-f7658864404b@tycho.nsa.gov>

--FMn2A1HwV2NJEnE54wqGgFaURfI31HQw8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/16/2016 07:10 PM, Stephen Smalley wrote:
> On 11/16/2016 12:59 PM, Dominick Grift wrote:
>>
>> I forgot that add the genfscon's for selinuxfs and securityfs and
>> the selinux filesystem ended up associated with the context
>> associated with the unlabeled initial sid.
>>
>> Why did the security initial sid not kick in instead of unlabeled?
>>
>> If the security isid is not there to ensure selinuxfs is labeled=20
>> appropriately then what is it there for?
>=20
> $ grep -r SECINITSID_SECURITY security/selinux
> security/selinux/selinuxfs.c:	return avc_has_perm(sid,
> SECINITSID_SECURITY,
>=20
> It is used as the target/object SID for the permission checks on the
> "security" class performed upon operations on selinuxfs (and
> pre-selinuxfs, it was likewise used for the corresponding permission
> checks on the added SELinux system calls).
>=20
> Could probably make it used as the default for selinuxfs nodes as
> well, but not presently done.
>=20

Thanks that explains a lot and make me wonder whether i should just move
selinuxfs/securityfs out of the "sec" module and into the "fs" module.
After all , its just another fs and not different from any other in that
sense.

Traditionally the security isid context shares the context of the fs in
common policy but I suppose it does not have to be that way

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--FMn2A1HwV2NJEnE54wqGgFaURfI31HQw8--

--QqoaL64xobSxuR23B1CxIsFWijTWL8RMo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYLLCvAAoJECV0jlU3+Udp7vML+gJHHB+Z2Gmwr20EBN+duRvJ
k2f86NAf/SqAIT/jc1VRta+rH71wtZQ7e96a1art9LAdefQC2S7wo/mpCrOr6II+
UNpg31iN4ZP0GtSP012pGD0K7fIaorKa62lnMA1UvZrd4Rrt5YfjlyH1Ltf4YzA7
RQdpJqsruS0spHZG+vBrvp67krQNQNkkloChfGk9kKsW7FqNd1dqmmuL3svt9n9I
IkoKR0SmFtwhLK/g7jF3jGpmQrSZ/NVgk8kG984drmP3h8aZvvVv2SbdymDCS4eF
1u5+ZfCyFq2aVTw+VQkB1jFNCavlE66pkMRUEYkuxCKdCIiHLPLoDYDCMIGOFMhK
88M0qO1vhIBEh5mkit6fAiTj8rZhmN5GNeL5p2RWYYR/Mr3Uom/6lhXTIPIefWMA
xbe0/5gJQGDssClAAYf6kewGX7lvZaP8V+/JYh2o3ZUlpJRbPK41CKVney/bbavO
V9YOxiFhsU0rwJXTF2/oAWqeM8wJm+I/HZmQr4VY6A==
=F3L5
-----END PGP SIGNATURE-----

--QqoaL64xobSxuR23B1CxIsFWijTWL8RMo--
