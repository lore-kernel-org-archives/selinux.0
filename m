Message-ID: <00f301c1149a$e3a31740$020144c0@windows>
From: "Eric Peters" <eric@peters.org>
To: <SELinux@tycho.nsa.gov>
Subject: verbose make relabel/RedHat 7.1 install
Date: Tue, 24 Jul 2001 16:46:33 -0700
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00F0_01C11460.3263ECF0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_00F0_01C11460.3263ECF0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

So I'm using RedHat 7.1 - fresh system install and after I =
tools/build-kernel tools/build-apps, install-kernel and install-apps, =
get lilo setup n crap I login and I get the option to get in via =
sysadm_r and sysadm_t so I do that then cd =
/usr/local/build/slinux/policy, and wallah:

# make relabel
[ .... ]
./setfiles:    labeling files under /
./setfiles:    conflicting specifications for /sbin/e2fsck and =
/sbin/fsck.ext3, using system_u:object_r:fsadm_exec_t
avc: denied { transition } for pid =3D 728 =
exe=3D/usr/local/build/slinux/policy/setfiles path=3D/sbin/e2fsck =
dev=3D03:01 ino=3D109997
    scontext=3Dsystem_u:object_r:sbin_t
    tcontext=3Dsystem_u:object_r:fsadm_exec_t
    tclass=3Dfile
./setfiles:    unable to relable /sbin/e2fsck to =
system_u:object_r:fsadm_exec_t
make: *** [relabel] Error 1
#


I havn't touched the file_context file or pretty much anything other =
than the three files in /www/security/ and the one users file

Any suggestions?

Thanks

Eric

------=_NextPart_000_00F0_01C11460.3263ECF0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 5.50.4616.200" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>So I'm using RedHat 7.1 - fresh system =
install and=20
after I tools/build-kernel tools/build-apps, install-kernel and =
install-apps,=20
get lilo setup n crap I login and I get the option to get in via =
sysadm_r and=20
sysadm_t so I do that then cd /usr/local/build/slinux/policy, and=20
wallah:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2># make relabel</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>[ .... ]</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>./setfiles:&nbsp;&nbsp;&nbsp; labeling =
files under=20
/</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>./setfiles:&nbsp;&nbsp;&nbsp; =
conflicting=20
specifications for /sbin/e2fsck and /sbin/fsck.ext3, using=20
system_u:object_r:fsadm_exec_t</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>avc: denied { transition } for pid =3D =
728=20
exe=3D/usr/local/build/slinux/policy/setfiles path=3D/sbin/e2fsck =
dev=3D03:01=20
ino=3D109997</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp;=20
scontext=3Dsystem_u:object_r:sbin_t</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp;=20
tcontext=3Dsystem_u:object_r:fsadm_exec_t</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp; =
tclass=3Dfile</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>./setfiles:&nbsp;&nbsp;&nbsp; unable to =
relable=20
/sbin<FONT color=3D#000000 size=3D2>/e2fsck to=20
system_u:object_r:fsadm_exec_t</FONT></FONT></DIV>
<DIV><FONT face=3DArial size=3D2>make: *** [relabel] Error =
1</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>#</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I havn't touched the file_context file =
or pretty=20
much anything other than the three files in /www/security/ and the one =
users=20
file</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Any suggestions?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Eric</FONT></DIV></BODY></HTML>

------=_NextPart_000_00F0_01C11460.3263ECF0--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
