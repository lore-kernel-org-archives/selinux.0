Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o0QFkHcI017100
	for <selinux@tycho.nsa.gov>; Tue, 26 Jan 2010 10:46:18 -0500
Received: from hostingsmtp.register.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o0QFkAjE009960
	for <selinux@tycho.nsa.gov>; Tue, 26 Jan 2010 15:46:10 GMT
Message-Id: <201001261546.o0QFkDMJ023435@vivaldi15.register.it>
From: "Guido Trentalancia" <guido@trentalancia.com>
Reply-To: "Guido Trentalancia" <guido@trentalancia.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: refpolicy@oss1.tresys.com, selinux@tycho.nsa.gov
Subject: Re: Building MLS/MCS policy
Date: Tue, 26 Jan 2010 16:46:13 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_f4c1dc87a99c287bd25ac03c3750d5a0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------_=_NextPart_000_f4c1dc87a99c287bd25ac03c3750d5a0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_c40e22be9a4bce4c70e45d3b688b6936"


------_=_NextPart_001_c40e22be9a4bce4c70e45d3b688b6936
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Stephen,

what I propose is to add a few lines of documentation explaining the process of switching between different policy types (see the two patches below, one for load_policy and the other for the reference policy).

diff -pru policycoreutils-2.0.77/load_policy/load_policy.8 policycoreutils-2.0.77-new/load_policy/load_policy.8
--- policycoreutils-2.0.77/load_policy/load_policy.8    2009-11-19 23:16:03.000000000 +0100
+++ policycoreutils-2.0.77-new/load_policy/load_policy.8        2010-01-26 16:26:11.210178317 +0100
@@ -12,6 +12,11 @@ load_policy loads the installed policy f
 The existing policy boolean values are automatically preserved
 across policy reloads rather than being reset to the default
 values in the policy file.
+.PP
+It should be noted that it is not possible to switch between
+a non-MLS/MCS policy and a MLS/MCS policy or viceversa at
+runtime. To switch between such different types of policies
+change the SELinux configuration and reboot the kernel.

 .SH "OPTIONS"
 .TP

diff -pru refpolicy-2.20091117/README refpolicy-2.20091117-new/README
--- refpolicy-2.20091117/README 2009-07-14 14:24:46.000000000 +0200
+++ refpolicy-2.20091117-new/README     2010-01-26 16:39:13.272185609 +0100
@@ -267,3 +267,14 @@ refresh                    Attempts to reinsert all modul
 xml                    Build a policy.xml from the XML included with the
                        base policy headers and any XML in the modules in
                        the current directory.
+
+5) Switching between different types of policies (e.g. from non-MLS to MLS)
+
+In order to switch from a non-MLS/non-MCS policy to a MLS or MCS policy
+(and viceversa), make sure to change in build.conf not only the TYPE
+parameter between the two policies but also the NAME parameter (just name
+the new policy differently from the previous one). Also, after building the
+new policy, in order to load it for the first time (and eventually install
+custom modules), it might be necessary to reboot the kernel in permissive
+mode (after having changed the SELinux configuration file to select the
+new policy).

Regards,

Guido 

------_=_NextPart_001_c40e22be9a4bce4c70e45d3b688b6936--

------_=_NextPart_000_f4c1dc87a99c287bd25ac03c3750d5a0
Content-Type: application/octet-stream;
	name="document-switch-policy-type.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="document-switch-policy-type.patch"

ZGlmZiAtcHJ1IHBvbGljeWNvcmV1dGlscy0yLjAuNzcvbG9hZF9wb2xpY3kv
bG9hZF9wb2xpY3kuOCBwb2xpY3ljb3JldXRpbHMtMi4wLjc3LW5ldy9sb2Fk
X3BvbGljeS9sb2FkX3BvbGljeS44Ci0tLSBwb2xpY3ljb3JldXRpbHMtMi4w
Ljc3L2xvYWRfcG9saWN5L2xvYWRfcG9saWN5LjgJMjAwOS0xMS0xOSAyMzox
NjowMy4wMDAwMDAwMDAgKzAxMDAKKysrIHBvbGljeWNvcmV1dGlscy0yLjAu
NzctbmV3L2xvYWRfcG9saWN5L2xvYWRfcG9saWN5LjgJMjAxMC0wMS0yNiAx
NjoyNjoxMS4yMTAxNzgzMTcgKzAxMDAKQEAgLTEyLDYgKzEyLDExIEBAIGxv
YWRfcG9saWN5IGxvYWRzIHRoZSBpbnN0YWxsZWQgcG9saWN5IGYKIFRoZSBl
eGlzdGluZyBwb2xpY3kgYm9vbGVhbiB2YWx1ZXMgYXJlIGF1dG9tYXRpY2Fs
bHkgcHJlc2VydmVkCiBhY3Jvc3MgcG9saWN5IHJlbG9hZHMgcmF0aGVyIHRo
YW4gYmVpbmcgcmVzZXQgdG8gdGhlIGRlZmF1bHQKIHZhbHVlcyBpbiB0aGUg
cG9saWN5IGZpbGUuCisuUFAKK0l0IHNob3VsZCBiZSBub3RlZCB0aGF0IGl0
IGlzIG5vdCBwb3NzaWJsZSB0byBzd2l0Y2ggYmV0d2VlbgorYSBub24tTUxT
L01DUyBwb2xpY3kgYW5kIGEgTUxTL01DUyBwb2xpY3kgb3IgdmljZXZlcnNh
IGF0CitydW50aW1lLiBUbyBzd2l0Y2ggYmV0d2VlbiBzdWNoIGRpZmZlcmVu
dCB0eXBlcyBvZiBwb2xpY2llcworY2hhbmdlIHRoZSBTRUxpbnV4IGNvbmZp
Z3VyYXRpb24gYW5kIHJlYm9vdCB0aGUga2VybmVsLgogCiAuU0ggIk9QVElP
TlMiCiAuVFAK


