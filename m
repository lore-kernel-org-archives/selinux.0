Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2I44hsS007058
	for <selinux@tycho.nsa.gov>; Thu, 18 Mar 2010 00:04:43 -0400
Received: from mail-yw0-f179.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o2I45IQK025489
	for <selinux@tycho.nsa.gov>; Thu, 18 Mar 2010 04:05:18 GMT
Received: by ywh9 with SMTP id 9so720372ywh.18
        for <selinux@tycho.nsa.gov>; Wed, 17 Mar 2010 21:04:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4BA171AE.9090508@ak.jp.nec.com>
References: <482a0d8c1003100413w4b2d060fy493a72f6a76b976e@mail.gmail.com>
	 <1268243344.3678.38.camel@moss-pluto.epoch.ncsc.mil>
	 <482a0d8c1003110208g9843309s83e41c6319ff8271@mail.gmail.com>
	 <482a0d8c1003162122y50c4f6adq3d1e4ab7a9d481ed@mail.gmail.com>
	 <4BA06092.9030302@ak.jp.nec.com>
	 <482a0d8c1003162308r3989a64by797220bf38dffdb3@mail.gmail.com>
	 <482a0d8c1003170012w6de08b88l11c5a0d23420b805@mail.gmail.com>
	 <4BA0894C.1060005@ak.jp.nec.com>
	 <482a0d8c1003170127w1d151315we0b2c6e8cfc3a913@mail.gmail.com>
	 <4BA171AE.9090508@ak.jp.nec.com>
Date: Thu, 18 Mar 2010 09:34:41 +0530
Message-ID: <482a0d8c1003172104r3ff4dc9csa065de1681b4794a@mail.gmail.com>
Subject: Re: working linux and busybox versions
From: Manvendra Pratap Singh <manav.emb@gmail.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=0016e64d9a1d90fb0c04820b5449
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0016e64d9a1d90fb0c04820b5449
Content-Type: text/plain; charset=ISO-8859-1

2010/3/18 KaiGai Kohei <kaigai@ak.jp.nec.com>

> (2010/03/17 17:27), Manvendra Pratap Singh wrote:
> >
> >
> > 2010/3/17 KaiGai Kohei <kaigai@ak.jp.nec.com <mailto:
> kaigai@ak.jp.nec.com>>
> >
> >     (2010/03/17 16:12), Manvendra Pratap Singh wrote:
> >      > Hi KaiGai,
> >      >
> >      > I checked /etc/selinux/base_policy/contexts/default_contexts and
> >      > /etc/selinux/base_policy/contexts/users/root both in my rootfs
> >     and it is
> >      > in correct place. But it still giving me same SID problem. Please
> >     give
> >      > some idea.
> >
> >     Does it have correct format? Does it contains an entry which matches
> >     with the security context of your logind daemon?
> >
> >     If your policy does not define domain-transitions appropriately,
> >     all the process may work with kernel_t, init_t or initrc_t.
> >     If so, get_default_context() cannot find out configured entry.
> >
> >
> > I am very new to SELinux, so I may not be able to answer your all
> > questions correctly. I compiled base policy and then included it in my
> > rootfs ( at /etc/selinux/base_policy). I compiled busbox-1.13.0 and
> > 2.6.29 linux-kernel with SELinux support. I faced lot of errors and
> > problems while compiling busybox with SELinux (utilities) support.
>
> What kind of errors did you see?
> If we cannot build busybox with SELinux support in the recent releases,
> we need to fix them.
>
>

This time I tried with busybox-1.11.3, Please have a look at the errors:

