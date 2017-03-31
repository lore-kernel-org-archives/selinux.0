Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2VEX6rJ002690
 for <selinux@tycho.nsa.gov>; Fri, 31 Mar 2017 10:33:06 -0400
Received: by mail-wm0-f65.google.com with SMTP id z133so46841wmb.2
 for <selinux@tycho.nsa.gov>; Fri, 31 Mar 2017 07:32:43 -0700 (PDT)
Received: from t450.enp8s0.d30 (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id
 127sm3125673wmt.20.2017.03.31.07.32.34 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 31 Mar 2017 07:32:35 -0700 (PDT)
Date: Fri, 31 Mar 2017 16:32:33 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: userspace object manager confused
Message-ID: <20170331143233.GE5699@t450.enp8s0.d30>
References: <20170331120905.GA5699@t450.enp8s0.d30>
 <1490966741.31110.2.camel@tycho.nsa.gov>
 <1490967056.31110.4.camel@tycho.nsa.gov>
 <20170331133613.GB5699@t450.enp8s0.d30>
 <1490968406.31110.6.camel@tycho.nsa.gov>
 <20170331135945.GC5699@t450.enp8s0.d30>
 <1490969437.31110.8.camel@tycho.nsa.gov>
 <e5c49ac0-c151-056f-ba11-6be3b116ddc4@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IU5/I01NYhRvwH70"
In-Reply-To: <e5c49ac0-c151-056f-ba11-6be3b116ddc4@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--IU5/I01NYhRvwH70
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 31, 2017 at 10:12:50AM -0400, James Carter wrote:
> On 03/31/2017 10:10 AM, Stephen Smalley wrote:
> > On Fri, 2017-03-31 at 15:59 +0200, Dominick Grift wrote:
> > > On Fri, Mar 31, 2017 at 09:53:26AM -0400, Stephen Smalley wrote:
> > > > On Fri, 2017-03-31 at 15:36 +0200, Dominick Grift wrote:
> > > > > On Fri, Mar 31, 2017 at 09:30:56AM -0400, Stephen Smalley wrote:
> > > > > > On Fri, 2017-03-31 at 09:25 -0400, Stephen Smalley wrote:
> > > > > > > On Fri, 2017-03-31 at 14:09 +0200, Dominick Grift wrote:
> > > > > > > > I vaguely recall that we discussed this issue or at least
> > > > > > > > that
> > > > > > > > i
> > > > > > > > mentioned it here but i can't recall the outcome if any:
> > > > > > > >=20
> > > > > > > > So today on my rawhide system i noticed that i somehow
> > > > > > > > forgot
> > > > > > > > to
> > > > > > > > add
> > > > > > > > support for the smc_socket class (i suspect that is part of
> > > > > > > > the
> > > > > > > > extended socket class patches)
> > > > > > > >=20
> > > > > > > > I added the class (which i suppose is unordered like the
> > > > > > > > othe
> > > > > > > > extended socket classes) but as soon as I loaded up the
> > > > > > > > policy
> > > > > > > > with
> > > > > > > > the new unordered smc_socket class the system became
> > > > > > > > unusable.
> > > > > > > >=20
> > > > > > > > This is because the dbus object manager became confused due
> > > > > > > > to
> > > > > > > > my
> > > > > > > > adding a new (unordered) class at runtime, and that the
> > > > > > > > dbus
> > > > > > > > class
> > > > > > > > was no longer working.
> > > > > > > >=20
> > > > > > > > Modern systems heavily rely on dbus at the heart and so it
> > > > > > > > is
> > > > > > > > undesire-able that this happens.
> > > > > > > >=20
> > > > > > > > A reboot clears this issue up but adding (unordered)
> > > > > > > > classes at
> > > > > > > > runtime should not cause these issues i suspect
> > > > > > >=20
> > > > > > > dbusd doesn't use selinux_check_access() and therefore does
> > > > > > > not
> > > > > > > yet
> > > > > > > support reordering of their classes/permissions at
> > > > > > > runtime.  The
> > > > > > > same
> > > > > > > is true of all userspace object managers created before
> > > > > > > selinux_check_access() was introduced - anything that
> > > > > > > directly
> > > > > > > calls
> > > > > > > security_compute_av() or avc_has_perm(). dbusd does call
> > > > > > > selinux_set_mapping() at startup, so it can correctly handle
> > > > > > > reordering of classes/permissions across restarts, but not
> > > > > > > while
> > > > > > > it
> > > > > > > is
> > > > > > > running.  Calling selinux_set_mapping() again upon policy
> > > > > > > reloads
> > > > > > > (e.g.
> > > > > > > from policy_reload_callback() if (event =3D=3D
> > > > > > > AVC_CALLBACK_RESET)
> > > > > > > before
> > > > > > > returning) may fix this problem, but requires proper
> > > > > > > locking.  Even
> > > > > > > better would be to rid the dbusd selinux implementation of
> > > > > > > threading
> > > > > > > entirely, see https://bugs.freedesktop.org/show_bug.cgi?id=3D=
92
> > > > > > > 831#
> > > > > > > c4
> > > > >=20
> > > > > Thank you, I suppose i should take this to them then.
> > > >=20
> > > > No, someone who uses SELinux will need to develop a patch and test
> > > > it
> > > > for them; dbusd maintainer doesn't use SELinux himself.
> > > >=20
> > > > Looks like I'm also wrong about being able to call
> > > > selinux_set_mapping() from an AVC callback, since
> > > > selinux_set_mapping()
> > > > itself calls avc_reset() to flush any cache entries before
> > > > reloading
> > > > the mapping, so that would produce infinite
> > > > recursion.  Sigh.  Could
> > > > change selinux_set_mapping() to not do that in libselinux, but that
> > > > won't help on existing releases.  Maybe we should just convert it
> > > > over
> > > > to using selinux_check_access() and drop all direct usage of the
> > > > AVC.
> > > >=20
> > > > > > >=20
> > > > > > > smc_socket was added by the kernel developers as part of the
> > > > > > > merge
> > > > > > > with
> > > > > > > net-next since we now trigger a build failure in the kernel
> > > > > > > if
> > > > > > > any
> > > > > > > new
> > > > > > > address families are introduced without adding a
> > > > > > > corresponding
> > > > > > > security
> > > > > > > class (so that SELinux always supports a separate class per
> > > > > > > network
> > > > > > > address family going forward). So there have been no policy
> > > > > > > patches
> > > > > > > submitted yet to define it in refpolicy even AFAIK.
> > > > > > >=20
> > > > > > > [1] https://github.com/SELinuxProject/selinux/issues/34
> > > > >=20
> > > > > So i suppose its an unordered class? or do i have to order this
> > > > > one
> > > > > to avoid future issues?
> > > > >=20
> > > > > >=20
> > > > > > BTW, I'm not sure what you did to trigger the problem.  When I
> > > > > > tested
> > > > > > the extended socket classes, I added them to my running policy
> > > > > > via
> > > > > > a
> > > > > > CIL module like this:
> > > > >=20
> > > > > Well i just added this commit (ignore the typo in the name) which
> > > > > adds the new class to the unordered socket list
> > > > >=20
> > > > > https://github.com/DefenSec/dssp2-base/commit/5e3ada7d12525c8c659
> > > > > f347
> > > > > 863f09ec9caeceb56
> > > > >=20
> > > > > then i built rpms using this script:
> > > > >=20
> > > > > https://github.com/DefenSec/dssp2-standard/blob/master/support/rp
> > > > > m/ds
> > > > > sp2-standard.sh
> > > > >=20
> > > > > and just rpm -Uvh the new rpm
> > > > >=20
> > > > > >=20
> > > > > > (policycap extended_socket_class)
> > > > > >=20
> > > > > > (classcommon sctp_socket socket)
> > > > > > (class sctp_socket (node_bind))
> > > > > >=20
> > > > > > <snip>
> > > > > >=20
> > > > > > (classcommon qipcrtr_socket socket)
> > > > > > (class qipcrtr_socket ())
> > > > > >=20
> > > > > > (classorder (unordered sctp_socket icmp_socket ax25_socket
> > > > > > ipx_socket
> > > > > > netrom_socket bridge_socket atmpvc_socket x25_socket
> > > > > > rose_socket
> > > > > > decnet_socket atmsvc_socket rds_socket irda_socket pppox_socket
> > > > > > llc_socket ib_socket mpls_socket can_socket tipc_socket
> > > > > > bluetooth_socket iucv_socket rxrpc_socket isdn_socket
> > > > > > phonet_socket
> > > > > > ieee802154_socket caif_socket alg_socket nfc_socket
> > > > > > vsock_socket
> > > > > > kcm_socket qipcrtr_socket))
> > > > > >=20
> > > > > > The classorder statement at the end ensured that they were
> > > > > > appended
> > > > > > to
> > > > > > the end of the class list and therefore did not break anything.
> > > > > >=20
> > > >=20
> > > > Looks like you failed to include a classorder statement for it as I
> > > > did
> > > > above.  That's still required to avoid breaking legacy userspace
> > > > object
> > > > managers.
> > > >=20
> > > >=20
> > >=20
> > > No I added "scm_socket" (i renamed it later to smc_socket) to my list
> > > or unordered classorder:
> > >=20
> > > ;
> > > ; Class order of unordered Linux access vectors
> > > ;
> > >=20
> > > (classorder
> > >     (unordered
> > >         alg_socket
> > >         atmpvc_socket
> > >         atmsvc_socket
> > >         ax25_socket
> > >         bluetooth_socket
> > >         caif_socket
> > >         can_socket
> > >         decnet_socket
> > >         icmp_socket
> > >         ieee802154_socket
> > >         ipx_socket
> > >         irda_socket
> > >         isdn_socket
> > >         iucv_socket
> > >         kcm_socket
> > >         llc_socket
> > >         netrom_socket
> > >         nfc_socket
> > >         phonet_socket
> > >         pppox_socket
> > >         qipcrtr_socket
> > >         rds_socket
> > >         rose_socket
> > >         rxrpc_socket
> > >         scm_socket
> > >         sctp_socket
> > >         tipc_socket
> > >         vsock_socket
> > >         x25_socket
> > >     )
> > > )
> >=20
> > Then I'm confused as to why you encountered breakage.  Doesn't CIL
> > ensure that all of those classes are appended to the existing class
> > list?  In which case it won't disturb the dbus class definitions.
> >=20
>=20
> CIL appends unordered classes to the existing class list, so I am not sure
> what is going on.

Here is my theory:

I have various (classorder (unordered)) lists spread throughout my policy (=
access_vectors,cil dbus.cil systemd.cil mcstrans,cil pam.cil)

This is because i differentiate between user space and linux access vectors=
: I want vendors to be able to add modules for user space components with ,=
 if applicable, their respective access vectors)

