Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA06491
	for <selinux@tycho.nsa.gov>; Wed, 26 Feb 2003 14:57:31 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA13214
	for <selinux@tycho.nsa.gov>; Wed, 26 Feb 2003 19:54:17 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id TAA13209
	for <selinux@tycho.nsa.gov>; Wed, 26 Feb 2003 19:54:15 GMT
Date: Wed, 26 Feb 2003 13:57:21 -0500 (EST)
From: Wayne Salamon <wsalamon@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Core policy, second pass
In-Reply-To: <200302261944.38544.russell@coker.com.au>
Message-ID: <Pine.LNX.4.33.0302261350580.3945-200000@vox.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="554330684-12203752-1046285841=:3945"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--554330684-12203752-1046285841=:3945
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 26 Feb 2003, Russell Coker wrote:

>
> bootloader should be considered as optional, it is not needed on a Cobalt Qube
> or RaQ for example.
>
> dhcpc, lpr, and lpd can be considered as optional and not required in a core
> policy, most Linux machines don't have lpd, and static IP addresses offer
> benefits for security.
>

Well, we need some consensus. Who is the typical user of the SELinux
download, and what are their requirements? Or, do we require some
customization for the user to be able to run, to enable base
functionality?

>
> Unfortunately no patch was attached.
>

 It is now. Sorry about that.

  We'll look at the other issues you raise: rpm, etc.

  Thanks,

-- 
Wayne Salamon
wsalamon@tislabs.com

--554330684-12203752-1046285841=:3945
Content-Type: TEXT/plain; name="diff.txt"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0302261357210.3945@vox.gw.tislabs.com>
Content-Description: 
Content-Disposition: attachment; filename="diff.txt"

