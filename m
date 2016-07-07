Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u67CcDMS031581
 for <selinux@tycho.nsa.gov>; Thu, 7 Jul 2016 08:38:13 -0400
Received: by mail-oi0-f68.google.com with SMTP id d132so2308993oig.2
 for <selinux@tycho.nsa.gov>; Thu, 07 Jul 2016 05:37:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160706121257.GS16797@redhat.com>
References: <1467798202-6412-1-git-send-email-rjones@redhat.com>
 <20160706112942.GA21226@meriadoc.perfinion.com>
 <20160706121257.GS16797@redhat.com>
From: Sven Vermeulen <sven.j.vermeulen@gmail.com>
Date: Thu, 7 Jul 2016 14:37:55 +0200
Message-ID: <CAPzO=Nzh7Rd124+WbsTcLw1zTKBKJ9BR6+HLA16qCFGXx8x7+w@mail.gmail.com>
Subject: Re: [PATCH] libselinux: If autorelabel, force permissive mode.
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

On Wed, Jul 6, 2016 at 2:12 PM, Richard W.M. Jones <rjones@redhat.com> wrote:
>> > The autorelabel feature has been broken in Fedora for a while.
>> > virt-builder relies on this feature to enable SELinux in guests since
>> > we are unable to set filesystem labels when generating the image.  So
>> > it comes down to me to try to fix this.  There was a discussion on the
>> > Fedora development list which explains the background and the reasons
>> > why autorelabel is broken:
>> >
>> > http://thread.gmane.org/gmane.linux.redhat.fedora.devel/220453
>> >
>> > The plan to fix autorelabel (also formulated in the above thread) is
>> > in two parts:
>> >
>> > (1) [This patch] If the autorelabel condition is detected when loading
>> > policy very early during boot, we set SELinux to permissive mode
>> > (overriding the contents of /etc/selinux/config and the command line).
>>
>> Can't you just set enforcing=0 on the kernel commandline for the first
>> boot?
>
> For virt-builder, no.  We create automated images that must
> boot themselves without manual intervention.
>
> However even ignoring my use case, I don't think it's a good idea
> anyway.  If /.autorelabel is set, then the labels on the filesystem
> are known to be wrong.  You shouldn't be making enforcement decisions
> based on labels which you know are wrong.

I agree with the sentiment, but not with its execution. You can't
guarantee that there is a systemd generator or other process in place
that will pick this situation up, run the setfiles (or equivalent)
service, remove the touch file and reboot. If you could, then that
would be awesome.

Let's say there is a platform that does not support /.autorelabel (not
sure how SEAndroid works, but on Gentoo we don't look at that file).
This patch would place the system in permissive mode, but just
continue regardless.

>> This patch sounds a bit dangerous. If anyone can touch /.autorelabel
>> later on the machine will be in permissive mode on next reboot.
>
> If someone can create files in / then I suspect you've got other
> problems.  In any case it will then immediately jump to the generator
> and relabel in a (very) minimal environment and reboot.  After this
> second boot it'll be back to enforcing (or whatever is requested by
> /etc/selinux/config).

SELinux is quite capable of allowing people to create files in / while
still not being able to do much else on the system. And the generator
step is only on a set of platforms, not all of those supporting
SELinux.

Wouldn't it be possible to reverse the logic? Introduce a
"checkautorelabel" kernel/boot option, and if that option is set, then
activate this logic? That way, other platforms beyond Fedora can
happily continue regardless, and you can by default enable the
checkautorelabel boot option.

Wkr,
  Sven Vermeulen
