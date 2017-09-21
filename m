Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v8LEsJEs004816
 for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2017 10:54:19 -0400
Received: from c-sl556.itechfrontiers.net (c-sl556.itechfrontiers.net
 [66.36.250.115])
 by c-sl428.itechfrontiers.net (ITechFrontiers-Post) with ESMTP id F161A5641A
 for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2017 10:14:44 -0400 (EDT)
Received: from c-sl428.itechfrontiers.net ([66.36.250.114])
 by c-sl556.itechfrontiers.net (c-sl556.itechfrontiers.net [66.36.250.115])
 (ITech Frontiers SecureMail)
 with ESMTP id zas_9VMr4L8s for <selinux@tycho.nsa.gov>;
 Thu, 21 Sep 2017 10:14:38 -0400 (EDT)
Received: from c-sl556.itechfrontiers.net (c-sl556.itechfrontiers.net
 [66.36.250.115])
 by c-sl428.itechfrontiers.net (ITechFrontiers-Post) with ESMTP id B151856419
 for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2017 10:14:38 -0400 (EDT)
Received: from c-sl428.itechfrontiers.net ([66.36.250.114])
 by c-sl556.itechfrontiers.net (c-sl556.itechfrontiers.net [66.36.250.115])
 (ITech Frontiers SecureMail)
 with ESMTP id jHuDWn8ctJ1G for <selinux@tycho.nsa.gov>;
 Thu, 21 Sep 2017 10:14:37 -0400 (EDT)
Received: from rhea.itechfrontiers.com ([10.7.14.47])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: cto@itechfrontiers.com)
 by c-sl428.itechfrontiers.net (ITechFrontiers-Post) with ESMTPSA id AC48C56418
 for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2017 10:14:36 -0400 (EDT)
To: selinux@tycho.nsa.gov
References: <CAPihp9nPSh1mnnAsZ3aHL3KqBq80RQKLjq8N_AF29iNn3UKj+A@mail.gmail.com>
From: "Patrick K., ITF" <cto@itechfrontiers.com>
Message-ID: <5063a5f6-876f-83b8-7b8a-74cf6dfc173a@itechfrontiers.com>
Date: Thu, 21 Sep 2017 10:14:39 -0400
MIME-Version: 1.0
In-Reply-To: <CAPihp9nPSh1mnnAsZ3aHL3KqBq80RQKLjq8N_AF29iNn3UKj+A@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------7C299A96A2C10326E96A3C8B"
Subject: Re: A casestudy where selinux has stopped malware attacks
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------7C299A96A2C10326E96A3C8B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hello,

Please read about SELinux here:

http://selinuxproject.org/page/FAQ


MAC in case of SeLinux or DAC (Discretionary Access Control)=C2=A0 are th=
ere=20
to control the extent of which a user or process can access or interact=20
with resources.

They by nature may sandbox an attack, but are not there to stop malware=20
attacks.
They may mitigate some of them like this one: (Exactly serving one of=20
its purposes)

CVE-2016-9962 docker: insecure opening of file-descriptor allows=20
privilege escalation:

http://rhelblog.redhat.com/2017/01/13/selinux-mitigates-container-vulnera=
bility/


Mitigating is not stopping, you still need to patch the vulnerability,=20
and it is not necessarily for all kind of malware or cases of malware,=20
it depends on malware , your setting, the environment and etc.

You may not deploy Selinux and think you stopped all attacks, it is just=20
false sense of security.

P.S. With Special thanks to Dan Walsh of RedHat


Best regards,

--=20
  Patrick K.

On 9/21/2017 12:13 AM, masoom alam wrote:
> Hi every one,
>
> Do we have some thing like the mentioned subject documented?
>
> Thank you.
>
>
> *----*
> *Dr. Masoom Alam,*
> Associate Professor,
> Department of Computer Science,
> COMSATS Institute of Information Technology,
> Park Road, Islamabad
> Off +92-51-9049-5391
> Cell +92-332-9298-404


