Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p82EIV3L009489
	for <selinux@tycho.nsa.gov>; Fri, 2 Sep 2011 10:18:31 -0400
Received: from mail-ew0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p82EITgv028808
	for <selinux@tycho.nsa.gov>; Fri, 2 Sep 2011 14:18:30 GMT
Received: by ewy8 with SMTP id 8so1695998ewy.12
        for <selinux@tycho.nsa.gov>; Fri, 02 Sep 2011 07:18:12 -0700 (PDT)
Date: Fri, 2 Sep 2011 16:18:07 +0200
From: Dominick Grift <domg472@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: CentOS 5 RBAC
Message-ID: <20110902141806.GA25154@localhost.localdomain>
References: <4E5E68DB.1030101@roboreus.com>
 <1314810951.6850.26.camel@moss-pluto>
 <4E5E7757.5030007@roboreus.com>
 <1314814992.6850.38.camel@moss-pluto>
 <4E60BFF0.1070002@roboreus.com>
 <4E60CC80.1030001@tresys.com>
 <4E60DEE6.4030605@roboreus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
In-Reply-To: <4E60DEE6.4030605@roboreus.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 02, 2011 at 02:49:26PM +0100, Roy Badami wrote:
>=20
> >>Any idea what it is that gives sysadm_t write access to selinux_config_=
t:file ?
> >>
> >>I can see the rule when I opne the binary policy in apol but I haven't =
had much luck tracking down where it comes from in the policy source.
> >The auth_manage_all_files_except_shadow() call in userdom_admin_user_tem=
plate().
> >
>=20
> Ah, thank you!  I would never have found that on my own, given the
> number of macros and attributes that everything indirects through!
>=20
> So I'm beginning to realise that sysadm_r is probably the wrong
> starting point for me.  I think what I really want to be doing is
> probably creating a new 'limited admin' role (perhaps based on
> staff_r) and adding in only those permissions the role actually
> needs.

You could create a new role based off of the userdom_base_user_template, an=
d then map this newly created role to the staff_u user. So that staff_u can=
 newrole to the "new role". Then just tailor the role to your requirements.

A key property of the "base_user_template" is that this is not a login user=
 template. So the role can only be access through newrole/su. The new role =
cannot interact with user home directories.
>=20
> Thanks again,
>=20
> roy
>=20
> --=20
> Roy Badami
> Roboreus Ltd
> 1 New Oxford Street
> London WC1A 1NU
>=20
>=20
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov =
with
> the words "unsubscribe selinux" without quotes as the message.

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAk5g5Z4ACgkQMlxVo39jgT+e8QCgs8FOhsruR4CfhVhILHJz9Kb/
3uEAn01SGLkrKzLs3LaE4miGjSFlFSyj
=dGe9
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
