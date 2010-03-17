Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2H7CYd5025169
	for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2010 03:12:34 -0400
Received: from qw-out-1920.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o2H7CCVO010710
	for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2010 07:12:12 GMT
Received: by qw-out-1920.google.com with SMTP id 5so164138qwc.30
        for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2010 00:12:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <482a0d8c1003162308r3989a64by797220bf38dffdb3@mail.gmail.com>
References: <482a0d8c1003100413w4b2d060fy493a72f6a76b976e@mail.gmail.com>
	 <1268235831.3678.31.camel@moss-pluto.epoch.ncsc.mil>
	 <482a0d8c1003100914j2709ab7epad0956ca4aa75081@mail.gmail.com>
	 <1268243344.3678.38.camel@moss-pluto.epoch.ncsc.mil>
	 <482a0d8c1003110208g9843309s83e41c6319ff8271@mail.gmail.com>
	 <482a0d8c1003162122y50c4f6adq3d1e4ab7a9d481ed@mail.gmail.com>
	 <4BA06092.9030302@ak.jp.nec.com>
	 <482a0d8c1003162308r3989a64by797220bf38dffdb3@mail.gmail.com>
Date: Wed, 17 Mar 2010 12:42:32 +0530
Message-ID: <482a0d8c1003170012w6de08b88l11c5a0d23420b805@mail.gmail.com>
Subject: Re: working linux and busybox versions
From: Manvendra Pratap Singh <manav.emb@gmail.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=0015175774848a1e550481f9d6bb
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0015175774848a1e550481f9d6bb
Content-Type: text/plain; charset=ISO-8859-1

Hi KaiGai,

I checked /etc/selinux/base_policy/contexts/default_contexts and
/etc/selinux/base_policy/contexts/users/root both in my rootfs and it is in
correct place. But it still giving me same SID problem. Please give some
idea.

On Wed, Mar 17, 2010 at 11:38 AM, Manvendra Pratap Singh <
manav.emb@gmail.com> wrote:

> Thanks for reply KaiGai Kohei, I will follow your suggestion and let you
> know about it.
>
> ---
> Manav
> Hyderabad
>
> 2010/3/17 KaiGai Kohei <kaigai@ak.jp.nec.com>
>
> (2010/03/17 13:22), Manvendra Pratap Singh wrote:
>> > Can anyone suggest me good guide for SELinux on omap3 (beagleboard). I
>> > tried it myself but I am not able to login after booting. On loging in
>> > root I get a msg "Cann't get SID for root". Please help me on this
>> > issue.  Here take a look at boot-log.
>> >
>> >
>> > [    0.000000] Security Framework initialized
>> > [    0.000000] SELinux:  Initializing.
>> >
>> >
>> > beagleboard login: root
>> > login: can't get SID for root
>>
>> This message come from logind applet of busybox.
>>
>> It tries to fetch the default security context of the root session.
>>
>> Put "/etc/selinux/<SELINUXTYPE>/contexts/default_contexts" or
>> "/etc/selinux/<SELINUXTYPE>/contexts/users/root" correctly, and
>> try it again.
>>
>> Thanks,
>>
>> >
>> > Embinux Linux 1.1 beagleboard ttyS2
>> >
>> > beagleboard login:
>> >
>> >
>> >
>> > ---
>> > Manav
>> > Hyderabad
>> >
>> >
>> >
>> > On Thu, Mar 11, 2010 at 3:38 PM, Manvendra Pratap Singh
>> > <manav.emb@gmail.com <mailto:manav.emb@gmail.com>> wrote:
>> >
>> >     Thanks for the information. I asked about working busybox and linux
>> >     kernel versions because when I am enabling selinux in busybox
>> >     (1.13.0), it is giving me lot of compilation errors and I think some
>> >     code is also missing. Although the kernel (2.6.29) which I am using
>> >     is working fine. If you tell anything more on this then it will be a
>> >     great help.
>> >
>> >
>> >     --
>> >     Manav
>> >     Hyderabad
>> >
>> >
>> >
>> >     On Wed, Mar 10, 2010 at 11:19 PM, Stephen Smalley <
>> sds@tycho.nsa.gov
>> >     <mailto:sds@tycho.nsa.gov>> wrote:
>> >
>> >         On Wed, 2010-03-10 at 22:44 +0530, Manvendra Pratap Singh wrote:
>> >          > Hi Stephen,
>> >          >
>> >          > May be I could not make myself clear to you. My question was
>> >         not about
>> >          > linux on omap3, it was about SELinux on omap3. Anyways thanks
>> >         for your
>> >          > reply. I will check the links given by you.
>> >
>> >         SELinux isn't platform-specific, and is a component of the Linux
>> 2.6
>> >         kernel.
>> >
>> >         --
>> >         Stephen Smalley
>> >         National Security Agency
>> >
>> >
>> >
>>
>>
>> --
>> KaiGai Kohei <kaigai@ak.jp.nec.com>
>>
>
>


-- 
Manav
Hyderabad

