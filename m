Message-Id: <200506111918.j5BJIeQp015251@turing-police.cc.vt.edu>
To: Park Lee <parklee_sel@yahoo.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Question about integration of IPsec with SELinux? 
In-Reply-To: Your message of "Sat, 11 Jun 2005 11:45:22 PDT."
             <20050611184522.51251.qmail@web51505.mail.yahoo.com>
From: Valdis.Kletnieks@vt.edu
References: <20050611184522.51251.qmail@web51505.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1118517519_5642P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Sat, 11 Jun 2005 15:18:39 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1118517519_5642P
Content-Type: text/plain; charset=us-ascii

On Sat, 11 Jun 2005 11:45:22 PDT, Park Lee said:
> On Sat, 11 Jun 2005 at 10:27, Casey Schaufler wrote:
> 
> > IPSEC is the forward looking mechanism for
> > passing process attributes between machines.
> 
> What is the meaning of "forward looking mechanism"?
> Why it it called so?

It means that looking into the future, IPSec looks like the best direction
to go.  There's been other protocols, but they don't look as good for the future.

> Do you mean that we can't make access control
> decisions if we do not use IPsec?

No, it means that without IPsec (or other disfavored protocols), you can't
make an access control decision because you need a secure, trustable, and
verifiable way to pass credentials and the like around.

It doesn't *have* to be IPsec - it appears that the OpenSSH protocols also
provide enough of the needed primitives.  It would be a lot harder though,
mostly due to the way that most OpenSSH implementations are mostly done
in userspace, which creates some challenges...

(I'm guessing that OpenSSH was one of the "other protocols" Casey mentioned -
it's *very* useful in it's problem space, but isn't the best choice for *this*
problem (building an MLS cluster)...)
> > You can't
> > do an MLS cluster, for example, without passing
> > sensitivity and clearance information among
> > the machines involved. There are plans afoot
> > to produce an SELinux based MLS system, and
> > without networking capabilties the market
> > opportunity is too small to consider.
> 
> What does "networking capabilities" mean here?

Nobody is interested in doing a single-system MLS that can't talk to the
network (or at least, few enough that there's no market for it).  On the
other hand, if you can deploy it across all the servers in the machine room,
then it gets interesting.

How many people would have deployed Microsoft's Active Directory if it only
worked on a single system?  The only reason it's interesting at all is because
it allows "everything in the department is controlled" management....


--==_Exmh_1118517519_5642P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCqzkPcC3lWbTT17ARAlYAAKCg1ewh0WrAvpyiongNtm22rTowqQCcC3aE
X3uyaCmsgSwn0bELHucllpM=
=rTBN
-----END PGP SIGNATURE-----

--==_Exmh_1118517519_5642P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
