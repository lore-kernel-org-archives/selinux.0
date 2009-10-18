Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9IAXss2010147
	for <selinux@tycho.nsa.gov>; Sun, 18 Oct 2009 06:33:54 -0400
Received: from mail-ew0-f228.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n9IAX11k010084
	for <selinux@tycho.nsa.gov>; Sun, 18 Oct 2009 10:33:02 GMT
Received: by ewy28 with SMTP id 28so3387660ewy.18
        for <selinux@tycho.nsa.gov>; Sun, 18 Oct 2009 03:33:51 -0700 (PDT)
Date: Sun, 18 Oct 2009 12:33:45 +0200
From: Dominick Grift <domg472@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: sshd error: Failed to get default security context
Message-ID: <20091018103341.GA8253@notebook1.grift.internal>
References: <81092d890910161715n12f3f523n16e02e08a3834b97@mail.gmail.com>
 <4AD9AD06.9030309@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
In-Reply-To: <4AD9AD06.9030309@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 17, 2009 at 07:39:50AM -0400, Daniel J Walsh wrote:
> On 10/16/2009 08:15 PM, Larry Ross wrote:
> > I have created a custom selinux user for the strict policy on RHEL5.3 w=
ho's
> > purpose is to connect via ssh and scp files off the machine.  When that=
 user
> > tries to login via ssh, I see the following messages in /var/log/secure:
> >=20
> > In enforcing:
> > Oct 16 07:49:40 localhost sshd[20461]: Accepted password for scpuser
> > from 192.168.1.1 port 64680 ssh2
> > Oct 16 07:49:40 localhost sshd[20461]: error: Failed to get default sec=
urity
> > context for scpuser.
> > Oct 16 07:49:40 localhost sshd[20461]: fatal: SELinux failure. Aborting
> > connection.
> >=20
> > In permissive:
> > Oct 16 07:55:59 localhost sshd[23302]: Accepted password for scpuser fr=
om
> > 192.168.1.1 port 56254 ssh2
> > Oct 16 07:55:59 localhost sshd[23302]: error: Failed to get default sec=
urity
> > context for scpuser.
> > Oct 16 07:55:59 localhost sshd[23302]: error: SELinux failure. Continui=
ng in
> > permissive mode.
> >=20
> > Could someone explain what these messages mean?

I am not sure about el5 but in Fedora:

the files in /etc/selinux/<policy model>/contexts/targeted have specificati=
ons that tell the login programs what context to use for the specified seus=
er when he logs in.

I wrote an article about adding customized user domains for Fedora:

http://selinux-mac.blogspot.com/2009/06/selinux-lockdown-part-four-customiz=
ed.html

And some screencasts:

http://selinux-mac.blogspot.com/2009/06/selinux-screencasts.html

> >=20
> > I believe that I have a default context defined in the "default context"
> > file that should work. I believe I have an executable context available=
 for
> > this user (using rbash rather than bash).
> >=20
> > How is sshd making this decision?  It looks like it is calling setexecc=
on,
> > but I'm not sure how that makes its decision.  Where should I look for =
clues
> > as to how to fix it?
> >=20
> >    Thank you,
> >    Larry
> >=20
> Did you add an entry to default_types?
>=20
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov =
with
> the words "unsubscribe selinux" without quotes as the message.

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkra7wUACgkQMlxVo39jgT85KwCdHltwCnuwgAwu8350W60Uka2Q
3DUAoNJ0IqgndbLgKRlahNjseWo8wNsr
=g+eG
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
