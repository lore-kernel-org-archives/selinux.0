Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n87EI1Dg012912
	for <selinux@tycho.nsa.gov>; Mon, 7 Sep 2009 10:18:01 -0400
Received: from mail.gmx.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n87EJIQa019550
	for <selinux@tycho.nsa.gov>; Mon, 7 Sep 2009 14:19:19 GMT
From: Dennis Wronka <linuxweb@gmx.net>
To: waqar afridi <afridi.waqar@gmail.com>
Subject: Re: Problem install Reference Policy
Date: Mon, 7 Sep 2009 22:17:48 +0800
Cc: zheyeung@gmail.com, selinux@tycho.nsa.gov
References: <200909071010066097796@gmail.com> <4AA48895.8030400@gmail.com> <78aaeffc0909062353p428dac47q614eb6b71a2f8ed7@mail.gmail.com>
In-Reply-To: <78aaeffc0909062353p428dac47q614eb6b71a2f8ed7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart10798810.8VD4R15e6h";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200909072217.52396.linuxweb@gmx.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--nextPart10798810.8VD4R15e6h
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Usually turning off modules shouldn't help to free a lot of memory as they=
=20
usually are small things that don't take up much RAM anyway.

How much RAM do you have in your PC?

> *Thanx zheyeung*, But If I do leave the original *Build.conf* I get the
> following error
>
> /usr/bin/checkpolicy policy.conf -o /etc/selinux/refpolicy/policy/policy.=
23
> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> make: *** [/etc/selinux/refpolicy/policy/policy.23] Killed
>
>  Is it due to less memory or some thing else, I also turned off some
> unwanted modules from *modules.conf*, but didnt help, What should I do?
>
> On Mon, Sep 7, 2009 at 10:14 AM, Justin P. Mattock
>
> <justinmattock@gmail.com>wrote:
> > zheyeung wrote:
> >> hello waqar, I used to get this problem.after then, i edit file
> >> build.conf in some way  ,then make . make successfully!
> >> but I've got another problem . after i install the policy (by editting
> >> /etc/ selinux/config ,reboot)  ,my graphic user interface failed to
> >> start up.and i don't kown why.
> >> I run "semanage login -l" ,found "login" of root is root: sysadm_r.but
> >> default targeted in Fedora-11. root 's "login" is "unconfined_u:
> >> unconfined_r".
> >
> > you might try  make clean, make enableaudit, make policy
> > this will generate some more avc's that you might need
> > to allow to startx.
> >
> >  2009-09-07
> >
> >> ----------------------------------------------------------------------=
=2D-
> >> zheyeung
> >> ----------------------------------------------------------------------=
=2D-
> >> *=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A* waqar afridi
> >> *=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A* 2009-09-05  15:44:44
> >> *=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A* selinux
> >> *=E6=8A=84=E9=80=81=EF=BC=9A*
> >> *=E4=B8=BB=E9=A2=98=EF=BC=9A* Problem install Reference Policy
> >> Hello Every One,
> >>
> >> I am new to selinux, I am using Ubuntu and i am trying to install
> >> reference Policy on it, after running command make load, I get this
> >> error, I dont know whats wrong
> >>
> >> /usr/bin/checkpolicy policy.conf -o
> >> /etc/selinux/refpolicy/policy/policy.23
> >> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> >> policy/modules/services/ifplugd.te":67:ERROR 'type netutils_exec_t is
> >> not within scope' at token ';' on line 362418:
> >>    allow ifplugd_t netutils_exec_t:file { getattr open read execute };
> >> #line 67
> >> checkpolicy:  error(s) encountered while parsing configuration
> >> make: *** [/etc/selinux/refpolicy/policy/policy.23] Error 1
> >>
> >>
> >> --
> >> Waqar Afridi
> >
> > Justin P. Mattock

--nextPart10798810.8VD4R15e6h
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEABECAAYFAkqlFhAACgkQ1sXw8/2VziTL4ACgjIZO6rYtGOiDMKPRnC79jFGs
nYsAoKTRNnp5Y0TGXLwYil2ab1HNCQ6t
=Q6KV
-----END PGP SIGNATURE-----

--nextPart10798810.8VD4R15e6h--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
