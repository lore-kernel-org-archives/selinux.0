Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8AHFeib011952
 for <selinux@tycho.nsa.gov>; Mon, 10 Sep 2018 13:15:40 -0400
Received: by mail-wm0-f51.google.com with SMTP id f21-v6so22333471wmc.5
 for <selinux@tycho.nsa.gov>; Mon, 10 Sep 2018 10:13:44 -0700 (PDT)
MIME-Version: 1.0
From: Ted Toth <txtoth@gmail.com>
Date: Mon, 10 Sep 2018 12:13:30 -0500
Message-ID: <CAFPpqQEgS9mqEZcMCn=3AGYer_5WBQmQdqjsMC=OJqtgwp96cQ@mail.gmail.com>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="0000000000009b4ac90575877a60"
Subject: MLS dominance check behavior on el7
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--0000000000009b4ac90575877a60
Content-Type: text/plain; charset="UTF-8"

We currently have code running on el6 that does a MLS dominance check by
calling security_compute_av_raw with the security object class
SECCLASS_CONTEXT with permission CONTEXT__CONTAINS as you can see in the
python code below. When I run this code on el6 s1 dominates s0 however when
I run the same code on el7 s1 does not dominate s0. On both systems the
file read dominance check works as expected. Can anyone help me understand
why the context contains check does not work the same on both systems?

Ted

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

import selinux

SECCLASS_CONTEXT = selinux.string_to_security_class("context")
CONTEXT__CONTAINS = selinux.string_to_av_perm(SECCLASS_CONTEXT, "contains")
SECCLASS_FILE = selinux.string_to_security_class("file")
FILE__READ = selinux.string_to_av_perm(SECCLASS_FILE, "read")

raw_con1 = "user_u:user_r:user_t:s1"
raw_con2 = "user_u:user_r:user_t:s0"

avd = selinux.av_decision()
selinux.avc_reset()
try:
    rc = selinux.security_compute_av_raw(raw_con1, raw_con2,
SECCLASS_CONTEXT, CONTEXT__CONTAINS, avd)
    if rc < 0:
        print("selinux.security_compute_av_raw failed for %s %s" %
(raw_con1, raw_con2))
    if (avd.allowed & CONTEXT__CONTAINS) == CONTEXT__CONTAINS:
        print("%s dominates %s" % (raw_con1, raw_con2))
    else:
        print("%s does not dominate %s" % (raw_con1, raw_con2))
except OSError, ex:
    print "exception calling selinux.security_compute_av_raw", ex

avd = selinux.av_decision()
selinux.avc_reset()
try:
    rc = selinux.security_compute_av_raw(raw_con1, raw_con2, SECCLASS_FILE,
FILE__READ, avd)
    if rc < 0:
        print("selinux.security_compute_av_raw failed for %s %s" %
(raw_con1, raw_con2))
    if (avd.allowed & FILE__READ) == FILE__READ:
        print("%s dominates %s" % (raw_con1, raw_con2))
    else:
        print("%s does not dominate %s" % (raw_con1, raw_con2))

except OSError:
    print "exception calling selinux.security_compute_av_raw", ex

--0000000000009b4ac90575877a60
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>We currently have code running on el=
6 that does a MLS dominance check by calling security_compute_av_raw with t=
he security object class SECCLASS_CONTEXT with permission CONTEXT__CONTAINS=
 as you can see in the python code below. When I run this code on el6 s1 do=
minates s0 however when I run the same code on el7 s1 does not dominate s0.=
 On both systems the file read dominance check works as expected. Can anyon=
e help me understand why the context contains check does not work the same =
on both systems?=C2=A0</div><div><br></div><div>Ted</div><div><br></div><di=
v>-------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-----------------------------------------------------</div><div><br></div><=
div>import selinux</div><div><br></div><div>SECCLASS_CONTEXT =3D selinux.st=
ring_to_security_class(&quot;context&quot;)</div><div>CONTEXT__CONTAINS =3D=
 selinux.string_to_av_perm(SECCLASS_CONTEXT, &quot;contains&quot;)</div><di=
v>SECCLASS_FILE =3D selinux.string_to_security_class(&quot;file&quot;)</div=
><div>FILE__READ =3D selinux.string_to_av_perm(SECCLASS_FILE, &quot;read&qu=
ot;)</div><div><br></div><div>raw_con1 =3D &quot;user_u:user_r:user_t:s1&qu=
ot;</div><div>raw_con2 =3D &quot;user_u:user_r:user_t:s0&quot;</div><div><b=
r></div><div>avd =3D selinux.av_decision()</div><div>selinux.avc_reset()</d=
iv><div>try:</div><div>=C2=A0 =C2=A0 rc =3D selinux.security_compute_av_raw=
(raw_con1, raw_con2, SECCLASS_CONTEXT, CONTEXT__CONTAINS, avd)</div><div>=
=C2=A0 =C2=A0 if rc &lt; 0:</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&qu=
ot;selinux.security_compute_av_raw failed for %s %s&quot; % (raw_con1, raw_=
con2))</div><div>=C2=A0 =C2=A0 if (avd.allowed &amp; CONTEXT__CONTAINS) =3D=
=3D CONTEXT__CONTAINS:</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;%s=
 dominates %s&quot; % (raw_con1, raw_con2))</div><div>=C2=A0 =C2=A0 else:</=
div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;%s does not dominate %s&qu=
ot; % (raw_con1, raw_con2))</div><div>except OSError, ex:</div><div>=C2=A0 =
=C2=A0 print &quot;exception calling selinux.security_compute_av_raw&quot;,=
 ex</div><div><br></div><div>avd =3D selinux.av_decision()</div><div>selinu=
x.avc_reset()</div><div>try:</div><div>=C2=A0 =C2=A0 rc =3D selinux.securit=
y_compute_av_raw(raw_con1, raw_con2, SECCLASS_FILE, FILE__READ, avd)</div><=
div>=C2=A0 =C2=A0 if rc &lt; 0:</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 print=
(&quot;selinux.security_compute_av_raw failed for %s %s&quot; % (raw_con1, =
raw_con2))</div><div>=C2=A0 =C2=A0 if (avd.allowed &amp; FILE__READ) =3D=3D=
 FILE__READ:</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;%s dominates=
 %s&quot; % (raw_con1, raw_con2))</div><div>=C2=A0 =C2=A0 else:</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;%s does not dominate %s&quot; % (ra=
w_con1, raw_con2))</div><div><br></div><div>except OSError:</div><div>=C2=
=A0 =C2=A0 print &quot;exception calling selinux.security_compute_av_raw&qu=
ot;, ex</div><div><br></div></div></div>

--0000000000009b4ac90575877a60--
