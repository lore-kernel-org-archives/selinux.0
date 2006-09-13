Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8DH8cv2002723
	for <selinux@tycho.nsa.gov>; Wed, 13 Sep 2006 13:08:38 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k8DH7lNu007652
	for <selinux@tycho.nsa.gov>; Wed, 13 Sep 2006 17:07:47 GMT
Subject: Re: Moving xconsole from xserver to logging policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Erich Schubert <erich@debian.org>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1158166443.1594.51.camel@wintermute.xmldesign.de>
References: <1158162208.1594.37.camel@wintermute.xmldesign.de>
	 <1158164561.26420.72.camel@sgc.columbia.tresys.com>
	 <1158166443.1594.51.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Wed, 13 Sep 2006 13:11:27 -0400
Message-Id: <1158167487.26420.75.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-09-13 at 18:54 +0200, Erich Schubert wrote:
> Hello Christopher,
> > I don't agree with this; I believe it is a Debian thing that syslog
> > writes to this.  Even neglecting that, it still makes more sense to me
> > that it stays in xserver.
> 
> Please enlighten me then what /dev/xconsole is good for.
> The xconsole manpage just says "The xconsole program displays messages
> which are usually sent to /dev/console" and "monitor system console
> messages with X"
> 
> The only app I know that writes to /dev/xconsole is syslog. Do you know
> any others?

I've seen it used for redirecting the stdout/err of programs started by
the window manager.  I think you can do that instead of
~/.xsession-errors.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
