Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l32Jinka023512
	for <selinux@tycho.nsa.gov>; Mon, 2 Apr 2007 15:44:49 -0400
Received: from mail2.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l32Jimss000511
	for <selinux@tycho.nsa.gov>; Mon, 2 Apr 2007 19:44:48 GMT
Date: Mon, 2 Apr 2007 15:44:45 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
cc: Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        Joshua Brindle <method@manicmethod.com>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: secmark integration
In-Reply-To: <1175534587.5433.11.camel@localhost.localdomain>
Message-ID: <Line.LNX.4.64.0704021544010.9184@d.namei>
References: <Line.LNX.4.64.0703191021480.22828@d.namei>
 <1175284031.3602.24.camel@localhost.localdomain>
 <1175286309.20396.13.camel@localhost.localdomain>
 <1175286967.3602.31.camel@localhost.localdomain>
 <1175291240.20396.36.camel@localhost.localdomain> <1175534587.5433.11.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2 Apr 2007, Karl MacMillan wrote:

> That sounds fine to me, but James mentioned that the upstream acceptance
> might be hard. So how do we experiment in the short term? Just don't
> worry about rules getting flushed?

I can supply a patch which creates a new table, for experimental purposes.  
Perhaps someone (Eric?) could make a Fedora kernel rpm with the patch for 
testing only.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
