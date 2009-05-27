Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4RA7nsY026603
	for <selinux@tycho.nsa.gov>; Wed, 27 May 2009 06:07:49 -0400
Received: from mail.fluendo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n4RA7DEB022241
	for <selinux@tycho.nsa.gov>; Wed, 27 May 2009 10:07:42 GMT
Received: from mail.fluendo.com (localhost.localdomain [127.0.0.1])
	by mail.fluendo.com (Postfix) with ESMTP id E0841250035
	for <selinux@tycho.nsa.gov>; Wed, 27 May 2009 12:06:42 +0200 (CEST)
Received: from [192.168.3.24] (o.bcn.fluendo.net [195.10.10.180])
	by mail.fluendo.com (Postfix) with ESMTP id 877DB250031
	for <selinux@tycho.nsa.gov>; Wed, 27 May 2009 12:06:41 +0200 (CEST)
Message-ID: <4A1D10AE.7020009@flumotion.com>
Date: Wed, 27 May 2009 12:06:38 +0200
From: Ioannis Aslanidis <iaslanidis@flumotion.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Problem with SELinux and glusterfs when trying to allow memprotect/mmap_zero
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE803FF57B8383A06316C7446"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE803FF57B8383A06316C7446
Content-Type: multipart/mixed;
 boundary="------------040807030209010205030607"

This is a multi-part message in MIME format.
--------------040807030209010205030607
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

I am trying to allow the following audit message through, but it says
that there is a violation. Can anyone explain what exactly is going on?

Thank you,

Ioannis

# cat messages.audit
May 27 01:51:13 streamer012 kernel: audit(1243381873.876:60): avc:
denied  { mmap_zero } for  pid=3D3155 comm=3D"glusterfs2"
scontext=3Dsystem_u:system_r:mount_t:s0
tcontext=3Dsystem_u:system_r:mount_t:s0 tclass=3Dmemprotect


# cat selinuxglusterfs.te

module selinuxglusterfs 1.0;

require {
	type mount_t;
	class memprotect mmap_zero;
}

#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D mount_t =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
allow mount_t self:memprotect mmap_zero;


#  semodule -i selinuxglusterfs.pp
libsepol.check_assertion_helper: assertion on line 0 violated by allow
mount_t mount_t:memprotect { mmap_zero };
libsepol.check_assertions: 1 assertion violations occured
libsemanage.semanage_expand_sandbox: Expand module failed
semodule:  Failed!

--------------040807030209010205030607
Content-Type: text/x-vcard; charset=utf-8;
 name="iaslanidis.vcf"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="iaslanidis.vcf"

begin:vcard
fn:Ioannis Aslanidis
n:Aslanidis;Ioannis
org:Flumotion Services S.A.;Infrastructure Department
adr:Edifici Nord Planta 2;;World Trade Center;Barcelona;Barcelona;08039;S=
pain
email;internet:iaslanidis@flumotion.com
title:System and Network Administrator
tel;work:+34935086359
tel;cell:+34672204575
note;quoted-printable:PGP Key: 0xBEAC0800 (pgp.rediris.es)=3D0D=3D0A=3D
	Key fingerprint =3D3D 73FE B836 D116 1EF1 D580  C06E 16AF BCC3 BEAC 0800=

url:http://www.flumotion.com
version:2.1
end:vcard


--------------040807030209010205030607--

--------------enigE803FF57B8383A06316C7446
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkodELEACgkQFq+8w76sCAAIOgCeLzEL6jB3KpqHChhEUaZYvIoc
LZAAnRBKgrC5K2nHpUsAWXQh4to2psbW
=CeaZ
-----END PGP SIGNATURE-----

--------------enigE803FF57B8383A06316C7446--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
