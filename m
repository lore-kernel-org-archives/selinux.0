Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i72J5brT015354
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 15:05:37 -0400 (EDT)
Date: Mon, 2 Aug 2004 20:12:43 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: matchfilecon (the program) vs matchfilecon (the libselinux1 fn)
Message-ID: <20040802191243.GJ4194@lkcl.net>
References: <20040801172751.GD20103@lkcl.net> <1091455223.23449.66.camel@moss-spartans.epoch.ncsc.mil> <20040802145724.GG4194@lkcl.net> <1091458325.23449.102.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1091458325.23449.102.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Aug 02, 2004 at 10:52:05AM -0400, Stephen Smalley wrote:
> On Mon, 2004-08-02 at 10:57, Luke Kenneth Casson Leighton wrote:
> >  ... one thing though: running udev, it can only generate about 4
> >  device inodes per second when having to do
> >  /etc/dev.d/defaults/selinux.dev (which calls restorecon $DEVICENAME).
> > 
> >  that's _awfully_ slow.
> > 
> >  especially when creating 64 /dev/ttyxx nodes, 64 /dev/ttySxx nodes,
> >  and then a few /dev/ramX nodes too.
> > 
> >  it delays boot-time by over 30 seconds, basically.
> > 
> >  what, if anything, could be done about this?
> > 
> >  run a restorecon asynchronous service?
> > 
> >  yes, i realise that sounds a bit mad, but if people are going to throw
> >  150 device inodes up at boot-time, it's got to be quick.
> 
> What's the objection to patching udev to directly invoke matchpathcon(3)
> and setfscreatecon(3) prior to creating each device node?
 
 time!  how long do those function calls take?

 using /sbin/restorecon, which is the present hack, each device node
 creation takes around a quarter of a second (!!)

 l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
