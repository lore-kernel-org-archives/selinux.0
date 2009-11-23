Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nANDBKGl029240
	for <selinux@tycho.nsa.gov>; Mon, 23 Nov 2009 08:11:20 -0500
Received: from trauma.tcs-sec.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nANDDRDr000472
	for <selinux@tycho.nsa.gov>; Mon, 23 Nov 2009 13:13:27 GMT
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA6C3E.721DE1EE"
Subject: RE: MLS support for RHEL5?
Date: Mon, 23 Nov 2009 08:11:19 -0500
Message-ID: <170D6ABBBA770349AA49582A86FCED1536F663@HAVOC.tcs-sec.com>
References: <834B41F71BFB1D4385FC5E62CF526DCE01C59D43@XMBIL123.northgrum.com>
From: <chanson@TrustedCS.com>
To: <Mark.Dyson@ngc.com>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA6C3E.721DE1EE
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

MLS is supported in RHEL 5 and been validated against the Common =
Criteria in this configuration as well. See the links below.

http://www.niap-ccevs.org/st/vid10125/
http://www.niap-ccevs.org/st/vid10165/
http://www.niap-ccevs.org/st/vid10286/

The supporting software is available for the configuration is available =
from Red Hat.
http://ftp.redhat.com/pub/redhat/linux/eal/EAL4_RHEL5/

Cheers,
-Chad=20


-----Original Message-----
From: owner-selinux@tycho.nsa.gov on behalf of Dyson, Mark L (IS)
Sent: Mon 11/23/2009 7:54 AM
To: selinux@tycho.nsa.gov
Subject: MLS support for RHEL5?
=20
For the project I'm working on the goal is to run a MLS application in a =
classified environment and the target architecture is Red Hat Enterprise =
Linux 5.  According to the Mayer/MacMillan/Caplan book MLS isn't =
supported as of RHEL4.  Can anyone tell me whether that has been =
resolved somewhat in RHEL5?  Is there a path to implementing MLS in that =
distribution? =20

Thanks in advance for your help, the information I'm able to turn up =
seems dated at best.

Mark



------_=_NextPart_001_01CA6C3E.721DE1EE
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7653.38">
<TITLE>RE: MLS support for RHEL5?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi Mark,<BR>
<BR>
MLS is supported in RHEL 5 and been validated against the Common =
Criteria in this configuration as well. See the links below.<BR>
<BR>
<A =
HREF=3D"http://www.niap-ccevs.org/st/vid10125/">http://www.niap-ccevs.org=
/st/vid10125/</A><BR>
<A =
HREF=3D"http://www.niap-ccevs.org/st/vid10165/">http://www.niap-ccevs.org=
/st/vid10165/</A><BR>
<A =
HREF=3D"http://www.niap-ccevs.org/st/vid10286/">http://www.niap-ccevs.org=
/st/vid10286/</A><BR>
<BR>
The supporting software is available for the configuration is available =
from Red Hat.<BR>
<A =
HREF=3D"http://ftp.redhat.com/pub/redhat/linux/eal/EAL4_RHEL5/">http://ft=
p.redhat.com/pub/redhat/linux/eal/EAL4_RHEL5/</A><BR>
<BR>
Cheers,<BR>
-Chad<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: owner-selinux@tycho.nsa.gov on behalf of Dyson, Mark L (IS)<BR>
Sent: Mon 11/23/2009 7:54 AM<BR>
To: selinux@tycho.nsa.gov<BR>
Subject: MLS support for RHEL5?<BR>
<BR>
For the project I'm working on the goal is to run a MLS application in a =
classified environment and the target architecture is Red Hat Enterprise =
Linux 5.&nbsp; According to the Mayer/MacMillan/Caplan book MLS isn't =
supported as of RHEL4.&nbsp; Can anyone tell me whether that has been =
resolved somewhat in RHEL5?&nbsp; Is there a path to implementing MLS in =
that distribution?&nbsp;<BR>
<BR>
Thanks in advance for your help, the information I'm able to turn up =
seems dated at best.<BR>
<BR>
Mark<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01CA6C3E.721DE1EE--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
