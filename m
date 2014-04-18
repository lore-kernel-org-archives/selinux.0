Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3IKmw5W004439
 for <selinux@tycho.nsa.gov>; Fri, 18 Apr 2014 16:48:58 -0400
Received: by mail-pb0-f47.google.com with SMTP id up15so1791315pbc.34
 for <selinux@tycho.nsa.gov>; Fri, 18 Apr 2014 13:48:41 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 18 Apr 2014 22:48:41 +0200
Message-ID: <CAHjP7BFiN5GjUwDfceL9uJdOMwBFQz68ra7=M8yyRGBsKHLxsw@mail.gmail.com>
Subject: LIbselinux: Correctness of context decision, how its made?
From: Rastislav Hepner <rastislav.hepner@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=047d7bd75d7c57ec5404f75746a7
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--047d7bd75d7c57ec5404f75746a7
Content-Type: text/plain; charset=UTF-8

Hello guys,

I'm doing research regarding testing of some libselinux functions via
python bindings.
I just got stucked on logic, which is behind exception:

OSError: [Errno 22] Invalid argument

after I'm calling it setfscreatecon_raw("wrongContext").
I've tried to check setfscreatecon.c but i dont see anything related to it.
and now im out of ideas where to find it.

Could you please direct me to this logic in some source file
 or explain how the decision (whether context is right or not) is made?

*Rastislav Hepner*

--047d7bd75d7c57ec5404f75746a7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello guys,<div><br></div><div>I&#39;m doing research rega=
rding testing of some libselinux functions via python bindings.<br></div><d=
iv>I just got stucked on logic, which is behind exception:</div><div><br></=
div>
<div>OSError: [Errno 22] Invalid argument</div><div><br></div><div>after I&=
#39;m calling it setfscreatecon_raw(&quot;wrongContext&quot;).</div><div>I&=
#39;ve tried to check setfscreatecon.c but i dont see anything related to i=
t.</div>
<div>and now im out of ideas where to find it.</div><div><br></div><div>Cou=
ld you please direct me to this logic in some source file</div><div>=C2=A0o=
r explain how the decision (whether context is right or not) is made?</div>=
<div>
<br></div><div><i style=3D"font-family:tahoma,sans-serif;background-color:r=
gb(255,102,102)"><span></span><span><span style=3D"background-color:rgb(255=
,255,255)"><span style=3D"background-color:rgb(0,0,0)"><span style=3D"backg=
round-color:rgb(255,255,255)">Rastislav Hepner</span></span></span></span><=
/i><br>

</div></div>

--047d7bd75d7c57ec5404f75746a7--
