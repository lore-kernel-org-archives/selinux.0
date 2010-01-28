Subject: Re: /dev on tmpfs. How to label?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: AlannY <m@alanny.ru>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20100128135524.GA24392@alanny-pc.lcl.starlink.ru>
References: <20100128115643.GA19986@alanny-pc.lcl.starlink.ru>
	 <1264685358.6232.38.camel@moss-pluto.epoch.ncsc.mil>
	 <20100128135524.GA24392@alanny-pc.lcl.starlink.ru>
Content-Type: text/plain
Date: Thu, 28 Jan 2010 09:20:09 -0500
Message-Id: <1264688409.6232.49.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-01-28 at 16:55 +0300, AlannY wrote:
> On Thu, Jan 28, 2010 at 08:29:18AM -0500, Stephen Smalley wrote:
> > Most distros do that these days, and it works fine in Fedora, for
> > example.
> > 
> > The technique used in Fedora is to run restorecon -R /dev from
> > rc.sysinit to set the contexts on the /dev nodes set up before the
> > policy load, and udev is already SELinux-aware (if built with SELinux
> > support enabled) and should label any dynamically created nodes
> > appropriately once SELinux policy has loaded.
> 
> Ok. I've built udev --with-selinux and it seems now I have a good context (or maybe right?).
> 
> Well, my Controlling term: user_u:object_r:user_tty_device_t:s0. Is it normal?

Yes.  user_tty_device_t for a tty, user_devpts_t for a pty.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
