Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m24EAJ8v019072
	for <selinux@tycho.nsa.gov>; Tue, 4 Mar 2008 09:10:19 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m24EAHRe017929
	for <selinux@tycho.nsa.gov>; Tue, 4 Mar 2008 14:10:18 GMT
Message-ID: <47CD5816.8000805@redhat.com>
Date: Tue, 04 Mar 2008 09:09:26 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Gienek Nowacki <nowackig@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Problem with corenet_* statements.
References: <29e7ef020803031339h759da5f9gd0eb196eb638ac6b@mail.gmail.com>
In-Reply-To: <29e7ef020803031339h759da5f9gd0eb196eb638ac6b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Gienek Nowacki wrote:
> Hi,
> 
> I would like to build my own SE module. The system is CentOS 5.1. The
> source of the module is as follow:
> 
> # ============ amav.te ===================
> 
> module amav 1.0.0;
> require {
>         type amavis_t;
> };
> corenet_udp_bind_generic_port(amavis_t);
> corenet_dontaudit_udp_bind_all_ports(amavis_t);
> 
> # ====================================
> 
> After running the command:
> checkmodule -M -m -o amav.mod  amav.te
> 
> ....there is `syntax error' -  checkmodule doasn't recognize
> corenet_*  statements.
> 
> Next, after successful I would like to use semodule_package and
> semodule commands.
> 
> The purpose of creating such modul is because amavisd use random UDP
> source ports when connecting to DNS serwer.
> 
> Could you help me how  - how there is possible to find the solution?
> 
> Gienek
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
You need to build with the interace files.

# yum install selinux-policy-devel
# make -f /usr/share/selinux/devel/Makefile

Should build your module.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkfNWBYACgkQrlYvE4MpobNExgCbBr4rqoz1r/Md9g4DMBjdgXaL
kOwAn1w0cj49wR5IOaemfb8MihbDinSC
=A0HS
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