I create myapp, made it an object manager, now i want to provide a module t=
hat included support for the object manager by declaring my user space acce=
ss vector

My linux access vector classes are classordered in access_vectors.cil, howe=
ver:

the dbus class is classordered in dbus.cil -- this is because the dbus clas=
s is tied to the dbus module: i.e. if i de-install dbus.cil then the dbus a=
ccess
vector will be removed.

So with that: could it be that we still have ordering issues (ironically)

because theres various (classorder (unordered)) lists and they just get app=
ended: so if it first processes the one in access_vectors, and then the one=
 in dbus.cil, then it will still mess up the order

should in not instead first collect all the (classorder (unonrdered)) lists=
 throughout the policy, thrown them on one heap and and then process them?

hmm ... that wouldnt work either i suppose....

>=20
> Jim
>=20
>=20
>=20
> --=20
> James Carter <jwcart2@tycho.nsa.gov>
> National Security Agency

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--IU5/I01NYhRvwH70
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAljeaH0ACgkQJXSOVTf5
R2mkWwv9FMO52LYINWRNQKnIOcl0JuLOoe0ePEgY1grB/Lbwp8HbCBA7yDtx1oDA
XVD3kWF0l2ZdqvJgYqjJbM24XiJUV5k1fI2uHQKBI/L8evJbfuUV5TZCZKz59xsu
h3+JHzlWXRdg0JLwwbw6h/uKKdp8AnyH04EOcDTKQ9x9DOlhMugRpMa3ITonoCa2
sKNRvImwF2Aofu3hc1hhQSRqAHQLgJsHvjWTfWR7Fsf/EQGXykYG7LGABoyv0kEJ
7UDxZd1U+z5WrLHM6hFv1HWsIvqn6iNn6kt94CNkDW1nt+WvpG7CfNV6lksqEBmM
gOQ+YxHBFa+1iurFY4hzfiuVQ20AtcWLAZwtudHA0I7p8lNrviFIVjcRjs/ahxYe
xb/8yL1tVmhJOnbpUgg/rw1TwowcGd2lV6fY37mwPE385ycHybfwlweJ7EF/cVEP
Qt2zfl5odSeKvxbw96KmAYLJ4LysODt371zsosm7rKqVZO8rjDuzJC2BqbN8GkiV
qbX8Cgpt
=+CkI
-----END PGP SIGNATURE-----

--IU5/I01NYhRvwH70--
