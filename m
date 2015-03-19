Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2JBnOE0031621
 for <selinux@tycho.nsa.gov>; Thu, 19 Mar 2015 07:49:24 -0400
Received: by wegp1 with SMTP id p1so55055967weg.1
 for <selinux@tycho.nsa.gov>; Thu, 19 Mar 2015 04:49:16 -0700 (PDT)
Date: Thu, 19 Mar 2015 12:49:15 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov, eparis@parisplace.org
Subject: Re: =?utf-8?B?562U5aSNOiBHb3Qgc29tZSBwcm9i?= =?utf-8?Q?lem_whe?=
 =?utf-8?Q?n?= using the type_transition, look for some helps! thank you!
Message-ID: <20150319114914.GA4249@localhost.localdomain>
References: <60ABE64B4BE4AC45964F1A967BA76CB201569BC3@szxeml522-mbx.china.huawei.com>
 <568659679.32020739.1426669508944.JavaMail.zimbra@redhat.com>
 <60ABE64B4BE4AC45964F1A967BA76CB201569E97@szxeml522-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
In-Reply-To: <60ABE64B4BE4AC45964F1A967BA76CB201569E97@szxeml522-mbx.china.huawei.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2015 at 01:47:29AM +0000, kuangjiou wrote:
> Milos ,Thanks for your reply,  It helps me a lot.
> now I can compile the module success. But when I try to semodule the .pp =
to the policydb, it got this message: libsepol.policydb_write: Discarding f=
ilename type transition rules. I think it must because the kernel version i=
s not new enough to support the filename type transition rules. But I don't=
 want to change my linux kernel , I just plan to update the SElinux codes a=
nd built a new linux kernel. And I don't know where to get the SELinux code=
 that is new enough to support the filename type transition rules, So, is t=
hat anyone can help me out with this ?

Paris (CC'd), may be able to help identify what is needed to port that code=
 to older kernels if that is reasonably possible.

I am wondering as well though why that code was not ported to EL 6.*

>=20
> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Milos Malik [mailto:mmalik@redhat.com]=20
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2015=E5=B9=B43=E6=9C=8818=E6=97=A5 =
17:05
> =E6=94=B6=E4=BB=B6=E4=BA=BA: kuangjiou
> =E6=8A=84=E9=80=81: selinux@tycho.nsa.gov
> =E4=B8=BB=E9=A2=98: Re: Got some problem when using the type_transition, =
look for some helps! thank you!
>=20
> Hi Sylar,
>=20
> I forgot to mention that filename transition rules are not supported on R=
HEL-6.x. Based on the kernel version you provided I guess that you are not =
running RHEL-7.x, where the filename transition rules are supported.
>=20
> # uname -srv
> Linux 2.6.32-504.12.2.el6.i686 #1 SMP Sun Feb 1 12:14:25 EST 2015 # cat m=
ypolicy.te
> policy_module(mypolicy,1.0)
>=20
> require {
>   type unconfined_t;
>   type dentry_t;
>   type file_t;
>   class file { create };
> }
>=20
> type_transition unconfined_t dentry_t:file file_t "myfile";
>=20
> # make -f /usr/share/selinux/devel/Makefile Compiling targeted mypolicy m=
odule
> /usr/bin/checkmodule:  loading policy configuration from tmp/mypolicy.tmp=
 mypolicy.te":10:WARNING 'unrecognized character' at token '"' on line 3220:
> type_transition unconfined_t dentry_t:file file_t "myfile";
>=20
> mypolicy.te":10:ERROR 'syntax error' at token 'myfile' on line 3220:
> type_transition unconfined_t dentry_t:file file_t "myfile";
>=20
> /usr/bin/checkmodule:  error(s) encountered while parsing configuration
> make: *** [tmp/mypolicy.mod] Error 1
> #
>=20
> Milos Malik
> SELinux QE person
> BaseOS QE Security team
> Brno, The Czech Republic
>=20
> ----- Original Message -----
> >=20
> >=20
> > Hello,everyone!
> >=20
> >=20
> >=20
> > I am try to use the new features of the type_transition that can=20
> > support to determine the type of the new file by the name of this new=
=20
> > file,And when I
> >=20
> >=20
> >=20
> > use the type_transisiton in my own policy module like this:
> >=20
> >=20
> >=20
> > type_transition unconfined_t dentry_t:file file_t myfile;
> >=20
> >=20
> >=20
> > I got the error: 'syntax error' at token 'myfile' on line 1195:
> >=20
> >=20
> >=20
> > It seems like didn't support the fifth parameter 'myfile', And I am=20
> > using the checkmodule (version 2.3) to compile my policy module, but I=
=20
> > am not sure
> >=20
> >=20
> >=20
> > the the version of the linux kernel (Linux nkgcinwslx00671=20
> > 2.6.32.12-0.7-default #1 SMP 2010-05-20 11:14:20 +0200 x86_64 x86_64=20
> > x86_64
> > GNU/Linux) is
> >=20
> >=20
> >=20
> > new enough to support this features.(I think the compiling should have=
=20
> > nothing to do with the kernel?)
> >=20
> >=20
> >=20
> > so, could anybody give me some suggestions to resolve this problem? I=
=20
> > am looking forward to your replies! Thank you very much!
> >=20
> >=20
> >=20
> >=20
> >=20
> > Sylar
> >=20
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to=20
> > Selinux-request@tycho.nsa.gov.
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

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJVCre2AAoJENAR6kfG5xmcdacMAMBG+gFX8q+/ORht7g41h3pK
yNrEKme+cWOHmuoex/6XLg+N5HRjdx3ZDcIfBpCl7d5eFpx6WpwuNv0Wjl/mnxb6
Z6n1dgLMfNsDuSSMmX6ApVsJojuM8gfkOj3GomYuse0oZ2s+cFlieh3NE0FmPYsK
4ZIk51F1w+kjtVOFF9aCtF8Zsa5V/w8me7JMPpdip8RZYVJu/01lIGSDCX4SVWvv
0C/Z/9Ifo4qgM8opJFSBqd+Bu7ie0Sf078rK5mjJd4TfWxtFtj6Gi79CJ0502eBK
+apNvuQoYHcVT10SraCjO9Sx9BP3SP0FY8+okZYb+WW1kF0lACJfbdbeK5NrOmix
kz3MDeVwwseZlllncaMSmM9yqEWvNdMZT/qihL7RI2T2S2DMyHrmuXpbOabBPqm/
33N5ad1+sbMRA+YyXdHiei7jvC8YwD4byPP31oeyhDS8/hw8PQqbALCvpft5N8du
6diLw3WnASnHEiamI4gdjVMX7m3CoI+AEs+EHm2CHA==
=EUHX
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
