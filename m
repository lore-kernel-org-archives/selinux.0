Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t458dBY2017522
 for <selinux@tycho.nsa.gov>; Tue, 5 May 2015 04:39:14 -0400
Received: by ykft189 with SMTP id t189so39417174ykf.1
 for <selinux@tycho.nsa.gov>; Tue, 05 May 2015 01:39:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <F766E4F80769BD478052FB6533FA745D66611C40DE@SC-VEXCH4.marvell.com>
References: <F766E4F80769BD478052FB6533FA745D66611C3FD9@SC-VEXCH4.marvell.com>
 <CAFftDdqp06sbW9chUrzS0RaNgrqv=W5=3nP9VcFnYrzOkUkf5Q@mail.gmail.com>
 <CACikiw07wGq+Pp_QjnXnUAhHsBe48X4Kpr25MzJyB5Xby_gQ9g@mail.gmail.com>
 <F766E4F80769BD478052FB6533FA745D66611C40DE@SC-VEXCH4.marvell.com>
Date: Tue, 5 May 2015 14:09:11 +0530
Message-ID: <CA+XqU8iaVZZM5Z2fwDMBtJeMS3OV4dQh797BTTQ8b91SOh-9Ew@mail.gmail.com>
Subject: Re: Give out all the avc logs in ome time
From: Gaurav Gangwar <gauravgangwaar@gmail.com>
To: Zhi Xin <xinzhi@marvell.com>
Content-Type: multipart/alternative; boundary=001a113a62dad433c70515519ccd
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113a62dad433c70515519ccd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Alan,

Do flash all the images every-time or just the boot image.
if you flash only boot-image then that could be reason.

Thanks and Regards
Gaurav Gangwar

On 5 May 2015 at 13:02, Zhi Xin <xinzhi@marvell.com> wrote:

> Hi  Ravi,
>
>
>
> Thanks for analysis. I get your point. Under enforcing, if open is
> blocked, we never see the ioctl operation come. I agreed with you analysi=
s.
>
>
>
> But my issue is not like this. The issue I try to say is that even under
> permissive, selinux cannot give out all the avc log in one time.
>
>
>
> My previous example is probably not a good one. I=E2=80=99d like to give =
a new
> one. For a new phone with Android lp5.0 that enabled permissive mode of
> SEAndroid, it reports lots of avc deny logs in one boot.  And after I fix
> them by adding selinux policy, reburn the boot.img and boot again. I can
> still get avc logs, which are different from previous. Why they cannot be
> printed out in one time ?
>
>
>
> Thanks.
>
> Sincerely
>
> Zhi Xin
>
>
>
>
>
> *From:* Ravi Kumar [mailto:nxp.ravi@gmail.com]
> *Sent:* 2015=E5=B9=B45=E6=9C=885=E6=97=A5 13:56
> *To:* William Roberts
> *Cc:* Zhi Xin; selinux@tycho.nsa.gov
> *Subject:* Re: Give out all the avc logs in ome time
>
>
>
> Alan,
>
> Code written in most of the cases will be checking for success on   file
> open or device node open . Which is basically a  check on  file descripto=
r
> (fd)   if its null ( may be failed due to  selinux policy missing)  it
> comes out of the code and never try to do a IOCTL / or any other  operati=
on
> on the null  fd  so we will not see any additional  denials  until we
> address the open.
>
> As a generally practice what i feel recommending  is  set the selinux mod=
e
> in permissive and capture all the denials at ONE shot . Based on the
> denials logs collected it will be easy for us to write / define the polic=
y
> at a single shot .
>
> you can use kernel cmdline for setting it in permissive  or use
> "setenforce " cmd from root shell .
>
>
>
> Regards,
>
> Ravi
>
>
>
>
>
>
>
> On Tue, May 5, 2015 at 8:07 AM, William Roberts <bill.c.roberts@gmail.com=
>
> wrote:
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
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
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

