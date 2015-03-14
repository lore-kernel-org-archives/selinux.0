Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2E7MwSa015025
 for <selinux@tycho.nsa.gov>; Sat, 14 Mar 2015 03:22:58 -0400
Received: by wibg7 with SMTP id g7so2764608wib.1
 for <selinux@tycho.nsa.gov>; Sat, 14 Mar 2015 00:22:55 -0700 (PDT)
Received: from linksys-wireless-usb.network2 (84-245-31-108.dsl.cambrium.nl.
 [84.245.31.108])
 by mx.google.com with ESMTPSA id j7sm5860153wix.4.2015.03.14.00.22.55
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 14 Mar 2015 00:22:55 -0700 (PDT)
Date: Sat, 14 Mar 2015 08:22:54 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Strange behavior: type boundaries
Message-ID: <20150314072253.GA26393@linksys-wireless-usb.network2>
References: <20150313181459.GB9437@linksys-wireless-usb.network2>
 <55032BCD.7090103@tycho.nsa.gov>
 <20150313184330.GC9437@linksys-wireless-usb.network2>
 <55033162.8040508@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
In-Reply-To: <55033162.8040508@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2015 at 02:50:10PM -0400, Stephen Smalley wrote:
> On 03/13/2015 02:43 PM, Dominick Grift wrote:
> > On Fri, Mar 13, 2015 at 02:26:21PM -0400, Stephen Smalley wrote:
> >> On 03/13/2015 02:15 PM, Dominick Grift wrote:
> >>> I was playing with systemd-nspawn/machine, and machinectl allows one =
to pull in images. I am trying to confine it and i hit issues:
> >>>
> >>> systemd runs systemd-importd, and systemd-importd runs systemd-pull
> >>>
> >>> It seems as if though its some multithreading going on because i get:
> >>>
> >>> type=3DSELINUX_ERR msg=3Daudit(1426268982.258:2559): op=3Dsecurity_bo=
unded_transition seresult=3Ddenied oldcontext=3Dsystem_u:system_r:systemd_t=
 newcontext=3Dsystem_u:system_r:importd_t
> >>>
> >>> Even though I am in permissive mode, and a transition rule "allow sys=
temd_t importd_t:process transition;" is present, SELinux does not transiti=
on.
> >>>
> >>> When i add a typebounds statement (typebounds systemd_t importd_t), t=
hen the scenario changes:
> >>>
> >>> type=3DSELINUX_ERR msg=3Daudit(1426268121.044:2414): op=3Dsecurity_co=
mpute_av reason=3Dbounds scontext=3Dsystem_u:system_r:systemd_t tcontext=3D=
system_u:system_r:importd_t tclass=3Dprocess perms=3Dtransition
> >>> ----
> >>> type=3DAVC msg=3Daudit(1426268121.044:2415): avc:  denied  { transiti=
on } for  pid=3D9210 comm=3D"(-importd)" path=3D"/usr/lib/systemd/systemd-i=
mportd" dev=3D"dm-1" ino=3D2232532 scontext=3Dsystem_u:system_r:systemd_t t=
context=3Dsystem_u:system_r:importd_t tclass=3Dprocess permissive=3D1
> >>> ----
> >>> type=3DSELINUX_ERR msg=3Daudit(1426268121.044:2416): op=3Dsecurity_co=
mpute_av reason=3Dbounds scontext=3Dsystem_u:system_r:importd_t tcontext=3D=
system_u:object_r:importd_exec_t tclass=3Dfile perms=3Dentrypoint
> >>> ----
> >>> type=3DAVC msg=3Daudit(1426268121.044:2417): avc:  denied  { entrypoi=
nt } for  pid=3D9210 comm=3D"(-importd)" path=3D"/usr/lib/systemd/systemd-i=
mportd" dev=3D"dm-1" ino=3D2232532 scontext=3Dsystem_u:system_r:importd_t t=
context=3Dsystem_u:object_r:importd_exec_t tclass=3Dfile permissive=3D1
> >>> ----
> >>> type=3DSELINUX_ERR msg=3Daudit(1426268121.046:2418): op=3Dsecurity_co=
mpute_av reason=3Dbounds scontext=3Dsystem_u:system_r:importd_t tcontext=3D=
system_u:system_r:systemd_t tclass=3Dfd perms=3Duse
> >>> ----
> >>> type=3DAVC msg=3Daudit(1426268121.046:2419): avc:  denied  { use } fo=
r  pid=3D9210 comm=3D"systemd-importd" path=3D"/dev/null" dev=3D"devtmpfs" =
ino=3D1028 scontext=3Dsystem_u:system_r:importd_t tcontext=3Dsystem_u:syste=
m_r:systemd_t tclass=3Dfd permissive=3D1
> >>>
> >>> These rules are present in the policy (the transition is obviously ta=
king place in permissive mode) and so is the typebounds rule, but access lo=
oks still denied.
> >>>
> >>> I do not understand what is going on here.
> >>>
> >>> First of all importd_t is bounded to systemd. So why does it appear t=
o be a problem that systemd operates on importd_t entities?
> >>>
> >>> Also why does selinux refuse to type transition without a typebounds,=
 and why does it give me a permission denied with a typebounds=20
