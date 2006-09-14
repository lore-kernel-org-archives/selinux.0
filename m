Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8EG32aM008329
	for <selinux@tycho.nsa.gov>; Thu, 14 Sep 2006 12:03:02 -0400
Received: from mail.and.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8EG29g7029515
	for <selinux@tycho.nsa.gov>; Thu, 14 Sep 2006 16:02:09 GMT
From: James Antill <jantill@redhat.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45095E10.2020205@tresys.com>
References: <45095092.6080603@redhat.com>  <45095E10.2020205@tresys.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uLVUXgh/O7bOiH8TrDFh"
Date: Thu, 14 Sep 2006 12:02:57 -0400
Message-Id: <1158249777.8442.13.camel@code.and.org>
Mime-Version: 1.0
Subject: Re: ipsec, netlabels, secmark- How about a little usability?
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-uLVUXgh/O7bOiH8TrDFh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-09-14 at 09:50 -0400, Joshua Brindle wrote:
> Daniel J Walsh wrote:
> > 1.  By default httpd has to be able to talk to itself in order to do=20
> > gracefull shutdown,
> > service httpd graceful.
> >
> > So I end up adding a rule allowing httpd to name_connect to the=20
> > httpd_port_t.    But I really only want to allow this for localhost. =20
> > IE I don't want to allow my httpd to name_connect to other machines=20
> > httpd ports?  I can't do this now.
> >
> you can with secmark can't you?
> iptables -I -p tcp -d localhost -s localhost -i lo --dport 80 -j SECMARK=20
> --selctx system_u:object_r:httpd_client_packet_t

 This one rule, both allows httpd_t to connect to localhost:80 and
disallows it from connecting to anything-else:80 ?

 From the documentation --selctx just sets the "SELinux security
context" ... so you presumably _also_ need some bit of policy code that
says "httpd_t can only name_bind(?) with httpd_client_packet_t"?

> > 2.  I as a sysadm have setup a apache web site that allows connections=20
> > from the outside and needs to connect to three mysql servers on my=20
> > internal network. So I need to allow it to connect to those three=20
> > machines on the internal network only.  How am I as the Sysadm going=20
> > to set this up.
> >
> again, secmark

 Err, no. The requirement here is that:

1. httpd_t on one machine is only allowed to connect to mysqld_t(?) on
one of these 3 machines.

...AIUI secmark doesn't know the label of the proc. on the other
machines, even when using ipsec/netlabel.

--=20
James Antill <jantill@redhat.com>

--=-uLVUXgh/O7bOiH8TrDFh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFCX0x11eXTEMrxtQRAqDJAKDAuu4rjKaR9uvw0I3aKT3NNBwz8gCfSRjt
m3/TFJEqIwbewg059EkgD8o=
=suzI
-----END PGP SIGNATURE-----

--=-uLVUXgh/O7bOiH8TrDFh--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
