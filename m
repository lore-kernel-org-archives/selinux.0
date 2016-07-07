Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u67DqrqN008933
 for <selinux@tycho.nsa.gov>; Thu, 7 Jul 2016 09:52:53 -0400
Received: by mail-it0-f48.google.com with SMTP id f6so20332488ith.0
 for <selinux@tycho.nsa.gov>; Thu, 07 Jul 2016 06:52:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160707135017.GA23053@meriadoc.perfinion.com>
References: <1467798202-6412-1-git-send-email-rjones@redhat.com>
 <20160706112942.GA21226@meriadoc.perfinion.com>
 <20160706121257.GS16797@redhat.com>
 <CAPzO=Nzh7Rd124+WbsTcLw1zTKBKJ9BR6+HLA16qCFGXx8x7+w@mail.gmail.com>
 <CAFftDdoP7T8nb5SYyKiGhoyc8_E2kLoA1WmajtP55yNNoW93dQ@mail.gmail.com>
 <20160707135017.GA23053@meriadoc.perfinion.com>
Date: Thu, 7 Jul 2016 09:52:48 -0400
Message-ID: <CAFftDdpcYw7Wxd75_T+xes+uzTJj+0b146aMTHeBP71AiExgLQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: If autorelabel, force permissive mode.
From: William Roberts <bill.c.roberts@gmail.com>
To: Jason Zaman <jason@perfinion.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a113f62d25e741c05370c00c3
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

--001a113f62d25e741c05370c00c3
Content-Type: text/plain; charset=UTF-8

On Jul 7, 2016 09:50, "Jason Zaman" <jason@perfinion.com> wrote:
>
> On Thu, Jul 07, 2016 at 08:43:45AM -0400, William Roberts wrote:
> > On Jul 7, 2016 08:40, "Sven Vermeulen" <sven.j.vermeulen@gmail.com>
wrote:
> > >
> > > On Wed, Jul 6, 2016 at 2:12 PM, Richard W.M. Jones <rjones@redhat.com>
> > wrote:
> > > >> > The autorelabel feature has been broken in Fedora for a while.
> > > >> > virt-builder relies on this feature to enable SELinux in guests
since
> > > >> > we are unable to set filesystem labels when generating the
image.  So
> > > >> > it comes down to me to try to fix this.  There was a discussion
on
> > the
> > > >> > Fedora development list which explains the background and the
reasons
> > > >> > why autorelabel is broken:
> > > >> >
> > > >> > http://thread.gmane.org/gmane.linux.redhat.fedora.devel/220453
> > > >> >
> > > >> > The plan to fix autorelabel (also formulated in the above
thread) is
> > > >> > in two parts:
> > > >> >
> > > >> > (1) [This patch] If the autorelabel condition is detected when
> > loading
> > > >> > policy very early during boot, we set SELinux to permissive mode
> > > >> > (overriding the contents of /etc/selinux/config and the command
> > line).
> > > >>
> > > >> Can't you just set enforcing=0 on the kernel commandline for the
first
> > > >> boot?
> > > >
> > > > For virt-builder, no.  We create automated images that must
> > > > boot themselves without manual intervention.
> > > >
> > > > However even ignoring my use case, I don't think it's a good idea
> > > > anyway.  If /.autorelabel is set, then the labels on the filesystem
> > > > are known to be wrong.  You shouldn't be making enforcement
decisions
> > > > based on labels which you know are wrong.
> > >
> > > I agree with the sentiment, but not with its execution. You can't
> > > guarantee that there is a systemd generator or other process in place
> > > that will pick this situation up, run the setfiles (or equivalent)
> > > service, remove the touch file and reboot. If you could, then that
> > > would be awesome.
> > >
> > > Let's say there is a platform that does not support /.autorelabel (not
> > > sure how SEAndroid works, but on Gentoo we don't look at that file).
> >
> > Android uses a readonly ramdisk so even if it was remounted and written
to,
> > the file would be gone on reboot. However, some newer Android stuff is
> > moving to an ext4 root filesystem. I'm a bit leary of this change as
well,
> > although in Android if you write to the rootfs we've likely already
lost,
> > best not to be adding functionality that could be used against us.
>
> Alternatively, if someone edits the boot image to have .autorelabel it
> will always come back. I definitely agree with not adding functionality

