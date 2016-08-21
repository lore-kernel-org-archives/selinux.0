Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7L2L297032185
 for <selinux@tycho.nsa.gov>; Sat, 20 Aug 2016 22:21:02 -0400
Received: by mail-ua0-f175.google.com with SMTP id n59so138144608uan.2
 for <selinux@tycho.nsa.gov>; Sat, 20 Aug 2016 19:20:58 -0700 (PDT)
MIME-Version: 1.0
From: Kashif ali <kashif.ali.9498@gmail.com>
Date: Sun, 21 Aug 2016 07:20:57 +0500
Message-ID: <CAFC8oac4Ut1Qm9R_KY2-XHatmeq-m+VoraEbwGYbGdCTi+xYcA@mail.gmail.com>
Subject: docker daemon type label issue
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a114950dcf63073053a8b9492
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114950dcf63073053a8b9492
Content-Type: text/plain; charset=UTF-8

Hi
* When i run my docker daemon with on port for communication with client
with the help of this command
=> "docker daemon -H localhost:2376 --selinux-enabled &"
   then the docker daemon have following label
   "root:unconfined_r:unconfined_t:s0-s0:c0.c1023 2535 pts/0 00:00:00
dockerd"

*  Root user is running in the following context
"root:unconfined_r:unconfined_t:"

* is there anything i am missing why docker daemon don't have docker_t
label on it,
  i know as docker daemon is started by unconfined_t domain and
unconfined_t domain   have no domain transition then in which context the
docker daemon should start and     as i read if init_t start the process
then docker daemon will have docker_t label on it so   how can i run docker
daemon with init_t context

--001a114950dcf63073053a8b9492
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<div>* When i run my docker daemon with on port for comm=
unication with client with the help of this command=C2=A0<br>=3D&gt; &quot;=
docker daemon -H localhost:2376 --selinux-enabled &amp;&quot;<br>=C2=A0 =C2=
=A0then the docker daemon have following label</div><div>=C2=A0 =C2=A0&quot=
;root:unconfined_r:<wbr>unconfined_t:s0-s0:c0.c1023 2535 pts/0 00:00:00 doc=
kerd&quot;</div><div><br>* =C2=A0Root user is running in the following cont=
ext &quot;root:unconfined_r:unconfined_<wbr>t:&quot;</div><div>=C2=A0 =C2=
=A0</div><div>* is there anything i am missing why docker daemon don&#39;t =
have docker_t label on it,=C2=A0</div><div>=C2=A0 i know as docker daemon i=
s started by unconfined_t domain and unconfined_t domain =C2=A0 have no dom=
ain transition then in which context the docker daemon should start and =C2=
=A0 =C2=A0 as i read if init_t start the process then docker daemon will ha=
ve docker_t label on it so =C2=A0 how can i run docker daemon with init_t c=
ontext=C2=A0<br><br></div></div>

--001a114950dcf63073053a8b9492--
