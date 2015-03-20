Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2KH2O2v026705
 for <selinux@tycho.nsa.gov>; Fri, 20 Mar 2015 13:02:24 -0400
References: <1426625004-7152-1-git-send-email-dgdegra@tycho.nsa.gov>
Message-ID: <1426870746.22025.YahooMailNeo@web133202.mail.ir2.yahoo.com>
Date: Fri, 20 Mar 2015 16:59:06 +0000
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: [PATCH v3 0/3] Xen/FLASK policy updates for device contexts
To: Daniel De Graaf <dgdegra@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <1426625004-7152-1-git-send-email-dgdegra@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="-745693771-1522173373-1426870746=:22025"
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Reply-To: Richard Haines <richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

---745693771-1522173373-1426870746=:22025
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

I've been testing this and found a few problems:=0A=0A1) I could not read a=
 policy with sedispol (in the checkpolicy/test directory)=0A=A0=A0=A0 when =
the devicetreecon statement was included (checkpolicy built ok).=0A=A0=A0=
=A0 I've attached a patch that fixes this problem and included CIL Ref Guid=
e=0A=A0=A0 updates for the new features.=0A=0A2) When building policy with =
the CIL compiler secilc I get core dumps but=0A=A0=A0=A0 only if I include =
the devicetreecon statement. I think its related to not releasing=0A=A0=A0=
=A0 the devicetreepath "path" when sepol_policydb_free is called. I've been=
=0A=A0=A0=A0 trying to track it down and failed - any ideas !!!=0A=A0=A0 se=
dispol will read the generated CIL policy with the above fix applied.=0A=0A=
=0ARichard=0A=0A=0A=0A----- Original Message -----=0A> From: Daniel De Graa=
f <dgdegra@tycho.nsa.gov>=0A> To: selinux@tycho.nsa.gov=0A> Cc: xen-devel@l=
ists.xenproject.org=0A> Sent: Tuesday, 17 March 2015, 20:43=0A> Subject: [P=
ATCH v3 0/3] Xen/FLASK policy updates for device contexts=0A> =0A> In order=
 to support assigning security lables to ARM device tree nodes=0A> in Xen's=
 XSM policy, a new ocontext type is needed in the security=0A> policy.=0A> =
=0A> In addition to adding the new ocontext, the existing I/O memory range=
=0A> ocontext is expanded to 64 bits in order to support hardware with more=
=0A> than 44 bits of physical address space (32-bit count of 4K pages).=0A>=
 =0A> Changes from v2:=0A> - Clean up printf format strings for 32-bit buil=
ds=0A> =0A> Changes from v1:=0A> - Use policy version 30 instead of forking=
 the version numbers for Xen;=0A> =A0  this removes the need for v1's patch=
 3.=0A> - Report an error when attempting to use an I/O memory range that=
=0A> =A0  requires a 64-bit representation with an old policy output versio=
n=0A> =A0  that cannot support this=0A> - Fix a few incorrect references to=
 PCIDEVICECON=0A> - Reorder patches to clarify the allowed characterset of =
device tree=0A> =A0  paths=0A> =0A> [PATCH 1/3] checkpolicy: Expand allowed=
 character set in paths=0A> [PATCH 2/3] libsepol, checkpolicy: widen Xen IO=
MEM ocontext entries=0A> [PATCH 3/3] libsepol, checkpolicy: add device tree=
 ocontext nodes to=0A> _______________________________________________=0A> =
Selinux mailing list=0A> Selinux@tycho.nsa.gov=0A> To unsubscribe, send ema=
il to Selinux-leave@tycho.nsa.gov.=0A> To get help, send an email containin=
g "help" to =0A> Selinux-request@tycho.nsa.gov.=0A> 
---745693771-1522173373-1426870746=:22025
Content-Type: text/x-patch; name="0001-libsepol-Fix-reading-Xen-policy-with-devicetreecon.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-libsepol-Fix-reading-Xen-policy-with-devicetreecon.patch"

