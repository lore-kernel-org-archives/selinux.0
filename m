Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8EDTuMS002663
	for <selinux@tycho.nsa.gov>; Thu, 14 Sep 2006 09:29:56 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k8EDT4g7002595
	for <selinux@tycho.nsa.gov>; Thu, 14 Sep 2006 13:29:04 GMT
Subject: Re: Moving xconsole from xserver to logging policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Erich Schubert <erich@debian.org>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1158174972.1594.61.camel@wintermute.xmldesign.de>
References: <1158162208.1594.37.camel@wintermute.xmldesign.de>
	 <1158164561.26420.72.camel@sgc.columbia.tresys.com>
	 <1158166443.1594.51.camel@wintermute.xmldesign.de>
	 <1158167487.26420.75.camel@sgc.columbia.tresys.com>
	 <1158174972.1594.61.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Thu, 14 Sep 2006 09:32:51 -0400
Message-Id: <1158240772.26420.102.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-09-13 at 21:16 +0200, Erich Schubert wrote:
> Hi Christopher,
> > I've seen it used for redirecting the stdout/err of programs started by
> > the window manager.  I think you can do that instead of
> > ~/.xsession-errors.
> 
> Not in strict, I guess... and you don't need a pipe in /dev for that,
> nor do you need to run xconsole to access /dev/xconsole. Just run
> xconsole -file ~/.xconsole and you won't need any extra information for
> that...
> So that use is actually an abuse of /dev/xconsole IMHO.

Regardless if this is a good use or not, having a xconsole without an
xserver makes no sense.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
