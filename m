Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6PLBJVf022712
	for <selinux@tycho.nsa.gov>; Sat, 25 Jul 2009 17:11:19 -0400
Received: from mail-ew0-f217.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n6PLCA83018377
	for <selinux@tycho.nsa.gov>; Sat, 25 Jul 2009 21:12:10 GMT
Received: by ewy17 with SMTP id 17so2780453ewy.18
        for <selinux@tycho.nsa.gov>; Sat, 25 Jul 2009 14:11:17 -0700 (PDT)
Subject: Re: "Error! Unable to set executable context."
From: Dominick Grift <domg472@gmail.com>
To: Larry Ross <selinux.larry@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <81092d890907251359x4eb2914v3247c752d326e612@mail.gmail.com>
References: <81092d890907251241k5ef56a87p2f6d6f763b25b70@mail.gmail.com>
	 <1248553007.13970.3.camel@notebook2.grift.internal>
	 <81092d890907251359x4eb2914v3247c752d326e612@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-2xeh/MVF664pH9ob4En2"
Date: Sat, 25 Jul 2009 23:11:14 +0200
Message-Id: <1248556274.13970.11.camel@notebook2.grift.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-2xeh/MVF664pH9ob4En2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2009-07-25 at 13:59 -0700, Larry Ross wrote:
> On Sat, Jul 25, 2009 at 1:16 PM, Dominick Grift <domg472@gmail.com>
> wrote:
> On Sat, 2009-07-25 at 12:41 -0700, Larry Ross wrote:
> > I am trying to create a custom selinux user for the strict policy on
> > RHEL5.3
> > I want logins that are mapped to this user to be able to login via
> > gdm, but when they do I get an error "Error! Unable to set
> executable
> > context."
> >
> > What does this error message mean?
> >
> > I am able to login via gdm with logins that are mapped to user_u.  I
> > have run the AVCs generated when I login in permissive mode (which
> > succeeds) through audit2allow and gotten to the point where it
> doesn't
> > seem that I am getting any killer AVCs.  What am I missing that is
> > needed for a custom user to use X-Windows?  Is there some place I
> can
> > look to determine what is causing the error?
> >
> >    Thank you,
> >    Larry
> >
> > /var/log/messages:
> >  Jul 25 11:51:21 newhost gdm[4673]: SELinux gdm login: unable to
> > obtain default security context for appuser.
> >
> >
> >  /var/log/audit/audit.log:
> > type=3DUSER_AUTH msg=3Daudit(1248550033.507:1432): user pid=3D3003 uid=
=3D0
> > auid=3D14022 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023 msg=3D'PAM:
> > authentication acct=3D"?" : exe=3D"/usr/sbin/gdm-binary" (hostname=3D?,
> > addr=3D?, terminal=3D:0 res=3Dfailed)'
> > type=3DUSER_LOGIN msg=3Daudit(1248550033.507:1433): user pid=3D3003 uid=
=3D0
> > auid=3D14022 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023
> > msg=3D'acct=3Ddbapp: exe=3D"/usr/sbin/gdm-binary" (hostname=3Dnewhost,
> > addr=3D127.0.0.1, terminal=3D:0 res=3Dfailed)'
> > type=3DUSER_AUTH msg=3Daudit(1248550043.787:1434): user pid=3D3003 uid=
=3D0
> > auid=3D14022 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023 msg=3D'PAM:
> > authentication acct=3D"appuser" :
> > exe=3D"/usr/sbin/gdm-binary" (hostname=3D?, addr=3D?, terminal=3D:0
> > res=3Dsuccess)'
> > type=3DUSER_ACCT msg=3Daudit(1248550043.789:1435): user pid=3D3003 uid=
=3D0
> > auid=3D14022 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023 msg=3D'PAM:
> > accounting acct=3D"appuser" : exe=3D"/usr/sbin/gdm-binary" (hostname=3D=
?,
> > addr=3D?, terminal=3D:0 res=3Dsuccess)'
> > type=3DCRED_ACQ msg=3Daudit(1248550043.790:1436): user pid=3D3003 uid=
=3D0
> > auid=3D14022 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023 msg=3D'PAM:
> > setcred acct=3D"appuser" : exe=3D"/usr/sbin/gdm-binary" (hostname=3D?,
> > addr=3D?, terminal=3D:0 res=3Dsuccess)'
> > type=3DLOGIN msg=3Daudit(1248550043.796:1437): login pid=3D3003 uid=3D0=
 old
