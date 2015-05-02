Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t42F3665023808
 for <selinux@tycho.nsa.gov>; Sat, 2 May 2015 11:03:06 -0400
Received: by widdi4 with SMTP id di4so79008156wid.0
 for <selinux@tycho.nsa.gov>; Sat, 02 May 2015 08:03:02 -0700 (PDT)
Received: from x131e (217-19-24-195.dsl.cambrium.nl. [217.19.24.195])
 by mx.google.com with ESMTPSA id o6sm2670306wiz.24.2015.05.02.08.03.01
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 02 May 2015 08:03:01 -0700 (PDT)
Date: Sat, 2 May 2015 17:03:00 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: secilc bug
Message-ID: <20150502150259.GA15244@x131e>
References: <alpine.LRH.2.11.1504082055100.32381@namei.org>
 <CAHC9VhQu=U51b85U74xhP+x+4VCOrm9W8WVAw=vW6s0FdSNPxw@mail.gmail.com>
 <alpine.LRH.2.11.1504131142390.774@namei.org>
 <CAHC9VhSAVxo2wkOpMj1QcM-=HvBVhOvVGyTG-JGQHKJhn-rvYw@mail.gmail.com>
 <alpine.LRH.2.11.1504241023280.13918@namei.org>
 <CAHC9VhTGXTRi0=XbeB8b+LQVC+MDdk3PH38hYSafmV5CMrvi8Q@mail.gmail.com>
 <553A6D3D.8020904@schaufler-ca.com>
 <CAHC9VhQkYU990OKAySUnPn-XzoOUN=21AjOB76pbM7uVQX_0xQ@mail.gmail.com>
 <alpine.LRH.2.11.1504271528350.16342@namei.org>
 <1430265211.2218.13.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
In-Reply-To: <1430265211.2218.13.camel@linux.vnet.ibm.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Today i hit an bug in secilc, when compiled by policy with some modules exc=
luded.

My policy is rather complex, and so i find the issue hard to explain but i =
will try:

In my github.com/doverride/laptop policy (the auth.cil module to be precise=
) i have a auth_pam_config_object_type() macro that
essentially associates the calling type with the auth_pam_config_object_typ=
e type attribute, which in turn is associated with
the auth_object_type attribute that is used to grant auth_admin() access to=
 all "auth object types"

The auth_pam_config_object_type() macro is called in various modules for va=
rious third party pam config files.

For example, xserver maintains /etc/pam.d/xserver, which is associated with=
 xserver_pam_config_t, and xserver_pam_config_t is
associated with auth_pam_config_object_type.

This is just one example.

By excluding the xserver.cil module, the whole auth_pam_config_object_type,=
 and all rules associated with it vanishes.
I noticed today that on a system where i excluded xserver.cil i no longer h=
ad access to /etc/security/access.conf (which is
associated with pam_config_t, and pam_config_t is associated with auth_pam_=
config_object_type)

By reincluding the xserver.cil module , the rules that allow auth_admin() t=
o maintain auth_object_type files reappeared.

To reproduce:

clone my "laptop" policy and build it

use "sesearch -A -s auth_admin_subject_type | grep auth_object_type" to con=
firm that auth_admin_subject_type is allowed
to maintain file objects associated with auth_object_type

Now exclude the xserver.cil module

use above sesearch command again and notice how the rules granting auth_adm=
in_subject_type access to maintain file objects
associated with auth_object_type have vanished.

P.S:
Another really strange thing i noticed is that i have a compiled policy wit=
h a bunch of modules excluded that is bigger than
a policy with little or no modules excluded.

--=20
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=3Dvindex&search=3D0x314883A202DFF788
Dominick Grift

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJVROceAAoJENAR6kfG5xmcGnEMALNe0UliUKwsPY7WMqlnqA4A
8ywEScLYJdFODn29vxwsaxnZ0WHo+FsJVvrsB2DwtKh/cZZIpdhZwDc9h5Kphx6W
6O/yKBeizk9ot96nTKtgId9c+47gftDP0QRis5YgHv0jg5DgGdlTFs1H1kP0dPZH
Boc6/v/KCQhudOnEtVGIBNChmh8XEeFp6Bufr+71gPATgJv+ZNLRQoDEi4Uv6CVV
9xjQRaUginKMnLCdiivAueG8oKH+cBY1YCdJa8SPcfF/x4K8agmkZ3JGV+rZsBta
1ug7G52IOvAxW5Py4sH0l958hRZLSfajnbzRIc/H2HVEs1Sz+/tO++PvccDPKvo1
j5c5RrOJmeFnPD5gOqcQX9nb6R+Mv12xIyUjkjD318GgD2uC/Bppgt8qQJmyFBWK
Yw7wzTYTng0gk3Je4I96DmTD6rE6Mp1fiTCXvXCAkT/DNtL/RmOEsAk6GBwJIdOv
+46iPrMutAEN7Za/uJeRuYNIMzkbf+7YvTHHfgfimQ==
=uEJu
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
