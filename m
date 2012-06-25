Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q5PJOVNx023640
	for <selinux@tycho.nsa.gov>; Mon, 25 Jun 2012 15:24:31 -0400
Received: by dadg9 with SMTP id g9so5478683dad.12
        for <selinux@tycho.nsa.gov>; Mon, 25 Jun 2012 12:24:29 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 25 Jun 2012 12:24:29 -0700
Message-ID: <CAFftDdpPdN6c6wqJMkj0=GZ_BUcDSPAGkCRgHxPK8G94Ag1tdg@mail.gmail.com>
Subject: Patch for rild denial
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary=e89a8ff24b3b48822804c350eedf
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--e89a8ff24b3b48822804c350eedf
Content-Type: multipart/alternative; boundary=e89a8ff24b3b48822204c350eedd

--e89a8ff24b3b48822204c350eedd
Content-Type: text/plain; charset=ISO-8859-1

This patch fixes rild trying to access the bluetooth efs dir with read
perms.

-- 
Respectfully,

William C Roberts

--e89a8ff24b3b48822204c350eedd
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This patch fixes rild trying to access the bluetooth efs dir with read perm=
s.=A0<br clear=3D"all"><div><br></div>-- <br>Respectfully,<br><br>William C=
 Roberts<br><br><br>

--e89a8ff24b3b48822204c350eedd--

--e89a8ff24b3b48822804c350eedf
Content-Type: application/octet-stream; name="rild_denial.patch"
Content-Disposition: attachment; filename="rild_denial.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h3vxqcqd0

ZGlmZiAtLWdpdCBhL3JpbGQudGUgYi9yaWxkLnRlCmluZGV4IDg1Yzg1YTUuLjAzM2ZjODQgMTAw
NjQ0Ci0tLSBhL3JpbGQudGUKKysrIGIvcmlsZC50ZQpAQCAtMTksNiArMTksNyBAQCBhbGxvdyBy
aWxkIGVmc19maWxlOmRpciBjcmVhdGVfZGlyX3Blcm1zOwogYWxsb3cgcmlsZCBlZnNfZmlsZTpm
aWxlIGNyZWF0ZV9maWxlX3Blcm1zOwogYWxsb3cgcmlsZCBzaGVsbF9leGVjOmZpbGUgcnhfZmls
ZV9wZXJtczsKIGFsbG93IHJpbGQgYmx1ZXRvb3RoX2Vmc19maWxlOmZpbGUgcl9maWxlX3Blcm1z
OworYWxsb3cgcmlsZCBibHVldG9vdGhfZWZzX2ZpbGU6ZGlyIHJfZGlyX3Blcm1zOwogYWxsb3cg
cmlsZCByYWRpb19kYXRhX2ZpbGU6ZGlyIHJfZGlyX3Blcm1zOwogYWxsb3cgcmlsZCByYWRpb19k
YXRhX2ZpbGU6ZmlsZSByd19maWxlX3Blcm1zOwogYWxsb3cgcmlsZCByYWRpb19kZXZpY2U6bG5r
X2ZpbGUgcl9maWxlX3Blcm1zOwo=
--e89a8ff24b3b48822804c350eedf--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
