MIME-Version: 1.0
Date: Wed, 23 May 2012 22:46:39 -0700
Message-ID: <CAFftDdpickqWvZsow+meLh=FSpq7hyzD+f8jM50CqOaSKUMx4g@mail.gmail.com>
Subject: Patch for bcrm_patchram_plus [DRAFT]
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov, seandroid@tycho.nsa.gov
Cc: Kalyan Desineni <desineni@gmail.com>
Content-Type: multipart/mixed; boundary=047d7b33d4ca8ff8ab04c0c1c621
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--047d7b33d4ca8ff8ab04c0c1c621
Content-Type: multipart/alternative; boundary=047d7b33d4ca8ff8a104c0c1c61f

--047d7b33d4ca8ff8a104c0c1c61f
Content-Type: text/plain; charset=ISO-8859-1

This is a draft policy patch for SE Android Tuna based devices(Maguro and
Toro).

apply: external_sepolicy.patch to external/sepolicy
apply: device_samsung_tuna.patch to device/samsung/tuna

I am still having issues with the tuna init.rc getting it to restorecon
/factory/bluetooth/bt_addr, any help there would be appreciated.

I also am still debating whether or not the rule in tuna/sepolicy.fc

/factory/bluetooth/bt_addr     u:object_r:bluetooth_mac_file:s0

should go to external/sepolicy/file_contexts, do the other device have the
same layout, if so can the tuna factory/bluetooth labeling move too?

Thanks for the review!

-- 
Respectfully,

William C Roberts

--047d7b33d4ca8ff8a104c0c1c61f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This is a draft policy patch for SE Android Tuna based devices(Maguro and T=
oro).=A0<div><br></div><div>apply: external_sepolicy.patch to external/sepo=
licy</div><div>apply: device_samsung_tuna.patch to device/samsung/tuna</div=
>
<div><br></div><div>I am still having issues with the tuna init.rc getting =
it to restorecon /factory/bluetooth/bt_addr, any help there would be apprec=
iated.</div><div><br></div><div>I also am still debating whether or not the=
 rule in tuna/sepolicy.fc</div>
<div><br></div><div>/factory/bluetooth/bt_addr =A0 =A0 u:object_r:bluetooth=
_mac_file:s0</div><div><br></div><div>should go to external/sepolicy/file_c=
ontexts, do the other device have the same layout, if so can the tuna facto=
ry/bluetooth labeling move too?</div>
<div><br></div><div><div>Thanks for the review!</div><div><br></div>-- <br>=
Respectfully,<br><br>William C Roberts<br><br><br>
</div>

--047d7b33d4ca8ff8a104c0c1c61f--

--047d7b33d4ca8ff8ab04c0c1c621
Content-Type: application/octet-stream; name="external_sepolicy.patch"
Content-Disposition: attachment; filename="external_sepolicy.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h2le1zx51

ZGlmZiAtLWdpdCBhL2ZpbGUudGUgYi9maWxlLnRlCmluZGV4IGI2ZTNhNWQuLmExM2YwNTggMTAw
NjQ0Ci0tLSBhL2ZpbGUudGUKKysrIGIvZmlsZS50ZQpAQCAtNTUsNiArNTUsOCBAQCB0eXBlIGNh
Y2hlX2ZpbGUsIGZpbGVfdHlwZSwgbWxzdHJ1c3RlZG9iamVjdDsKIHR5cGUgZWZzX2ZpbGUsIGZp
bGVfdHlwZTsKICMgVHlwZSBmb3Igd2FsbHBhcGVyIGZpbGUuCiB0eXBlIHdhbGxwYXBlcl9maWxl
LCBmaWxlX3R5cGU7Cit0eXBlIGJsdWV0b290aF9tYWNfZmlsZSwgZmlsZV90eXBlOwordHlwZSBo
Y2lfYXR0YWNoX2RldiwgZGV2X3R5cGU7CiAKICMgU29ja2V0IHR5cGVzCiB0eXBlIGJsdWV0b290
aF9zb2NrZXQsIGZpbGVfdHlwZTsKZGlmZiAtLWdpdCBhL3JpbGQudGUgYi9yaWxkLnRlCmluZGV4
IGEwYTRhMzcuLjI2YTMyN2QgMTAwNjQ0Ci0tLSBhL3JpbGQudGUKKysrIGIvcmlsZC50ZQpAQCAt
MTcsNiArMTcsNyBAQCBhbGxvdyByaWxkIG10ZF9kZXZpY2U6ZGlyIHNlYXJjaDsKIGFsbG93IHJp
bGQgZWZzX2ZpbGU6ZGlyIGNyZWF0ZV9kaXJfcGVybXM7CiBhbGxvdyByaWxkIGVmc19maWxlOmZp
bGUgY3JlYXRlX2ZpbGVfcGVybXM7CiBhbGxvdyByaWxkIHNoZWxsX2V4ZWM6ZmlsZSByeF9maWxl
X3Blcm1zOworYWxsb3cgcmlsZCBibHVldG9vdGhfbWFjX2ZpbGU6ZmlsZSB7IHJlYWQgZ2V0YXR0
ciBvcGVuIH07CiBkb250YXVkaXQgcmlsZCBzZWxmOmNhcGFiaWxpdHkgc3lzX2FkbWluOwogIyBY
WFggTGFiZWwgc3lzZnMgZmlsZXMgd2l0aCBhIHNwZWNpZmljIHR5cGU/CiBhbGxvdyByaWxkIHN5
c2ZzOmZpbGUgcndfZmlsZV9wZXJtczsK
--047d7b33d4ca8ff8ab04c0c1c621
Content-Type: application/octet-stream; name="device_samsung_tuna.patch"
Content-Disposition: attachment; filename="device_samsung_tuna.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h2lefjmi2

