Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA14097
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 09:21:54 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA23967
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 13:20:44 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id NAA23962
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 13:20:42 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 795FD92466
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 23:21:49 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 1217F8FDA
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 15:21:42 +0200 (CEST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: another small patch
Date: Wed, 28 Aug 2002 15:21:41 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_5G2KBQQYIJL8MWP2DJXK"
Message-Id: <20020828132142.1217F8FDA@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_5G2KBQQYIJL8MWP2DJXK
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

This patch gives sysadm_t the privhome attribute (allowing it to create files 
under user home directories with the correct type), and removes my mistaken 
first attempt at doing this.

Also it allows xdm_t to read the default_context_t (otherwise XDM logins are 
impossible).  It removes access to shadow_t because the "auth" attribute 
grants that anyway.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--------------Boundary-00=_5G2KBQQYIJL8MWP2DJXK
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="diff"

ZGlmZiAtcnV3IC90bXAvcG9saWN5L2RvbWFpbnMvYWRtaW4udGUgLi9kb21haW5zL2FkbWluLnRl
Ci0tLSAvdG1wL3BvbGljeS9kb21haW5zL2FkbWluLnRlCTIwMDItMDYtMjggMjA6MTQ6MTAuMDAw
MDAwMDAwICswMjAwCisrKyAuL2RvbWFpbnMvYWRtaW4udGUJMjAwMi0wOC0yNyAyMzo1OTozNi4w
MDAwMDAwMDAgKzAyMDAKQEAgLTMsNyArMyw3IEBACiAjCiAKICMgc3lzYWRtX3QgaXMgdGhlIHN5
c3RlbSBhZG1pbmlzdHJhdG9yIGRvbWFpbi4KLXR5cGUgc3lzYWRtX3QsIGRvbWFpbiwgcHJpdmxv
ZywgcHJpdm93bmVyLCBhZG1pbiwgdXNlcmRvbWFpbjsKK3R5cGUgc3lzYWRtX3QsIGRvbWFpbiwg
cHJpdmxvZywgcHJpdm93bmVyLCBhZG1pbiwgdXNlcmRvbWFpbiwgcHJpdmhvbWU7CiAKICMgc3lz
dGVtX3IgaXMgYXV0aG9yaXplZCBmb3Igc3lzYWRtX3QgZm9yIHNpbmdsZS11c2VyIG1vZGUuCiBy
b2xlIHN5c3RlbV9yIHR5cGVzIHN5c2FkbV90OyAKZGlmZiAtcnV3IC90bXAvcG9saWN5L2RvbWFp
bnMvcHJvZ3JhbS94ZG0udGUgLi9kb21haW5zL3Byb2dyYW0veGRtLnRlCi0tLSAvdG1wL3BvbGlj
eS9kb21haW5zL3Byb2dyYW0veGRtLnRlCTIwMDItMDgtMjEgMjA6MjI6NDYuMDAwMDAwMDAwICsw
MjAwCisrKyAuL2RvbWFpbnMvcHJvZ3JhbS94ZG0udGUJMjAwMi0wOC0yOCAxMDowMjoyNy4wMDAw
MDAwMDAgKzAyMDAKQEAgLTI0LDcgKzI0LDcgQEAKICMgUnVuIHRoZSBYIERpc3BsYXkgTWFuYWdl
ciBpbiBpdHMgb3duIGRvbWFpbi4KIGRvbWFpbl9hdXRvX3RyYW5zKHsgaW5pdF90IGluaXRyY190
IH0sIHhkbV9leGVjX3QsIHhkbV90KQogCi1hbGxvdyB4ZG1fdCBzaGFkb3dfdDpmaWxlIHsgcmVh
ZCBnZXRhdHRyIH07CithbGxvdyB4ZG1fdCBkZWZhdWx0X2NvbnRleHRfdDpmaWxlIHsgcmVhZCBn
ZXRhdHRyIH07CiAKIGFsbG93IHhkbV90IGluaXRfdDpmZCB1c2U7CiAKZGlmZiAtcnV3IC90bXAv
cG9saWN5L21hY3Jvcy91c2VyX21hY3Jvcy50ZSAuL21hY3Jvcy91c2VyX21hY3Jvcy50ZQotLS0g
L3RtcC9wb2xpY3kvbWFjcm9zL3VzZXJfbWFjcm9zLnRlCTIwMDItMDgtMjggMTQ6MzQ6MjEuMDAw
MDAwMDAwICswMjAwCisrKyAuL21hY3Jvcy91c2VyX21hY3Jvcy50ZQkyMDAyLTA4LTI3IDIzOjU5
OjMzLjAwMDAwMDAwMCArMDIwMApAQCAtMjQwLDExICsyNDAsNyBAQAogZGVmaW5lKGBmdWxsX3Vz
ZXJfcm9sZScsIGAKIAogIyB1c2VyX3QvJDFfdCBpcyBhbiB1bnByaXZpbGVnZWQgdXNlcnMgZG9t
YWluLgotaWZlbHNlKCQxLCBzeXNhZG0sIGAKLXR5cGUgJDFfdCwgZG9tYWluLCB1c2VyZG9tYWlu
LCBwcml2aG9tZTsKLScsIGAKIHR5cGUgJDFfdCwgZG9tYWluLCB1c2VyZG9tYWluLCB1bnByaXZf
dXNlcmRvbWFpbjsKLScpCiAKICMgJDFfciBpcyBhdXRob3JpemVkIGZvciAkMV90IGZvciB0aGUg
aW5pdGlhbCBsb2dpbiBkb21haW4uCiByb2xlICQxX3IgdHlwZXMgJDFfdDsK

--------------Boundary-00=_5G2KBQQYIJL8MWP2DJXK--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
