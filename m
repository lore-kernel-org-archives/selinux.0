Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q5PJgWR7024524
	for <selinux@tycho.nsa.gov>; Mon, 25 Jun 2012 15:42:32 -0400
Received: by pbbrr13 with SMTP id rr13so6759799pbb.12
        for <selinux@tycho.nsa.gov>; Mon, 25 Jun 2012 12:42:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFftDdpyqOBEq8cw9S2R2J2y1WKR976j_Md5o7-cFChauDTCQw@mail.gmail.com>
References: <CAFftDdpyqOBEq8cw9S2R2J2y1WKR976j_Md5o7-cFChauDTCQw@mail.gmail.com>
Date: Mon, 25 Jun 2012 12:42:30 -0700
Message-ID: <CAFftDdqzEUq8Om_KdeCUF1+LW_+2d5y_NkC+dw-cFNc36v85TA@mail.gmail.com>
Subject: Re: Patch for mmac denials
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary=e89a8ff244cfb96d1704c3512e7c
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--e89a8ff244cfb96d1704c3512e7c
Content-Type: multipart/alternative; boundary=e89a8ff244cfb96d1204c3512e7a

--e89a8ff244cfb96d1204c3512e7a
Content-Type: text/plain; charset=ISO-8859-1

Oops I wanted rw not just w.

media app should have rw access to sdcard dir and files.

On Mon, Jun 25, 2012 at 12:25 PM, William Roberts
<bill.c.roberts@gmail.com>wrote:

> I got some denials on media apps. After looking through I think media apps
> need to be able to write stored content to the sdcard.
>
> --
> Respectfully,
>
> William C Roberts
>
>
>


-- 
Respectfully,

William C Roberts

--e89a8ff244cfb96d1204c3512e7a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Oops I wanted rw not just w.<div><br></div><div>media app should have rw ac=
cess to sdcard dir and files.<br><br><div class=3D"gmail_quote">On Mon, Jun=
 25, 2012 at 12:25 PM, William Roberts <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:bill.c.roberts@gmail.com" target=3D"_blank">bill.c.roberts@gmail.com</a=
>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">I got some denials on media apps. After look=
ing through I think media apps need to be able to write stored content to t=
he sdcard.<span class=3D"HOEnZb"><font color=3D"#888888"><br clear=3D"all">
<div><br></div>-- <br>Respectfully,<br><br>William C Roberts<br><br><br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r>Respectfully,<br><br>William C Roberts<br><br><br>
</div>

--e89a8ff244cfb96d1204c3512e7a--

--e89a8ff244cfb96d1704c3512e7c
Content-Type: application/octet-stream; name="media_app_mmac_denials.patch"
Content-Disposition: attachment; filename="media_app_mmac_denials.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h3vydkwk1

ZGlmZiAtLWdpdCBhL2FwcC50ZSBiL2FwcC50ZQppbmRleCA5MTc2MDEzLi4wOGI2ZGExIDEwMDY0
NAotLS0gYS9hcHAudGUKKysrIGIvYXBwLnRlCkBAIC00MCw4ICs0MCw4IEBAIGFsbG93IG1lZGlh
X2FwcCBtdHBfZGV2aWNlOmNocl9maWxlIHJ3X2ZpbGVfcGVybXM7CiBhbGxvdyBtZWRpYV9hcHAg
Y2FjaGVfZmlsZTpkaXIgcndfZGlyX3Blcm1zOwogYWxsb3cgbWVkaWFfYXBwIGNhY2hlX2ZpbGU6
ZmlsZSBjcmVhdGVfZmlsZV9wZXJtczsKICMgQWNjZXNzIHNkY2FyZC4KLWFsbG93IG1lZGlhX2Fw
cCBzZGNhcmQ6ZGlyIHJfZGlyX3Blcm1zOwotYWxsb3cgbWVkaWFfYXBwIHNkY2FyZDpmaWxlIHJf
ZmlsZV9wZXJtczsKK2FsbG93IG1lZGlhX2FwcCBzZGNhcmQ6ZGlyIHJ3X2Rpcl9wZXJtczsKK2Fs
bG93IG1lZGlhX2FwcCBzZGNhcmQ6ZmlsZSByd19maWxlX3Blcm1zOwogCiAjIEFwcHMgc2lnbmVk
IHdpdGggdGhlIHNoYXJlZCBrZXkuCiB0eXBlIHNoYXJlZF9hcHAsIGRvbWFpbjsK
--e89a8ff244cfb96d1704c3512e7c--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
