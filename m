Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2H8Rs1b029841
	for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2010 04:27:54 -0400
Received: from qw-out-1920.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o2H8RWv6016080
	for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2010 08:27:32 GMT
Received: by qw-out-1920.google.com with SMTP id 5so171427qwc.30
        for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2010 01:27:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4BA0894C.1060005@ak.jp.nec.com>
References: <482a0d8c1003100413w4b2d060fy493a72f6a76b976e@mail.gmail.com>
	 <1268235831.3678.31.camel@moss-pluto.epoch.ncsc.mil>
	 <482a0d8c1003100914j2709ab7epad0956ca4aa75081@mail.gmail.com>
	 <1268243344.3678.38.camel@moss-pluto.epoch.ncsc.mil>
	 <482a0d8c1003110208g9843309s83e41c6319ff8271@mail.gmail.com>
	 <482a0d8c1003162122y50c4f6adq3d1e4ab7a9d481ed@mail.gmail.com>
	 <4BA06092.9030302@ak.jp.nec.com>
	 <482a0d8c1003162308r3989a64by797220bf38dffdb3@mail.gmail.com>
	 <482a0d8c1003170012w6de08b88l11c5a0d23420b805@mail.gmail.com>
	 <4BA0894C.1060005@ak.jp.nec.com>
Date: Wed, 17 Mar 2010 13:57:52 +0530
Message-ID: <482a0d8c1003170127w1d151315we0b2c6e8cfc3a913@mail.gmail.com>
Subject: Re: working linux and busybox versions
From: Manvendra Pratap Singh <manav.emb@gmail.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=0016361e815ef237000481fae345
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0016361e815ef237000481fae345
Content-Type: text/plain; charset=ISO-8859-1

2010/3/17 KaiGai Kohei <kaigai@ak.jp.nec.com>

> (2010/03/17 16:12), Manvendra Pratap Singh wrote:
> > Hi KaiGai,
> >
> > I checked /etc/selinux/base_policy/contexts/default_contexts and
> > /etc/selinux/base_policy/contexts/users/root both in my rootfs and it is
> > in correct place. But it still giving me same SID problem. Please give
> > some idea.
>
> Does it have correct format? Does it contains an entry which matches
> with the security context of your logind daemon?
>
> If your policy does not define domain-transitions appropriately,
> all the process may work with kernel_t, init_t or initrc_t.
> If so, get_default_context() cannot find out configured entry.
>
>
I am very new to SELinux, so I may not be able to answer your all questions
correctly. I compiled base policy and then included it in my rootfs ( at
/etc/selinux/base_policy). I compiled busbox-1.13.0 and 2.6.29 linux-kernel
with SELinux support. I faced lot of errors and problems while compiling
busybox with SELinux (utilities) support. then I booted beagle. And faced
above problem. I did not try any extra code other then base_policy, Because
initially I wanted to see  the kernel booting with SELinux support and
working SELinux utilities provided by busybox.


> What is your policy type? The standard reference policy?, or others?
>

I think my policy is standard reference policy.


