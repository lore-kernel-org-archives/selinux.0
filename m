Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6FGe6Ha018280
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 12:40:06 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6FGd4nJ000766
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 16:39:04 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
	by jazzswing.ncsc.mil  with ESMTP id h6FGd4hr000763
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 16:39:04 GMT
Subject: Re: crash with 2.5.74 while loading policy
From: Colin Walters <walters@verbum.org>
To: James Morris <jmorris@intercode.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <Mutt.LNX.4.44.0307152306260.23933-100000@excalibur.intercode.com.au>
References: 
	 <Mutt.LNX.4.44.0307152306260.23933-100000@excalibur.intercode.com.au>
Content-Type: text/plain
Message-Id: <1058287194.15102.4.camel@columbia>
Mime-Version: 1.0
Date: 15 Jul 2003 12:39:54 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-07-15 at 09:07, James Morris wrote:

> I've not seen anything like this with 2.5.  And according to your report, 
> it seems that dpkg was running when the oops occurred.

That's true, but I think dpkg is not at fault; besides, any kind of
crash is a kernel bug.  The only thing I can think of that's even
slightly unusual about this machine is that it's SMP (dual PII-350).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
