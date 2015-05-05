Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t452bKMx029183
 for <selinux@tycho.nsa.gov>; Mon, 4 May 2015 22:37:20 -0400
Received: by wiun10 with SMTP id n10so129522146wiu.1
 for <selinux@tycho.nsa.gov>; Mon, 04 May 2015 19:37:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <F766E4F80769BD478052FB6533FA745D66611C3FD9@SC-VEXCH4.marvell.com>
References: <F766E4F80769BD478052FB6533FA745D66611C3FD9@SC-VEXCH4.marvell.com>
Date: Mon, 4 May 2015 19:37:17 -0700
Message-ID: <CAFftDdqp06sbW9chUrzS0RaNgrqv=W5=3nP9VcFnYrzOkUkf5Q@mail.gmail.com>
Subject: Re: Give out all the avc logs in ome time
From: William Roberts <bill.c.roberts@gmail.com>
To: Zhi Xin <xinzhi@marvell.com>
Content-Type: multipart/alternative; boundary=047d7b86de869797b205154c8e89
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--047d7b86de869797b205154c8e89
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Are you running in permissive or enforcing mode? Usually if you're running
in enforcing mode the daemon will not be able to perform all of its tasks
that it normally would thus your missing messages
On May 4, 2015 7:11 PM, "Zhi Xin" <xinzhi@marvell.com> wrote:

> Hi All,
>
>
>
> In my daily work, I=E2=80=99m always solving the selinux deny as presente=
d by avc
> log. But I found that, for one particular test, selinux cannot give me al=
l
> the avc deny log in one time, which has slowed down a lot of my daily wor=
k.
>
>
>
> For example, I trigger a process called test_daemon to access a
> /dev/test_device in a particular test. Totally, it should have =E2=80=9Co=
pen, read,
> write, ioctl=E2=80=9D for permissions. But for one time test, I only catc=
h =E2=80=9Copen,
> read=E2=80=9D related avc log. And only after I have merged a patch to gi=
ve the
> =E2=80=9Copen=E2=80=9D and =E2=80=9Cread=E2=80=9D permission, I rerun the=
 test. The =E2=80=9Cwrite ioctl=E2=80=9D related
> avc  logs start to occur. So my question is how can I get =E2=80=9Copen, =
read,
> write, ioctl=E2=80=9D avc log in one test.
>
>
>
> I have done a little study on this issue. selinux avc log depends on audi=
t
> subsystem. In /kernel/kernel/audit.c, some code has indicated that we may
> lost the records in five ways:
>
> 115 <http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/aud=
it.c#115>/* Records can be lost in several ways:
>
> 116 <http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/aud=
it.c#116>   0) [suppressed in audit_alloc]
>
> 117 <http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/aud=
it.c#117>   1) out of memory in audit_log_start [kmalloc of struct audit_bu=
ffer]
>
> 118 <http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/aud=
it.c#118>   2) out of memory in audit_log_move [alloc_skb]
>
> 119 <http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/aud=
it.c#119>   3) suppressed due to audit_rate_limit
>
> 120 <http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/aud=
it.c#120>   4) suppressed due to audit_backlog_limit
>
> 121 <http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/aud=
it.c#121>*/
>
>
>
> So is this the root-cause of my issue ? How can I modify kernel code to
> archieve my purpose or there already is a open/off switch to help me on
> giving all the logs in one time test ?
>
>
>
> Thanks
>
> Sincerely
>
> Alan Xin
>
>
>
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>

--047d7b86de869797b205154c8e89
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Are you running in permissive or enforcing mode? Usually if =
you&#39;re running in enforcing mode the daemon will not be able to perform=
 all of its tasks that it normally would thus your missing messages</p>
<div class=3D"gmail_quote">On May 4, 2015 7:11 PM, &quot;Zhi Xin&quot; &lt;=
<a href=3D"mailto:xinzhi@marvell.com">xinzhi@marvell.com</a>&gt; wrote:<br =
type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div lang=3D"ZH-CN" lin=
k=3D"blue" vlink=3D"purple"><div><p class=3D"MsoNormal"><span lang=3D"EN-US=
">Hi All,<u></u><u></u></span></p><p class=3D"MsoNormal"><span lang=3D"EN-U=
S"><u></u>=C2=A0<u></u></span></p><p class=3D"MsoNormal"><span lang=3D"EN-U=
S">In my daily work, I=E2=80=99m always solving the selinux deny as present=
ed by avc log. But I found that, for one particular test, selinux cannot gi=
ve me all the avc deny log in one time, which has slowed down a lot of my d=
aily work.<u></u><u></u></span></p><p class=3D"MsoNormal"><span lang=3D"EN-=
US"><u></u>=C2=A0<u></u></span></p><p class=3D"MsoNormal"><span lang=3D"EN-=
US">For example, I trigger a process called test_daemon to access a /dev/te=
st_device in a particular test. Totally, it should have =E2=80=9Copen, read=
, write, ioctl=E2=80=9D for permissions. But for one time test, I only catc=
h =E2=80=9Copen, read=E2=80=9D related avc log. And only after I have merge=
d a patch to give the =E2=80=9Copen=E2=80=9D and =E2=80=9Cread=E2=80=9D per=
mission, I rerun the test. The =E2=80=9Cwrite ioctl=E2=80=9D related avc =
=C2=A0logs start to occur. So my question is how can I get =E2=80=9Copen, r=
ead, write, ioctl=E2=80=9D avc log in one test.<u></u><u></u></span></p><p =
class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p><p =
class=3D"MsoNormal"><span lang=3D"EN-US">I have done a little study on this=
 issue. selinux avc log depends on audit subsystem. In /kernel/kernel/audit=