--------------7C299A96A2C10326E96A3C8B
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf=
-8">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    <p>Hello,</p>
    <p>Please read about SELinux here:<br>
    </p>
    <p><a class=3D"moz-txt-link-freetext" href=3D"http://selinuxproject.o=
rg/page/FAQ">http://selinuxproject.org/page/FAQ</a><br>
    </p>
    <br>
    MAC in case of SeLinux or DAC (Discretionary Access Control)=C2=A0 ar=
e
    there to control the extent of which a user or process can access or
    interact with resources.<br>
    <br>
    They by nature may sandbox an attack, but are not there to stop
    malware attacks.<br>
    They may mitigate some of them like this one: (Exactly serving one
    of its purposes)<br>
    <br>
    CVE-2016-9962 docker: insecure opening of file-descriptor allows
    privilege escalation:<br>
    <br>
<a class=3D"moz-txt-link-freetext" href=3D"http://rhelblog.redhat.com/201=
7/01/13/selinux-mitigates-container-vulnerability/">http://rhelblog.redha=
t.com/2017/01/13/selinux-mitigates-container-vulnerability/</a><br>
    <br>
    <br>
    Mitigating is not stopping, you still need to patch the
    vulnerability, and it is not necessarily for all kind of malware or
    cases of malware, it depends on malware , your setting, the
    environment and etc.<br>
    <br>
    You may not deploy Selinux and think you stopped all attacks, it is
    just false sense of security.<br>
    <br>
    P.S. With Special thanks to Dan Walsh of RedHat<br>
    <br>
    <br>
    Best regards,<br>
    <pre class=3D"moz-signature" cols=3D"72">--=20
 Patrick K.</pre>
    <div class=3D"moz-cite-prefix">On 9/21/2017 12:13 AM, masoom alam
      wrote:<br>
    </div>
    <blockquote type=3D"cite"
cite=3D"mid:CAPihp9nPSh1mnnAsZ3aHL3KqBq80RQKLjq8N_AF29iNn3UKj+A@mail.gmai=
l.com">
      <div dir=3D"ltr">Hi every one,=C2=A0
        <div><br>
        </div>
        <div>Do we have some thing like the mentioned subject
          documented?</div>
        <div><br>
        </div>
        <div>Thank you.=C2=A0</div>
        <div><br>
        </div>
        <div><br clear=3D"all">
          <div>
            <div class=3D"gmail_signature"
              data-smartmail=3D"gmail_signature">
              <div dir=3D"ltr">
                <div>
                  <div dir=3D"ltr"><font style=3D"font-size:12.8px"
                      color=3D"#666666"><b>----</b></font></div>
                  <div dir=3D"ltr"><font style=3D"font-size:12.8px"
                      color=3D"#666666"><b>Dr. Masoom Alam,</b><br>
                    </font>
                    <div style=3D"font-size:12.8px">
                      <div style=3D"font-size:12.8px"><span
                          style=3D"color:rgb(102,102,102);font-size:small=
">Associate
                          Professor,</span><span
                          style=3D"color:rgb(102,102,102)"><br>
                        </span></div>
                      <div><font size=3D"2" color=3D"#666666">Department =
of
                          Computer Science,</font></div>
                      <div style=3D"font-size:12.8px"><span
                          style=3D"color:rgb(102,102,102)">COMSATS
                          Institute of Information Technology,</span></di=
v>
                      <div style=3D"font-size:12.8px"><span
                          style=3D"color:rgb(102,102,102)">Park Road,
                          Islamabad</span></div>
                      <div style=3D"font-size:12.8px"><font
                          color=3D"#666666">Off +92-51-9049-5391</font></=
div>
                    </div>
                    <div style=3D"font-size:12.8px"><font color=3D"#66666=
6">Cell
                        +92-332-9298-404</font></div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------7C299A96A2C10326E96A3C8B--
