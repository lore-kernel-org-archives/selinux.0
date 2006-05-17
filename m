MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C679BC.066A5F86"
Subject: [PATCH] initialize sym_val_to_name arrays
Date: Wed, 17 May 2006 10:13:08 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B015881706A0@exchange.columbia.tresys.com>
From: "Kevin Carr" <kcarr@tresys.com>
To: <selinux@tycho.nsa.gov>
Cc: <selinux-dev@tresys.com>, "Stephen Smalley" <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C679BC.066A5F86
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The attached patch initializes the sym_val_to_name arrays to NULL on
creation. There are circumstances where a symbol name might not be
present (e.g., attributes lack names when loaded from kernel binary
policy). Without this patch the symbol name will be undefined rather
than NULL in those cases. Though it is possible to determine which names
are undefined based on the policy type and the symbol datum, this patch
helps avoid inadvertent mistakes.

Kevin Carr
Tresys Technology
410.290.1411 x137

------_=_NextPart_001_01C679BC.066A5F86
Content-Type: application/octet-stream;
	name="sepol-explicit-initialize-syms.patch"
Content-Transfer-Encoding: base64
Content-Description: sepol-explicit-initialize-syms.patch
Content-Disposition: attachment;
	filename="sepol-explicit-initialize-syms.patch"

SW5kZXg6IGxpYnNlcG9sL3NyYy9wb2xpY3lkYi5jDQo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQotLS0gbGlic2Vwb2wv
c3JjL3BvbGljeWRiLmMJKHJldmlzaW9uIDY3MikNCisrKyBsaWJzZXBvbC9zcmMvcG9saWN5ZGIu
Ywkod29ya2luZyBjb3B5KQ0KQEAgLTcxMSw2ICs3MTEsOCBAQA0KIAkJICAgIG1hbGxvYyhwLT5z
eW10YWJbaV0ubnByaW0gKiBzaXplb2YoY2hhciAqKSk7DQogCQlpZiAoIXAtPnN5bV92YWxfdG9f
bmFtZVtpXSkNCiAJCQlyZXR1cm4gLTE7DQorCQltZW1zZXQocC0+c3ltX3ZhbF90b19uYW1lW2ld
LCAwLA0KKwkJICAgICAgIHAtPnN5bXRhYltpXS5ucHJpbSAqIHNpemVvZihjaGFyICopKTsNCiAJ
CWlmIChoYXNodGFiX21hcChwLT5zeW10YWJbaV0udGFibGUsIGluZGV4X2ZbaV0sIHApKQ0KIAkJ
CXJldHVybiAtMTsNCiAJfQ0K

------_=_NextPart_001_01C679BC.066A5F86--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
