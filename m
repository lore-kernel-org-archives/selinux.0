Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA29906
	for <selinux@tycho.nsa.gov>; Fri, 15 Mar 2002 12:04:06 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA00542
	for <selinux@tycho.nsa.gov>; Fri, 15 Mar 2002 17:02:49 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id RAA00538
	for <selinux@tycho.nsa.gov>; Fri, 15 Mar 2002 17:02:48 GMT
Date: Fri, 15 Mar 2002 12:03:14 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Updated Release
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A10152430C@csoc-mail-box.csoconline.com>
Message-ID: <Pine.GSO.4.33.0203151200030.15480-200000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-351212254-1016211794=:15480"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-351212254-1016211794=:15480
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Fri, 15 Mar 2002, Westerman, Mark wrote:

> There is a problem with the build in the updated release.
>
> I was to quick and did not figure out the what was causing the
> problem. When doing a make quickinstall (on a clean install of
> RedHat) some install program create install itself as
> /usr/local/selinux/sbin. Since sbin was a program and not
> a directory the make failed

Thanks for the bug report.  The selinux/selopt Makefiles assume that the
/usr/local/selinux hierarchy has been created, and end up installing
binaries as /usr/local/selinux/sbin if that directory has not already been
created.  That was a reasonable assumption for James, because selopt was
originally intended to be installed after an initial install of SELinux.
When we merged it, we didn't fix this.  Sorry.  The attached patch moves
the selopt install after the utils install, at which point this assumption
holds.  Longer term, we should just fix the selopt Makefiles to create
the target directories if necessary.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



---559023410-351212254-1016211794=:15480
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="install.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0203151203140.15480@raven>
Content-Description: 
Content-Disposition: attachment; filename="install.patch"

