Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2V9p3ln002735
	for <selinux@tycho.nsa.gov>; Tue, 31 Mar 2009 05:51:03 -0400
Received: from m15-25.126.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id n2V9p1P1002582
	for <selinux@tycho.nsa.gov>; Tue, 31 Mar 2009 09:51:02 GMT
Date: Tue, 31 Mar 2009 17:50:50 +0800 (CST)
From: sixiaolin0 <sixiaolin067@126.com>
To: selinux <selinux@tycho.nsa.gov>
Message-ID: <14175751.701461238493050688.JavaMail.coremail@bj126app25.126.com>
Subject: setools make error
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_186458_21442089.1238493050685"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_186458_21442089.1238493050685
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: quoted-printable


when I am installing the setools the following error occured
I just didn't know how to solve it.
=20

/home/Acelin/tcl8.5.3/generic/regex.h:298: error=A3=BAexpected constructor,=
 destructor, or type conversion before =A1=AEint=A1=AF
/home/Acelin/tcl8.5.3/generic/regex.h:307: error=A3=BAexpected constructor,=
 destructor, or type conversion before =A1=AEint=A1=AF
/home/Acelin/tcl8.5.3/generic/regex.h:309: error=A3=BA=A1=AEMODULE_SCOPE=A1=
=AFnot define a type
/home/Acelin/tcl8.5.3/generic/regex.h:310: error=A3=BA=A1=AEMODULE_SCOPE=A1=
=AFnot define a type
make[5]: *** [libtsefs.so.4.0.2] error 1
make[5]: Leaving directory `/home/Acelin/setools-3.3.5/libsefs/swig/tcl'
make[4]: *** [all] error 2
make[4]: Leaving directory `/home/Acelin/setools-3.3.5/libsefs/swig/tcl'
make[3]: *** [all-recursive] error 1
make[3]: Leaving directory `/home/Acelin/setools-3.3.5/libsefs/swig'
make[2]: *** [all-recursive] error 1
make[2]: Leaving directory `/error 1
make[1]: Leaving directory `/home/Acelin/setools-3.3.5'
make: *** [all] error2

------=_Part_186458_21442089.1238493050685
Content-Type: text/html; charset=gbk
Content-Transfer-Encoding: quoted-printable

<DIV><BR>when I am installing the setools the following error occured</DIV>
<DIV>I just didn't know how to solve it.</DIV>
<DIV>&nbsp;</DIV>
<DIV><BR>/home/Acelin/tcl8.5.3/generic/regex.h:298: error=A3=BAexpected con=
structor, destructor, or type conversion before =A1=AEint=A1=AF<BR>/home/Ac=
elin/tcl8.5.3/generic/regex.h:307: error=A3=BAexpected constructor, destruc=
tor, or type conversion before =A1=AEint=A1=AF<BR>/home/Acelin/tcl8.5.3/gen=
eric/regex.h:309: error=A3=BA=A1=AEMODULE_SCOPE=A1=AFnot define a type</DIV=
>
<DIV>/home/Acelin/tcl8.5.3/generic/regex.h:310: error=A3=BA=A1=AEMODULE_SCO=
PE=A1=AFnot define a type<BR>make[5]: *** [libtsefs.so.4.0.2] error 1<BR>ma=
ke[5]: Leaving directory `/home/Acelin/setools-3.3.5/libsefs/swig/tcl'<BR>m=
ake[4]: *** [all] error 2<BR>make[4]: Leaving directory `/home/Acelin/setoo=
ls-3.3.5/libsefs/swig/tcl'<BR>make[3]: *** [all-recursive] error 1<BR>make[=
3]: Leaving directory `/home/Acelin/setools-3.3.5/libsefs/swig'<BR>make[2]:=
 *** [all-recursive] error 1<BR>make[2]: Leaving directory `/error 1<BR>mak=
e[1]: Leaving directory `/home/Acelin/setools-3.3.5'<BR>make: *** [all] err=
or2<BR></DIV><br><!-- footer --><br><span title=3D"neteasefooter"/><hr/>
<a href=3D"http://email.163.com">=CD=F8=D2=D7=D3=CA=CF=E4=A3=AC=D6=D0=B9=FA=
=B5=DA=D2=BB=B4=F3=B5=E7=D7=D3=D3=CA=BC=FE=B7=FE=CE=F1=C9=CC</a>
</span>
------=_Part_186458_21442089.1238493050685--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
