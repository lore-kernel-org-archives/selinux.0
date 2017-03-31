Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2VF1woF012248
 for <selinux@tycho.nsa.gov>; Fri, 31 Mar 2017 11:01:59 -0400
Received: by mail-wm0-f67.google.com with SMTP id x124so180093wmf.3
 for <selinux@tycho.nsa.gov>; Fri, 31 Mar 2017 08:01:52 -0700 (PDT)
Received: from t450.enp8s0.d30 (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id
 e16sm7010999wra.62.2017.03.31.08.01.48 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 31 Mar 2017 08:01:48 -0700 (PDT)
Date: Fri, 31 Mar 2017 17:01:46 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: userspace object manager confused
Message-ID: <20170331150146.GG5699@t450.enp8s0.d30>
References: <1490967056.31110.4.camel@tycho.nsa.gov>
 <20170331133613.GB5699@t450.enp8s0.d30>
 <1490968406.31110.6.camel@tycho.nsa.gov>
 <20170331135945.GC5699@t450.enp8s0.d30>
 <1490969437.31110.8.camel@tycho.nsa.gov>
 <e5c49ac0-c151-056f-ba11-6be3b116ddc4@tycho.nsa.gov>
 <20170331141719.GD5699@t450.enp8s0.d30>
 <53f1212a-6c94-8beb-36eb-e14e16a71231@tycho.nsa.gov>
 <20170331143948.GF5699@t450.enp8s0.d30>
 <db4e0f0d-f747-b7ac-202a-7aaffa16f936@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="L1c6L/cjZjI9d0Eq"
In-Reply-To: <db4e0f0d-f747-b7ac-202a-7aaffa16f936@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--L1c6L/cjZjI9d0Eq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 31, 2017 at 10:53:00AM -0400, James Carter wrote:
> On 03/31/2017 10:39 AM, Dominick Grift wrote:
> > On Fri, Mar 31, 2017 at 10:30:22AM -0400, James Carter wrote:
> > > On 03/31/2017 10:17 AM, Dominick Grift wrote:
> > > > On Fri, Mar 31, 2017 at 10:12:50AM -0400, James Carter wrote:
> > > > > On 03/31/2017 10:10 AM, Stephen Smalley wrote:
> > > > > > On Fri, 2017-03-31 at 15:59 +0200, Dominick Grift wrote:
> > > > > > > On Fri, Mar 31, 2017 at 09:53:26AM -0400, Stephen Smalley wro=
te:
> > > > > > > > On Fri, 2017-03-31 at 15:36 +0200, Dominick Grift wrote:
> > > > > > > > > On Fri, Mar 31, 2017 at 09:30:56AM -0400, Stephen Smalley=
 wrote:
> > > > > > > > > > On Fri, 2017-03-31 at 09:25 -0400, Stephen Smalley wrot=
e:
> > > > > > > > > > > On Fri, 2017-03-31 at 14:09 +0200, Dominick Grift wro=
te:
> > > > > > > > > > > > I vaguely recall that we discussed this issue or at=
 least
> > > > > > > > > > > > that
> > > > > > > > > > > > i
> > > > > > > > > > > > mentioned it here but i can't recall the outcome if=
 any:
> > > > > > > > > > > >=20
> > > > > > > > > > > > So today on my rawhide system i noticed that i some=
how
> > > > > > > > > > > > forgot
> > > > > > > > > > > > to
> > > > > > > > > > > > add
> > > > > > > > > > > > support for the smc_socket class (i suspect that is=
 part of
> > > > > > > > > > > > the
> > > > > > > > > > > > extended socket class patches)
> > > > > > > > > > > >=20
> > > > > > > > > > > > I added the class (which i suppose is unordered lik=
e the
> > > > > > > > > > > > othe
> > > > > > > > > > > > extended socket classes) but as soon as I loaded up=
 the
> > > > > > > > > > > > policy
> > > > > > > > > > > > with
> > > > > > > > > > > > the new unordered smc_socket class the system became
> > > > > > > > > > > > unusable.
> > > > > > > > > > > >=20
> > > > > > > > > > > > This is because the dbus object manager became conf=
used due
> > > > > > > > > > > > to
> > > > > > > > > > > > my
> > > > > > > > > > > > adding a new (unordered) class at runtime, and that=
 the
> > > > > > > > > > > > dbus
> > > > > > > > > > > > class
> > > > > > > > > > > > was no longer working.
> > > > > > > > > > > >=20
> > > > > > > > > > > > Modern systems heavily rely on dbus at the heart an=
d so it
> > > > > > > > > > > > is
> > > > > > > > > > > > undesire-able that this happens.
> > > > > > > > > > > >=20
> > > > > > > > > > > > A reboot clears this issue up but adding (unordered)
> > > > > > > > > > > > classes at
> > > > > > > > > > > > runtime should not cause these issues i suspect
> > > > > > > > > > >=20
> > > > > > > > > > > dbusd doesn't use selinux_check_access() and therefor=
e does
> > > > > > > > > > > not
> > > > > > > > > > > yet
> > > > > > > > > > > support reordering of their classes/permissions at
> > > > > > > > > > > runtime.  The
> > > > > > > > > > > same
> > > > > > > > > > > is true of all userspace object managers created befo=
re
> > > > > > > > > > > selinux_check_access() was introduced - anything that
> > > > > > > > > > > directly
> > > > > > > > > > > calls
> > > > > > > > > > > security_compute_av() or avc_has_perm(). dbusd does c=
all
> > > > > > > > > > > selinux_set_mapping() at startup, so it can correctly=
 handle
> > > > > > > > > > > reordering of classes/permissions across restarts, bu=
t not
> > > > > > > > > > > while
> > > > > > > > > > > it
> > > > > > > > > > > is
> > > > > > > > > > > running.  Calling selinux_set_mapping() again upon po=
licy
> > > > > > > > > > > reloads
> > > > > > > > > > > (e.g.
> > > > > > > > > > > from policy_reload_callback() if (event =3D=3D
> > > > > > > > > > > AVC_CALLBACK_RESET)
> > > > > > > > > > > before
> > > > > > > > > > > returning) may fix this problem, but requires proper
> > > > > > > > > > > locking.  Even
> > > > > > > > > > > better would be to rid the dbusd selinux implementati=
on of
> > > > > > > > > > > threading
> > > > > > > > > > > entirely, see https://bugs.freedesktop.org/show_bug.c=
gi?id=3D92
> > > > > > > > > > > 831#
> > > > > > > > > > > c4
> > > > > > > > >=20
> > > > > > > > > Thank you, I suppose i should take this to them then.
> > > > > > > >=20
> > > > > > > > No, someone who uses SELinux will need to develop a patch a=
nd test
> > > > > > > > it
> > > > > > > > for them; dbusd maintainer doesn't use SELinux himself.
> > > > > > > >=20
> > > > > > > > Looks like I'm also wrong about being able to call
> > > > > > > > selinux_set_mapping() from an AVC callback, since
> > > > > > > > selinux_set_mapping()
> > > > > > > > itself calls avc_reset() to flush any cache entries before
> > > > > > > > reloading
> > > > > > > > the mapping, so that would produce infinite
> > > > > > > > recursion.  Sigh.  Could
> > > > > > > > change selinux_set_mapping() to not do that in libselinux, =
but that
> > > > > > > > won't help on existing releases.  Maybe we should just conv=
ert it
> > > > > > > > over
> > > > > > > > to using selinux_check_access() and drop all direct usage o=
f the
> > > > > > > > AVC.
> > > > > > > >=20
> > > > > > > > > > >=20
> > > > > > > > > > > smc_socket was added by the kernel developers as part=
 of the
> > > > > > > > > > > merge
> > > > > > > > > > > with
> > > > > > > > > > > net-next since we now trigger a build failure in the =
kernel
> > > > > > > > > > > if
> > > > > > > > > > > any
> > > > > > > > > > > new
> > > > > > > > > > > address families are introduced without adding a
> > > > > > > > > > > corresponding
> > > > > > > > > > > security
> > > > > > > > > > > class (so that SELinux always supports a separate cla=
ss per
> > > > > > > > > > > network
> > > > > > > > > > > address family going forward). So there have been no =
policy
> > > > > > > > > > > patches
> > > > > > > > > > > submitted yet to define it in refpolicy even AFAIK.
> > > > > > > > > > >=20
> > > > > > > > > > > [1] https://github.com/SELinuxProject/selinux/issues/=
34
> > > > > > > > >=20
> > > > > > > > > So i suppose its an unordered class? or do i have to orde=
r this
> > > > > > > > > one
> > > > > > > > > to avoid future issues?
> > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > > BTW, I'm not sure what you did to trigger the problem. =
 When I
> > > > > > > > > > tested
> > > > > > > > > > the extended socket classes, I added them to my running=
 policy
> > > > > > > > > > via
> > > > > > > > > > a
> > > > > > > > > > CIL module like this:
> > > > > > > > >=20
> > > > > > > > > Well i just added this commit (ignore the typo in the nam=
e) which
> > > > > > > > > adds the new class to the unordered socket list
> > > > > > > > >=20
> > > > > > > > > https://github.com/DefenSec/dssp2-base/commit/5e3ada7d125=
25c8c659
> > > > > > > > > f347
> > > > > > > > > 863f09ec9caeceb56
> > > > > > > > >=20
> > > > > > > > > then i built rpms using this script:
> > > > > > > > >=20
> > > > > > > > > https://github.com/DefenSec/dssp2-standard/blob/master/su=
pport/rp
> > > > > > > > > m/ds
> > > > > > > > > sp2-standard.sh
> > > > > > > > >=20
> > > > > > > > > and just rpm -Uvh the new rpm
> > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > > (policycap extended_socket_class)
> > > > > > > > > >=20
> > > > > > > > > > (classcommon sctp_socket socket)
> > > > > > > > > > (class sctp_socket (node_bind))
> > > > > > > > > >=20
> > > > > > > > > > <snip>
> > > > > > > > > >=20
> > > > > > > > > > (classcommon qipcrtr_socket socket)
> > > > > > > > > > (class qipcrtr_socket ())
> > > > > > > > > >=20
> > > > > > > > > > (classorder (unordered sctp_socket icmp_socket ax25_soc=
ket
> > > > > > > > > > ipx_socket
> > > > > > > > > > netrom_socket bridge_socket atmpvc_socket x25_socket
> > > > > > > > > > rose_socket
> > > > > > > > > > decnet_socket atmsvc_socket rds_socket irda_socket pppo=
x_socket
> > > > > > > > > > llc_socket ib_socket mpls_socket can_socket tipc_socket
> > > > > > > > > > bluetooth_socket iucv_socket rxrpc_socket isdn_socket
> > > > > > > > > > phonet_socket
> > > > > > > > > > ieee802154_socket caif_socket alg_socket nfc_socket
> > > > > > > > > > vsock_socket
> > > > > > > > > > kcm_socket qipcrtr_socket))
> > > > > > > > > >=20
> > > > > > > > > > The classorder statement at the end ensured that they w=
ere
> > > > > > > > > > appended
> > > > > > > > > > to
> > > > > > > > > > the end of the class list and therefore did not break a=
nything.
> > > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > Looks like you failed to include a classorder statement for=
 it as I
> > > > > > > > did
> > > > > > > > above.  That's still required to avoid breaking legacy user=
space
> > > > > > > > object
> > > > > > > > managers.
> > > > > > > >=20
> > > > > > > >=20
> > > > > > >=20
> > > > > > > No I added "scm_socket" (i renamed it later to smc_socket) to=
 my list
> > > > > > > or unordered classorder:
> > > > > > >=20
> > > > > > > ;
> > > > > > > ; Class order of unordered Linux access vectors
> > > > > > > ;
> > > > > > >=20
> > > > > > > (classorder
> > > > > > >     (unordered
> > > > > > >         alg_socket
> > > > > > >         atmpvc_socket
> > > > > > >         atmsvc_socket
> > > > > > >         ax25_socket
> > > > > > >         bluetooth_socket
> > > > > > >         caif_socket
> > > > > > >         can_socket
> > > > > > >         decnet_socket
> > > > > > >         icmp_socket
> > > > > > >         ieee802154_socket
> > > > > > >         ipx_socket
> > > > > > >         irda_socket
> > > > > > >         isdn_socket
> > > > > > >         iucv_socket
> > > > > > >         kcm_socket
> > > > > > >         llc_socket
> > > > > > >         netrom_socket
> > > > > > >         nfc_socket
> > > > > > >         phonet_socket
> > > > > > >         pppox_socket
> > > > > > >         qipcrtr_socket
> > > > > > >         rds_socket
> > > > > > >         rose_socket
> > > > > > >         rxrpc_socket
> > > > > > >         scm_socket
> > > > > > >         sctp_socket
> > > > > > >         tipc_socket
> > > > > > >         vsock_socket
> > > > > > >         x25_socket
> > > > > > >     )
> > > > > > > )
> > > > > >=20
> > >=20
> > > You are reordering classes here since you didn't put scm_socket at th=
e end
> > > of the list. CIL just adds all of the unordered classes in the order =
that it
> > > parses them to the end of the ordered list. So could it be that sctp_=
socket,
> > > tipc_socket, vsock_socket, x25_socket changing caused the problem?
> > >=20
> > > Jim
> > >=20
> > > > > > Then I'm confused as to why you encountered breakage.  Doesn't =
CIL
> > > > > > ensure that all of those classes are appended to the existing c=
lass
> > > > > > list?  In which case it won't disturb the dbus class definition=
s.
> > > > > >=20
> > > >=20
> > > > If I would have left out the classorder entry , then a reboot would=
 - i suppose - not have fixed the issue
> > > >=20
> > > > >=20
> > > > > CIL appends unordered classes to the existing class list, so I am=
 not sure
> > > > > what is going on.
> > > > >=20
> > > > > Jim
> >=20
> > What was the meaning of "unordered" if order matters just as much as "o=
rdered"?
>=20
> With ordered lists you will get an error if the ordered lists cannot be
> merged. So two ordered lists with no common members will cause an error to
> be reported. Likewise, if there is an inconsistency, (A B C) and (C B),
> there will be an error. But unordered lists are just added to the end of =
the
> ordered lists in the order that CIL sees them.
>=20
> >=20
> > dbus class is unordered, smc_socket is unordered. how can these two uno=
rdered classes cause ordering issues?
> >=20
>=20
> Because the order in the kernel policy changes. Classes are always ordered
> in the kernel. Unordered classes are useful for user space object managers
> that use selinux_check_access() and can support reordering of classes. In
> the dbus case, which apparently does not support that, you will have to be
> careful about the ordering.

Thanks, so the issue is just object managers that dont use selinux_access_c=
heck()

>=20
> Jim
>=20
> > > > >=20
> > > > >=20
> > > > >=20
> > > > > --
> > > > > James Carter <jwcart2@tycho.nsa.gov>
> > > > > National Security Agency
> > > >=20
> > > >=20
> > > >=20
> > > > _______________________________________________
> > > > Selinux mailing list
> > > > Selinux@tycho.nsa.gov
> > > > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > > > To get help, send an email containing "help" to Selinux-request@tyc=
ho.nsa.gov.
> > > >=20
> > >=20
> > >=20
> > > --
> > > James Carter <jwcart2@tycho.nsa.gov>
> > > National Security Agency
> > > _______________________________________________
> > > Selinux mailing list
> > > Selinux@tycho.nsa.gov
> > > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > > To get help, send an email containing "help" to Selinux-request@tycho=
=2Ensa.gov.
> >=20
> >=20
> >=20
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to Selinux-request@tycho.n=
sa.gov.
> >=20
>=20
>=20
> --=20
> James Carter <jwcart2@tycho.nsa.gov>
> National Security Agency

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--L1c6L/cjZjI9d0Eq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAljeb1cACgkQJXSOVTf5
R2kOpQv+LRnAJvMKwuoo5yG35dVoIvuGUeE/nI7uMhf/rj2JhbJekuKsgz9R6n7k
rYeYGBP+Me87+laZ21Ez2KOL8qpnbKFwi4ECxxqk2EI74J/TadPOyMz+F3t2xAz5
c3W2e1FEezvvLT065BitGW9MW4ND88KYzLefuuQayclpLQxklyVJutaHKYVTOirI
CXQQ9IQFBj/vMhcD86J3eRjUk6lyDNI7Xsg1T/QKg20/XnKGNGaYMJJvgiSE6iHc
ja85qhDSqrDfFqdgtIcr714A7WONbuljoQ+FAEmNZMOkc3vZbskgbX0s/zpBAlXb
vH1WJaZAAaK9SABhu/FSyHGOR0NZNkbSWV11FYzALuEuZ3/GnvNZ02omdtBgKeyS
Xzn8+NSrsCOoOtivpMDEefJm/Z6mRowziKuA+xXgwSyakDhXbLH5q7j+4MwdskAD
8XzGJ0/x2VAia2MXHc+hI64wTt2e3xqJEDVgPndHoaP83E/OFMWAh+Y1ib4fP+aq
/JfmGhNA
=tdPJ
-----END PGP SIGNATURE-----

--L1c6L/cjZjI9d0Eq--