.c, some code has indicated that we may lost the records in five ways:<u></=
u><u></u></span></p><pre><a name=3D"14d21d7a7c1f2c03_115"></a><a href=3D"ht=
tp://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/audit.c#115"=
 target=3D"_blank"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-fami=
ly:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:windowtext;text-decorat=
ion:none">115</span></a><span lang=3D"EN-US" style=3D"font-size:10.5pt;font=
-family:&quot;Calibri&quot;,&quot;sans-serif&quot;">/* Records can be lost =
in several ways:<u></u><u></u></span></pre><pre><a name=3D"14d21d7a7c1f2c03=
_116"></a><a href=3D"http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/ker=
nel/kernel/audit.c#116" target=3D"_blank"><span lang=3D"EN-US" style=3D"fon=
t-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:=
windowtext;text-decoration:none">116</span></a><span lang=3D"EN-US" style=
=3D"font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;=
">=C2=A0=C2=A0 0) [suppressed in audit_alloc]<u></u><u></u></span></pre><pr=
e><a name=3D"14d21d7a7c1f2c03_117"></a><a href=3D"http://10.38.120.31:8080/=
source/xref/pxa1928-lp5.0/kernel/kernel/audit.c#117" target=3D"_blank"><spa=
n lang=3D"EN-US" style=3D"font-size:10.5pt;font-family:&quot;Calibri&quot;,=
&quot;sans-serif&quot;;color:windowtext;text-decoration:none">117</span></a=
><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-family:&quot;Calibri&q=
uot;,&quot;sans-serif&quot;">=C2=A0=C2=A0 1) out of memory in audit_log_sta=
rt [kmalloc of struct audit_buffer]<u></u><u></u></span></pre><pre><a name=
=3D"14d21d7a7c1f2c03_118"></a><a href=3D"http://10.38.120.31:8080/source/xr=
ef/pxa1928-lp5.0/kernel/kernel/audit.c#118" target=3D"_blank"><span lang=3D=
"EN-US" style=3D"font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;san=
s-serif&quot;;color:windowtext;text-decoration:none">118</span></a><span la=
ng=3D"EN-US" style=3D"font-size:10.5pt;font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;">=C2=A0=C2=A0 2) out of memory in audit_log_move [alloc_=
skb]<u></u><u></u></span></pre><pre><a name=3D"14d21d7a7c1f2c03_119"></a><a=
 href=3D"http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/a=
udit.c#119" target=3D"_blank"><span lang=3D"EN-US" style=3D"font-size:10.5p=
t;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:windowtext;t=
ext-decoration:none">119</span></a><span lang=3D"EN-US" style=3D"font-size:=
10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;">=C2=A0=C2=A0=
 3) suppressed due to audit_rate_limit<u></u><u></u></span></pre><pre><a na=
me=3D"14d21d7a7c1f2c03_120"></a><a href=3D"http://10.38.120.31:8080/source/=
xref/pxa1928-lp5.0/kernel/kernel/audit.c#120" target=3D"_blank"><span lang=
=3D"EN-US" style=3D"font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;=
sans-serif&quot;;color:windowtext;text-decoration:none">120</span></a><span=
 lang=3D"EN-US" style=3D"font-size:10.5pt;font-family:&quot;Calibri&quot;,&=
quot;sans-serif&quot;">=C2=A0=C2=A0 4) suppressed due to audit_backlog_limi=
t<u></u><u></u></span></pre><pre><a name=3D"14d21d7a7c1f2c03_121"></a><a hr=
ef=3D"http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/audi=
t.c#121" target=3D"_blank"><span lang=3D"EN-US" style=3D"font-size:10.5pt;f=
ont-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:windowtext;text=
-decoration:none">121</span></a><span lang=3D"EN-US" style=3D"font-size:10.=
5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;">*/<u></u><u></u=
></span></pre><p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u><=
/u></span></p><p class=3D"MsoNormal"><span lang=3D"EN-US">So is this the ro=
ot-cause of my issue ? How can I modify kernel code to archieve my purpose =
or there already is a open/off switch to help me on giving all the logs in =
one time test ? <u></u><u></u></span></p><p class=3D"MsoNormal"><span lang=
=3D"EN-US"><u></u>=C2=A0<u></u></span></p><p class=3D"MsoNormal"><span lang=
=3D"EN-US">Thanks<u></u><u></u></span></p><p class=3D"MsoNormal"><span lang=
=3D"EN-US">Sincerely<u></u><u></u></span></p><p class=3D"MsoNormal"><span l=
ang=3D"EN-US">Alan Xin<u></u><u></u></span></p><p class=3D"MsoNormal"><span=
 lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p><p class=3D"MsoNormal"><span=
 lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p></div></div><br>____________=
___________________________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br></blo=
ckquote></div>

--047d7b86de869797b205154c8e89--
