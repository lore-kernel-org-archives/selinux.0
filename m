Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAS9KkIi006359
	for <selinux@tycho.nsa.gov>; Sun, 28 Nov 2004 04:20:46 -0500 (EST)
Received: from sunspire.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAS9JD5A018745
	for <selinux@tycho.nsa.gov>; Sun, 28 Nov 2004 09:19:13 GMT
Message-ID: <41A99F8C.4080503@gentoo.org>
Date: Sun, 28 Nov 2004 11:51:08 +0200
From: petre rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: jwcart2@epoch.ncsc.mil, SELinux <selinux@tycho.nsa.gov>
Subject: Re: gentoo policy for dante
References: <4198E94B.8070008@gentoo.org>	 <1100808438.26930.28.camel@moss-lions.epoch.ncsc.mil>	 <419D1ABD.4020901@gentoo.org> <1100893919.31793.32.camel@moss-lions.epoch.ncsc.mil> <41A02530.3070505@redhat.com>
In-Reply-To: <41A02530.3070505@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE8EFCEF610CAE161111F1D1D"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE8EFCEF610CAE161111F1D1D
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hi Daniel,

Daniel J Walsh wrote:
> Small change on previous patch.
> 
> Please ignore previous patch and use this one.
 >
> --- nsapolicy/domains/program/unused/postgresql.te	2004-11-20 22:29:09.000000000 -0500
> +++ policy-1.19.4/domains/program/unused/postgresql.te	2004-11-21 00:17:07.933617789 -0500
> @@ -110,6 +110,14 @@
>  dontaudit postgresql_t selinux_config_t:dir { search };
>  allow postgresql_t mail_spool_t:dir { search };
>  rw_dir_create_file(postgresql_t, var_lock_t)
> +can_exec(postgresql_t, { shell_exec_t bin_t } )
> +ifdef(`httpd.te', `
> +# 
> +# Allow httpd to work with postgresql
> +#
> +allow httpd_t postgresql_tmp_t:sock_file rw_file_perms;
> +can_unix_connect(httpd_t, posgresql_t)
> +')

shouldn't this be an ifdef on apache.te instead of httpd.te?

bye,
peter

-- 
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux

--------------enigE8EFCEF610CAE161111F1D1D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBqZ+MGSBEIeh4AEYRArVnAJsGIW038hI+9voIVtrrIVjHZUX6aQCgijk7
Luxre+YN/FUGykGPEq7GB5A=
=oBJd
-----END PGP SIGNATURE-----

--------------enigE8EFCEF610CAE161111F1D1D--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
