MIME-Version: 1.0
From: Nick Kralevich <nnk@google.com>
Date: Fri, 7 Apr 2017 10:34:13 -0700
Message-ID: <CAFJ0LnGQPYAxugZfak6az6ruB9Ea8J34nPXQYTUey_YOg4g1BQ@mail.gmail.com>
Subject: add CONFIG_SECURITY_SELINUX_LOAD_ONCE
To: SELinux <Selinux@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a114733c0cce3f6054c9708ab
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114733c0cce3f6054c9708ab
Content-Type: text/plain; charset=UTF-8

I wanted to draw people's attention to the following proposed change:

  https://android-review.googlesource.com/367695

In the case of Android, it's common for security policy to be loaded once,
and never reloaded again. In that case, the locking / unlocking surrounding
the in-kernel policy is unnecessary and can be avoided. The patch above
turns the locks into no-ops and ensures that the kernel cannot load a
policy more than once. End result is that locking and preemption overhead
is avoided and there's less attack surface / code compiled into the kernel.

I would appreciate comments on the change. This feels like a worthwhile
change for the entire SELinux community.

-- Nick

-- 
Nick Kralevich | Android Security | nnk@google.com | 650.214.4037

--001a114733c0cce3f6054c9708ab
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I wanted to draw people&#39;s attention to the follow=
ing proposed change:</div><div><br></div><div>=C2=A0=C2=A0<a href=3D"https:=
//android-review.googlesource.com/367695">https://android-review.googlesour=
ce.com/367695</a></div><div><br></div><div>In the case of Android, it&#39;s=
 common for security policy to be loaded once, and never reloaded again. In=
 that case, the locking / unlocking surrounding the in-kernel policy is unn=
ecessary and can be avoided. The patch above turns the locks into no-ops an=
d ensures that the kernel cannot load a policy more than once. End result i=
s that locking and preemption overhead is avoided and there&#39;s less atta=
ck surface / code compiled into the kernel.</div><div><br></div><div>I woul=
d appreciate comments on the change. This feels like a worthwhile change fo=
r the entire SELinux community.</div><div><br></div><div>-- Nick</div><div>=
<br></div>-- <br><div class=3D"gmail_signature"><div>Nick Kralevich | Andro=
id Security | <a href=3D"mailto:nnk@google.com" target=3D"_blank">nnk@googl=
e.com</a> | 650.214.4037</div></div>
</div>

--001a114733c0cce3f6054c9708ab--
