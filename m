Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6TKT3rT022328
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 16:29:03 -0400 (EDT)
Received: from smtp800.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i6TKT2Cb020952
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 20:29:02 GMT
Date: Thu, 29 Jul 2004 21:40:08 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: udev has had udev_selinux removed - argh!
Message-ID: <20040729204008.GM9950@lkcl.net>
References: <20040729094717.GE6443@lkcl.net> <20040729185034.GA1530@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040729185034.GA1530@kroah.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hello greg,

well i tried compiling udev-024 and it was a pain, plus i got udev-030
to work and decided it wasn't worth the effort, the users can
JustLiveWithIt(tm) until it's fixed properly.

greg, do you have any objections to me doing a "proper" job, which
is to patch udev-add.c to use some libselinux1 functions that will
"prime" the selinux module with the right context, such that
when the node (and the symlink!) are individually created, they
are individually created with the correct context - there and then.

not post-creation, which is what udev_selinux and also the use of
restorecon do.

l.

On Thu, Jul 29, 2004 at 11:50:34AM -0700, Greg KH wrote:
> On Thu, Jul 29, 2004 at 10:47:17AM +0100, Luke Kenneth Casson Leighton wrote:
> > hi there,
> > 
> > gentoo have pulled udev from their distribution because the
> > udev_selinux program has been removed from udev and replaced
> > with a /etc/dev.d/default/selinux script.
> 
> No they have not.  As the Gentoo udev maintainer, I would have heard
> about this :)  I see it in the gentoo tree just fine.
> 
> Now as to issues if the "hardened Gentoo" people currently like to use
> udev or not, well that is a different issue...

 ah, likely.  

> > whilst this is reported as "WorkingForRedHat(tm)", i would
> > be very grateful if the functionality could be returned such
> > that it can be optionally compiled back in.
> 
> Great, send me patches to do this.  I'm not a selinux developer, so I
> rely on someone else to support this if they want to.  The previous
> patches for selinux in udev were not working, so they were removed.
> 
> > i have a question for you: is there the possibility of a race
> > condition in between udev creating nodes in /dev, and the
> > scripts in /etc/dev.d/default getting at them?
> 
> Only if your startup scripts are stupid.  :)
> 
> > for example, could /dev/usbtts0 be created if i plug in a USB modem,
> > and hotplug or a manual process fire up pppd BEFORE
> > /etc/dev.d/default/selinux gets to it?
> 
> That's a different question than the one above.
> Sure, that could happen, it just proves that udev needs to have selinux
> support added into it, to prevent this from happening.
> 
> > because if so, things are going to fail unexpectedly.
> 
> Yup.  Good luck :)
> 
> > how has this issue been addressed in udev, and also, whilst
> > i realise that Fedora accept the /etc/dev.d/default/selinux
> > change, it should concern you that gentoo do not [and therefore,
> > like a lemming oblique stroke sheep, i'd rather not, for my
> > debian distro].
> 
> Again, patches are welcome.
> 
> thanks,
> 
> greg k-h

-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility if acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
