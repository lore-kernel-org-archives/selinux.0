Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6AMvrfT024730
	for <selinux@tycho.nsa.gov>; Tue, 10 Jul 2012 18:57:53 -0400
Received: by ghbz13 with SMTP id z13so621076ghb.12
        for <selinux@tycho.nsa.gov>; Tue, 10 Jul 2012 15:57:52 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 10 Jul 2012 15:57:51 -0700
Message-ID: <CAFftDdrwpSDqaPVVpiHDFYrvBK-f-MkaVHcUU5Z+x6=GLqnO=w@mail.gmail.com>
Subject: external/strace build breakage
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=f46d042f9eb0fd2ec304c481a8a3
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d042f9eb0fd2ec304c481a8a3
Content-Type: text/plain; charset=ISO-8859-1

I got a build breakage when building SE Android master. It stems from
external/strace and it is on branch aosp/master spewing error: #if with no
expression.

You can apply this patch to fix it:

git fetch https://android.googlesource.com/platform/external/stracerefs/changes/91/38991/1
&& git cherry-pick FETCH_HEAD

https://android-review.googlesource.com/#/c/38991/

I don't think this the "best" fix as their is
another similar patch submitted to the project, but it works for now. I
think that macro should be assigned a 1 or 0 vs defined/not defined.

-- 
Respectfully,

William C Roberts

--f46d042f9eb0fd2ec304c481a8a3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I got a build breakage when building SE Android master. It stems from exter=
nal/strace and it is on branch aosp/master spewing=A0<span style=3D"backgro=
und-color:white;font-size:13px;line-height:1.3em">error: #if with no expres=
sion.</span><div>
<br></div><div>You can apply this patch to fix it:</div><div><br></div><div=
>git fetch <a href=3D"https://android.googlesource.com/platform/external/st=
race">https://android.googlesource.com/platform/external/strace</a> refs/ch=
anges/91/38991/1 &amp;&amp; git cherry-pick FETCH_HEAD</div>
<div><br></div><div><a href=3D"https://android-review.googlesource.com/#/c/=
38991/">https://android-review.googlesource.com/#/c/38991/</a></div><div><b=
r></div><div>I don&#39;t think this the &quot;best&quot; fix as their is an=
other=A0similar=A0patch=A0submitted=A0to the project, but it works for now.=
 I think that macro should be assigned a 1 or 0 vs defined/not defined.</di=
v>
<div><br></div><div>-- <br>Respectfully,<br><br>William C Roberts<br><br><b=
r>
</div>

--f46d042f9eb0fd2ec304c481a8a3--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
