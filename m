Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5OMBqgA011214
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 18:11:52 -0400 (EDT)
Received: from turing-police.cirt.vt.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5OMBlUD010861
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 22:11:48 GMT
Message-Id: <200506242211.j5OMBUA5012667@turing-police.cc.vt.edu>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: gyurdiev@redhat.com, "'Brian T. Sniffen'" <bsniffen@mitre.org>,
   selinux@tycho.nsa.gov
Subject: Re: Alternative user management approach 
In-Reply-To: Your message of "Fri, 24 Jun 2005 14:41:45 EDT."
             <200506241841.j5OIfiqc018618@gotham.columbia.tresys.com>
From: Valdis.Kletnieks@vt.edu
References: <200506241841.j5OIfiqc018618@gotham.columbia.tresys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1119651089_4848P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 24 Jun 2005 18:11:30 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1119651089_4848P
Content-Type: text/plain; charset=us-ascii

On Fri, 24 Jun 2005 14:41:45 EDT, Karl MacMillan said:
> > -----Original Message-----
> > From: Ivan Gyurdiev [mailto:gyurdiev@redhat.com]
> > Sent: Friday, June 24, 2005 2:33 PM
> > To: Brian T. Sniffen
> > Cc: Karl MacMillan; selinux@tycho.nsa.gov
> > Subject: Re: Alternative user management approach
> > 
> > On Fri, 2005-06-24 at 14:09 -0400, Brian T. Sniffen wrote:
> > > "Karl MacMillan" <kmacmillan@tresys.com> writes:
> > >
> > > > This makes the SELinux user more what we are calling a 'user
> > > > role'. For example, the policy could create 3 user roles with
> > > > different role authorizations (which become 'role capabilities'):
> > >
> > > This seems like a great innovation.  But it does inherit one problem
> > > of generic user_u: there's no longer any MAC separating users.  If I'm
> > > a normal user, my shell has exactly the same security context as your
> > > shell---right?
> > 
> > Is the user info used for anything besides rbac?
> > I don't think it is...
> > 
> 
> It can be used for constraints. There have been some suggested uses for this,
> but none are currently implemented in real policies. User separation seems
> better left to DAC.

I think I was the guy who started the whole constraints discussion ;)

And for the most part, yes DAC is sufficient - but there's a few things I'd
like to apply at the MAC level using constraints.  I'd much rather have one
user_u with 20-30 locally added ($u1 != $u2) constraints than have to drag
around user1_u..user1000_u with corresponding ruleset explosion....

--==_Exmh_1119651089_4848P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCvIURcC3lWbTT17ARAgyPAKD23l0Qa7nZ+k7+OTb/M2tovD4zEwCgqqS+
95dQv5nWSrMs1aGyJ/1gbIA=
=zDKS
-----END PGP SIGNATURE-----

--==_Exmh_1119651089_4848P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