--001a113a62dad433c70515519ccd
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Alan,<div><br></div><div>Do flash all the images every-=
time or just the boot image.</div><div>if you flash only boot-image then th=
at could be reason.</div><div><br></div><div>Thanks and Regards</div><div>G=
aurav Gangwar</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail=
_quote">On 5 May 2015 at 13:02, Zhi Xin <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:xinzhi@marvell.com" target=3D"_blank">xinzhi@marvell.com</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div lang=3D"ZH-CN" link=3D"blue=
" vlink=3D"purple"><div><p class=3D"MsoNormal"><span lang=3D"EN-US" style=
=3D"font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;=
;color:#1f497d">Hi=C2=A0 Ravi,<u></u><u></u></span></p><p class=3D"MsoNorma=
l"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-family:&quot;Calibri=
&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=A0<u></u></span></p=
><p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font=
-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">Thanks fo=
r analysis. I get your point. Under enforcing, if open is blocked, we never=
 see the ioctl operation come. I agreed with you analysis.<u></u><u></u></s=
pan></p><p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5=
pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u=
></u>=C2=A0<u></u></span></p><p class=3D"MsoNormal"><span lang=3D"EN-US" st=
yle=3D"font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&qu=
ot;;color:#1f497d">But my issue is not like this. The issue I try to say is=
</span><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-family:&quot;Cal=
ibri&quot;,&quot;sans-serif&quot;;color:red"> that even under permissive, s=
elinux cannot give out all the avc log in one time. </span><span lang=3D"EN=
-US" style=3D"font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-s=
erif&quot;;color:#1f497d"><u></u><u></u></span></p><p class=3D"MsoNormal"><=
span lang=3D"EN-US" style=3D"font-size:10.5pt;font-family:&quot;Calibri&quo=
t;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=A0<u></u></span></p><p =
class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-fam=
ily:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">My previous e=
xample is probably not a good one. I=E2=80=99d like to give a new one. For =
a new phone with Android lp5.0 that enabled permissive mode of SEAndroid, i=
t reports lots of avc deny logs in one boot.=C2=A0 And after I fix them by =
adding selinux policy, reburn the boot.img and boot again. I can still get =
avc logs, which are different from previous. Why they cannot be printed out=
 in one time ? <u></u><u></u></span></p><p class=3D"MsoNormal"><span lang=
=3D"EN-US" style=3D"font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;=
sans-serif&quot;;color:#1f497d"><u></u>=C2=A0<u></u></span></p><p class=3D"=
MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-family:&quot=
;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">Thanks.<u></u><u></u><=
/span></p><p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10=
.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">=
Sincerely<u></u><u></u></span></p><p class=3D"MsoNormal"><span lang=3D"EN-U=
S" style=3D"font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-ser=
if&quot;;color:#1f497d">Zhi Xin<u></u><u></u></span></p><p class=3D"MsoNorm=
al"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-family:&quot;Calibr=
i&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=A0<u></u></span></=
p><p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;fon=
t-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=
=C2=A0<u></u></span></p><div style=3D"border:none;border-top:solid #b5c4df =
1.0pt;padding:3.0pt 0cm 0cm 0cm"><p class=3D"MsoNormal"><b><span lang=3D"EN=
-US" style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-se=
rif&quot;">From:</span></b><span lang=3D"EN-US" style=3D"font-size:10.0pt;f=
ont-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> Ravi Kumar [mailto:<=
a href=3D"mailto:nxp.ravi@gmail.com" target=3D"_blank">nxp.ravi@gmail.com</=
a>] <br><b>Sent:</b> 2015</span><span style=3D"font-size:10.0pt">=E5=B9=B4<=
/span><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;Taho=
ma&quot;,&quot;sans-serif&quot;">5</span><span style=3D"font-size:10.0pt">=
=E6=9C=88</span><span lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:=
&quot;Tahoma&quot;,&quot;sans-serif&quot;">5</span><span style=3D"font-size=
:10.0pt">=E6=97=A5</span><span lang=3D"EN-US" style=3D"font-size:10.0pt;fon=
t-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> 13:56<br><b>To:</b> Wi=
lliam Roberts<br><b>Cc:</b> Zhi Xin; <a href=3D"mailto:selinux@tycho.nsa.go=
v" target=3D"_blank">selinux@tycho.nsa.gov</a><br><b>Subject:</b> Re: Give =
out all the avc logs in ome time<u></u><u></u></span></p></div><p class=3D"=
MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p><div><div><d=
iv><p class=3D"MsoNormal"><span lang=3D"EN-US">Alan, <u></u><u></u></span><=
/p></div><p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=
=3D"EN-US">Code written in most of the cases will be checking for success o=
n =C2=A0 file open or device node open . Which is basically a=C2=A0 check o=
n=C2=A0 file descriptor (fd) =C2=A0 if its null ( may be failed due to=C2=
=A0 selinux policy missing)=C2=A0 it=C2=A0 comes out of the code and never =
try to do a IOCTL / or any other=C2=A0 operation on the null=C2=A0 fd=C2=A0=
 so we will not see any additional=C2=A0 denials=C2=A0 until we address the=
 open. <u></u><u></u></span></p></div><div><p class=3D"MsoNormal" style=3D"=