--0015175774848a1e550481f9d6bb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi KaiGai,<br><br>I checked /etc/selinux/base_policy/contexts/default_conte=
xts and /etc/selinux/base_policy/contexts/users/root both in my rootfs and =
it is in correct place. But it still giving me same SID problem. Please giv=
e some idea.<br>
<br><div class=3D"gmail_quote">On Wed, Mar 17, 2010 at 11:38 AM, Manvendra =
Pratap Singh <span dir=3D"ltr">&lt;<a href=3D"mailto:manav.emb@gmail.com">m=
anav.emb@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt =
0.8ex; padding-left: 1ex;">
Thanks for reply KaiGai Kohei, I will follow your suggestion and let you kn=
ow about it.<br><br>---<br>Manav<br>Hyderabad<br><br><div class=3D"gmail_qu=
ote">2010/3/17 KaiGai Kohei <span dir=3D"ltr">&lt;<a href=3D"mailto:kaigai@=
ak.jp.nec.com" target=3D"_blank">kaigai@ak.jp.nec.com</a>&gt;</span><div>
<div></div><div class=3D"h5"><br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div>(2010/03/17 =
13:22), Manvendra Pratap Singh wrote:<br>
&gt; Can anyone suggest me good guide for SELinux on omap3 (beagleboard). I=
<br>
&gt; tried it myself but I am not able to login after booting. On loging in=
<br>
&gt; root I get a msg &quot;Cann&#39;t get SID for root&quot;. Please help =
me on this<br>
&gt; issue. =A0Here take a look at boot-log.<br>
&gt;<br>
&gt;<br>
&gt; [ =A0 =A00.000000] Security Framework initialized<br>
&gt; [ =A0 =A00.000000] SELinux: =A0Initializing.<br>
&gt;<br>
&gt;<br>
&gt; beagleboard login: root<br>
&gt; login: can&#39;t get SID for root<br>
<br>
</div>This message come from logind applet of busybox.<br>
<br>
It tries to fetch the default security context of the root session.<br>
<br>
Put &quot;/etc/selinux/&lt;SELINUXTYPE&gt;/contexts/default_contexts&quot; =
or<br>
&quot;/etc/selinux/&lt;SELINUXTYPE&gt;/contexts/users/root&quot; correctly,=
 and<br>
try it again.<br>
<br>
Thanks,<br>
<div><br>
&gt;<br>
&gt; Embinux Linux 1.1 beagleboard ttyS2<br>
&gt;<br>
&gt; beagleboard login:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; ---<br>
&gt; Manav<br>
&gt; Hyderabad<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Thu, Mar 11, 2010 at 3:38 PM, Manvendra Pratap Singh<br>
</div><div>&gt; &lt;<a href=3D"mailto:manav.emb@gmail.com" target=3D"_blank=
">manav.emb@gmail.com</a> &lt;mailto:<a href=3D"mailto:manav.emb@gmail.com"=
 target=3D"_blank">manav.emb@gmail.com</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt; =A0 =A0 Thanks for the information. I asked about working busybox and =
linux<br>
&gt; =A0 =A0 kernel versions because when I am enabling selinux in busybox<=
br>
&gt; =A0 =A0 (1.13.0), it is giving me lot of compilation errors and I thin=
k some<br>
&gt; =A0 =A0 code is also missing. Although the kernel (2.6.29) which I am =
using<br>
&gt; =A0 =A0 is working fine. If you tell anything more on this then it wil=
l be a<br>
&gt; =A0 =A0 great help.<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 --<br>
&gt; =A0 =A0 Manav<br>
&gt; =A0 =A0 Hyderabad<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 On Wed, Mar 10, 2010 at 11:19 PM, Stephen Smalley &lt;<a href=
=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a><br>
</div><div><div></div><div>&gt; =A0 =A0 &lt;mailto:<a href=3D"mailto:sds@ty=
cho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 On Wed, 2010-03-10 at 22:44 +0530, Manvendra Pratap Si=
ngh wrote:<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; Hi Stephen,<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; May be I could not make myself clear to you. M=
y question was<br>
&gt; =A0 =A0 =A0 =A0 not about<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; linux on omap3, it was about SELinux on omap3.=
 Anyways thanks<br>
&gt; =A0 =A0 =A0 =A0 for your<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; reply. I will check the links given by you.<br=
>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 SELinux isn&#39;t platform-specific, and is a componen=
t of the Linux 2.6<br>
&gt; =A0 =A0 =A0 =A0 kernel.<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 --<br>
&gt; =A0 =A0 =A0 =A0 Stephen Smalley<br>
&gt; =A0 =A0 =A0 =A0 National Security Agency<br>
&gt;<br>
&gt;<br>
&gt;<br>
<br>
<br>
</div></div><font color=3D"#888888">--<br>
KaiGai Kohei &lt;<a href=3D"mailto:kaigai@ak.jp.nec.com" target=3D"_blank">=
kaigai@ak.jp.nec.com</a>&gt;<br>
</font></blockquote></div></div></div><br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>Manav<br>Hyderabad<br>

--0015175774848a1e550481f9d6bb--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
