MIME-Version: 1.0
In-Reply-To: <CAB9W1A2-PT8QU-md1s9fxhNg+Cv0C4Xu-i1w_q0XzQ+K9rsyAg@mail.gmail.com>
References: <20171002155825.28620-1-sds@tycho.nsa.gov>
 <20171002155825.28620-10-sds@tycho.nsa.gov>
 <1507217234.27146.14.camel@tycho.nsa.gov>
 <alpine.LRH.2.21.1710091250460.23916@namei.org>
 <CAB9W1A2-PT8QU-md1s9fxhNg+Cv0C4Xu-i1w_q0XzQ+K9rsyAg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley@gmail.com>
Date: Mon, 9 Oct 2017 09:53:52 -0400
Message-ID: <CAB9W1A1s9phxBocqadVif1t58jp4is+1nssZmi1O95BJhHKvSw@mail.gmail.com>
To: James Morris <jmorris@namei.org>
Cc: "Stephen D. Smalley" <sds@tycho.nsa.gov>, selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="001a113ee9b25fbd03055b1d858e"
Subject: Re: [RFC 09/10] selinux: add a selinuxfs interface to
 unshare selinux namespace
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113ee9b25fbd03055b1d858e
Content-Type: text/plain; charset="UTF-8"

On Oct 8, 2017 9:54 PM, "James Morris" <jmorris@namei.org> wrote:

On Thu, 5 Oct 2017, Stephen Smalley wrote:

> inet_socket test failures are expected due to running in a non-init
> network namespace; they don't work even without unsharing the selinux
> namespace.

Do these results all look as expected?


No, that suggests that you either didn't insert the policy module allowing
access to unlabeled fds or you didn't run restorecon -R /dev before running
the tests. The only expected failures are the inet socket ones.


Test Summary Report
-------------------
fdreceive/test         (Wstat: 0 Tests: 3 Failed: 1)
  Failed test:  3
inherit/test           (Wstat: 0 Tests: 3 Failed: 1)
  Failed test:  1
file/test              (Wstat: 0 Tests: 16 Failed: 1)
  Failed test:  8
bounds/test            (Wstat: 0 Tests: 24 Failed: 5)
  Failed tests:  3, 6, 12, 21, 23
mmap/test              (Wstat: 0 Tests: 46 Failed: 2)
  Failed tests:  9, 13
inet_socket/test       (Wstat: 3584 Tests: 33 Failed: 14)
  Failed tests:  1, 3, 5-6, 8, 16, 18, 20, 22, 25-26, 28
                30, 32
  Non-zero exit status: 14
overlay/test           (Wstat: 3072 Tests: 121 Failed: 12)
  Failed tests:  1, 25, 27, 39-40, 57, 63, 87, 89, 98-99
                116
  Non-zero exit status: 12
Files=51, Tests=485, 28 wallclock secs ( 0.60 usr  0.13 sys +  2.67 cusr
3.76 csys =  7.16 CPU)
Result: FAIL
Failed 7/51 test programs. 36/485 subtests failed.


--
James Morris
<jmorris@namei.org>

--001a113ee9b25fbd03055b1d858e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_extra"><div class=3D"gmail_quote=
">On Oct 8, 2017 9:54 PM, &quot;James Morris&quot; &lt;<a href=3D"mailto:jm=
orris@namei.org">jmorris@namei.org</a>&gt; wrote:<br type=3D"attribution"><=
blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex"><div class=3D"quoted-text">On Thu, 5 Oct 2017, Step=
hen Smalley wrote:<br>
<br>
&gt; inet_socket test failures are expected due to running in a non-init<br=
>
&gt; network namespace; they don&#39;t work even without unsharing the seli=
nux<br>
&gt; namespace.<br>
<br>
</div>Do these results all look as expected?<br></blockquote></div></div></=
div><div dir=3D"auto"><br></div><div dir=3D"auto">No, that suggests that yo=
u either didn&#39;t insert the policy module allowing access to unlabeled f=
ds or you didn&#39;t run restorecon -R /dev before running the tests. The o=
nly expected failures are the inet socket ones.=C2=A0</div><div dir=3D"auto=
"><br></div><div dir=3D"auto"><div class=3D"gmail_extra"><div class=3D"gmai=
l_quote"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">
<br>
Test Summary Report<br>
-------------------<br>
fdreceive/test=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(Wstat: 0 Tests: 3 Failed: =
1)<br>
=C2=A0 Failed test:=C2=A0 3<br>
inherit/test=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(Wstat: 0 Tests: 3 Fai=
led: 1)<br>
=C2=A0 Failed test:=C2=A0 1<br>
file/test=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (Wstat: 0 Tests: =
16 Failed: 1)<br>
=C2=A0 Failed test:=C2=A0 8<br>
bounds/test=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (Wstat: 0 Tests: 24 Fa=
iled: 5)<br>
=C2=A0 Failed tests:=C2=A0 3, 6, 12, 21, 23<br>
mmap/test=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (Wstat: 0 Tests: =
46 Failed: 2)<br>
=C2=A0 Failed tests:=C2=A0 9, 13<br>
inet_socket/test=C2=A0 =C2=A0 =C2=A0 =C2=A0(Wstat: 3584 Tests: 33 Failed: 1=
4)<br>
=C2=A0 Failed tests:=C2=A0 1, 3, 5-6, 8, 16, 18, 20, 22, 25-26, 28<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 30, 32<br>
=C2=A0 Non-zero exit status: 14<br>
overlay/test=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(Wstat: 3072 Tests: 12=
1 Failed: 12)<br>
=C2=A0 Failed tests:=C2=A0 1, 25, 27, 39-40, 57, 63, 87, 89, 98-99<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 116<br>
=C2=A0 Non-zero exit status: 12<br>
Files=3D51, Tests=3D485, 28 wallclock secs ( 0.60 usr=C2=A0 0.13 sys +=C2=
=A0 2.67 cusr<br>
3.76 csys =3D=C2=A0 7.16 CPU)<br>
Result: FAIL<br>
Failed 7/51 test programs. 36/485 subtests failed.<br>
<font color=3D"#888888"><br>
<br>
--<br>
James Morris<br>
&lt;<a href=3D"mailto:jmorris@namei.org">jmorris@namei.org</a>&gt;<br>
<br>
<br>
</font></blockquote></div><br></div></div></div>

--001a113ee9b25fbd03055b1d858e--
