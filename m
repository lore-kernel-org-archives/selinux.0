To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
From: Laurent Bigonville <bigon@debian.org>
Message-ID: <c58fe940-dc55-2fa3-fd6e-b58d0f7af3a2@debian.org>
Date: Sat, 15 Jul 2017 00:38:27 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------9DFF8C2337C38CB76161049A"
Subject: Re: open_init_pty: Do not make stdin and stdout non-blocking
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------9DFF8C2337C38CB76161049A
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

> commit fb081eb64b36a9de5a43f3d69d9e628b6eb1afc7 (HEAD -> master, 
> origin/master)
> Author: Stephen Smalley <sds@tycho.nsa.gov>
> Date:   Mon Jul 10 13:03:01 2017 -0400
>
>     open_init_pty: Do not make stdin and stdout non-blocking
>
>     It is unclear why this was being done in the first place, and
>     it has caused multiple bugs with run_init/open_init_pty usage.
>
>     Fixes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=863187
>     Fixes: https://bugs.gentoo.org/show_bug.cgi?id=621062
>     Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

I see you fixed the issue with run_init/open_init_pty messing up with 
the terminals but I think it's introducing an other issue :/

FTR I found the reason why stdin/stdout were not blocking, it's a fix 
for this: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=474956#10

Apparently if the descriptors are closed, open_init_pty hangs, example:

./open_init_pty bash -c 'echo hello; exec >&- 2>&- <&-; sleep 1; '


--------------9DFF8C2337C38CB76161049A
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>

    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3Dutf=
-8">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    <p>
      <blockquote type=3D"cite">commit
        fb081eb64b36a9de5a43f3d69d9e628b6eb1afc7 (HEAD -&gt; master,
        origin/master)<br>
        Author: Stephen Smalley <a class=3D"moz-txt-link-rfc2396E" href=3D=
"mailto:sds@tycho.nsa.gov">&lt;sds@tycho.nsa.gov&gt;</a><br>
        Date:=C2=A0=C2=A0 Mon Jul 10 13:03:01 2017 -0400<br>
        <br>
        =C2=A0=C2=A0=C2=A0 open_init_pty: Do not make stdin and stdout no=
n-blocking<br>
        =C2=A0=C2=A0 =C2=A0<br>
        =C2=A0=C2=A0=C2=A0 It is unclear why this was being done in the f=
irst place,
        and<br>
        =C2=A0=C2=A0=C2=A0 it has caused multiple bugs with run_init/open=
_init_pty
        usage.<br>
        =C2=A0=C2=A0 =C2=A0<br>
        =C2=A0=C2=A0=C2=A0 Fixes:
        <a class=3D"moz-txt-link-freetext" href=3D"https://bugs.debian.or=
g/cgi-bin/bugreport.cgi?bug=3D863187">https://bugs.debian.org/cgi-bin/bug=
report.cgi?bug=3D863187</a><br>
        =C2=A0=C2=A0=C2=A0 Fixes: <a class=3D"moz-txt-link-freetext" href=
=3D"https://bugs.gentoo.org/show_bug.cgi?id=3D621062">https://bugs.gentoo=
.org/show_bug.cgi?id=3D621062</a><br>
        =C2=A0=C2=A0=C2=A0 Signed-off-by: Stephen Smalley <a class=3D"moz=
-txt-link-rfc2396E" href=3D"mailto:sds@tycho.nsa.gov">&lt;sds@tycho.nsa.g=
ov&gt;</a><br>
      </blockquote>
    </p>
    <p>I see you fixed the issue with run_init/open_init_pty messing up
      with the terminals but I think it's introducing an other issue :/</=
p>
    <p>FTR I found the reason why stdin/stdout were not blocking, it's a
      fix for this:
      <a class=3D"moz-txt-link-freetext" href=3D"https://bugs.debian.org/=
cgi-bin/bugreport.cgi?bug=3D474956#10">https://bugs.debian.org/cgi-bin/bu=
greport.cgi?bug=3D474956#10</a></p>
    <p>Apparently if the descriptors are closed, open_init_pty hangs,
      example:</p>
    <pre class=3D"message">./open_init_pty bash -c 'echo hello; exec &gt;=
&amp;- 2&gt;&amp;- &lt;&amp;-; sleep 1; '
</pre>
  </body>
</html>

--------------9DFF8C2337C38CB76161049A--
