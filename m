Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4CFCBt6011669
 for <selinux@tycho.nsa.gov>; Tue, 12 May 2015 11:12:11 -0400
Received: by wief7 with SMTP id f7so114772410wie.0
 for <selinux@tycho.nsa.gov>; Tue, 12 May 2015 08:12:08 -0700 (PDT)
Received: from x131e (217-19-24-195.dsl.cambrium.nl. [217.19.24.195])
 by mx.google.com with ESMTPSA id i6sm28193803wjf.29.2015.05.12.08.12.07
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 May 2015 08:12:07 -0700 (PDT)
Date: Tue, 12 May 2015 17:12:04 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: SELinux talk
Message-ID: <20150512151201.GA9693@x131e>
References: <CAEcA1_vvm7TEkrULWOxbC=BtuCyn+Tm0DMXLE3ScZe24Lktpjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
In-Reply-To: <CAEcA1_vvm7TEkrULWOxbC=BtuCyn+Tm0DMXLE3ScZe24Lktpjw@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2015 at 04:42:41PM +0200, Andrew Holway wrote:
> Hello,
>=20
> I'm giving a talk on SELinux at a little conference here in Berlin in a
> couple of days. I was going to do the following items.
>=20
> IEEE 1003.1e/2c - A withdrawn draft standard.
> Linux ACLS - Hacked together from IEEE 1003.1e/2c
> SELinux -> An opensource solution for the US military.
> DAC 1997 -> 2015 - The elephant in the room.
>=20
> I was wondering if anyone could provide me with specific bulletpoint
> examples of the problems inherent with the current ACL system and how
> SELinux can mitigate these problems.

Here is one i somehow find compelling:

Centralized governed (MAC) versus De-centralized goverened (DAC) security

Back in the days of 1997 the privilege of computer environments was pretty =
much limited to academic use.

I think there was an filosophy of trust. Were all academics we know what we=
 do and we're all good (we dont make mistakes)

(Some still believe in that)

To others, things changed since then.

Computer environments are no longer limited to academics and everyone and t=
heir mother are now wielding a computer with a 100 mbit+ uplink to the rest=
 of the connected world.

Also we're now pretty much all connected. That means that we can in theory =
now all affect eachothers=B4 experience.

For example some could in theory send your site into a black hole by packet=
ing it to death.
(some user with access to your system may decide to use your assets to ruin=
 the fun for someone else on the network by udp flooding or whatever)=20

Also these days the stakes are much higher in general (some businesses depe=
nd for their lively hood on computer environment)

Those three changes are basically a pretty compelling reason to calibrate t=
he security model to the new requirements and threats.

SELinux and MAC in general, allows the owner of a computer system or enviro=
nment to take control back into his own hands by overriding traditional DAC

SELinux enables one to not necessarily trust individual processes and/or us=
ers on a system. It allows owners to enforce what
indidivual processes and users can do thereby enforcing integrity

Some other advantages of SELinux over other MAC systems are that SELinux is=
 customizable, flexible and allows for finer-grained access control.

>=20
> Can anyone tell me about the relationship between IEEE 1003.1e/2c and
> SELinux?
>=20
> Any other interesting nuggets to keep a technical but non security focuss=
ed
> audience interested?
>=20
> Ta
>=20
> Andrew
>=20
>=20
>=20
> --=20
> Otter Networks UG
> http://otternetworks.de
> fon: +49 30 54 88 5197
> Gotenstra=DFe 17
> 10829 Berlin

> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa=
=2Egov.


--=20
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=3Dvindex&search=3D0x314883A202DFF788
Dominick Grift

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJVUhg9AAoJENAR6kfG5xmc+/QL/j2FbTy4AkGKAylS1/ssUB+i
QeJ8uFV/1HicRKTwaG0z770eJjzUD+6vmnrBD5wt6sxDmtI+YZ+eZzTEw2sQiIPa
LKCfNQ7rO+E7y3DJQyNFkh0rW9tM9wL43nZv0Fcvhl7U6vukfRl3zjB35kCJu9tv
p3mkNbCLNt6goKhN40nx7/F+ea9fmUcph+j5R9sRGXxlQiVIZsIjrXXgE4kQtzdl
1QiFJ5HHr8gzbSI7r87UXFYmr3tldnYWqTYh3022kv2jTS9coNFSG4zL6ShrveC8
CEbfQgX/6k/CaA089oWkOcUa/dtOKyuY6sMctFsgYHsdNPOhS+KYqflS15iv9ACp
9Ef6wXshfThQJHAmzgGIrAQvaL3NajN462zttS7avBoNb95TMgXYQrZJspl1VyQq
k5b6Vwe1ZXq2GD7YArnQgr/6GOtGPIoTyc3TW82TnHPl9rgno6qR2bRmK4aWvOqk
2PuPEfjn2n09DRJpWkv7+DL9/6jgoYJJyNP50YgW8A==
=Z9As
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
