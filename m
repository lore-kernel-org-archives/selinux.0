Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8KGaOsJ003318
	for <selinux@tycho.nsa.gov>; Sat, 20 Sep 2003 12:36:24 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8KGaN2R024891
	for <selinux@tycho.nsa.gov>; Sat, 20 Sep 2003 16:36:23 GMT
Received: from chris.pebenito.dhs.org (12-251-184-225.client.attbi.com [12.251.184.225])
        by jazzband.ncsc.mil  with ESMTP id h8KGaN1A024888 for <selinux@tycho.nsa.gov>; Sat, 20 Sep 2003 16:36:23 GMT
Subject: run_init patch
From: Chris PeBenito <pebenito@gentoo.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-Z9VI2cdjvAu2CK/pMsaK"
Message-Id: <1064075776.2834.9.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: Sat, 20 Sep 2003 11:36:17 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Z9VI2cdjvAu2CK/pMsaK
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Here is a patch for policycoreutils (against 1.1) which closes the file
descriptor in run_init on successfully getting the context out of
/etc/security/initrc_context.  It is closed on a failed read, but was
missing on the successful read.

This prevents a denial similar to:
avc:  denied  { use } for  pid=13041 exe=/usr/sbin/smbd
path=/etc/security/initrc_context dev=03:03 ino=722489
scontext=system_u:system_r:smbd_t tcontext=pebenito:sysadm_r:run_init_t
tclass=fd

-- 
Chris PeBenito
<pebenito@gentoo.org>
Developer, SELinux
Hardened Gentoo Linux
 
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xE6AF9243
Key fingerprint = B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-Z9VI2cdjvAu2CK/pMsaK
Content-Disposition: attachment; filename=policycoreutils-1.1-close_init_fp.diff
Content-Type: text/x-patch; name=policycoreutils-1.1-close_init_fp.diff; charset=ISO-8859-1
Content-Transfer-Encoding: base64

ZGlmZiAtdXJOIHBvbGljeWNvcmV1dGlscy0xLjEub3JpZy9ydW5faW5pdC9ydW5faW5pdC5jIHBv
bGljeWNvcmV1dGlscy0xLjEvcnVuX2luaXQvcnVuX2luaXQuYw0KLS0tIHBvbGljeWNvcmV1dGls
cy0xLjEub3JpZy9ydW5faW5pdC9ydW5faW5pdC5jCTIwMDMtMDYtMDIgMTU6MjM6MDcuMDAwMDAw
MDAwIC0wNTAwDQorKysgcG9saWN5Y29yZXV0aWxzLTEuMS9ydW5faW5pdC9ydW5faW5pdC5jCTIw
MDMtMDktMjAgMTE6MjE6NDQuMDAwMDAwMDAwIC0wNTAwDQpAQCAtMjg4LDYgKzI4OCw3IEBADQog
ICAgICAgKmNvbnRleHQgPSBzdHJkdXAoYnVmcCk7DQogICAgICAgaWYgKCEoKmNvbnRleHQpKQ0K
IAlnb3RvIG91dDsNCisgICAgICBmY2xvc2UoZnApOw0KICAgICAgIHJldHVybiAwOw0KICAgICB9
DQogICB9DQo=

--=-Z9VI2cdjvAu2CK/pMsaK--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
