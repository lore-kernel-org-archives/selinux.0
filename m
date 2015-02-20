Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t1KNRZk7001751
 for <selinux@tycho.nsa.gov>; Fri, 20 Feb 2015 18:27:35 -0500
Received: from tracyreed.org (wsip-98-175-106-200.sd.sd.cox.net
 [98.175.106.200])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mail.copilotco.com (Postfix) with ESMTP id A150B64C71
 for <selinux@tycho.nsa.gov>; Fri, 20 Feb 2015 15:27:33 -0800 (PST)
Date: Fri, 20 Feb 2015 15:27:50 -0800
From: Tracy Reed <treed@ultraviolet.org>
To: selinux@tycho.nsa.gov
Subject: Re: MCS error
Message-ID: <20150220232749.GM12937@tracyreed.org>
References: <20150219014803.GB12937@tracyreed.org>
 <54E5E3C4.40904@tycho.nsa.gov>
 <20150219154047.GA11807@linksys-wireless-usb.network2>
 <20150219193337.GC12937@tracyreed.org>
 <20150219204841.GA1649@linksys-wireless-usb.network2>
 <20150220003425.GF12937@tracyreed.org>
 <20150220020213.GG12937@tracyreed.org>
 <20150220073302.GA10579@linksys-wireless-usb.network2>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Q4RbCnAmn9VrkE5p"
In-Reply-To: <20150220073302.GA10579@linksys-wireless-usb.network2>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--Q4RbCnAmn9VrkE5p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2015 at 11:33:03PM PST, Dominick Grift spake thusly:
> Right, this table (login table) shows the associations of selinux identit=
ies
> and selinux securtity levels with linux users, whereas the "user table" s=
hows
> associations of selinux roles and security levels with selinux users.

Ok, I think I understand that now... Looks like they both can associate
security levels with their respective kinds of users. Seems odd now to be a=
ble
to associate security levels with Linux users instead of just SELinux users=
=2E=20

Now I am wondering which one takes precedence. For example, in the MCS setu=
p I
am attempting do I need to have the security category defined in the login
table or the user table or both?

> You are misunderstanding the concept of associating things with "selinux
> users" (user table) versus the concept of associating things with "linux
> users" (login table), and how the two relate.

Indeed.

> You cannot associate something with a Linux user if that something is not
> associated with the SELinux user first.

Ok...

> For example the error message above complains that you have a "appuser_u"
> identity associated with some "linux user(s)" (p16002, p16003). Howver th=
at
> identity (appuser_u) does not exist in your "user table".=20
>=20
> So to fix that error: re-add the appuser_u selinux user to the "user tabl=
e" ,
> then remove the references to "appuser_u" from the "login table" *first* ,
> and then finally remove the appuser_u association from the "user table"
> again.

Your use of "*first*" in the second step is confusing to me but it looks li=
ke
the order of operations here is:

1. re-add the appuser_u selinux user to the "user table"

2. remove the references to "appuser_u" from the "login table"

3. remove the appuser_u association from the "user table"


So to do step 1 and re-add appuser_u selinux user to the "user table" I sho=
uld do this and get this result:

# semanage user -a -R user_r appuser_u
libsemanage.validate_handler: selinux user appuser_u does not exist (No suc=
h file or directory).
libsemanage.validate_handler: seuser mapping [p16002 -> (appuser_u, s0:c1.c=
499-s0:c2)] is invalid (No such file or directory).
libsemanage.dbase_llist_iterate: could not iterate over records (No such fi=
le or directory).
/usr/sbin/semanage: Could not commit semanage transaction

Even if I try step 2 first (in case that's what you meant by *first) I get =
this:

# semanage login -d p16002
libsemanage.validate_handler: selinux user appuser_u does not exist (No suc=
h file or directory).
libsemanage.validate_handler: seuser mapping [p16003 -> (appuser_u, s0:c1.c=
499-s0:c3)] is invalid (No such file or directory).
libsemanage.dbase_llist_iterate: could not iterate over records (No such fi=
le or directory).
/usr/sbin/semanage: Could not commit semanage transaction

What am I missing here? Thanks!

--=20
Tracy Reed

--Q4RbCnAmn9VrkE5p
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFU58L1BhSTPg0d/nQRAtbhAKC59hYGgyhCRsuagY+HgsoPlNESnQCguVS0
VTByXDiiIqDMbGxl6/bLkWo=
=8/86
-----END PGP SIGNATURE-----

--Q4RbCnAmn9VrkE5p--
