Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5A0J9gA015028
	for <selinux@tycho.nsa.gov>; Thu, 9 Jun 2005 20:19:10 -0400 (EDT)
Received: from free.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5A0BcpU006375
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 00:11:39 GMT
Date: Thu, 9 Jun 2005 22:31:31 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: 312714@bugs.debian.org
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Bug#312714 acknowledged by developer (Re: Bug#312714: initrd-tools: swsuspend requires an extra line in order to avoid filesystem corruption)
Message-ID: <20050609213131.GP8525@lkcl.net>
References: <20050609201822.GM3104@sputnik.stro.at> <E1DgAej-0002gA-Jf@lkcl.net> <handler.312714.D312714.111834832011322.notifdone@bugs.debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <handler.312714.D312714.111834832011322.notifdone@bugs.debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jun 09, 2005 at 01:33:09PM -0700, Debian Bug Tracking System wrote:
> This is an automatic notification regarding your Bug report
> #312714: initrd-tools: swsuspend requires an extra line in order to avoid filesystem corruption,
> which was filed against the initrd-tools package.
> 
> It has been closed by one of the developers, namely
> maximilian attems <debian@sternwelten.at>.
> 
> Their explanation is attached below.  If this explanation is
> unsatisfactory and you have not received a better one in a separate
> message then please contact the developer, by replying to this email.
> 
> Debian bug tracking system administrator
> (administrator, Debian Bugs database)
> 
> Received: (at 312714-done) by bugs.debian.org; 9 Jun 2005 20:18:40 +0000
> >From max@stro.at Thu Jun 09 13:18:39 2005
> Return-path: <max@stro.at>
> Received: from baikonur.stro.at [213.239.196.228] 
> 	by spohr.debian.org with esmtp (Exim 3.35 1 (Debian))
> 	id 1DgTU7-0002wQ-00; Thu, 09 Jun 2005 13:18:39 -0700
> Received: from sputnik (stallburg.stro.at [128.131.216.190])
> 	by baikonur.stro.at (Postfix) with ESMTP id AE1C45C00F
> 	for <312714-done@bugs.debian.org>; Thu,  9 Jun 2005 22:18:04 +0200 (CEST)
> Received: from max by sputnik with local (Exim 4.50)
> 	id 1DgTTq-0000Yt-GS
> 	for 312714-done@bugs.debian.org; Thu, 09 Jun 2005 22:18:22 +0200
> Date: Thu, 9 Jun 2005 22:18:22 +0200
> From: maximilian attems <debian@sternwelten.at>
> To: 312714-done@bugs.debian.org
> Subject: Re: Bug#312714: initrd-tools: swsuspend requires an extra line in order to avoid filesystem corruption
> Message-ID: <20050609201822.GM3104@sputnik.stro.at>
> References: <E1DgAej-0002gA-Jf@lkcl.net>
> Mime-Version: 1.0
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> In-Reply-To: <E1DgAej-0002gA-Jf@lkcl.net>
> User-Agent: Mutt/1.5.9i
> X-Virus-Scanned: by Amavis (ClamAV) at stro.at
> Delivered-To: 312714-done@bugs.debian.org
> X-Spam-Checker-Version: SpamAssassin 2.60-bugs.debian.org_2005_01_02 
> 	(1.212-2003-09-23-exp) on spohr.debian.org
> X-Spam-Status: No, hits=-6.0 required=4.0 tests=BAYES_00,HAS_BUG_NUMBER 
> 	autolearn=no version=2.60-bugs.debian.org_2005_01_02
> X-Spam-Level: 
> 
> On Thu, 09 Jun 2005, Luke Kenneth Casson Leighton wrote:
> 
> > according to
> > 
> > 	http://www.suspend2.net/HOWTO-2.html
> 
> that's a strange piece of junk.
> use it on your own risk.
>  
> > you need this:
> > 
> > 	echo > /proc/software_suspend/do_resume
> > 
> > BEFORE the script mounts your filesystem. If the line is missing, your
> > system will not resume. If the line comes after mounting file systems,
> > you will most likely suffer from filesystem corruption. You have been
> > warned.
> > 
> 
> well initrd-tools is another piece of junk and
> is on the way to be replaced.

 ah - is it to be replaced with something that happily supports udev
 inside it?

 and the enabling of selinux?

 if there's a wish-list, i would LOVE to see proper support / detection
 for selinux, and the use of uclib-compiled udev in an initrd, just like
 there is in FC2-FC4

 doing a udev-aware debian/selinux, whilst still keeping
 the "bog-standard-non-selinux-aware" initrd, is a complete
 half-way-house dog's dinner.

 it would actually be better, like gentoo, to _not_ have an initrd at
 all, when deploying udev+debian+selinux.


> debian-kernel currently don't support suspend so this anyway a noop.
 
 well it is and it isn't.

 i would expect to be able to download the debian kernel, with its
 .config file, patch it, update it, compile it... 

 yes?

 [i do this all the time.]

 so it's not exactly "a noop".

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
