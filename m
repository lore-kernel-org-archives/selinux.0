Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t455ttKn008467
 for <selinux@tycho.nsa.gov>; Tue, 5 May 2015 01:55:55 -0400
Received: by labbd9 with SMTP id bd9so119373449lab.2
 for <selinux@tycho.nsa.gov>; Mon, 04 May 2015 22:55:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFftDdqp06sbW9chUrzS0RaNgrqv=W5=3nP9VcFnYrzOkUkf5Q@mail.gmail.com>
References: <F766E4F80769BD478052FB6533FA745D66611C3FD9@SC-VEXCH4.marvell.com>
 <CAFftDdqp06sbW9chUrzS0RaNgrqv=W5=3nP9VcFnYrzOkUkf5Q@mail.gmail.com>
Date: Tue, 5 May 2015 11:25:49 +0530
Message-ID: <CACikiw07wGq+Pp_QjnXnUAhHsBe48X4Kpr25MzJyB5Xby_gQ9g@mail.gmail.com>
Subject: Re: Give out all the avc logs in ome time
From: Ravi Kumar <nxp.ravi@gmail.com>
To: William Roberts <bill.c.roberts@gmail.com>
Content-Type: multipart/alternative; boundary=001a11c27b7aa0d3b905154f5451
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11c27b7aa0d3b905154f5451
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Alan,
Code written in most of the cases will be checking for success on   file
open or device node open . Which is basically a  check on  file descriptor
(fd)   if its null ( may be failed due to  selinux policy missing)  it
comes out of the code and never try to do a IOCTL / or any other  operation
on the null  fd  so we will not see any additional  denials  until we
address the open.

As a generally practice what i feel recommending  is  set the selinux mode
in permissive and capture all the denials at ONE shot . Based on the
denials logs collected it will be easy for us to write / define the policy
at a single shot .

you can use kernel cmdline for setting it in permissive  or use
"setenforce " cmd from root shell .

Regards,
Ravi




On Tue, May 5, 2015 at 8:07 AM, William Roberts <bill.c.roberts@gmail.com>
wrote:

> Are you running in permissive or enforcing mode? Usually if you're runnin=
g
> in enforcing mode the daemon will not be able to perform all of its tasks
> that it normally would thus your missing messages
> On May 4, 2015 7:11 PM, "Zhi Xin" <xinzhi@marvell.com> wrote:
>
>> Hi All,
>>
>>
>>
>> In my daily work, I=E2=80=99m always solving the selinux deny as present=
ed by avc
>> log. But I found that, for one particular test, selinux cannot give me a=
ll
>> the avc deny log in one time, which has slowed down a lot of my daily wo=
rk.
>>
>>
>>
>> For example, I trigger a process called test_daemon to access a
>> /dev/test_device in a particular test. Totally, it should have =E2=80=9C=
open, read,
>> write, ioctl=E2=80=9D for permissions. But for one time test, I only cat=
ch =E2=80=9Copen,
>> read=E2=80=9D related avc log. And only after I have merged a patch to g=
ive the
>> =E2=80=9Copen=E2=80=9D and =E2=80=9Cread=E2=80=9D permission, I rerun th=
e test. The =E2=80=9Cwrite ioctl=E2=80=9D related
>> avc  logs start to occur. So my question is how can I get =E2=80=9Copen,=
 read,
>> write, ioctl=E2=80=9D avc log in one test.
>>
>>
>>
>> I have done a little study on this issue. selinux avc log depends on
>> audit subsystem. In /kernel/kernel/audit.c, some code has indicated that=
 we
>> may lost the records in five ways:
>>
>> 115 <http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/au=
dit.c#115>/* Records can be lost in several ways:
>>
>> 116 <http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/au=
dit.c#116>   0) [suppressed in audit_alloc]
>>
>> 117 <http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/au=
dit.c#117>   1) out of memory in audit_log_start [kmalloc of struct audit_b=
uffer]
>>
>> 118 <http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/au=
dit.c#118>   2) out of memory in audit_log_move [alloc_skb]
>>
>> 119 <http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/au=
dit.c#119>   3) suppressed due to audit_rate_limit
>>
>> 120 <http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/au=
dit.c#120>   4) suppressed due to audit_backlog_limit
>>
>> 121 <http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/au=
dit.c#121>*/
>>
>>
>>
>> So is this the root-cause of my issue ? How can I modify kernel code to
>> archieve my purpose or there already is a open/off switch to help me on
>> giving all the logs in one time test ?
>>
>>
>>
>> Thanks
>>
>> Sincerely
>>
>> Alan Xin
>>
>>
>>
>>
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to
>> Selinux-request@tycho.nsa.gov.
>>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>

