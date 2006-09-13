Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8DGJqWG000969
	for <selinux@tycho.nsa.gov>; Wed, 13 Sep 2006 12:19:52 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k8DGJQPt011747
	for <selinux@tycho.nsa.gov>; Wed, 13 Sep 2006 16:19:27 GMT
Subject: Re: Moving xconsole from xserver to logging policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Erich Schubert <erich@debian.org>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1158162208.1594.37.camel@wintermute.xmldesign.de>
References: <1158162208.1594.37.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Wed, 13 Sep 2006 12:22:41 -0400
Message-Id: <1158164561.26420.72.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-09-13 at 17:43 +0200, Erich Schubert wrote:
> Basically, /dev/xconsole is a FIFO written to by syslog, and often is
> present even when there is no X. Therefore, this should go into the
> logging policy.
> Patch attached.

I don't agree with this; I believe it is a Debian thing that syslog
writes to this.  Even neglecting that, it still makes more sense to me
that it stays in xserver.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