> >=20
> >> NO_NEW_PRIVS?  See http://marc.info/?l=3Dselinux&m=3D140717412324539&w=
=3D2
> >> Previously domain transitions on exec were always disabled under
> >> NO_NEW_PRIVS and nosuid mounts.  This was introduced as a way of
> >> supporting e.g. the SELinux sandbox or other cases where NNP is being
> >> used and they want to transition domains on exec.  Typebounds makes th=
is
> >> safe, but typebounds requires you to cap the child type's permissions =
to
> >> a subset of the parent type's permissions.  This is normally checked by
> >> checkpolicy or libsemanage at policy build/link time but I'm sure Red
> >> Hat has disabled it along with neverallow checking, so you probably
> >> don't see it until the kernel recognizes the discrepancy and dynamical=
ly
> >> blocks the access that would violate the bound.
> >=20
> > Yes that is what i mentioned on #selinux. However i am not using checkp=
olicy or libsemanage. I am using secilc (and i have it check for neverallow=
 rule violations). I would have expected it to catch it on compile time.
> >=20
> > However there is still something strange in that importd_t is bounded t=
o systemd_t: thus why would: "systemd_t importd_t:process transition;" be d=
enied?
> >=20
> > systemd_t is the parent and not the bounded child.
> >=20
> > A rule "allow systemd_t importd_t:process transition;" is present in th=
e output of "sesearch -A -s systemd_t -t
> importd_t". Yet it still prints a denial.
>=20
> Typebounds restricts its use both as a source and as a target context.
> Does systemd_t have transition to self?

Thanks for the hint. That did it.

It feels wrong/unnatural though because now i have to give the parent more =
permissions to be able to run the child with less permissions than its pare=
nt.

But ce'st la vie i suppose. At least i know what the problem was now.

>=20
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa=
=2Egov.

--=20
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=3Dvindex&search=3D0x314883A202DFF788
Dominick Grift

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJVA+HIAAoJENAR6kfG5xmc0PcL/i84tH1pTbrdgRFixA5fBFhv
jT/F7la0SlMpj4hovwwvlvOBDX4LvfL0HaCNMWI3P1gPPCGYZgb0Ne3GfoVXQ1UZ
uFdJNGZIl18SUrbzhafdBeokstVWWrN8SitSBpIE4U5SyMlW/5wC0dbeF4/QfClz
H+DFxai8RoEfPr0TPFi6+YwerfW9tWS5CNRnwtpO/NjczeIPqmpX1GXyrLwGO43Q
kwqhsl1Mo3tpCMq4P0clRYqLkaE5fCKCIGxF4CNBQSBGh7Ll8k6U3gO5loiBVm+P
DTtxKtUMaSKsTqh2u7G4DN4eZ7yJcPCpl5s/gH2yoSrp0WIVFU4V7IoS0THSAiSf
2kCzeZjTkniQ1GgWOocQNq/L/WYOgmkRI8P6rAC65eCLmNaSZJJ2JeQG59OR6jSI
wxwJTQ8iUNVbynb6Cga1hfBp66ejgHXncrbjfooeTNdSqSUUyXs3q1AxXf57qzpq
EYDRyOi2pZKio5D2e+yWZQQ3m+R3be8BxmVi5w0Amg==
=9ysV
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