RnJvbSAxMmYxN2YwMDIyNzg0YTdiNTdhYTM1NWRjOGM0ZTVjOGQ0YjlhOTlk
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBSaWNoYXJkIEhhaW5l
cyA8cmljaGFyZF9jX2hhaW5lc0BidGludGVybmV0LmNvbT4KRGF0ZTogRnJp
LCAyMCBNYXIgMjAxNSAxNDoxODozMSArMDAwMApTdWJqZWN0OiBbUEFUQ0hd
IGxpYnNlcG9sOiBGaXggcmVhZGluZyBYZW4gcG9saWN5IHdpdGggZGV2aWNl
dHJlZWNvbgoKUG9saWN5IGZhaWxlZCB0byByZWFkIHdpdGggZGV2aWNldHJl
ZWNvbiBzdGF0ZW1lbnQuCgpBZGRlZCBkZXZpY2V0cmVlY29uIHN0YXRlbWVu
dCB0byBDSUwgcG9saWN5LmNpbCBhbmQgdXBkYXRlZCB0aGUgQ0lMClJlZmVy
ZW5jZSBHdWlkZS4KClNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgSGFpbmVzIDxy
aWNoYXJkX2NfaGFpbmVzQGJ0aW50ZXJuZXQuY29tPgotLS0KIGxpYnNlcG9s
L2NpbC9kb2NzL2NpbF94ZW5fc3RhdGVtZW50cy54bWwgfCA0NCArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKwogbGlic2Vwb2wvY2lsL3Rlc3Qv
cG9saWN5LmNpbCAgICAgICAgICAgICB8ICAxICsKIGxpYnNlcG9sL3NyYy9w
b2xpY3lkYi5jICAgICAgICAgICAgICAgICAgfCAgNCArKy0KIDMgZmlsZXMg
Y2hhbmdlZCwgNDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlm
ZiAtLWdpdCBhL2xpYnNlcG9sL2NpbC9kb2NzL2NpbF94ZW5fc3RhdGVtZW50
cy54bWwgYi9saWJzZXBvbC9jaWwvZG9jcy9jaWxfeGVuX3N0YXRlbWVudHMu
eG1sCmluZGV4IDEwMzViNjguLjQ1ODY1YzYgMTAwNjQ0Ci0tLSBhL2xpYnNl
cG9sL2NpbC9kb2NzL2NpbF94ZW5fc3RhdGVtZW50cy54bWwKKysrIGIvbGli
c2Vwb2wvY2lsL2RvY3MvY2lsX3hlbl9zdGF0ZW1lbnRzLnhtbApAQCAtMyw2
ICszLDcgQEAKIAogICAgPHNlY3QxPgogICAgICAgPHRpdGxlPlhlbiBTdGF0
ZW1lbnRzPC90aXRsZT4KKyAgICAgIDxwYXJhPlBvbGljeSB2ZXJzaW9uIDMw
IGludHJvZHVjZWQgdGhlIDxsaXRlcmFsPjxsaW5rIGxpbmtlbmQ9ImRldmlj
ZXRyZWVjb24iPmNvbnRleHQ8L2xpbms+PC9saXRlcmFsPiBzdGF0ZW1lbnQg
YW5kIGFsc28gZXhwYW5kZWQgdGhlIGV4aXN0aW5nIEkvTyBtZW1vcnkgcmFu
Z2UgdG8gNjQgYml0cyBpbiBvcmRlciB0byBzdXBwb3J0IGhhcmR3YXJlIHdp
dGggbW9yZSB0aGFuIDQ0IGJpdHMgb2YgcGh5c2ljYWwgYWRkcmVzcyBzcGFj
ZSAoMzItYml0IGNvdW50IG9mIDRLIHBhZ2VzKS48L3BhcmE+CiAgICAgICA8
cGFyYT5TZWUgdGhlIDx1bGluayB1cmw9Imh0dHA6Ly94ZW5iaXRzLnhlbi5v
cmcvZG9jcy80LjItdGVzdGluZy9taXNjL3hzbS1mbGFzay50eHQiPiJYU00v
RkxBU0sgQ29uZmlndXJhdGlvbiI8L3VsaW5rPiBkb2N1bWVudCBmb3IgZnVy
dGhlciBpbmZvcm1hdGlvbiAoPHVsaW5rIHVybD0iaHR0cDovL3hlbmJpdHMu
eGVuLm9yZy9kb2NzLzQuMi10ZXN0aW5nL21pc2MveHNtLWZsYXNrLnR4dCI+
PC91bGluaz4pPC9wYXJhPgogICAgICAgPHNlY3QyIGlkPSJpb21lbWNvbiI+
CiAgICAgICAgICA8dGl0bGU+aW9tZW1jb248L3RpdGxlPgpAQCAtMTgwLDQg
KzE4MSw0NyBAQAogICAgICAgICAgPHByb2dyYW1saXN0aW5nPjwhW0NEQVRB
WyhwaXJxY29uIDMzICh1bmNvbmZpbmVkLnVzZXIgb2JqZWN0X3IgdW5jb25m
aW5lZC5vYmplY3QgbG93X2xvdykpXV0+PC9wcm9ncmFtbGlzdGluZz4KICAg
ICAgIDwvc2VjdDI+CiAKKyAgICAgIDxzZWN0MiBpZD0iZGV2aWNldHJlZWNv
biI+CisgICAgICAgICA8dGl0bGU+ZGV2aWNldHJlZWNvbjwvdGl0bGU+Cisg
ICAgICAgICA8cGFyYT5MYWJlbCBkZXZpY2UgdHJlZSBub2Rlcy48L3BhcmE+
CisgICAgICAgICA8cGFyYT48ZW1waGFzaXMgcm9sZT0iYm9sZCI+U3RhdGVt
ZW50IGRlZmluaXRpb246PC9lbXBoYXNpcz48L3BhcmE+CisgICAgICAgICA8
cHJvZ3JhbWxpc3Rpbmc+PCFbQ0RBVEFbKGRldmljZXRyZWVjb24gcGF0aCBj
b250ZXh0X2lkKV1dPjwvcHJvZ3JhbWxpc3Rpbmc+CisgICAgICAgICA8cGFy
YT48ZW1waGFzaXMgcm9sZT0iYm9sZCI+V2hlcmU6PC9lbXBoYXNpcz48L3Bh
cmE+CisgICAgICAgICA8aW5mb3JtYWx0YWJsZSBmcmFtZT0iYWxsIj4KKyAg
ICAgICAgICAgIDx0Z3JvdXAgY29scz0iMiI+CisgICAgICAgICAgICA8Y29s
c3BlYyBjb2x3aWR0aD0iMiAqIi8+CisgICAgICAgICAgICA8Y29sc3BlYyBj
b2x3aWR0aD0iNiAqIi8+CisgICAgICAgICAgICAgICA8dGJvZHk+CisgICAg
ICAgICAgICAgICA8cm93PgorICAgICAgICAgICAgICAgICAgPGVudHJ5Pgor
ICAgICAgICAgICAgICAgICAgICAgPHBhcmE+PGxpdGVyYWw+ZGV2aWNldHJl
ZWNvbjwvbGl0ZXJhbD48L3BhcmE+CisgICAgICAgICAgICAgICAgICA8L2Vu
dHJ5PgorICAgICAgICAgICAgICAgICAgPGVudHJ5PgorICAgICAgICAgICAg
ICAgICAgICAgPHBhcmE+VGhlIDxsaXRlcmFsPmRldmljZXRyZWVjb248L2xp
dGVyYWw+IGtleXdvcmQuPC9wYXJhPgorICAgICAgICAgICAgICAgICAgPC9l
bnRyeT4KKyAgICAgICAgICAgICAgIDwvcm93PgorICAgICAgICAgICAgICAg
PHJvdz4KKyAgICAgICAgICAgICAgICAgIDxlbnRyeT4KKyAgICAgICAgICAg
ICAgICAgICAgIDxwYXJhPjxsaXRlcmFsPnBhdGg8L2xpdGVyYWw+PC9wYXJh
PgorICAgICAgICAgICAgICAgICAgPC9lbnRyeT4KKyAgICAgICAgICAgICAg
ICAgIDxlbnRyeT4KKyAgICAgICAgICAgICAgICAgICAgIDxwYXJhPlRoZSBk
ZXZpY2UgdHJlZSBwYXRoLiBJZiB0aGlzIGNvbnRhaW5zIHNwYWNlcyBlbmNs
b3NlIHdpdGhpbiA8bGl0ZXJhbD4iIjwvbGl0ZXJhbD4uPC9wYXJhPgorICAg
ICAgICAgICAgICAgICAgPC9lbnRyeT4KKyAgICAgICAgICAgICAgIDwvcm93
PgorICAgICAgICAgICAgICAgPHJvdz4KKyAgICAgICAgICAgICAgICAgIDxl
bnRyeT4KKyAgICAgICAgICAgICAgICAgICAgIDxwYXJhPjxsaXRlcmFsPmNv
bnRleHRfaWQ8L2xpdGVyYWw+PC9wYXJhPgorICAgICAgICAgICAgICAgICAg
PC9lbnRyeT4KKyAgICAgICAgICAgICAgICAgIDxlbnRyeT4KKyAgICAgICAg
ICAgICAgICAgICAgIDxwYXJhPkEgcHJldmlvdXNseSBkZWNsYXJlZCA8bGl0
ZXJhbD48bGluayBsaW5rZW5kPSJjb250ZXh0Ij5jb250ZXh0PC9saW5rPjwv
bGl0ZXJhbD4gaWRlbnRpZmllciBvciBhbiBhbm9ueW1vdXMgc2VjdXJpdHkg
Y29udGV4dCAoPGxpdGVyYWw+PGxpbmsgbGlua2VuZD0idXNlciI+dXNlcjwv
bGluaz4gPGxpbmsgbGlua2VuZD0icm9sZSI+cm9sZTwvbGluaz4gPGxpbmsg
bGlua2VuZD0idHlwZSI+dHlwZTwvbGluaz4gPGxpbmsgbGlua2VuZD0ibGV2
ZWxyYW5nZSI+bGV2ZWxyYW5nZTwvbGluaz48L2xpdGVyYWw+KSwgdGhlIHJh
bmdlIE1VU1QgYmUgZGVmaW5lZCB3aGV0aGVyIHRoZSBwb2xpY3kgaXMgTUxT
L01DUyBlbmFibGVkIG9yIG5vdC48L3BhcmE+CisgICAgICAgICAgICAgICAg
ICA8L2VudHJ5PgorICAgICAgICAgICAgICAgPC9yb3c+CisgICAgICAgICAg
ICA8L3Rib2R5PjwvdGdyb3VwPgorICAgICAgICAgPC9pbmZvcm1hbHRhYmxl
PgorCisgICAgICAgICA8cGFyYT48ZW1waGFzaXMgcm9sZT0iYm9sZCI+RXhh
bXBsZTo8L2VtcGhhc2lzPjwvcGFyYT4KKyAgICAgICAgIDxwYXJhPkFuIGFu
b255bW91cyBjb250ZXh0IGZvciB0aGUgc3BlY2lmaWVkIHBhdGg6PC9wYXJh
PgorICAgICAgICAgPHByb2dyYW1saXN0aW5nPjwhW0NEQVRBWyhkZXZpY2V0
cmVlY29uICIvdGhpcyBpcy9hL3BhdGgiICh1bmNvbmZpbmVkLnVzZXIgb2Jq
ZWN0X3IgdW5jb25maW5lZC5vYmplY3QgbG93X2xvdykpXV0+PC9wcm9ncmFt
bGlzdGluZz4KKyAgICAgIDwvc2VjdDI+CisKICAgIDwvc2VjdDE+CmRpZmYg
LS1naXQgYS9saWJzZXBvbC9jaWwvdGVzdC9wb2xpY3kuY2lsIGIvbGlic2Vw
b2wvY2lsL3Rlc3QvcG9saWN5LmNpbAppbmRleCA5Yzc2Y2FkLi4yNWM4NTQ1
IDEwMDY0NAotLS0gYS9saWJzZXBvbC9jaWwvdGVzdC9wb2xpY3kuY2lsCisr
KyBiL2xpYnNlcG9sL2NpbC90ZXN0L3BvbGljeS5jaWwKQEAgLTI1MCw2ICsy
NTAsNyBAQAogCShpb21lbWNvbiAoMCAyNTUpIHN5c3RlbV91X2Jpbl90X2wy
aCkKIAkoaW9wb3J0Y29uICgyMiAyMikgc3lzdGVtX3VfYmluX3RfbDJoKQog
CShwY2lkZXZpY2Vjb24gMzQ1IHN5c3RlbV91X2Jpbl90X2wyaCkKKwkoZGV2
aWNldHJlZWNvbiAiL3RoaXMgaXMvYS9wYXRoIiBzeXN0ZW1fdV9iaW5fdF9s
MmgpCiAKIAkoY29uc3RyYWluIChmaWxlcyAocmVhZCkpIChub3QgKG9yIChh
bmQgKGVxIHQxIGV4ZWNfdCkgKGVxIHQyIGJpbl90KSkgKGVxIHIxIHIyKSkp
KQogCShjb25zdHJhaW4gY2hhcl93IChub3QgKG9yIChhbmQgKGVxIHQxIGV4
ZWNfdCkgKGVxIHQyIGJpbl90KSkgKGVxIHIxIHIyKSkpKQpkaWZmIC0tZ2l0
IGEvbGlic2Vwb2wvc3JjL3BvbGljeWRiLmMgYi9saWJzZXBvbC9zcmMvcG9s
aWN5ZGIuYwppbmRleCBiNDViNjYyLi5jZWFjMzNkIDEwMDY0NAotLS0gYS9s
aWJzZXBvbC9zcmMvcG9saWN5ZGIuYworKysgYi9saWJzZXBvbC9zcmMvcG9s
aWN5ZGIuYwpAQCAtMjU1OSwxMSArMjU1OSwxMyBAQCBzdGF0aWMgaW50IG9j
b250ZXh0X3JlYWRfeGVuKHN0cnVjdCBwb2xpY3lkYl9jb21wYXRfaW5mbyAq
aW5mbywKIAkJCQlyYyA9IG5leHRfZW50cnkoYnVmLCBmcCwgc2l6ZW9mKHVp
bnQzMl90KSk7CiAJCQkJaWYgKHJjIDwgMCkKIAkJCQkJcmV0dXJuIC0xOwot
CQkJCWxlbiA9IGxlMzJfdG9fY3B1KGJ1ZlsxXSk7CisJCQkJbGVuID0gbGUz
Ml90b19jcHUoYnVmWzBdKTsKIAkJCQljLT51Lm5hbWUgPSBtYWxsb2MobGVu
ICsgMSk7CiAJCQkJaWYgKCFjLT51Lm5hbWUpCiAJCQkJCXJldHVybiAtMTsK
IAkJCQlyYyA9IG5leHRfZW50cnkoYy0+dS5uYW1lLCBmcCwgbGVuKTsKKwkJ
CQlpZiAocmMgPCAwKQorCQkJCQlyZXR1cm4gLTE7CiAJCQkJYy0+dS5uYW1l
W2xlbl0gPSAwOwogCQkJCWlmIChjb250ZXh0X3JlYWRfYW5kX3ZhbGlkYXRl
CiAJCQkJICAgICgmYy0+Y29udGV4dFswXSwgcCwgZnApKQotLSAKMi4xLjAK
Cg==

---745693771-1522173373-1426870746=:22025--
