Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1EFuemH001193
	for <selinux@tycho.nsa.gov>; Mon, 14 Feb 2011 10:56:40 -0500
Received: from nm14-vm0.bullet.mail.ird.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id p1EFuc2J017488
	for <selinux@tycho.nsa.gov>; Mon, 14 Feb 2011 15:56:39 GMT
Message-ID: <248378.46713.qm@web87007.mail.ird.yahoo.com>
Date: Mon, 14 Feb 2011 15:56:37 +0000 (GMT)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: selinux_file_context_verify function returns wrong value.
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-545106716-1297698997=:46713"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-545106716-1297698997=:46713
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

The selinux_file_context_verify seems to return the wrong value when I know=
 the context of the file and that in the file_contexts file are the same (r=
eturns '1' but according to man page should be '0').
=A0
Looking at the libselinux source code (matchpathcon.c) the line:
=A0
=A0=A0=A0=A0=A0=A0 rc =3D (selinux_file_context_cmp(fcontext, con) =3D=3D 0=
);
=A0
seems the problem.
=A0
I'm using libselinux 2.0.96
=A0
So should it return 0 on match, 1 if contexts are different (or if=A0the fi=
le=A0/=A0file_contexts entries=A0do not exist) and -1 on error.
=A0
And just to clarify the selinux_file_context_cmp function return values:
=A0
=A0=A0=A0=A0 Should it return 0 on match (after the 'user:' portion), 1 if =
contexts do not match and -1 on error.
=A0
Thanks
Richard
=A0
--0-545106716-1297698997=:46713
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;"><DIV>The selinux_file_context_verify seems to=
 return the wrong value when I know the context of the file and that in the=
 file_contexts file are the same (returns '1' but according to man page sho=
uld be '0').</DIV>
<DIV>&nbsp;</DIV>
<DIV>Looking at the libselinux source code (matchpathcon.c) the line:</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc =3D (selinux_file_context_cmp(=
fcontext, con) =3D=3D 0);</DIV>
<DIV>&nbsp;</DIV>
<DIV>seems the problem.</DIV>
<DIV>&nbsp;</DIV>
<DIV>I'm using libselinux 2.0.96</DIV>
<DIV>&nbsp;</DIV>
<DIV>So should it return 0 on match, 1 if contexts are different (or if&nbs=
p;the file&nbsp;/&nbsp;file_contexts entries&nbsp;do not exist) and -1 on e=
rror.</DIV>
<DIV>&nbsp;</DIV>
<DIV>And just to clarify the selinux_file_context_cmp function return value=
s:</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp; Should it return 0 on match (after the 'user:=
' portion), 1 if contexts do not match and -1 on error.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks</DIV>
<DIV>Richard</DIV>
<DIV>&nbsp;</DIV></td></tr></table>
--0-545106716-1297698997=:46713--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
