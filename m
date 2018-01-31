Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w0VKvBAa000655
 for <selinux@tycho.nsa.gov>; Wed, 31 Jan 2018 15:57:11 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC03.oob.disa.mil (Postfix) with SMTP id 3zWwXt44RDzJpBh
 for <selinux@tycho.nsa.gov>; Wed, 31 Jan 2018 20:57:02 +0000 (UTC)
Received: from UPDC3CPA08_EEMSG_MP24.eemsg.mil (unknown [192.168.18.19])
 by UPDCF3IC03.oob.disa.mil (Postfix) with ESMTP id 3zWwXs096LzJpBb
 for <selinux@tycho.nsa.gov>; Wed, 31 Jan 2018 20:57:00 +0000 (UTC)
Received: by mail-wm0-f41.google.com with SMTP id v123so1625281wmd.5
 for <selinux@tycho.nsa.gov>; Wed, 31 Jan 2018 12:56:59 -0800 (PST)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id c5sm10133206ede.30.2018.01.31.12.56.57
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 31 Jan 2018 12:56:57 -0800 (PST)
Date: Wed, 31 Jan 2018 21:56:56 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20180131205656.GA4618@julius.enp8s0.d30>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Subject: CIL: should this work?
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have a template (blockabstract): foo.bar.template

in another module i want to inherit that like this:

(in foo
    (block baz
    (blockinherit bar.template)))

This does not seem to work fully.

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlpyLZQACgkQJXSOVTf5
R2k89Qv/SFMeVElhPJ6Yx+Juav5VZ9aEqu3Dvafr9Z8XqWinttkFKeGIBcimj16i
tbviubgl4O+6wTLBp+6bWduGjBD+dJyJvtCAPtBRrK8RIcyIuLKGLMctEJan/9Xb
H30y+oJTkPtOFFI/n/B4xwVP3pofo3BW/33YEMmP5mjxrz3lTRddUZWX4B3PAT/x
QDDOAsf64cc9U0PqE3gEo5R69HnZsRHE2+sXs79wLiqNrjtYDpZC6yvnD2cFLU3G
ia7BxaJ5b3aAkhjEPNqBaS4vWNYU0JCN3z22Hg5B+9RiVofMKzdcmSGEuH9sF70a
Jy8rT/0ywNgohNe6MTRhvYCRRmnbBUjoHeCO7tKdS5pDdlE3jg/7IiJ64AZE58Im
2TYFxm3NHT6U3Ohv4987/RnNDJ+S5wNTAE30eNSnocgIYXteKEkpfcRF56rU57U/
zJ9ry2574mF4rRLLAu7foeEejxY70qVg5WB+Da0XZNA6e02nUn5e1pso3NLhXJc2
ba9Dcw0U
=xlqd
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
