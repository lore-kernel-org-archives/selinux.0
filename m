MIME-Version: 1.0
Date: Tue, 19 Jun 2012 19:43:14 -0700
Message-ID: <CAFftDdr+nvC3e1bJ62cdB-TWcDeA36QfmrGi3OqTb+oPJ-tqjg@mail.gmail.com>
Subject: [PATCH] ion fix
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary=e89a8ff2439f5b280104c2de5cab
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--e89a8ff2439f5b280104c2de5cab
Content-Type: multipart/alternative; boundary=e89a8ff2439f5b27fa04c2de5ca9

--e89a8ff2439f5b27fa04c2de5ca9
Content-Type: text/plain; charset=ISO-8859-1

Attached is a patch file that fixes Media Server denial when accessing
/dev/ion

Since it is for all ICS devices, I put it in external/sepolicy.

http://lwn.net/Articles/480055/

Bill Roberts

--e89a8ff2439f5b27fa04c2de5ca9
Content-Type: text/html; charset=ISO-8859-1

<div><br></div>Attached is a patch file that fixes Media Server denial when accessing /dev/ion<div><br></div><div>Since it is for all ICS devices, I put it in external/sepolicy.<br>
<div><br></div><div><a href="http://lwn.net/Articles/480055/">http://lwn.net/Articles/480055/</a></div><div><br></div><div>Bill Roberts</div></div>

--e89a8ff2439f5b27fa04c2de5ca9--

--e89a8ff2439f5b280104c2de5cab
Content-Type: application/octet-stream; name="ion.patch"
Content-Disposition: attachment; filename="ion.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h3nsqcj40

RnJvbSA2ZWI2MDc3MDA3YTJhYTViMTgwNDk0ODVkMjMzOTNkZTZmNjU5YzY3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBXaWxsaWFtIFJvYmVydHMgPHcucm9iZXJ0c0BzdGEuc2Ftc3Vu
Zy5jb20+CkRhdGU6IFR1ZSwgMTkgSnVuIDIwMTIgMTg6NDY6MTYgLTA3MDAKU3ViamVjdDogW1BB
VENIXSBpb24gZml4CgotLS0KIGRldmljZS50ZSAgICAgIHwgICAgMSArCiBmaWxlX2NvbnRleHRz
ICB8ICAgIDEgKwogbWVkaWFzZXJ2ZXIudGUgfCAgICAxICsKIDMgZmlsZXMgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RldmljZS50ZSBiL2Rl
dmljZS50ZQppbmRleCA0ZDJkZWEzLi5jYjE1ZWViIDEwMDY0NAotLS0gYS9kZXZpY2UudGUKKysr
IGIvZGV2aWNlLnRlCkBAIC0zOCw2ICszOCw3IEBAIHR5cGUgdmlkZW9fZGV2aWNlLCBkZXZfdHlw
ZTsKIHR5cGUgdmNzX2RldmljZSwgZGV2X3R5cGU7CiB0eXBlIHplcm9fZGV2aWNlLCBkZXZfdHlw
ZTsKIHR5cGUgZnVzZV9kZXZpY2UsIGRldl90eXBlOwordHlwZSBpb25fZGV2aWNlLCBkZXZfdHlw
ZTsKIAogIyBBbGwgZGV2aWNlcyBoYXZlIGEgdWFydCBmb3IgdGhlIGhjaQogIyBhdHRhY2ggc2Vy
dmljZS4gVGhlIHVhcnQgZGV2IG5vZGUKZGlmZiAtLWdpdCBhL2ZpbGVfY29udGV4dHMgYi9maWxl
X2NvbnRleHRzCmluZGV4IGZhMjJjODcuLjcyYzk1YTUgMTAwNjQ0Ci0tLSBhL2ZpbGVfY29udGV4
dHMKKysrIGIvZmlsZV9jb250ZXh0cwpAQCAtMjgsNiArMjgsNyBAQAogL2Rldi9mdXNlCQl1Om9i
amVjdF9yOmZ1c2VfZGV2aWNlOnMwCiAvZGV2L2dyYXBoaWNzKC8uKik/CXU6b2JqZWN0X3I6Z3Jh
cGhpY3NfZGV2aWNlOnMwCiAvZGV2L2lucHV0KC8uKikJCXU6b2JqZWN0X3I6aW5wdXRfZGV2aWNl
OnMwCisvZGV2L2lvbgkJdTpvYmplY3Rfcjppb25fZGV2aWNlOnMwCiAvZGV2L2ttZW0JCXU6b2Jq
ZWN0X3I6a21lbV9kZXZpY2U6czAKIC9kZXYvbG9nKC8uKik/CQl1Om9iamVjdF9yOmxvZ19kZXZp
Y2U6czAKIC9kZXYvbWVtCQl1Om9iamVjdF9yOmttZW1fZGV2aWNlOnMwCmRpZmYgLS1naXQgYS9t
ZWRpYXNlcnZlci50ZSBiL21lZGlhc2VydmVyLnRlCmluZGV4IDE2YmJlZmEuLjgyMzZjNzkgMTAw
NjQ0Ci0tLSBhL21lZGlhc2VydmVyLnRlCisrKyBiL21lZGlhc2VydmVyLnRlCkBAIC0yNCwzICsy
NCw0IEBAIGFsbG93IG1lZGlhc2VydmVyIHFlbXVfZGV2aWNlOmNocl9maWxlIHJ3X2ZpbGVfcGVy
bXM7CiBhbGxvdyBtZWRpYXNlcnZlciBzeXNmczpmaWxlIHJ3X2ZpbGVfcGVybXM7CiAjIFhYWCBX
aHk/CiBhbGxvdyBtZWRpYXNlcnZlciBhcGtfZGF0YV9maWxlOmZpbGUgeyByZWFkIGdldGF0dHIg
fTsKK2FsbG93IG1lZGlhc2VydmVyIGlvbl9kZXZpY2U6Y2hyX2ZpbGUgcndfZmlsZV9wZXJtczsK
LS0gCjEuNy4wLjQKCg==
--e89a8ff2439f5b280104c2de5cab--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
