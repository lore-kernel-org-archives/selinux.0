Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m33Mqd69030760
	for <selinux@tycho.nsa.gov>; Thu, 3 Apr 2008 18:52:39 -0400
Received: from dmzmta101.na.baesystems.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m33Mqbl8005826
	for <selinux@tycho.nsa.gov>; Thu, 3 Apr 2008 22:52:37 GMT
Received: from BLUMS0033.bluelnk.net (blums0033.bluelnk.net [10.40.96.54])
	by dmzmta101.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m33MoNuY025442
	for <selinux@tycho.nsa.gov>; Thu, 3 Apr 2008 18:50:25 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Removing 2 modules that depend on eachother
Date: Thu, 3 Apr 2008 15:51:12 -0700
Message-ID: <4AE25A7D8CBE4E4DA8E87173237DE27E7E4E@blums0042.bluelnk.net>
From: "Karrels, Jeffrey J \(US SSA\)" <jeffrey.karrels@baesystems.com>
To: "Joshua Brindle" <method@manicmethod.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

That did it. Thanks!

> -----Original Message-----
> From: Joshua Brindle [mailto:method@manicmethod.com]
> Sent: Thursday, April 03, 2008 2:35 PM
> To: Karrels, Jeffrey J (US SSA)
> Cc: selinux@tycho.nsa.gov
> Subject: Re: Removing 2 modules that depend on eachother
> 
> Karrels, Jeffrey J (US SSA) wrote:
> >
> > Hello all.
> >
> > I have a question. I have two modules that I created that I wanted
to
> > remove (both). Each module depends on the other. What is the best
way
> > to go about this? (for now, I have removed one of my dependencies
and
> > then was able to remove the modules one at a time). Is there a
better
> > way to go about this though? I tried calling semodule -r in various
> > forms to try and remove two packages at the same time, but did not
> > have any luck. Any suggestions?
> >
> > Thanks
> >
> > Jeff
> >
> 
> you can do multiple -r's on one line:
> 
> semodule -r module1 -r module2 -r module3
> 
> and so on.
> 




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
