Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t452pmtG030287
 for <selinux@tycho.nsa.gov>; Mon, 4 May 2015 22:51:48 -0400
Received: by widdi4 with SMTP id di4so129705203wid.0
 for <selinux@tycho.nsa.gov>; Mon, 04 May 2015 19:51:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <F766E4F80769BD478052FB6533FA745D66611C4006@SC-VEXCH4.marvell.com>
References: <F766E4F80769BD478052FB6533FA745D66611C3FD9@SC-VEXCH4.marvell.com>
 <CAFftDdqp06sbW9chUrzS0RaNgrqv=W5=3nP9VcFnYrzOkUkf5Q@mail.gmail.com>
 <F766E4F80769BD478052FB6533FA745D66611C4006@SC-VEXCH4.marvell.com>
Date: Mon, 4 May 2015 19:51:45 -0700
Message-ID: <CAFftDdqMvrPLBb=854+_1H4kEr3NHQrmQdvUCdhicx-RDUxw+Q@mail.gmail.com>
Subject: RE: Give out all the avc logs in ome time
From: William Roberts <bill.c.roberts@gmail.com>
To: Zhi Xin <xinzhi@marvell.com>
Content-Type: multipart/alternative; boundary=047d7bfcfa0a5b9e8605154cc2ae
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--047d7bfcfa0a5b9e8605154cc2ae
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Outside of the fact that I see Linux will only print the first denial and
permissive and perhaps your logs are rolling over or something like that I
have no idea. SELinux and the audit framework in general will never miss a
message with the exception of a full message queue or some exceptional case=
.

Perhaps sds can shed some light on it that I'm not aware of
 On May 4, 2015 7:43 PM, "Zhi Xin" <xinzhi@marvell.com> wrote:

> Hi  William,
>
>
>
> In my experience, under permissive, we can indeed get more avc log than
> enforcing but it still cannot give all the deny log in one time. Usually,
> it require 2-3 round of policy adding for a complicated issue even under
> permissive.
>
>
>
> Any clue about this ?
>
>
>
> Thanks.
>
> Sincerely
>
> Alan Xin
>
>
>
> *From:* William Roberts [mailto:bill.c.roberts@gmail.com]
> *Sent:* 2015=E5=B9=B45=E6=9C=885=E6=97=A5 10:37
> *To:* Zhi Xin
> *Cc:* selinux@tycho.nsa.gov
> *Subject:* Re: Give out all the avc logs in ome time
>
>
>
> Are you running in permissive or enforcing mode? Usually if you're runnin=
g
> in enforcing mode the daemon will not be able to perform all of its tasks
> that it normally would thus your missing messages
>
> On May 4, 2015 7:11 PM, "Zhi Xin" <xinzhi@marvell.com> wrote:
>
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
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>

--047d7bfcfa0a5b9e8605154cc2ae
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Outside of the fact that I see Linux will only print the fir=
st denial and permissive and perhaps your logs are rolling over or somethin=
g like that I have no idea. SELinux and the audit framework in general will=
 never miss a message with the exception of a full message queue or some ex=
ceptional case.</p>
<p dir=3D"ltr">Perhaps sds can shed some light on it that I&#39;m not aware=
 of<br>
</p>
<div class=3D"gmail_quote">On May 4, 2015 7:43 PM, &quot;Zhi Xin&quot; &lt;=
<a href=3D"mailto:xinzhi@marvell.com">xinzhi@marvell.com</a>&gt; wrote:<br =
type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div lang=3D"ZH-CN" lin=
k=3D"blue" vlink=3D"purple"><div><p class=3D"MsoNormal"><span lang=3D"EN-US=
" style=3D"font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-seri=
f&quot;;color:#1f497d">Hi=C2=A0 William,<u></u><u></u></span></p><p class=
=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-family:&=
quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=A0<u></=
u></span></p><p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size=
:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497=
d">In my experience, under permissive, we can indeed get more avc log than =
enforcing but it still cannot give all the deny log in one time. Usually, i=
t require 2-3 round of policy adding for a complicated issue even under per=
missive. <u></u><u></u></span></p><p class=3D"MsoNormal"><span lang=3D"EN-U=
S" style=3D"font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-ser=
if&quot;;color:#1f497d"><u></u>=C2=A0<u></u></span></p><p class=3D"MsoNorma=
l"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-family:&quot;Calibri=
&quot;,&quot;sans-serif&quot;;color:#1f497d">Any clue about this ? <u></u><=
u></u></span></p><p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-=
size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1=
f497d"><u></u>=C2=A0<u></u></span></p><p class=3D"MsoNormal"><span lang=3D"=
EN-US" style=3D"font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans=
-serif&quot;;color:#1f497d">Thanks.<u></u><u></u></span></p><p class=3D"Mso=
Normal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d">Sincerely<u></u><u></u></=
span></p><p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.=
5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">A=
lan Xin<u></u><u></u></span></p><p class=3D"MsoNormal"><span lang=3D"EN-US"=
 style=3D"font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif=
