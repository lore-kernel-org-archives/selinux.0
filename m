Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAFFqIIi023816
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 10:52:18 -0500 (EST)
Received: from passage.avira.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAFFopvq028065
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 15:50:52 GMT
Message-ID: <4198D4CA.3020708@gentoo.org>
Date: Mon, 15 Nov 2004 18:09:46 +0200
From: petre rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: gentoo policy for stunnel
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig98D817110E51F1BA0D3EBBD8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig98D817110E51F1BA0D3EBBD8
Content-Type: multipart/mixed;
 boundary="------------020505030006000707010002"

This is a multi-part message in MIME format.
--------------020505030006000707010002
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hi,

attached you'll find the policy we use for stunnel [1]

[1] http://www.stunnel.org
	Stunnel is a program that allows you to encrypt arbitrary TCP connections inside SSL (Secure Sockets Layer) available on both Unix and Windows. Stunnel can allow you to secure non-SSL aware daemons and protocols (like POP, IMAP, LDAP, etc) by having Stunnel provide the encryption, requiring no 
changes to the daemon's code.

bye,
peter

-- 
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux

--------------020505030006000707010002
Content-Type: text/plain;
 name="stunnel.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stunnel.fc"

/usr/sbin/stunnel	--	system_u:object_r:stunnel_exec_t
/etc/stunnel(/.*)?          	system_u:object_r:stunnel_etc_t
/var/run/stunnel(/.*)?		system_u:object_r:stunnel_var_run_t

--------------020505030006000707010002
Content-Type: text/plain;
 name="stunnel.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stunnel.te"

# DESC: selinux policy for stunnel
#
# Author:   petre rodan <kaiowas@gentoo.org>
#

type stunnel_port_t, port_type;

daemon_domain(stunnel, `, privlog')

can_network(stunnel_t)

type stunnel_etc_t, file_type, sysadmfile;

allow stunnel_t self:capability { setgid setuid sys_chroot };
allow stunnel_t self:fifo_file { read write };
allow stunnel_t self:tcp_socket { read write };
allow stunnel_t self:unix_stream_socket { connect create };

allow stunnel_t stunnel_port_t:tcp_socket { name_bind };

r_dir_file(stunnel_t, stunnel_etc_t)
r_dir_file(stunnel_t, etc_t)

--------------020505030006000707010002--

--------------enig98D817110E51F1BA0D3EBBD8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBmNTKGSBEIeh4AEYRAsJ9AJ4ltnJ8TxZW4iwA06/z6xjvW6VfYgCgjuA5
3h3bKgXyCkkFSNECe9TF7bk=
=yBd6
-----END PGP SIGNATURE-----

--------------enig98D817110E51F1BA0D3EBBD8--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
