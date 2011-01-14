Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p0E9HACc014111
	for <selinux@tycho.nsa.gov>; Fri, 14 Jan 2011 04:17:10 -0500
Received: from mail-gw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p0E9H9Lf003115
	for <selinux@tycho.nsa.gov>; Fri, 14 Jan 2011 09:17:09 GMT
Received: by gwb10 with SMTP id 10so1127843gwb.12
        for <selinux@tycho.nsa.gov>; Fri, 14 Jan 2011 01:17:09 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 14 Jan 2011 14:47:07 +0530
Message-ID: <AANLkTimFDVmgtFCkUEKV=mUDBCOQMX4-owM+gTes0X7v@mail.gmail.com>
Subject: audit function
From: mohit verma <mohit89mlnc@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=002354435c6cf520c90499cae5eb
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--002354435c6cf520c90499cae5eb
Content-Type: text/plain; charset=ISO-8859-1

hi folks,
 can someone  help me understand the use of  the function

 selinux_audit_rule_init
<http://lxr.linux.no/linux+*/+code=selinux_audit_rule_init>(u32
<http://lxr.linux.no/linux+*/+code=u32> field
<http://lxr.linux.no/linux+*/+code=field>, u32
<http://lxr.linux.no/linux+*/+code=u32> op
<http://lxr.linux.no/linux+*/+code=op>, char *rulestr
<http://lxr.linux.no/linux+*/+code=rulestr>, void **vrule
<http://lxr.linux.no/linux+*/+code=vrule>);

  does this function gets initialized at initramfs or later on to log
the data? i mean i am completely blank at this function.

thanks in advance to elaborate on it.


-- 
........................
*MOHIT VERMA*

--002354435c6cf520c90499cae5eb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

hi folks,<br>=A0can someone=A0 help me understand the use of=A0 the functio=
n<br clear=3D"all"><pre class=3D"done" id=3D"5f/55/429799c1b61eae15e12415de=
f3479cb51327_3/2000"> <a href=3D"http://lxr.linux.no/linux+*/+code=3Dselinu=
x_audit_rule_init" class=3D"sref">selinux_audit_rule_init</a>(<a href=3D"ht=
tp://lxr.linux.no/linux+*/+code=3Du32" class=3D"sref">u32</a> <a href=3D"ht=
tp://lxr.linux.no/linux+*/+code=3Dfield" class=3D"sref">field</a>, <a href=
=3D"http://lxr.linux.no/linux+*/+code=3Du32" class=3D"sref">u32</a> <a href=
=3D"http://lxr.linux.no/linux+*/+code=3Dop" class=3D"sref">op</a>, char *<a=
 href=3D"http://lxr.linux.no/linux+*/+code=3Drulestr" class=3D"sref">rulest=
r</a>, void **<a href=3D"http://lxr.linux.no/linux+*/+code=3Dvrule" class=
=3D"sref">vrule</a>);<br>
<br>  does this function gets initialized at initramfs or later on to log t=
he data? i mean i am completely blank at this function.<br><br>thanks in ad=
vance to elaborate on it.<br><br></pre><br>-- <br>........................<=
div>
<i>MOHIT VERMA</i></div><br>

--002354435c6cf520c90499cae5eb--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