True, I didn't even think about that case.

> that can be used against us. Currently a user has to check
> /etc/selinux/config and the kernel commandline, adding more ways means
> more things the user can miss.
>
> Doesn't Android set the labels on the /system disk image during build?

Yes that is correct.

> Maybe virt-builder can copy that? This would also speed up initial
> deployment of new images.
>
> What steps are required during a default install in RHEL? does an
> install from a livecd without virt-builder also have this relabelling
> problem?
>
> One way I can think of is have a transition from kernel_t (or whatever
> the context would be on a completely unlabelled system) to a domain with
> perms to relabel everything. Since the labels would be missing pid1
> would have to runcon -t autorelabel_t ... but it seems the safer road
> than making absolutely everything permissive.
>
> Alternatively, is there a reason /etc/selinux/config shouldn't be set to
> permissive by default in the image? What do we gain with this extra way?
> If the user is going to autorelabel after install, they are already
> probably setting permissive in the config before they reboot too.
>
> -- Jason
>
> > > This patch would place the system in permissive mode, but just
> > > continue regardless.
> > >
> > > >> This patch sounds a bit dangerous. If anyone can touch
/.autorelabel
> > > >> later on the machine will be in permissive mode on next reboot.
> > > >
> > > > If someone can create files in / then I suspect you've got other
> > > > problems.  In any case it will then immediately jump to the
generator
> > > > and relabel in a (very) minimal environment and reboot.  After this
> > > > second boot it'll be back to enforcing (or whatever is requested by
> > > > /etc/selinux/config).
> > >
> > > SELinux is quite capable of allowing people to create files in / while
> > > still not being able to do much else on the system. And the generator
> > > step is only on a set of platforms, not all of those supporting
> > > SELinux.
> > >
> > > Wouldn't it be possible to reverse the logic? Introduce a
> > > "checkautorelabel" kernel/boot option, and if that option is set, then
> > > activate this logic? That way, other platforms beyond Fedora can
> > > happily continue regardless, and you can by default enable the
> > > checkautorelabel boot option.
> > >
> > > Wkr,
> > >   Sven Vermeulen
> > > _______________________________________________
> > > Selinux mailing list
> > > Selinux@tycho.nsa.gov
> > > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > > To get help, send an email containing "help" to
> > Selinux-request@tycho.nsa.gov.
>
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.
>

