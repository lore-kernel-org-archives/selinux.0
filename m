Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w889oxr1016493
 for <selinux@tycho.nsa.gov>; Sat, 8 Sep 2018 05:51:01 -0400
From: =?gb2312?B?wO4gzuS41Q==?= <liwugang@outlook.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Sat, 8 Sep 2018 09:50:23 +0000
Message-ID: <DM5PR05MB3401C01C936FFE66579A1928D4070@DM5PR05MB3401.namprd05.prod.outlook.com>
Content-Type: multipart/mixed;
 boundary="_004_DM5PR05MB3401C01C936FFE66579A1928D4070DM5PR05MB3401namp_"
MIME-Version: 1.0
Subject: Bug report
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--_004_DM5PR05MB3401C01C936FFE66579A1928D4070DM5PR05MB3401namp_
Content-Type: multipart/alternative;
	boundary="_000_DM5PR05MB3401C01C936FFE66579A1928D4070DM5PR05MB3401namp_"

--_000_DM5PR05MB3401C01C936FFE66579A1928D4070DM5PR05MB3401namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

DQpIaSwgQUxMDQoNClRoZXJlIGlzIG9uZSBidWcgd2hpY2ggaGFzIG5vdCBjaGVja2luZyB0aGUg
cmVzdWx0IHZhbHVlIG9mICBoYXNodGFiX3NlYXJjaCBpbiB0aGUgZnVuY3Rpb24gZGVmaW5lX2xl
dmVsIG9mIHBvbGljeWRiX2RlZmluZS5jLiBJZiB0aGUgY2F0ZWdvcnkgaXMgbm90IGRlZmluZWQs
IGEgbnVsbC1wb2ludGVyIGRlcmVmZXJlbmNlIHdpbGwgYmUgdGFrZW4gcGxhY2UuDQpUaGUgcGF0
Y2ggaXMgYXR0YWNoZWQuDQoNCkJlc3QgUmVnYXJkcywNCsDuzuS41Q0KDQo=

--_000_DM5PR05MB3401C01C936FFE66579A1928D4070DM5PR05MB3401namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi, ALL</p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">There is one bug which has not checking the result v=
alue of &nbsp;hashtab_search in the function define_level of policydb_defin=
e.c. If the category is not defined, a null-pointer dereference will be tak=
en place.
</p>
<p class=3D"MsoNormal">The patch is attached. </p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Best Regards,<o:p></o:p></p>
<p class=3D"MsoNormal"><span lang=3D"ZH-CN" style=3D"font-family:DengXian">=
=C0=EE=CE=E4=B8=D5</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_DM5PR05MB3401C01C936FFE66579A1928D4070DM5PR05MB3401namp_--

--_004_DM5PR05MB3401C01C936FFE66579A1928D4070DM5PR05MB3401namp_
Content-Type: application/octet-stream;
	name="0001-checkpolicy-check-the-result-value-of-hashtable_sear.patch"
Content-Description: 0001-checkpolicy-check-the-result-value-of-hashtable_sear.patch
Content-Disposition: attachment;
	filename="0001-checkpolicy-check-the-result-value-of-hashtable_sear.patch";
	size=835; creation-date="Sat, 08 Sep 2018 09:33:58 GMT";
	modification-date="Sat, 08 Sep 2018 09:33:58 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxZTc3ODEzNzgxN2JlZDEwOGNjN2M3YzQ4ODkzMDNhM2Y3NmNjZDI3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBsaXd1Z2FuZyA8bGl3dWdhbmdAeGlhb21pLmNvbT4KRGF0ZTog
U2F0LCA4IFNlcCAyMDE4IDE3OjE2OjQxICswODAwClN1YmplY3Q6IFtQQVRDSF0gY2hlY2twb2xp
Y3k6IGNoZWNrIHRoZSByZXN1bHQgdmFsdWUgb2YgaGFzaHRhYmxlX3NlYXJjaAoKU2lnbmVkLW9m
Zi1ieTogbGl3dWdhbmcgPGxpd3VnYW5nQHhpYW9taS5jb20+Ci0tLQogY2hlY2twb2xpY3kvcG9s
aWN5X2RlZmluZS5jIHwgNSArKysrKwogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQoK
ZGlmZiAtLWdpdCBhL2NoZWNrcG9saWN5L3BvbGljeV9kZWZpbmUuYyBiL2NoZWNrcG9saWN5L3Bv
bGljeV9kZWZpbmUuYwppbmRleCBkODc4OGE2Zi4uZWNlMTBlN2EgMTAwNjQ0Ci0tLSBhL2NoZWNr
cG9saWN5L3BvbGljeV9kZWZpbmUuYworKysgYi9jaGVja3BvbGljeS9wb2xpY3lfZGVmaW5lLmMK
QEAgLTExMDcsNiArMTEwNywxMSBAQCBpbnQgZGVmaW5lX2xldmVsKHZvaWQpCiAJCQkgICAgKGNh
dF9kYXR1bV90ICopIGhhc2h0YWJfc2VhcmNoKHBvbGljeWRicC0+cF9jYXRzLgogCQkJCQkJCSAg
IHRhYmxlLAogCQkJCQkJCSAgIChoYXNodGFiX2tleV90KSBpZCk7CisJCQlpZiAoIWNkYXR1bSkg
eworCQkJCXl5ZXJyb3IyKCJ1bmtub3duIGNhdGVnb3J5ICVzIiwgaWQpOworCQkJCWZyZWUoaWQp
OworCQkJCXJldHVybiAtMTsKKwkJCX0KIAkJCXJhbmdlX3N0YXJ0ID0gcmFuZ2VfZW5kID0gY2Rh
dHVtLT5zLnZhbHVlIC0gMTsKIAkJfQogCi0tIAoyLjE4LjAKCg==

--_004_DM5PR05MB3401C01C936FFE66579A1928D4070DM5PR05MB3401namp_--
