Date: Wed, 9 Jul 2003 15:41:40 -0700
From: Tracy R Reed <treed@ultraviolet.org>
To: Bill Laut <wlsel@verizon.net>
Cc: SELinux@tycho.nsa.gov
Subject: Re: SELinux, KDE, and honeypots
Message-ID: <20030709154140.B28893@ultraviolet.org>
References: <200307082303.22083.wlsel@verizon.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
In-Reply-To: <200307082303.22083.wlsel@verizon.net>; from wlsel@verizon.net on Tue, Jul 08, 2003 at 11:03:22PM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 08, 2003 at 11:03:22PM -0400, Bill Laut spake thusly:
> needs to be modified is kdm.  Is this a correct assumption, or should I=
=20
> expect it to be more involved than that?

rjc has already offered a good answer to this. kdm isn't easily patched,
use something else or startx.

> The idea I had was to create a pseudo-device driver that leverages NetFil=
ter=20
> to output all traffic from all TCP streams to a user-mode daemon that wri=
tes=20
> the packets for each stream into their own separate disk files (and gover=
ning=20

I think this is a pretty slick idea. Although I doubt you have to make it
as fancy as a device driver. I would log everything to an external host
and let that external host also do the sniffing. It could save everything
for a certain amount of time before deleting it (I might go for a week
since this box shouldn't get much traffic and gentle probes can be made
over a long period of time before they pick your box as a target or
discover a vulnerability that will allow them to cause an access
violation) and if there was an access violation it could permanently save
all traffic up to that point and any future traffic of any ip that had
communicated with the box within a minute before and after the violation
occurred. Pretty much all of the vulnerabilities I am aware of cause
instantaneous results but if there are some that might cause a time delay
between the network traffic and the access violation  the window can be
widened to an hour or a day or whatever. It just means we'll have more
data to go through but this box should not be receiving much traffic
anyhow.

Oh, and of course you would want to run the box in permissive mode for all
of this so that their exploit can actually work and you can learn
something.

> Does this idea sound reasonable?  Has someone already done it using SELin=
ux? =20
> If not, how would you improve it?

I am not aware of anyone having done it either. Kinda wish I had thought
of it actually. :) My suggestions for improvement are above. Sounds like a
very interesting project.

--=20
Tracy Reed     =20
http://ultraviolet.org

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj8MmiQACgkQ9PIYKZYVAq2QowCcCwtJkHV4KEPoE2mD+pDAFtkX
3DAAn2VtXl1NkOGwv2SKpUuqlx9BRx99
=bFx9
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
