Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA06982
	for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 11:09:26 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA00649
	for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 16:08:23 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id QAA00645 for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 16:08:21 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 569A292443
	for <selinux@tycho.nsa.gov>; Sat, 23 Mar 2002 03:09:21 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 960521F36A
	for <selinux@tycho.nsa.gov>; Fri, 22 Mar 2002 17:09:13 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: gpg te
Date: Fri, 22 Mar 2002 17:09:13 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_D7UDH0LYJV7BMQHHFJL3"
Message-Id: <20020322160913.960521F36A@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_D7UDH0LYJV7BMQHHFJL3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

Here's the file_contexts data:
/root/.*/\.gnupg(|/.*)          system_u:object_r:sysadm_gpg_secret_t
/home/.*/\.gnupg(|/.*)          system_u:object_r:user_gpg_secret_t
/usr/bin/gpg                    system_u:object_r:gpg_exec_t

In user_macros.te I added the following at the start:
include(program/gpg_macros.te)

Then I added the following after the netscape_domain line:
gpg_domain($1)

In admin_macros.te I added the following:
# Allow our gpg domain to write to .gnupg
allow $1_gpg_t user_gpg_secret_t:dir create_dir_perms;
allow $1_gpg_t user_gpg_secret_t:file create_file_perms;

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--------------Boundary-00=_D7UDH0LYJV7BMQHHFJL3
Content-Type: text/plain;
  charset="us-ascii";
  name="gpg_macros.te"
Content-Transfer-Encoding: base64
Content-Description: gpg_macros.te
Content-Disposition: attachment; filename="gpg_macros.te"

