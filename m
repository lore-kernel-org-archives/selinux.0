Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAFHIrIi024638
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 12:18:53 -0500 (EST)
Received: from sunspire.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAFHHQvq004914
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 17:17:27 GMT
Message-ID: <4198E94B.8070008@gentoo.org>
Date: Mon, 15 Nov 2004 19:37:15 +0200
From: petre rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: gentoo policy for dante
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4E2F18D194527D3336FF3033"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4E2F18D194527D3336FF3033
Content-Type: multipart/mixed;
 boundary="------------030403000806070007000300"

This is a multi-part message in MIME format.
--------------030403000806070007000300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

this must be gentoo-day :)

policy for dante [1], attached

[1] http://www.inet.no/dante/

bye,
peter

-- 
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux

--------------030403000806070007000300
Content-Type: text/plain;
 name="dante.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dante.fc"

# dante
/usr/sbin/sockd		--	system_u:object_r:dante_exec_t
/etc/socks(/.*)?		system_u:object_r:dante_conf_t
/var/run/sockd.pid	--	system_u:object_r:dante_var_run_t

--------------030403000806070007000300
Content-Type: text/plain;
 name="dante.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dante.te"

#DESC dante - socks daemon
#
# Author: petre rodan <kaiowas@gentoo.org>
#

type dante_conf_t, file_type, sysadmfile;
type socks_port_t, port_type;

daemon_domain(dante)
can_network(dante_t)

allow dante_t self:fifo_file { read write };
allow dante_t self:capability { setuid };
allow dante_t self:unix_dgram_socket { connect create write };
allow dante_t self:unix_stream_socket { connect create read setopt write };

allow dante_t socks_port_t:tcp_socket name_bind;

allow dante_t { etc_t etc_runtime_t }:file r_file_perms;
r_dir_file(dante_t, dante_conf_t)

allow dante_t initrc_var_run_t:file { getattr write };

--------------030403000806070007000300--

--------------enig4E2F18D194527D3336FF3033
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBmOlPGSBEIeh4AEYRAqheAJ9oP/uTQOrrEZu4px7+j3xztiKoIACfVFv6
5/2h50VGxh1tM1yfoQyXqXM=
=IUzD
-----END PGP SIGNATURE-----

--------------enig4E2F18D194527D3336FF3033--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