>
> Thanks,
>
> > On Wed, Mar 17, 2010 at 11:38 AM, Manvendra Pratap Singh
> > <manav.emb@gmail.com <mailto:manav.emb@gmail.com>> wrote:
> >
> >     Thanks for reply KaiGai Kohei, I will follow your suggestion and let
> >     you know about it.
> >
> >     ---
> >     Manav
> >     Hyderabad
> >
> >     2010/3/17 KaiGai Kohei <kaigai@ak.jp.nec.com
> >     <mailto:kaigai@ak.jp.nec.com>>
> >
> >         (2010/03/17 13:22), Manvendra Pratap Singh wrote:
> >          > Can anyone suggest me good guide for SELinux on omap3
> >         (beagleboard). I
> >          > tried it myself but I am not able to login after booting. On
> >         loging in
> >          > root I get a msg "Cann't get SID for root". Please help me on
> >         this
> >          > issue.  Here take a look at boot-log.
> >          >
> >          >
> >          > [    0.000000] Security Framework initialized
> >          > [    0.000000] SELinux:  Initializing.
> >          >
> >          >
> >          > beagleboard login: root
> >          > login: can't get SID for root
> >
> >         This message come from logind applet of busybox.
> >
> >         It tries to fetch the default security context of the root
> session.
> >
> >         Put "/etc/selinux/<SELINUXTYPE>/contexts/default_contexts" or
> >         "/etc/selinux/<SELINUXTYPE>/contexts/users/root" correctly, and
> >         try it again.
> >
> >         Thanks,
> >
> >          >
> >          > Embinux Linux 1.1 beagleboard ttyS2
> >          >
> >          > beagleboard login:
> >          >
> >          >
> >          >
> >          > ---
> >          > Manav
> >          > Hyderabad
> >          >
> >          >
> >          >
> >          > On Thu, Mar 11, 2010 at 3:38 PM, Manvendra Pratap Singh
> >          > <manav.emb@gmail.com <mailto:manav.emb@gmail.com>
> >         <mailto:manav.emb@gmail.com <mailto:manav.emb@gmail.com>>>
> wrote:
> >          >
> >          >     Thanks for the information. I asked about working busybox
> >         and linux
> >          >     kernel versions because when I am enabling selinux in
> busybox
> >          >     (1.13.0), it is giving me lot of compilation errors and I
> >         think some
> >          >     code is also missing. Although the kernel (2.6.29) which
> >         I am using
> >          >     is working fine. If you tell anything more on this then
> >         it will be a
> >          >     great help.
> >          >
> >          >
> >          >     --
> >          >     Manav
> >          >     Hyderabad
> >          >
> >          >
> >          >
> >          >     On Wed, Mar 10, 2010 at 11:19 PM, Stephen Smalley
> >         <sds@tycho.nsa.gov <mailto:sds@tycho.nsa.gov>
> >          > <mailto:sds@tycho.nsa.gov <mailto:sds@tycho.nsa.gov>>> wrote:
> >          >
> >          >         On Wed, 2010-03-10 at 22:44 +0530, Manvendra Pratap
> >         Singh wrote:
> >          > > Hi Stephen,
> >          > >
> >          > > May be I could not make myself clear to you. My question was
> >          >         not about
> >          > > linux on omap3, it was about SELinux on omap3. Anyways
> thanks
> >          >         for your
> >          > > reply. I will check the links given by you.
> >          >
> >          >         SELinux isn't platform-specific, and is a component
> >         of the Linux 2.6
> >          >         kernel.
> >          >
> >          >         --
> >          >         Stephen Smalley
> >          >         National Security Agency
> >          >
> >          >
> >          >
> >
> >
> >         --
> >         KaiGai Kohei <kaigai@ak.jp.nec.com <mailto:kaigai@ak.jp.nec.com
> >>
> >
> >
> >
> >
> >
> > --
> > Manav
> > Hyderabad
>
>
> --
> KaiGai Kohei <kaigai@ak.jp.nec.com>
>



-- 
Manav
Hyderabad

--0016361e815ef237000481fae345
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2010/3/17 KaiGai Kohei <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:kaigai@ak.jp.nec.com">kaigai@ak.jp.nec.com</a>&gt;</=
span><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid =
rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im">(2010/03/17 16:12), Manvendra Pratap Singh wrote:<br>
&gt; Hi KaiGai,<br>
&gt;<br>
&gt; I checked /etc/selinux/base_policy/contexts/default_contexts and<br>
&gt; /etc/selinux/base_policy/contexts/users/root both in my rootfs and it =
is<br>
&gt; in correct place. But it still giving me same SID problem. Please give=
<br>
&gt; some idea.<br>
<br>
</div>Does it have correct format? Does it contains an entry which matches<=
br>
with the security context of your logind daemon?<br>
<br>
If your policy does not define domain-transitions appropriately,<br>
all the process may work with kernel_t, init_t or initrc_t.<br>
If so, get_default_context() cannot find out configured entry.<br>
<br></blockquote><div><br>I am very new to SELinux, so I may not be able to=
 answer your all questions correctly. I compiled base policy and then inclu=
