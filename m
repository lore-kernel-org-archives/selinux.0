Message-Id: <200209151556.PAA17617@jazzswing.ncsc.mil>
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: some patches
Date: Sun, 15 Sep 2002 17:56:45 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_LMLHRJWRG9OI45PPBD5P"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_LMLHRJWRG9OI45PPBD5P
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I've attached follow patches:
inetd.diff:=20
  add a type var_log_inetd_t for daemons logs
ldconfig.diff:=20
  dontaudit ldconfig_t device_t:dir { search };
  change { read write } for sysadm_devpts_t and sysadm_tty_device_t=20
  to rw_file_perms, because I need also getattr and ioctl for SuSE
pppd.diff:
  allow pppd_t device_t:dir { search };

Carsten
--------------Boundary-00=_LMLHRJWRG9OI45PPBD5P
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="inetd.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="inetd.diff"

LS0tIC4uL29yaWdpbmFsL2ZpbGVfY29udGV4dHMvcHJvZ3JhbS9pbmV0ZC5mYwlUdWUgSnVuIDE4
IDE5OjQwOjQxIDIwMDIKKysrIGZpbGVfY29udGV4dHMvcHJvZ3JhbS9pbmV0ZC5mYwlTYXQgU2Vw
IDE0IDE3OjU0OjE0IDIwMDIKQEAgLTQsMyArNCw0IEBACiAvdXNyL3NiaW4vcmxpbmV0ZAkJc3lz
dGVtX3U6b2JqZWN0X3I6aW5ldGRfZXhlY190CiAvdXNyL3NiaW4vaWRlbnRkCQlzeXN0ZW1fdTpv
YmplY3RfcjppbmV0ZF9jaGlsZF9leGVjX3QKIC91c3Ivc2Jpbi9pblwuLipkCQlzeXN0ZW1fdTpv
YmplY3RfcjppbmV0ZF9jaGlsZF9leGVjX3QKKy92YXIvbG9nLyh4KT9pbmV0ZC5sb2cJCXN5c3Rl
bV91Om9iamVjdF9yOnZhcl9sb2dfaW5ldGRfdAotLS0gLi4vb3JpZ2luYWwvZG9tYWlucy9wcm9n
cmFtL2luZXRkLnRlCVR1ZSBKdW4gMTggMTk6NDA6MzkgMjAwMgorKysgZG9tYWlucy9wcm9ncmFt
L2luZXRkLnRlCVNhdCBTZXAgMTQgMTg6MDg6MDAgMjAwMgpAQCAtMjMsNiArMjMsOCBAQAogZmls
ZV90eXBlX2F1dG9fdHJhbnMoaW5ldGRfdCwgdG1wX3QsIGluZXRkX3RtcF90KQogdHlwZSBpbmV0
ZF92YXJfcnVuX3QsIGZpbGVfdHlwZSwgc3lzYWRtZmlsZSwgcGlkZmlsZTsKIGZpbGVfdHlwZV9h
dXRvX3RyYW5zKGluZXRkX3QsIHZhcl9ydW5fdCwgaW5ldGRfdmFyX3J1bl90KQordHlwZSB2YXJf
bG9nX2luZXRkX3QsIGZpbGVfdHlwZSwgc3lzYWRtZmlsZTsKK2ZpbGVfdHlwZV9hdXRvX3RyYW5z
KGluZXRkX3QsIHZhcl9sb2dfdCwgdmFyX2xvZ19pbmV0ZF90KQogCiAjIEluaGVyaXQgYW5kIHVz
ZSBkZXNjcmlwdG9ycyBmcm9tIGluaXQuCiBhbGxvdyBpbmV0ZF90IGluaXRfdDpmZCB1c2U7Cg==

--------------Boundary-00=_LMLHRJWRG9OI45PPBD5P
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="ldconfig.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ldconfig.diff"

LS0tIC4uL29yaWdpbmFsL2RvbWFpbnMvcHJvZ3JhbS9sZGNvbmZpZy50ZQlXZWQgQXVnIDIxIDIw
OjIyOjQ0IDIwMDIKKysrIGRvbWFpbnMvcHJvZ3JhbS9sZGNvbmZpZy50ZQlTdW4gU2VwIDE1IDE3
OjE3OjMwIDIwMDIKQEAgLTEzLDcgKzEzLDcgQEAKIHJvbGUgc3lzdGVtX3IgdHlwZXMgbGRjb25m
aWdfdDsKIAogZG9tYWluX2F1dG9fdHJhbnMoeyBzeXNhZG1fdCBpbml0cmNfdCBpZmRlZihgZHBr
Zy50ZScsIGBkcGtnX3QnKSB9LCBsZGNvbmZpZ19leGVjX3QsIGxkY29uZmlnX3QpCi1hbGxvdyBs
ZGNvbmZpZ190IHsgc3lzYWRtX2RldnB0c190IHN5c2FkbV90dHlfZGV2aWNlX3QgfTpjaHJfZmls
ZSB7IHJlYWQgd3JpdGUgfTsKK2FsbG93IGxkY29uZmlnX3QgeyBzeXNhZG1fZGV2cHRzX3Qgc3lz
YWRtX3R0eV9kZXZpY2VfdCB9OmNocl9maWxlIHJ3X2ZpbGVfcGVybXM7CiBhbGxvdyBsZGNvbmZp
Z190IHByaXZmZDpmZCB1c2U7CiAKIHVzZXNfc2hsaWIobGRjb25maWdfdCkKQEAgLTI2LDMgKzI2
LDYgQEAKIGFsbG93IGxkY29uZmlnX3QgZXRjX3Q6bG5rX2ZpbGUgcmVhZDsKIAogYWxsb3cgbGRj
b25maWdfdCBmc190OmZpbGVzeXN0ZW0gZ2V0YXR0cjsKKworIyBkb250YXVkaXQKK2RvbnRhdWRp
dCBsZGNvbmZpZ190IGRldmljZV90OmRpciB7IHNlYXJjaCB9Owo=

--------------Boundary-00=_LMLHRJWRG9OI45PPBD5P
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="pppd.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="pppd.diff"

LS0tIC4uL3J1c3NlbC9kb21haW5zL3Byb2dyYW0vcHBwZC50ZQlNb24gU2VwICA5IDIyOjMxOjE4
IDIwMDIKKysrIGRvbWFpbnMvcHJvZ3JhbS9wcHBkLnRlCVNhdCBTZXAgMTQgMTc6MTk6NDIgMjAw
MgpAQCAtNDYsNiArNDYsNyBAQAogYWxsb3cgcHBwZF90IGJpbl90Omxua19maWxlIHJlYWQ7CiAK
ICMgQWNjZXNzIC9kZXYvcHBwLgorYWxsb3cgcHBwZF90IGRldmljZV90OmRpciB7IHNlYXJjaCB9
OwogYWxsb3cgcHBwZF90IHBwcF9kZXZpY2VfdDpjaHJfZmlsZSByd19maWxlX3Blcm1zOwogYWxs
b3cgcHBwZF90IGRldnR0eV90OmNocl9maWxlIHsgcmVhZCB3cml0ZSB9OwogCg==

--------------Boundary-00=_LMLHRJWRG9OI45PPBD5P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
