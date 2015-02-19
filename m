Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t1JFexQT003015
 for <selinux@tycho.nsa.gov>; Thu, 19 Feb 2015 10:40:59 -0500
Received: by mail-wi0-f172.google.com with SMTP id l15so48905858wiw.5
 for <selinux@tycho.nsa.gov>; Thu, 19 Feb 2015 07:40:56 -0800 (PST)
Received: from linksys-wireless-usb.network2 (84-245-31-108.dsl.cambrium.nl.
 [84.245.31.108])
 by mx.google.com with ESMTPSA id ch6sm37900123wjc.3.2015.02.19.07.40.55
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Thu, 19 Feb 2015 07:40:55 -0800 (PST)
Date: Thu, 19 Feb 2015 16:40:48 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: MCS error
Message-ID: <20150219154047.GA11807@linksys-wireless-usb.network2>
References: <20150219014803.GB12937@tracyreed.org>
 <54E5E3C4.40904@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
In-Reply-To: <54E5E3C4.40904@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The MCS implementation has been changed a bit over the years on the policy =
side.

Back in the earlier day's MCS was enforced on all proceses in redhat distro=
's by default

Nowaday's that is no longer the case, and you need to opt-in for it by asso=
ciating the mcs_constrained_type type attribute with the type of the proces=
s to constrain.

In rhel6 this attribute name does not exist i suspect. It was renamed to af=
orementioned later.

A seinfo -a | grep mcs might reveal the type attribute used for the same in=
 RHEL6. (i think its something with trusted or untrusted, dunno for sure)

On Thu, Feb 19, 2015 at 08:23:16AM -0500, Stephen Smalley wrote:
> On 02/18/2015 08:48 PM, Tracy Reed wrote:
> > Hello all,
> >=20
> > I am implementing Multi-Category Security for a client to contain vario=
us
> > different instances of their web application which all run on the same =
box.
> > This sort of multi-tenant operation seems like a perfect fit for MCS.
> >=20
> > I am using the following guide as a basis for getting started:
> >=20
> > https://www.centos.org/docs/5/html/Deployment_Guide-en-US/sec-mcs-getst=
arted.html
> >=20
> > However, I am actually running CentOS 6. I can't seem to find a CentOS 6
> > version of this guide.
> >=20
> > When I try to add the category to the user I get this error:
> >=20
> > [mcstest:/root]# chcat -l -- +user1 user1
> > libsemanage.validate_handler: MLS range s0-s0:c1 for Unix user user1 ex=
ceeds allowed range s0 for SELinux user user_u (No such file or directory).
> > libsemanage.validate_handler: seuser mapping [user1 -> (user_u, s0-s0:c=
1)] is invalid (No such file or directory).
> > libsemanage.dbase_llist_iterate: could not iterate over records (No suc=
h file or directory).
> > /usr/sbin/semanage: Could not commit semanage transaction
> >=20
> > Here's some relevant config info:
> >=20
> > [mcstest:/root]# chcat -L=20
> > s0:c1                          user1
> > s0:c2                          user2
> > s0:c3                          user3
> > s0                             SystemLow
> > s0-s0:c0.c1023                 SystemLow-SystemHigh
> > s0:c0.c1023                    SystemHigh
> >=20
> >=20
> > [mcstest:/root]# semanage user -l=20
> >=20
> > Labeling   MLS/       MLS/                         =20
> > SELinux User    Prefix     MCS Level  MCS Range                      SE=
Linux Roles
> >=20
> > git_shell_u     user       SystemLow  SystemLow                      gi=
t_shell_r
> > guest_u         user       SystemLow  SystemLow                      gu=
est_r
> > root            user       SystemLow  SystemLow-SystemHigh           st=
aff_r sysadm_r system_r unconfined_r
> > staff_u         user       SystemLow  SystemLow-SystemHigh           st=
aff_r sysadm_r system_r unconfined_r
> > sysadm_u        user       SystemLow  SystemLow-SystemHigh           sy=
sadm_r
> > system_u        user       SystemLow  SystemLow-SystemHigh           sy=
stem_r unconfined_r
> > unconfined_u    user       SystemLow  SystemLow-SystemHigh           sy=
stem_r unconfined_r
> > user_u          user       SystemLow  SystemLow                      us=
er_r
> > xguest_u        user       SystemLow  SystemLow                      xg=
uest_r
> >=20
> > I notice that the MCS Range for user_u is only SystemLow. In the docume=
ntation
> > referenced above the output of this command shows user_u as:
> >=20
> > user_u                  user           s0                      s0-s0:c0=
=2Ec1023    system_r sysadm_r user_r
> >=20
> > so the MCS range is s0-s0:c0.c1023. This seems to be what is missing in=
 my
> > setup. But I don't understand how to allow that MCS Range for user_u.
> >=20
> > Any pointers are greatly appreciated. Thanks!
>=20
>  semanage user -m -r s0-s0:c0.c1023 user_u
>=20
>=20
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

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJU5gP6AAoJENAR6kfG5xmcvm8MALKCt2XZYbAjhAZQ33W+2J/4
GzDJGK+rTA/3yZXuwCAwvanz7dMq5iksujVQgg1OZJGxphlhitBeSLqfq6TRkg6U
vWWiPXEyFyZc0Y8FQ9d0SE+v8CiSUZP9jsxfe+nBLbaCQ8C7JAlGr1MhpaUB4kaJ
yqcdRUrdeC2iWYiubzX9XOqpVUMVNVSCI1LzBxXHIQfabXAgIgXXpceTy1pN5vF9
y//nt7vg5TrTlaw5gY8cOY/A+mKRxksppnenis3dqFzjQuCo81twfM6H9mbPluKS
wQW+c7ssy5Fys6IPcIqFIoFj+ktd07I9TQFjJf1C+9TIzjFdaNLqtwFiVWxTLYcL
O3XUPU4tb+D/YlR/SLUWzsPAokZyRmwUI3/Yty9wQgfjbcv/bQHgkivI54dPlHtW
Ht66NRuWnkuN8Qm9/v5gUpggMrDzGABEZ5Y9bU5H53n/PREZVYwyrzBCWUfrW0v6
SS7hzHT7RBm8iv6Lc+FP0SOWRubgrItUyVmaXcAsVQ==
=/rpK
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
