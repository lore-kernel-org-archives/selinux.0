Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA08930
	for <selinux@tycho.nsa.gov>; Fri, 5 Jul 2002 09:34:20 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA01192
	for <selinux@tycho.nsa.gov>; Fri, 5 Jul 2002 13:32:52 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id NAA01188 for <selinux@tycho.nsa.gov>; Fri, 5 Jul 2002 13:32:52 GMT
Received: from localhost (sds@localhost)
	by raven.gw.tislabs.com (8.11.6/8.11.6) with ESMTP id g65DXnp04870
	for <selinux@tycho.nsa.gov>; Fri, 5 Jul 2002 09:33:49 -0400 (EDT)
Date: Fri, 5 Jul 2002 09:33:49 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: <selinux@tycho.nsa.gov>
Subject: [patch] run_init.fc
Message-ID: <Pine.GSO.4.33.0207050922340.29942-200000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1297389768-1025875510=:29942"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1297389768-1025875510=:29942
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.33.0207050928201.29942@raven>


The attached patch fixes an erroneous entry in the
policy/file_contexts/program/run_init.fc file that affects people using
the upstream SELinux release (not the Debian selinux package).  To apply,
cd selinux && patch -p0 < ~/run_init.patch.  You can then run 'cd policy
&& make relabel' or simply run 'chcon system_u:object_r:run_init_exec_t
/usr/local/selinux/sbin/run_init' to relabel run_init properly.  This
patch has been committed to the sourceforge CVS tree.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



---559023410-1297389768-1025875510=:29942
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="run_init.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0207050925100.29942@raven>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="run_init.patch"

SW5kZXg6IHBvbGljeS9maWxlX2NvbnRleHRzL3Byb2dyYW0vcnVuX2luaXQu
ZmMNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT0NClJDUyBmaWxlOiAvY3Zzcm9v
dC9zZWxpbnV4L25zYS9zZWxpbnV4L3BvbGljeS9maWxlX2NvbnRleHRzL3By
b2dyYW0vcnVuX2luaXQuZmMsdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjEu
MS4yDQpkaWZmIC11IC1yMS4xLjEuMiBydW5faW5pdC5mYw0KLS0tIHBvbGlj
eS9maWxlX2NvbnRleHRzL3Byb2dyYW0vcnVuX2luaXQuZmMJMyBKdWwgMjAw
MiAyMDoyNjoyMiAtMDAwMAkxLjEuMS4yDQorKysgcG9saWN5L2ZpbGVfY29u
dGV4dHMvcHJvZ3JhbS9ydW5faW5pdC5mYwk1IEp1bCAyMDAyIDEzOjIwOjIz
IC0wMDAwDQpAQCAtMSwzICsxLDMgQEANCiAjIHJ1bl9pbml0DQotL3Vzci9s
b2NhbC9zZWxpbnV4L2Jpbi9ydW5faW5pdAkJc3lzdGVtX3U6b2JqZWN0X3I6
cnVuX2luaXRfZXhlY190DQorL3Vzci9sb2NhbC9zZWxpbnV4L3NiaW4vcnVu
X2luaXQJc3lzdGVtX3U6b2JqZWN0X3I6cnVuX2luaXRfZXhlY190DQogL3Vz
ci9zYmluL3J1bl9pbml0CQlzeXN0ZW1fdTpvYmplY3RfcjpydW5faW5pdF9l
eGVjX3QNCg==
---559023410-1297389768-1025875510=:29942--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