--001a113f62d25e741c05370c00c3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Jul 7, 2016 09:50, &quot;Jason Zaman&quot; &lt;<a href=3D"mailto:jason@p=
erfinion.com">jason@perfinion.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Thu, Jul 07, 2016 at 08:43:45AM -0400, William Roberts wrote:<br>
&gt; &gt; On Jul 7, 2016 08:40, &quot;Sven Vermeulen&quot; &lt;<a href=3D"m=
ailto:sven.j.vermeulen@gmail.com">sven.j.vermeulen@gmail.com</a>&gt; wrote:=
<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Wed, Jul 6, 2016 at 2:12 PM, Richard W.M. Jones &lt;<a hr=
ef=3D"mailto:rjones@redhat.com">rjones@redhat.com</a>&gt;<br>
&gt; &gt; wrote:<br>
&gt; &gt; &gt; &gt;&gt; &gt; The autorelabel feature has been broken in Fed=
ora for a while.<br>
&gt; &gt; &gt; &gt;&gt; &gt; virt-builder relies on this feature to enable =
SELinux in guests since<br>
&gt; &gt; &gt; &gt;&gt; &gt; we are unable to set filesystem labels when ge=
nerating the image.=C2=A0 So<br>
&gt; &gt; &gt; &gt;&gt; &gt; it comes down to me to try to fix this.=C2=A0 =
There was a discussion on<br>
&gt; &gt; the<br>
&gt; &gt; &gt; &gt;&gt; &gt; Fedora development list which explains the bac=
kground and the reasons<br>
&gt; &gt; &gt; &gt;&gt; &gt; why autorelabel is broken:<br>
&gt; &gt; &gt; &gt;&gt; &gt;<br>
&gt; &gt; &gt; &gt;&gt; &gt; <a href=3D"http://thread.gmane.org/gmane.linux=
.redhat.fedora.devel/220453">http://thread.gmane.org/gmane.linux.redhat.fed=
ora.devel/220453</a><br>
&gt; &gt; &gt; &gt;&gt; &gt;<br>
&gt; &gt; &gt; &gt;&gt; &gt; The plan to fix autorelabel (also formulated i=
n the above thread) is<br>
&gt; &gt; &gt; &gt;&gt; &gt; in two parts:<br>
&gt; &gt; &gt; &gt;&gt; &gt;<br>
&gt; &gt; &gt; &gt;&gt; &gt; (1) [This patch] If the autorelabel condition =
is detected when<br>
&gt; &gt; loading<br>
&gt; &gt; &gt; &gt;&gt; &gt; policy very early during boot, we set SELinux =
to permissive mode<br>
&gt; &gt; &gt; &gt;&gt; &gt; (overriding the contents of /etc/selinux/confi=
g and the command<br>
&gt; &gt; line).<br>
&gt; &gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt; &gt;&gt; Can&#39;t you just set enforcing=3D0 on the kernel =
commandline for the first<br>
&gt; &gt; &gt; &gt;&gt; boot?<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; For virt-builder, no.=C2=A0 We create automated images =
that must<br>
&gt; &gt; &gt; &gt; boot themselves without manual intervention.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; However even ignoring my use case, I don&#39;t think it=
&#39;s a good idea<br>
&gt; &gt; &gt; &gt; anyway.=C2=A0 If /.autorelabel is set, then the labels =
on the filesystem<br>
&gt; &gt; &gt; &gt; are known to be wrong.=C2=A0 You shouldn&#39;t be makin=
g enforcement decisions<br>
&gt; &gt; &gt; &gt; based on labels which you know are wrong.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I agree with the sentiment, but not with its execution. You =
can&#39;t<br>
&gt; &gt; &gt; guarantee that there is a systemd generator or other process=
 in place<br>
&gt; &gt; &gt; that will pick this situation up, run the setfiles (or equiv=
alent)<br>
&gt; &gt; &gt; service, remove the touch file and reboot. If you could, the=
n that<br>
&gt; &gt; &gt; would be awesome.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Let&#39;s say there is a platform that does not support /.au=
torelabel (not<br>
&gt; &gt; &gt; sure how SEAndroid works, but on Gentoo we don&#39;t look at=
 that file).<br>
&gt; &gt;<br>
&gt; &gt; Android uses a readonly ramdisk so even if it was remounted and w=
ritten to,<br>
&gt; &gt; the file would be gone on reboot. However, some newer Android stu=
ff is<br>
&gt; &gt; moving to an ext4 root filesystem. I&#39;m a bit leary of this ch=
ange as well,<br>
&gt; &gt; although in Android if you write to the rootfs we&#39;ve likely a=
lready lost,<br>
&gt; &gt; best not to be adding functionality that could be used against us=
.<br>
&gt;<br>
&gt; Alternatively, if someone edits the boot image to have .autorelabel it=
<br>
&gt; will always come back. I definitely agree with not adding functionalit=
y</p>
<p dir=3D"ltr">True, I didn&#39;t even think about that case.</p>
<p dir=3D"ltr">&gt; that can be used against us. Currently a user has to ch=
eck<br>
&gt; /etc/selinux/config and the kernel commandline, adding more ways means=
<br>
&gt; more things the user can miss.<br>
&gt;<br>
&gt; Doesn&#39;t Android set the labels on the /system disk image during bu=
ild?</p>
<p dir=3D"ltr">Yes that is correct.</p>
<p dir=3D"ltr">&gt; Maybe virt-builder can copy that? This would also speed=
 up initial<br>
