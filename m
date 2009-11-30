Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nAUGDkd7018227
	for <selinux@tycho.nsa.gov>; Mon, 30 Nov 2009 11:13:46 -0500
Received: from trauma.tcs-sec.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id nAUGCdhY011140
	for <selinux@tycho.nsa.gov>; Mon, 30 Nov 2009 16:12:39 GMT
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA71D8.16FE2447"
Subject: RE: MLS support for RHEL5?
Date: Mon, 30 Nov 2009 11:13:43 -0500
Message-ID: <170D6ABBBA770349AA49582A86FCED1501B7F77A@HAVOC.tcs-sec.com>
In-Reply-To: <834B41F71BFB1D4385FC5E62CF526DCE01C59D53@XMBIL123.northgrum.com>
References: <834B41F71BFB1D4385FC5E62CF526DCE01C59D43@XMBIL123.northgrum.com> <170D6ABBBA770349AA49582A86FCED1536F663@HAVOC.tcs-sec.com> <834B41F71BFB1D4385FC5E62CF526DCE01C59D44@XMBIL123.northgrum.com> <170D6ABBBA770349AA49582A86FCED1536F664@HAVOC.tcs-sec.com> <834B41F71BFB1D4385FC5E62CF526DCE01C59D52@XMBIL123.northgrum.com> <170D6ABBBA770349AA49582A86FCED1501B22689@HAVOC.tcs-sec.com> <834B41F71BFB1D4385FC5E62CF526DCE01C59D53@XMBIL123.northgrum.com>
From: <chanson@TrustedCS.com>
To: <Mark.Dyson@ngc.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA71D8.16FE2447
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Mark,
=20
I have not yet seen Eamon's presentation, but this work is on the trunk
of the Xorg and SELinux project from what I recall. I do not believe
this support exists in RHEL 5 as it was released a long time ago when
XACE was not yet included in the X server. I believe the inclusion of
the graphical environment in a newer Fedora release probably still needs
the assistance of a skilled developer with experience in SELinux policy
and X window environment. The implementation of non-graphical
applications straightforward to implement in the MLS environment.
=20
-Chad

________________________________

From: Dyson, Mark L (IS) [mailto:Mark.Dyson@ngc.com]=20
Sent: Wednesday, November 25, 2009 7:52 AM
To: Chad Hanson
Cc: selinux@tycho.nsa.gov
Subject: RE: MLS support for RHEL5?



Chad,

=20

