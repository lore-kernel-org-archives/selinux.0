Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8QDtuvI004279
 for <selinux@tycho.nsa.gov>; Wed, 26 Sep 2018 09:56:01 -0400
Date: Wed, 26 Sep 2018 13:55:33 +0000 (UTC)
From: sajjad ahmed <sajjad_ahmed782@yahoo.com>
To: selinux@tycho.nsa.gov
Message-ID: <1622272321.2871056.1537970133583@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_Part_2871055_1999334878.1537970133581"
References: <1622272321.2871056.1537970133583.ref@mail.yahoo.com>
Subject: setfiles rootfs labeling
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

------=_Part_2871055_1999334878.1537970133581
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,
I'm trying to use the setfiles utility (v 2.7) from policycoreutils to labe=
l rootfs, it seems like setfiles exclude all the directories straight away =
and labels nothing. I tried an older version (< 2.6) that works fine.=C2=A0=
I'm using the yocto project to build packages and using native setfiles uti=
lity to "label rootfs on the build=C2=A0system". Is it utility who is not d=
oing what is supposed to?
I'm using the following command to label rootfs,=C2=A0sudo=C2=A0setfiles=C2=
=A0-v -r /tmp/sid/ /etc/selinux/refpolicy/contexts/files/file_contexts=C2=
=A0/tmp/sid/


- Sajjad Ahmed
------=_Part_2871055_1999334878.1537970133581
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div>Hi all,</div><div><br></div><div><span>I'm tr=
ying to use the setfiles utility (v 2.7) from policycoreutils to label root=
fs, it seems like setfiles exclude all the directories straight away and la=
bels nothing. I tried an older version (&lt; 2.6) that works fine.&nbsp;</s=
pan>I'm using the yocto project to build packages and using native setfiles=
 utility to "label rootfs on the build&nbsp;system". Is it utility who is n=
ot doing what is supposed to?</div><div><br></div><div><span>I'm using the =
following command to label rootfs,&nbsp;</span></div><div><span><span><i><s=
pan class=3D"ydp51b10852SpellingError ydp51b10852SCXO200010408" style=3D"ma=
rgin: 0px; padding: 0px; border-bottom: 1px solid transparent; color: rgb(0=
, 0, 0); font-family: Calibri, sans-serif; font-size: 14.6667px; background=
-color: inherit;">sudo</span><span class=3D"ydp51b10852NormalTextRun ydp51b=
10852SCXO200010408" style=3D"margin: 0px; padding: 0px; color: rgb(0, 0, 0)=
; font-family: Calibri, sans-serif; font-size: 14.6667px; background-color:=
 inherit;">&nbsp;</span><span class=3D"ydp51b10852SpellingError ydp51b10852=
SCXO200010408" style=3D"margin: 0px; padding: 0px; border-bottom: 1px solid=
 transparent; color: rgb(0, 0, 0); font-family: Calibri, sans-serif; font-s=
