Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m75ERch5017836
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 10:27:38 -0400
Received: from mail.gmx.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m75ERbSF021199
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 14:27:37 GMT
From: Dennis Wronka <linuxweb@gmx.net>
To: SELinux Mailing List <selinux@tycho.nsa.gov>
Subject: Re: Question about newrole
Date: Tue, 5 Aug 2008 22:27:31 +0800
References: <200808052155.18105.linuxweb@gmx.net> <1217945614.2994.74.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1217945614.2994.74.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1271883.qeThMIpfX7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200808052227.31582.linuxweb@gmx.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--nextPart1271883.qeThMIpfX7
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Just for the record, sent the initial reply to Stephen only.
Sorry for the glitch.

Rest at the bottom.

On Tuesday 05 August 2008 22:13:34 Stephen Smalley wrote:
> On Tue, 2008-08-05 at 21:55 +0800, Dennis Wronka wrote:
> > Hi folks,
> >
> > I'd like to ask about a problem I am experiencing with newrole.
> > When I use newrole in permissive-mode I have no problems changing the
> > role. Also I don't get any audit-messages.
> > But when I switch to enforcing-mode I cannot use newrole, it keeps
> > telling me "incorrect password for root", although it clearly is correc=
t.
> > I suspect a problem in interaction between newrole and unix_chkpwd, but
> > am not entirely sure about it.
> >
> > Problem is that I don't get any audits from SELinux, only errors in
> > auth.log from unix_chkpwd:
> > check_pass; user unknown
> > password check failer for user (root)
> >
> > I am working with the latest reference-policy, adjusted here and there =
to
> > fit the needs of my distro.
> >
> > Thanks for any suggestions.
>
> What version of pam are you using?  What distro?
> There were changes made to pam_unix and unix_chkpwd for selinux.
> Also, how are you building newrole?

I am using PAM 1.0.1 on the current development-version of EasyLFS. I am=20
currently working on the integration of SELinux and seem to be hanging on=20
this point.
I haven't set much focus towards newrole in the previous releases, but want=
 to=20
do so now.
newrole is the one from the policycoreutils 2.0.49, built simply with make =
&&=20
make install.

Btw, I think the same problem applies to run_init, will have to check to=20
confirm though.

--nextPart1271883.qeThMIpfX7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiYY1MACgkQ1sXw8/2VziSs8ACbBfdObWFxwoR9Im00kKnc1Ujr
qWkAoLQH0TSZtBdGLUiXNa71SpK6sj3E
=Lfys
-----END PGP SIGNATURE-----

--nextPart1271883.qeThMIpfX7--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
