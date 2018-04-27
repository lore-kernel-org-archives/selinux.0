Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w3RKD7j7016051
 for <selinux@tycho.nsa.gov>; Fri, 27 Apr 2018 16:13:07 -0400
Received: by mail-wm0-f50.google.com with SMTP id a137so2229430wme.1
 for <selinux@tycho.nsa.gov>; Fri, 27 Apr 2018 07:53:43 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id c15-v6sm929489edr.78.2018.04.27.07.53.41
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 27 Apr 2018 07:53:41 -0700 (PDT)
Date: Fri, 27 Apr 2018 16:53:40 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20180427145340.GA24673@julius.enp8s0.d30>
References: <CAJ9kUZ=afxguhDWvttDf6ws-wH=dNcvTT_5s1XU8b-xD7b9-kw@mail.gmail.com>
 <d893d3fd-b5cf-f959-7de2-3adbedd773f4@tycho.nsa.gov>
 <CAJ9kUZ=Bzzbs=VVP65XwaiMv1aVy=mAeRunKbPTLrM51iXvVUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
In-Reply-To: <CAJ9kUZ=Bzzbs=VVP65XwaiMv1aVy=mAeRunKbPTLrM51iXvVUQ@mail.gmail.com>
Subject: Re: Loopback TCP connection
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 27, 2018 at 04:42:56PM +0200, Troels Arvin wrote:
> Hello,
>=20
> On Fri, Apr 27, 2018 at 4:31 PM, Stephen Smalley <sds@tycho.nsa.gov> wrot=
e:
>=20
> > See:
> > https://github.com/SELinuxProject/selinux-kernel/issues/21
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D1168044
> >
>=20
> OK. So currently, it's not possible to write a policy item which allows
> connections to sockets on the loopback interface only.
>=20
> In that case, I'll work on a patch proposal for a boolean to activate thi=
s:
>   allow tomcat_t smtp_port_t:tcp_socket name_connect;

I think it should be possible to control egress/ingress on labeled interfac=
es

>=20
> --=20
> Regards,
> Troels Arvin

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlrjOW8ACgkQJXSOVTf5
R2mb2AwAm3YA51gWo/rrtiZbN39jeak3HxiTNX7ftgVu1kb3+QMJCBRjNAtZDS1x
304ArPguuxUvRFE9cLHrYo+CvvVwJGkvhgZClWs3FnlgMhlMjr1p5l3aX+RNCchT
iXCvxStPIu6J15h4bFkPXsU9wb1FTSBuVFR4V1fU0wpaop0aFRdUgHNXVjsVrBY+
orcO70hZ5ULTCtLWtCWCmYlNrpqdP9t4/dXAfZ86tq94HNODFrwhuyl+t+/gH8PN
J2TLWgkpssJ3PUi/JlKv3CLNq3GIincML2QNUXqdiv27GsS5EL3BStxMF3X3kuVX
qPlpXtEuYJt+7e5cZLOgQXzPQI5EpyNRkPum9Uoed7PJAxDdcisUzZE0qpjb+TZ6
+B8AmbuMg/80XO9N35W4E7KXrtvNeWGTxJROs+S6XfGvikMwuxCOOTmf7RH1vGQf
kfgVODuzJCpvYNJ8Bv+0x9YQkig+5g/duS+JjDv4vc4gMAG+04y5ACPq+kO+jf06
UPa7Jjt2
=XQxR
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
