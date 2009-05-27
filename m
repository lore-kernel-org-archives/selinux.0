Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4RHNXfh030859
	for <selinux@tycho.nsa.gov>; Wed, 27 May 2009 13:23:33 -0400
Received: from AZ25EGS04.gdc4s.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n4RHNME4025693
	for <selinux@tycho.nsa.gov>; Wed, 27 May 2009 17:23:26 GMT
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9DEEF.D398A062"
Subject: Unexpected role change from custom role back to user_r
Date: Wed, 27 May 2009 10:23:18 -0700
Message-ID: <FA8938DBA959E546BF6527F085F22FF804C16BB4@AZ25EXM04.gddsi.com>
From: "West, Gary-P55389" <Gary.West@gdc4s.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9DEEF.D398A062
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I have a custom SELinux policy (based on clip), user and role that will
login through X windows. When the user logs in, see the USER_ROLE_CHANGE
to the desired role. All X clients have the user_r and user_t and not
the custom role and type shown in the USER_ROLE_CHANGE message. Can
someone explain how this secondary role change would happen?


Gary West, CISSP-ISSEP
Software Engineer Staff=20
General Dynamics C4 Systems=20
Information Assurance Division / High Assurance Systems=20
8220 East Roosevelt Street MD R5216=20
Scottsdale, AZ 85257=20
Email: gary.west@gdc4s.com=20
Phone: (480) 441-3421=20
Fax: (480) 441-0843=20
This email message is for the sole use of the intended recipient(s) and
may contain GDC4S confidential or privileged information. Any
unauthorized review, use, disclosure or distribution is prohibited. If
you are not an intended recipient, please contact the sender by reply
email and destroy all copies of the original message NOTE: Regardless of
content, this e-mail shall not operate to bind CSC to any order or other
contract unless pursuant to explicit written agreement or government
initiative expressly permitting the use of e-mail for such purpose



------_=_NextPart_001_01C9DEEF.D398A062
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7654.12">
<TITLE>Unexpected role change from custom role back to user_r</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT FACE=3D"Times New Roman">I have a custom SELinux policy (based =
on clip), user and role that will login through X windows. When the user =
logs in, see the USER_ROLE_CHANGE to the desired role. All X clients =
have the user_r and user_t and not the custom role and type shown in the =
USER_ROLE_CHANGE message. Can someone explain how this secondary role =
change would happen?</FONT></P>
<BR>

<P><B><I><FONT FACE=3D"Times New Roman">Gary West, =
CISSP-ISSEP</FONT></I></B><I></I><BR>
<B></B><B><I><FONT FACE=3D"Times New Roman">Software Engineer =
Staff</FONT></I></B><I></I><FONT FACE=3D"Times New Roman"><BR>
</FONT><B></B><B><I><FONT FACE=3D"Times New Roman">General Dynamics C4 =
Systems</FONT></I></B><I></I><FONT FACE=3D"Times New Roman"><BR>
</FONT><B></B><B><I><FONT FACE=3D"Times New Roman">Information Assurance =
Division / High Assurance Systems</FONT></I></B><I></I><FONT =
FACE=3D"Times New Roman"><BR>
</FONT><B></B><B><I><FONT FACE=3D"Times New Roman">8220 East Roosevelt =
Street MD R5216</FONT></I></B><I></I><FONT FACE=3D"Times New Roman"><BR>
</FONT><B></B><B><I><FONT FACE=3D"Times New Roman">Scottsdale, AZ =
85257</FONT></I></B><I></I><FONT FACE=3D"Times New Roman"><BR>
</FONT><B></B><B><I><FONT FACE=3D"Times New Roman">Email: =
gary.west@gdc4s.com</FONT></I></B><I></I><FONT FACE=3D"Times New =
Roman"><BR>
</FONT><B></B><B><I><FONT FACE=3D"Times New Roman">Phone: (480) =
441-3421</FONT></I></B><I></I><FONT FACE=3D"Times New Roman"><BR>
</FONT><B></B><B><I><FONT FACE=3D"Times New Roman">Fax: (480) =
441-0843</FONT></I></B><I></I><FONT FACE=3D"Times New Roman"> </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">This email message is for the sole use =
of the intended recipient(s) and may contain GDC4S confidential or =
privileged information. Any unauthorized review, use, disclosure or =
distribution is prohibited. If you are not an intended recipient, please =
contact the sender by reply email and destroy all copies of the original =
message NOTE: Regardless of content, this e-mail shall not operate to =
bind CSC to any order or other contract unless pursuant to explicit =
written agreement or government initiative expressly permitting the use =
of e-mail for such purpose</FONT></P>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C9DEEF.D398A062--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