------_=_NextPart_000_f4c1dc87a99c287bd25ac03c3750d5a0
Content-Type: application/octet-stream;
	name="document-switch-policy-type-in-reference.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="document-switch-policy-type-in-reference.patch"

ZGlmZiAtcHJ1IHJlZnBvbGljeS0yLjIwMDkxMTE3L1JFQURNRSByZWZwb2xp
Y3ktMi4yMDA5MTExNy1uZXcvUkVBRE1FCi0tLSByZWZwb2xpY3ktMi4yMDA5
MTExNy9SRUFETUUJMjAwOS0wNy0xNCAxNDoyNDo0Ni4wMDAwMDAwMDAgKzAy
MDAKKysrIHJlZnBvbGljeS0yLjIwMDkxMTE3LW5ldy9SRUFETUUJMjAxMC0w
MS0yNiAxNjozOToxMy4yNzIxODU2MDkgKzAxMDAKQEAgLTI2NywzICsyNjcs
MTQgQEAgcmVmcmVzaAkJCUF0dGVtcHRzIHRvIHJlaW5zZXJ0IGFsbCBtb2R1
bAogeG1sCQkJQnVpbGQgYSBwb2xpY3kueG1sIGZyb20gdGhlIFhNTCBpbmNs
dWRlZCB3aXRoIHRoZQogCQkJYmFzZSBwb2xpY3kgaGVhZGVycyBhbmQgYW55
IFhNTCBpbiB0aGUgbW9kdWxlcyBpbgogCQkJdGhlIGN1cnJlbnQgZGlyZWN0
b3J5LgorCis1KSBTd2l0Y2hpbmcgYmV0d2VlbiBkaWZmZXJlbnQgdHlwZXMg
b2YgcG9saWNpZXMgKGUuZy4gZnJvbSBub24tTUxTIHRvIE1MUykKKworSW4g
b3JkZXIgdG8gc3dpdGNoIGZyb20gYSBub24tTUxTL25vbi1NQ1MgcG9saWN5
IHRvIGEgTUxTIG9yIE1DUyBwb2xpY3kKKyhhbmQgdmljZXZlcnNhKSwgbWFr
ZSBzdXJlIHRvIGNoYW5nZSBpbiBidWlsZC5jb25mIG5vdCBvbmx5IHRoZSBU
WVBFCitwYXJhbWV0ZXIgYmV0d2VlbiB0aGUgdHdvIHBvbGljaWVzIGJ1dCBh
bHNvIHRoZSBOQU1FIHBhcmFtZXRlciAoanVzdCBuYW1lCit0aGUgbmV3IHBv
bGljeSBkaWZmZXJlbnRseSBmcm9tIHRoZSBwcmV2aW91cyBvbmUpLiBBbHNv
LCBhZnRlciBidWlsZGluZyB0aGUKK25ldyBwb2xpY3ksIGluIG9yZGVyIHRv
IGxvYWQgaXQgZm9yIHRoZSBmaXJzdCB0aW1lIChhbmQgZXZlbnR1YWxseSBp
bnN0YWxsCitjdXN0b20gbW9kdWxlcyksIGl0IG1pZ2h0IGJlIG5lY2Vzc2Fy
eSB0byByZWJvb3QgdGhlIGtlcm5lbCBpbiBwZXJtaXNzaXZlCittb2RlIChh
ZnRlciBoYXZpbmcgY2hhbmdlZCB0aGUgU0VMaW51eCBjb25maWd1cmF0aW9u
IGZpbGUgdG8gc2VsZWN0IHRoZQorbmV3IHBvbGljeSkuCg==


------_=_NextPart_000_f4c1dc87a99c287bd25ac03c3750d5a0--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