Thanks for the help thus far, and for your patience.  I only have the
one machine available to me, and it came pre-installed both with RHEL5.3
and with a proprietary software suite that is eventually supposed to run
under SELinux (it's a port from Trusted Solaris).  I don't have the RHEL
install media, and installing the software itself (so I'm given to
understand) is a major undertaking, so a re-install is very
unattractive.  I'm also a total neophyte to SELinux, I hadn't even heard
of it before I was asked to look into this, and I'm not a Linux guru by
any stretch of the imagination.

=20

The desired end state is to be running Multi-Level Security, and X
Windowing support is also needed, or so I'm given to understand.  I read
that was problematic in the books I have, but I understood from the
mailing list that Eamon Walsh just delivered a paper that seemed to
indicate it was now supported?  Managing multi-security-level windows in
a session is one of the specific issues I was asked to look into.

=20

Does there exist a laundry list of the packages that need to be
installed?  I'm willing to attempt this, if I could get my hands on
sufficient guidance, and I'd hope not to bend the patience of the folks
on the list (to which I'm going to CC this thread so as to spread the
burden a little).  My current sources of information are two books about
SELinux: The O'Reilly one by Bill McCarty and the Prentice Hall one by
Frank Mayer, Karl MacMillan, and David Caplan.  That's pretty much it.

=20

So as a more general invitation to chime in: is the mapping from Trusted
Solaris to SELunix for an X-windows application a realistic path?  Is
SELinux just not yet ready for such an adventure?

=20

As ever, many thanks,

Mark

=20

=20

=20

From: chanson@TrustedCS.com [mailto:chanson@TrustedCS.com]=20
Sent: Tuesday, November 24, 2009 3:50 PM
To: Dyson, Mark L (IS)
Subject: RE: MLS support for RHEL5?

=20

Hi Mark,

=20

The LSPP functionality can be enabled after installation, however it is
probably not an easy process depending on your experience level with
SELinux. You'll need to manually install the MLS Selinux security policy
rpm. You'll want to make sure the policycoreutils-newrole rpm is
installed. These are few things I can think of to start with. Really
this is just trying to manually add software and change config to the
configuration guide.  Also note the CC LSPP configuration doesn't
support X windows for example so this would need to be disabled as I
don't believe it will start in enforcing mode.

=20

It may be worthwhile to install the LSPP version in a virtual machine
before trying to convert an existing system. This would be a good idea
for the procedure above as well to verify what will happen with the
various steps. The would let you see what the system should like after
the conversion.

=20

Cheers,

-Chad

=20

________________________________

From: Dyson, Mark L (IS) [mailto:Mark.Dyson@ngc.com]=20
Sent: Tuesday, November 24, 2009 11:33 AM
To: Chad Hanson
Subject: RE: MLS support for RHEL5?

Chad,

=20

More newbie questions.  I don't currently have the option of installing
RHEL5, the system came to me pre-installed with the subject application
installed as well.  Is this LSPP something that can be added after the
fact?  The main issue I was having was the MLS and Strict options
weren't available in the SELinux config utility.  Does that mean I'm
hosed unless I can re-install RHEL5 using the lspp kickstart method?

=20

Thanks in advance,

Mark

=20

From: chanson@TrustedCS.com [mailto:chanson@TrustedCS.com]=20
Sent: Monday, November 23, 2009 8:30 AM
To: Dyson, Mark L (IS); selinux@tycho.nsa.gov
Subject: RE: MLS support for RHEL5?

=20

=20

One of the key components in the lspp rpm is the Configuration Guide.
This describes the manner in which you should install RHEL 5 and mostly
isn't hardware specific. The SGI document is for RHEL 5.1. I would
probably start with that. The Dell version should be for 5.3, but I
cannot say for sure.

-Chad

-----Original Message-----
From: Dyson, Mark L (IS) [mailto:Mark.Dyson@ngc.com]
Sent: Mon 11/23/2009 8:17 AM
To: Chad Hanson; selinux@tycho.nsa.gov
Subject: RE: MLS support for RHEL5?

Chad,



Many thanks!  The download link seems to be divided into Dell, HP, IBM
and SGI.  The machine I'm using is a SunFire X2200 (AMD processors).
I'm not sure which of the four available would be the closest match.



Mark



From: chanson@TrustedCS.com [mailto:chanson@TrustedCS.com]
Sent: Monday, November 23, 2009 8:11 AM
To: Dyson, Mark L (IS); selinux@tycho.nsa.gov
Subject: RE: MLS support for RHEL5?



Hi Mark,

MLS is supported in RHEL 5 and been validated against the Common
Criteria in this configuration as well. See the links below.

http://www.niap-ccevs.org/st/vid10125/
http://www.niap-ccevs.org/st/vid10165/
http://www.niap-ccevs.org/st/vid10286/

The supporting software is available for the configuration is available
from Red Hat.
http://ftp.redhat.com/pub/redhat/linux/eal/EAL4_RHEL5/

Cheers,
-Chad


-----Original Message-----
From: owner-selinux@tycho.nsa.gov on behalf of Dyson, Mark L (IS)
Sent: Mon 11/23/2009 7:54 AM
To: selinux@tycho.nsa.gov
Subject: MLS support for RHEL5?

For the project I'm working on the goal is to run a MLS application in a
classified environment and the target architecture is Red Hat Enterprise
Linux 5.  According to the Mayer/MacMillan/Caplan book MLS isn't
supported as of RHEL4.  Can anyone tell me whether that has been
resolved somewhat in RHEL5?  Is there a path to implementing MLS in that
distribution?

Thanks in advance for your help, the information I'm able to turn up
seems dated at best.

Mark





------_=_NextPart_001_01CA71D8.16FE2447
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML xmlns=3D"http://www.w3.org/TR/REC-html40" xmlns:v =3D=20
"urn:schemas-microsoft-com:vml" xmlns:o =3D=20
"urn:schemas-microsoft-com:office:office" xmlns:w =3D=20
"urn:schemas-microsoft-com:office:word" xmlns:m =3D=20
"http://schemas.microsoft.com/office/2004/12/omml"><HEAD><TITLE>RE: MLS =
support for RHEL5?</TITLE>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.5890" name=3DGENERATOR><!--[if !mso]>
<STYLE>v\:* {
	BEHAVIOR: url(#default#VML)
}
o\:* {
	BEHAVIOR: url(#default#VML)
}
w\:* {
	BEHAVIOR: url(#default#VML)
}
.shape {
	BEHAVIOR: url(#default#VML)
}
</STYLE>
<![endif]-->
<STYLE>@font-face {
	font-family: Calibri;
}
@font-face {
	font-family: Tahoma;
}
@page Section1 {size: 8.5in 11.0in; margin: 1.0in 1.0in 1.0in 1.0in; }
P.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: "Times New =
Roman","serif"
}
LI.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: "Times New =
Roman","serif"
}
DIV.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: "Times New =
Roman","serif"
}
A:link {
	COLOR: blue; TEXT-DECORATION: underline; mso-style-priority: 99
}
SPAN.MsoHyperlink {
	COLOR: blue; TEXT-DECORATION: underline; mso-style-priority: 99
}
A:visited {
	COLOR: purple; TEXT-DECORATION: underline; mso-style-priority: 99
}
SPAN.MsoHyperlinkFollowed {
	COLOR: purple; TEXT-DECORATION: underline; mso-style-priority: 99
}
P {
	FONT-SIZE: 12pt; MARGIN-LEFT: 0in; MARGIN-RIGHT: 0in; FONT-FAMILY: =
"Times New Roman","serif"; mso-style-priority: 99; mso-margin-top-alt: =
auto; mso-margin-bottom-alt: auto
}
SPAN.EmailStyle18 {
	COLOR: #1f497d; FONT-FAMILY: "Calibri","sans-serif"; mso-style-type: =
personal
}
SPAN.EmailStyle19 {
	COLOR: #1f497d; FONT-FAMILY: "Calibri","sans-serif"; mso-style-type: =
personal-reply
}
.MsoChpDefault {
	FONT-SIZE: 10pt; mso-style-type: export-only
}
DIV.Section1 {
	page: Section1
}
</STYLE>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]--></HEAD>
<BODY lang=3DEN-US vLink=3Dpurple link=3Dblue>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D437005615-30112009><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Hi Mark,</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D437005615-30112009><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D437005615-30112009><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>I have not yet seen Eamon's presentation, but =
this work is=20
on the trunk of the&nbsp;Xorg and SELinux&nbsp;project from what I=20
recall.&nbsp;I do not believe this support exists in RHEL 5 as it was =
released a=20
long time ago when&nbsp;XACE was not yet included in the&nbsp;X server. =
I=20
believe the inclusion of the graphical environment in a newer=20
Fedora&nbsp;release probably still needs the assistance of a=20
skilled&nbsp;developer with experience in SELinux policy and&nbsp;X =
window=20
environment.&nbsp;The implementation of non-graphical applications=20
straightforward to implement in the MLS environment.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D437005615-30112009><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D437005615-30112009><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>-Chad</FONT></SPAN></DIV><BR>
<DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
<HR tabIndex=3D-1>
<FONT face=3DTahoma size=3D2><B>From:</B> Dyson, Mark L (IS)=20
[mailto:Mark.Dyson@ngc.com] <BR><B>Sent:</B> Wednesday, November 25, =
2009 7:52=20
AM<BR><B>To:</B> Chad Hanson<BR><B>Cc:</B>=20
selinux@tycho.nsa.gov<BR><B>Subject:</B> RE: MLS support for=20
RHEL5?<BR></FONT><BR></DIV>
<DIV></DIV>
<DIV class=3DSection1>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 11pt; COLOR: #1f497d; FONT-FAMILY: =
'Calibri','sans-serif'">Chad,<o:p></o:p></SPAN></P>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 11pt; COLOR: #1f497d; FONT-FAMILY: =
'Calibri','sans-serif'"><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 11pt; COLOR: #1f497d; FONT-FAMILY: =
'Calibri','sans-serif'">Thanks=20
for the help thus far, and for your patience.&nbsp; I only have the one =
machine=20
available to me, and it came pre-installed both with RHEL5.3 and with a=20
proprietary software suite that is eventually supposed to run under =
SELinux=20
(it&#8217;s a port from Trusted Solaris).&nbsp; I don&#8217;t have the =
RHEL install media,=20
and installing the software itself (so I&#8217;m given to understand) is =
a major=20
undertaking, so a re-install is very unattractive.&nbsp; I&#8217;m also =
a total=20
neophyte to SELinux, I hadn&#8217;t even heard of it before I was asked =
to look into=20
this, and I&#8217;m not a Linux guru by any stretch of the=20
imagination.<o:p></o:p></SPAN></P>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 11pt; COLOR: #1f497d; FONT-FAMILY: =
'Calibri','sans-serif'"><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 11pt; COLOR: #1f497d; FONT-FAMILY: =
'Calibri','sans-serif'">The=20
desired end state is to be running Multi-Level Security, and X Windowing =
support=20
is also needed, or so I&#8217;m given to understand.&nbsp; I read that =
was problematic=20
in the books I have, but I understood from the mailing list that Eamon =
Walsh=20
just delivered a paper that seemed to indicate it was now =
supported?&nbsp;=20
Managing multi-security-level windows in a session is one of the =
specific issues=20
I was asked to look into.<o:p></o:p></SPAN></P>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 11pt; COLOR: #1f497d; FONT-FAMILY: =
'Calibri','sans-serif'"><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 11pt; COLOR: #1f497d; FONT-FAMILY: =
'Calibri','sans-serif'">Does=20
there exist a laundry list of the packages that need to be =
installed?&nbsp; I&#8217;m=20
willing to attempt this, if I could get my hands on sufficient guidance, =
and I&#8217;d=20
hope not to bend the patience of the folks on the list (to which =
I&#8217;m going to CC=20
this thread so as to spread the burden a little).&nbsp; My current =
sources of=20
information are two books about SELinux: The O&#8217;Reilly one by Bill =
McCarty and=20
the Prentice Hall one by Frank Mayer, Karl MacMillan, and David =
Caplan.&nbsp;=20
That&#8217;s pretty much it.<o:p></o:p></SPAN></P>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 11pt; COLOR: #1f497d; FONT-FAMILY: =
'Calibri','sans-serif'"><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 11pt; COLOR: #1f497d; FONT-FAMILY: =
'Calibri','sans-serif'">So=20
as a more general invitation to chime in: is the mapping from Trusted =
Solaris to=20
SELunix for an X-windows application a realistic path?&nbsp; Is SELinux =
just not=20
yet ready for such an adventure?<o:p></o:p></SPAN></P>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 11pt; COLOR: #1f497d; FONT-FAMILY: =
'Calibri','sans-serif'"><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 11pt; COLOR: #1f497d; FONT-FAMILY: =
'Calibri','sans-serif'">As=20
ever, many thanks,<o:p></o:p></SPAN></P>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 11pt; COLOR: #1f497d; FONT-FAMILY: =
'Calibri','sans-serif'">Mark<o:p></o:p></SPAN></P>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 11pt; COLOR: #1f497d; FONT-FAMILY: =
'Calibri','sans-serif'"><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 11pt; COLOR: #1f497d; FONT-FAMILY: =
'Calibri','sans-serif'"><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 11pt; COLOR: #1f497d; FONT-FAMILY: =
'Calibri','sans-serif'"><o:p>&nbsp;</o:p></SPAN></P>
<DIV>
<DIV=20
style=3D"BORDER-RIGHT: medium none; PADDING-RIGHT: 0in; BORDER-TOP: =
#b5c4df 1pt solid; PADDING-LEFT: 0in; PADDING-BOTTOM: 0in; BORDER-LEFT: =
medium none; PADDING-TOP: 3pt; BORDER-BOTTOM: medium none">
<P class=3DMsoNormal><B><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
'Tahoma','sans-serif'">From:</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: 'Tahoma','sans-serif'">=20
chanson@TrustedCS.com [mailto:chanson@TrustedCS.com] <BR><B>Sent:</B> =
Tuesday,=20
November 24, 2009 3:50 PM<BR><B>To:</B> Dyson, Mark L =
(IS)<BR><B>Subject:</B>=20
RE: MLS support for RHEL5?<o:p></o:p></SPAN></P></DIV></DIV>
<P class=3DMsoNormal><o:p>&nbsp;</o:p></P>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 10pt; COLOR: blue; FONT-FAMILY: =
'Arial','sans-serif'">Hi=20
Mark,</SPAN><o:p></o:p></P>
<P class=3DMsoNormal>&nbsp;<o:p></o:p></P>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 10pt; COLOR: blue; FONT-FAMILY: =
'Arial','sans-serif'">The LSPP=20
functionality can be enabled after installation, however it is probably =
not an=20
easy process depending on your experience level with SELinux. You'll =
need to=20
manually install the&nbsp;MLS Selinux security policy rpm.&nbsp;You'll =
want to=20
make sure the policycoreutils-newrole rpm is installed. These are few =
things I=20
can think of to start with. Really this is just trying to manually add =
software=20
and change config to the configuration guide.&nbsp; Also note =
the&nbsp;CC LSPP=20
configuration doesn't support X windows for example so this would need =
to be=20
disabled as I don't believe it will start in enforcing=20
mode.</SPAN><o:p></o:p></P>
<P class=3DMsoNormal>&nbsp;<o:p></o:p></P>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 10pt; COLOR: blue; FONT-FAMILY: =
'Arial','sans-serif'">It may=20
be worthwhile to install the LSPP version in a virtual =
machine&nbsp;before=20
trying to convert an existing system. This&nbsp;would be a good =
idea&nbsp;for=20
the procedure above as well to verify what will happen with the various =
steps.=20
The would let you see what the system should like after the=20
conversion.</SPAN><o:p></o:p></P>
<P class=3DMsoNormal>&nbsp;<o:p></o:p></P>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 10pt; COLOR: blue; FONT-FAMILY: =
'Arial','sans-serif'">Cheers,</SPAN><o:p></o:p></P>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 10pt; COLOR: blue; FONT-FAMILY: =
'Arial','sans-serif'">-Chad</SPAN><o:p></o:p></P>
<P class=3DMsoNormal><o:p>&nbsp;</o:p></P>
<DIV class=3DMsoNormal style=3D"TEXT-ALIGN: center" align=3Dcenter>
<HR align=3Dcenter width=3D"100%" SIZE=3D2>
</DIV>
<P class=3DMsoNormal style=3D"MARGIN-BOTTOM: 12pt"><B><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
'Tahoma','sans-serif'">From:</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: 'Tahoma','sans-serif'"> Dyson, =
Mark L (IS)=20
[mailto:Mark.Dyson@ngc.com] <BR><B>Sent:</B> Tuesday, November 24, 2009 =
11:33=20
AM<BR><B>To:</B> Chad Hanson<BR><B>Subject:</B> RE: MLS support for=20
RHEL5?</SPAN><o:p></o:p></P>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 11pt; COLOR: #1f497d; FONT-FAMILY: =
'Calibri','sans-serif'">Chad,<o:p></o:p></SPAN></P>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 11pt; COLOR: #1f497d; FONT-FAMILY: =
'Calibri','sans-serif'"><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 11pt; COLOR: #1f497d; FONT-FAMILY: =
'Calibri','sans-serif'">More=20
newbie questions.&nbsp; I don&#8217;t currently have the option of =
installing RHEL5,=20
the system came to me pre-installed with the subject application =
installed as=20
well.&nbsp; Is this LSPP something that can be added after the =
fact?&nbsp; The=20
main issue I was having was the MLS and Strict options weren&#8217;t =
available in the=20
SELinux config utility.&nbsp; Does that mean I&#8217;m hosed unless I =
can re-install=20
RHEL5 using the lspp kickstart method?<o:p></o:p></SPAN></P>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 11pt; COLOR: #1f497d; FONT-FAMILY: =
'Calibri','sans-serif'"><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 11pt; COLOR: #1f497d; FONT-FAMILY: =
'Calibri','sans-serif'">Thanks=20
in advance,<o:p></o:p></SPAN></P>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 11pt; COLOR: #1f497d; FONT-FAMILY: =
'Calibri','sans-serif'">Mark<o:p></o:p></SPAN></P>
<P class=3DMsoNormal><SPAN=20
style=3D"FONT-SIZE: 11pt; COLOR: #1f497d; FONT-FAMILY: =
'Calibri','sans-serif'"><o:p>&nbsp;</o:p></SPAN></P>
<DIV>
<DIV=20
style=3D"BORDER-RIGHT: medium none; PADDING-RIGHT: 0in; BORDER-TOP: =
#b5c4df 1pt solid; PADDING-LEFT: 0in; PADDING-BOTTOM: 0in; BORDER-LEFT: =
medium none; PADDING-TOP: 3pt; BORDER-BOTTOM: medium none">
<P class=3DMsoNormal><B><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
'Tahoma','sans-serif'">From:</SPAN></B><SPAN=20
style=3D"FONT-SIZE: 10pt; FONT-FAMILY: 'Tahoma','sans-serif'">=20
chanson@TrustedCS.com [mailto:chanson@TrustedCS.com] <BR><B>Sent:</B> =
Monday,=20
November 23, 2009 8:30 AM<BR><B>To:</B> Dyson, Mark L (IS);=20
selinux@tycho.nsa.gov<BR><B>Subject:</B> RE: MLS support for=20
RHEL5?<o:p></o:p></SPAN></P></DIV></DIV>
<P class=3DMsoNormal><o:p>&nbsp;</o:p></P>
<P class=3DMsoNormal><o:p>&nbsp;</o:p></P>
<P style=3D"MARGIN-BOTTOM: 12pt"><SPAN style=3D"FONT-SIZE: 10pt">One of =
the key=20
components in the lspp rpm is the Configuration Guide. This describes =
the manner=20
in which you should install RHEL 5 and mostly isn't hardware specific. =
The SGI=20
document is for RHEL 5.1. I would probably start with that. The Dell =
version=20
should be for 5.3, but I cannot say for =
sure.<BR><BR>-Chad<BR><BR>-----Original=20
Message-----<BR>From: Dyson, Mark L (IS) [<A=20
href=3D"mailto:Mark.Dyson@ngc.com">mailto:Mark.Dyson@ngc.com</A>]<BR>Sent=
: Mon=20
11/23/2009 8:17 AM<BR>To: Chad Hanson; selinux@tycho.nsa.gov<BR>Subject: =
RE: MLS=20
support for RHEL5?<BR><BR>Chad,<BR><BR><BR><BR>Many thanks!&nbsp; The =
download=20
link seems to be divided into Dell, HP, IBM<BR>and SGI.&nbsp; The =
machine I'm=20
using is a SunFire X2200 (AMD processors).<BR>I'm not sure which of the =
four=20
available would be the closest =
match.<BR><BR><BR><BR>Mark<BR><BR><BR><BR>From:=20
chanson@TrustedCS.com [<A=20
href=3D"mailto:chanson@TrustedCS.com">mailto:chanson@TrustedCS.com</A>]<B=
R>Sent:=20
Monday, November 23, 2009 8:11 AM<BR>To: Dyson, Mark L (IS);=20
selinux@tycho.nsa.gov<BR>Subject: RE: MLS support for =
RHEL5?<BR><BR><BR><BR>Hi=20
Mark,<BR><BR>MLS is supported in RHEL 5 and been validated against the=20
Common<BR>Criteria in this configuration as well. See the links =
below.<BR><BR><A=20
href=3D"http://www.niap-ccevs.org/st/vid10125/">http://www.niap-ccevs.org=
/st/vid10125/</A><BR><A=20
href=3D"http://www.niap-ccevs.org/st/vid10165/">http://www.niap-ccevs.org=
/st/vid10165/</A><BR><A=20
href=3D"http://www.niap-ccevs.org/st/vid10286/">http://www.niap-ccevs.org=
/st/vid10286/</A><BR><BR>The=20
supporting software is available for the configuration is =
available<BR>from Red=20
Hat.<BR><A=20
href=3D"http://ftp.redhat.com/pub/redhat/linux/eal/EAL4_RHEL5/">http://ft=
p.redhat.com/pub/redhat/linux/eal/EAL4_RHEL5/</A><BR><BR>Cheers,<BR>-Chad=
<BR><BR><BR>-----Original=20
Message-----<BR>From: owner-selinux@tycho.nsa.gov on behalf of Dyson, =
Mark L=20
(IS)<BR>Sent: Mon 11/23/2009 7:54 AM<BR>To: =
selinux@tycho.nsa.gov<BR>Subject:=20
MLS support for RHEL5?<BR><BR>For the project I'm working on the goal is =
to run=20
a MLS application in a<BR>classified environment and the target =
architecture is=20
Red Hat Enterprise<BR>Linux 5.&nbsp; According to the =
Mayer/MacMillan/Caplan=20
book MLS isn't<BR>supported as of RHEL4.&nbsp; Can anyone tell me =
whether that=20
has been<BR>resolved somewhat in RHEL5?&nbsp; Is there a path to =
implementing=20
MLS in that<BR>distribution?<BR><BR>Thanks in advance for your help, the =

information I'm able to turn up<BR>seems dated at=20
best.<BR><BR>Mark<BR><BR><BR></SPAN><o:p></o:p></P></DIV></BODY></HTML>

------_=_NextPart_001_01CA71D8.16FE2447--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
