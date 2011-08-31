Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7VHmCbO002889
	for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2011 13:48:12 -0400
Received: from mail-ew0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7VHmBKk008701
	for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2011 17:48:11 GMT
Received: by ewy8 with SMTP id 8so701229ewy.12
        for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2011 10:48:10 -0700 (PDT)
Date: Wed, 31 Aug 2011 19:48:07 +0200
From: Dominick Grift <domg472@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: CentOS 5 RBAC
Message-ID: <20110831174805.GC11607@localhost.localdomain>
References: <4E5E68DB.1030101@roboreus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
In-Reply-To: <4E5E68DB.1030101@roboreus.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 31, 2011 at 06:01:15PM +0100, Roy Badami wrote:
> I'm trying to understand the RBAC features in the version of the mls
> (and also strict) policies that ship with CentOS 5.6 - I'm not sure
> if this is the best place to ask or if there's a more appropriate
> list.

refpolicy@oss.tresys.com is more appropriate.

>=20
> Starting with the mls policy, and setting the secure_mode_loadpolicy
> boolean to 'on'  I then get that *neither* sysadm_r *nor* secadm_r
> can issue commands such as setenforce.  Yet userdomain.te contains
> the following code:
>=20
> ifdef(`strict_policy',`
> [...]
>         optional_policy(`
>                 seutil_run_restorecon(sysadm_t,sysadm_r,admin_terminal)
>                 seutil_run_runinit(sysadm_t,sysadm_r,admin_terminal)
>=20
>                 ifdef(`enable_mls',`

> userdom_security_administrator(secadm_t,secadm_r,{
> secadm_tty_device_t sysadm_devpts_t })
> #                       tunable_policy(`allow_sysadm_manage_security',`
> userdom_security_administrator(sysadm_t,sysadm_r,admin_terminal)
> #                       ')
>                 ', `
> userdom_security_administrator(sysadm_t,sysadm_r,admin_terminal)
>                 ')
>         ')
> [...]
> ')

When you build mls policy you get a seperate secadm role when you build str=
ict policy then sysadm role also has the capabilities that secadm role in m=
ls has.=20

Not sure how thats done in el5 but currently its done like so: (sysadm.te:)

ifndef(`enable_mls',`
	userdom_security_admin_template(sysadm_t, sysadm_r)
')

meaning if enable_mls is not defined then allow sysadm_t to be security adm=
inistrator.

secadm role only being in mls policy, is a decision made. probably related =
to confidentiality or some cerification requirement. i do not know.

As for securemode_policy_load boolean that is conditional policy e.g. when =
its set then caller is not allowed to "setbool", "load_policy" and "setenfo=
rce" (these are permission for the security class)

example (shortened for brevity)

	if(!secure_mode_policyload) {
		allow $1 security_t:security load_policy;
	}

if secure_module_policload is not defined then allow caller to load policy.

as for how come secadm_u is only available in mls i am not sure how but i b=
et part of it probablty could be that the module just is not installed (can=
 be defined in modules.conf which modules to install)

but the mapping is specified in the users file:

gen_user(staff_u, staff, staff_r sysadm_r ifdef(`enable_mls',`secadm_r audi=
tadm_r'), s0, s0 - mls_systemhigh, mcs_allcats)

basically saying if enable_mls is defined then map secadm_r and auditadm_r =
roles to staff_u. else not.

>=20
> Now as far as I can see from the specfile the mls policy passes
> NAME=3Dmls TYPE=3Dstrict-mls to the makefile, and the makefile in turn
> defines strict_policy and enable_mls in response to TYPE=3Dstrict-mls
> - and yet as far as I can tell from running apol the actual binary
> policy in the selinux-policy-mls RPM ends up not containing any TE
> rule to allow sysadm_t or secadm_t to run setenforce - despite the
> fact that it would appear that the userdom_security_administrator
> macro should appear to expand into such rules.
>=20
> What am I overlooking here?
>=20
> Just out of interest, I then went and tried the strict policy.  Yet
> this policy doesn't even have a secadm_r and again I don't
> understand why.  The specfile builds it with NAME=3Dstrict

probably a requirement for mls (certification) to have a seperate secadm_r =
and may not make much sense in strict. therefore sysadm_r also has the seca=
dm capabilities in strict.

> TYPE=3Dstrict-mcs and from my reading of the makefile an -mcs policy
> should again set enable_mls.    And kernel.ke continas the
> following, so I don't quite see why the policy doesn't end up
> containing these roles.
>=20
> ifdef(`enable_mls',`
>         role secadm_r;
>         role auditadm_r;
> ')

well whether the modules are installed (semodule -l | grep secadm) that i g=
uess would be defined manually in the modules.conf for strict. if the secad=
m module is installed then it could be that the role is just not mapped to =
staff_u unless policy is mls ( see above: users file snippet)

> Any pointers to what I'm missing here would be appreciated.
>=20
> Regards
>=20
> Roy
>=20
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

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAk5ec9UACgkQMlxVo39jgT+Z3ACeM8OTHOHn4yVIQxDfVjBMQSkZ
pGsAnRyBQdj2qYg6saIZiLmaUlM1YJPQ
=eYoH
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
