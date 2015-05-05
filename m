Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4530JDm030768
 for <selinux@tycho.nsa.gov>; Mon, 4 May 2015 23:00:19 -0400
Received: by widdi4 with SMTP id di4so129827871wid.0
 for <selinux@tycho.nsa.gov>; Mon, 04 May 2015 20:00:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFftDdqMvrPLBb=854+_1H4kEr3NHQrmQdvUCdhicx-RDUxw+Q@mail.gmail.com>
References: <F766E4F80769BD478052FB6533FA745D66611C3FD9@SC-VEXCH4.marvell.com>
 <CAFftDdqp06sbW9chUrzS0RaNgrqv=W5=3nP9VcFnYrzOkUkf5Q@mail.gmail.com>
 <F766E4F80769BD478052FB6533FA745D66611C4006@SC-VEXCH4.marvell.com>
 <CAFftDdqMvrPLBb=854+_1H4kEr3NHQrmQdvUCdhicx-RDUxw+Q@mail.gmail.com>
Date: Mon, 4 May 2015 20:00:14 -0700
Message-ID: <CAFftDdpemNpG8TWUqXEQFOCOzQROoc-BGZSfWSZnaXLtOtg3Sw@mail.gmail.com>
Subject: RE: Give out all the avc logs in ome time
From: William Roberts <bill.c.roberts@gmail.com>
To: Zhi Xin <xinzhi@marvell.com>
Content-Type: multipart/alternative; boundary=e89a8f6473ebb0e2b905154ce081
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--e89a8f6473ebb0e2b905154ce081
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On May 4, 2015 7:51 PM, "William Roberts" <bill.c.roberts@gmail.com> wrote:
>
> Outside of the fact that I see Linux will
Darn talk to text.. I see selinux
only print the first denial and permissive and perhaps your logs are
rolling over or something like that I have no idea. SELinux and the audit
framework in general will never miss a message with the exception of a full
message queue or some exceptional case.
>
> Perhaps sds can shed some light on it that I'm not aware of
>
> On May 4, 2015 7:43 PM, "Zhi Xin" <xinzhi@marvell.com> wrote:
>>
>> Hi  William,
>>
>>
>>
>> In my experience, under permissive, we can indeed get more avc log than
enforcing but it still cannot give all the deny log in one time. Usually,
it require 2-3 round of policy adding for a complicated issue even under
permissive.
>>
>>
>>
>> Any clue about this ?
>>
>>
>>
>> Thanks.
>>
>> Sincerely
>>
>> Alan Xin
>>
>>
>>
>> From: William Roberts [mailto:bill.c.roberts@gmail.com]
>> Sent: 2015=E5=B9=B45=E6=9C=885=E6=97=A5 10:37
>> To: Zhi Xin
>> Cc: selinux@tycho.nsa.gov
>> Subject: Re: Give out all the avc logs in ome time
>>
>>
>>
>> Are you running in permissive or enforcing mode? Usually if you're
running in enforcing mode the daemon will not be able to perform all of its
tasks that it normally would thus your missing messages
>>
>> On May 4, 2015 7:11 PM, "Zhi Xin" <xinzhi@marvell.com> wrote:
>>
>> Hi All,
>>
>>
>>
>> In my daily work, I=E2=80=99m always solving the selinux deny as present=
ed by
avc log. But I found that, for one particular test, selinux cannot give me
all the avc deny log in one time, which has slowed down a lot of my daily
work.
>>
>>
>>
>> For example, I trigger a process called test_daemon to access a
/dev/test_device in a particular test. Totally, it should have =E2=80=9Cope=
n, read,
write, ioctl=E2=80=9D for permissions. But for one time test, I only catch =
=E2=80=9Copen,
read=E2=80=9D related avc log. And only after I have merged a patch to give=
 the
=E2=80=9Copen=E2=80=9D and =E2=80=9Cread=E2=80=9D permission, I rerun the t=
est. The =E2=80=9Cwrite ioctl=E2=80=9D related
avc  logs start to occur. So my question is how can I get =E2=80=9Copen, re=
ad,
write, ioctl=E2=80=9D avc log in one test.
>>
>>
>>
>> I have done a little study on this issue. selinux avc log depends on
audit subsystem. In /kernel/kernel/audit.c, some code has indicated that we
may lost the records in five ways:
>>
>> 115/* Records can be lost in several ways:
>>
>> 116   0) [suppressed in audit_alloc]
>>
>> 117   1) out of memory in audit_log_start [kmalloc of struct
audit_buffer]
>>
>> 118   2) out of memory in audit_log_move [alloc_skb]
>>
>> 119   3) suppressed due to audit_rate_limit
>>
>> 120   4) suppressed due to audit_backlog_limit
>>
>> 121*/
>>
>>
>>
>> So is this the root-cause of my issue ? How can I modify kernel code to
archieve my purpose or there already is a open/off switch to help me on
giving all the logs in one time test ?
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
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.

--e89a8f6473ebb0e2b905154ce081
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On May 4, 2015 7:51 PM, &quot;William Roberts&quot; &lt;<a href=3D"mailto:b=
ill.c.roberts@gmail.com">bill.c.roberts@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Outside of the fact that I see Linux will<br>
Darn talk to text.. I see selinux<br>
 only print the first denial and permissive and perhaps your logs are rolli=
