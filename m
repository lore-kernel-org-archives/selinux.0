Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2VDanhM016125
 for <selinux@tycho.nsa.gov>; Fri, 31 Mar 2017 09:36:49 -0400
Received: by mail-wr0-f174.google.com with SMTP id l43so108247603wre.1
 for <selinux@tycho.nsa.gov>; Fri, 31 Mar 2017 06:36:17 -0700 (PDT)
Received: from t450.enp8s0.d30 (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id
 m186sm2941572wmd.21.2017.03.31.06.36.15 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 31 Mar 2017 06:36:15 -0700 (PDT)
Date: Fri, 31 Mar 2017 15:36:13 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: userspace object manager confused
Message-ID: <20170331133613.GB5699@t450.enp8s0.d30>
References: <20170331120905.GA5699@t450.enp8s0.d30>
 <1490966741.31110.2.camel@tycho.nsa.gov>
 <1490967056.31110.4.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
In-Reply-To: <1490967056.31110.4.camel@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 31, 2017 at 09:30:56AM -0400, Stephen Smalley wrote:
> On Fri, 2017-03-31 at 09:25 -0400, Stephen Smalley wrote:
> > On Fri, 2017-03-31 at 14:09 +0200, Dominick Grift wrote:
> > > I vaguely recall that we discussed this issue or at least that i
> > > mentioned it here but i can't recall the outcome if any:
> > >=20
> > > So today on my rawhide system i noticed that i somehow forgot to
> > > add
> > > support for the smc_socket class (i suspect that is part of the
> > > extended socket class patches)
> > >=20
> > > I added the class (which i suppose is unordered like the othe
> > > extended socket classes) but as soon as I loaded up the policy with
> > > the new unordered smc_socket class the system became unusable.
> > >=20
> > > This is because the dbus object manager became confused due to my
> > > adding a new (unordered) class at runtime, and that the dbus class
> > > was no longer working.
> > >=20
> > > Modern systems heavily rely on dbus at the heart and so it is
> > > undesire-able that this happens.
> > >=20
> > > A reboot clears this issue up but adding (unordered) classes at
> > > runtime should not cause these issues i suspect
> >=20
> > dbusd doesn't use selinux_check_access() and therefore does not yet
> > support reordering of their classes/permissions at runtime.=A0=A0The sa=
me
> > is true of all userspace object managers created before
> > selinux_check_access() was introduced - anything that directly calls
> > security_compute_av() or avc_has_perm(). dbusd does call
> > selinux_set_mapping() at startup, so it can correctly handle
> > reordering of classes/permissions across restarts, but not while it
> > is
> > running.=A0=A0Calling selinux_set_mapping() again upon policy reloads
> > (e.g.
> > from policy_reload_callback() if (event =3D=3D AVC_CALLBACK_RESET) befo=
re
> > returning) may fix this problem, but requires proper locking.=A0=A0Even
> > better would be to rid the dbusd selinux implementation of threading
> > entirely, see https://bugs.freedesktop.org/show_bug.cgi?id=3D92831#c4

Thank you, I suppose i should take this to them then.

> >=20
> > smc_socket was added by the kernel developers as part of the merge
> > with
> > net-next since we now trigger a build failure in the kernel if any
> > new
> > address families are introduced without adding a corresponding
> > security
> > class (so that SELinux always supports a separate class per network
> > address family going forward). So there have been no policy patches
> > submitted yet to define it in refpolicy even AFAIK.
> >=20
> > [1] https://github.com/SELinuxProject/selinux/issues/34

So i suppose its an unordered class? or do i have to order this one to avoi=
d future issues?

>=20
> BTW, I'm not sure what you did to trigger the problem.  When I tested
> the extended socket classes, I added them to my running policy via a
> CIL module like this:

Well i just added this commit (ignore the typo in the name) which adds the =
new class to the unordered socket list

https://github.com/DefenSec/dssp2-base/commit/5e3ada7d12525c8c659f347863f09=
ec9caeceb56

then i built rpms using this script:

https://github.com/DefenSec/dssp2-standard/blob/master/support/rpm/dssp2-st=
andard.sh

and just rpm -Uvh the new rpm

>=20
> (policycap extended_socket_class)
>=20
> (classcommon sctp_socket socket)
> (class sctp_socket (node_bind))
>=20
> <snip>
>=20
> (classcommon qipcrtr_socket socket)
> (class qipcrtr_socket ())
>=20
> (classorder (unordered sctp_socket icmp_socket ax25_socket ipx_socket
> netrom_socket bridge_socket atmpvc_socket x25_socket rose_socket
> decnet_socket atmsvc_socket rds_socket irda_socket pppox_socket
> llc_socket ib_socket mpls_socket can_socket tipc_socket
> bluetooth_socket iucv_socket rxrpc_socket isdn_socket phonet_socket
> ieee802154_socket caif_socket alg_socket nfc_socket vsock_socket
> kcm_socket qipcrtr_socket))
>=20
> The classorder statement at the end ensured that they were appended to
> the end of the class list and therefore did not break anything.
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAljeW0oACgkQJXSOVTf5
R2ksQwv+KB5DK0ddFCPoo+LpeQrp5E5dFAObf2rDQvMx3ToaQWaWG/UDwW5AN2cq
gasAAqyjd9RldPzNLCZ1Mo462IgRt+PLtaMxHn9viTpoufwy9Z2L7QOFrrA34jW4
xGiE3kB3mJ06kxfskKWCNdao1Na0dgnn2frrmfx1jA5e0ASq5i6utTqvJ7VdZp0A
70Fs/Mm4xBPoD1jh14bil1C1fxX70wND1Kd9eoJ9jKUrVTZa8zVW42pKNSrW9eqs
E6Yle6T5PkbzxJMjsPLEJc5QwnGv/pangRRTOj+3uix4omh5dCDE9vd8/Fe9It++
/s5KUc7Bpg8QhbjQw7RJVhNYH1GE259pQxhN9ouUtFLv1JO6NwkeLCCVIKRTL7t6
wVzSQYoaxMtyKZYLaLbcI4zu9Vqu1PAo6gdeFRq8Mi+NlqYt4kNIj+vKUCA4WRZh
/ZChitRJ8shsvP1CjXKAArR6R9C3tmiiNFcigzmZNlEW4gwFDEfPePtcEJaeqw9F
G7f09WDX
=xRlB
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
