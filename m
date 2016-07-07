Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u67CiEIs032487
 for <selinux@tycho.nsa.gov>; Thu, 7 Jul 2016 08:44:14 -0400
Received: by mail-io0-f194.google.com with SMTP id k78so2447294ioi.2
 for <selinux@tycho.nsa.gov>; Thu, 07 Jul 2016 05:43:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPzO=Nzh7Rd124+WbsTcLw1zTKBKJ9BR6+HLA16qCFGXx8x7+w@mail.gmail.com>
References: <1467798202-6412-1-git-send-email-rjones@redhat.com>
 <20160706112942.GA21226@meriadoc.perfinion.com>
 <20160706121257.GS16797@redhat.com>
 <CAPzO=Nzh7Rd124+WbsTcLw1zTKBKJ9BR6+HLA16qCFGXx8x7+w@mail.gmail.com>
Date: Thu, 7 Jul 2016 08:43:45 -0400
Message-ID: <CAFftDdoP7T8nb5SYyKiGhoyc8_E2kLoA1WmajtP55yNNoW93dQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: If autorelabel, force permissive mode.
From: William Roberts <bill.c.roberts@gmail.com>
To: Sven Vermeulen <sven.j.vermeulen@gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a113f261666540b05370b09ff
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

--001a113f261666540b05370b09ff
Content-Type: text/plain; charset=UTF-8

On Jul 7, 2016 08:40, "Sven Vermeulen" <sven.j.vermeulen@gmail.com> wrote:
>
> On Wed, Jul 6, 2016 at 2:12 PM, Richard W.M. Jones <rjones@redhat.com>
wrote:
> >> > The autorelabel feature has been broken in Fedora for a while.
> >> > virt-builder relies on this feature to enable SELinux in guests since
> >> > we are unable to set filesystem labels when generating the image.  So
> >> > it comes down to me to try to fix this.  There was a discussion on
the
> >> > Fedora development list which explains the background and the reasons
> >> > why autorelabel is broken:
> >> >
> >> > http://thread.gmane.org/gmane.linux.redhat.fedora.devel/220453
> >> >
> >> > The plan to fix autorelabel (also formulated in the above thread) is
> >> > in two parts:
> >> >
> >> > (1) [This patch] If the autorelabel condition is detected when
loading
> >> > policy very early during boot, we set SELinux to permissive mode
> >> > (overriding the contents of /etc/selinux/config and the command
line).
> >>
> >> Can't you just set enforcing=0 on the kernel commandline for the first
> >> boot?
> >
> > For virt-builder, no.  We create automated images that must
> > boot themselves without manual intervention.
> >
> > However even ignoring my use case, I don't think it's a good idea
> > anyway.  If /.autorelabel is set, then the labels on the filesystem
> > are known to be wrong.  You shouldn't be making enforcement decisions
> > based on labels which you know are wrong.
>
> I agree with the sentiment, but not with its execution. You can't
> guarantee that there is a systemd generator or other process in place
> that will pick this situation up, run the setfiles (or equivalent)
> service, remove the touch file and reboot. If you could, then that
> would be awesome.
>
> Let's say there is a platform that does not support /.autorelabel (not
> sure how SEAndroid works, but on Gentoo we don't look at that file).

Android uses a readonly ramdisk so even if it was remounted and written to,
the file would be gone on reboot. However, some newer Android stuff is
moving to an ext4 root filesystem. I'm a bit leary of this change as well,
although in Android if you write to the rootfs we've likely already lost,
best not to be adding functionality that could be used against us.

> This patch would place the system in permissive mode, but just
> continue regardless.
>
> >> This patch sounds a bit dangerous. If anyone can touch /.autorelabel
> >> later on the machine will be in permissive mode on next reboot.
> >
> > If someone can create files in / then I suspect you've got other
> > problems.  In any case it will then immediately jump to the generator
> > and relabel in a (very) minimal environment and reboot.  After this
> > second boot it'll be back to enforcing (or whatever is requested by
> > /etc/selinux/config).
>
> SELinux is quite capable of allowing people to create files in / while
> still not being able to do much else on the system. And the generator
> step is only on a set of platforms, not all of those supporting
> SELinux.
>
> Wouldn't it be possible to reverse the logic? Introduce a
> "checkautorelabel" kernel/boot option, and if that option is set, then
> activate this logic? That way, other platforms beyond Fedora can
> happily continue regardless, and you can by default enable the
> checkautorelabel boot option.
>
> Wkr,
>   Sven Vermeulen
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.

--001a113f261666540b05370b09ff
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Jul 7, 2016 08:40, &quot;Sven Vermeulen&quot; &lt;<a href=3D"mailto:sven=
.j.vermeulen@gmail.com">sven.j.vermeulen@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Wed, Jul 6, 2016 at 2:12 PM, Richard W.M. Jones &lt;<a href=3D"mail=
to:rjones@redhat.com">rjones@redhat.com</a>&gt; wrote:<br>
&gt; &gt;&gt; &gt; The autorelabel feature has been broken in Fedora for a =
while.<br>
&gt; &gt;&gt; &gt; virt-builder relies on this feature to enable SELinux in=
 guests since<br>
