Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBFIn0Rb021530
	for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2003 13:49:00 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBFImAjx023927
	for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2003 18:48:10 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
	by jazzswing.ncsc.mil  with ESMTP id hBFIm8SR023881
	for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2003 18:48:08 GMT
Subject: Re: [patch] add source line numbers to checkpolicy
From: Colin Walters <walters@verbum.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>,
   Howard Holm <hdholm@epoch.ncsc.mil>, Karl MacMillan <kmacmillan@tresys.com>
In-Reply-To: <1071500009.28044.60.camel@moss-spartans.epoch.ncsc.mil>
References: <1071478020.17990.8.camel@nexus.verbum.private>
	 <1071500009.28044.60.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-m4yyfR3+8w+78rTo3gPU"
Message-Id: <1071514006.20748.49.camel@nexus.verbum.private>
Mime-Version: 1.0
Date: Mon, 15 Dec 2003 13:46:46 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-m4yyfR3+8w+78rTo3gPU
Content-Type: multipart/mixed; boundary="=-Jc1uRd5AAwlYe249+TY5"


--=-Jc1uRd5AAwlYe249+TY5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-12-15 at 09:53, Stephen Smalley wrote:

> Thanks, this looks useful.  If I recall correctly, we originally split
> up the m4 processing because we were encountering a m4 failure due to
> the number of arguments.  I'm not sure what version of m4 that was, but
> the m4 on RHEL3 and FC1 appear to work fine with your patch and all
> existing .te files enabled, so perhaps that limitation was eliminated.

Ah, I see.
=20
> Given this change, I would think that we could also factor out
> tmp/program_unused_flags.te and $(ALL_MACROS) from ALLTEFILES and
> CONSTRAINT_CONTEXT_MACRO_FILES and only include them once in POLICYFILES
> prior to TE_RBAC_FILES.

Ok, right.  New patch attached.


--=-Jc1uRd5AAwlYe249+TY5
Content-Disposition: attachment; filename=policy-makefile2.patch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=policy-makefile2.patch; charset=UTF-8

