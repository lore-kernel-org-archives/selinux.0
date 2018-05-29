Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4TBe2MP013400
 for <selinux@tycho.nsa.gov>; Tue, 29 May 2018 07:40:02 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC13.oob.disa.mil (Postfix) with SMTP id 40wBbd2JW3z25sSK
 for <selinux@tycho.nsa.gov>; Tue, 29 May 2018 11:39:57 +0000 (UTC)
Received: from UPDC3CPA09_EEMSG_MP25.eemsg.mil (unknown [192.168.18.20])
 by UPDCF3IC13.oob.disa.mil (Postfix) with ESMTP id 40wBbc3Vd0z25sRv
 for <selinux@tycho.nsa.gov>; Tue, 29 May 2018 11:39:56 +0000 (UTC)
Received: by mail-vk0-f44.google.com with SMTP id y137-v6so8652372vkd.6
 for <selinux@tycho.nsa.gov>; Tue, 29 May 2018 04:39:55 -0700 (PDT)
MIME-Version: 1.0
From: bhawna goel <bhawnagoel13@gmail.com>
Date: Tue, 29 May 2018 17:09:53 +0530
Message-ID: <CABCvxxp040XVs4K_GGSJeNnTr9sNmeEfw62QoXVjF==xm9bNXg@mail.gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary="00000000000064c3c3056d56b12b"
Subject: Invalid security context while executing audit2alllow.orig
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--00000000000064c3c3056d56b12b
Content-Type: text/plain; charset="UTF-8"

 Hi Team,

We are getting below error while creating policies using command
audit2allow.orig. Can you help in identifying what could be the possible
reason of such error.

Error:
libsepol.context_from_record: invalid security context:
"specialuser_u:system_r:ssh_t:s0"
libsepol.context_from_record: could not create context structure
libsepol.context_from_string: could not create context structure
libsepol.sepol_context_to_sid: could not convert
specialuser_u:system_r:ssh_t:s0 to sid

Thanks in Advance

Regards,
Bhawna

--00000000000064c3c3056d56b12b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">

<div style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:12=
.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norm=
al;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;t=
ext-transform:none;white-space:normal;word-spacing:0px;background-color:rgb=
(255,255,255);text-decoration-style:initial;text-decoration-color:initial">=
Hi Team,</div><div style=3D"color:rgb(34,34,34);font-family:arial,sans-seri=
f;font-size:12.8px;font-style:normal;font-variant-ligatures:normal;font-var=
iant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;tex=
t-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgr=
ound-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-c=
olor:initial"><br></div><div style=3D"color:rgb(34,34,34);font-family:arial=
,sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:norma=
l;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align=
:start;text-indent:0px;text-transform:none;white-space:normal;word-spacing:=
0px;background-color:rgb(255,255,255);text-decoration-style:initial;text-de=
coration-color:initial">We are getting below error while creating policies =
using command audit2allow.orig. Can you help in identifying what could be t=
he possible reason of such error.</div><div style=3D"color:rgb(34,34,34);fo=
nt-family:arial,sans-serif;font-size:12.8px;font-style:normal;font-variant-=
ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:no=
rmal;text-align:start;text-indent:0px;text-transform:none;white-space:norma=
l;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:=
initial;text-decoration-color:initial"><br></div><div style=3D"color:rgb(34=
,34,34);font-family:arial,sans-serif;font-size:12.8px;font-style:normal;fon=
t-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-=
spacing:normal;text-align:start;text-indent:0px;text-transform:none;white-s=
pace:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decorat=
ion-style:initial;text-decoration-color:initial">Error:</div><div style=3D"=
color:rgb(34,34,34);font-family:arial,sans-serif;font-size:12.8px;font-styl=
e:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight=
:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:=
none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);=
text-decoration-style:initial;text-decoration-color:initial"><div>libsepol.=
context_from_record: invalid security context: &quot;specialuser_u:system_r=
:ssh_t:<wbr>s0&quot;</div><div>libsepol.context_from_record: could not crea=
te context structure</div><div>libsepol.context_from_string: could not crea=
te context structure</div><div>libsepol.sepol_context_to_sid: could not con=
vert specialuser_u:system_r:ssh_t:<wbr>s0 to sid</div></div><div style=3D"c=
olor:rgb(34,34,34);font-family:arial,sans-serif;font-size:12.8px;font-style=
:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:=
400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:n=
one;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);t=
ext-decoration-style:initial;text-decoration-color:initial"><br></div><div =
style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:12.8px;=
font-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;fo=
nt-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-t=
ransform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,=
255,255);text-decoration-style:initial;text-decoration-color:initial">Thank=
s in Advance</div>

<br><div>Regards,</div><div>Bhawna</div></div>

--00000000000064c3c3056d56b12b--
