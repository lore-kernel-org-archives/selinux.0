Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o1A6RiTM027777
	for <selinux@tycho.nsa.gov>; Wed, 10 Feb 2010 01:27:45 -0500
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o1A6RWb8014452
	for <selinux@tycho.nsa.gov>; Wed, 10 Feb 2010 06:27:33 GMT
Date: Wed, 10 Feb 2010 07:27:29 +0100
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov
Subject: Re: MLS and network
Message-ID: <20100210062729.GW1750@myhost.felk.cvut.cz>
References: <20100204174901.GL1750@myhost.felk.cvut.cz>
 <201002051547.27944.paul.moore@hp.com>
 <20100207181016.GS1750@myhost.felk.cvut.cz>
 <201002081011.53221.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gX5Hm7FaHdN5aeGl"
In-Reply-To: <201002081011.53221.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--gX5Hm7FaHdN5aeGl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Paul Moore wrote:
> Well, keep in mind that once you label the interface via semanage, on
> subsequent reboots it takes effect before the network is brought up
> (it happens during policy load) so you don't really have to worry
> about any race conditions.  However, you do make a good point about
> interface naming, but I would suspect that anyone who is interested in
> running the strict/MLS SELinux policy is also tightly controlling
> physical access to the machine and binding interface
> names/configuration to the physical MAC address which means problems
> caused by new or mis-named interfaces are not a real concern.

There are also software interfaces like tunnels and taps, and god knows
what else (you can even run a ppp interface over a ssh session). At some
point it might just be that they are all pinned down and tightly
controlled, but why have to do all this *just because* the default is
systemhigh and not *in addition to* a sane systemlow default? Isn't a
longish list of semanaged interfaces just a more volatile version of a
low default?

> So let me get this straight ... you are very concerned about what
> information leaves your system over what physical network, but you
> don't care at all about the information coming into your system?  That
> seems odd to me.  The SELinux network access controls are dynamic and
> assume that those who wish to use them want to enforce access controls
> on traffic both leaving and entering the system.

If you just want to protect confidential data in your box then strictly
speaking yes! egress traffic is everything you need to worry about (at
least network-wise).

Second, I'm not quite sure if I understand why defining a *fallback*
label is necessary to turn on the whole infrastructure. I think that
the fallback label is not that much necessary in most situations.

If I wanted to implement a MLS network then my first shot would be to
designate a separate interface for s1 traffic. Thus my eth1 would have
s1 and I wouldn't need a fallback label there.

If I wanted to use single interface for multiple levels, I could use the
CIPSO stuff to mark packets at the sender and yet again I would do
without fallback labels at the receiver. (I would assume unmarked
packets as invalid.)

Only if I wanted to use a single interface for both unmarked and marked
traffic I would need to define a fallback label.

> This next point may sound minor, but trust me it is important: the
> per- packet labels provided by secmark do not represent the same
> security attributes as the per-packet labels provided by NetLabel (or
> labeled IPsec for that matter).  The secmark labels represent the IP
> attributes of the packet, e.g. IP addresses, while the NetLabel and
> labeled IPsec labels, called network peer labels, represent the
> security attributes of the sender, e.g. apache_t. =20

That's true only when the sender already fills in the netlabel info. My
point was that netlabel fallback labels can be only configured per IP
address, but secmark has the whole netfilter infrastructure behind it,
thus could provide more fine-grained fallback labeling.

Michal Svoboda

--gX5Hm7FaHdN5aeGl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAktyUdEACgkQg/fU9pp1uX6DsACgsGeLL5sraE4bGO7rf/qBvcn1
91YAoJ861SivHq/k/30+ViMfqy2XVdSG
=DIA6
-----END PGP SIGNATURE-----

--gX5Hm7FaHdN5aeGl--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
