Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAL8xBIi029857
	for <selinux@tycho.nsa.gov>; Sun, 21 Nov 2004 03:59:11 -0500 (EST)
Received: from sunspire.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAL8vf5H004710
	for <selinux@tycho.nsa.gov>; Sun, 21 Nov 2004 08:57:42 GMT
Message-ID: <41A05C93.2050609@gentoo.org>
Date: Sun, 21 Nov 2004 11:14:59 +0200
From: petre rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: jwcart2@epoch.ncsc.mil, SELinux <selinux@tycho.nsa.gov>,
   Chris PeBenito <pebenito@gentoo.org>
Subject: Re: gentoo policy for dante
References: <4198E94B.8070008@gentoo.org>	 <1100808438.26930.28.camel@moss-lions.epoch.ncsc.mil>	 <419D1ABD.4020901@gentoo.org> <1100893919.31793.32.camel@moss-lions.epoch.ncsc.mil> <41A02530.3070505@redhat.com>
In-Reply-To: <41A02530.3070505@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig61E5FCC86E95E6EEFD216569"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig61E5FCC86E95E6EEFD216569
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hi Daniel,

Daniel J Walsh wrote:
> Small change on previous patch.
> 
> Please ignore previous patch and use this one.
> 
[..]
> diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/stunnel.te policy-1.19.4/domains/program/unused/stunnel.te
> --- nsapolicy/domains/program/unused/stunnel.te	2004-11-18 14:44:59.000000000 -0500
> +++ policy-1.19.4/domains/program/unused/stunnel.te	2004-11-21 00:17:07.934617676 -0500
> @@ -2,21 +2,10 @@
>  #
>  # Author:   petre rodan <kaiowas@gentoo.org>
>  #
> +inetd_child_domain(stunnel, tcp)
>  
> -type stunnel_port_t, port_type;
> -
> -daemon_domain(stunnel)
> -
> -can_network(stunnel_t)
> -
> -type stunnel_etc_t, file_type, sysadmfile;
> -
> -allow stunnel_t self:capability { setgid setuid sys_chroot };
> -allow stunnel_t self:fifo_file { read write };
> -allow stunnel_t self:tcp_socket { read write };
> -allow stunnel_t self:unix_stream_socket { connect create };

please put this in a distro or a inetd ifdef.
stunnel is in no way dependent on inetd, and gentoo has dropped inetd support (so we don't even have that macro you're using).

thanks,
peter

-- 
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux

--------------enig61E5FCC86E95E6EEFD216569
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBoFyXGSBEIeh4AEYRAkiNAJ0ejEfc5g/2g4SbR80wToilsCWiKgCaAtL2
ssmvehKtfOzfdZKG1U/N+fk=
=3pji
-----END PGP SIGNATURE-----

--------------enig61E5FCC86E95E6EEFD216569--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
