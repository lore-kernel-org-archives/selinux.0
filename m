Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBTKDXIi029751
	for <selinux@tycho.nsa.gov>; Wed, 29 Dec 2004 15:13:33 -0500 (EST)
Received: from sunspire.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBTKDYXh029024
	for <selinux@tycho.nsa.gov>; Wed, 29 Dec 2004 20:13:35 GMT
Message-ID: <41D32C09.9020409@gentoo.org>
Date: Thu, 30 Dec 2004 00:13:29 +0200
From: petre rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: gentoo policies for daemontools, ucspi-tcp, publicfile,	djbdns,
 clockspeed
References: <41A07D3C.4070300@gentoo.org> <1103139082.31218.29.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1103139082.31218.29.camel@moss-lions.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE4C1DCC55718CAD8D1785473"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE4C1DCC55718CAD8D1785473
Content-Type: multipart/mixed;
 boundary="------------060503030107050904050705"

This is a multi-part message in MIME format.
--------------060503030107050904050705
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

James Carter wrote:
> Do others use these tools?
>
> Petre, you didn't include the publicfile policy, would you please send
> it to the list.

oops, sorry, here it is =)


Happy Holidays To Everyone!

peter

--------------060503030107050904050705
Content-Type: text/plain;
 name="publicfile.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="publicfile.fc"


/usr/bin/ftpd			--	system_u:object_r:publicfile_exec_t
/usr/bin/httpd			--	system_u:object_r:publicfile_exec_t
/usr/bin/publicfile-conf	--	system_u:object_r:publicfile_exec_t

# this is the place where online content located
# set this to suit your needs
#/var/www(/.*)?			system_u:object_r:publicfile_content_t


--------------060503030107050904050705
Content-Type: text/plain;
 name="publicfile.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="publicfile.te"

#DESC Publicfile - HTTP and FTP file services
# http://cr.yp.to/publicfile.html
#
# Author: petre rodan <kaiowas@gentoo.org>
#
# this policy depends on ucspi-tcp
#

ifdef(`ftpd.te', `
', `
type ftp_port_t, port_type, reserved_port_type;
type ftp_data_port_t, port_type, reserved_port_type;
')

ifdef(`apache.te', `
', `
type http_port_t, port_type, reserved_port_type;
')

daemon_domain(publicfile)
type publicfile_content_t, file_type, sysadmfile;
domain_auto_trans(initrc_t, publicfile_exec_t, publicfile_t)

ifdef(`ucspi-tcp.te', `
domain_auto_trans(utcpserver_t, publicfile_exec_t, publicfile_t)
allow publicfile_t utcpserver_t:tcp_socket { read write };
allow utcpserver_t { ftp_data_port_t ftp_port_t http_port_t }:tcp_socket name_bind;
')

allow publicfile_t initrc_t:tcp_socket { read write };

allow publicfile_t self:capability { dac_override setgid setuid sys_chroot };

r_dir_file(publicfile_t, publicfile_content_t)



--------------060503030107050904050705--

--------------enigE4C1DCC55718CAD8D1785473
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFB0ywOGSBEIeh4AEYRAkm6AJ9VqpbBPsQ9Dn80tHM96oAAi3zabgCeJq79
AkP5BWmkgNymKcf5E/kfP6s=
=40FJ
-----END PGP SIGNATURE-----

--------------enigE4C1DCC55718CAD8D1785473--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
