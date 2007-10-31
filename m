From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Decoder for log messages???
Date: Thu, 1 Nov 2007 08:44:59 +1000
Cc: Dean Anderson <dean@av8.com>, selinux@tycho.nsa.gov,
        Steve Grubb <sgrubb@redhat.com>, Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>
References: <Pine.LNX.4.44.0710262329300.30215-100000@citation2.av8.net> <1193840770.3983.86.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1193840770.3983.86.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200711010945.04287.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 01 November 2007 01:26, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Sat, 2007-10-27 at 00:17 -0400, Dean Anderson wrote:
> > I removed and reinstalled httpd, and got a bunch of these messages.
> > I'm guessing that dm-0 refers to a devicemapper device (which on my
> > system doesn't seem to actually be in use, so I'm left wondering what
> > the heck...perhaps a shared device number)
>
> device mapper is used by the logical volume manager.
> dmsetup ls?
> cat /sys/block/dm-0/dev?

It's also used by cryptsetup and probably other things.

While LVM has support for persistent (across reboot) ID numbers I don't think 
that anyone uses them by default.  I believe that cryptsetup has no support 
for persistent IDs, and if you use LVM or cryptsetup on removable media then 
the possibility of having two devices want the same ID would make it 
difficult or impossible to use them.

So if you have a 6 month old log entry that referrs to dm-0 then it may be 
impossible to determine what it was from.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
