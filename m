Message-Id: <200606170224.k5H2ONvL009887@turing-police.cc.vt.edu>
To: janak@us.ibm.com
Cc: dwalsh@redhat.com, sgrubb@redhat.com, tmraz@redhat.com, klaus@atsec.com,
        sds@tycho.nsa.gov, russell@coker.com.au, selinux@tycho.nsa.gov
Subject: Re: [PATCH] pam_namespace : allow use of X and gdm while polyinstantiating /tmp
In-Reply-To: Your message of "Thu, 15 Jun 2006 22:56:46 EDT."
             <1150426606.12904.3.camel@localhost.localdomain>
From: Valdis.Kletnieks@vt.edu
References: <1150426606.12904.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1150511062_4789P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 16 Jun 2006 22:24:23 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1150511062_4789P
Content-Type: text/plain; charset=us-ascii

On Thu, 15 Jun 2006 22:56:46 EDT, Janak Desai said:
> Changes since the last version:
>     - Execute instance initialization script at each instance setup
>     - Properly obtain exit status from a child process that executes
>       the instance initialization script
>     - Example script for using X while polyinstantiating /tmp
>     - Update Makefile.am to make sure that the instance initialization script
>       gets installed with execute permission
>     - Update man pages and README to reflect above changes
> 
> Signed-off-by: Janak Desai <janak@us.ibm.com>

Minor nit....

> diff -Naurp pam_namespace0615/modules/pam_namespace/Makefile.am pam_namespace0615+patch/modules/pam_namespace/Makefile.am
> --- pam_namespace0615/modules/pam_namespace/Makefile.am	2006-06-16 02:07:24.000000000 +0000
> +++ pam_namespace0615+patch/modules/pam_namespace/Makefile.am	2006-06-16 01:18:16.000000000 +0000
> @@ -33,5 +33,6 @@ if HAVE_UNSHARE
>  securelib_LTLIBRARIES = pam_namespace.la
>  pam_namespace_la_SOURCES = pam_namespace.c md5.c md5.h
>  
> -secureconf_DATA = namespace.conf namespace.init
> +secureconf_DATA = namespace.conf
> +secureconf_SCRIPT = namespace.init
>  endif

This chokes on an 'rpmbuild', because namespace.init doesn't get installed.
The problem is that there's supporting stuff in the Makefile that gets
produces to install the secoreconf_DATA (see the install-secureconfDATA
target), but there's no matching install-secureconfSCRIPT target to get
the script installed to make rpmbuild happy....  Nuking that one part
gets an RPM that packages /etc/security/namespace.init.

I'll post later about whether the sample namespace.init actually works
when you uncomment the X11 support code.. 


--==_Exmh_1150511062_4789P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEk2fWcC3lWbTT17ARAkBwAKDsLyVh3VMEEzMyp83wcKasnEn0IQCg2ldf
yOkchXdqJBE58s0LEM5RSgY=
=pEt4
-----END PGP SIGNATURE-----

--==_Exmh_1150511062_4789P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
