Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA24451
	for <selinux@tycho.nsa.gov>; Sun, 28 Jul 2002 04:12:08 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id IAA10680
	for <selinux@tycho.nsa.gov>; Sun, 28 Jul 2002 08:11:20 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id IAA10676
	for <selinux@tycho.nsa.gov>; Sun, 28 Jul 2002 08:11:18 GMT
Date: Sun, 28 Jul 2002 18:12:00 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: IDENTIFIER
Message-ID: <20020728081200.GA11093@snoopy.apana.org.au>
References: <20020726032129.GD27354@snoopy.apana.org.au> <20020726102225.C748D155E@lyta.coker.com.au> <20020727030922.GB18313@snoopy.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020727030922.GB18313@snoopy.apana.org.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Jul 27, 2002 at 01:09:22PM +1000, Brian May wrote:
> Better make that list: !@%&-=/

Second thoughts: None of those characters can appear in M4 macro names,
so maybe this isn't such a good idea...

In fact the current definition seems to be the same as the definition
for M4 names.

Even if I just used this other character in type names, there is the
risk that M4 will get confused and expand the wrong thing.

For now I will simply use the (perhaps more ugly looking) '__' instead.
-- 
Brian May <bam@snoopy.apana.org.au>

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