ng over or something like that I have no idea. SELinux and the audit framew=
ork in general will never miss a message with the exception of a full messa=
ge queue or some exceptional case.<br>
&gt;<br>
&gt; Perhaps sds can shed some light on it that I&#39;m not aware of<br>
&gt;<br>
&gt; On May 4, 2015 7:43 PM, &quot;Zhi Xin&quot; &lt;<a href=3D"mailto:xinz=
hi@marvell.com">xinzhi@marvell.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Hi=C2=A0 William,<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0<br>
&gt;&gt;<br>
&gt;&gt; In my experience, under permissive, we can indeed get more avc log=
 than enforcing but it still cannot give all the deny log in one time. Usua=
lly, it require 2-3 round of policy adding for a complicated issue even und=
er permissive.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0<br>
&gt;&gt;<br>
&gt;&gt; Any clue about this ?<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0<br>
&gt;&gt;<br>
&gt;&gt; Thanks.<br>
&gt;&gt;<br>
&gt;&gt; Sincerely<br>
&gt;&gt;<br>
&gt;&gt; Alan Xin<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0<br>
&gt;&gt;<br>
&gt;&gt; From: William Roberts [mailto:<a href=3D"mailto:bill.c.roberts@gma=
il.com">bill.c.roberts@gmail.com</a>] <br>
&gt;&gt; Sent: 2015=E5=B9=B45=E6=9C=885=E6=97=A5 10:37<br>
&gt;&gt; To: Zhi Xin<br>
&gt;&gt; Cc: <a href=3D"mailto:selinux@tycho.nsa.gov">selinux@tycho.nsa.gov=
</a><br>
&gt;&gt; Subject: Re: Give out all the avc logs in ome time<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0<br>
&gt;&gt;<br>
&gt;&gt; Are you running in permissive or enforcing mode? Usually if you&#3=
9;re running in enforcing mode the daemon will not be able to perform all o=
f its tasks that it normally would thus your missing messages<br>
&gt;&gt;<br>
&gt;&gt; On May 4, 2015 7:11 PM, &quot;Zhi Xin&quot; &lt;<a href=3D"mailto:=
xinzhi@marvell.com">xinzhi@marvell.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Hi All,<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0<br>
&gt;&gt;<br>
&gt;&gt; In my daily work, I=E2=80=99m always solving the selinux deny as p=
resented by avc log. But I found that, for one particular test, selinux can=
not give me all the avc deny log in one time, which has slowed down a lot o=
f my daily work.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0<br>
&gt;&gt;<br>
&gt;&gt; For example, I trigger a process called test_daemon to access a /d=
ev/test_device in a particular test. Totally, it should have =E2=80=9Copen,=
 read, write, ioctl=E2=80=9D for permissions. But for one time test, I only=
 catch =E2=80=9Copen, read=E2=80=9D related avc log. And only after I have =
merged a patch to give the =E2=80=9Copen=E2=80=9D and =E2=80=9Cread=E2=80=
=9D permission, I rerun the test. The =E2=80=9Cwrite ioctl=E2=80=9D related=
 avc =C2=A0logs start to occur. So my question is how can I get =E2=80=9Cop=
en, read, write, ioctl=E2=80=9D avc log in one test.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0<br>
&gt;&gt;<br>
&gt;&gt; I have done a little study on this issue. selinux avc log depends =
on audit subsystem. In /kernel/kernel/audit.c, some code has indicated that=
 we may lost the records in five ways:<br>
&gt;&gt;<br>
&gt;&gt; 115/* Records can be lost in several ways:<br>
&gt;&gt;<br>
&gt;&gt; 116=C2=A0=C2=A0 0) [suppressed in audit_alloc]<br>
&gt;&gt;<br>
&gt;&gt; 117=C2=A0=C2=A0 1) out of memory in audit_log_start [kmalloc of st=
ruct audit_buffer]<br>
&gt;&gt;<br>
&gt;&gt; 118=C2=A0=C2=A0 2) out of memory in audit_log_move [alloc_skb]<br>
&gt;&gt;<br>
&gt;&gt; 119=C2=A0=C2=A0 3) suppressed due to audit_rate_limit<br>
&gt;&gt;<br>
&gt;&gt; 120=C2=A0=C2=A0 4) suppressed due to audit_backlog_limit<br>
&gt;&gt;<br>
&gt;&gt; 121*/<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0<br>
&gt;&gt;<br>
&gt;&gt; So is this the root-cause of my issue ? How can I modify kernel co=
de to archieve my purpose or there already is a open/off switch to help me =
on giving all the logs in one time test ?<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0<br>
&gt;&gt;<br>
&gt;&gt; Thanks<br>
&gt;&gt;<br>
&gt;&gt; Sincerely<br>
&gt;&gt;<br>
&gt;&gt; Alan Xin<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; Selinux mailing list<br>
&gt;&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a>=
<br>
&gt;&gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tych=
o.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt;&gt; To get help, send an email containing &quot;help&quot; to <a href=
=3D"mailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>=
.</p>

--e89a8f6473ebb0e2b905154ce081--
