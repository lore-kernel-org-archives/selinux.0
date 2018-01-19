Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w0JAJx19008024
 for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2018 05:19:59 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC16.oob.disa.mil (Postfix) with SMTP id 3zNGzJ73cqz2VpdS
 for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2018 10:19:56 +0000 (UTC)
Received: from UPBD19PA11.eemsg.mil (unknown [192.168.18.17])
 by UPDCF3IC16.oob.disa.mil (Postfix) with ESMTP id 3zNGzH2G7Xz2VpBS
 for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2018 10:19:55 +0000 (UTC)
Received: by mail-wm0-f50.google.com with SMTP id v123so2433668wmd.5
 for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2018 02:19:54 -0800 (PST)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id o26sm3132352edi.18.2018.01.19.02.19.52
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 19 Jan 2018 02:19:53 -0800 (PST)
Date: Fri, 19 Jan 2018 11:19:51 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20180119101951.GA4126@julius.enp8s0.d30>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Subject: default_type limitations
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The default_type functionality is too limited because it assumes that all l=
ogin programs associate the same type with a given role

This is not the case

For example:

default_type for local_login: joe.role:joe.type
default_type for sshd: joe.role:joe_ssh_server.type
default_type for cockpit joe.role:joe_cockpit_bridge.type

etc

So pam_selinux "select_context" can only support a single login program due=
 to this

I do not understand why default_type is needed in the first place. The cont=
exts/users/ file is more specific:

/etc/selinux/TYPE/contexts/users/joe.user:
sys.role:login.type:s0 joe.role:joe.type:s0 joe1.role:joe1.type:s0
sys.role:sshd.type:s0 joe.role:joe_ssh_server.type:s0 joe1.role:joe1_ssh_se=
rver.type:s0
sys.role:cockpit_session.subj:s0 joe.role:joe_cockpit_bridge.type:s0 joe1:j=
oe1_cockpit_bridge.type:s0

ie. its already specified that for example joe1.type is default type for jo=
e1.role for local_login and that joe1_ssh_server.type is default type for j=
oe1.role for sshd

So unless i am overlooking something, the default_type file is redundant an=
d it actually adds an extra file to configure

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlphxkMACgkQJXSOVTf5
R2knhQwAgRg/3xK0fPF+hRNjgYoNDHZPJuJF6VMb/MiLiXet5YmytNwkmyWcakcE
0uyHa8Q6IPGk8pMudEo13cRxGWQCxMuQvNoPlKL50izsaZZPmNUPVnazsLkzCqJD
0aXsVqNXquwznOvH/7zFcmTRIk0+iZRVh8P0exDdNf/rSbrhDbwIR8UPj0P6Q9zq
jSNxmNGEALqGg1zLEQpWdxBZi3epoWxcDWq8jASkXF+FDz4hL1RzITCWtAqTvvzc
H0aHzUQlmnrUB6z+g6N8NZrkKjcUyH8zGQntbwZK8g9xpqdND3lrvep1arUKchzm
4oYu3YSOF51oD5JKJoYxR5zMe/fvuPBohgK/hxW2gz/b1qUWC5tE65o8K4xMGPH3
Q27McEwxWRwgZAz/+psjrSbYmxP+LGAwLWwhPOIuTt6uThfXoI8vOWeJboJD7A+y
wprQhUBgyUx1gFdxNagse28xgew7I+Axr4V1871O85TCc13FcsMS2L5bXeXUl0ne
MMoi21mU
=8et6
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
