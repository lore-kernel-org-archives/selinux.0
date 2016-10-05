Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u957WkjU022912
 for <selinux@tycho.nsa.gov>; Wed, 5 Oct 2016 03:32:46 -0400
Received: by mail-wm0-f41.google.com with SMTP id p138so256523429wmb.1
 for <selinux@tycho.nsa.gov>; Wed, 05 Oct 2016 00:32:42 -0700 (PDT)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id f142sm7932649wmf.19.2016.10.05.00.32.40
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Oct 2016 00:32:40 -0700 (PDT)
Subject: Re: restorecon -r goes up the tree?
To: selinux@tycho.nsa.gov
References: <20161005072834.GA8208@meriadoc>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <51089b56-c8e7-01f8-6a51-9121c1ddf354@gmail.com>
Date: Wed, 5 Oct 2016 09:32:29 +0200
MIME-Version: 1.0
In-Reply-To: <20161005072834.GA8208@meriadoc>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DKWG7HKt9TkMVscS91L37hHbmBCJBdaNp"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DKWG7HKt9TkMVscS91L37hHbmBCJBdaNp
Content-Type: multipart/mixed; boundary="Mkx4AEXTqH0bxovxc5Gvsnl3vDacQ2NH7";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <51089b56-c8e7-01f8-6a51-9121c1ddf354@gmail.com>
Subject: Re: restorecon -r goes up the tree?
References: <20161005072834.GA8208@meriadoc>
In-Reply-To: <20161005072834.GA8208@meriadoc>

--Mkx4AEXTqH0bxovxc5Gvsnl3vDacQ2NH7
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 10/05/2016 09:28 AM, Jason Zaman wrote:
> Hey all,
>=20
> There have been a few changes to restorecon just before RC1 and it
> appears to not stay in the dir it was pointed at anymore?
>=20
> meriadoc ~ # mount | grep "/dev"
> udev on /dev type devtmpfs (rw,nosuid,relatime,seclabel,size=3D10240k,n=
r_inodes=3D1521608,mode=3D755)
> devpts on /dev/pts type devpts (rw,relatime,seclabel,gid=3D5,mode=3D620=
,ptmxmode=3D000)
> mqueue on /dev/mqueue type mqueue (rw,nosuid,nodev,noexec,relatime,secl=
abel)
> shm on /dev/shm type tmpfs (rw,nosuid,nodev,noexec,relatime,seclabel)
>=20
> meriadoc ~ # restorecon -rv /dev/
> Warning no default label for /run/sm-notify.pid
> Warning no default label for /run/cgmanager/fs
> Warning no default label for /run/user/1000/dconf
> Warning no default label for /run/user/1000/dconf/user
> Warning no default label for /run/user/1000/gvfs
> Warning no default label for /run/lightdm.pid
> Warning no default label for /run/dbus.pid
> ^C
>=20
> I'd already run restorecon so this output isnt as verbose as it was
> before (scrollback fell off). But the first time it was also going into=

> /usr and /lib and many other places that are not /dev. /dev and /run ar=
e
> also separate mountpoints so its not just that its doing the entire
> rootfs or something cuz if that was the case it would stay in /dev.
> Also "/dev" vs "/dev/" makes no difference.
>=20

I also see this.
When i do a restorecon -RvF /home, it will act like restorecon -RvF /

> -- Jason
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.n=
sa.gov.
>=20


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--Mkx4AEXTqH0bxovxc5Gvsnl3vDacQ2NH7--

--DKWG7HKt9TkMVscS91L37hHbmBCJBdaNp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJX9KyTAAoJECV0jlU3+UdpNDIL/iK6iHteQGFByBr2TwgvThd3
PStZyuHomeGwi9JBulX4UnGHeDxavimhOjsdb7Ay0yYDVES4a3lP7AMd2wcYDZYJ
x1SGuaXwzsFMYZEoBZXq20ck0CkZQdPOgCQYto653Ex+VlkFHwLfe8PcxIVlZ0D5
ZCt/WLjEbNe7E2RRJZZ+3p5jmKqe4NQn18GXHvsdB0cwuW+Sm5dpT1OXw+gcAO4u
9pszp5AmxQqvHQNIIJBIroritk/UyU466XPehZ82zc9zSL6UqEss43a6fMozihNe
CYaahn1Kj+wZS41o3KREZ557HEzIzebnHV/5J84NhXUcZKBRVzF+VXpEj6Nfa4nj
80UWxcCKWqk3QS96wIiRd8tB5UaiKbYKczhBfyTYNjjq2Et6HCTgvYyeh91XMmiU
n900yYWmHlM9tUN5VaGTw1lPIJrbNkjkfT91s4q9KVR+oCbpj/l0bXwpxOC1uWkQ
yZjHemdOddCiSsBdc4F1XrWnawuB61i3e98do6touw==
=Aqds
-----END PGP SIGNATURE-----

--DKWG7HKt9TkMVscS91L37hHbmBCJBdaNp--
