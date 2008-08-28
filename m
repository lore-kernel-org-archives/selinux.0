Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7SLBtGO014853
	for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2008 17:11:55 -0400
Received: from ey-out-1920.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7SLBsxJ020678
	for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2008 21:11:55 GMT
Received: by ey-out-1920.google.com with SMTP id 4so168399eyg.30
        for <selinux@tycho.nsa.gov>; Thu, 28 Aug 2008 14:11:54 -0700 (PDT)
Subject: Re: About Domain Transition
From: Dominick Grift <domg472@gmail.com>
To: Hong <kindloaf@gmail.com>
Cc: SELinux Mailing List <selinux@tycho.nsa.gov>
In-Reply-To: <f00ed96d0808281333i6fb890a9j85949806cbbf2179@mail.gmail.com>
References: <f00ed96d0808281333i6fb890a9j85949806cbbf2179@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jJ1Hl1kV+YbkRKp9Evvj"
Date: Thu, 28 Aug 2008 23:11:52 +0200
Message-Id: <1219957912.11166.14.camel@sulphur.notebook.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-jJ1Hl1kV+YbkRKp9Evvj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-08-28 at 16:33 -0400, Hong wrote:

> Is there any documentation I can refer to so I can see how the access
> decision is made? Or where in the kernel source code above logic is
> implement?
>=20
> Thanks!
>=20

Hello and welcome, There is a separate mailing list for (ref)policy.
You can subscribe here: http://oss.tresys.com/mailman/listinfo/refpolicy

You can browse policy source code here:
http://oss.tresys.com/projects/refpolicy/browser/trunk

I Think your explanation looks good.=20

1. cannot execute (access is denied by default)

2. can execute but not transition to new domain (run executable file in
the caller domain) for example: if domain_type_6_t tries to execute
application_executable_files_type_1_t then run that process in the
domain_type_6_t domain

3. can execute and and transition to a predefined domain ( for example:
if domain_type_1_t tries to executes
application_executable_files_type_1_t then transition to domain_type_2_t

You can easily test these with policy like can_exec() and
domain_auto_trans()

Another good resource for knowledge is the #selinux and #fedora-selinux
irc channel on irc.freenode.org.



if domain_type_3_t tries to execute
application_executable_files_type_1_t then transition to domain_type_3_t
=20
--=20
Dominick Grift <domg472@gmail.com>

--=-jJ1Hl1kV+YbkRKp9Evvj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAki3FJEACgkQL00QnzrVtlzGfwCgzlY/2NaDjElofoJLi8m/O+uL
ThgAoJkerubhaDCWiw6JUmmOyarWWR7Q
=rvI4
-----END PGP SIGNATURE-----

--=-jJ1Hl1kV+YbkRKp9Evvj--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
