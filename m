Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9J9pXq9027634
	for <selinux@tycho.nsa.gov>; Mon, 19 Oct 2009 05:51:33 -0400
Received: from mail-ew0-f207.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n9J9rHm4019098
	for <selinux@tycho.nsa.gov>; Mon, 19 Oct 2009 09:53:17 GMT
Received: by ewy3 with SMTP id 3so3550728ewy.41
        for <selinux@tycho.nsa.gov>; Mon, 19 Oct 2009 02:51:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4ADBF832.8070001@ak.jp.nec.com>
References: <bb74313d0910170111r1fd7f59cl3556e59be1d2f7a8@mail.gmail.com>
	 <4ADBF832.8070001@ak.jp.nec.com>
Date: Mon, 19 Oct 2009 13:21:30 +0330
Message-ID: <bb74313d0910190251w21117682p59d42db26b3f0191@mail.gmail.com>
Subject: Re: bounds domain
From: michel m <michel.mcgregor@gmail.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=00504502c881a852af047646b048
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--00504502c881a852af047646b048
Content-Type: text/plain; charset=ISO-8859-1

hi,

you have noted that:

>As long as your application does not manage shared objects in userspace,
you don't need to consult userspace AVC before actions.

this is exactly what I am going to do. that is, I have  userspace some
shared objects that I need to control my threads access to these objects.
but I don`t know if I should consult AVC myself in userspace per access
(because as we both agree that my userspace threads` context is bounded by
my OS process)or SELinus does this for me itself.

I think it seems logical that since kernel doesnot know any thing about my
threads(e.g. pthreads) I should have some hooks that consult SELinux when
needed.how do you think? but here comes another question, if my thread were
kernel level, would I need hooks for controling my threads access to
userspace shared objects?

as the last question, I want to know, in a multithreaded process, which uses
M:1 model, if access requests from threads to OS , are delivered by that
single process or if not, how is it done?

Best regards


2009/10/19 KaiGai Kohei <kaigai@ak.jp.nec.com>

> michel m wrote:
> > hi,
> >
> > as I was studying on how to assign different security context on
> > threads defined in a process, I found that there is a concept named
> > BOUNDS DOMAIN which does this for me.
> > now I would like to know for implementing a userspace object manager
> > that uses this mechanism for its threads, how requests for OS
> > resources are protected. that is, if my single OS process changes its
> > security context per thread request or I should consult AVC before any
> > action taken by my threads if that action is legal.
>
> I seems to me you are confusing about different two concepts.
> The one is bounds-domain, the other is userspace object manager.
>
> Once a thread changes its domain to the bounded one, its privileges
> are more restrictive than the original domain. Then, SELinux checks
> the given actions based on the restricted privileges.
>
> > I should consult AVC before any
> > action taken by my threads if that action is legal.
>
> It goes against to the assumption of SELinux.
> How do you make sure the checks are well comprehensive?
> Since it is near to impossible to check and eliminate any bugs in
> userspace, so we check violated accesses in kernel space.
>
> As long as your application does not manage shared objects in userspace,
> you don't need to consult userspace AVC before actions.
>
> > is there any documentation on this topic?
>
> You can set a new domain on the thread using setcon(3) API.
> The only difference from dynamic domain transition is that
> the newer domain has to be bounded by the older domain.
>
> Thanks,
> --
> OSS Platform Development Division, NEC
> KaiGai Kohei <kaigai@ak.jp.nec.com>
>

--00504502c881a852af047646b048
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

hi,<br><br>you have noted that:<br><br>&gt;As long as your application does=
 not manage shared objects in userspace,<br>
you don&#39;t need to consult userspace AVC before actions.<br>
<br>this is exactly what I am going to do. that is, I have=A0 userspace som=
e shared objects that I need to control my threads access to these objects.=
 but I don`t know if I should consult AVC myself in userspace per access (b=
ecause as we both agree that my userspace threads` context is bounded by my=
 OS process)or SELinus does this for me itself. <br>
<br>I think it seems logical that since kernel doesnot know any thing about=
 my threads(e.g. pthreads) I should have some hooks that consult SELinux wh=
en needed.how do you think? but here comes another question, if my thread w=
ere kernel level, would I need hooks for controling my threads access to us=
erspace shared objects?<br>
<br>as the last question, I want to know, in a multithreaded process, which=
 uses M:1 model, if access requests from threads to OS , are delivered by t=
hat single process or if not, how is it done?<br><br>Best regards<br><br>
<br><div class=3D"gmail_quote">2009/10/19 KaiGai Kohei <span dir=3D"ltr">&l=
t;<a href=3D"mailto:kaigai@ak.jp.nec.com" target=3D"_blank">kaigai@ak.jp.ne=
c.com</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"border-l=
eft: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left:=
 1ex;">

<div>michel m wrote:<br>
&gt; hi,<br>
&gt;<br>
&gt; as I was studying on how to assign different security context on<br>
&gt; threads defined in a process, I found that there is a concept named<br=
>
&gt; BOUNDS DOMAIN which does this for me.<br>
&gt; now I would like to know for implementing a userspace object manager<b=
r>
&gt; that uses this mechanism for its threads, how requests for OS<br>
&gt; resources are protected. that is, if my single OS process changes its<=
br>
&gt; security context per thread request or I should consult AVC before any=
<br>
&gt; action taken by my threads if that action is legal.<br>
<br>
</div>I seems to me you are confusing about different two concepts.<br>
The one is bounds-domain, the other is userspace object manager.<br>
<br>
Once a thread changes its domain to the bounded one, its privileges<br>
are more restrictive than the original domain. Then, SELinux checks<br>
the given actions based on the restricted privileges.<br>
<div><br>
&gt; I should consult AVC before any<br>
&gt; action taken by my threads if that action is legal.<br>
<br>
</div>It goes against to the assumption of SELinux.<br>
How do you make sure the checks are well comprehensive?<br>
Since it is near to impossible to check and eliminate any bugs in<br>
userspace, so we check violated accesses in kernel space.<br>
<br>
As long as your application does not manage shared objects in userspace,<br=
>
you don&#39;t need to consult userspace AVC before actions.<br>
<div><br>
&gt; is there any documentation on this topic?<br>
<br>
</div>You can set a new domain on the thread using setcon(3) API.<br>
The only difference from dynamic domain transition is that<br>
the newer domain has to be bounded by the older domain.<br>
<br>
Thanks,<br>
<font color=3D"#888888">--<br>
OSS Platform Development Division, NEC<br>
KaiGai Kohei &lt;<a href=3D"mailto:kaigai@ak.jp.nec.com" target=3D"_blank">=
kaigai@ak.jp.nec.com</a>&gt;<br>
</font></blockquote></div><br>

--00504502c881a852af047646b048--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
