Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4IFXFRb002533
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 11:33:15 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4IFXDAR028777
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 15:33:13 GMT
Received: from carbon.btinternet.com (carbon.btinternet.com [194.73.73.92])
        by jazzband.ncsc.mil  with ESMTP id i4IFXCHn028774 for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 15:33:12 GMT
Date: Tue, 18 May 2004 15:30:26 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: list of permissions created by allow2audit: what do i do now?
Message-ID: <20040518153026.GI24917@lkcl.net>
References: <20040518104026.GC24333@lkcl.net> <20040518125633.GA24917@lkcl.net> <200405190029.31893.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200405190029.31893.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, May 19, 2004 at 12:29:31AM +1000, Russell Coker wrote:
> On Tue, 18 May 2004 22:56, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > domains/programs/localstuff.te
> 
> Use domains/misc/localstuff.te .  Anything in domains/programs needs a 
> matching .fc file.
 
 ah ha!  okay.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
