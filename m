Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7IJO1rT022574
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2004 15:24:01 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7IJNxRq004987
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2004 19:24:00 GMT
Date: Wed, 18 Aug 2004 16:24:06 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: removed lpd.te, kept cups.te
Message-ID: <20040818152406.GE19646@lkcl.net>
References: <20040817113807.GO18321@lkcl.net> <200408182057.50798.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200408182057.50798.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Aug 18, 2004 at 08:57:50PM +1000, Russell Coker wrote:
> On Tue, 17 Aug 2004 21:38, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > i removed lpd.te, i kept cups.te (which reflects what i have
> > set up: lpd is not enabled, lpd emulation in cups is not enabled).
> >
> > ... but instead i get error at line 29: unknown type printer_device_t.
> >
> > am i missing something?
> 
> Line 5 of cups.te.
 
 ooo.  ah, yes: the one that says "Depends: lpd.te" :)

 okay.  so lpd.te allows binding to the lpr port.

 and the only cupsys package that does binding to the lpr port is
 cupsys-bsd (which provides a lpr compatibility layer).

 so if i haven't installed cupsys-bsd, i have an extra unprotected
 port which a compromised cupsys daemon could bind to.

 hmm :)

 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