&quot;;color:#1f497d"><u></u>=C2=A0<u></u></span></p><div style=3D"border:n=
one;border-top:solid #b5c4df 1.0pt;padding:3.0pt 0cm 0cm 0cm"><p class=3D"M=
soNormal"><b><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&qu=
ot;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span lang=3D"EN-US=
" style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif=
&quot;"> William Roberts [mailto:<a href=3D"mailto:bill.c.roberts@gmail.com=
" target=3D"_blank">bill.c.roberts@gmail.com</a>] <br><b>Sent:</b> 2015</sp=
an><span style=3D"font-size:10.0pt">=E5=B9=B4</span><span lang=3D"EN-US" st=
yle=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quo=
t;">5</span><span style=3D"font-size:10.0pt">=E6=9C=88</span><span lang=3D"=
EN-US" style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-=
serif&quot;">5</span><span style=3D"font-size:10.0pt">=E6=97=A5</span><span=
 lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&q=
uot;sans-serif&quot;"> 10:37<br><b>To:</b> Zhi Xin<br><b>Cc:</b> <a href=3D=
"mailto:selinux@tycho.nsa.gov" target=3D"_blank">selinux@tycho.nsa.gov</a><=
br><b>Subject:</b> Re: Give out all the avc logs in ome time<u></u><u></u><=
/span></p></div><p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u=
></u></span></p><p><span lang=3D"EN-US">Are you running in permissive or en=
forcing mode? Usually if you&#39;re running in enforcing mode the daemon wi=
ll not be able to perform all of its tasks that it normally would thus your=
 missing messages<u></u><u></u></span></p><div><p class=3D"MsoNormal"><span=
 lang=3D"EN-US">On May 4, 2015 7:11 PM, &quot;Zhi Xin&quot; &lt;<a href=3D"=
mailto:xinzhi@marvell.com" target=3D"_blank">xinzhi@marvell.com</a>&gt; wro=
te:<u></u><u></u></span></p><div><div><p class=3D"MsoNormal"><span lang=3D"=
EN-US">Hi All,<u></u><u></u></span></p><p class=3D"MsoNormal"><span lang=3D=
"EN-US">=C2=A0<u></u><u></u></span></p><p class=3D"MsoNormal"><span lang=3D=
"EN-US">In my daily work, I=E2=80=99m always solving the selinux deny as pr=
esented by avc log. But I found that, for one particular test, selinux cann=
ot give me all the avc deny log in one time, which has slowed down a lot of=
 my daily work.<u></u><u></u></span></p><p class=3D"MsoNormal"><span lang=
=3D"EN-US">=C2=A0<u></u><u></u></span></p><p class=3D"MsoNormal"><span lang=
=3D"EN-US">For example, I trigger a process called test_daemon to access a =
/dev/test_device in a particular test. Totally, it should have =E2=80=9Cope=
n, read, write, ioctl=E2=80=9D for permissions. But for one time test, I on=
ly catch =E2=80=9Copen, read=E2=80=9D related avc log. And only after I hav=
e merged a patch to give the =E2=80=9Copen=E2=80=9D and =E2=80=9Cread=E2=80=
=9D permission, I rerun the test. The =E2=80=9Cwrite ioctl=E2=80=9D related=
 avc =C2=A0logs start to occur. So my question is how can I get =E2=80=9Cop=
en, read, write, ioctl=E2=80=9D avc log in one test.<u></u><u></u></span></=
p><p class=3D"MsoNormal"><span lang=3D"EN-US">=C2=A0<u></u><u></u></span></=
p><p class=3D"MsoNormal"><span lang=3D"EN-US">I have done a little study on=
 this issue. selinux avc log depends on audit subsystem. In /kernel/kernel/=
audit.c, some code has indicated that we may lost the records in five ways:=
<u></u><u></u></span></p><pre><a name=3D"14d21f51300672cf_14d21d7a7c1f2c03_=
115"></a><span lang=3D"EN-US"><a href=3D"http://10.38.120.31:8080/source/xr=
ef/pxa1928-lp5.0/kernel/kernel/audit.c#115" target=3D"_blank"><span style=
=3D"font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;=
;color:windowtext;text-decoration:none">115</span></a></span><span lang=3D"=
EN-US" style=3D"font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans=
-serif&quot;">/* Records can be lost in several ways:</span><span lang=3D"E=
N-US"><u></u><u></u></span></pre><pre><a name=3D"14d21f51300672cf_14d21d7a7=
c1f2c03_116"></a><span lang=3D"EN-US"><a href=3D"http://10.38.120.31:8080/s=
ource/xref/pxa1928-lp5.0/kernel/kernel/audit.c#116" target=3D"_blank"><span=
 style=3D"font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif=
&quot;;color:windowtext;text-decoration:none">116</span></a></span><span la=
ng=3D"EN-US" style=3D"font-size:10.5pt;font-family:&quot;Calibri&quot;,&quo=
t;sans-serif&quot;">=C2=A0=C2=A0 0) [suppressed in audit_alloc]</span><span=
 lang=3D"EN-US"><u></u><u></u></span></pre><pre><a name=3D"14d21f51300672cf=