ded it in my rootfs ( at /etc/selinux/base_policy). I compiled busbox-1.13.=
0 and 2.6.29 linux-kernel with SELinux support. I faced lot of errors and p=
roblems while compiling busybox with SELinux (utilities) support. then I bo=
oted beagle. And faced above problem. I did not try any extra code other th=
en base_policy, Because initially I wanted to see=A0 the kernel booting wit=
h SELinux support and working SELinux utilities provided by busybox.<br>
=A0</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid =
rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
What is your policy type? The standard reference policy?, or others?<br></b=
lockquote><div><br>I think my policy is standard reference policy.<br>=A0</=
div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(2=
04, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

<br>
Thanks,<br>
<div class=3D"im"><br>
&gt; On Wed, Mar 17, 2010 at 11:38 AM, Manvendra Pratap Singh<br>
</div><div class=3D"im">&gt; &lt;<a href=3D"mailto:manav.emb@gmail.com">man=
av.emb@gmail.com</a> &lt;mailto:<a href=3D"mailto:manav.emb@gmail.com">mana=
v.emb@gmail.com</a>&gt;&gt; wrote:<br>
&gt;<br>
</div><div class=3D"im">&gt; =A0 =A0 Thanks for reply KaiGai Kohei, I will =
follow your suggestion and let<br>
&gt; =A0 =A0 you know about it.<br>
&gt;<br>
&gt; =A0 =A0 ---<br>
&gt; =A0 =A0 Manav<br>
&gt; =A0 =A0 Hyderabad<br>
&gt;<br>
&gt; =A0 =A0 2010/3/17 KaiGai Kohei &lt;<a href=3D"mailto:kaigai@ak.jp.nec.=
com">kaigai@ak.jp.nec.com</a><br>
</div>&gt; =A0 =A0 &lt;mailto:<a href=3D"mailto:kaigai@ak.jp.nec.com">kaiga=
i@ak.jp.nec.com</a>&gt;&gt;<br>
<div class=3D"im">&gt;<br>
&gt; =A0 =A0 =A0 =A0 (2010/03/17 13:22), Manvendra Pratap Singh wrote:<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; Can anyone suggest me good guide for SELinux o=
n omap3<br>
&gt; =A0 =A0 =A0 =A0 (beagleboard). I<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; tried it myself but I am not able to login aft=
er booting. On<br>
&gt; =A0 =A0 =A0 =A0 loging in<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; root I get a msg &quot;Cann&#39;t get SID for =
root&quot;. Please help me on<br>
&gt; =A0 =A0 =A0 =A0 this<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; issue. =A0Here take a look at boot-log.<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; [ =A0 =A00.000000] Security Framework initiali=
zed<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; [ =A0 =A00.000000] SELinux: =A0Initializing.<b=
r>
&gt; =A0 =A0 =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; beagleboard login: root<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; login: can&#39;t get SID for root<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 This message come from logind applet of busybox.<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 It tries to fetch the default security context of the =
root session.<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Put &quot;/etc/selinux/&lt;SELINUXTYPE&gt;/contexts/de=
fault_contexts&quot; or<br>
&gt; =A0 =A0 =A0 =A0 &quot;/etc/selinux/&lt;SELINUXTYPE&gt;/contexts/users/=
root&quot; correctly, and<br>
&gt; =A0 =A0 =A0 =A0 try it again.<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Thanks,<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; Embinux Linux 1.1 beagleboard ttyS2<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; beagleboard login:<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; ---<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; Manav<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; Hyderabad<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; On Thu, Mar 11, 2010 at 3:38 PM, Manvendra Pra=
tap Singh<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; &lt;<a href=3D"mailto:manav.emb@gmail.com">man=
av.emb@gmail.com</a> &lt;mailto:<a href=3D"mailto:manav.emb@gmail.com">mana=
v.emb@gmail.com</a>&gt;<br>
</div><div class=3D"im">&gt; =A0 =A0 =A0 =A0 &lt;mailto:<a href=3D"mailto:m=
anav.emb@gmail.com">manav.emb@gmail.com</a> &lt;mailto:<a href=3D"mailto:ma=
nav.emb@gmail.com">manav.emb@gmail.com</a>&gt;&gt;&gt; wrote:<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; =A0 =A0 Thanks for the information. I asked ab=
out working busybox<br>
&gt; =A0 =A0 =A0 =A0 and linux<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; =A0 =A0 kernel versions because when I am enab=
ling selinux in busybox<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; =A0 =A0 (1.13.0), it is giving me lot of compi=
lation errors and I<br>
&gt; =A0 =A0 =A0 =A0 think some<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; =A0 =A0 code is also missing. Although the ker=
nel (2.6.29) which<br>
&gt; =A0 =A0 =A0 =A0 I am using<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; =A0 =A0 is working fine. If you tell anything =
more on this then<br>
&gt; =A0 =A0 =A0 =A0 it will be a<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; =A0 =A0 great help.<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; =A0 =A0 --<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; =A0 =A0 Manav<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; =A0 =A0 Hyderabad<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; =A0 =A0 On Wed, Mar 10, 2010 at 11:19 PM, Step=
hen Smalley<br>
&gt; =A0 =A0 =A0 =A0 &lt;<a href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa=
.gov</a> &lt;mailto:<a href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov<=
/a>&gt;<br>
</div><div class=3D"im">&gt; =A0 =A0 =A0 =A0 =A0&gt; &lt;mailto:<a href=3D"=
mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a> &lt;mailto:<a href=3D"mailt=
o:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt;&gt;&gt; wrote:<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; =A0 =A0 =A0 =A0 On Wed, 2010-03-10 at 22:44 +0=
530, Manvendra Pratap<br>
&gt; =A0 =A0 =A0 =A0 Singh wrote:<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; &gt; Hi Stephen,<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; &gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; &gt; May be I could not make myself clear to y=
ou. My question was<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; =A0 =A0 =A0 =A0 not about<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; &gt; linux on omap3, it was about SELinux on o=
map3. Anyways thanks<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; =A0 =A0 =A0 =A0 for your<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; &gt; reply. I will check the links given by yo=
u.<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; =A0 =A0 =A0 =A0 SELinux isn&#39;t platform-spe=
cific, and is a component<br>
&gt; =A0 =A0 =A0 =A0 of the Linux 2.6<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; =A0 =A0 =A0 =A0 kernel.<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; =A0 =A0 =A0 =A0 --<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; =A0 =A0 =A0 =A0 Stephen Smalley<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt; =A0 =A0 =A0 =A0 National Security Agency<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0&gt;<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 --<br>
</div>&gt; =A0 =A0 =A0 =A0 KaiGai Kohei &lt;<a href=3D"mailto:kaigai@ak.jp.=
nec.com">kaigai@ak.jp.nec.com</a> &lt;mailto:<a href=3D"mailto:kaigai@ak.jp=
.nec.com">kaigai@ak.jp.nec.com</a>&gt;&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; Manav<br>
&gt; Hyderabad<br>
<font color=3D"#888888"><br>
<br>
--<br>
</font><div><div></div><div class=3D"h5">KaiGai Kohei &lt;<a href=3D"mailto=
:kaigai@ak.jp.nec.com">kaigai@ak.jp.nec.com</a>&gt;<br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br>Manav<br>Hy=
derabad<br>

--0016361e815ef237000481fae345--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
