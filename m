Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA03149
	for <selinux@tycho.nsa.gov>; Thu, 12 Sep 2002 18:09:35 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA17586
	for <selinux@tycho.nsa.gov>; Thu, 12 Sep 2002 22:07:50 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id WAA17578 for <selinux@tycho.nsa.gov>; Thu, 12 Sep 2002 22:07:48 GMT
Date: Fri, 13 Sep 2002 08:09:26 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: Problems compiling selinux on SuSe 7.2
Message-ID: <20020912220926.GD3486@snoopy.apana.org.au>
References: <1031756508.3d7f5adca337f@qmc.ufsc.br> <200209111753.37846.russell@coker.com.au> <20020911230717.GA17728@snoopy.apana.org.au> <200209120843.20157.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200209120843.20157.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 12, 2002 at 08:43:20AM +0200, Russell Coker wrote:
> Yes, I got the impression that the person asking the questions may have had 
> this problem (or alternately they may have patched a copy of the SSH source 
> that was prepared by someone who uses kerberos).

I wasn't sure. I thought it safest to ask. You are probably correct
though.

> > Its on my TODO list. Along with other items like "update Debian Heimdal
> > to latest upstream version" and "help get the latest krb4 into testing,
> > as it is holding up lots of other packages (including Heimdal)".
> 
> Sounds like you're really busy.

Its not that I am busy, its just that my TODO list is always long ;-).

Its simply a matter of prioritising the important stuff first, and
leaving the boring, unwanted tasks (eg. finding out why / on two of my
Unix systems is almost full, even though I have 2 and 2.5 gig allocated,
respectively and /var on a seperate partition) end up falling to the
bottom ;-).

> Are you sure you want to take over the woody port of SE Linux?

I have already done most of the packages, there are only two
more left...
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