--001a11c27b7aa0d3b905154f5451
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Alan, <br></div>Code written in most of the case=
s will be checking for success on =C2=A0 file open or device node open . Wh=
ich is basically a=C2=A0 check on=C2=A0 file descriptor (fd) =C2=A0 if its =
null ( may be failed due to=C2=A0 selinux policy missing)=C2=A0 it=C2=A0 co=
mes out of the code and never try to do a IOCTL / or any other=C2=A0 operat=
ion on the null=C2=A0 fd=C2=A0 so we will not see any additional=C2=A0 deni=
als=C2=A0 until we address the open. <br><br></div><div>As a generally prac=
tice what i feel recommending=C2=A0 is=C2=A0 set the selinux mode in permis=
sive and capture all the denials at ONE shot . Based on the denials logs co=
llected it will be easy for us to write / define the policy at a single sho=
t .=C2=A0 <br><br></div><div>you can use kernel cmdline for setting it in p=
ermissive=C2=A0 or use=C2=A0 &quot;setenforce &quot; cmd from root shell .=
=C2=A0 <br></div><div><br></div><div>Regards,<br></div><div>Ravi<br></div><=
div><br><br>=C2=A0 <br></div></div><div class=3D"gmail_extra"><br><div clas=
s=3D"gmail_quote">On Tue, May 5, 2015 at 8:07 AM, William Roberts <span dir=
=3D"ltr">&lt;<a href=3D"mailto:bill.c.roberts@gmail.com" target=3D"_blank">=
bill.c.roberts@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex"><p dir=3D"ltr">Are you running in permissive or enforcing mode? Usual=
ly if you&#39;re running in enforcing mode the daemon will not be able to p=
erform all of its tasks that it normally would thus your missing messages</=
p>
<div class=3D"gmail_quote"><div><div class=3D"h5">On May 4, 2015 7:11 PM, &=
quot;Zhi Xin&quot; &lt;<a href=3D"mailto:xinzhi@marvell.com" target=3D"_bla=
nk">xinzhi@marvell.com</a>&gt; wrote:<br type=3D"attribution"></div></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex"><div><div class=3D"h5"><div link=3D"blue" vli=
nk=3D"purple" lang=3D"ZH-CN"><div><p class=3D"MsoNormal"><span lang=3D"EN-U=
S">Hi All,<u></u><u></u></span></p><p class=3D"MsoNormal"><span lang=3D"EN-=
US"><u></u>=C2=A0<u></u></span></p><p class=3D"MsoNormal"><span lang=3D"EN-=
US">In my daily work, I=E2=80=99m always solving the selinux deny as presen=
ted by avc log. But I found that, for one particular test, selinux cannot g=
ive me all the avc deny log in one time, which has slowed down a lot of my =
daily work.<u></u><u></u></span></p><p class=3D"MsoNormal"><span lang=3D"EN=
-US"><u></u>=C2=A0<u></u></span></p><p class=3D"MsoNormal"><span lang=3D"EN=
-US">For example, I trigger a process called test_daemon to access a /dev/t=
est_device in a particular test. Totally, it should have =E2=80=9Copen, rea=
d, write, ioctl=E2=80=9D for permissions. But for one time test, I only cat=
ch =E2=80=9Copen, read=E2=80=9D related avc log. And only after I have merg=
ed a patch to give the =E2=80=9Copen=E2=80=9D and =E2=80=9Cread=E2=80=9D pe=
rmission, I rerun the test. The =E2=80=9Cwrite ioctl=E2=80=9D related avc =
=C2=A0logs start to occur. So my question is how can I get =E2=80=9Copen, r=
ead, write, ioctl=E2=80=9D avc log in one test.<u></u><u></u></span></p><p =
class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p><p =
class=3D"MsoNormal"><span lang=3D"EN-US">I have done a little study on this=
 issue. selinux avc log depends on audit subsystem. In /kernel/kernel/audit=
