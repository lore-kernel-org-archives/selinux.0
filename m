Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hATDLHRb000245
	for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 08:21:17 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hATDKdp5029674
	for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 13:20:40 GMT
Received: from node11.ravantivirus.com (node11.ravantivirus.com [213.233.121.11])
	by jazzswing.ncsc.mil  with ESMTP id hATDKct0029671
	for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 13:20:39 GMT
Date: Sat, 29 Nov 2003 15:21:11 +0200
From: Petre Rodan <petre.rodan@ravantivirus.com>
To: Russell Coker <russell@coker.com.au>
Cc: Petre Rodan <petre.rodan@ravantivirus.com>,
   SELinux <selinux@tycho.nsa.gov>
Subject: Re: policies for DJ Bernstein tools
Message-ID: <20031129132111.GA22741@peter.rav.local>
References: <20031128164612.GA32668@peter.rav.local> <200311292147.58963.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
In-Reply-To: <200311292147.58963.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


thank you for your comments.

On Sat, Nov 29, 2003 at 09:47:58PM +1100, Russell Coker wrote:
> On Sat, 29 Nov 2003 03:46, Petre Rodan <petre.rodan@ravantivirus.com> wro=
te:
> > I have searched for selinux policies for daemontools, ucspi-tcp, public=
file
> > and clockspeed. Failing to find them ment that I shoud try to create th=
em.
> > I'm not an expert in these matters, but I'm more than willing to try to
> > become one ;)
>=20
> I have added your changes to qmail.te and qmail.fc to my tree, it'll be o=
n my=20
> site in a few minutes.  I have modified them slightly so you will want to=
=20
> check that they still do what you require.  I removed the user_home_t lab=
el=20
> for the qmail alias directory as I don't think that's an appropriate type=
=2E =20
> Maybe etc_qmail_t will work.

acording to Dave Sill's 'life with qmail' install guide (the best one out t=
here)
alias is a pseudo-user that gets the mails that did not have a valid recipi=
ent on the server.
I gave him a user_home_t so he gets mail without other modifications done t=
o qmail_local_t.

for details:
http://www.lifewithqmail.org/lwq.html#aliases

there is also a list manager, called ezmlm (used on bugtraq for instance) t=
hat creates
=2Eqmail files and maildirs by default in ~alias (/var/qmail/alias). Then i=
t will receive posts=20
in that location.

> What is clockspeed?

it's a SNTP client available here:
http://cr.yp.to/clockspeed.html

the big difference between clockspeed and ntpd is the number of exploits ...

> I don't think that we want mua in it's current form.  It doesn't support=
=20
> running a mua from a console login.  It allows entering mua_t from staff_=
t=20
> and sysadm_t and allows writing to a pty from either.  This means that if=
 you=20
> can exploit the mua program (changing the $EDITOR variable appropriately=
=20
> should do it) then someone as staff_r can read/write to the pty of sysadm=
_t,=20
> this permits them to take over a sysadm_t session by inserting key stroke=
s in=20
> the buffer.

I understand, I will definitely rewrite that part somehow.
The reason I made this context is because I have a lot of scripts (eighter =
run=20
through ssh or by crond_t) that send mail with attachments using mutt.

These scripts run in different contexts and I had to add to each of them a =
lot of=20
qmail_inject, qmail_queue related rules.

I will check out if a domain_auto_trans to qmail_inject_t will do the trick.
I will also remove the mua.te and mua.fc from my selinux wishlist ;)

> Any time you have a single domain that can talk to the pty's from multipl=
e=20
> roles then it could be exploited to do some damage.  Currently we only al=
low=20
> this for newrole_t, system_chkpwd_t, and passwd_t (all of which can break=
 the=20
> system entirely if they are exploited regardless of what we do).

thanks for the tip.

> What is publicfile?  Some sort of ftp-like service?

it's a simple http and ftp daemon with no known exploits until now.
it runs out of tcpserver or from initrc_t.

URL:
http://cr.yp.to/publicfile.html

> For the ucspi-tcp service, why does it have so much access to qmail files=
 and=20
> programs?  Why not just domain_auto_trans() to the appropriate qmail=20
> domain(s)?

you are perfectly right. I made the change you requested. much cleaner this=
 way.
just download again http://team.rav.ro/peter/policy.tar.gz


> Also isn't ucspi-tcp is conceptually another version of inetd?  If that i=
s a=20
> currect summary then perhaps the correct solution would be to macroise th=
e=20
> inetd policy to support multiple versions of inetd and consider ucspi-tcp=
=20
> just another version of inetd (with a different set of ports that it is=
=20
> permitted to bind to).

This would be a great idea, but I'm still making my way through Stephen's d=
ocumentation
and his macros. I don't know if I will be able to make this macro stuff in =
the next=20
few days.

> What is svc?

it's a great `service manipulator`. his features are covered in
http://cr.yp.to/daemontools/faq/create.html#why

i use it on 15 servers and all my linux desktops. if one is not using them,=
 well, he should ;)

it can supervise use any daemon you can think of (ssh, apache, proftpd, tcp=
server, squid, etc).

> Finally it would make things a little easier to manage if you used the ma=
cros=20
> more.  For example this:
> allow svc_t svc_svc_t:dir { add_name read remove_name search getattr writ=
e };
> Could be changed to this:
> allow svc_t svc_svc_t:dir rw_dir_perms;

yes, reading those m4 macros is my number one priority

> Using the macro makes it much easier to read the policy.  In this example=
 the=20
> macro also adds ioctl and lock access, but I don't think that this does a=
ny=20
> harm with all the access that is already granted.  Similarly using can_ex=
ec()=20
> makes things easier to read.

this is exactly why i'm somewhat afraid to use them.

also please keep in mind that my fc files reflect the file locations given =
by
the gentoo distro. if support for other distro (or default file location) i=
s needed,=20
please inform me, and I'll make the needed aditions.

BTW,
you use the cvs.sourceforge.net:/cvsroot/selinux repository?
just to make sure we use the same source ...

best regards and happy weekend,
peter


> --=20
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page
>=20

--=20

Petre Rodan
Senior Network Engineer
GeCAD Software - RAV Division

----------------------------------------------------------------------
Tel/Fax: +40-21-321-7803
Hotline:  +40-21-321-7859

This message is confidential. It may also be privileged or otherwise=20
protected by work product immunity or other legal rules. It may contain
personal views which are not the views of the GeCAD unless specifically
stated.=20
If you have received it in error, please delete it from your system.=20
Do not use, copy or disclose the information in any way nor act in=20
reliance on it and notify the sender immediately.

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/yJ1HixMPpwVd7zERAmEPAJ9DV0O13sPxQ5gTsMNBD/End3yGxwCfZAPp
YYmSvptxBPn+fcUrVjrAVGI=
=Xqru
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
