Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i910jrrT028279
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 20:45:53 -0400 (EDT)
Received: from monk.area614.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i910ilng020354
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 00:44:47 GMT
Subject: Re: Access to xdm_t
From: Colin Walters <walters@verbum.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <20040930192935.GA6063@lkcl.net>
References: <20040929163222.GA4125@rom.cip.ifi.lmu.de>
	 <1096561927.4957.15.camel@nexus.verbum.private>
	 <20040930192935.GA6063@lkcl.net>
Content-Type: text/plain
Date: Thu, 30 Sep 2004 20:47:28 -0400
Message-Id: <1096591648.5736.3.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-09-30 at 20:29 +0100, Luke Kenneth Casson Leighton wrote:
> On Thu, Sep 30, 2004 at 12:32:07PM -0400, Colin Walters wrote:
> > On Wed, 2004-09-29 at 18:32 +0200, Thomas Bleher wrote:
> > 
> > > If yes, should xdm_t get the attribute privfd?
> > 
> > Actually even moving the log to /tmp you'll still get programs wanting
> > access to the xdm_t fd.  Ideally we would have a little program run in
> > its own domain (xdm_launcher_t say) that would simply close all of its
> > file descriptors, open up the tmp file itself for logging and exec the
> > user session.  
> 
>  /usr/bin/startkde for example?

I think the idea with doing it inside ?dm was to keep common
functionality inside the display manager; also it ensures you get an
error log even if your session script fails early on (and gdm will offer
to display the error log for example if your session lasts less than 10
seconds, which it can really only do if it knows the name of the error
log).

So putting it inside each session script is generally wrong I think.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
