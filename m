Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6OCNOkL026152
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2008 08:23:24 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6OCNNWE009147
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2008 12:23:23 GMT
Message-ID: <4888742E.1060106@redhat.com>
Date: Thu, 24 Jul 2008 08:23:10 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: david@hardeman.nu
CC: selinux@tycho.nsa.gov, cpebenito@tresys.com
Subject: Re: [refpolicy-patch 11/23] cpucontrol policy update
References: <20080719205002.462190042@hardeman.nu> <20080719210252.834349352@hardeman.nu>
In-Reply-To: <20080719210252.834349352@hardeman.nu>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

david@hardeman.nu wrote:
> Only documentation changes...
> 
> diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cpucontrol.if serefpolicy-3.5.0/policy/modules/services/cpucontrol.if
> --- nsaserefpolicy/policy/modules/services/cpucontrol.if	2008-07-10 11:38:46.000000000 -0400
> +++ serefpolicy-3.5.0/policy/modules/services/cpucontrol.if	2008-07-15 14:05:12.000000000 -0400
> @@ -4,9 +4,9 @@
>  ## <summary>
>  ##	CPUcontrol stub interface.  No access allowed.
>  ## </summary>
> -## <param name="domain" unused="true">
> +## <param name="domain" optional="true">
>  ##	<summary>
> -##	Domain allowed access.
> +##	N/A
>  ##	</summary>
>  ## </param>
>  #
> 
This is a reversal of upstream I have removed from latest rawhide policy.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkiIdC4ACgkQrlYvE4MpobPWvQCgouVlsFb+DJX8Q1hTuYTWNCh3
xIYAoNSMlNXHdd5ExC+w1Bjxc7ds/M7W
=eizO
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
