Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5RBYdrT007812
	for <selinux@tycho.nsa.gov>; Sun, 27 Jun 2004 07:34:39 -0400 (EDT)
Received: from mbox-o00.iijmio.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5RBYL5h007786
	for <selinux@tycho.nsa.gov>; Sun, 27 Jun 2004 11:34:22 GMT
Message-Id: <200406271133.i5RBXpH0029485@mms-r00.iijmio.jp>
Date: Sun, 27 Jun 2004 20:33:49 +0900
From: Yuichi Nakamura <himainu-ynakam@miomio.jp>
MIME-Version: 1.0
To: fedora-selinux-list@redhat.com
Cc: himainu-ynakam@miomio.jp, selinux@tycho.nsa.gov, russell@coker.com.au
Subject: Policy for webalizer
Content-Type: multipart/mixed; boundary="------------Boundary_Wt2A_ef+qHNIn?r"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary_Wt2A_ef+qHNIn?r
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi.

I found that webalizer does not work from cron on FedoraCore2.

It seems that there is no policy for webalizer.
I wrote policy for webalizer.
I tested it from command line and cron.
Please use.

(1) copy webalizer policies to policy source dir.
#cp webalizer.te /etc/security/selinux/src/policy/domains/program
#cp webalizer.fc /etc/security/selinux/src/policy/file_contexts/program

(2) append the following to /etc/security/selinux/src/policy/domains/program/apache.te .

r_dir_file(httpd_t,webalizer_usage_t)

(3) reload and relabel
#cd  /etc/security/selinux/src/policy/
#make reload
#setfiles file_contexts/file_contexts /usr/bin /var /etc

Thank you.

---
Yuichi Nakamura
Japan SELinux Users Group(JPSEG)
http://www.selinux.gr.jp/
--------------Boundary_Wt2A_ef+qHNIn?r
Content-Type: application/octet-stream; name="webalizer.te"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="webalizer.te"