&gt; deployment of new images.<br>
&gt;<br>
&gt; What steps are required during a default install in RHEL? does an<br>
&gt; install from a livecd without virt-builder also have this relabelling<=
br>
&gt; problem?<br>
&gt;<br>
&gt; One way I can think of is have a transition from kernel_t (or whatever=
<br>
&gt; the context would be on a completely unlabelled system) to a domain wi=
th<br>
&gt; perms to relabel everything. Since the labels would be missing pid1<br=
>
&gt; would have to runcon -t autorelabel_t ... but it seems the safer road<=
br>
&gt; than making absolutely everything permissive.<br>
&gt;<br>
&gt; Alternatively, is there a reason /etc/selinux/config shouldn&#39;t be =
set to<br>
&gt; permissive by default in the image? What do we gain with this extra wa=
y?<br>
&gt; If the user is going to autorelabel after install, they are already<br=
>
&gt; probably setting permissive in the config before they reboot too.<br>
&gt;<br>
&gt; -- Jason<br>
&gt;<br>
&gt; &gt; &gt; This patch would place the system in permissive mode, but ju=
st<br>
&gt; &gt; &gt; continue regardless.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;&gt; This patch sounds a bit dangerous. If anyone can to=
uch /.autorelabel<br>
&gt; &gt; &gt; &gt;&gt; later on the machine will be in permissive mode on =
next reboot.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; If someone can create files in / then I suspect you&#39=
;ve got other<br>
&gt; &gt; &gt; &gt; problems.=C2=A0 In any case it will then immediately ju=
mp to the generator<br>
&gt; &gt; &gt; &gt; and relabel in a (very) minimal environment and reboot.=
=C2=A0 After this<br>
&gt; &gt; &gt; &gt; second boot it&#39;ll be back to enforcing (or whatever=
 is requested by<br>
&gt; &gt; &gt; &gt; /etc/selinux/config).<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; SELinux is quite capable of allowing people to create files =
in / while<br>
&gt; &gt; &gt; still not being able to do much else on the system. And the =
generator<br>
&gt; &gt; &gt; step is only on a set of platforms, not all of those support=
ing<br>
&gt; &gt; &gt; SELinux.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Wouldn&#39;t it be possible to reverse the logic? Introduce =
a<br>
&gt; &gt; &gt; &quot;checkautorelabel&quot; kernel/boot option, and if that=
 option is set, then<br>
&gt; &gt; &gt; activate this logic? That way, other platforms beyond Fedora=
 can<br>
&gt; &gt; &gt; happily continue regardless, and you can by default enable t=
he<br>
&gt; &gt; &gt; checkautorelabel boot option.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Wkr,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0Sven Vermeulen<br>
&gt; &gt; &gt; _______________________________________________<br>
&gt; &gt; &gt; Selinux mailing list<br>
&gt; &gt; &gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.g=
ov</a><br>
&gt; &gt; &gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leav=
e@tycho.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; &gt; &gt; To get help, send an email containing &quot;help&quot; to<br=
>
&gt; &gt; <a href=3D"mailto:Selinux-request@tycho.nsa.gov">Selinux-request@=
tycho.nsa.gov</a>.<br>
&gt;<br>
&gt; &gt; _______________________________________________<br>
&gt; &gt; Selinux mailing list<br>
&gt; &gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a=
><br>
&gt; &gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tyc=
ho.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; &gt; To get help, send an email containing &quot;help&quot; to <a href=
=3D"mailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>=
.<br>
&gt;<br>
</p>

--001a113f62d25e741c05370c00c3--
