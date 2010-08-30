Subject: Re: selinux vs devtmpfs (vs udev)
From: Eric Paris <eparis@redhat.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov, greg@kroah.com,
        sds@tycho.nsa.gov, harald@redhat.com, dwalsh@redhat.com
In-Reply-To: <AANLkTi=aEdKM_hunJmPzXxPqkrbok+_C6QUKf8v=Q+18@mail.gmail.com>
References: <1282950052.3284.110.camel@dhcp231-106.rdu.redhat.com>
	 <AANLkTi=aEdKM_hunJmPzXxPqkrbok+_C6QUKf8v=Q+18@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 30 Aug 2010 19:14:30 -0400
Message-ID: <1283210070.3284.139.camel@dhcp231-106.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2010-08-28 at 11:57 +0200, Kay Sievers wrote:
> On Sat, Aug 28, 2010 at 01:00, Eric Paris <eparis@redhat.com> wrote:

> > In the new new days of devtmpfs things aren't as nice.  The kernel is
> > magically creating files in /dev.  These are getting created with the
> > 'default' SELinux context.  So herein lies the problem.
> >
> > The first program that tries to access these files get denied by
> > SELinux.  Now udev actually has logic in it to fix the label on any
> > closed device file, so udev will at that point swoop in, fix the label,
> > and the next program that tries to use the file will work just fine.  Oh
> > fun!

> Udev should still label all device nodes, even when they are created
> by the kernel. Devtmpfs or not should not make a difference here.
> 
> I guess it's a udev bug introduced with:
>   http://git.kernel.org/?p=linux/hotplug/udev.git;a=commitdiff;h=578cc8a8085a47c963b5940459e475ac5f07219c
> 
> and we just need to fix that.

Looks like the likely cause.  I see a note in one of the bugzillas that
says:

Aug 30 14:03:09 pippin udevd-work[347]: preserve file '/dev/dri/card0',
because it has correct dev_t

Which is certainly the part of code in question.  Do you have a quick
fix in mind that you plan to push upstream or should I ask the RH udev
guy to come up with something?

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
