Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v33NR2Tl030549
 for <selinux@tycho.nsa.gov>; Mon, 3 Apr 2017 19:27:02 -0400
Received: by mail-wr0-f178.google.com with SMTP id k6so185786474wre.2
 for <selinux@tycho.nsa.gov>; Mon, 03 Apr 2017 16:26:57 -0700 (PDT)
MIME-Version: 1.0
From: Rahmadi Trimananda <rtrimana@uci.edu>
Date: Mon, 3 Apr 2017 16:26:56 -0700
Message-ID: <CAHFUiBOa186qydQ5VBeEmcMMinQnpkwBPMx91Aq-GAq4TvSm-g@mail.gmail.com>
Subject: Running Java and JVM on SELinux
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a114423d8c0ce51054c4b7e52
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114423d8c0ce51054c4b7e52
Content-Type: text/plain; charset=UTF-8

Hi All,

I am trying to run javac and java on my Raspbian while SELinux is enabled.
However, I keep getting "Segmentation fault", even when I just run "javac"
or "java". This happens in enforcing mode, but it doesn't happen with
"gcc". I am wondering why, because both are in /usr/bin directory and both
binaries have the same context.

Can somebody please help?

Thank you so much!

Regards,
Rahmadi

--001a114423d8c0ce51054c4b7e52
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<div><br></div><div>I am trying to run javac and ja=
va on my Raspbian while SELinux is enabled. However, I keep getting &quot;S=
egmentation fault&quot;, even when I just run &quot;javac&quot; or &quot;ja=
va&quot;. This happens in enforcing mode, but it doesn&#39;t happen with &q=
uot;gcc&quot;. I am wondering why, because both are in /usr/bin directory a=
nd both binaries have the same context.</div><div><br></div><div>Can somebo=
dy please help?</div><div><br></div><div>Thank you so much!</div><div><br><=
/div><div>Regards,</div><div>Rahmadi</div><div class=3D"gmail_extra"><br>
</div></div>

--001a114423d8c0ce51054c4b7e52--
