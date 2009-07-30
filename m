Subject: Re: Help with SELinux policy for Usability Study
From: Dominick Grift <domg472@gmail.com>
To: Cliffe <cliffe@ii.net>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>, slide@tresys.com
In-Reply-To: <4A71AD1A.5030406@ii.net>
References: <200907300352.n6U3qvAC012682@tarius.tycho.ncsc.mil>
	 <4A711890.2030101@ii.net>
	 <1248955358.11627.91.camel@moss-pluto.epoch.ncsc.mil>
	 <4A71AD1A.5030406@ii.net>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-fTb2YFpRvk+XjljR3D7b"
Date: Thu, 30 Jul 2009 19:39:59 +0200
Message-Id: <1248975599.14879.13.camel@notebook2.grift.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-fTb2YFpRvk+XjljR3D7b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-07-30 at 22:24 +0800, Cliffe wrote:
>=20
>=20
> Stephen Smalley wrote:=20
> > On Thu, 2009-07-30 at 11:50 +0800, Cliffe wrote:
> >  =20
> > > Dear SELinux Gurus,
> > >=20
> > > I am a PhD candidate conducting research into the usability of securi=
ty=20
> > > mechanisms. I would really appreciate some help regarding the use of=20
> > > SELinux. Let me know if this is not the right place to be asking thes=
e=20
> > > types of questions.
> > >    =20
> >=20
> > General usability questions, yes.  polgengui however is Fedora-specific
> > and thus fedora-selinux-list may be a more suitable choice.
> >=20
> > You should also take a look at SLIDE, an Eclipse plugin for creating
> > SELinux policies.  The upstream home page is at:
> > http://oss.tresys.com/projects/slide/
> > and the software should be available in Fedora via:
> > yum install eclipse-slide
> >=20
> >  =20
> > > I generated a policy for opera using polgengui. I then ran the genera=
ted=20
> > > ./opera.sh.
> > >=20
> > > Although SELinux was still set to enforcing mode opera seemed to run=20
> > > unconfined. The executable and process was labelled as expected=20
> > > (unconfined_u:unconfined_r:opera_t). AVCs were generated, but not enf=
orced.
> > >=20
> > > I added to opera.te using
> > > grep opera /var/log/audit/audit.log | audit2allow >> opera.te
> > > and reran ./opera.sh
> > > until no AVCs were generated.
> > >=20
> > > Looking at opera.te I noticed the line =E2=80=9Cpermissive opera_t=E2=
=80=9D, and not=20
> > > knowing exactly what this line does, I thought it may be placing this=
=20
> > > domain into permissive mode (although the gui tools suggest otherwise=
).=20
> > > Removing the line causes =E2=80=9C/bin/sh: /usr/bin/opera: Permission=
 denied=E2=80=9D.=20
> > > No AVCs are generated.
> > >    =20
> >=20
> > Yes, permissive opera_t causes the domain to run in permissive mode
> > while leaving the rest of the system enforcing.  Per-domain permissive
> > mode was introduced in Fedora 10, I think.
> >=20
> >  =20
> > > So I am not sure why opera seams to be unconfined, or if removing the=
=20
> > > permissive line was on the right track. Any advice?
> > >    =20
> >=20
> > Yes, removing the permissive line is the right track to take when you
> > are ready to test in enforcing mode.  If you don't see any AVC denials,
> > then try running semodule -DB to strip all dontaudit rules from policy
> > and then re-test, followed by semodule -B again to restore the dontaudi=
t
> > rules.  This will generate a _lot_ of denials, some of which are
> > irrelevant, but should then show you all denials.  dontaudit rules are
> > used to suppress denials that come from harmless application or library
> > probing (e.g. getcwd) that are not required for operation of the
> > application, but may sometimes mask real denials.
> >=20
> > I'm not sure why polgengui is automatically adding a permissive line in
> > this case but not in the case of kwrite - Dan?  It should be consistent=
,
> > and it really only should do that with user consent as the user needs t=
o
> > know that the domain is permissive.=20
> >  =20
>=20
> It adds the permissive line to both (I am not sure why kwrite seemed
> to be in enforcing mode). But the gui does not make this clear. I have
> mentioned this to the fedora-selinux mailing list.

I suspect this was due to dbus. kwrite_t may have been permissive but
other domains that needed interaction with kwrite to make it work were
enforced. So that why it seems that kwrite was enforced but really was
not.


> > > Also I tried creating a policy for kwrite. This time the created poli=
cy=20
> > > seemed to be in effect as soon as I ran the kwrite.sh script. I set=20
> > > setenforce 0 and added to kwrite.te (as above for opera) until no err=
or=20
> > > msgs were generated. Then I reran ./kwrite.sh. Now kwrite exists with=
=20
> > > =E2=80=9Ckwrite(2533): Couldn=E2=80=99t register name =E2=80=98=E2=80=
=9Dorg.kate-editor.kwrite-2533=E2=80=99=E2=80=9D=20
> > > with DBUS =E2=80=93 another process owns it already!=E2=80=9D. When s=
etenforce 0 it runs=20
> > > without AVCs.
> > >    =20
> >=20
> > Sounds like you are getting a DBUS denial, so look for USER_AVC message=
s
> > e.g.
> > /sbin/ausearch -i -m USER_AVC.
> >  =20
>=20
> None there. It turns out they were in /var/log/messages
>=20
> so=20
> grep kwrite /var/log/audit/audit.log | audit2allow >> kwrite.te
> did the trick. It is strange that some AVCs go to /var/log/messages
> while others goto=20
> /var/log/audit/audit.log

Agreed.
=20
> Thanks for all your advice, it has helped a lot.
>=20
> Cliffe.

--=-fTb2YFpRvk+XjljR3D7b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkpx2ukACgkQMlxVo39jgT/9CgCfb12dOOXEhTxMcfkI71ohMeks
CTAAoJfq/W3XSJscwjnpVkk3qcw216dZ
=m6PZ
-----END PGP SIGNATURE-----

--=-fTb2YFpRvk+XjljR3D7b--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