ZGlmZiAtLWdpdCBhL2luaXQudHVuYS5yYyBiL2luaXQudHVuYS5yYwppbmRleCAxMzU1MjM3Li4z
ZTllNDU5IDEwMDc1NQotLS0gYS9pbml0LnR1bmEucmMKKysrIGIvaW5pdC50dW5hLnJjCkBAIC0x
MTMsNyArMTEzLDggQEAgb24gZnMKIAljaG1vZCAwNjYwIC9zeXMvY2xhc3MvcmZraWxsL3Jma2ls
bDAvc3RhdGUKIAljaG93biBibHVldG9vdGggYmx1ZXRvb3RoIC9zeXMvY2xhc3MvcmZraWxsL3Jm
a2lsbDAvc3RhdGUKIAljaG93biBibHVldG9vdGggYmx1ZXRvb3RoIC9zeXMvY2xhc3MvcmZraWxs
L3Jma2lsbDAvdHlwZQotICAgICAgICByZXN0b3JlY29uIC9mYWN0b3J5L2JsdWV0b290aAorCXJl
c3RvcmVjb24gL2ZhY3RvcnkvYmx1ZXRvb3RoCisJcmVzdG9yZWNvbiAvZmFjdG9yeS9ibHVldG9v
dGgvYnRfYWRkcgogCiAjIGJhY2tsaWdodAogCWNob3duIHN5c3RlbSBzeXN0ZW0gL3N5cy9jbGFz
cy9iYWNrbGlnaHQvczZlOGFhMC9icmlnaHRuZXNzCmRpZmYgLS1naXQgYS9zZXBvbGljeS5mYyBi
L3NlcG9saWN5LmZjCmluZGV4IGE0OTkxYTIuLjBhYWQzMDMgMTAwNjQ0Ci0tLSBhL3NlcG9saWN5
LmZjCisrKyBiL3NlcG9saWN5LmZjCkBAIC00LDMgKzQsMTEgQEAKIC9kYXRhL3JhZGlvL252X2Rh
dGEuYmluLiogIHU6b2JqZWN0X3I6cmFkaW9fZGF0YV9maWxlOnMwCiAvZmFjdG9yeSgvLiopPyAg
ICAgICAgICAgICB1Om9iamVjdF9yOmVmc19maWxlOnMwCiAvZmFjdG9yeS9udl9kYXRhLmJpbi4q
ICAgICB1Om9iamVjdF9yOnJhZGlvX2RhdGFfZmlsZTpzMAorL3N5c3RlbS9iaW4vYnJjbV9wYXRj
aHJhbV9wbHVzICAgICB1Om9iamVjdF9yOmJjcm1fcGF0Y2hyYW1fcGx1c19leGVjOnMwCisKKyNU
aGUgZGV2aWNlcyBhbmQgZmlsZXMgdXNlZCBieSB0aGUgaGNpYXR0YWNoIHNlcnZpY2UgYXJlIGRl
dmljZSBzcGVjaWZpYworL2Rldi90dHlPMSAgICAgdTpvYmplY3RfcjpoY2lfYXR0YWNoX2Rldjpz
MAorCisjWFhYIElzIC9mYWN0b3J5L2JsdWV0b290aC9idF9hZGRyIFR1bmEgc3BlY2lmaWMgdG9v
IG9yIGNvdWxkIHRoaXMgZ28gdG8KKyNleHRlcm5hbC9zZXBvbGljeT8KKy9mYWN0b3J5L2JsdWV0
b290aC9idF9hZGRyICAgICB1Om9iamVjdF9yOmJsdWV0b290aF9tYWNfZmlsZTpzMApkaWZmIC0t
Z2l0IGEvc2Vwb2xpY3kudGUgYi9zZXBvbGljeS50ZQppbmRleCA0ZTZiNjA0Li45ZTIyZWUyIDEw
MDY0NAotLS0gYS9zZXBvbGljeS50ZQorKysgYi9zZXBvbGljeS50ZQpAQCAtMSwzICsxLDEyIEBA
CiAjIFRoaXMgc2hvdWxkIGJlIHJlcXVpcmVkIGZvciBhbGwgZG9tYWlucy4KICMgQWRkZWQgYWNj
ZXNzIHRvIHN5c3RlbS50ZSBhbmQgbmZjLnRlIGluIHRoZSBiYXNlIHBvbGljeS4KICNhbGxvdyBk
b21haW4gc3lzZnNfbmZjX3Bvd2VyX3dyaXRhYmxlOmZpbGUgcndfZmlsZV9wZXJtczsKKwordHlw
ZSBiY3JtX3BhdGNocmFtX3BsdXMsIGRvbWFpbjsKK3R5cGUgYmNybV9wYXRjaHJhbV9wbHVzX2V4
ZWMsIGV4ZWNfdHlwZSwgZmlsZV90eXBlOworCitpbml0X2RhZW1vbl9kb21haW4oYmNybV9wYXRj
aHJhbV9wbHVzKQorCithbGxvdyBiY3JtX3BhdGNocmFtX3BsdXMgYmx1ZXRvb3RoX21hY19maWxl
OmZpbGUgeyByZWFkIG9wZW4gfTsKK2FsbG93IGJjcm1fcGF0Y2hyYW1fcGx1cyBoY2lfYXR0YWNo
X2RldjpjaHJfZmlsZSB7IHJlYWQgd3JpdGUgaW9jdGwgb3BlbiB9OworYWxsb3cgYmNybV9wYXRj
aHJhbV9wbHVzIGtlcm5lbDpzeXN0ZW0gbW9kdWxlX3JlcXVlc3Q7Cg==
--047d7b33d4ca8ff8ab04c0c1c621--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
