Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4IEAcRb001685
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 10:10:39 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4IE8EB2016643
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 14:08:14 GMT
Received: from einsteinium.btinternet.com (einsteinium.btinternet.com [194.73.73.147])
	by jazzswing.ncsc.mil  with ESMTP id i4IE8Dwi016640
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 14:08:13 GMT
Date: Tue, 18 May 2004 14:07:55 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: [latest cvs]: build error on printer_device_t not recognised
Message-ID: <20040518140755.GD24917@lkcl.net>
References: <20040518094837.GA24333@lkcl.net> <200405182350.20921.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200405182350.20921.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, May 18, 2004 at 11:50:20PM +1000, Russell Coker wrote:
> On Tue, 18 May 2004 19:48, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > 	allow cupsd_t printer_device_t:chr_file { ioctl read getattr lock write
> > 	append };
> > 	/usr/bin/checkpolicy:  error(s) encountered while parsing configuration
> >
> > i find the printer_device_t definition to be in
> > domains/program/unused/lpd.te
> >
> > is this error something to do with me having cups installed but not
> > lpd?
> 
> Yes.  cups.te depends on lpd.te, see the Depends line in cups.te.
 
 ah.  but i have cupsys-bsd installed, not lpd.  cupsys-bsd provides
 lpd client-side compatibility:

  "This package provides the BSD commands for interacting with CUPS.  It
   is provides separately to allow CUPS to coexist with other printing
   systems (to a small degree)."

 i manually copied over
 /usr/share/selinux/default/domains/program/lpd.te
 to /etc/selinux/... and the problem went away.

 l.

> -- 
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page

-- 
-- 
expecting email to be received and understood is a bit like
picking up the telephone and immediately dialing without
checking for a dial-tone; speaking immediately without listening
for either an answer or ring-tone; hanging up immediately and
believing that you have actually started a conversation.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
