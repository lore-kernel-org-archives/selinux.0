Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q5PJPZ7T023684
	for <selinux@tycho.nsa.gov>; Mon, 25 Jun 2012 15:25:35 -0400
Received: by dadg9 with SMTP id g9so5479976dad.12
        for <selinux@tycho.nsa.gov>; Mon, 25 Jun 2012 12:25:35 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 25 Jun 2012 12:25:34 -0700
Message-ID: <CAFftDdpyqOBEq8cw9S2R2J2y1WKR976j_Md5o7-cFChauDTCQw@mail.gmail.com>
Subject: Patch for mmac denials
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary=e89a8ff24b3b3068ce04c350f2f5
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--e89a8ff24b3b3068ce04c350f2f5
Content-Type: multipart/alternative; boundary=e89a8ff24b3b3068ca04c350f2f3

--e89a8ff24b3b3068ca04c350f2f3
Content-Type: text/plain; charset=ISO-8859-1

I got some denials on media apps. After looking through I think media apps
need to be able to write stored content to the sdcard.

-- 
Respectfully,

William C Roberts

--e89a8ff24b3b3068ca04c350f2f3
Content-Type: text/html; charset=ISO-8859-1

I got some denials on media apps. After looking through I think media apps need to be able to write stored content to the sdcard.<br clear="all"><div><br></div>-- <br>Respectfully,<br><br>William C Roberts<br><br><br>

--e89a8ff24b3b3068ca04c350f2f3--

--e89a8ff24b3b3068ce04c350f2f5
Content-Type: application/octet-stream; name="media_app_mmac_denials.patch"
Content-Disposition: attachment; filename="media_app_mmac_denials.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h3vxrt290

ZGlmZiAtLWdpdCBhL2FwcC50ZSBiL2FwcC50ZQppbmRleCBjYzEzNTdlLi45MTc2MDEzIDEwMDY0
NAotLS0gYS9hcHAudGUKKysrIGIvYXBwLnRlCkBAIC00MCw4ICs0MCw4IEBAIGFsbG93IG1lZGlh
X2FwcCBtdHBfZGV2aWNlOmNocl9maWxlIHJ3X2ZpbGVfcGVybXM7CiBhbGxvdyBtZWRpYV9hcHAg
Y2FjaGVfZmlsZTpkaXIgcndfZGlyX3Blcm1zOwogYWxsb3cgbWVkaWFfYXBwIGNhY2hlX2ZpbGU6
ZmlsZSBjcmVhdGVfZmlsZV9wZXJtczsKICMgQWNjZXNzIHNkY2FyZC4KLWFsbG93IG1lZGlhX2Fw
cCBzZGNhcmQ6ZGlyIHdfZGlyX3Blcm1zOwotYWxsb3cgbWVkaWFfYXBwIHNkY2FyZDpmaWxlIHdf
ZmlsZV9wZXJtczsKK2FsbG93IG1lZGlhX2FwcCBzZGNhcmQ6ZGlyIHJfZGlyX3Blcm1zOworYWxs
b3cgbWVkaWFfYXBwIHNkY2FyZDpmaWxlIHJfZmlsZV9wZXJtczsKIAogIyBBcHBzIHNpZ25lZCB3
aXRoIHRoZSBzaGFyZWQga2V5LgogdHlwZSBzaGFyZWRfYXBwLCBkb21haW47Cg==
--e89a8ff24b3b3068ce04c350f2f5--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
