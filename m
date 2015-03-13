Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2DLVlbj015529
 for <selinux@tycho.nsa.gov>; Fri, 13 Mar 2015 17:31:47 -0400
Received: by wghl18 with SMTP id l18so25879945wgh.5
 for <selinux@tycho.nsa.gov>; Fri, 13 Mar 2015 14:31:45 -0700 (PDT)
Received: from linksys-wireless-usb.network2 (84-245-31-108.dsl.cambrium.nl.
 [84.245.31.108])
 by mx.google.com with ESMTPSA id r14sm4410397wiv.13.2015.03.13.14.31.44
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 13 Mar 2015 14:31:44 -0700 (PDT)
Date: Fri, 13 Mar 2015 22:31:38 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: selinux category relabel (puppet)
Message-ID: <20150313213137.GE9437@linksys-wireless-usb.network2>
References: <2409d98630af4bc39108524e04557017@VNUCITEX02.ICFI.icfconsulting.com>
 <55032105.1030903@tycho.nsa.gov>
 <103dc46dd5b34fa5a752edce40d20e01@VNUCITEX02.ICFI.icfconsulting.com>
 <550326BD.10207@tycho.nsa.gov>
 <6d80ec39a885492792f446972fb5facc@VNUCITEX02.ICFI.icfconsulting.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
In-Reply-To: <6d80ec39a885492792f446972fb5facc@VNUCITEX02.ICFI.icfconsulting.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2015 at 09:17:36PM +0000, Higgs, Stephen wrote:
> > >>> Hello all,
> > >>>
> > >>>
> > >>>
> > >>> If there is a more appropriate forum for this question please let m=
e know:
> > >>>
> > >>>
> > >>>
> > >>> I have a system that uses confined users by default and some files
> > >>> are managed by a puppet server.  When I run (via run_init) the
> > >>> puppet startup script, I get the following avc log:
> > >>>
> > >>>
> > >>>
> > >>> avc: denied { relabelto } for pid=3D30707 comm=3D"puppet" name=3D"c=
rl.pem"
> > >>> dev=3Ddm-1 ino=3D527257 scontext=3Dsystem_u:system_r:puppet_t:s0
> > >>> tcontext=3Dsystem_u:object_r:puppet_var_lib_t:s0:c0.c1023 tclass=3D=
file
> > >>>
> > >>> I added "typeattribute puppet_t can_change_object_identity" and
> > >>> appropriate "allow" statements to the puppet_t type after reading
> > >>> the constraints in the targeted policy. However, it was the category
> > >>> "s0:c0.c1023" that was also preventing puppet from relabeling the
> > >>> crl.pem file.
> > >>>
> > >>> I was able to fix this by manually relabeling the file to "s0"
> > >>> instead of "s0:c0.c1023". My question is, how *should* I handle this
> > >>> so puppet can handle the relabel of the category?
> > >>
> > >> It requires an appropriate attribute for the mcs or mls constraint
> > >> that is blocking access.  Which attribute depends on your policy; MCS
> > >> in particular has changed a lot over time in Fedora and RHEL.  What =
distro &
> > version?
> > >>
> > >
> > > I'm using CentOS / RedHat 6.6, targeted reference policy 24.
> >=20
> > Hmmm...looking at selinux-policy-3.7.19-260.el6.src.rpm,
> > serefpolicy-3.719/policy/mcs has this:
> >=20
> > # New filesystem object labels must be dominated by the relabeling subj=
ect #
> > clearance, also the objects are single-level.
> > mlsconstrain file { create relabelto }
> >         (( h1 dom h2 ) and ( l2 eq h2 ));
> >=20
> > So no attributes are exempted from that constraint; your only option is=
 to run
> > puppet ranged (i.e. as system_u:system_r:puppet_t:s0-s0:c0.c1023)
> > so that its high level dominates any potential file level.
> >=20
> > You should be able to do that with a range_transition rule, e.g.
> > range_transition initrc_t puppet_exec_t:process s0 - s0:c0.c0123; (assu=
ming
> > that the puppet entrypoint is labeled with puppet_exec_t).
>=20
> Thanks Stephen, this makes sense to me, but I can't get that statement to=
 compile in my policy module:
>=20
>    Compiling targeted puppet module
>    /usr/bin/checkmodule:  loading policy configuration from tmp/puppet.tmp
>    puppet.te":14:ERROR 'unknown level s0-s0 used in range_transition defi=
nition' at token ';' on line 1041:
>    range_transition initrc_t puppet_exec_t:process s0-s0:c0.c1023;
>    #init_ranged_daemon_domain(puppet_t,puppet_exec_t,s0-s0:c0.c1023);
>    /usr/bin/checkmodule:  error(s) encountered while parsing configuration
>    make: *** [tmp/puppet.mod] Error 1
>=20
> I did try checkmodule as well, and I tried using the init_ranged_daemon_d=
omain macro.  Here is the policy module that I am trying to compile:
>=20
>    module puppet 1.2;
>    require {
>            type puppet_t;
>            type puppet_exec_t;
>            type initrc_t;
>            attribute can_change_object_identity;
>            class process { transition };=20
>    }
>    typeattribute puppet_t can_change_object_identity;
>    #init_ranged_daemon_domain(puppet_t,puppet_exec_t,s0-s0:c0.c1023);=20
>    range_transition initrc_t puppet_exec_t:process s0-s0:c0.c1023;

Not sure but try spaces here (s0 - s0): range_transition initrc_t puppet_ex=
ec_t:process s0 - s0:c0.c1023;

>=20
> I feel like I'm close, but perhaps I'm missing how to import  the level d=
efinitions?
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

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJVA1c1AAoJENAR6kfG5xmcEbAMALntR3fjG+Lh8j2ms2nh+gEK
TtXfPqssseCB3gTj6B2M8rAsdUqBOb34XWeRjlJDWShCzzx0rnvFk4uFayutvN6l
9w78nRL3u+dtSb3ktn/Itn5Bzp4FW4iJpmYedVBn+qe5zBqzBxzK7zsdCxEyyj6A
PAT/p1d6tNfBaeNf//1+Ory+xlcSpD3uM5iy08j/OmUoWsGlJKHSusRtJWf7ArQ7
D2EbdZl8fioVvp6ZCq0fqSZTdda+fYiA8HDOz2giF/5cCW6JWnWXnCIltvW2KKXz
UazcY6gNxEZsv9q3Pnnej4d4cC30345bV1zQdU7s/AzNlunj0TF/Xzg93G05qBky
y0iZjmCiia0GJsl3dBobEEjeeW8IGInVgLgARiUQnxyDuMMy/zUWt2BRCaL1a0h6
9GPH9HtLu/bnw51X+QCBWmuamZoPCKIhskh0OtmbudeB4H+V5Mt92gsx+/V/Uxge
8oDXxiCU/tXSygfnTPFZqFdawkJOo8cOCIgZCoXTzA==
=ts/6
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
