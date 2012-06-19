MIME-Version: 1.0
Date: Mon, 18 Jun 2012 22:10:47 -0700
Message-ID: <CAFftDdrLvViiy2dHyokrZdemJvoEV3+8DTh5HRCfrp8icpC0Tw@mail.gmail.com>
Subject: SE Android patch -- Fix for bug on factory labeling
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joshua Brindle <jbrindle@tresys.com>
Content-Type: multipart/mixed; boundary=047d7b10ce79254a5804c2cc4e37
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--047d7b10ce79254a5804c2cc4e37
Content-Type: multipart/alternative; boundary=047d7b10ce79254a5004c2cc4e35

--047d7b10ce79254a5004c2cc4e35
Content-Type: text/plain; charset=ISO-8859-1

A bug introduced in device/samsung/tuna on
commit 6fc73cf6d9e05d9e20009bf88c2f028657bc2ebd on branch seandroid caused
factory bluetooth to get mislabeled and was not caught. I discovered this
today while using a maguro for awhile. This patch fixes that introduced bug.

-- 
Respectfully,

William C Roberts

--047d7b10ce79254a5004c2cc4e35
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

A bug introduced in device/samsung/tuna on commit=A06fc73cf6d9e05d9e20009bf=
88c2f028657bc2ebd on branch seandroid caused factory bluetooth to get=A0mis=
labeled=A0and was not caught. I discovered this today while using a maguro =
for awhile. This patch fixes that introduced bug.<div>
<br></div><div>--=A0</div><div>Respectfully,<br><br>William C Roberts<br><b=
r><br>
</div>

--047d7b10ce79254a5004c2cc4e35--

--047d7b10ce79254a5804c2cc4e37
Content-Type: application/octet-stream; name="ordering.patch"
Content-Disposition: attachment; filename="ordering.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h3milpt20

ZGlmZiAtLWdpdCBhL3NlcG9saWN5LmZjIGIvc2Vwb2xpY3kuZmMKaW5kZXggMWRmODJlZi4uNTk5
ZmY5MiAxMDA2NDQKLS0tIGEvc2Vwb2xpY3kuZmMKKysrIGIvc2Vwb2xpY3kuZmMKQEAgLTE1LDkg
KzE1LDkgQEAKIC9kZXYvdW10c19pcGMwCXU6b2JqZWN0X3I6cmFkaW9fZGV2aWNlOnMwCiAvZGV2
L3VtdHNfcmFtZHVtcDAJdTpvYmplY3RfcjpyYWRpb19kZXZpY2U6czAKIC9kZXYvdW10c19yZnMw
IHU6b2JqZWN0X3I6cmFkaW9fZGV2aWNlOnMwCisvZmFjdG9yeSgvLiopPyAgICAgICAgICAgICB1
Om9iamVjdF9yOmVmc19maWxlOnMwCiAvZmFjdG9yeS9ibHVldG9vdGgoLy4qKT8gICAgIHU6b2Jq
ZWN0X3I6Ymx1ZXRvb3RoX2Vmc19maWxlOnMwCiAvZmFjdG9yeS9udl9kYXRhLmJpbi4qICAgICB1
Om9iamVjdF9yOnJhZGlvX2RhdGFfZmlsZTpzMAotL2ZhY3RvcnkoLy4qKT8gICAgICAgICAgICAg
dTpvYmplY3RfcjplZnNfZmlsZTpzMAogCiAjbmZjCiAvZGV2L3R0eU8zICAgICB1Om9iamVjdF9y
Om5mY19kZXZpY2U6czAK
--047d7b10ce79254a5804c2cc4e37--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
