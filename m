Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s61JHDqF022709
 for <selinux@tycho.nsa.gov>; Tue, 1 Jul 2014 15:17:13 -0400
Received: by mail-we0-f179.google.com with SMTP id w62so10242916wes.38
 for <selinux@tycho.nsa.gov>; Tue, 01 Jul 2014 12:17:14 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 1 Jul 2014 22:17:14 +0300
Message-ID: <CAMRSN0D+wGvMAxTxVQKYYTaWqO0Z5=1+s12vdTGWyRFcmzsa1g@mail.gmail.com>
Subject: libselinux-2.0.94-2.el6.i686 issue
From: Sebastian Brestin <sebastianbrestin@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=047d7ba97f3a94945304fd269fda
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--047d7ba97f3a94945304fd269fda
Content-Type: text/plain; charset=UTF-8

Hi.

I am trying to figure out why is this happening. I have a program that
uses pam_open_session.

If selinux is set on enforcing the following error occurs when running the
program.

PAM pam_open_session failed with error: [7] Authentication failure

if I update the libselinux from 2.0.94-2 to 2.0.94-5.3 the error disappears.

Also during the update libselinux-util updates since it is an dependency.
The versions for the util lib are the same as the selinux ones.

Any ideas why the first versions fails?

-sgb

--047d7ba97f3a94945304fd269fda
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi.<div><br></div><div>I am trying to figure out why is th=
is happening. I have a program that uses=C2=A0pam_open_session.</div><div><=
br></div><div>If selinux is set on enforcing the following error occurs whe=
n running the program.</div>
<div><br></div><div><div>PAM pam_open_session failed with error: [7] Authen=
tication failure</div></div><div><br></div><div>if I update the libselinux =
from=C2=A02.0.94-2 to=C2=A02.0.94-5.3 the error disappears.</div><div><br><=
/div><div>
Also during the update libselinux-util updates since it is an dependency. T=
he versions for the util lib are the same as the selinux ones.</div><div><b=
r></div><div>Any ideas why the first versions fails?</div><div><br></div>
<div>-sgb</div><div><br></div><div><br></div><div><br></div><div><br></div>=
</div>

--047d7ba97f3a94945304fd269fda--
