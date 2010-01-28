Date: Thu, 28 Jan 2010 16:55:26 +0300
From: AlannY <m@alanny.ru>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux@tycho.nsa.gov
Subject: Re: /dev on tmpfs. How to label?
Message-ID: <20100128135524.GA24392@alanny-pc.lcl.starlink.ru>
References: <20100128115643.GA19986@alanny-pc.lcl.starlink.ru>
 <1264685358.6232.38.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1264685358.6232.38.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jan 28, 2010 at 08:29:18AM -0500, Stephen Smalley wrote:
> Most distros do that these days, and it works fine in Fedora, for
> example.
> 
> The technique used in Fedora is to run restorecon -R /dev from
> rc.sysinit to set the contexts on the /dev nodes set up before the
> policy load, and udev is already SELinux-aware (if built with SELinux
> support enabled) and should label any dynamically created nodes
> appropriately once SELinux policy has loaded.

Ok. I've built udev --with-selinux and it seems now I have a good context (or maybe right?).

Well, my Controlling term: user_u:object_r:user_tty_device_t:s0. Is it normal?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
