Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t43AopFg017999
 for <selinux@tycho.nsa.gov>; Sun, 3 May 2015 06:50:51 -0400
Received: by wgen6 with SMTP id n6so125819261wge.3
 for <selinux@tycho.nsa.gov>; Sun, 03 May 2015 03:50:48 -0700 (PDT)
Received: from x131e (217-19-24-195.dsl.cambrium.nl. [217.19.24.195])
 by mx.google.com with ESMTPSA id fs9sm15549840wjc.34.2015.05.03.03.50.47
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 03 May 2015 03:50:47 -0700 (PDT)
Date: Sun, 3 May 2015 12:50:46 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: secilc bug
Message-ID: <20150503105045.GB13244@x131e>
References: <CAHC9VhQu=U51b85U74xhP+x+4VCOrm9W8WVAw=vW6s0FdSNPxw@mail.gmail.com>
 <alpine.LRH.2.11.1504131142390.774@namei.org>
 <CAHC9VhSAVxo2wkOpMj1QcM-=HvBVhOvVGyTG-JGQHKJhn-rvYw@mail.gmail.com>
 <alpine.LRH.2.11.1504241023280.13918@namei.org>
 <CAHC9VhTGXTRi0=XbeB8b+LQVC+MDdk3PH38hYSafmV5CMrvi8Q@mail.gmail.com>
 <553A6D3D.8020904@schaufler-ca.com>
 <CAHC9VhQkYU990OKAySUnPn-XzoOUN=21AjOB76pbM7uVQX_0xQ@mail.gmail.com>
 <alpine.LRH.2.11.1504271528350.16342@namei.org>
 <1430265211.2218.13.camel@linux.vnet.ibm.com>
 <20150502150259.GA15244@x131e>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
In-Reply-To: <20150502150259.GA15244@x131e>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 02, 2015 at 05:02:59PM +0200, Dominick Grift wrote:
> Today i hit an bug in secilc, when compiled by policy with some modules e=
xcluded.

<snip>

I suspect the issue is something like the following:

There are currently no rules associated with the pam_auth_config_object_typ=
e type attribute thus it will be removed from the policy by secilc

However this may or may not change. I do have macros with rules assoc. with=
 pam_auth_config_object_type, they are currently just not called by anything

In my policy, the pam_auth_config_object_type type attribute currently only=
 acts as a bridge to auth_object_type type attribute=20

Example: pam_config_t (and many other types) is/are assoc. with auth_pam_co=
nfig_object_type, auth_pam_config_object_type is associated
with auth_object_type, and there are rules assoc. with auth_object_type

(for example: auth_admin_subject_type auth_object_type (all_file_objects (a=
ll_file_perms_except)))

The question remains, how does me exluding the xserver.cil affects all this=
=2E I actually commented out the only call to
the auth.cil module ( (call auth_pam_config_object_type (xserver_pam_config=
_t)) ) from the xserver module and it turns out to not
affect it. So it is not that macro call.

It may instead be another ordering issue...

E.g. excluding the xserver.cil module may mess up the ordering of the modul=
es to process in such a way that this rule vanishes

Because that is what this issue boils down to: rules vanishing for no reason

I made a screencast that tries to explain the issue:

https://www.youtube.com/watch?v=3DXRp5z9aqLDo

--=20
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=3Dvindex&search=3D0x314883A202DFF788
Dominick Grift

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJVRf2AAAoJENAR6kfG5xmctvUMANC3pyGBlTqJC76/nzPc7EmJ
SOOL0C9KLfHP9r4PAQH8Wf224OqYhn2/m8rrY6j3C26tr0O0c6B6+Dckv7MkXMCR
TLsnVgSOcXqoGGdePH71qyk3Rey8p62/bA3HEWsANActaGyfDLuUcxl/94WVH/ju
NZkheRO/qyA7NXV/oXGNdwM+QuJx5AxaHIZuwaUiln9mS6hCA/ICLzZrMkGpCwCS
IecBDtwql7hUvkf8XOqZY8Ry7pGt4ysLUVpWVb/HXE6fKDzyWhkbExEwG11NCI61
q+zNz1K0yzE2mNipExgslwtCbr4nV3l0LiZv/9VocYYe9I5sfh2fxVa8L+0sZeJZ
aW4ujLiniMCQjGBDzcrmuanu/ZS38JKHIDW2bFRnaQA3ZTIwEo5VLeQo5uUmUQio
xap+o+njOYNnZx4WwPgKIsIwaH+atCtOD0Jz+Ajw4q1C2PPGvx1ofjJqseiIs7lI
cpEUl6pC6YREJW16oIJ9tPKPUAxJlHvqMou2OGeuWA==
=1on0
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