.c, some code has indicated that we may lost the records in five ways:<u></=
u><u></u></span></p><pre><a name=3D"14d21f2f9342b644_14d21d7a7c1f2c03_115">=
</a><a href=3D"http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/ke=
rnel/audit.c#115" target=3D"_blank"><span style=3D"font-size:10.5pt;font-fa=
mily:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:windowtext;text-decor=
ation:none" lang=3D"EN-US">115</span></a><span style=3D"font-size:10.5pt;fo=
nt-family:&quot;Calibri&quot;,&quot;sans-serif&quot;" lang=3D"EN-US">/* Rec=
ords can be lost in several ways:<u></u><u></u></span></pre><pre><a name=3D=
"14d21f2f9342b644_14d21d7a7c1f2c03_116"></a><a href=3D"http://10.38.120.31:=
8080/source/xref/pxa1928-lp5.0/kernel/kernel/audit.c#116" target=3D"_blank"=
><span style=3D"font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans=
-serif&quot;;color:windowtext;text-decoration:none" lang=3D"EN-US">116</spa=
n></a><span style=3D"font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;" lang=3D"EN-US">=C2=A0=C2=A0 0) [suppressed in audit_allo=
c]<u></u><u></u></span></pre><pre><a name=3D"14d21f2f9342b644_14d21d7a7c1f2=
c03_117"></a><a href=3D"http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/=
kernel/kernel/audit.c#117" target=3D"_blank"><span style=3D"font-size:10.5p=
t;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:windowtext;t=
ext-decoration:none" lang=3D"EN-US">117</span></a><span style=3D"font-size:=
10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;" lang=3D"EN-U=
S">=C2=A0=C2=A0 1) out of memory in audit_log_start [kmalloc of struct audi=
t_buffer]<u></u><u></u></span></pre><pre><a name=3D"14d21f2f9342b644_14d21d=
7a7c1f2c03_118"></a><a href=3D"http://10.38.120.31:8080/source/xref/pxa1928=
-lp5.0/kernel/kernel/audit.c#118" target=3D"_blank"><span style=3D"font-siz=
e:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:windo=
wtext;text-decoration:none" lang=3D"EN-US">118</span></a><span style=3D"fon=
t-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;" lang=
=3D"EN-US">=C2=A0=C2=A0 2) out of memory in audit_log_move [alloc_skb]<u></=
u><u></u></span></pre><pre><a name=3D"14d21f2f9342b644_14d21d7a7c1f2c03_119=
"></a><a href=3D"http://10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/=
kernel/audit.c#119" target=3D"_blank"><span style=3D"font-size:10.5pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:windowtext;text-dec=
oration:none" lang=3D"EN-US">119</span></a><span style=3D"font-size:10.5pt;=
font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;" lang=3D"EN-US">=C2=
=A0=C2=A0 3) suppressed due to audit_rate_limit<u></u><u></u></span></pre><=
pre><a name=3D"14d21f2f9342b644_14d21d7a7c1f2c03_120"></a><a href=3D"http:/=
/10.38.120.31:8080/source/xref/pxa1928-lp5.0/kernel/kernel/audit.c#120" tar=
get=3D"_blank"><span style=3D"font-size:10.5pt;font-family:&quot;Calibri&qu=
ot;,&quot;sans-serif&quot;;color:windowtext;text-decoration:none" lang=3D"E=
N-US">120</span></a><span style=3D"font-size:10.5pt;font-family:&quot;Calib=
ri&quot;,&quot;sans-serif&quot;" lang=3D"EN-US">=C2=A0=C2=A0 4) suppressed =
due to audit_backlog_limit<u></u><u></u></span></pre><pre><a name=3D"14d21f=
2f9342b644_14d21d7a7c1f2c03_121"></a><a href=3D"http://10.38.120.31:8080/so=
urce/xref/pxa1928-lp5.0/kernel/kernel/audit.c#121" target=3D"_blank"><span =
style=3D"font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&=
quot;;color:windowtext;text-decoration:none" lang=3D"EN-US">121</span></a><=
span style=3D"font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-s=
erif&quot;" lang=3D"EN-US">*/<u></u><u></u></span></pre><p class=3D"MsoNorm=
al"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></span></p><p class=3D"MsoNorm=
al"><span lang=3D"EN-US">So is this the root-cause of my issue ? How can I =
modify kernel code to archieve my purpose or there already is a open/off sw=
itch to help me on giving all the logs in one time test ? <u></u><u></u></s=
pan></p><p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></u></s=
pan></p><p class=3D"MsoNormal"><span lang=3D"EN-US">Thanks<u></u><u></u></s=
pan></p><p class=3D"MsoNormal"><span lang=3D"EN-US">Sincerely<u></u><u></u>=
</span></p><p class=3D"MsoNormal"><span lang=3D"EN-US">Alan Xin<u></u><u></=
u></span></p><p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></=
u></span></p><p class=3D"MsoNormal"><span lang=3D"EN-US"><u></u>=C2=A0<u></=
u></span></p></div></div><br></div></div>__________________________________=
_____________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov" target=3D"_blank">Selinux@tycho.ns=
a.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
" target=3D"_blank">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov" target=3D"_blank">Selinux-request@tycho.nsa=
.gov</a>.<br></blockquote></div>
<br>_______________________________________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br></blo=
ckquote></div><br></div>

--001a11c27b7aa0d3b905154f5451--