> > auid=3D14022 new auid=3D14020 old ses=3D35 new ses=3D36
> > type=3DUSER_START msg=3Daudit(1248550043.804:1438): user pid=3D3003 uid=
=3D0
> > auid=3D14020 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023 msg=3D'PAM:
> > session open acct=3D"appuser" :
> exe=3D"/usr/sbin/gdm-binary" (hostname=3D?,
> > addr=3D?, terminal=3D:0 res=3Dsuccess)'
> > type=3DUSER_LOGIN msg=3Daudit(1248550043.804:1439): user pid=3D3003 uid=
=3D0
> > auid=3D14020 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023
> msg=3D'uid=3D14020:
> > exe=3D"/usr/sbin/gdm-binary" (hostname=3Dnewhost, addr=3D127.0.0.1,
> > terminal=3D:0 res=3Dsuccess)'
> > type=3DUSER_END msg=3Daudit(1248550092.461:1440): user pid=3D3003 uid=
=3D0
> > auid=3D14020 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023 msg=3D'PAM:
> > session close acct=3D"appuser" :
> exe=3D"/usr/sbin/gdm-binary" (hostname=3D?,
> > addr=3D?, terminal=3D:0 res=3Dsuccess)'
> > type=3DCRED_DISP msg=3Daudit(1248550092.461:1441): user pid=3D3003 uid=
=3D0
> > auid=3D14020 subj=3Dsystem_u:system_r:xdm_t:s0-s0:c0.c1023 msg=3D'PAM:
> > setcred acct=3D"appuser" : exe=3D"/usr/sbin/gdm-binary" (hostname=3D?,
> > addr=3D?, terminal=3D:0 res=3Dsuccess)'
> >
>=20
> Dominick,
>   Thank you for your reply.
>=20
>         probably means you have no default contexts defined for
>         "appuser"
> =20
> How do I define a default context for an selinux user?

Well this is how a default contexts file looks for the user_u selinux
user in fedora (targeted policy):

[root@notebook2 ~]# cat /etc/selinux/targeted/contexts/users/user_u
system_r:local_login_t:s0       user_r:user_t:s0
system_r:remote_login_t:s0      user_r:user_t:s0
system_r:sshd_t:s0              user_r:user_t:s0
system_r:crond_t:s0             user_r:user_t:s0
system_r:xdm_t:s0               user_r:user_t:s0
user_r:user_su_t:s0             user_r:user_t:s0
user_r:user_sudo_t:s0           user_r:user_t:s0
system_r:initrc_su_t:s0         user_r:user_t:s0
user_r:user_t:s0                user_r:user_t:s0


>         can you show us the output of 'semanage user -l | grep
>         appuser'?
> =20
> [root@newhost ~]# semanage user -l | grep appuser
>=20
> returns no results, as I would expect, appuser is a linux login id,
> not an selinux user.
>=20
> [root@newhost ~]# semanage login -l | grep appuser
> appuser                   app_user_u                 s0

semanage user -l | grep app_user_u

>=20
>        =20
>         If this user is based of off user_u you could simply:
>        =20
>         cp /etc/selinux/contexts/users/user_u /etc/selinux/contexts/users=
/appuser
>        =20
>         but it depends on how your appuser selinux-user is configured
>         ( whats
>         his default domain )
> =20
> The only thing in /etc/selinux/strict/contexts/users/
> is "root", there is no file there for user_u.

That's weird, i would expect default contexts be defined since you
stated that your user_u login works. Maybe it is stored in a different
location in el5.

See if you can locate a file called user_u or any other file that may
have similar entries as i pasted above in
you /etc/selinux/strict/contexts (and /users).

> =20
>   -- Larry
>=20

--=-2xeh/MVF664pH9ob4En2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkprdOwACgkQMlxVo39jgT+nfgCeOix1ZQVHRgCkc38jvSZjlkjk
BrgAoLFq6qCYPHOKc8qTBxrrs67fTYsg
=1U91
-----END PGP SIGNATURE-----

--=-2xeh/MVF664pH9ob4En2--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
