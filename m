Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hATE6eRb000444
	for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 09:06:40 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hATE6dqY025796
	for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 14:06:39 GMT
Received: from node11.ravantivirus.com (node11.ravantivirus.com [213.233.121.11])
        by jazzband.ncsc.mil  with ESMTP id hATE6c0o025793 for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 14:06:39 GMT
Date: Sat, 29 Nov 2003 16:06:37 +0200
From: Petre Rodan <petre.rodan@ravantivirus.com>
To: Russell Coker <russell@coker.com.au>
Cc: Petre Rodan <petre.rodan@ravantivirus.com>,
   SELinux <selinux@tycho.nsa.gov>
Subject: Re: policies for DJ Bernstein tools
Message-ID: <20031129140637.GA10673@peter.rav.local>
References: <20031128164612.GA32668@peter.rav.local> <200311292147.58963.russell@coker.com.au> <20031129132111.GA22741@peter.rav.local> <200311300041.15386.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
In-Reply-To: <200311300041.15386.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2003 at 12:41:15AM +1100, Russell Coker wrote:
> On Sun, 30 Nov 2003 00:21, Petre Rodan <petre.rodan@ravantivirus.com> wro=
te:
> > > I have added your changes to qmail.te and qmail.fc to my tree, it'll =
be
> > > on my site in a few minutes.  I have modified them slightly so you wi=
ll
> > > want to check that they still do what you require.  I removed the
> > > user_home_t label for the qmail alias directory as I don't think that=
's
> > > an appropriate type. Maybe etc_qmail_t will work.
> >
> > acording to Dave Sill's 'life with qmail' install guide (the best one o=
ut
> > there) alias is a pseudo-user that gets the mails that did not have a v=
alid
> > recipient on the server. I gave him a user_home_t so he gets mail witho=
ut
> > other modifications done to qmail_local_t.
>=20
> This will require more investigation.  However ~alias is different from a=
=20
> regular user home directory, and it seems unlikely that you would want us=
er_r=20
> to write to it.  So therefore user_home_t seems like the wrong type for i=
t.
>=20
> We could create a new qmail_home_t type which has attributes home_type an=
d=20
> user_home_type to allow qmail to access it.

qmail_home_t sounds just perfect to me.

my only requirement would be that sysadm_t should be able to have full acce=
ss there.
ezmlm (http://www.ezmlm.org) has a lot of binaries that fool around with fi=
les in ~alias.
the manager of the list (usualy sysadm_t) should be able to make his job in=
side
~alias without new policy rules. maybe it would be even simpler to make ~al=
ias a
sysadm_home_t. just a thought.

> > > What is clockspeed?
> >
> > it's a SNTP client available here:
> > http://cr.yp.to/clockspeed.html
> >
> > the big difference between clockspeed and ntpd is the number of exploits
> > ...
>=20
> So why not have clockspeed run in ntpd_t?

clockspeed uses some files (cs_atto_t, cs_etc_t) and a cs_adjust_t fifo tha=
t kinda=20
makes him unique (or maybe I am wrong?)

anyhow, I'm still investigating the usefulness of some of the rules i wrote.
the locations of some of the files should be also changed in the distro.
his adition should be postponed.

> > I understand, I will definitely rewrite that part somehow.
> > The reason I made this context is because I have a lot of scripts (eigh=
ter
> > run through ssh or by crond_t) that send mail with attachments using mu=
tt.
>=20
> Doesn't mutt just run "sendmail -t"?  If not why not?  If so then why doe=
sn't=20
> it get staff_mail_t for the sendmail process?

i use qmail on all my machines. he comes with a sendmail of his own located=
 in=20
/var/qmail/bin/sendmail.=20
/usr/sbin/sendmail is a symlink to /var/qmail/bin/sendmail, and both are la=
beled as
system_u:object_r:bin_t
so there is no domain_auto_trans to staff_mail_t.

maybe we should label them the way sendmail is labeled on your machine and=
=20
voila, no more problems.

> > you use the cvs.sourceforge.net:/cvsroot/selinux repository?
> > just to make sure we use the same source ...
>=20
> I maintain my own policy tree based on the NSA release plus all patches t=
hat=20
> flow through this list and other sources.  It often varies significantly =
=66rom=20
> the CVS, but at the moment there is not much difference.

ok, got that.

thanks for your help,
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

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/yKftixMPpwVd7zERApxkAJ9kZ8SgVobOACAdNrBS58wMR7wbPQCgprbW
0xnpYelxcezFGBJPEM6u8HI=
=Za0B
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
