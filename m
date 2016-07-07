Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u67DoiXc008790
 for <selinux@tycho.nsa.gov>; Thu, 7 Jul 2016 09:50:44 -0400
Received: by mail-pa0-f65.google.com with SMTP id ib6so1864328pad.3
 for <selinux@tycho.nsa.gov>; Thu, 07 Jul 2016 06:50:24 -0700 (PDT)
Date: Thu, 7 Jul 2016 21:50:17 +0800
From: Jason Zaman <jason@perfinion.com>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] libselinux: If autorelabel, force permissive mode.
Message-ID: <20160707135017.GA23053@meriadoc.perfinion.com>
References: <1467798202-6412-1-git-send-email-rjones@redhat.com>
 <20160706112942.GA21226@meriadoc.perfinion.com>
 <20160706121257.GS16797@redhat.com>
 <CAPzO=Nzh7Rd124+WbsTcLw1zTKBKJ9BR6+HLA16qCFGXx8x7+w@mail.gmail.com>
 <CAFftDdoP7T8nb5SYyKiGhoyc8_E2kLoA1WmajtP55yNNoW93dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFftDdoP7T8nb5SYyKiGhoyc8_E2kLoA1WmajtP55yNNoW93dQ@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

On Thu, Jul 07, 2016 at 08:43:45AM -0400, William Roberts wrote:
> On Jul 7, 2016 08:40, "Sven Vermeulen" <sven.j.vermeulen@gmail.com> wrote:
> >
> > On Wed, Jul 6, 2016 at 2:12 PM, Richard W.M. Jones <rjones@redhat.com>
> wrote:
> > >> > The autorelabel feature has been broken in Fedora for a while.
> > >> > virt-builder relies on this feature to enable SELinux in guests since
> > >> > we are unable to set filesystem labels when generating the image.  So
> > >> > it comes down to me to try to fix this.  There was a discussion on
> the
> > >> > Fedora development list which explains the background and the reasons
> > >> > why autorelabel is broken:
> > >> >
> > >> > http://thread.gmane.org/gmane.linux.redhat.fedora.devel/220453
> > >> >
> > >> > The plan to fix autorelabel (also formulated in the above thread) is
> > >> > in two parts:
> > >> >
> > >> > (1) [This patch] If the autorelabel condition is detected when
> loading
> > >> > policy very early during boot, we set SELinux to permissive mode
> > >> > (overriding the contents of /etc/selinux/config and the command
> line).
> > >>
> > >> Can't you just set enforcing=0 on the kernel commandline for the first
> > >> boot?
> > >
> > > For virt-builder, no.  We create automated images that must
> > > boot themselves without manual intervention.
> > >
> > > However even ignoring my use case, I don't think it's a good idea
> > > anyway.  If /.autorelabel is set, then the labels on the filesystem
> > > are known to be wrong.  You shouldn't be making enforcement decisions
> > > based on labels which you know are wrong.
> >
> > I agree with the sentiment, but not with its execution. You can't
> > guarantee that there is a systemd generator or other process in place
> > that will pick this situation up, run the setfiles (or equivalent)
> > service, remove the touch file and reboot. If you could, then that
> > would be awesome.
> >
> > Let's say there is a platform that does not support /.autorelabel (not
> > sure how SEAndroid works, but on Gentoo we don't look at that file).
> 
> Android uses a readonly ramdisk so even if it was remounted and written to,
> the file would be gone on reboot. However, some newer Android stuff is
> moving to an ext4 root filesystem. I'm a bit leary of this change as well,
> although in Android if you write to the rootfs we've likely already lost,
> best not to be adding functionality that could be used against us.

Alternatively, if someone edits the boot image to have .autorelabel it
will always come back. I definitely agree with not adding functionality
that can be used against us. Currently a user has to check
/etc/selinux/config and the kernel commandline, adding more ways means
more things the user can miss.

Doesn't Android set the labels on the /system disk image during build?
Maybe virt-builder can copy that? This would also speed up initial
deployment of new images.

What steps are required during a default install in RHEL? does an
install from a livecd without virt-builder also have this relabelling
problem?

One way I can think of is have a transition from kernel_t (or whatever
the context would be on a completely unlabelled system) to a domain with
perms to relabel everything. Since the labels would be missing pid1
would have to runcon -t autorelabel_t ... but it seems the safer road
than making absolutely everything permissive.

Alternatively, is there a reason /etc/selinux/config shouldn't be set to
permissive by default in the image? What do we gain with this extra way?
If the user is going to autorelabel after install, they are already
probably setting permissive in the config before they reboot too.

-- Jason

> > This patch would place the system in permissive mode, but just
> > continue regardless.
> >
> > >> This patch sounds a bit dangerous. If anyone can touch /.autorelabel
> > >> later on the machine will be in permissive mode on next reboot.
> > >
> > > If someone can create files in / then I suspect you've got other
> > > problems.  In any case it will then immediately jump to the generator
> > > and relabel in a (very) minimal environment and reboot.  After this
> > > second boot it'll be back to enforcing (or whatever is requested by
> > > /etc/selinux/config).
> >
> > SELinux is quite capable of allowing people to create files in / while
> > still not being able to do much else on the system. And the generator
> > step is only on a set of platforms, not all of those supporting
> > SELinux.
> >
> > Wouldn't it be possible to reverse the logic? Introduce a
> > "checkautorelabel" kernel/boot option, and if that option is set, then
> > activate this logic? That way, other platforms beyond Fedora can
> > happily continue regardless, and you can by default enable the
> > checkautorelabel boot option.
> >
> > Wkr,
> >   Sven Vermeulen
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.

> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