SW5kZXg6IG1hY3Jvcy9wcm9ncmFtL3N1X21hY3Jvcy50ZQ0KPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQ0KUkNTIGZpbGU6IC9jdnMvbHNtL3NlbGludXgvcG9s
aWN5L21hY3Jvcy9wcm9ncmFtL3N1X21hY3Jvcy50ZSx2DQpyZXRyaWV2aW5n
IHJldmlzaW9uIDEuOQ0KZGlmZiAtdSAtcjEuOSBzdV9tYWNyb3MudGUNCi0t
LSBtYWNyb3MvcHJvZ3JhbS9zdV9tYWNyb3MudGUJMjAwMy8wMS8yNyAxOTox
NTo1NwkxLjkNCisrKyBtYWNyb3MvcHJvZ3JhbS9zdV9tYWNyb3MudGUJMjAw
My8wMi8yNiAxMzo1MDozMQ0KQEAgLTYxLDcgKzYxLDkgQEANCiBhbGxvdyAk
MV9zdV90ICQxX2hvbWVfZGlyX3Q6ZGlyIHNlYXJjaDsNCiANCiAjIE1vZGlm
eSAuWGF1dGhvcml0eSBmaWxlICh2aWEgeGF1dGggcHJvZ3JhbSkuDQoraWZk
ZWYoYHhhdXRoLXB0eS1oZWxwZXIudGUnLCBgDQogZG9tYWluX2F1dG9fdHJh
bnMoJDFfc3VfdCwgeGF1dGhfZXhlY190LCAkMV94YXV0aF90KQ0KKycpDQog
DQogIyBBY2Nlc3Mgc3NoZCBjb29raWUgZmlsZXMuDQogYWxsb3cgJDFfc3Vf
dCBzc2hkX3RtcF90OmRpciByd19kaXJfcGVybXM7DQpJbmRleDogbWFjcm9z
L3Byb2dyYW0vbHByX21hY3Jvcy50ZQ0KPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQ0KUkNTIGZpbGU6IC9jdnMvbHNtL3NlbGludXgvcG9saWN5L21hY3Jvcy9w
cm9ncmFtL2xwcl9tYWNyb3MudGUsdg0KcmV0cmlldmluZyByZXZpc2lvbiAx
LjgNCmRpZmYgLXUgLXIxLjggbHByX21hY3Jvcy50ZQ0KLS0tIG1hY3Jvcy9w
cm9ncmFtL2xwcl9tYWNyb3MudGUJMjAwMy8wMS8yMSAxNjoxNjoxNQkxLjgN
CisrKyBtYWNyb3MvcHJvZ3JhbS9scHJfbWFjcm9zLnRlCTIwMDMvMDIvMjYg
MTM6NTA6MzENCkBAIC0zNyw4ICszNyw2IEBADQogIyBVc2UgdGhpcyB0eXBl
IHdoZW4gY3JlYXRpbmcgZmlsZXMgaW4gL3RtcC4gDQogZmlsZV90eXBlX2F1
dG9fdHJhbnMoJDFfbHByX3QsIHRtcF90LCAkMV9scHJfdG1wX3QpDQogcl9k
aXJfZmlsZSgkMV9scHJfdCwgJDFfdG1wX3QpDQotYWxsb3cgJDFfbHByX3Qg
bHBkX3Zhcl9ydW5fdDpkaXIgc2VhcmNoOw0KLWFsbG93ICQxX2xwcl90IGxw
ZF92YXJfcnVuX3Q6c29ja19maWxlIHdyaXRlOw0KIA0KICMgVHlwZSBmb3Ig
c3Bvb2wgZmlsZXMuDQogdHlwZSAkMV9wcmludF9zcG9vbF90LCBmaWxlX3R5
cGUsIHN5c2FkbWZpbGU7DQpAQCAtNTksOSArNTcsMjEgQEANCiAjIFJlYWQg
YW5kIHdyaXRlIHNoYXJlZCBmaWxlcyBpbiB0aGUgc3Bvb2wgZGlyZWN0b3J5
Lg0KIGFsbG93ICQxX2xwcl90IHByaW50X3Nwb29sX3Q6bm90ZGV2ZmlsZV9j
bGFzc19zZXQgcndfZmlsZV9wZXJtczsNCiANCisjIGxwciBjYW4gcnVuIGlu
ICdsaWdodHdlaWdodCcgbW9kZSwgd2l0aG91dCBhIGxvY2FsIHByaW50IHNw
b29sZXIuIElmIHRoZQ0KKyMgbHBkIHBvbGljeSBpcyBwcmVzZW50LCBncmFu
dCBzb21lIHBlcm1pc3Npb25zIGZvciB0aGlzIGRvbWFpbiBhbmQgdGhlIGxw
ZA0KKyMgZG9tYWluIHRvIGludGVyYWN0Lg0KK2lmZGVmKGBscGQudGUnLCBg
DQorYWxsb3cgJDFfbHByX3QgbHBkX3Zhcl9ydW5fdDpkaXIgc2VhcmNoOw0K
K2FsbG93ICQxX2xwcl90IGxwZF92YXJfcnVuX3Q6c29ja19maWxlIHdyaXRl
Ow0KKw0KKyMgQWxsb3cgbHBkIHRvIHJlYWQsIHJlbmFtZSwgYW5kIHVubGlu
ayBzcG9vbCBmaWxlcy4NCithbGxvdyBscGRfdCAkMV9wcmludF9zcG9vbF90
OmZpbGUgcl9maWxlX3Blcm1zOw0KK2FsbG93IGxwZF90ICQxX3ByaW50X3Nw
b29sX3Q6ZmlsZSBsaW5rX2ZpbGVfcGVybXM7DQorDQogIyBDb25uZWN0IHRv
IGxwZCB2aWEgYSBVbml4IGRvbWFpbiBzb2NrZXQuDQogYWxsb3cgJDFfbHBy
X3QgcHJpbnRlcl90OnNvY2tfZmlsZSByd19maWxlX3Blcm1zOw0KIGNhbl91
bml4X2Nvbm5lY3QoJDFfbHByX3QsIGxwZF90KQ0KK2RvbnRhdWRpdCAkMV9s
cHJfdCAkMV90OnVuaXhfc3RyZWFtX3NvY2tldCB7IHJlYWQgd3JpdGUgfTsN
CiANCiAjIENvbm5lY3QgdG8gbHBkIHZpYSBhIFRDUCBzb2NrZXQuDQogY2Fu
X3RjcF9jb25uZWN0KCQxX2xwcl90LCBscGRfdCkNCkBAIC02OSwxMSArNzks
NyBAQA0KICMgU2VuZCBTSUdIVVAgdG8gbHBkLg0KIGFsbG93ICQxX2xwcl90
IGxwZF90OnByb2Nlc3Mgc2lnbmFsOw0KIA0KLSMgQWxsb3cgbHBkIHRvIHJl
YWQsIHJlbmFtZSwgYW5kIHVubGluayBzcG9vbCBmaWxlcy4NCi1hbGxvdyBs
cGRfdCAkMV9wcmludF9zcG9vbF90OmZpbGUgcl9maWxlX3Blcm1zOw0KLWFs
bG93IGxwZF90ICQxX3ByaW50X3Nwb29sX3Q6ZmlsZSBsaW5rX2ZpbGVfcGVy
bXM7DQotDQotZG9udGF1ZGl0ICQxX2xwcl90ICQxX3Q6dW5peF9zdHJlYW1f
c29ja2V0IHsgcmVhZCB3cml0ZSB9Ow0KKycpDQogDQogaWZkZWYoYGN1cHMu
dGUnLCBgDQogYWxsb3cgeyAkMV9scHJfdCAkMV90IH0gZXRjX2N1cHNkX3Q6
ZGlyIHNlYXJjaDsNCg==
--554330684-12203752-1046285841=:3945--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
