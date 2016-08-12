Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7CEMtXL025020
 for <selinux@tycho.nsa.gov>; Fri, 12 Aug 2016 10:22:55 -0400
Received: by mail-wm0-f67.google.com with SMTP id q128so3140348wma.1
 for <selinux@tycho.nsa.gov>; Fri, 12 Aug 2016 07:22:28 -0700 (PDT)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id s184sm2809319wmb.11.2016.08.12.07.22.25
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Aug 2016 07:22:26 -0700 (PDT)
Subject: Re: [PATCH] semanage: correct fcontext auditing
To: selinux@tycho.nsa.gov
References: <1471010236-27524-1-git-send-email-mvadkert@redhat.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <cd0a96df-5daf-8231-d57e-4be544c923a0@gmail.com>
Date: Fri, 12 Aug 2016 16:22:14 +0200
MIME-Version: 1.0
In-Reply-To: <1471010236-27524-1-git-send-email-mvadkert@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kjhw3MonIq5e1Hv4NHo0Qe89B5q3OKaje"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kjhw3MonIq5e1Hv4NHo0Qe89B5q3OKaje
Content-Type: multipart/mixed; boundary="MRRMCDQfLLHCgqvRDLHbVmkqLpN57uasr"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <cd0a96df-5daf-8231-d57e-4be544c923a0@gmail.com>
Subject: Re: [PATCH] semanage: correct fcontext auditing
References: <1471010236-27524-1-git-send-email-mvadkert@redhat.com>
In-Reply-To: <1471010236-27524-1-git-send-email-mvadkert@redhat.com>

--MRRMCDQfLLHCgqvRDLHbVmkqLpN57uasr
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 08/12/2016 03:57 PM, Miroslav Vadkerti wrote:
> For modify action actually audit the selinux type, i.e. use setype
> variable.
>=20
> For deleting equal fcontext rules do not audit ftype, as the ftype valu=
e
> for equal rules makes little sense.
>=20
> Signed-off-by: Miroslav Vadkerti <mvadkert@redhat.com>
> ---
>  policycoreutils/semanage/seobject.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/sem=
anage/seobject.py
> index 786ed0e..8d3088c 100644
> --- a/policycoreutils/semanage/seobject.py
> +++ b/policycoreutils/semanage/seobject.py
> @@ -1992,7 +1992,7 @@ class fcontextRecords(semanageRecords):
>          if not seuser:
>              seuser =3D "system_u"

system_u is reference policy specific. this is selinux user space not
reference policy user space.

> =20
> -        self.mylog.log_change("resrc=3Dfcontext op=3Dmodify %s ftype=3D=
%s tcontext=3D%s:%s:%s:%s" % (audit.audit_encode_nv_string("tglob", targe=
t, 0), ftype_to_audit[ftype], seuser, "object_r", type, serange))
> +        self.mylog.log_change("resrc=3Dfcontext op=3Dmodify %s ftype=3D=
%s tcontext=3D%s:%s:%s:%s" % (audit.audit_encode_nv_string("tglob", targe=
t, 0), ftype_to_audit[ftype], seuser, "object_r", setype, serange))
> =20
>      def modify(self, target, setype, ftype, serange, seuser):
>          self.begin()
> @@ -2030,7 +2030,7 @@ class fcontextRecords(semanageRecords):
>              self.equiv.pop(target)
>              self.equal_ind =3D True
> =20
> -            self.mylog.log_change("resrc=3Dfcontext op=3Ddelete-equal =
%s ftype=3D%s" % (audit.audit_encode_nv_string("tglob", target, 0), ftype=
_to_audit[ftype]))
> +            self.mylog.log_change("resrc=3Dfcontext op=3Ddelete-equal =
%s" % (audit.audit_encode_nv_string("tglob", target, 0)))
> =20
>              return
> =20
>=20


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--MRRMCDQfLLHCgqvRDLHbVmkqLpN57uasr--

--kjhw3MonIq5e1Hv4NHo0Qe89B5q3OKaje
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJXrdudAAoJECV0jlU3+UdpUVoL/3cASbyoiLDarCXFUiJwibGH
fv+QiKP/Fqq1yp0hYA6zIvqH9024/ei2QFTSZ2ThVfS9RmRoGx3ojhmz6cxcXJAo
fLrmiENnCiT/KXURNQjs5a93BSKl/CbMA68ZjhW5IbR/TX6/E+cNV/2zox8S3HFo
6mz3nbcqreV6vt2mIpANE7bhqSbqjZLzIx0t+8yTvhvrLt+V1mhL3DH2RyJVHE4q
MPb8rAztYAiu9jgPoS1+egGkXW9ky775OwFIeulDpbXlQVc+PzwrIHnbhQY45v7n
QtstZMmPkDpWKeYJuCQaTlXHaFv3gzuX8Q8tsldGSeOozLg12LEhkl7xllJoxkF1
1+rj31KVNbTRbWJNN9Rb3xSEeOCFDDJLaAH2p3fGGXkmQbXPl8IQ1Atv9qXpg2+d
UXHQQh1GF6fXl4WOGdI2KtoOYgpbzfH/LZIJSiIOEHQb2whBkLEVJSGTAyX+nnTf
Jqk0N8585dmnqPaflyzCPUnC9ZZmfta+Syl0g+xGPg==
=jlC3
-----END PGP SIGNATURE-----

--kjhw3MonIq5e1Hv4NHo0Qe89B5q3OKaje--
