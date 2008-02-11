Subject: Re: newrole transition problems w/ local user domain
From: Jeremiah Jahn <jeremiah@goodinassociates.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1202738786.24250.38.camel@moss-spartans.epoch.ncsc.mil>
References: <1202507600.3577.51.camel@bluejay.goodinassociates.com>
	 <1202738786.24250.38.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-vq1lXKDTvr4xZVcL6+x+"
Date: Mon, 11 Feb 2008 12:16:49 -0600
Message-Id: <1202753809.3577.247.camel@bluejay.goodinassociates.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-vq1lXKDTvr4xZVcL6+x+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-02-11 at 09:06 -0500, Stephen Smalley wrote:
> On Fri, 2008-02-08 at 15:53 -0600, Jeremiah Jahn wrote:
> > for some reason, I can't seem to get newrole to do it's thing.=20
> >=20
> > example:
> > [bob@XXXX ~]$ newrole -r monetra_admin_r -t monetra_admin_t
> > Authenticating bob.
> > Password:=20
> > failed to exec shell
> > : Permission denied
> >=20
> > audit log has:
> > type=3DUSER_AUTH msg=3Daudit(1202507011.151:2157): user pid=3D21599 uid=
=3D504 auid=3D504 subj=3Dmonetra_adm_u:monetra_adm_r:newrole_t:s0 msg=3D'PA=
M: authentication acct=3D"bob" : exe=3D"/usr/bin/newrole" (hostname=3D?, ad=
dr=3D?, terminal=3Dpts/3 res=3Dsuccess)'
> > type=3DUSER_ACCT msg=3Daudit(1202507011.151:2158): user pid=3D21599 uid=
=3D504 auid=3D504 subj=3Dmonetra_adm_u:monetra_adm_r:newrole_t:s0 msg=3D'PA=
M: accounting acct=3D"bob" : exe=3D"/usr/bin/newrole" (hostname=3D?, addr=
=3D?, terminal=3Dpts/3 res=3Dsuccess)'
> > type=3DUSER_START msg=3Daudit(1202507011.152:2159): user pid=3D21600 ui=
d=3D504 auid=3D504 subj=3Dmonetra_adm_u:monetra_adm_r:newrole_t:s0 msg=3D'P=
AM: session open acct=3D"bob" : exe=3D"/usr/bin/newrole" (hostname=3D?, add=
r=3D?, terminal=3Dpts/3 res=3Dsuccess)'
> > type=3DUSER_ROLE_CHANGE msg=3Daudit(1202507011.152:2160): user pid=3D21=
600 uid=3D504 auid=3D504 subj=3Dmonetra_adm_u:monetra_adm_r:newrole_t:s0 ms=
g=3D'newrole: old-context=3Dmonetra_adm_u:monetra_adm_r:monetra_adm_t:s0 ne=
w-context=3Dmonetra_adm_u:monetra_admin_r:monetra_admin_t:s0
> > : exe=3D"/usr/bin/newrole" (hostname=3D?, addr=3D?, terminal=3D/dev/pts=
/3 res=3Dsuccess)'
> > type=3DAVC msg=3Daudit(1202507011.152:2161): avc:  denied  { transition=
 } for  pid=3D21600 comm=3D"newrole" path=3D"/bin/bash" dev=3Dsda1 ino=3D32=
7714 scontext=3Dmonetra_adm_u:monetra_adm_r:newrole_t:s0 tcontext=3Dmonetra=
_adm_u:monetra_admin_r:monetra_admin_t:s0 tclass=3Dprocess
> > type=3DSYSCALL msg=3Daudit(1202507011.152:2161): arch=3D40000003 syscal=
l=3D11 success=3Dno exit=3D-13 a0=3D9cbe010 a1=3Dbff58a64 a2=3D9cc4fc0 a3=
=3D0 items=3D0 ppid=3D21599 pid=3D21600 auid=3D504 uid=3D504 gid=3D504 euid=
=3D504 suid=3D504 fsuid=3D504 egid=3D504 sgid=3D504 fsgid=3D504 tty=3Dpts3 =
comm=3D"newrole"=20
> > exe=3D"/usr/bin/newrole" subj=3Dmonetra_adm_u:monetra_adm_r:newrole_t:s=
0 key=3D(null)
> >=20
> > and yet my te file has:
> > allow newrole_t monetra_admin_t:process transition;
>=20
> So the denial is due to something other than TE, e.g. RBAC or a
> constraint. audit2why would give you a hint as to the cause.
>=20
> Looking at your denial, I see that not only are you changing domain but
> also role, from monetra_admin_r to monetra_adm_r.  Not sure how those
> two roles are supposed to differ (the names sound the same conceptually,
> even if they are different), but you'd need a rbac allow rule:
> 	allow monetra_admin_r monetra_adm_r;
>=20
> Normally I think that kind of thing gets covered by a call to
> userdom_role_change_template(), see userdomain.te for examples.
>=20
> >=20
> > I added a role to no avail:
> > role monetra_admin_r types newrole_t;
> >=20
> >=20
> > this just produced errors about old TE rules an new te rule conflicts:
> > domain_type(monetra_admin_t)
> > #domain_entry_file(monetra_admin_t , newrole_exec_t )
> > #domain_auto_trans(monetra_adm_t,newrole_exec_t,monetra_admin_t)
> >=20
> > could it be I need to use somthing other than:
> > userdom_unpriv_user_template(monetra_adm)?
> >=20
> >=20
> > thanx

using userdom_role_change_template worked like a dream, as long as it
comes _after_ userdom_unpriv_user_template and the types.  They both
seem to declare the type, but in the right order things are great.

thank you for your help,
I may get to actually shave soon.=20






"I'll rob that rich person and give it to some poor deserving slob. That
will *prove* I'm Robin Hood." -- Daffy Duck, "Robin Hood Daffy", [1958,
Chuck Jones]

--=-vq1lXKDTvr4xZVcL6+x+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHsJER6caZY8jbHDkRAvALAJ9eIv9yVe3R0FP2khBDlp4f0DnINgCgvhYy
pTG1QtrGHGZrdQgIFJoRxz8=
=kqPz
-----END PGP SIGNATURE-----

--=-vq1lXKDTvr4xZVcL6+x+--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
