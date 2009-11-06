Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nA6MBX2N001475
	for <selinux@tycho.nsa.gov>; Fri, 6 Nov 2009 17:11:33 -0500
Received: from mail-ew0-f228.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id nA6MAXTW017019
	for <selinux@tycho.nsa.gov>; Fri, 6 Nov 2009 22:10:33 GMT
Received: by ewy28 with SMTP id 28so1643022ewy.18
        for <selinux@tycho.nsa.gov>; Fri, 06 Nov 2009 14:11:30 -0800 (PST)
Date: Fri, 6 Nov 2009 23:11:27 +0100
From: Dominick Grift <domg472@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: "security_compute_sid: invalid context" error when
 starting/stopping mysqld daemon
Message-ID: <20091106221120.GA4921@notebook3.grift.internal>
References: <81092d890911041557u78860e4ar65d2a1eb6964656e@mail.gmail.com>
 <4AF482CA.4090109@tycho.nsa.gov>
 <81092d890911061239t22c15f7p9aa4c907962de8cf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
In-Reply-To: <81092d890911061239t22c15f7p9aa4c907962de8cf@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2009 at 12:39:57PM -0800, Larry Ross wrote:
> On Fri, Nov 6, 2009 at 12:10 PM, Eamon Walsh <ewalsh@tycho.nsa.gov> wrote:
>=20
> >  On 11/04/2009 06:57 PM, Larry Ross wrote:
> > > I have two selinux users that need to be able to stop and start the
> > > mysql daemon, which is started by the initialization scripts.  When
> > > the daemon is stopped and started by the secadm_u user, it ends up in
> > > the context secadm_u:secadm_r:mysqld_t.  When it is stopped and
> > > started by the dbadm_u user, it ends up in the
> > > dbadm_u:dbadm_r:mysqld_t context.  When it is started by the init
> > > scripts it ends up in the system_u:system_r:mysqld_t domain.
> > >
> > > I would like it to alway end up in the system_r:mysqld_t domain, but
> > > can't seem to find any documentation that describes how to get that to
> > > work.
> > >
> > > If I add a role_transition rule to transition the role to system_r
> > > when the executable is run:
> > > role_transition sysadm_r mysqld_safe_exec_t system_r;
> > > role_transition dbadm_r  mysqld_safe_exec_t system_r;
> > > I end up getting these errors:
> > >
> > > Nov  4 15:41:36 localhost kernel: type=3D1401 audit(1257378096.775:46=
):
> > > security_compute_sid:  invalid context
> > > dbadm_u:system_r:mysqld_safe_t:s0 for
> > > scontext=3Ddbadm_u:dbadm_r:initrc_t:s0
> > > tcontext=3Dsystem_u:object_r:mysqld_safe_exec_t:s0 tclass=3Dprocess
> > >
> > > I believe I have the rules that should allow this, but obviously I am
> > > missing something.
> > > role dbadm_r types mysqld_safe_t;
> > > role sysadm_r types mysqld_safe_t;
> > > role system_r types mysqld_safe_t;
> > > and this:
> > > allow initrc_t mysqld_safe_t : process transition ;
> > > which is what the "security_compute_sid" message looks like it is
> > missing.
> > >
> > > Does anyone know where I can find a good description of how to get a
> > > service to transistion back into system_r when started by a user or
> > > have any idea what I am missing?
> >
> >
> > The run_init program was designed to solve this problem, take a look at
> > the man page.
> >
> > On Fedora at least, the "service" command calls run_init internally, so
> > doing "service mysqld start" should in theory start it up in the
> > system_r role.  If you're just running "/etc/init.d/mysld start" it
> > won't transition.
> >
> That would be great, but I am trying to use this as normal users on a sys=
tem
> to which the root account is locked.  As far as I know, run_init always a=
sks
> for the root password.  Is there a way to use it without having access to
> the root password?

I think you can use pam_rootok in /etc/pam.d/run_init. I dont know the deta=
ils of the top of my head because i use Fedora and the policy that i posted=
 earlier so that i automatically transition to initrc_t without run_init.

hth
>=20
> BTW, I am using RHEL 5.3, do you know if service there calls run_init
> internally?
>=20
>   Thank you,
>   Larry
>=20
>=20
>=20
> >
> >
> > --
> >
> > Eamon Walsh
> > National Security Agency
> >
> >

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkr0nwgACgkQMlxVo39jgT9RlACcDnpp/CUEvdEx1l5s9cvif1s+
bZUAnAo/3wHd4QMy2fqdDw701XOWYUhQ
=Sqw8
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
