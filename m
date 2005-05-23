Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4NMX1gA012553
	for <selinux@tycho.nsa.gov>; Mon, 23 May 2005 18:33:01 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4NMS6hG004334
	for <selinux@tycho.nsa.gov>; Mon, 23 May 2005 22:28:07 GMT
Date: Mon, 23 May 2005 23:37:36 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Valdis.Kletnieks@vt.edu
Cc: Kurt Wall <kwall@kurtwerks.com>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: depinit
Message-ID: <20050523223736.GX8953@lkcl.net>
References: <20050522174200.GP10156@lkcl.net> <200505221403.26383.kwall@kurtwerks.com> <20050522202555.GR10156@lkcl.net> <200505231628.j4NGStKQ016569@turing-police.cc.vt.edu> <20050523171422.GQ8953@lkcl.net> <200505231758.j4NHwkxZ020399@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200505231758.j4NHwkxZ020399@turing-police.cc.vt.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, May 23, 2005 at 01:58:46PM -0400, Valdis.Kletnieks@vt.edu wrote:

> On Mon, 23 May 2005 18:14:22 BST, Luke Kenneth Casson Leighton said:
> 
> >  there _is_ no "start" option or "stop" option to the service
> >  startup scripts.  if the script dies, the service is assumed to have
> >  died: the signal is caught by depinit (all signals are caught by
> >  depinit) and an "action" script e.g. /etc/depinit/sig_chld is called.
> >  
> >  if you _want_ the service to stop, you get depinit to automatically
> >  send increasingly aggressive levels of signals to the "service" script.
> > 
> >  there _is_ no stupid numbering schemes - not the stupid symlinks, and
> >  not the stupid runlevels.
> 
> This is actually irrelevant (mostly) as far as SELinux is concerned..
> 
> >  everything is _named_.  properly.
> 
> Again, mostly irrelevant..

 *whew*.

> >  the present policy - init.te, initrc.te - is therefore going
> >  to be mostly irrelevant.
> 
> Actually *looking* at the .te's shows that *most* of it will, in fact,
> still be applicable for *any* init-replacment.  The *important* part is
> that the policy address things like "can the init-process access these
> resources?" 

 okay.   much appreciated.
 
 i have a bit more confidence to try it :)

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
