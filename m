Message-ID: <5D201EB6E3041946BC4F8F6A14296132607EE3@svnt4-5.inepar.com.br>
From: "Luis Fernando C. Talora" <luis.talora@iesa.com.br>
To: " (SELinux@tycho.nsa.gov)" <SELinux@tycho.nsa.gov>
Subject: Problem with SELinux and Squid+Winbind+Samba
Date: Tue, 7 Dec 2004 09:19:14 -0200 
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4DC4E.9523D5D0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C4DC4E.9523D5D0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Fellows,
=20
I=B4m trying to put a server running Squid with Microsoft Windows Active
Directory integrated authentication (using Samba 3 and Winbind). When I
start the squid service, I get the following message (it repeats itself m=
any
times):
=20
Dec  7 08:48:56 svux8-250 kernel: audit(1102416536.028:0): avc:  denied  =
{
getattr } for  pid=3D3825 exe=3D/usr/lib/squid/wb_ntlmauth
path=3D/var/run/winbindd/pipe dev=3Dhda7 ino=3D627398
scontext=3Droot:system_r:squid_t tcontext=3Droot:object_r:var_run_t
tclass=3Dsock_file
=20
Since I=B4m new in SELinux, I have no idea how to solve this. Could someo=
ne
give some help?
=20
Thank you all!
=20
Regards,
=20
_____________________
Luis Fernando C. Talora
Support Analyst
=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Esta mensagem pode conter informa=E7=E3o confidencial e/ou privilegiada.
Se voc=EA n=E3o for o destinat=E1rio ou a pessoa autorizada a receber est=
a=20
mensagem, n=E3o dever=E1 utilizar, copiar, alterar, divulgar a informa=E7=
=E3o=20
nela contida ou tomar qualquer a=E7=E3o baseada nessas informa=E7=F5es. S=
e=20
voc=EA recebeu esta mensagem por engano, por favor avise imediatamente=20
o remetente, respondendo o e-mail e em seguida apague-o.Agradecemos=20
sua coopera=E7=E3o.=20

This message may contain confidential and/or privileged information.=20
If you are not the addressee or authorized to receive this for the=20
addressee, you must not use, copy, disclose, change, take any action=20
based on this message or any information herein. If you have received
this message in error, please advise the sender immediately by reply=20
e-mail and delete this message. Thank you for your cooperation.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
------_=_NextPart_001_01C4DC4E.9523D5D0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Diso-885=
9-1">


<META content=3D"MSHTML 6.00.3790.0" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D337440611-07122004><FONT face=3DArial=20
size=3D2>Fellows,</FONT></SPAN></DIV>
<DIV><SPAN class=3D337440611-07122004><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D337440611-07122004><FONT face=3DArial size=3D2>I=B4m t=
rying to put a=20
server running Squid with Microsoft Windows Active Directory integrated=20
authentication (using Samba 3 and Winbind). When I start the squid servic=
e, I=20
get the following message (it repeats itself many times):</FONT></SPAN></=
DIV>
<DIV><SPAN class=3D337440611-07122004><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D337440611-07122004><FONT face=3DArial size=3D2>Dec&nbs=
p; 7 08:48:56=20
svux8-250 kernel: audit(1102416536.028:0): avc:&nbsp; denied&nbsp; { geta=
ttr }=20
for&nbsp; pid=3D3825 exe=3D/usr/lib/squid/wb_ntlmauth path=3D/var/run/win=
bindd/pipe=20
dev=3Dhda7 ino=3D627398 scontext=3Droot:system_r:squid_t=20
tcontext=3Droot:object_r:var_run_t tclass=3Dsock_file</FONT></SPAN></DIV>
<DIV><SPAN class=3D337440611-07122004><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D337440611-07122004><FONT face=3DArial size=3D2>Since I=
=B4m new in=20
SELinux, I have no idea how to solve this. Could someone give some=20
help?</FONT></SPAN></DIV>
<DIV><SPAN class=3D337440611-07122004><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D337440611-07122004><FONT face=3DArial size=3D2>Thank y=
ou=20
all!</FONT></SPAN></DIV>
<DIV><SPAN class=3D337440611-07122004><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D337440611-07122004><FONT face=3DArial=20
size=3D2>Regards,</FONT></SPAN></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2>
<DIV align=3Dleft><FONT face=3DArial size=3D2>_____________________</FONT=
></DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2>Luis Fernando C. Talora</FO=
NT></DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2>Support Analyst</FONT></DIV=
>
<DIV align=3Dleft><FONT face=3DArial=20
size=3D2></FONT>&nbsp;</DIV></FONT></DIV>
<FONT SIZE=3D3 COLOR=3DBLUE><PRE>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Esta mensagem pode conter informa=E7=E3o confidencial e/ou privilegiada.
Se voc=EA n=E3o for o destinat=E1rio ou a pessoa autorizada a receber est=
a=20
mensagem, n=E3o dever=E1 utilizar, copiar, alterar, divulgar a informa=E7=
=E3o=20
nela contida ou tomar qualquer a=E7=E3o baseada nessas informa=E7=F5es. S=
e=20
voc=EA recebeu esta mensagem por engano, por favor avise imediatamente=20
o remetente, respondendo o e-mail e em seguida apague-o.Agradecemos=20
sua coopera=E7=E3o.=20

This message may contain confidential and/or privileged information.=20
If you are not the addressee or authorized to receive this for the=20
addressee, you must not use, copy, disclose, change, take any action=20
based on this message or any information herein. If you have received
this message in error, please advise the sender immediately by reply=20
e-mail and delete this message. Thank you for your cooperation.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
</PRE></FONT>
</BODY></HTML>
------_=_NextPart_001_01C4DC4E.9523D5D0--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
