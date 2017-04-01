Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v31EPnhr013585
 for <selinux@tycho.nsa.gov>; Sat, 1 Apr 2017 10:25:49 -0400
Received: by mail-wm0-f48.google.com with SMTP id o81so16970222wmb.1
 for <selinux@tycho.nsa.gov>; Sat, 01 Apr 2017 07:25:44 -0700 (PDT)
Received: from t450.enp8s0.d30 (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id
 82sm10087206wmg.0.2017.04.01.07.25.42 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 01 Apr 2017 07:25:43 -0700 (PDT)
Date: Sat, 1 Apr 2017 16:25:41 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: ssh/cron access checks and my Play Machine
Message-ID: <20170401142541.GA32568@t450.enp8s0.d30>
References: <201704012359.15451.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
In-Reply-To: <201704012359.15451.russell@coker.com.au>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 01, 2017 at 11:59:15PM +1100, Russell Coker wrote:
> Ever since the earliest days of SE Linux (at least 2001 according to my=
=20
> recollection) the cron patches for SE Linux have included a check of the=
=20
> context of the crontab file to ensure that the policy specifies that it i=
s=20
> permitted to have crontab entries to run in the context in question.  Suc=
h=20
> checks were comparable to the checks in crond for a UID match for running=
 the=20
> job with Unix permissions, but a little more complex because we aren't ju=
st=20
> dealing with UIDs.
>=20
> The sshd checks the Unix permissions of ~/.ssh/authorized_keys to ensure =
that=20
> only the owner of the account in question and the primary group of that=
=20
> account can write to it, ~/.ssh, and ~.  But we don't have similar checks=
 for=20
> SE Linux permissions.  I really should have thought of this back when I w=
as=20
> doing a lot of the maintenance for the SE Linux patches for cron and sshd.
>=20
> To test this, try "chmod 666 ~/.ssh/authorized_keys" and then observe tha=
t you=20
> can't ssh to that account without a password.  Then use chcon to set the =
type=20
> of the authorized_keys file to something inappropriate but readable by ss=
hd_t=20
> (such as user_tmpfs_t or etc_t) or set the identity to something other th=
an=20
> system_u or the identity of the account in question and observe that you =
can=20
> still login without a password.

So youre saying the a policy upgrade changed the permissions of ~/.ssh/auth=
orized_keys from 0600 to ????
how is that possible? Also is ~ not set to 0700? User wouldnt be able to tr=
averse to other uids' ~/.ssh

>=20
> During a recent upgrade to my SE Linux Play Machine (or to be more specif=
ic the=20
> Debian/Unstable Play Machine that recently replaced the Debian/Jessie=20
> instance) the permissions were reset on the home directory of the sysadm_=
r=20
> account by a policy upgrade and I didn't notice and set them correctly.  =
This=20
> made it theoretically possible for a user_r user to modify the authorized=
_keys=20
> file, login to the sysadm_r account, and then totally pwn the system.

How do you figure that? you are not specific about what permissions were re=
set to what exactly

Anyhow, It wouldnt be be first time that your play-machine was compromised =
if i recollect correctly. So i do not doubt that its possibly compromized b=
ut I do not see how a policy update would change permission bits of ~/.ssh/=
authorized_keys from 0600 to something world writable and how other uids wo=
uld be able to traverse sysadms' homedir if thats set to 0700 as well.


>=20
> Today I noticed that sshd was taking more memory than usual and user_r lo=
gins=20
> were failing with the error "fatal: monitor_apply_keystate: packet_set_st=
ate:=20
> memory allocation failed".  Only user_r logins were failing because only=
=20
> user_r has a memory limit set in /etc/security/limits.conf.  This raises =
the=20
> possibility that someone replaced sshd or a library it depends on.  I'll =
make=20
> the system image available to anyone who wants to do forensics.  I am not=
=20
> certain that the system was compromised at this stage.  But given that it=
=20
> could have been compromised and that it was operating in a different way =
to=20
> what I expected I think it's most reasonable to assume that it was.
>=20
> Some people may wonder why I am posting this on the first of April.  Some=
one=20
> sent an April 1st joke to a mailing list that had obfuscinated shell code=
 and=20
> my usual practice is to login to my Play Machine as user_r to run suspect=
=20
> code.  This is what led me to discover the problem.  That said, there is=
=20
> evidence that the system might have been running correctly yesterday.
>=20
> When running such systems there have been a number of incidents of proble=
ms=20
> discovered.  As long as the end result is improvement of knowledge about=
=20
> computer security (both by the person running the system and the communit=
y) or=20
> an improvement in SE Linux to make such attacks more difficult in future =
(which=20
> I aim to implement by changes to policy and PAM/sshd code) it can be coun=
ted=20
> as a win for us.  I think that this will end up achieving the aims of=20
> education and software improvement.  So while it sucks a bit, the end res=
ult=20
> should be positive.
>=20
> --=20
> My Main Blog         http://etbe.coker.com.au/
> My Documents Blog    http://doc.coker.com.au/
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa=
=2Egov.

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAljfuGEACgkQJXSOVTf5
R2lYNQv+KFHeds+6/gU8th38PFzimp5++UFl9DuyTbE/CbAoHeIcO670vmRGulQW
w/XmuuYOYyuQmX9jnqe1RCPy2VYceRLNtGEknloq9FR2ksr+Sd5JkitWpC26qqPu
QINjSb2OjfC6d9PSd4bXgqdvPWodnzbCMMSaUGdCEeR+oCIFBnPHnFCCPzMXnklW
cOUKjzBtlBxSw1LuMdIjI2zJWhxvyC86qsP/cmJ7npd7nrWXuQM2ZGTe2d4T+eoY
zNb80r8DWBsxCYMS39bbQtHvAqCO7E8/NVXfkjJbs8FDiJ6WlCI1Wq4MSzplAmyw
5Ynd6jWCZ3sRExJyNImXt7Ye80PnDVFyXHjx3woin78w+vMJIhhlX9hWOsDZ/VGJ
4w4iZc2D11xy6IoZ5Qrye/GJ/aQB6zQOiuroIZBcEmzqXj0SVkB+ZvkiL/Pn30Uc
MUg/x5L+RBrUn4B2Af/iHjNGdUbwYJSMYuI2VnUxCww4jxmwkV3nmww3zFGzxomR
pg+qT/yE
=gipl
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
