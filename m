Subject: Re: selinux vs devtmpfs (vs udev)
From: Eric Paris <eparis@redhat.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Harald Hoyer <harald@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov, greg@kroah.com,
        sds@tycho.nsa.gov
In-Reply-To: <AANLkTikhc1Nu5PsQqzKL0PXY3juOxwuPOsu0ZKvzfCJ3@mail.gmail.com>
References: <1282950052.3284.110.camel@dhcp231-106.rdu.redhat.com>
	 <AANLkTi=aEdKM_hunJmPzXxPqkrbok+_C6QUKf8v=Q+18@mail.gmail.com>
	 <1283210070.3284.139.camel@dhcp231-106.rdu.redhat.com>
	 <4C7CC107.1050304@redhat.com> <4C7D0DAD.9030505@redhat.com>
	 <4C7D141A.9060102@redhat.com> <4C7D1868.3090701@redhat.com>
	 <1283267765.3284.150.camel@dhcp231-106.rdu.redhat.com>
	 <4C7D1E1B.4020700@redhat.com>
	 <1283268367.3284.154.camel@dhcp231-106.rdu.redhat.com>
	 <4C7D248A.2080507@redhat.com>
	 <AANLkTikhc1Nu5PsQqzKL0PXY3juOxwuPOsu0ZKvzfCJ3@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 31 Aug 2010 16:51:38 -0400
Message-ID: <1283287898.3284.183.camel@dhcp231-106.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-08-31 at 21:32 +0200, Kay Sievers wrote:
> On Tue, Aug 31, 2010 at 17:49, Harald Hoyer <harald@redhat.com> wrote:
> > https://bugzilla.redhat.com/show_bug.cgi?id=575128#c14
> > https://bugzilla.redhat.com/attachment.cgi?id=442223&format=raw
> >
> > udev/udev-node.c
> >
> > +                       /* set selinux file context on add events */
> > +                       if (strcmp(udev_device_get_action(dev), "add") == 0)
> > +                               udev_selinux_lsetfilecon(udev, file, mode);
> 
> I can't access these bugs.
> 
> Does that makes sense/work for you?
>   http://git.kernel.org/?p=linux/hotplug/udev.git;a=commitdiff;h=326c5fc3ea684825629eccaf33a548759162a539
> 
> Kay

I ask Harald (but he wasn't around and I don't know the answer) if it is
a problem that this changes the behavior of non "add" events.
Previously a non "add" event with an incorrect mask/uid/gid would have
reset the SELinux context but now it will not.  It fixes the issue at
hand, my boxes boot with everything labeled nicely, but I'm not sure if
there is some other corner case that expected the old behavior with
change events....

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