margin-bottom:12.0pt"><span lang=3D"EN-US">As a generally practice what i f=
eel recommending=C2=A0 is=C2=A0 set the selinux mode in permissive and capt=
ure all the denials at ONE shot . Based on the denials logs collected it wi=
ll be easy for us to write / define the policy at a single shot .=C2=A0 <u>=
</u><u></u></span></p></div><div><p class=3D"MsoNormal"><span lang=3D"EN-US=
">you can use kernel cmdline for setting it in permissive=C2=A0 or use=C2=
=A0 &quot;setenforce &quot; cmd from root shell .=C2=A0 <u></u><u></u></spa=
n></p></div><div><p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<=
u></u></span></p></div><div><p class=3D"MsoNormal"><span lang=3D"EN-US">Reg=
ards,<u></u><u></u></span></p></div><div><p class=3D"MsoNormal"><span lang=
=3D"EN-US">Ravi<u></u><u></u></span></p></div><div><p class=3D"MsoNormal"><=
span lang=3D"EN-US"><br><br>=C2=A0 <u></u><u></u></span></p></div></div><di=
v><p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></=
p><div><p class=3D"MsoNormal"><span lang=3D"EN-US">On Tue, May 5, 2015 at 8=
:07 AM, William Roberts &lt;<a href=3D"mailto:bill.c.roberts@gmail.com" tar=
get=3D"_blank">bill.c.roberts@gmail.com</a>&gt; wrote:<u></u><u></u></span>=
</p><p><span lang=3D"EN-US">Are you running in permissive or enforcing mode=
? Usually if you&#39;re running in enforcing mode the daemon will not be ab=
le to perform all of its tasks that it normally would thus your missing mes=
sages<u></u><u></u></span></p><div><div><div><p class=3D"MsoNormal"><span l=
ang=3D"EN-US">On May 4, 2015 7:11 PM, &quot;Zhi Xin&quot; &lt;<a href=3D"ma=
ilto:xinzhi@marvell.com" target=3D"_blank">xinzhi@marvell.com</a>&gt; wrote=
:<u></u><u></u></span></p></div></div><blockquote style=3D"border:none;bord=
er-left:solid #cccccc 1.0pt;padding:0cm 0cm 0cm 6.0pt;margin-left:4.8pt;mar=
gin-right:0cm"><div><div><div><div><p class=3D"MsoNormal"><span lang=3D"EN-=
US">Hi All,<u></u><u></u></span></p><p class=3D"MsoNormal"><span lang=3D"EN=
-US">=C2=A0<u></u><u></u></span></p><p class=3D"MsoNormal"><span lang=3D"EN=
-US">In my daily work, I=E2=80=99m always solving the selinux deny as prese=
nted by avc log. But I found that, for one particular test, selinux cannot =
give me all the avc deny log in one time, which has slowed down a lot of my=
 daily work.<u></u><u></u></span></p><p class=3D"MsoNormal"><span lang=3D"E=
