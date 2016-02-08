Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u18GcMvH024528
 for <selinux@tycho.nsa.gov>; Mon, 8 Feb 2016 11:38:23 -0500
Received: by mail-wm0-f45.google.com with SMTP id c200so24103287wme.0
 for <selinux@tycho.nsa.gov>; Mon, 08 Feb 2016 08:38:01 -0800 (PST)
MIME-Version: 1.0
From: Mark Steele <mark@control-alt-del.org>
Date: Mon, 8 Feb 2016 11:37:20 -0500
Message-ID: <CAB5=j_pWWH=qEpDoFF6NZgo9hxkVG6neuJ0R9E7oWT8TX3qYYg@mail.gmail.com>
Subject: Policy feedback
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a114435e8f22627052b44d290
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114435e8f22627052b44d290
Content-Type: text/plain; charset=UTF-8

Hello list,

I've written my first SELinux policy, and was wondering if this was the
right place to ask for feedback for newly written policy. Apologies in
advance if it isn't.

The policy can be viewed here:

https://github.com/marksteele/cinched/tree/master/policy

The goal of the policy is to confine a service into a domain, and lock it
down as much as possible.

What I appear to have accomplished thus far is that only the sysadm_t type
is allowed to transition into the domain via an executable, and only via
that transition can the service access it's files.

If anyone spots something that looks off, please feel free to get in touch.

Regards,

Mark Steele
CISSP, GPEN, GCIA, CSM
mark@control-alt-del.org

LinkedIn: https://ca.linkedin.com/in/markrsteele
Github: https://github.com/marksteele
Personal: http://www.control-alt-del.org

--001a114435e8f22627052b44d290
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello list,<div><br></div><div>I&#39;ve written my first S=
ELinux policy, and was wondering if this was the right place to ask for fee=
dback for newly written policy. Apologies in advance if it isn&#39;t.</div>=
<div><br></div><div>The policy can be viewed here:</div><div><br></div><div=
><a href=3D"https://github.com/marksteele/cinched/tree/master/policy">https=
://github.com/marksteele/cinched/tree/master/policy</a><br></div><div><br><=
/div><div>The goal of the policy is to confine a service into a domain, and=
 lock it down as much as possible.=C2=A0</div><div><br></div><div>What I ap=
pear to have accomplished thus far is that only the sysadm_t type is allowe=
d to transition into the domain via an executable, and only via that transi=
tion can the service access it&#39;s files.</div><div><br></div><div>If any=
one spots something that looks off, please feel free to get in touch.</div>=
<div><br></div><div>Regards,</div><div><br clear=3D"all"><div><div class=3D=
"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div s=
tyle=3D"font-size:small">Mark Steele</div><div style=3D"font-size:small">CI=
SSP, GPEN, GCIA, CSM</div><div style=3D"font-size:small"><a href=3D"mailto:=
mark@control-alt-del.org" target=3D"_blank">mark@control-alt-del.org</a><br=
></div><div style=3D"font-size:small"><br></div><div><font size=3D"2">Linke=
dIn: <a href=3D"https://ca.linkedin.com/in/markrsteele" target=3D"_blank">h=
ttps://ca.linkedin.com/in/markrsteele</a></font><br></div><div style=3D"fon=
t-size:small">Github: <a href=3D"https://github.com/marksteele" target=3D"_=
blank">https://github.com/marksteele</a></div><div><font size=3D"2">Persona=
l: <a href=3D"http://www.control-alt-del.org" target=3D"_blank">http://www.=
control-alt-del.org</a></font></div><div style=3D"font-size:small"></div></=
div></div></div></div></div>
</div></div>

--001a114435e8f22627052b44d290--
