Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v34FoRFR001675
 for <selinux@tycho.nsa.gov>; Tue, 4 Apr 2017 11:50:27 -0400
Received: by mail-wm0-f41.google.com with SMTP id o81so29182895wmb.1
 for <selinux@tycho.nsa.gov>; Tue, 04 Apr 2017 08:50:25 -0700 (PDT)
MIME-Version: 1.0
From: Rahmadi Trimananda <rtrimana@uci.edu>
Date: Tue, 4 Apr 2017 08:50:23 -0700
Message-ID: <CAHFUiBNUTOaOYVch=MJPz6c_Stx_B_rmMA-FjMVcneiWouGKOw@mail.gmail.com>
Subject: Confining a Java process reading file
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a114447dedc0138054c593ba2
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114447dedc0138054c593ba2
Content-Type: text/plain; charset=UTF-8

Hey Guys,

I am trying to confine a Java process that I have so that it will be able
to read only certain files. This is my experiment setup for my folder.
Basically a.out (C program) and Test.class (Java class) are coded to read
and print out the text in test.txt.

    unconfined_u:object_r:httpd_t:SystemLow a.out
unconfined_u:object_r:user_home_t:SystemLow test.c
    unconfined_u:object_r:httpd_t:SystemLow Test.class
unconfined_u:object_r:user_home_t:SystemLow Test.java
unconfined_u:object_r:user_home_t:SystemLow test.txt

I tried to change the type label for a.out from user_home_t to httpd_t just
for the sake of the experiment. With this setup, a.out is no longer able to
read test.txt in enforcing mode. However, I seem to not be able to do it
for Test.class as it's running on a JVM. The java label is "bin_t". And I
checked using this:

sesearch -s bin_t -t user_home_t -c file -p read -Ad

And it doesn't seem to have a rule that allows bin_t to read a file with
user_home_t label.

What's the right way to do this if any? Then, I also try to confine port
accesses for Test.class, e.g. I only allow it to access ports 1234 and
2345. Same question, what's the right way to do this?

Kind regards,
Rahmadi

--001a114447dedc0138054c593ba2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hey Guys,<div><br></div><div>I am trying to confine a Java=
 process that I have so that it will be able to read only certain files. Th=
is is my experiment setup for my folder. Basically a.out (C program) and Te=
st.class (Java class) are coded to read and print out the text in test.txt.=
</div><div><br></div><div><div>=C2=A0 =C2=A0 unconfined_u:object_r:httpd_t:=
SystemLow a.out</div><div>unconfined_u:object_r:user_home_t:SystemLow test.=
c</div><div>=C2=A0 =C2=A0 unconfined_u:object_r:httpd_t:SystemLow Test.clas=
s</div><div>unconfined_u:object_r:user_home_t:SystemLow Test.java</div><div=
>unconfined_u:object_r:user_home_t:SystemLow test.txt</div><div><br></div><=
div><div>I tried to change the type label for a.out from user_home_t to htt=
pd_t just for the sake of the experiment. With this setup, a.out is no long=
er able to read test.txt in enforcing mode. However, I seem to not be able =
to do it for Test.class as it&#39;s running on a JVM. The java label is &qu=
ot;bin_t&quot;. And I checked using this:</div></div><div><br></div><div>se=
search -s bin_t -t user_home_t -c file -p read -Ad<br></div><div><br></div>=
<div>And it doesn&#39;t seem to have a rule that allows bin_t to read a fil=
e with user_home_t label.</div><div><br></div><div>What&#39;s the right way=
 to do this if any? Then, I also try to confine port accesses for Test.clas=
s, e.g. I only allow it to access ports 1234 and 2345. Same question, what&=
#39;s the right way to do this?</div><div><br></div><div class=3D"gmail_sig=
nature"><div dir=3D"ltr">Kind regards,<div>Rahmadi</div></div></div>
</div></div>

--001a114447dedc0138054c593ba2--