LS0tIHBvbGljeS0xLjQvTWFrZWZpbGUJMjAwMy0xMS0yNiAxMTozMToyMC4wMDAwMDAwMDAgLTA1
MDANCisrKyBwb2xpY3ktMS40LmhhY2tlZC9NYWtlZmlsZQkyMDAzLTEyLTE1IDEzOjQzOjM1LjAw
MDAwMDAwMCAtMDUwMA0KQEAgLTI5LDEzICsyOSwyMCBAQA0KIFNSQ0lOU1RBTExESVIgPSAkKElO
U1RBTExESVIpL3NyYw0KIFBPTElDWUNPTkYgPSAkKFNSQ0lOU1RBTExESVIpL3BvbGljeS5jb25m
DQogDQorQUxMX1BST0dSQU1fTUFDUk9TIDo9ICQod2lsZGNhcmQgbWFjcm9zL3Byb2dyYW0vKi50
ZSkNCitBTExfTUFDUk9TIDo9ICQoQUxMX1BST0dSQU1fTUFDUk9TKSAkKHdpbGRjYXJkIG1hY3Jv
cy8qLnRlKQ0KK0FMTF9UWVBFUyA6PSAkKHdpbGRjYXJkIHR5cGVzLyoudGUpDQorQUxMX0RPTUFJ
TlMgOj0gJCh3aWxkY2FyZCBkb21haW5zLyoudGUgZG9tYWlucy9taXNjLyoudGUgZG9tYWlucy9w
cm9ncmFtLyoudGUpDQorQUxMVEVGSUxFUyA6PSBhdHRyaWIudGUgdG1wL3Byb2dyYW1fdXNlZF9m
bGFncy50ZSAkKEFMTF9NQUNST1MpICQoQUxMX1RZUEVTKSAkKEFMTF9ET01BSU5TKSBhc3NlcnQu
dGUgDQorVEVfUkJBQ19GSUxFUyA6PSAkKEFMTFRFRklMRVMpIHJiYWMNCisNCiBQT0xJQ1lGSUxF
UyA9ICQoYWRkcHJlZml4ICQoRkxBU0tESVIpLHNlY3VyaXR5X2NsYXNzZXMgaW5pdGlhbF9zaWRz
IGFjY2Vzc192ZWN0b3JzKQ0KIGlmZXEgKCQoTUxTKSx5KQ0KIFBPTElDWUZJTEVTICs9IG1scw0K
IGVuZGlmDQotUE9MSUNZRklMRVMgKz0gdG1wL3RlLXJiYWMubTQNCitQT0xJQ1lGSUxFUyArPSAk
KFRFX1JCQUNfRklMRVMpDQogUE9MSUNZRklMRVMgKz0gdXNlcnMgDQotUE9MSUNZRklMRVMgKz0g
dG1wL2NvbnN0cmFpbnRzLWNvbnRleHRzLm00DQorUE9MSUNZRklMRVMgKz0gY29uc3RyYWludHMg
aW5pdGlhbF9zaWRfY29udGV4dHMgZnNfdXNlIGdlbmZzX2NvbnRleHRzIG5ldF9jb250ZXh0cw0K
IA0KIFVOVVNFRF9URV9GSUxFUyA6PSAkKHdpbGRjYXJkIGRvbWFpbnMvcHJvZ3JhbS91bnVzZWQv
Ki50ZSkNCiANCkBAIC04Niw3ICs5Myw4IEBADQogDQogcG9saWN5LmNvbmY6ICQoUE9MSUNZRklM
RVMpIA0KIAlta2RpciAtcCB0bXANCi0JY2F0ICReID4gJEANCisJbTQgJChNNFBBUkFNKSAtSW1h
Y3JvcyAtcyAkXiA+ICRALnRtcA0KKwltdiAkQC50bXAgJEANCiANCiBpbnN0YWxsLXNyYzogDQog
CXJtIC1yZiAkKFNSQ0lOU1RBTExESVIpL3BvbGljeS5vbGQNCkBAIC05NCwzNSArMTAyLDExIEBA
DQogCW1rZGlyIC1wICQoU1JDSU5TVEFMTERJUikvcG9saWN5DQogCWNwIC1SIC4gJChTUkNJTlNU
QUxMRElSKS9wb2xpY3kNCiANCi1BTExURUZJTEVTIDo9IGF0dHJpYi50ZSB0bXAvcHJvZ3JhbV91
c2VkX2ZsYWdzLnRlIHRtcC9hbGxfbWFjcm9zLnRlIHRtcC9hbGxfdHlwZXMudGUgdG1wL2FsbF9k
b21haW5zLnRlIGFzc2VydC50ZSANCi1URV9SQkFDX01BQ1JPX0ZJTEVTIDo9IHRtcC9hbGwudGUg
cmJhYw0KLUNPTlNUUkFJTlRfQ09OVEVYVF9NQUNST19GSUxFUyA6PSB0bXAvcHJvZ3JhbV91c2Vk
X2ZsYWdzLnRlIHRtcC9hbGxfbWFjcm9zLnRlIGNvbnN0cmFpbnRzIGluaXRpYWxfc2lkX2NvbnRl
eHRzIGZzX3VzZSBnZW5mc19jb250ZXh0cyBuZXRfY29udGV4dHMNCi0NCi10bXAvdGUtcmJhYy5t
NDogJChURV9SQkFDX01BQ1JPX0ZJTEVTKQ0KLQltNCAkKE00UEFSQU0pIC1JbWFjcm9zIC1zICRe
ID4gJEANCi0NCi10bXAvY29uc3RyYWludHMtY29udGV4dHMubTQ6ICQoQ09OU1RSQUlOVF9DT05U
RVhUX01BQ1JPX0ZJTEVTKQ0KLQltNCAkKE00UEFSQU0pIC1JbWFjcm9zIC1zICReID4gJEANCi0N
Ci10bXAvYWxsLnRlOiAkKEFMTFRFRklMRVMpDQotCWNhdCAkXiA+ICRADQotDQogdG1wL3Byb2dy
YW1fdXNlZF9mbGFncy50ZTogJCh3aWxkY2FyZCBkb21haW5zL3Byb2dyYW0vKi50ZSkgZG9tYWlu
cy9wcm9ncmFtDQogCW1rZGlyIC1wIHRtcA0KLQkoIGNkIGRvbWFpbnMvcHJvZ3JhbS8gOyBmb3Ig
biBpbiAqLnRlIDsgZG8gZWNobyAiZGVmaW5lKFxgJCRuJykiOyBkb25lICkgPiAkQA0KLQkoIGNk
IGRvbWFpbnMvbWlzYy8gOyBmb3IgbiBpbiAqLnRlIDsgZG8gZWNobyAiZGVmaW5lKFxgJCRuJyki
OyBkb25lICkgPj4gJEANCi0NCi10bXAvYWxsX21hY3Jvcy50ZTogIG1hY3JvcyAkKHdpbGRjYXJk
IG1hY3Jvcy8qLnRlKSB0bXAvYWxsX3Byb2dyYW1fbWFjcm9zLnRlDQotCWNhdCAkKHdpbGRjYXJk
IG1hY3Jvcy8qLnRlKSB0bXAvYWxsX3Byb2dyYW1fbWFjcm9zLnRlID4gJEANCi0NCi10bXAvYWxs
X3Byb2dyYW1fbWFjcm9zLnRlOiBtYWNyb3MvcHJvZ3JhbSAkKHdpbGRjYXJkIG1hY3Jvcy9wcm9n
cmFtLyoudGUpDQotCWNhdCAkKHdpbGRjYXJkIG1hY3Jvcy9wcm9ncmFtLyoudGUpID4gJEANCi0N
Ci10bXAvYWxsX3R5cGVzLnRlOiAkKHdpbGRjYXJkIHR5cGVzLyoudGUpIHR5cGVzDQotCWNhdCB0
eXBlcy8qLnRlID4gJEANCi0NCi10bXAvYWxsX2RvbWFpbnMudGU6ICQod2lsZGNhcmQgZG9tYWlu
cy8qLnRlIGRvbWFpbnMvbWlzYy8qLnRlIGRvbWFpbnMvcHJvZ3JhbS8qLnRlKSBkb21haW5zIGRv
bWFpbnMvbWlzYyBkb21haW5zL3Byb2dyYW0NCi0JY2F0IGRvbWFpbnMvKi50ZSBkb21haW5zL21p
c2MvKi50ZSBkb21haW5zL3Byb2dyYW0vKi50ZSA+ICRADQorCSggY2QgZG9tYWlucy9wcm9ncmFt
LyA7IGZvciBuIGluICoudGUgOyBkbyBlY2hvICJkZWZpbmUoXGAkJG4nKSI7IGRvbmUgKSA+ICRA
LnRtcA0KKwkoIGNkIGRvbWFpbnMvbWlzYy8gOyBmb3IgbiBpbiAqLnRlIDsgZG8gZWNobyAiZGVm
aW5lKFxgJCRuJykiOyBkb25lICkgPj4gJEAudG1wDQorCW12ICRALnRtcCAkQA0KIA0KIHJlbGFi
ZWw6ICAkKEZDKSAkKFNFVEZJTEVTKQ0KIAkkKFNFVEZJTEVTKSAkKEZDKSBgbW91bnQgfCBhd2sg
Jy9leHRbMjNdL3twcmludCAkJDN9J2ANCkBAIC0xMzQsNyArMTE4LDggQEANCiAJbWtkaXIgLXAg
ZmlsZV9jb250ZXh0cy9taXNjDQogDQogJChGQyk6ICQoRkNGSUxFUykgZG9tYWlucy9wcm9ncmFt
IGRvbWFpbnMvbWlzYyBmaWxlX2NvbnRleHRzL3Byb2dyYW0gZmlsZV9jb250ZXh0cy9taXNjDQot
CWNhdCAkKEZDRklMRVMpID4gJEANCisJY2F0ICQoRkNGSUxFUykgPiAkQC50bXANCisJbXYgJEAu
dG1wICRADQogDQogY2xlYW46DQogCXJtIC1mIHBvbGljeS5jb25mDQo=

--=-Jc1uRd5AAwlYe249+TY5--

--=-m4yyfR3+8w+78rTo3gPU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/3gGWOIkJWWp2WGURAtC4AJ9LeM3owA6zc1gKgpGWcjYVrq1gVACfeDV9
QNqLTZ9sWvz7eQiqsWk5iUQ=
=VUjW
-----END PGP SIGNATURE-----

--=-m4yyfR3+8w+78rTo3gPU--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
