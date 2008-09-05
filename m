Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m85ENQ8Y025910
	for <selinux@tycho.nsa.gov>; Fri, 5 Sep 2008 10:23:26 -0400
Received: from ey-out-1920.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m85EMhqh005645
	for <selinux@tycho.nsa.gov>; Fri, 5 Sep 2008 14:22:48 GMT
Received: by ey-out-1920.google.com with SMTP id 4so205795eyg.30
        for <selinux@tycho.nsa.gov>; Fri, 05 Sep 2008 07:23:21 -0700 (PDT)
Subject: Re: user guide draft: "Targeted Policy" review
From: Dominick Grift <domg472@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Murray McAllister <mmcallis@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <48C13900.8050401@redhat.com>
References: <48BE3FB4.8020003@redhat.com> <48BE9106.6050703@redhat.com>
	 <48C0D4CD.5090908@redhat.com>  <48C13900.8050401@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YQA9ojgKJNpZ04rMcWzc"
Date: Fri, 05 Sep 2008 16:23:19 +0200
Message-Id: <1220624599.14911.6.camel@sulphur.notebook.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-YQA9ojgKJNpZ04rMcWzc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-09-05 at 09:49 -0400, Daniel J Walsh wrote:
> Murray McAllister wrote:
> > Daniel J Walsh wrote:
> > Murray McAllister wrote:
> >>>> Hi,
> >>>>
> >>>> The following is a draft of the "Targeted Policy" sections for the
> >>>> SELinux User Guide. Any comments and corrections are appreciated.
> >>>>
> >>>> Thanks.
> >>>>
> >>>> Targeted Policy
> >>>>
> >>>> Targeted policy is the default SELinux policy used in Fedora 10. Whe=
n
> >>>> using targeted policy, subjects that are targeted run in their own
> >>>> domain type, and subjects that are not targeted run in the unconfine=
d_t
> > confined domain, and subjects that are not targeted run in an unconfine=
d
> > domain,  For example logged in users by default log in as unconfined_t
> > while system processes started by init run in initrc_t.  Both of these
> > domains are unconfined.
> >=20
> > NOTE:
> >=20
> > Even unconfined domains are subject to executable/writable memory
> > checks.  execmem, execstack, execheap.  By default processes run as an
> > unconfined domain can not allocate writeable memory and execute it.
> > This is a common attack vector call buffer overflow attacks.  Some
> > applications require this type of access (java, wine, mono and a few
> > others).=20
> >=20
> >> Does this mean applications running in a Java Virtual Machine, and in =
Wine?
> >=20
> >> I'll change my response below based on the answer to this.
> Yes
> >=20
> >> These applications need to be labeled correctly to allow the
> > access.  There are booleans that can turn off this protection for the
> > unconfined user unconfined_t.  allow_execmem, allow_execstack,
> > allow_execheap.
> >=20
> > You can turn the booleans on using setsebool
> >=20
> > setsebool -P allow_execmem 1
> >=20
> >> I will use these examples later on.
> >=20
> >=20
And then there is text relocation

http://people.redhat.com/drepper/textrelocs.html
http://people.redhat.com/drepper/selinux-mem.html

/usr/sbin/semanage fcontext -l | grep execmem
/usr/sbin/semanage fcontext -l | grep textrel

> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov =
with
> the words "unsubscribe selinux" without quotes as the message.
--=20
Dominick Grift <domg472@gmail.com>

--=-YQA9ojgKJNpZ04rMcWzc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkjBQM8ACgkQL00QnzrVtly0hgCfQDsDChaVz4GWqg1paaOLEpZF
BnsAoID6B+Exh6gsKR7G0pygYjKX0Ejs
=Jdac
-----END PGP SIGNATURE-----

--=-YQA9ojgKJNpZ04rMcWzc--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