ize: 14.6667px; background-color: inherit;">setfiles</span><span class=3D"y=
dp51b10852NormalTextRun ydp51b10852SCXO200010408" style=3D"margin: 0px; pad=
ding: 0px; color: rgb(0, 0, 0); font-family: Calibri, sans-serif; font-size=
: 14.6667px; background-color: inherit;">&nbsp;-v -r /</span><span class=3D=
"ydp51b10852SpellingError ydp51b10852SCXO200010408" style=3D"margin: 0px; p=
adding: 0px; border-bottom: 1px solid transparent; color: rgb(0, 0, 0); fon=
t-family: Calibri, sans-serif; font-size: 14.6667px; background-color: inhe=
rit;">tmp</span><span class=3D"ydp51b10852NormalTextRun ydp51b10852SCXO2000=
10408" style=3D"margin: 0px; padding: 0px; color: rgb(0, 0, 0); font-family=
: Calibri, sans-serif; font-size: 14.6667px; background-color: inherit;">/<=
/span><span class=3D"ydp51b10852SpellingError ydp51b10852SCXO200010408" sty=
le=3D"margin: 0px; padding: 0px; border-bottom: 1px solid transparent; colo=
r: rgb(0, 0, 0); font-family: Calibri, sans-serif; font-size: 14.6667px; ba=
ckground-color: inherit;">sid</span><span class=3D"ydp51b10852NormalTextRun=
 ydp51b10852SCXO200010408" style=3D"margin: 0px; padding: 0px; color: rgb(0=
, 0, 0); font-family: Calibri, sans-serif; font-size: 14.6667px; background=
-color: inherit;">/ /etc/</span><span class=3D"ydp51b10852SpellingError ydp=
51b10852SCXO200010408" style=3D"margin: 0px; padding: 0px; border-bottom: 1=
px solid transparent; color: rgb(0, 0, 0); font-family: Calibri, sans-serif=
; font-size: 14.6667px; background-color: inherit;">selinux</span><span cla=
ss=3D"ydp51b10852NormalTextRun ydp51b10852SCXO200010408" style=3D"margin: 0=
px; padding: 0px; color: rgb(0, 0, 0); font-family: Calibri, sans-serif; fo=
nt-size: 14.6667px; background-color: inherit;">/</span><span class=3D"ydp5=
1b10852SpellingError ydp51b10852SCXO200010408" style=3D"margin: 0px; paddin=
g: 0px; border-bottom: 1px solid transparent; color: rgb(0, 0, 0); font-fam=
ily: Calibri, sans-serif; font-size: 14.6667px; background-color: inherit;"=
>refpolicy</span><span class=3D"ydp51b10852NormalTextRun ydp51b10852SCXO200=
010408" style=3D"margin: 0px; padding: 0px; color: rgb(0, 0, 0); font-famil=
y: Calibri, sans-serif; font-size: 14.6667px; background-color: inherit;">/=
contexts/files/</span><span class=3D"ydp51b10852SpellingError ydp51b10852SC=
XO200010408" style=3D"margin: 0px; padding: 0px; border-bottom: 1px solid t=
ransparent; color: rgb(0, 0, 0); font-family: Calibri, sans-serif; font-siz=
e: 14.6667px; background-color: inherit;">file_contexts</span><span class=
=3D"ydp51b10852NormalTextRun ydp51b10852SCXO200010408" style=3D"margin: 0px=
; padding: 0px; color: rgb(0, 0, 0); font-family: Calibri, sans-serif; font=
-size: 14.6667px; background-color: inherit;">&nbsp;/</span><span class=3D"=
ydp51b10852SpellingError ydp51b10852SCXO200010408" style=3D"margin: 0px; pa=
dding: 0px; border-bottom: 1px solid transparent; color: rgb(0, 0, 0); font=
-family: Calibri, sans-serif; font-size: 14.6667px; background-color: inher=
it;">tmp</span><span class=3D"ydp51b10852NormalTextRun ydp51b10852SCXO20001=
0408" style=3D"margin: 0px; padding: 0px; color: rgb(0, 0, 0); font-family:=
 Calibri, sans-serif; font-size: 14.6667px; background-color: inherit;">/</=
span><span class=3D"ydp51b10852SpellingError ydp51b10852SCXO200010408" styl=
e=3D"margin: 0px; padding: 0px; border-bottom: 1px solid transparent; color=
: rgb(0, 0, 0); font-family: Calibri, sans-serif; font-size: 14.6667px; bac=
kground-color: inherit;">sid</span><span class=3D"ydp51b10852NormalTextRun =
ydp51b10852SCXO200010408" style=3D"margin: 0px; padding: 0px; color: rgb(0,=
 0, 0); font-family: Calibri, sans-serif; font-size: 14.6667px; background-=
color: inherit;">/</span></i></span><br></span></div><div><span><span><i><s=
pan class=3D"ydp51b10852NormalTextRun ydp51b10852SCXO200010408" style=3D"ma=
rgin: 0px; padding: 0px; color: rgb(0, 0, 0); font-family: Calibri, sans-se=
rif; font-size: 14.6667px; background-color: inherit;"><br></span></i></spa=
n></span></div><div><br></div><div><font face=3D"Calibri, sans-serif"><span=
 style=3D"font-size: 14.6667px;">- Sajjad Ahmed</span></font></div><div cla=
ss=3D"ydp41634a67yahoo-style-wrap" style=3D"font-family:Helvetica Neue, Hel=
vetica, Arial, sans-serif;font-size:13px;"></div></body></html>
------=_Part_2871055_1999334878.1537970133581--