IwojIE1hY3JvcyBmb3IgZ3BnIGFuZCBwZ3AKIwojIEF1dGhvcjogIFJ1c3NlbGwgQ29rZXIgPHJ1
c3NlbGxAY29rZXIuY29tLmF1PgojCiMgYmFzZWQgb24gdGhlIHdvcmsgb2Y6CiMgU3RlcGhlbiBT
bWFsbGV5IDxzZHNAdGlzbGFicy5jb20+IChOQUkgTGFicykgYW5kIFRpbW90aHkgRnJhc2VyCiMK
CiMKIyBncGdfZG9tYWluKGRvbWFpbl9wcmVmaXgpCiMKIyBEZWZpbmUgYSBkZXJpdmVkIGRvbWFp
biBmb3IgdGhlIGdwZy9wZ3AgcHJvZ3JhbSB3aGVuIGV4ZWN1dGVkIGJ5CiMgYSB1c2VyIGRvbWFp
bi4KIwojIFRoZSB0eXBlIGRlY2xhcmF0aW9uIGZvciB0aGUgZXhlY3V0YWJsZSB0eXBlIGZvciB0
aGlzIHByb2dyYW0gaXMKIyBwcm92aWRlZCBzZXBhcmF0ZWx5IGluIGRvbWFpbnMvcHJvZ3JhbS9n
cGcudGUuCiMKZGVmaW5lKGBncGdfZG9tYWluJywgYAojIERlcml2ZWQgZG9tYWluIGJhc2VkIG9u
IHRoZSBjYWxsaW5nIHVzZXIgZG9tYWluIGFuZCB0aGUgcHJvZ3JhbS4KdHlwZSAkMV9ncGdfdCwg
ZG9tYWluLCBwcml2bG9nOwojIFRyYW5zaXRpb24gZnJvbSB0aGUgdXNlciBkb21haW4gdG8gdGhl
IGRlcml2ZWQgZG9tYWluLgpkb21haW5fYXV0b190cmFucygkMV90LCBncGdfZXhlY190LCAkMV9n
cGdfdCkKCiMgVGhlIHVzZXIgcm9sZSBpcyBhdXRob3JpemVkIGZvciB0aGlzIGRvbWFpbi4Kcm9s
ZSAkMV9yIHR5cGVzICQxX2dwZ190OwoKdHlwZSAkMV9ncGdfc2VjcmV0X3QsIGZpbGVfdHlwZSwg
c3lzYWRtZmlsZTsKCiMgSW5oZXJpdCBhbmQgdXNlIGRlc2NyaXB0b3JzCmFsbG93ICQxX2dwZ190
ICQxX3Q6ZmQgaW5oZXJpdF9mZF9wZXJtczsKYWxsb3cgJDFfZ3BnX3QgJDFfdDpwcm9jZXNzIHNp
Z2NobGQ7CmFsbG93ICQxX2dwZ190IHNlbGY6cHJvY2VzcyBzaWduYWw7Cgp1c2VzX3NobGliKCQx
X2dwZ190KQoKIyB1c2UgJDFfZ3BnX3NlY3JldF90IGZvciBmaWxlcyBpdCBjcmVhdGVzCiMgTkIg
d2UgYXJlIGRvaW5nIHRoZSB0eXBlIHRyYW5zaXRpb24gZm9yIGRpcmVjdG9yeSBjcmVhdGlvbiBv
bmx5IQojIHNvIH4vLmdudXBnIHdpbGwgYmUgb2YgJDFfZ3BnX3NlY3JldF90LCB0aGVuIGZpbGVz
IGNyZWF0ZWQgdW5kZXIgaXQgc3VjaCBhcwojIHNlY3JpbmcuZ3BnIHdpbGwgYmUgb2YgJDFfZ3Bn
X3NlY3JldF90IHRvby4gIEJ1dCB3aGVuIHlvdSB1c2UgZ3BnIHRvIGRlY3J5cHQKIyBhIGZpbGUg
YW5kIHdyaXRlIG91dHB1dCB0byB5b3VyIGhvbWUgZGlyZWN0b3J5IGl0IHdpbGwgdXNlIHVzZXJf
aG9tZV90LgpmaWxlX3R5cGVfdHJhbnMoJDFfZ3BnX3QsICQxX2hvbWVfdCwgJDFfZ3BnX3NlY3Jl
dF90KQp0eXBlX3RyYW5zaXRpb24gJDFfZ3BnX3QgJDFfaG9tZV90OmRpciAkMV9ncGdfc2VjcmV0
X3Q7CgphbGxvdyAkMV9ncGdfdCAkMV90OmZpbGUgY3JlYXRlX2ZpbGVfcGVybXM7CgphbGxvdyAk
MV9ncGdfdCBzZWxmOmNhcGFiaWxpdHkgeyBpcGNfbG9jayBzZXR1aWQgfTsKYWxsb3cgJDFfZ3Bn
X3QgZGV2dHR5X3Q6Y2hyX2ZpbGUgcndfZmlsZV9wZXJtczsKCiNjYW5fbmV0d29yaygkMV9ncGdf
dCkKCmFsbG93ICQxX2dwZ190IHsgZXRjX3QgdXNyX3QgfTpkaXIgcl9kaXJfcGVybXM7CmFsbG93
ICQxX2dwZ190IGZzX3Q6ZmlsZXN5c3RlbSBnZXRhdHRyOwphbGxvdyAkMV9ncGdfdCB1c3JfdDpm
aWxlIHJfZmlsZV9wZXJtczsKYWxsb3cgJDFfZ3BnX3QgeyB1c2VyX2hvbWVfdCBzeXNhZG1faG9t
ZV90IH06ZGlyIGNyZWF0ZV9kaXJfcGVybXM7CmFsbG93ICQxX2dwZ190IHsgdXNlcl9ob21lX3Qg
c3lzYWRtX2hvbWVfdCB9OmZpbGUgY3JlYXRlX2ZpbGVfcGVybXM7CmFsbG93ICQxX3QgJDFfZ3Bn
X3NlY3JldF90OmRpciByd19kaXJfcGVybXM7CicpCg==

--------------Boundary-00=_D7UDH0LYJV7BMQHHFJL3
Content-Type: text/plain;
  charset="us-ascii";
  name="gpg.te"
Content-Transfer-Encoding: base64
Content-Description: gpg.te
Content-Disposition: attachment; filename="gpg.te"

IwojIEF1dGhvcnM6ICBSdXNzZWxsIENva2VyIDxydXNzZWxsQGNva2VyLmNvbS5hdT4KIwoKIyBU
eXBlIGZvciBncGcgb3IgcGdwIGV4ZWN1dGFibGVzLgp0eXBlIGdwZ19leGVjX3QsIGZpbGVfdHlw
ZSwgc3lzYWRtZmlsZSwgZXhlY190eXBlOwoKIyBFdmVyeXRoaW5nIGVsc2UgaXMgaW4gdGhlIGdw
Z19kb21haW4gbWFjcm8gaW4KIyBtYWNyb3MvcHJvZ3JhbS9ncGdfbWFjcm9zLnRlLgo=

--------------Boundary-00=_D7UDH0LYJV7BMQHHFJL3--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
