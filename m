Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i71GcMrT007708
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 12:38:22 -0400 (EDT)
Received: from smtp801.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i71Gbn52024415
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 16:37:49 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp801.mail.ukl.yahoo.com with SMTP; 1 Aug 2004 16:38:21 -0000
Date: Sun, 1 Aug 2004 17:49:25 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: udev, tmp_t (on tmpfs on /dev), and matchpathcon failing
Message-ID: <20040801164925.GA20103@lkcl.net>
References: <20040801135209.GC15205@lkcl.net> <200408020044.08954.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200408020044.08954.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Aug 02, 2004 at 12:44:08AM +1000, Russell Coker wrote:
> On Sun, 1 Aug 2004 23:52, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > russell (someone?), the debian 1.14 (or greater) selinux-policy-default
> > package could uhm, do with um, updating to match what the rpm spec
> > does :)
> 
> No, it does not.
> 
> The needs of Debian are different from the needs of Red Hat.  I don't think 
> that Debian has any need for the targeted policy, but if someone does wish to 
> produce such a policy then they can make a selinux-policy-targeted package to 
> provide it which would conflict with selinux-policy-default.  I planned it 
> this way YEARS ago.
> 
> The design of Debian has some significant differences from the Red Hat design.  
> One such difference is that packages which provide conflicting ways of 
> performing the same task can not be installed at the same time in Debian.  In 
> Debian it is impossible to install Sendmail and Postfix at the same time.  If 
> there is a selinux-policy-targeted package for Debian then it will conflict 
> with selinux-policy-default for the same reason.
> 
> The upgrade path from the older version of the SE Linux packages 
> (before /etc/selinux/config) is extremely painful.  But once you get there it 
> will all work fine.
> 
> If you start rm'ing trees of files that my packages install and then replacing 
> them with trees taken from other places then you can expect difficulty.  In 
> fact you will probably end up repeating some of the work I did in 2001 when I 
> first started working on SE Linux.
> 
> Also when you have problems please report the first error that occurs.  Not 
> the error that occurs after you have tried ten different methods of working 
> around the first error.
 
 sorry, russell.

 i'm again moving rather quickly through one thing to the next, not
 really understanding why things are failing, and just trying something
 else until it works.

 my apologies for throwing up a large number of [post-analysis]
 irrelevant issues.

 i've pretty much abandoned all of my [heavily-modified] 1.12 stuff
 in favour of starting from scratch on the 1.14 stuff, and adding
 things as necessary (fireflier.te, usbmount.te, mods to fsadm.te
 to support usbmount.te using diskinfo and sg_map).

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