N-US">=C2=A0<u></u><u></u></span></p><p class=3D"MsoNormal"><span lang=3D"E=
N-US">For example, I trigger a process called test_daemon to access a /dev/=
test_device in a particular test. Totally, it should have =E2=80=9Copen, re=
ad, write, ioctl=E2=80=9D for permissions. But for one time test, I only ca=
tch =E2=80=9Copen, read=E2=80=9D related avc log. And only after I have mer=
ged a patch to give the =E2=80=9Copen=E2=80=9D and =E2=80=9Cread=E2=80=9D p=
ermission, I rerun the test. The =E2=80=9Cwrite ioctl=E2=80=9D related avc =
=C2=A0logs start to occur. So my question is how can I get =E2=80=9Copen, r=
ead, write, ioctl=E2=80=9D avc log in one test.<u></u><u></u></span></p><p =
class=3D"MsoNormal"><span lang=3D"EN-US">=C2=A0<u></u><u></u></span></p><p =
class=3D"MsoNormal"><span lang=3D"EN-US">I have done a little study on this=
 issue. selinux avc log depends on audit subsystem. In /kernel/kernel/audit=
.c, some code has indicated that we may lost the records in five ways:<u></=
u><u></u></span></p><pre><a name=3D"14d2301c6cb57c75_14d21f2f9342b644_14d21=
d7a7c1f2c03_115"></a><span lang=3D"EN-US"><a href=3D"http://10.38.120.31:80=
80/source/xref/pxa1928-lp5.0/kernel/kernel/audit.c#115" target=3D"_blank"><=
span style=3D"font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-s=
erif&quot;;color:windowtext;text-decoration:none">115</span></a></span><spa=
n lang=3D"EN-US" style=3D"font-size:10.5pt;font-family:&quot;Calibri&quot;,=
&quot;sans-serif&quot;">/* Records can be lost in several ways:</span><span=
 lang=3D"EN-US"><u></u><u></u></span></pre><pre><a name=3D"14d2301c6cb57c75=
