Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA23006
	for <selinux@tycho.nsa.gov>; Mon, 22 Apr 2002 16:39:28 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA16574
	for <selinux@tycho.nsa.gov>; Mon, 22 Apr 2002 20:38:16 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id UAA16570 for <selinux@tycho.nsa.gov>; Mon, 22 Apr 2002 20:38:16 GMT
Date: Mon, 22 Apr 2002 16:39:09 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: boot loader
In-Reply-To: <20020422195846.432904545D@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0204221636350.28618-300000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1804928587-1019507949=:28618"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1804928587-1019507949=:28618
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Mon, 22 Apr 2002, Russell Coker wrote:

> I've attached my new te file, and following is the lilo file_contexts entries:
> /etc/lilo.conf                  system_u:object_r:etc_bootloader_t
> /sbin/lilo.*                    system_u:object_r:bootloader_exec_t

Thanks.  I had to add a few permissions (search access to /dev, use
descriptors created by newrole, write to the administrator's terminal) to
bootloader.te.  The first attached patch shows the changes.  The second
attached patch shows the changes to assert.te and admin_macros.te.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



---559023410-1804928587-1019507949=:28618
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="bootloader.te.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0204221639090.28618@raven>
Content-Description: 
Content-Disposition: attachment; filename="bootloader.te.patch"

LS0tIGJvb3Rsb2FkZXIudGUub2xkCU1vbiBBcHIgMjIgMTY6MzI6MzcgMjAw
Mg0KKysrIGJvb3Rsb2FkZXIudGUJTW9uIEFwciAyMiAxNjoyNTo1OSAyMDAy
DQpAQCAtMTcsMTAgKzE3LDExIEBADQogcm9sZSBzeXN0ZW1fciB0eXBlcyBi
b290bG9hZGVyX3Q7DQogDQogZG9tYWluX2F1dG9fdHJhbnMoc3lzYWRtX3Qs
IGJvb3Rsb2FkZXJfZXhlY190LCBib290bG9hZGVyX3QpDQorYWxsb3cgYm9v
dGxvYWRlcl90IG5ld3JvbGVfdDpmZCB1c2U7DQogDQogZmlsZV90eXBlX2F1
dG9fdHJhbnMoYm9vdGxvYWRlcl90LCB0bXBfdCwgYm9vdGxvYWRlcl90bXBf
dCkNCiANCi1hbGxvdyBib290bG9hZGVyX3QgeyBldGNfdCB9OmRpciByX2Rp
cl9wZXJtczsNCithbGxvdyBib290bG9hZGVyX3QgeyBldGNfdCBkZXZpY2Vf
dCB9OmRpciByX2Rpcl9wZXJtczsNCiB1c2VzX3NobGliKGJvb3Rsb2FkZXJf
dCkNCiANCiBhbGxvdyBib290bG9hZGVyX3QgeyBmaXhlZF9kaXNrX2Rldmlj
ZV90IHJlbW92YWJsZV9kZXZpY2VfdCB9OmJsa19maWxlIHJ3X2ZpbGVfcGVy
bXM7DQpAQCAtNDcsNiArNDgsOCBAQA0KIGFsbG93IGJvb3Rsb2FkZXJfdCBl
dGNfcnVudGltZV90OmZpbGUgcl9maWxlX3Blcm1zOw0KIA0KIGFsbG93IGJv
b3Rsb2FkZXJfdCBkZXZ0dHlfdDpjaHJfZmlsZSByd19maWxlX3Blcm1zOw0K
K2FsbG93IGJvb3Rsb2FkZXJfdCBzeXNhZG1fdHR5X2RldmljZV90OmNocl9m
aWxlIHJ3X2ZpbGVfcGVybXM7DQorYWxsb3cgYm9vdGxvYWRlcl90IHN5c2Fk
bV9kZXZwdHNfdDpjaHJfZmlsZSByd19maWxlX3Blcm1zOw0KIA0KICMgZm9y
IHJlYWRpbmcgQklPUyBkYXRhDQogYWxsb3cgYm9vdGxvYWRlcl90IG1lbW9y
eV9kZXZpY2VfdDpjaHJfZmlsZSByX2ZpbGVfcGVybXM7DQo=
---559023410-1804928587-1019507949=:28618
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="assert-admin.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0204221639091.28618@raven>
Content-Description: 
Content-Disposition: attachment; filename="assert-admin.patch"

SW5kZXg6IHBvbGljeS9hc3NlcnQudGUNCj09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0NClJDUyBmaWxlOiAvY3ZzL2xzbS9zZWxpbnV4L3BvbGljeS9hc3NlcnQu
dGUsdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjEzDQpkaWZmIC11IC1yMS4x
MyBhc3NlcnQudGUNCi0tLSBwb2xpY3kvYXNzZXJ0LnRlCTIwMDIvMDMvMjYg
MTc6NDU6MzYJMS4xMw0KKysrIHBvbGljeS9hc3NlcnQudGUJMjAwMi8wNC8y
MiAyMDozMTo1Nw0KQEAgLTQ1LDEwICs0NSw5IEBADQogbmV2ZXJhbGxvdyB+
YWRtaW4geyBsaWJfdCBiaW5fdCBzYmluX3QgfTpmaWxlIHsgd3JpdGUgYXBw
ZW5kIHVubGluayByZW5hbWUgfTsNCiANCiAjDQotIyBWZXJpZnkgdGhhdCBv
bmx5IHRoZSBhZG1pbmlzdHJhdG9yIGRvbWFpbiBhbmQgdGhlDQotIyBmaWxl
IHN5c3RlbSBhZG1pbmlzdHJhdGlvbiBkb21haW4gaGF2ZSBhY2Nlc3MgdG8g
dGhlIHJhdyBkaXNrIGRldmljZXMuDQorIyBWZXJpZnkgdGhhdCBvbmx5IGNl
cnRhaW4gZG9tYWlucyBoYXZlIGFjY2VzcyB0byB0aGUgcmF3IGRpc2sgZGV2
aWNlcy4NCiAjDQotbmV2ZXJhbGxvdyB+eyBhZG1pbiBmc2FkbV90IG1vdW50
X3QgfSBmaXhlZF9kaXNrX2RldmljZV90OmRldmZpbGVfY2xhc3Nfc2V0IHsg
cmVhZCB3cml0ZSBhcHBlbmQgfTsNCituZXZlcmFsbG93IH57IGJvb3Rsb2Fk
ZXJfdCBmc2FkbV90IG1vdW50X3QgfSBmaXhlZF9kaXNrX2RldmljZV90OmRl
dmZpbGVfY2xhc3Nfc2V0IHsgcmVhZCB3cml0ZSBhcHBlbmQgfTsNCiANCiAj
DQogIyBWZXJpZnkgdGhhdCBvbmx5IHRoZSBYIHNlcnZlciBhbmQga2xvZ2Qg
aGF2ZSBhY2Nlc3MgdG8gbWVtb3J5IGRldmljZXMuDQpJbmRleDogcG9saWN5
L21hY3Jvcy9hZG1pbl9tYWNyb3MudGUNCj09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0NClJDUyBmaWxlOiAvY3ZzL2xzbS9zZWxpbnV4L3BvbGljeS9tYWNyb3Mv
YWRtaW5fbWFjcm9zLnRlLHYNCnJldHJpZXZpbmcgcmV2aXNpb24gMS41DQpk
aWZmIC11IC1yMS41IGFkbWluX21hY3Jvcy50ZQ0KLS0tIHBvbGljeS9tYWNy
b3MvYWRtaW5fbWFjcm9zLnRlCTIwMDIvMDMvMjYgMTk6MzI6MTIJMS41DQor
KysgcG9saWN5L21hY3Jvcy9hZG1pbl9tYWNyb3MudGUJMjAwMi8wNC8yMiAy
MDozMTo1Nw0KQEAgLTMyLDEwICszMiw2IEBADQogYWxsb3cgJDFfdCBzeXNh
ZG1maWxlOm5vdGRldmZpbGVfY2xhc3Nfc2V0IGNyZWF0ZV9maWxlX3Blcm1z
Ow0KIGFsbG93ICQxX3Qgc3lzYWRtZmlsZTpkaXIgY3JlYXRlX2Rpcl9wZXJt
czsNCiANCi0jIFVzZSAvc2Jpbi9saWxvIHRvIHVwZGF0ZSB0aGUgYm9vdCBs
b2FkZXIuDQotIyBYWFggRklYTUUhICBNb3ZlIGxpbG8gaW50byBzZXBhcmF0
ZSBkb21haW4uDQotYWxsb3cgJDFfdCBmaXhlZF9kaXNrX2RldmljZV90OmRl
dmZpbGVfY2xhc3Nfc2V0IHJ3X2ZpbGVfcGVybXM7DQotDQogIyBBY2Nlc3Mg
cmVtb3ZhYmxlIGRldmljZXMuDQogYWxsb3cgJDFfdCByZW1vdmFibGVfZGV2
aWNlX3Q6ZGV2ZmlsZV9jbGFzc19zZXQgcndfZmlsZV9wZXJtczsNCiANCg==
---559023410-1804928587-1019507949=:28618--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
