Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4NI4XgA010024
	for <selinux@tycho.nsa.gov>; Mon, 23 May 2005 14:04:33 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4NHxdhG013725
	for <selinux@tycho.nsa.gov>; Mon, 23 May 2005 17:59:39 GMT
Date: Mon, 23 May 2005 18:14:22 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Valdis.Kletnieks@vt.edu
Cc: Kurt Wall <kwall@kurtwerks.com>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: depinit
Message-ID: <20050523171422.GQ8953@lkcl.net>
References: <20050522174200.GP10156@lkcl.net> <200505221403.26383.kwall@kurtwerks.com> <20050522202555.GR10156@lkcl.net> <200505231628.j4NGStKQ016569@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200505231628.j4NGStKQ016569@turing-police.cc.vt.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, May 23, 2005 at 12:28:54PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Sun, 22 May 2005 21:25:55 BST, Luke Kenneth Casson Leighton said:
> 
> >  i may have a requirement for utilising depinit instead of debian
> >  /etc/init.d and /sbin/init - because i believe it to be much more
> >  capable of doing fast boot-times.
> > 
> >  one of the other requirements is selinux.
> > 
> >  one plus one equals a whole boat-load more work.
> 
> The current Fedora patch to add SELinux support to SysVinit is all of 318
> lines.  150 lines of that is one large chunk of added subroutines you can
> use yourself, another 15 is adding all the "should we enable it" testing.
> 100 lines is adding SELinux support to 'killall' and 'sulogin'.
> 
> You're handed most of the code you need, and identifying the correct place
> to add the 15 lines of checking is pretty easy.  It's *not* a boat-load more
> work.

 sorry, valdis - i was thinking more along the lines of writing the
 policy.

 thank you for the pointers - they're really appreciated.

 depinit provides concepts like "start this service group named 'mail'"
 which will go away and bring up networking and anything else you need.

 there _is_ no "start" option or "stop" option to the service
 startup scripts.  if the script dies, the service is assumed to have
 died: the signal is caught by depinit (all signals are caught by
 depinit) and an "action" script e.g. /etc/depinit/sig_chld is called.
 
 if you _want_ the service to stop, you get depinit to automatically
 send increasingly aggressive levels of signals to the "service" script.

 there _is_ no stupid numbering schemes - not the stupid symlinks, and
 not the stupid runlevels.

 everything is _named_.  properly.

 the present policy - init.te, initrc.te - is therefore going
 to be mostly irrelevant.

 that's where quite a lot of the work would go.

 l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