_14d21f2f9342b644_14d21d7a7c1f2c03_116"></a><span lang=3D"EN-US"><a href=3D=
"http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/audit.c#1=
16" target=3D"_blank"><span style=3D"font-size:10.5pt;font-family:&quot;Cal=
ibri&quot;,&quot;sans-serif&quot;;color:windowtext;text-decoration:none">11=
6</span></a></span><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-fami=
ly:&quot;Calibri&quot;,&quot;sans-serif&quot;">=C2=A0=C2=A0 0) [suppressed =
in audit_alloc]</span><span lang=3D"EN-US"><u></u><u></u></span></pre><pre>=
<a name=3D"14d2301c6cb57c75_14d21f2f9342b644_14d21d7a7c1f2c03_117"></a><spa=
n lang=3D"EN-US"><a href=3D"http://10.38.120.31:8080/source/xref/pxa1928-lp=
5.0/kernel/kernel/audit.c#117" target=3D"_blank"><span style=3D"font-size:1=
0.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:windowte=
xt;text-decoration:none">117</span></a></span><span lang=3D"EN-US" style=3D=
"font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;">=
=C2=A0=C2=A0 1) out of memory in audit_log_start [kmalloc of struct audit_b=
uffer]</span><span lang=3D"EN-US"><u></u><u></u></span></pre><pre><a name=
=3D"14d2301c6cb57c75_14d21f2f9342b644_14d21d7a7c1f2c03_118"></a><span lang=
=3D"EN-US"><a href=3D"http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/ke=
rnel/kernel/audit.c#118" target=3D"_blank"><span style=3D"font-size:10.5pt;=
font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:windowtext;tex=
t-decoration:none">118</span></a></span><span lang=3D"EN-US" style=3D"font-=
size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;">=C2=A0=
=C2=A0 2) out of memory in audit_log_move [alloc_skb]</span><span lang=3D"E=
N-US"><u></u><u></u></span></pre><pre><a name=3D"14d2301c6cb57c75_14d21f2f9=
342b644_14d21d7a7c1f2c03_119"></a><span lang=3D"EN-US"><a href=3D"http://10=
.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/audit.c#119" target=
=3D"_blank"><span style=3D"font-size:10.5pt;font-family:&quot;Calibri&quot;=
,&quot;sans-serif&quot;;color:windowtext;text-decoration:none">119</span></=
a></span><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-family:&quot;C=
alibri&quot;,&quot;sans-serif&quot;">=C2=A0=C2=A0 3) suppressed due to audi=
t_rate_limit</span><span lang=3D"EN-US"><u></u><u></u></span></pre><pre><a =
name=3D"14d2301c6cb57c75_14d21f2f9342b644_14d21d7a7c1f2c03_120"></a><span l=
ang=3D"EN-US"><a href=3D"http://10.38.120.31:8080/source/xref/pxa1928-lp5.0=
/kernel/kernel/audit.c#120" target=3D"_blank"><span style=3D"font-size:10.5=
pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:windowtext;=
text-decoration:none">120</span></a></span><span lang=3D"EN-US" style=3D"fo=
nt-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;">=C2=
=A0=C2=A0 4) suppressed due to audit_backlog_limit</span><span lang=3D"EN-U=
S"><u></u><u></u></span></pre><pre><a name=3D"14d2301c6cb57c75_14d21f2f9342=
b644_14d21d7a7c1f2c03_121"></a><span lang=3D"EN-US"><a href=3D"http://10.38=
.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/audit.c#121" target=3D=
"_blank"><span style=3D"font-size:10.5pt;font-family:&quot;Calibri&quot;,&q=
uot;sans-serif&quot;;color:windowtext;text-decoration:none">121</span></a><=
/span><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-family:&quot;Cali=
bri&quot;,&quot;sans-serif&quot;">*/</span><span lang=3D"EN-US"><u></u><u><=
/u></span></pre><p class=3D"MsoNormal"><span lang=3D"EN-US">=C2=A0<u></u><u=
></u></span></p><p class=3D"MsoNormal"><span lang=3D"EN-US">So is this the =
root-cause of my issue ? How can I modify kernel code to archieve my purpos=
e or there already is a open/off switch to help me on giving all the logs i=
n one time test ? <u></u><u></u></span></p><p class=3D"MsoNormal"><span lan=
g=3D"EN-US">=C2=A0<u></u><u></u></span></p><p class=3D"MsoNormal"><span lan=
g=3D"EN-US">Thanks<u></u><u></u></span></p><p class=3D"MsoNormal"><span lan=
g=3D"EN-US">Sincerely<u></u><u></u></span></p><p class=3D"MsoNormal"><span =
lang=3D"EN-US">Alan Xin<u></u><u></u></span></p><p class=3D"MsoNormal"><spa=
n lang=3D"EN-US">=C2=A0<u></u><u></u></span></p><p class=3D"MsoNormal"><spa=
n lang=3D"EN-US">=C2=A0<u></u><u></u></span></p></div></div><p class=3D"Mso=
Normal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p></div></div><p =
class=3D"MsoNormal"><span lang=3D"EN-US">__________________________________=
_____________<br>Selinux mailing list<br><a href=3D"mailto:Selinux@tycho.ns=
a.gov" target=3D"_blank">Selinux@tycho.nsa.gov</a><br>To unsubscribe, send =
email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov" target=3D"_blank">S=
elinux-leave@tycho.nsa.gov</a>.<br>To get help, send an email containing &q=
uot;help&quot; to <a href=3D"mailto:Selinux-request@tycho.nsa.gov" target=
=3D"_blank">Selinux-request@tycho.nsa.gov</a>.<u></u><u></u></span></p></bl=
ockquote></div><p class=3D"MsoNormal"><span lang=3D"EN-US"><br>____________=
___________________________________<br>Selinux mailing list<br><a href=3D"m=
ailto:Selinux@tycho.nsa.gov" target=3D"_blank">Selinux@tycho.nsa.gov</a><br=
>To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.go=
v" target=3D"_blank">Selinux-leave@tycho.nsa.gov</a>.<br>To get help, send =
an email containing &quot;help&quot; to <a href=3D"mailto:Selinux-request@t=
ycho.nsa.gov" target=3D"_blank">Selinux-request@tycho.nsa.gov</a>.<u></u><u=
></u></span></p></div><p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=
=C2=A0<u></u></span></p></div></div></div><br>_____________________________=
__________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br></blo=
ckquote></div><br></div>

--001a113a62dad433c70515519ccd--
