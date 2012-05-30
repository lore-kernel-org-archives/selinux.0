MIME-Version: 1.0
Date: Wed, 30 May 2012 17:43:16 -0400
Message-ID: <CAFftDdqD=SB5YVPMW1s9CKU3ot57PV=yzha0=qDUALiU9TiuaA@mail.gmail.com>
Subject: SE Android patch for internal fuse sdcard policy
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov, seandroid@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary=20cf307ac163c6f0bc04c147d6ea
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--20cf307ac163c6f0bc04c147d6ea
Content-Type: multipart/alternative; boundary=20cf307ac163c6f0b804c147d6e8

--20cf307ac163c6f0b804c147d6e8
Content-Type: text/plain; charset=ISO-8859-1

The attached patch handles the policy for /system/bin/sdcard. Most US and
European bound Android handsets are moving to 'internal sdcard' which
consists of a fuse file system faking the old FAT setup and writing to
/data/media. This was tested on a Maguro device, but all other internal
sdcard systems should be the same.

Since sdcard was already in use, I called everything sdcardd*.

Also, I labeled /dev/fuse as a fuse_device, since other processes should
not require access to the fuse device.

-- 
Respectfully,

William C Roberts

--20cf307ac163c6f0b804c147d6e8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

The attached patch handles the policy for /system/bin/sdcard. Most US and E=
uropean bound Android handsets are moving to &#39;internal sdcard&#39; whic=
h consists of a fuse file system faking the old FAT setup and writing to /d=
ata/media. This was tested on a Maguro device, but all other internal sdcar=
d systems should be the same.<br clear=3D"all">
<div><br></div><div>Since sdcard was already in use, I called=A0everything =
sdcardd*.=A0</div><div><br></div><div>Also, I labeled /dev/fuse as a fuse_d=
evice, since other processes should not require access to the fuse device. =
=A0</div>
<div><br></div>-- <br>Respectfully,<br><br>William C Roberts<br><br><br>

--20cf307ac163c6f0b804c147d6e8--

--20cf307ac163c6f0bc04c147d6ea
Content-Type: application/octet-stream;
	name="external_sepolicy_sdcardd.patch"
Content-Disposition: attachment; filename="external_sepolicy_sdcardd.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h2ux6szq0

ZGlmZiAtLWdpdCBhL2RldmljZS50ZSBiL2RldmljZS50ZQppbmRleCA2NDI0ZGI2Li43MTBiNjdj
IDEwMDY0NAotLS0gYS9kZXZpY2UudGUKKysrIGIvZGV2aWNlLnRlCkBAIC0zNywzICszNyw0IEBA
IHR5cGUgdXJhbmRvbV9kZXZpY2UsIGRldl90eXBlOwogdHlwZSB2aWRlb19kZXZpY2UsIGRldl90
eXBlOwogdHlwZSB2Y3NfZGV2aWNlLCBkZXZfdHlwZTsKIHR5cGUgemVyb19kZXZpY2UsIGRldl90
eXBlOwordHlwZSBmdXNlX2RldmljZSwgZGV2X3R5cGU7CmRpZmYgLS1naXQgYS9maWxlX2NvbnRl
eHRzIGIvZmlsZV9jb250ZXh0cwppbmRleCBjNjEwZGYzLi5mYTIyYzg3IDEwMDY0NAotLS0gYS9m
aWxlX2NvbnRleHRzCisrKyBiL2ZpbGVfY29udGV4dHMKQEAgLTI1LDYgKzI1LDcgQEAKIC9kZXYv
ZGV2aWNlLW1hcHBlcgl1Om9iamVjdF9yOmRtX2RldmljZTpzMAogL2Rldi9lYWMJCXU6b2JqZWN0
X3I6YXVkaW9fZGV2aWNlOnMwCiAvZGV2L2Z1bGwJCXU6b2JqZWN0X3I6ZnVsbF9kZXZpY2U6czAK
Ky9kZXYvZnVzZQkJdTpvYmplY3RfcjpmdXNlX2RldmljZTpzMAogL2Rldi9ncmFwaGljcygvLiop
Pwl1Om9iamVjdF9yOmdyYXBoaWNzX2RldmljZTpzMAogL2Rldi9pbnB1dCgvLiopCQl1Om9iamVj
dF9yOmlucHV0X2RldmljZTpzMAogL2Rldi9rbWVtCQl1Om9iamVjdF9yOmttZW1fZGV2aWNlOnMw
CkBAIC05Niw2ICs5Nyw3IEBACiAvc3lzdGVtL2Jpbi9ibHVldG9vdGhkCXU6b2JqZWN0X3I6Ymx1
ZXRvb3RoZF9leGVjOnMwCiAvc3lzdGVtL2Jpbi93cGFfc3VwcGxpY2FudAl1Om9iamVjdF9yOndw
YV9leGVjOnMwCiAvc3lzdGVtL2Jpbi9xZW11ZAl1Om9iamVjdF9yOnFlbXVkX2V4ZWM6czAKKy9z
eXN0ZW0vYmluL3NkY2FyZCAgICAgIHU6b2JqZWN0X3I6c2RjYXJkZF9leGVjOnMwCiAvc3lzdGVt
L3hiaW4vc3UJCXU6b2JqZWN0X3I6c3VfZXhlYzpzMAogL3N5c3RlbS92ZW5kb3IvYmluL2dwc2Qg
dTpvYmplY3RfcjpncHNkX2V4ZWM6czAKICMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjCmRp
ZmYgLS1naXQgYS9zZGNhcmRkLnRlIGIvc2RjYXJkZC50ZQpuZXcgZmlsZSBtb2RlIDEwMDY0NApp
bmRleCAwMDAwMDAwLi4yMWI4NjczCi0tLSAvZGV2L251bGwKKysrIGIvc2RjYXJkZC50ZQpAQCAt
MCwwICsxLDEzIEBACit0eXBlIHNkY2FyZGQsIGRvbWFpbjsKK3R5cGUgc2RjYXJkZF9leGVjLCBl
eGVjX3R5cGUsIGZpbGVfdHlwZTsKKworaW5pdF9kYWVtb25fZG9tYWluKHNkY2FyZGQpCisKK2Fs
bG93IHNkY2FyZGQgY2dyb3VwOmRpciBjcmVhdGVfZGlyX3Blcm1zOworYWxsb3cgc2RjYXJkZCBm
dXNlX2RldmljZTpjaHJfZmlsZSByd19maWxlX3Blcm1zOworYWxsb3cgc2RjYXJkZCByb290ZnM6
ZGlyIG1vdW50b247CithbGxvdyBzZGNhcmRkIHNkY2FyZDpmaWxlc3lzdGVtIG1vdW50OworYWxs
b3cgc2RjYXJkZCBzZWxmOmNhcGFiaWxpdHkgeyBzZXR1aWQgc2V0Z2lkIH07CithbGxvdyBzZGNh
cmRkIHN5c3RlbV9kYXRhX2ZpbGU6ZGlyICBjcmVhdGVfZGlyX3Blcm1zOworYWxsb3cgc2RjYXJk
ZCBzeXN0ZW1fZGF0YV9maWxlOmZpbGUgY3JlYXRlX2ZpbGVfcGVybXM7CisK
--20cf307ac163c6f0bc04c147d6ea--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
