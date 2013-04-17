Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r3HEoqa7029788
	for <selinux@tycho.nsa.gov>; Wed, 17 Apr 2013 10:50:52 -0400
Received: by mail-pd0-f179.google.com with SMTP id x11so918574pdj.10
        for <selinux@tycho.nsa.gov>; Wed, 17 Apr 2013 07:50:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0971982CF6B9AB418FFD5FEF7F50CB9F05E09E0C@IAD-WPRD-XCHB03.corp.verio.net>
References: <0971982CF6B9AB418FFD5FEF7F50CB9F05E09E0C@IAD-WPRD-XCHB03.corp.verio.net>
Date: Wed, 17 Apr 2013 09:50:49 -0500
Message-ID: <CAFPpqQG+N8UuSZ3cM_iuHM6rXiG6xYBrTzBoX_mHo+BWs2fPew@mail.gmail.com>
Subject: Re: Not sending AVC denials to audit.log
From: Ted Toth <txtoth@gmail.com>
To: Rodney Simioni <rodney.simioni@verio.net>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=047d7bd6c73ea0382504da8f9c64
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--047d7bd6c73ea0382504da8f9c64
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

You might try 'semanage -DB' to disable all of the dontaudits. Run
'semanage -B' to re-enable dontaudits.


On Wed, Apr 17, 2013 at 9:16 AM, Rodney Simioni <rodney.simioni@verio.net>w=
rote:

> Hi,****
>
> ** **
>
> I have a few development tests that are failing when I put the server in
> =91enforcing` mode; however, it=92s not sending AVC denials to the audit.=
log.*
> ***
>
> I have also used =91semanage dontaudit=92 in both on and off position and=
 it=92s
> not generating denials. When I put the server in =91permissive mode`, the
> tests do not fail.****
>
> Why isn=92t selinux sending the denials to the audit.log when the tests
> fail? How do I go about finding the culprit(s) that is/are failing my
> tests? Thanks in advance.****
>
> ** **
>
> Rodney****
>
>
> This email message is intended for the use of the person to whom it has
> been sent, and may contain information that is confidential or legally
> protected. If you are not the intended recipient or have received this
> message in error, you are not authorized to copy, distribute, or otherwis=
e
> use this message or its attachments. Please notify the sender immediately
> by return e-mail and permanently delete this message and any attachments.
> Verio Inc. makes no warranty that this email is error or virus free. Than=
k
> you.
>

--047d7bd6c73ea0382504da8f9c64
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">You might try &#39;semanage -DB&#39; to disable all of the=
 dontaudits. Run &#39;semanage -B&#39; to re-enable dontaudits.</div><div c=
lass=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Wed, Apr 17, 201=
3 at 9:16 AM, Rodney Simioni <span dir=3D"ltr">&lt;<a href=3D"mailto:rodney=
.simioni@verio.net" target=3D"_blank">rodney.simioni@verio.net</a>&gt;</spa=
n> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div lang=3D"EN-US" link=3D"blue" vlink=3D"p=
urple"><div><p class=3D"MsoNormal">Hi,<u></u><u></u></p><p class=3D"MsoNorm=
al"><u></u>=A0<u></u></p>
<p class=3D"MsoNormal">I have a few development tests that are failing when=
 I put the server in =91enforcing` mode; however, it=92s not sending AVC de=
nials to the audit.log.<u></u><u></u></p><p class=3D"MsoNormal">I have also=
 used =91semanage dontaudit=92 in both on and off position and it=92s not g=
enerating denials. When I put the server in =91permissive mode`, the tests =
do not fail.<u></u><u></u></p>
<p class=3D"MsoNormal">Why isn=92t selinux sending the denials to the audit=
.log when the tests fail? How do I go about finding the culprit(s) that is/=
are failing my tests? Thanks in advance.<u></u><u></u></p><p class=3D"MsoNo=
rmal">
<u></u>=A0<u></u></p><p class=3D"MsoNormal">Rodney<u></u><u></u></p></div><=
p></p><p><br>This email message is intended for the use of the person to wh=
om it has been sent, and may contain information that is confidential or le=
gally protected. If you are not the intended recipient or have received thi=
s message in error, you are not authorized to copy, distribute, or otherwis=
e use this message or its attachments. Please notify the sender immediately=
 by return e-mail and permanently delete this message and any attachments. =
Verio Inc. makes no warranty that this email is error or virus free.  Thank=
 you.</p>
</div></blockquote></div><br></div>

--047d7bd6c73ea0382504da8f9c64--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