SW5kZXg6IE1ha2VmaWxlDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpSQ1Mg
ZmlsZTogL2N2cy9sc20vc2VsaW51eC9NYWtlZmlsZSx2DQpyZXRyaWV2aW5n
IHJldmlzaW9uIDEuOA0KcmV0cmlldmluZyByZXZpc2lvbiAxLjkNCmRpZmYg
LXUgLXIxLjggLXIxLjkNCi0tLSBNYWtlZmlsZQkyMDAyLzAzLzE1IDE1OjM4
OjI1CTEuOA0KKysrIE1ha2VmaWxlCTIwMDIvMDMvMTUgMTY6MjY6NDcJMS45
DQpAQCAtMjIsMTAgKzIyLDEwIEBADQogCWNkIHBvbGljeSAmJiBtYWtlIGlu
c3RhbGwNCiAJQGVjaG8gIkJ1aWxkaW5nIGFuZCBpbnN0YWxsaW5nIGxpYnNl
Y3VyZS4iDQogCWNkIGxpYnNlY3VyZSAmJiBtYWtlIGluc3RhbGwNCi0JQGVj
aG8gIkJ1aWxkaW5nIGFuZCBpbnN0YWxsaW5nIHRoZSBTRUxPUFQgdXRpbHMu
Ig0KLQljZCBzZWxvcHQgJiYgbWFrZSBMU01WRVI9JChMU01WRVIpICYmIG1h
a2UgaW5zdGFsbA0KIAlAZWNobyAiQnVpbGRpbmcgYW5kIGluc3RhbGxpbmcg
dGhlIG1vZGlmaWVkIGRhZW1vbnMgYW5kIHRoZSBuZXcgb3IgbW9kaWZpZWQg
dXRpbGl0aWVzLiINCiAJY2QgdXRpbHMgJiYgbWFrZSBpbnN0YWxsDQorCUBl
Y2hvICJCdWlsZGluZyBhbmQgaW5zdGFsbGluZyB0aGUgU0VMT1BUIHV0aWxz
LiINCisJY2Qgc2Vsb3B0ICYmIG1ha2UgTFNNVkVSPSQoTFNNVkVSKSAmJiBt
YWtlIGluc3RhbGwNCiAJQGVjaG8gIkluc3RhbGxpbmcgdGhlIGFwcGxpY2F0
aW9uIGNvbnRleHQgY29uZmlndXJhdGlvbiBmaWxlcy4iDQogCWlmIFsgISAt
ZiAvZXRjL3NlY3VyaXR5L2RlZmF1bHRfY29udGV4dCBdOyB0aGVuIGluc3Rh
bGwgLW0gNjQ0IHV0aWxzL2FwcGNvbmZpZy9kZWZhdWx0X2NvbnRleHQgL2V0
Yy9zZWN1cml0eTsgZmkNCiAJaWYgWyAhIC1mIC9ldGMvc2VjdXJpdHkvZGVm
YXVsdF90eXBlIF07IHRoZW4gaW5zdGFsbCAtbSA2NDQgdXRpbHMvYXBwY29u
ZmlnL2RlZmF1bHRfdHlwZSAvZXRjL3NlY3VyaXR5OyBmaQ0KSW5kZXg6IFJF
QURNRQ0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KUkNTIGZpbGU6IC9jdnMv
bHNtL3NlbGludXgvUkVBRE1FLHYNCnJldHJpZXZpbmcgcmV2aXNpb24gMS42
MA0KcmV0cmlldmluZyByZXZpc2lvbiAxLjYxDQpkaWZmIC11IC1yMS42MCAt
cjEuNjENCi0tLSBSRUFETUUJMjAwMi8wMy8xNSAxNTozODoyNQkxLjYwDQor
KysgUkVBRE1FCTIwMDIvMDMvMTUgMTY6MjY6NDcJMS42MQ0KQEAgLTE4MCwy
MSArMTgwLDIxIEBADQogICAgbWFrZSBpbnN0YWxsDQogICAgY2QgLi4NCiAN
Ci03KSBJZiB5b3Ugd2FudCB0byBleHBlcmltZW50IHdpdGggdGhlIGxhYmVs
ZWQgbmV0d29ya2luZyBzdXBwb3J0LCB0aGVuDQotICAgYnVpbGQgYW5kIGlu
c3RhbGwgdGhlIFNlbG9wdCB1dGlsaXRpZXM6DQotICAgY2Qgc2Vsb3B0DQot
ICAgbWFrZSAob3IgbWFrZSBMU01WRVI9LTIuNSkNCi0gICBzdSAoaWYgbm90
IGFscmVhZHkgcm9vdCkNCi0gICBtYWtlIGluc3RhbGwNCi0gICBjZCAuLg0K
LQ0KLTgpIEJ1aWxkIGFuZCBpbnN0YWxsIHRoZSBtb2RpZmllZCBhcHBsaWNh
dGlvbnMuDQorNykgQnVpbGQgYW5kIGluc3RhbGwgdGhlIG1vZGlmaWVkIGFw
cGxpY2F0aW9ucy4NCiAgICBJZiB5b3UgYXJlIHJ1bm5pbmcgUkg3LjEsIHRo
ZW4gZmlyc3QgZWRpdCB0aGUgdXRpbHMvTWFrZWZpbGUsDQogICAgY29tbWVu
dGluZyBvdXQgdGhlIExPR1JPVEFURV9WRVIgZGVmaW5pdGlvbiBmb3IgUkg3
LjIgYW5kIHVuY29tbWVudGluZyANCiAgICB0aGUgY29ycmVzcG9uZGluZyBk
ZWZpbml0aW9uIGZvciBSSDcuMS4NCiANCiAgICBjZCB1dGlscw0KICAgIG1h
a2UNCisgICBzdSAoaWYgbm90IGFscmVhZHkgcm9vdCkNCisgICBtYWtlIGlu
c3RhbGwNCisgICBjZCAuLg0KKw0KKzgpIElmIHlvdSB3YW50IHRvIGV4cGVy
aW1lbnQgd2l0aCB0aGUgbGFiZWxlZCBuZXR3b3JraW5nIHN1cHBvcnQsIHRo
ZW4NCisgICBidWlsZCBhbmQgaW5zdGFsbCB0aGUgU2Vsb3B0IHV0aWxpdGll
czoNCisgICBjZCBzZWxvcHQNCisgICBtYWtlIChvciBtYWtlIExTTVZFUj0t
Mi41KQ0KICAgIHN1IChpZiBub3QgYWxyZWFkeSByb290KQ0KICAgIG1ha2Ug
aW5zdGFsbA0KICAgIGNkIC4uDQo=
---559023410-351212254-1016211794=:15480--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
