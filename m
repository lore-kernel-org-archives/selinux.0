Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id XAA20064
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 23:09:36 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id DAA24380
	for <selinux@tycho.nsa.gov>; Sat, 27 Jul 2002 03:08:04 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id DAA24376 for <selinux@tycho.nsa.gov>; Sat, 27 Jul 2002 03:08:02 GMT
Date: Sat, 27 Jul 2002 13:09:22 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: IDENTIFIER
Message-ID: <20020727030922.GB18313@snoopy.apana.org.au>
References: <20020726032129.GD27354@snoopy.apana.org.au> <20020726102225.C748D155E@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020726102225.C748D155E@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jul 26, 2002 at 12:22:25PM +0200, Russell Coker wrote:
> On Fri, 26 Jul 2002 05:21, Brian May wrote:
> > Is it possible to relax the definition of IDENTIFIER:
> >
> > {letter}({letter}|{digit}|_)*   { return(IDENTIFIER); }
> >
> > Any one symbol would be OK, but suggested ones include ~!@%&-=/
> 
> ~ is already taken to mean a logical not.

Good point.

Better make that list: !@%&-=/
-- 
Brian May <bam@snoopy.apana.org.au>

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