&gt; &gt;&gt; &gt; we are unable to set filesystem labels when generating t=
he image.=C2=A0 So<br>
&gt; &gt;&gt; &gt; it comes down to me to try to fix this.=C2=A0 There was =
a discussion on the<br>
&gt; &gt;&gt; &gt; Fedora development list which explains the background an=
d the reasons<br>
&gt; &gt;&gt; &gt; why autorelabel is broken:<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; <a href=3D"http://thread.gmane.org/gmane.linux.redhat.fe=
dora.devel/220453">http://thread.gmane.org/gmane.linux.redhat.fedora.devel/=
220453</a><br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; The plan to fix autorelabel (also formulated in the abov=
e thread) is<br>
&gt; &gt;&gt; &gt; in two parts:<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; (1) [This patch] If the autorelabel condition is detecte=
d when loading<br>
&gt; &gt;&gt; &gt; policy very early during boot, we set SELinux to permiss=
ive mode<br>
&gt; &gt;&gt; &gt; (overriding the contents of /etc/selinux/config and the =
command line).<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Can&#39;t you just set enforcing=3D0 on the kernel commandlin=
e for the first<br>
&gt; &gt;&gt; boot?<br>
&gt; &gt;<br>
&gt; &gt; For virt-builder, no.=C2=A0 We create automated images that must<=
br>
&gt; &gt; boot themselves without manual intervention.<br>
&gt; &gt;<br>
&gt; &gt; However even ignoring my use case, I don&#39;t think it&#39;s a g=
ood idea<br>
&gt; &gt; anyway.=C2=A0 If /.autorelabel is set, then the labels on the fil=
esystem<br>
&gt; &gt; are known to be wrong.=C2=A0 You shouldn&#39;t be making enforcem=
ent decisions<br>
&gt; &gt; based on labels which you know are wrong.<br>
&gt;<br>
&gt; I agree with the sentiment, but not with its execution. You can&#39;t<=
br>
&gt; guarantee that there is a systemd generator or other process in place<=
br>
&gt; that will pick this situation up, run the setfiles (or equivalent)<br>
&gt; service, remove the touch file and reboot. If you could, then that<br>
&gt; would be awesome.<br>
&gt;<br>
&gt; Let&#39;s say there is a platform that does not support /.autorelabel =
(not<br>
&gt; sure how SEAndroid works, but on Gentoo we don&#39;t look at that file=
).</p>
<p dir=3D"ltr">Android uses a readonly ramdisk so even if it was remounted =
and written to, the file would be gone on reboot. However, some newer Andro=
id stuff is moving to an ext4 root filesystem. I&#39;m a bit leary of this =
change as well, although in Android if you write to the rootfs we&#39;ve li=
kely already lost, best not to be adding functionality that could be used a=
gainst us.</p>
<p dir=3D"ltr">&gt; This patch would place the system in permissive mode, b=
ut just<br>
&gt; continue regardless.<br>
&gt;<br>
&gt; &gt;&gt; This patch sounds a bit dangerous. If anyone can touch /.auto=
relabel<br>
&gt; &gt;&gt; later on the machine will be in permissive mode on next reboo=
t.<br>
&gt; &gt;<br>
&gt; &gt; If someone can create files in / then I suspect you&#39;ve got ot=
her<br>
&gt; &gt; problems.=C2=A0 In any case it will then immediately jump to the =
generator<br>
&gt; &gt; and relabel in a (very) minimal environment and reboot.=C2=A0 Aft=
er this<br>
&gt; &gt; second boot it&#39;ll be back to enforcing (or whatever is reques=
ted by<br>
&gt; &gt; /etc/selinux/config).<br>
&gt;<br>
&gt; SELinux is quite capable of allowing people to create files in / while=
<br>
&gt; still not being able to do much else on the system. And the generator<=
br>
&gt; step is only on a set of platforms, not all of those supporting<br>
&gt; SELinux.<br>
&gt;<br>
&gt; Wouldn&#39;t it be possible to reverse the logic? Introduce a<br>
&gt; &quot;checkautorelabel&quot; kernel/boot option, and if that option is=
 set, then<br>
&gt; activate this logic? That way, other platforms beyond Fedora can<br>
&gt; happily continue regardless, and you can by default enable the<br>
&gt; checkautorelabel boot option.<br>
&gt;<br>
&gt; Wkr,<br>
&gt; =C2=A0 Sven Vermeulen<br>
&gt; _______________________________________________<br>
&gt; Selinux mailing list<br>
&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
&gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.ns=
a.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; To get help, send an email containing &quot;help&quot; to <a href=3D"m=
ailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
</p>

--001a113f261666540b05370b09ff--