manav@manav-desktop:busybox-1.11.3$ make ARCH=arm
CROSS_CONFIG=arm-none-linux-gnueabi-
  SPLIT   include/autoconf.h -> include/config/*
  GEN     include/bbconfigopts.h
  HOSTCC  applets/usage
applets/usage.c: In function 'main':
applets/usage.c:27: warning: ignoring return value of 'write', declared with
attribute warn_unused_result
  GEN     include/usage_compressed.h
  HOSTCC  applets/applet_tables
In file included from applets/../include/busybox.h:10,
                 from applets/applet_tables.c:16:
applets/../include/libbb.h:56:29: error: selinux/selinux.h: No such file or
directory
applets/../include/libbb.h:57:29: error: selinux/context.h: No such file or
directory
applets/../include/libbb.h:58:27: error: selinux/flask.h: No such file or
directory
applets/../include/libbb.h:59:36: error: selinux/av_permissions.h: No such
file or directory
In file included from applets/../include/busybox.h:10,
                 from applets/applet_tables.c:16:
applets/../include/libbb.h:1007: error: expected ')' before 'sid'
applets/../include/libbb.h:1008: error: expected '=', ',', ';', 'asm' or
'__attribute__' before 'set_security_context_component'
applets/../include/libbb.h:1010: error: expected ')' before 'scontext'
make[1]: *** [applets/applet_tables] Error 1
make: *** [applets] Error 2





> > then
> > I booted beagle. And faced above problem. I did not try any extra code
> > other then base_policy, Because initially I wanted to see  the kernel
> > booting with SELinux support and working SELinux utilities provided by
> > busybox.
> >
> >     What is your policy type? The standard reference policy?, or others?
> >
> >
> > I think my policy is standard reference policy.
>
> Hmm... It seems to me reason of the matter is still unclear.
>
> Could you check the following items at least?
> - The security policy was correctly loaded?
>  If OK, the kernel exports log messages as Stephen noted.
>


yes, I will surely check for this, and let you know the results.


>
> - What kind of matter you faced when you build busybox and libselinux?
>  If you modified the code, what kind of changes were applied?
>
> - Is the filesystem correctly labeled?
>  If files don't have valid security context, SELinux considers all the
>  files have "unlabeled_t" context, but it is not expected for reference
>  policy.
>
> Right now, I doubt your /sbin/init could not load the security policy
> correctly. SELinux performs permissive mode, if it failed to load the
> policy. So, you can see the login prompt without any fails, because it
> means bootstrap sequence was correctly done.
>
> Also note that /sbin/init applet of busybox also support to load the
> policy at first. If you applied different binary, it needs to be replaced.
>

I have replaced the binary.

Thanks guys for your support, let me come up with results.


>
> Thanks,
>
> >     Thanks,
> >
> >      > On Wed, Mar 17, 2010 at 11:38 AM, Manvendra Pratap Singh
> >      > <manav.emb@gmail.com <mailto:manav.emb@gmail.com>
> >     <mailto:manav.emb@gmail.com <mailto:manav.emb@gmail.com>>> wrote:
> >      >
> >      >     Thanks for reply KaiGai Kohei, I will follow your suggestion
> >     and let
> >      >     you know about it.
> >      >
> >      >     ---
> >      >     Manav
> >      >     Hyderabad
> >      >
> >      >     2010/3/17 KaiGai Kohei <kaigai@ak.jp.nec.com
> >     <mailto:kaigai@ak.jp.nec.com>
> >      > <mailto:kaigai@ak.jp.nec.com <mailto:kaigai@ak.jp.nec.com>>>
> >      >
> >      >         (2010/03/17 13:22), Manvendra Pratap Singh wrote:
> >      > > Can anyone suggest me good guide for SELinux on omap3
> >      >         (beagleboard). I
> >      > > tried it myself but I am not able to login after booting. On
> >      >         loging in
> >      > > root I get a msg "Cann't get SID for root". Please help me on
> >      >         this
> >      > > issue.  Here take a look at boot-log.
> >      > >
> >      > >
> >      > > [    0.000000] Security Framework initialized
> >      > > [    0.000000] SELinux:  Initializing.
> >      > >
> >      > >
> >      > > beagleboard login: root
> >      > > login: can't get SID for root
> >      >
> >      >         This message come from logind applet of busybox.
> >      >
> >      >         It tries to fetch the default security context of the
> >     root session.
> >      >
> >      >         Put "/etc/selinux/<SELINUXTYPE>/contexts/default_contexts"
> or
> >      > "/etc/selinux/<SELINUXTYPE>/contexts/users/root" correctly, and
> >      >         try it again.
> >      >
> >      >         Thanks,
> >      >
> >      > >
> >      > > Embinux Linux 1.1 beagleboard ttyS2
> >      > >
> >      > > beagleboard login:
> >      > >
> >      > >
> >      > >
> >      > > ---
> >      > > Manav
> >      > > Hyderabad
> >      > >
> >      > >
> >      > >
> >      > > On Thu, Mar 11, 2010 at 3:38 PM, Manvendra Pratap Singh
> >      > > <manav.emb@gmail.com <mailto:manav.emb@gmail.com>
> >     <mailto:manav.emb@gmail.com <mailto:manav.emb@gmail.com>>
> >      > <mailto:manav.emb@gmail.com <mailto:manav.emb@gmail.com>
> >     <mailto:manav.emb@gmail.com <mailto:manav.emb@gmail.com>>>> wrote:
> >      > >
> >      > >     Thanks for the information. I asked about working busybox
> >      >         and linux
> >      > >     kernel versions because when I am enabling selinux in
> busybox
> >      > >     (1.13.0), it is giving me lot of compilation errors and I
> >      >         think some
> >      > >     code is also missing. Although the kernel (2.6.29) which
> >      >         I am using
> >      > >     is working fine. If you tell anything more on this then
> >      >         it will be a
> >      > >     great help.
> >      > >
> >      > >
> >      > >     --
> >      > >     Manav
> >      > >     Hyderabad
> >      > >
> >      > >
> >      > >
> >      > >     On Wed, Mar 10, 2010 at 11:19 PM, Stephen Smalley
> >      > <sds@tycho.nsa.gov <mailto:sds@tycho.nsa.gov>
> >     <mailto:sds@tycho.nsa.gov <mailto:sds@tycho.nsa.gov>>
> >      > > <mailto:sds@tycho.nsa.gov <mailto:sds@tycho.nsa.gov>
> >     <mailto:sds@tycho.nsa.gov <mailto:sds@tycho.nsa.gov>>>> wrote:
> >      > >
> >      > >         On Wed, 2010-03-10 at 22:44 +0530, Manvendra Pratap
> >      >         Singh wrote:
> >      > > > Hi Stephen,
> >      > > >
> >      > > > May be I could not make myself clear to you. My question was
> >      > >         not about
> >      > > > linux on omap3, it was about SELinux on omap3. Anyways thanks
> >      > >         for your
> >      > > > reply. I will check the links given by you.
> >      > >
> >      > >         SELinux isn't platform-specific, and is a component
> >      >         of the Linux 2.6
> >      > >         kernel.
> >      > >
> >      > >         --
> >      > >         Stephen Smalley
> >      > >         National Security Agency
> >      > >
> >      > >
> >      > >
> >      >
> >      >
> >      >         --
> >      >         KaiGai Kohei <kaigai@ak.jp.nec.com
> >     <mailto:kaigai@ak.jp.nec.com> <mailto:kaigai@ak.jp.nec.com
> >     <mailto:kaigai@ak.jp.nec.com>>>
> >      >
> >      >
> >      >
> >      >
> >      >
> >      > --
> >      > Manav
> >      > Hyderabad
> >
> >
> >     --
> >     KaiGai Kohei <kaigai@ak.jp.nec.com <mailto:kaigai@ak.jp.nec.com>>
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

--0016e64d9a1d90fb0c04820b5449
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2010/3/18 KaiGai Kohei <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:kaigai@ak.jp.nec.com">kaigai@ak.jp.nec.com</a>&gt;</=
span><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid =
rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im">(2010/03/17 17:27), Manvendra Pratap Singh wrote:<br>
&gt;<br>
&gt;<br>
&gt; 2010/3/17 KaiGai Kohei &lt;<a href=3D"mailto:kaigai@ak.jp.nec.com">kai=
gai@ak.jp.nec.com</a> &lt;mailto:<a href=3D"mailto:kaigai@ak.jp.nec.com">ka=
igai@ak.jp.nec.com</a>&gt;&gt;<br>
&gt;<br>
</div><div class=3D"im">&gt; =A0 =A0 (2010/03/17 16:12), Manvendra Pratap S=
ingh wrote:<br>
&gt; =A0 =A0 =A0&gt; Hi KaiGai,<br>
&gt; =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0&gt; I checked /etc/selinux/base_policy/contexts/default_co=
ntexts and<br>
&gt; =A0 =A0 =A0&gt; /etc/selinux/base_policy/contexts/users/root both in m=
y rootfs<br>
&gt; =A0 =A0 and it is<br>
&gt; =A0 =A0 =A0&gt; in correct place. But it still giving me same SID prob=
lem. Please<br>
&gt; =A0 =A0 give<br>
&gt; =A0 =A0 =A0&gt; some idea.<br>
&gt;<br>
&gt; =A0 =A0 Does it have correct format? Does it contains an entry which m=
atches<br>
&gt; =A0 =A0 with the security context of your logind daemon?<br>
&gt;<br>
&gt; =A0 =A0 If your policy does not define domain-transitions appropriatel=
y,<br>
&gt; =A0 =A0 all the process may work with kernel_t, init_t or initrc_t.<br=
>
&gt; =A0 =A0 If so, get_default_context() cannot find out configured entry.=
<br>
&gt;<br>
&gt;<br>
&gt; I am very new to SELinux, so I may not be able to answer your all<br>
&gt; questions correctly. I compiled base policy and then included it in my=
<br>
&gt; rootfs ( at /etc/selinux/base_policy). I compiled busbox-1.13.0 and<br=
>
&gt; 2.6.29 linux-kernel with SELinux support. I faced lot of errors and<br=
>
&gt; problems while compiling busybox with SELinux (utilities) support.<br>
<br>
</div>What kind of errors did you see?<br>
If we cannot build busybox with SELinux support in the recent releases,<br>
we need to fix them.<br>
<div class=3D"im"><br></div></blockquote><div><br><br>This time I tried wit=
h busybox-1.11.3, Please have a look at the errors:<br><br>manav@manav-desk=
top:busybox-1.11.3$ make ARCH=3Darm CROSS_CONFIG=3Darm-none-linux-gnueabi-=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>
=A0 SPLIT=A0=A0 include/autoconf.h -&gt; include/config/*<br>=A0 GEN=A0=A0=
=A0=A0 include/bbconfigopts.h<br>=A0 HOSTCC=A0 applets/usage<br>applets/usa=
ge.c: In function &#39;main&#39;:<br>applets/usage.c:27: warning: ignoring =
return value of &#39;write&#39;, declared with attribute warn_unused_result=
<br>
=A0 GEN=A0=A0=A0=A0 include/usage_compressed.h<br>=A0 HOSTCC=A0 applets/app=
let_tables<br>In file included from applets/../include/busybox.h:10,<br>=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from applets/applet_tables.c:=
16:<br>applets/../include/libbb.h:56:29: error: selinux/selinux.h: No such =
file or directory<br>
applets/../include/libbb.h:57:29: error: selinux/context.h: No such file or=
 directory<br>applets/../include/libbb.h:58:27: error: selinux/flask.h: No =
such file or directory<br>applets/../include/libbb.h:59:36: error: selinux/=
av_permissions.h: No such file or directory<br>
In file included from applets/../include/busybox.h:10,<br>=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from applets/applet_tables.c:16:<br>apple=
ts/../include/libbb.h:1007: error: expected &#39;)&#39; before &#39;sid&#39=
;<br>applets/../include/libbb.h:1008: error: expected &#39;=3D&#39;, &#39;,=
&#39;, &#39;;&#39;, &#39;asm&#39; or &#39;__attribute__&#39; before &#39;se=
t_security_context_component&#39;<br>
applets/../include/libbb.h:1010: error: expected &#39;)&#39; before &#39;sc=
ontext&#39;<br>make[1]: *** [applets/applet_tables] Error 1<br>make: *** [a=
pplets] Error 2<br><br><br><br>=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8e=
x; padding-left: 1ex;">
<div class=3D"im">
&gt; then<br>
&gt; I booted beagle. And faced above problem. I did not try any extra code=
<br>
&gt; other then base_policy, Because initially I wanted to see =A0the kerne=
l<br>
&gt; booting with SELinux support and working SELinux utilities provided by=
<br>
&gt; busybox.<br>
&gt;<br>
&gt; =A0 =A0 What is your policy type? The standard reference policy?, or o=
thers?<br>
&gt;<br>
&gt;<br>
&gt; I think my policy is standard reference policy.<br>
<br>
</div>Hmm... It seems to me reason of the matter is still unclear.<br>
<br>
Could you check the following items at least?<br>
- The security policy was correctly loaded?<br>
 =A0If OK, the kernel exports log messages as Stephen noted.<br></blockquot=
e><div><br><br>yes, I will surely check for this, and let you know the resu=
lts.<br>=A0<br></div><blockquote class=3D"gmail_quote" style=3D"border-left=
: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1e=
x;">

<br>
- What kind of matter you faced when you build busybox and libselinux?<br>
 =A0If you modified the code, what kind of changes were applied?<br>
<br>
- Is the filesystem correctly labeled?<br>
 =A0If files don&#39;t have valid security context, SELinux considers all t=
he<br>
 =A0files have &quot;unlabeled_t&quot; context, but it is not expected for =
reference<br>
 =A0policy.<br>
<br>
Right now, I doubt your /sbin/init could not load the security policy<br>
correctly. SELinux performs permissive mode, if it failed to load the<br>
policy. So, you can see the login prompt without any fails, because it<br>
means bootstrap sequence was correctly done.<br>
<br>
Also note that /sbin/init applet of busybox also support to load the<br>
policy at first. If you applied different binary, it needs to be replaced.<=
br></blockquote><div><br>I have replaced the binary.<br><br>Thanks guys for=
 your  support, let me come up with results.<br>=A0</div><blockquote class=
=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin=
: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

<br>
Thanks,<br>
<div class=3D"im"><br>
&gt; =A0 =A0 Thanks,<br>
&gt;<br>
&gt; =A0 =A0 =A0&gt; On Wed, Mar 17, 2010 at 11:38 AM, Manvendra Pratap Sin=
gh<br>
&gt; =A0 =A0 =A0&gt; &lt;<a href=3D"mailto:manav.emb@gmail.com">manav.emb@g=
mail.com</a> &lt;mailto:<a href=3D"mailto:manav.emb@gmail.com">manav.emb@gm=
ail.com</a>&gt;<br>
</div><div class=3D"im">&gt; =A0 =A0 &lt;mailto:<a href=3D"mailto:manav.emb=
@gmail.com">manav.emb@gmail.com</a> &lt;mailto:<a href=3D"mailto:manav.emb@=
gmail.com">manav.emb@gmail.com</a>&gt;&gt;&gt; wrote:<br>
&gt; =A0 =A0 =A0&gt;<br>
</div><div class=3D"im">&gt; =A0 =A0 =A0&gt; =A0 =A0 Thanks for reply KaiGa=
i Kohei, I will follow your suggestion<br>
&gt; =A0 =A0 and let<br>
&gt; =A0 =A0 =A0&gt; =A0 =A0 you know about it.<br>
&gt; =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0&gt; =A0 =A0 ---<br>
&gt; =A0 =A0 =A0&gt; =A0 =A0 Manav<br>
&gt; =A0 =A0 =A0&gt; =A0 =A0 Hyderabad<br>
&gt; =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0&gt; =A0 =A0 2010/3/17 KaiGai Kohei &lt;<a href=3D"mailto:k=
aigai@ak.jp.nec.com">kaigai@ak.jp.nec.com</a><br>
&gt; =A0 =A0 &lt;mailto:<a href=3D"mailto:kaigai@ak.jp.nec.com">kaigai@ak.j=
p.nec.com</a>&gt;<br>
</div>&gt; =A0 =A0 =A0&gt; &lt;mailto:<a href=3D"mailto:kaigai@ak.jp.nec.co=
m">kaigai@ak.jp.nec.com</a> &lt;mailto:<a href=3D"mailto:kaigai@ak.jp.nec.c=
om">kaigai@ak.jp.nec.com</a>&gt;&gt;&gt;<br>
<div><div></div><div class=3D"h5">&gt; =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0&gt; =A0 =A0 =A0 =A0 (2010/03/17 13:22), Manvendra Pratap S=
ingh wrote:<br>
&gt; =A0 =A0 =A0&gt; &gt; Can anyone suggest me good guide for SELinux on o=
map3<br>
&gt; =A0 =A0 =A0&gt; =A0 =A0 =A0 =A0 (beagleboard). I<br>
&gt; =A0 =A0 =A0&gt; &gt; tried it myself but I am not able to login after =
booting. On<br>
&gt; =A0 =A0 =A0&gt; =A0 =A0 =A0 =A0 loging in<br>
&gt; =A0 =A0 =A0&gt; &gt; root I get a msg &quot;Cann&#39;t get SID for roo=
t&quot;. Please help me on<br>
&gt; =A0 =A0 =A0&gt; =A0 =A0 =A0 =A0 this<br>
&gt; =A0 =A0 =A0&gt; &gt; issue. =A0Here take a look at boot-log.<br>
&gt; =A0 =A0 =A0&gt; &gt;<br>
&gt; =A0 =A0 =A0&gt; &gt;<br>
&gt; =A0 =A0 =A0&gt; &gt; [ =A0 =A00.000000] Security Framework initialized=
<br>
&gt; =A0 =A0 =A0&gt; &gt; [ =A0 =A00.000000] SELinux: =A0Initializing.<br>
&gt; =A0 =A0 =A0&gt; &gt;<br>
&gt; =A0 =A0 =A0&gt; &gt;<br>
&gt; =A0 =A0 =A0&gt; &gt; beagleboard login: root<br>
&gt; =A0 =A0 =A0&gt; &gt; login: can&#39;t get SID for root<br>
&gt; =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0&gt; =A0 =A0 =A0 =A0 This message come from logind applet o=
f busybox.<br>
&gt; =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0&gt; =A0 =A0 =A0 =A0 It tries to fetch the default security=
 context of the<br>
&gt; =A0 =A0 root session.<br>
&gt; =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0&gt; =A0 =A0 =A0 =A0 Put &quot;/etc/selinux/&lt;SELINUXTYPE=
&gt;/contexts/default_contexts&quot; or<br>
&gt; =A0 =A0 =A0&gt; &quot;/etc/selinux/&lt;SELINUXTYPE&gt;/contexts/users/=
root&quot; correctly, and<br>
&gt; =A0 =A0 =A0&gt; =A0 =A0 =A0 =A0 try it again.<br>
&gt; =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0&gt; =A0 =A0 =A0 =A0 Thanks,<br>
&gt; =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0&gt; &gt;<br>
&gt; =A0 =A0 =A0&gt; &gt; Embinux Linux 1.1 beagleboard ttyS2<br>
&gt; =A0 =A0 =A0&gt; &gt;<br>
&gt; =A0 =A0 =A0&gt; &gt; beagleboard login:<br>
&gt; =A0 =A0 =A0&gt; &gt;<br>
&gt; =A0 =A0 =A0&gt; &gt;<br>
&gt; =A0 =A0 =A0&gt; &gt;<br>
&gt; =A0 =A0 =A0&gt; &gt; ---<br>
&gt; =A0 =A0 =A0&gt; &gt; Manav<br>
&gt; =A0 =A0 =A0&gt; &gt; Hyderabad<br>
&gt; =A0 =A0 =A0&gt; &gt;<br>
&gt; =A0 =A0 =A0&gt; &gt;<br>
&gt; =A0 =A0 =A0&gt; &gt;<br>
&gt; =A0 =A0 =A0&gt; &gt; On Thu, Mar 11, 2010 at 3:38 PM, Manvendra Pratap=
 Singh<br>
&gt; =A0 =A0 =A0&gt; &gt; &lt;<a href=3D"mailto:manav.emb@gmail.com">manav.=
emb@gmail.com</a> &lt;mailto:<a href=3D"mailto:manav.emb@gmail.com">manav.e=
mb@gmail.com</a>&gt;<br>
&gt; =A0 =A0 &lt;mailto:<a href=3D"mailto:manav.emb@gmail.com">manav.emb@gm=
ail.com</a> &lt;mailto:<a href=3D"mailto:manav.emb@gmail.com">manav.emb@gma=
il.com</a>&gt;&gt;<br>
&gt; =A0 =A0 =A0&gt; &lt;mailto:<a href=3D"mailto:manav.emb@gmail.com">mana=
v.emb@gmail.com</a> &lt;mailto:<a href=3D"mailto:manav.emb@gmail.com">manav=
.emb@gmail.com</a>&gt;<br>
&gt; =A0 =A0 &lt;mailto:<a href=3D"mailto:manav.emb@gmail.com">manav.emb@gm=
ail.com</a> &lt;mailto:<a href=3D"mailto:manav.emb@gmail.com">manav.emb@gma=
il.com</a>&gt;&gt;&gt;&gt; wrote:<br>
&gt; =A0 =A0 =A0&gt; &gt;<br>
&gt; =A0 =A0 =A0&gt; &gt; =A0 =A0 Thanks for the information. I asked about=
 working busybox<br>
&gt; =A0 =A0 =A0&gt; =A0 =A0 =A0 =A0 and linux<br>
&gt; =A0 =A0 =A0&gt; &gt; =A0 =A0 kernel versions because when I am enablin=
g selinux in busybox<br>
&gt; =A0 =A0 =A0&gt; &gt; =A0 =A0 (1.13.0), it is giving me lot of compilat=
ion errors and I<br>
&gt; =A0 =A0 =A0&gt; =A0 =A0 =A0 =A0 think some<br>
&gt; =A0 =A0 =A0&gt; &gt; =A0 =A0 code is also missing. Although the kernel=
 (2.6.29) which<br>
&gt; =A0 =A0 =A0&gt; =A0 =A0 =A0 =A0 I am using<br>
&gt; =A0 =A0 =A0&gt; &gt; =A0 =A0 is working fine. If you tell anything mor=
e on this then<br>
&gt; =A0 =A0 =A0&gt; =A0 =A0 =A0 =A0 it will be a<br>
&gt; =A0 =A0 =A0&gt; &gt; =A0 =A0 great help.<br>
&gt; =A0 =A0 =A0&gt; &gt;<br>
&gt; =A0 =A0 =A0&gt; &gt;<br>
&gt; =A0 =A0 =A0&gt; &gt; =A0 =A0 --<br>
&gt; =A0 =A0 =A0&gt; &gt; =A0 =A0 Manav<br>
&gt; =A0 =A0 =A0&gt; &gt; =A0 =A0 Hyderabad<br>
&gt; =A0 =A0 =A0&gt; &gt;<br>
&gt; =A0 =A0 =A0&gt; &gt;<br>
&gt; =A0 =A0 =A0&gt; &gt;<br>
&gt; =A0 =A0 =A0&gt; &gt; =A0 =A0 On Wed, Mar 10, 2010 at 11:19 PM, Stephen=
 Smalley<br>
&gt; =A0 =A0 =A0&gt; &lt;<a href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa=
.gov</a> &lt;mailto:<a href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov<=
/a>&gt;<br>
&gt; =A0 =A0 &lt;mailto:<a href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.=
gov</a> &lt;mailto:<a href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</=
a>&gt;&gt;<br>
&gt; =A0 =A0 =A0&gt; &gt; &lt;mailto:<a href=3D"mailto:sds@tycho.nsa.gov">s=
ds@tycho.nsa.gov</a> &lt;mailto:<a href=3D"mailto:sds@tycho.nsa.gov">sds@ty=
cho.nsa.gov</a>&gt;<br>
&gt; =A0 =A0 &lt;mailto:<a href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.=
gov</a> &lt;mailto:<a href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</=
a>&gt;&gt;&gt;&gt; wrote:<br>
&gt; =A0 =A0 =A0&gt; &gt;<br>
&gt; =A0 =A0 =A0&gt; &gt; =A0 =A0 =A0 =A0 On Wed, 2010-03-10 at 22:44 +0530=
, Manvendra Pratap<br>
&gt; =A0 =A0 =A0&gt; =A0 =A0 =A0 =A0 Singh wrote:<br>
&gt; =A0 =A0 =A0&gt; &gt; &gt; Hi Stephen,<br>
&gt; =A0 =A0 =A0&gt; &gt; &gt;<br>
&gt; =A0 =A0 =A0&gt; &gt; &gt; May be I could not make myself clear to you.=
 My question was<br>
&gt; =A0 =A0 =A0&gt; &gt; =A0 =A0 =A0 =A0 not about<br>
&gt; =A0 =A0 =A0&gt; &gt; &gt; linux on omap3, it was about SELinux on omap=
3. Anyways thanks<br>
&gt; =A0 =A0 =A0&gt; &gt; =A0 =A0 =A0 =A0 for your<br>
&gt; =A0 =A0 =A0&gt; &gt; &gt; reply. I will check the links given by you.<=
br>
&gt; =A0 =A0 =A0&gt; &gt;<br>
&gt; =A0 =A0 =A0&gt; &gt; =A0 =A0 =A0 =A0 SELinux isn&#39;t platform-specif=
ic, and is a component<br>
&gt; =A0 =A0 =A0&gt; =A0 =A0 =A0 =A0 of the Linux 2.6<br>
&gt; =A0 =A0 =A0&gt; &gt; =A0 =A0 =A0 =A0 kernel.<br>
&gt; =A0 =A0 =A0&gt; &gt;<br>
&gt; =A0 =A0 =A0&gt; &gt; =A0 =A0 =A0 =A0 --<br>
&gt; =A0 =A0 =A0&gt; &gt; =A0 =A0 =A0 =A0 Stephen Smalley<br>
&gt; =A0 =A0 =A0&gt; &gt; =A0 =A0 =A0 =A0 National Security Agency<br>
&gt; =A0 =A0 =A0&gt; &gt;<br>
&gt; =A0 =A0 =A0&gt; &gt;<br>
&gt; =A0 =A0 =A0&gt; &gt;<br>
&gt; =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0&gt; =A0 =A0 =A0 =A0 --<br>
&gt; =A0 =A0 =A0&gt; =A0 =A0 =A0 =A0 KaiGai Kohei &lt;<a href=3D"mailto:kai=
gai@ak.jp.nec.com">kaigai@ak.jp.nec.com</a><br>
</div></div>&gt; =A0 =A0 &lt;mailto:<a href=3D"mailto:kaigai@ak.jp.nec.com"=
>kaigai@ak.jp.nec.com</a>&gt; &lt;mailto:<a href=3D"mailto:kaigai@ak.jp.nec=
.com">kaigai@ak.jp.nec.com</a><br>
<div><div></div><div class=3D"h5">&gt; =A0 =A0 &lt;mailto:<a href=3D"mailto=
:kaigai@ak.jp.nec.com">kaigai@ak.jp.nec.com</a>&gt;&gt;&gt;<br>
&gt; =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0&gt;<br>
&gt; =A0 =A0 =A0&gt; --<br>
&gt; =A0 =A0 =A0&gt; Manav<br>
&gt; =A0 =A0 =A0&gt; Hyderabad<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 --<br>
&gt; =A0 =A0 KaiGai Kohei &lt;<a href=3D"mailto:kaigai@ak.jp.nec.com">kaiga=
i@ak.jp.nec.com</a> &lt;mailto:<a href=3D"mailto:kaigai@ak.jp.nec.com">kaig=
ai@ak.jp.nec.com</a>&gt;&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; Manav<br>
&gt; Hyderabad<br>
<br>
<br>
--<br>
KaiGai Kohei &lt;<a href=3D"mailto:kaigai@ak.jp.nec.com">kaigai@ak.jp.nec.c=
om</a>&gt;<br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br>Manav<br>Hy=
derabad<br>

--0016e64d9a1d90fb0c04820b5449--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