_14d21d7a7c1f2c03_117"></a><span lang=3D"EN-US"><a href=3D"http://10.38.120=
.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/audit.c#117" target=3D"_bl=
ank"><span style=3D"font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;=
sans-serif&quot;;color:windowtext;text-decoration:none">117</span></a></spa=
n><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-family:&quot;Calibri&=
quot;,&quot;sans-serif&quot;">=C2=A0=C2=A0 1) out of memory in audit_log_st=
art [kmalloc of struct audit_buffer]</span><span lang=3D"EN-US"><u></u><u><=
/u></span></pre><pre><a name=3D"14d21f51300672cf_14d21d7a7c1f2c03_118"></a>=
<span lang=3D"EN-US"><a href=3D"http://10.38.120.31:8080/source/xref/pxa192=
8-lp5.0/kernel/kernel/audit.c#118" target=3D"_blank"><span style=3D"font-si=
ze:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:wind=
owtext;text-decoration:none">118</span></a></span><span lang=3D"EN-US" styl=
e=3D"font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot=
;">=C2=A0=C2=A0 2) out of memory in audit_log_move [alloc_skb]</span><span =
lang=3D"EN-US"><u></u><u></u></span></pre><pre><a name=3D"14d21f51300672cf_=
14d21d7a7c1f2c03_119"></a><span lang=3D"EN-US"><a href=3D"http://10.38.120.=
31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/audit.c#119" target=3D"_bla=
nk"><span style=3D"font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;s=
ans-serif&quot;;color:windowtext;text-decoration:none">119</span></a></span=
><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-family:&quot;Calibri&q=
uot;,&quot;sans-serif&quot;">=C2=A0=C2=A0 3) suppressed due to audit_rate_l=
imit</span><span lang=3D"EN-US"><u></u><u></u></span></pre><pre><a name=3D"=
14d21f51300672cf_14d21d7a7c1f2c03_120"></a><span lang=3D"EN-US"><a href=3D"=
http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/audit.c#12=
0" target=3D"_blank"><span style=3D"font-size:10.5pt;font-family:&quot;Cali=
bri&quot;,&quot;sans-serif&quot;;color:windowtext;text-decoration:none">120=
</span></a></span><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-famil=
y:&quot;Calibri&quot;,&quot;sans-serif&quot;">=C2=A0=C2=A0 4) suppressed du=
e to audit_backlog_limit</span><span lang=3D"EN-US"><u></u><u></u></span></=
pre><pre><a name=3D"14d21f51300672cf_14d21d7a7c1f2c03_121"></a><span lang=
=3D"EN-US"><a href=3D"http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/ke=
rnel/kernel/audit.c#121" target=3D"_blank"><span style=3D"font-size:10.5pt;=
font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:windowtext;tex=
t-decoration:none">121</span></a></span><span lang=3D"EN-US" style=3D"font-=
size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;">*/</spa=
n><span lang=3D"EN-US"><u></u><u></u></span></pre><p class=3D"MsoNormal"><s=
pan lang=3D"EN-US">=C2=A0<u></u><u></u></span></p><p class=3D"MsoNormal"><s=
pan lang=3D"EN-US">So is this the root-cause of my issue ? How can I modify=
 kernel code to archieve my purpose or there already is a open/off switch t=
o help me on giving all the logs in one time test ? <u></u><u></u></span></=
p><p class=3D"MsoNormal"><span lang=3D"EN-US">=C2=A0<u></u><u></u></span></=
p><p class=3D"MsoNormal"><span lang=3D"EN-US">Thanks<u></u><u></u></span></=
p><p class=3D"MsoNormal"><span lang=3D"EN-US">Sincerely<u></u><u></u></span=
></p><p class=3D"MsoNormal"><span lang=3D"EN-US">Alan Xin<u></u><u></u></sp=
an></p><p class=3D"MsoNormal"><span lang=3D"EN-US">=C2=A0<u></u><u></u></sp=
an></p><p class=3D"MsoNormal"><span lang=3D"EN-US">=C2=A0<u></u><u></u></sp=
an></p></div></div><p class=3D"MsoNormal"><span lang=3D"EN-US"><br>________=
_______________________________________<br>Selinux mailing list<br><a href=
=3D"mailto:Selinux@tycho.nsa.gov" target=3D"_blank">Selinux@tycho.nsa.gov</=
a><br>To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.n=
sa.gov" target=3D"_blank">Selinux-leave@tycho.nsa.gov</a>.<br>To get help, =
send an email containing &quot;help&quot; to <a href=3D"mailto:Selinux-requ=
est@tycho.nsa.gov" target=3D"_blank">Selinux-request@tycho.nsa.gov</a>.<u><=
/u><u></u></span></p></div></div></div></blockquote></div>

--047d7bfcfa0a5b9e8605154cc2ae--
