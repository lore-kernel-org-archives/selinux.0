Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6MAHUCd006693
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 06:17:30 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6MAHTfY013939
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 10:17:29 GMT
Message-ID: <4885B399.10900@redhat.com>
Date: Tue, 22 Jul 2008 06:16:57 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: david@hardeman.nu
CC: selinux@tycho.nsa.gov, cpebenito@tresys.com
Subject: Re: [refpolicy-patch 02/23] anaconda policy update
References: <20080719205002.462190042@hardeman.nu> <20080719210251.406319184@hardeman.nu>
In-Reply-To: <20080719210251.406319184@hardeman.nu>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

david@hardeman.nu wrote:
> Anaconda is a RH installation program, RH should know their own program and
> the changes are quite trivial
> 
> diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/anaconda.te serefpolicy-3.5.0/policy/modules/admin/anaconda.te
> --- nsaserefpolicy/policy/modules/admin/anaconda.te	2008-07-10 11:38:46.000000000 -0400
> +++ serefpolicy-3.5.0/policy/modules/admin/anaconda.te	2008-07-15 14:05:12.000000000 -0400
> @@ -31,16 +31,11 @@
>  modutils_domtrans_insmod(anaconda_t)
>  
>  seutil_domtrans_semanage(anaconda_t)
> -
> -unconfined_domain(anaconda_t)
> +seutil_domtrans_setsebool(anaconda_t)
>  
>  unprivuser_home_dir_filetrans_home_content(anaconda_t,{ dir file lnk_file fifo_file sock_file })
>  
>  optional_policy(`
> -	dmesg_domtrans(anaconda_t)
> -')
> -
> -optional_policy(`
>  	kudzu_domtrans(anaconda_t)
>  ')
>  
> @@ -58,5 +53,9 @@
>  ')
>  
>  optional_policy(`
> +	unconfined_domain(anaconda_t)
> +')
> +
> +optional_policy(`
>  	usermanage_domtrans_admin_passwd(anaconda_t)
>  ')
> 
The main goal of this patch was to get anaconda AVC messages out of the
log files.  Anaconda has to run the installation in permissive mode so
we need to avoid avc messages by making it unconfined and avoid
transitions where ever possible. The goal is to have /root/anaconda.log
without any SELinux errors.  As for Russells comments we might want to
make this more of a generic installer policy?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkiFs5kACgkQrlYvE4MpobPyfgCgm2z8rAQUfh2OGMKVjeInIWtV
nJUAn35LGrkmmxctLPKDEqvQ2g78+BpC
=qC6x
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
