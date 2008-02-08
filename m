Subject: Re: new user types
From: Jeremiah Jahn <jeremiah@goodinassociates.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1202498029.27371.409.camel@moss-spartans.epoch.ncsc.mil>
References: <1202426088.2801.500.camel@bluejay.goodinassociates.com>
	 <1202479171.27371.320.camel@moss-spartans.epoch.ncsc.mil>
	 <1202494415.3577.18.camel@bluejay.goodinassociates.com>
	 <1202498029.27371.409.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3tRR6/eUbL0kIMQqXc/v"
Date: Fri, 08 Feb 2008 14:12:54 -0600
Message-Id: <1202501574.3577.35.camel@bluejay.goodinassociates.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-3tRR6/eUbL0kIMQqXc/v
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

That worked:

userdom_unpriv_user_template(client)
user client_u roles { client_r } level s0 range s0 - s0;

plus
semanage login -a -s client_u bob

Gave me what I want. I found it easier to look through userdomain.if
than the website. I also had to remove some of the types I'd already
declared since the template will re-declare them according to the
prefix.=20

thanx alot,
-jj-


On Fri, 2008-02-08 at 14:13 -0500, Stephen Smalley wrote:
> On Fri, 2008-02-08 at 12:13 -0600, Jeremiah Jahn wrote:
> > On Fri, 2008-02-08 at 08:59 -0500, Stephen Smalley wrote:
> > > On Thu, 2008-02-07 at 17:14 -0600, Jeremiah Jahn wrote:
> > > > I can't seem to login as the right user, and I'm not sure what I mi=
ssed.
> > > >=20
> > > > I added the following roles and users to my monetra.te file:
> > > >=20
> > > >=20
> > > > #admin roles
> > > > role monetra_admin_r types monetra_t;
> > > > role monetra_admin_r types monetra_lib_t;
> > >=20
> > > role-type statements are only required for domain types, not file typ=
es.
> > > Files use the generic object_r role.
> > thanx.
> >=20
> >=20
> > >=20
> > > > #client roles
> > > > role monetra_client_r types monetra_t;
> > > > role monetra_client_r types monetra_lib_t;
> > > > role monetra_client_r types monetra_client_t;
> > > >=20
> > > > #monetra users
> > > > user monetra_u roles { monetra_client_r monetra_admin_r } level s0 =
range s0 - s0;
> > > >=20
> > > >=20
> > > >=20
> > > >=20
> > > > I ran the add login command:
> > > > semanage login -a -s monetra_u bob
> > > >=20
> > > >=20
> > > >=20
> > > > I get the following output:
> > > > [root@xxx ~]# semanage login -l
> > > >=20
> > > > Login Name                SELinux User              MLS/MCS Range  =
         =20
> > > >=20
> > > > __default__               user_u                    s0             =
         =20
> > > > root                      root                      s0-s0:c0.c255  =
         =20
> > > > system_u                  system_u                  s0-s0:c0.c255  =
         =20
> > > > bob                      monetra_u                 s0              =
        =20
> > > >=20
> > > > [root@xxx ~]# semanage user -l
> > > >=20
> > > >                 Labeling   MLS/       MLS/                         =
=20
> > > > SELinux User    Prefix     MCS Level  MCS Range                    =
  SELinux Roles
> > > >=20
> > > >=20
> > > > monetra_u       user       s0         s0                           =
  monetra_admin_r monetra_client_r
> > > > root            sysadm     s0         s0-s0:c0.c255                =
  sysadm_r staff_r
> > > > staff_u         staff      s0         s0-s0:c0.c255                =
  sysadm_r staff_r
> > > > sysadm_u        sysadm     s0         s0-s0:c0.c255                =
  sysadm_r
> > > > system_u        user       s0         s0-s0:c0.c255                =
  system_r
> > > > unconfined_u    unconfined s0         s0-s0:c0.c255                =
  unconfined_r
> > > > user_u          user       s0         s0                           =
  user_r
> > > >=20
> > > > yet when I login I get:
> > > > [bob@xxx ~]$ id -Z
> > > > system_u:system_r:unconfined_t:s0-s0:c0.c255
> > > >=20
> > > >=20
> > > > thanx for any help you can give.
> > >=20
> > > First, by login, I assume you mean a real login (via console login, g=
dm,
> > > or ssh), not just a su.  su doesn't change SELinux context in RHEL 5.
> > correct.
> >=20
> > >=20
> > > Second, have you authorized a domain transition from the domain in wh=
ich
> > > the login process is running to your new domain?
> > can you give me a quick pointer as to where to go to find an example of
> > this? userdomain.te didn't help, nor locallogin.te. I need to both do i=
t
> > from the console, and from ssh. And one other dumb question, what the
> > heck are prefixes, and how do they apply to this?=20
>=20
> (cc'ing Chris, refpolicy maintainer)
>=20
> The login domains call the userdom_spec_domtrans_all_users() or
> unpriv_users() interfaces to allow the domain transition to happen to
> user domains, where user domains have the 'userdomain' attribute (when
> declared via the userdom_base_user_template() interface or one of its
> callers).
>=20
> You also need to allow the role transition to happen and to ensure that
> the constraint passes.  All of which should be covered if using
> userdom_base_user_template() or one of its callers to define your user
> domain.
>=20
> The prefix is the string prepended to the home directory types for the
> user domain.  Conventionally, this is the same as the user domain
> prefix, e.g. user_t has prefix "user", thus yielding user_home_dir_t,
> user_home_t, etc for the home directory labeling.
>=20
> Chris can likely comment on the best way to create new roles presently;
> there has been work done to simplify it and allow tools like SLIDE to
> help automate it.
>=20
> --=20
> Stephen Smalley
> National Security Agency
The President publicly apologized today to all those offended by his
brother's remark, "There's more Arabs in this country than there is
Jews!". Those offended include Arabs, Jews, and English teachers. --
Baltimore, Channel 11 News, on Jimmy Carter

--=-3tRR6/eUbL0kIMQqXc/v
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHrLfG6caZY8jbHDkRAnOLAJ9bb5nxsX0XRj4uZNeO5bg3MjtiLACggP7E
D+07GzASMHol25shtXTuXyo=
=Zwd2
-----END PGP SIGNATURE-----

--=-3tRR6/eUbL0kIMQqXc/v--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
