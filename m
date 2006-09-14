From: James Antill <jantill@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1158252565.25629.111.camel@moss-spartans.epoch.ncsc.mil>
References: <45095092.6080603@redhat.com>  <45095E10.2020205@tresys.com>
	 <1158249777.8442.13.camel@code.and.org>
	 <1158252565.25629.111.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-oU1wKcHzOTejaYp5E+Jh"
Date: Thu, 14 Sep 2006 13:24:55 -0400
Message-Id: <1158254695.8442.30.camel@code.and.org>
Mime-Version: 1.0
Subject: Re: ipsec, netlabels, secmark- How about a little usability?
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-oU1wKcHzOTejaYp5E+Jh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-09-14 at 12:49 -0400, Stephen Smalley wrote:
> On Thu, 2006-09-14 at 12:02 -0400, James Antill wrote:

> The iptables rule only deals with labeling the packet with a type.  The
> policy deals with what domains can send/recv a given packet via allow
> rules like:
> 	allow httpd_t http_client_packet_t:packet { send recv };
> encapsulated in interfaces like:
> 	corenet_sendrecv_http_client_packet(httpd_t)
>=20
> But the problem I see with the above example is that refpolicy already
> generates a netfilter contexts entry that maps _everything_ going to
> port 80 with http_client_packet_t, so we would need to delete that entry
> to make the above work, or use a different type
> (http_client_packet_lo_t) and only allow httpd_t to send it, not the
> generic http_client_packet_t.  All of which gets back to proper
> integration.

 The problem is you can't just use "send recv", because httpd_t needs to
call send on sockets it receives from all over the place. So you need an
interface specifically for connect (which, I understood, was called=20
something like name_bind)?
 Think of the difference between something coming to port X:80 from Y:Z,
being accepted, processed and a response being sent against some
attacker in httpd_t doing a connect from X:80 to Y:Z as part of some
botnet.

> > 1. httpd_t on one machine is only allowed to connect to mysqld_t(?) on
> > one of these 3 machines.
> >=20
> > ...AIUI secmark doesn't know the label of the proc. on the other
> > machines, even when using ipsec/netlabel.
>=20
> Yes, but you can label the output packet via secmark with one type if it
> is destined for the mysql port on one of the "good" machines and a
> different type otherwise, and only allow httpd_t to send the "good"
> type.   On the internal machines, you can ensure that only mysqld_t can
> bind to that port.  That doesn't really require a network labeling
> mechanism like ipsec or netlabel per se.

 That works, but is significantly more interdependent. From a useability
POV it would be much nicer to just be able to say something like
"httpd_t can only connect to mysqld_t, and also only on these
machines/networks".

 Also I can pretty much guarantee that if the accepted practice is "just
trust the port number on the other machines". The solution will be to
just use iptables to REJECT packets without that port (as that works
with or without SELinux).

--=20
James Antill <jantill@redhat.com>

--=-oU1wKcHzOTejaYp5E+Jh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFCZBn11eXTEMrxtQRAnOqAKDAIsqd859DbVMybbWyZdt6hc88WACfVshB
VYLXj/TeKTCYYslbJM31i60=
=gVf7
-----END PGP SIGNATURE-----

--=-oU1wKcHzOTejaYp5E+Jh--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
