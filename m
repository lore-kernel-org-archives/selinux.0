Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4IM3YRb005863
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 18:03:34 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4IM3VAR001097
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 22:03:31 GMT
Received: from smtp803.mail.ukl.yahoo.com (smtp803.mail.ukl.yahoo.com [217.12.12.140])
        by jazzband.ncsc.mil  with SMTP id i4IM3UHn001094 for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 22:03:31 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.130.181.235 with poptime)
  by smtp803.mail.ukl.yahoo.com with SMTP; 18 May 2004 21:04:43 -0000
Received: from highfield ([192.168.0.223]:32796 helo=lkcl.net)
	by lkcl.net with esmtp (Exim 4.24 #1)
	id 1BQBoG-00083N-Mb
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 21:07:36 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BQBiu-0002BV-B7
	for selinux@tycho.nsa.gov; Tue, 18 May 2004 21:02:04 +0000
Date: Tue, 18 May 2004 21:02:04 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: "'Selinux'" <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] some file_contexts for SuSE, binfmt_misc, small cleanup (was: Re: Suse)
Message-ID: <20040518210204.GG7348@lkcl.net>
References: <1084540729.17741.61.camel@moss-spartans.epoch.ncsc.mil> <20040514224053.9377E3A404F@abyss.simplyaquatics.com> <20040515232756.GB2095@jmh.mhn.de> <200405171027.47689.russell@coker.com.au> <20040517231318.GA2127@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040517231318.GA2127@jmh.mhn.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, May 18, 2004 at 01:13:18AM +0200, Thomas Bleher wrote:

> This is a very good point.
> I just went through my tree and collected the patches (not all
> SuSE-specific) which I think can be applied immediately.
> The patches are:
> * binfmt_misc.patch - add support for mounting the binfmt_misc fs
> * file_contexts.patch - add a bunch of file contexts
> * cleanup.patch - some very small cleanup and policy additions
> The patches should apply cleanly against current CVS.
 
 yes they do.  ta.

 more, more!

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