IyN3ZWJhbGl6ZXJfdDogZG9tYWluIGZvciB3ZWJhbGl6ZXIKIyAyMDA0LjYuMTkKIyBieSBZ
dWljaGkgTmFrYW11cmEgKHluYWthbSBAIHNlbGludXguZ3IuanApCgphcHBsaWNhdGlvbl9k
b21haW4od2ViYWxpemVyKQojIHRvIHVzZSBmcm9tIGNyb24Kc3lzdGVtX2Nyb25kX2VudHJ5
KHdlYmFsaXplcl9leGVjX3Qsd2ViYWxpemVyX3QpCnJvbGUgc3lzdGVtX3IgdHlwZXMgd2Vi
YWxpemVyX3Q7CgojI3R5cGUgZGVmaW5pc2lvbgojIHR5cGUgZm9yIHVzYWdlIGZpbGUKdHlw
ZSB3ZWJhbGl6ZXJfdXNhZ2VfdCxmaWxlX3R5cGUsc3lzYWRtZmlsZTsKIyB0eXBlIGZvciAv
dmFyL2xpYi93ZWJhbGl6ZXIKdHlwZSB3ZWJhbGl6ZXJfd3JpdGVfdCxmaWxlX3R5cGUsc3lz
YWRtZmlsZTsKIyB0eXBlIGZvciB3ZWJhbGl6ZXIuY29uZgp0eXBlIHdlYmFsaXplcl9jb25m
X3QsZmlsZV90eXBlLHN5c2FkbWZpbGU7CgojcmVhZCBhcGFjaGUgbG9nCmFsbG93IHdlYmFs
aXplcl90IHZhcl9sb2dfdDpkaXIgcl9kaXJfcGVybXM7CnJfZGlyX2ZpbGUod2ViYWxpemVy
X3QsaHR0cGRfbG9nX3QpCgojIHJlYWQgd2ViYWxpemVyLmNvbmYKYWxsb3cgd2ViYWxpemVy
X3Qgd2ViYWxpemVyX2NvbmZfdDpmaWxlIHJfZmlsZV9wZXJtczsKCiNyL3cgL3Zhci9saWIv
d2ViYWxpemVyCmFsbG93IHdlYmFsaXplcl90IHZhcl9saWJfdDpkaXIgeyBzZWFyY2ggfTsK
cndfZGlyX2NyZWF0ZV9maWxlKHdlYmFsaXplcl90LHdlYmFsaXplcl93cml0ZV90KQoKI3Jl
YWQgL3Zhci93d3cvdXNhZ2UKY3JlYXRlX2Rpcl9maWxlKHdlYmFsaXplcl90LHdlYmFsaXpl
cl91c2FnZV90KQphbGxvdyB3ZWJhbGl6ZXJfdCBodHRwZF9zeXNfY29udGVudF90OmRpciB7
IHNlYXJjaCB9OwoKI3JlYWQgc3lzdGVtIGZpbGVzIHVuZGVyIC9ldGMKYWxsb3cgd2ViYWxp
emVyX3QgZXRjX3Q6ZmlsZSByX2ZpbGVfcGVybXM7CmFsbG93IHdlYmFsaXplcl90IGV0Y19y
dW50aW1lX3Q6ZmlsZSByX2ZpbGVfcGVybXM7CmFsbG93IHdlYmFsaXplcl90IGxvY2FsZV90
OmZpbGUgeyBnZXRhdHRyIHJlYWQgfTsKCiMgdG8gdXNlIGZyb20gY29tbWFuZCBsaW5lCmFs
bG93IHdlYmFsaXplcl90IGxvY2FsX2xvZ2luX3Q6ZmQgeyB1c2UgfTsKYWxsb3cgd2ViYWxp
emVyX3Qgc3lzYWRtX3R0eV9kZXZpY2VfdDpjaHJfZmlsZSB7IHJlYWQgd3JpdGUgfTsKCgoj
IGNhbiB1c2UgdG1wIGZpbGUKdG1wX2RvbWFpbih3ZWJhbGl6ZXIpCgojIGNhbiByZWFkIC9w
cm9jCnJlYWRfc3lzY3RsKHdlYmFsaXplcl90KQphbGxvdyB3ZWJhbGl6ZXJfdCBwcm9jX3Q6
ZGlyIHsgc2VhcmNoIH07CmFsbG93IHdlYmFsaXplcl90IHByb2NfdDpmaWxlIHJfZmlsZV9w
ZXJtczsKCiMgbmV0d29yawphbGxvdyB3ZWJhbGl6ZXJfdCBuZXRfY29uZl90OmZpbGUgeyBn
ZXRhdHRyIHJlYWQgfTsKYWxsb3cgd2ViYWxpemVyX3QgZG5zX3BvcnRfdDp1ZHBfc29ja2V0
IHsgcmVjdl9tc2cgc2VuZF9tc2cgfTsKYWxsb3cgd2ViYWxpemVyX3QgbmV0aWZfZXRoMF90
Om5ldGlmIHsgdWRwX3JlY3YgdWRwX3NlbmQgfTsKYWxsb3cgd2ViYWxpemVyX3Qgbm9kZV90
Om5vZGUgeyB1ZHBfcmVjdiB1ZHBfc2VuZCB9OwoKI3Byb2Nlc3MgY29tbXVuaWNhdGlvbiBp
bnNpZGUgd2ViYWxpemVyIGl0c2VsZgpnZW5lcmFsX2RvbWFpbl9hY2Nlc3Mod2ViYWxpemVy
X3QpCgphbGxvdyB3ZWJhbGl6ZXJfdCB3ZWJhbGl6ZXJfdDpjYXBhYmlsaXR5IHsgZGFjX292
ZXJyaWRlIH07CgojIHRvIHVzZSBmcm9tIHNzaAphbGxvdyB3ZWJhbGl6ZXJfdCBzc2hkX3Q6
ZmQgeyB1c2UgfTsKYWxsb3cgd2ViYWxpemVyX3Qgc3lzYWRtX2RldnB0c190OmNocl9maWxl
IHJ3X2ZpbGVfcGVybXM7Cn==

--------------Boundary_Wt2A_ef+qHNIn?r
Content-Type: application/octet-stream; name="webalizer.fc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="webalizer.fc"

Ci91c3IvYmluL3dlYmFsaXplcgkJc3lzdGVtX3U6b2JqZWN0X3I6d2ViYWxpemVyX2V4ZWNf
dAovdmFyL3d3dy91c2FnZSgvLiopPwlzeXN0ZW1fdTpvYmplY3Rfcjp3ZWJhbGl6ZXJfdXNh
Z2VfdAovdmFyL2xpYi93ZWJhbGl6ZXIoLy4qKT8Jc3lzdGVtX3U6b2JqZWN0X3I6d2ViYWxp
emVyX3dyaXRlX3QKL2V0Yy93ZWJhbGl6ZXIuY29uZgkJc3lzdGVtX3U6b2JqZWN0X3I6d2Vi
YWxpemVyX2NvbmZfdAr=

--------------Boundary_Wt2A_ef+qHNIn?r--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
