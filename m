Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t69AnA37026279
 for <selinux@tycho.nsa.gov>; Thu, 9 Jul 2015 06:49:10 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (Postfix) with ESMTPS id 4A5F9319837
 for <selinux@tycho.nsa.gov>; Thu,  9 Jul 2015 10:49:08 +0000 (UTC)
Received: from hulk.w.lan (dhcp-10-40-2-179.brq.redhat.com [10.40.2.179])
 by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 t69An6aA004102
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
 for <selinux@tycho.nsa.gov>; Thu, 9 Jul 2015 06:49:07 -0400
Subject: Re: [PATCH] Fix typo in semanage args for minimum policy store
To: selinux@tycho.nsa.gov
References: <1436429776-32450-1-git-send-email-plautrba@redhat.com>
 <20150709100450.GA20638@x250>
From: Petr Lautrbach <plautrba@redhat.com>
Message-ID: <559E519D.4060800@redhat.com>
Date: Thu, 9 Jul 2015 12:49:01 +0200
MIME-Version: 1.0
In-Reply-To: <20150709100450.GA20638@x250>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2Rp9BgL7rXKDHiB3A0bne2r8TaK8lIAkm"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2Rp9BgL7rXKDHiB3A0bne2r8TaK8lIAkm
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Dne 9.7.2015 v 12:04 Dominick Grift napsal(a):
> On Thu, Jul 09, 2015 at 10:16:16AM +0200, Petr Lautrbach wrote:
>> ---
>>  policycoreutils/semanage/semanage | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/policycoreutils/semanage/semanage b/policycoreutils/seman=
age/semanage
>> index dd63010..dd1010a 100644
>> --- a/policycoreutils/semanage/semanage
>> +++ b/policycoreutils/semanage/semanage
>> @@ -788,7 +788,7 @@ def createCommandParser():
>> =20
>>  def make_io_args(args):
>>      # import/export backward compability
>> -    args_origin =3D ["-S", "-o", "-i", "targeted", "minumum", "mls"]
>> +    args_origin =3D ["-S", "-o", "-i", "targeted", "minimum", "mls"]
>=20
> Hard coding policy models is not very user friendly. Besides the minimu=
m policy model is fedora specific.
>=20

You are right. The patch just fixes the typo which makes it unusable
even on Fedora.


Petr
--=20
Petr Lautrbach



--2Rp9BgL7rXKDHiB3A0bne2r8TaK8lIAkm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVnlGdAAoJEGOorUuYLENzxb0QAKT4wdkG7TxJ5IaOtgw90CMk
Ag59uQjjJFS91dufp+rruoMvLDsxApylQPdHew9EgmJs8NEcGl02DaPEFnSsm4hE
HPTiUiAmSgJDTiqEQKnQnpcFiCZrkHDdPsZXfM7YH66/HE4K0fjeLCDgSu5KDSLP
1TS+/6LMSkCiXY08KPYxDvLEOoEsbxQnYa4795YrPh7KMNVxejzjCmcC9djhgk6W
zCIEO3NpXdh11aia3RVLd03H8u7uOUXkGJ8IRj5kPwFWNGAobYndvNY6tAneo4uB
2iz2C1Y9/Ui78jO0e4VnKXFSMvAG/lyptHT6305pAjchyW6NK2ZA9hW9cAAJJoRy
3a3Em3lm07Wm4lqLBkVET8n5fSWymzUQygF5BsSBG5PJaYq0zH/e3lgJ2SM7oIyf
GGoE9HjsQyArBggxgFG+WfQj2AnBrpKAXiI8gbTBf2LVH0xukmeYMN3W3g2lBar7
I2EYGy+3pS1PXEaQAOkV5tCAlRR/aIU4V3H959VbxCBd+S01EzcvzmwasQOg3zAj
IGIdzBS0Tfq0xnGK/d8PUD0BhqEAvN6BuPmIJh4zxTyos+P9ofRMe9tO6uKnSbCv
q9cSr/5oxk33IafcyljT2pCxk+9KO2tnJSL7JtKVV2pjIxW6uCuXZMIP/WmxnJl+
UE6ESjhud9Drx5GfbWXn
=cBct
-----END PGP SIGNATURE-----

--2Rp9BgL7rXKDHiB3A0bne2r8TaK8lIAkm--
