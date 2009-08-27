Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7REI2og030874
	for <selinux@tycho.nsa.gov>; Thu, 27 Aug 2009 10:18:02 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n7REJEsC011594
	for <selinux@tycho.nsa.gov>; Thu, 27 Aug 2009 14:19:14 GMT
Subject: Re: bugzilla 518569 discusses making vsftpd SELinux aware.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4A968455.3050209@redhat.com>
References: <4A968455.3050209@redhat.com>
Content-Type: text/plain
Date: Thu, 27 Aug 2009 10:16:31 -0400
Message-Id: <1251382591.8357.59.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-08-27 at 09:04 -0400, Daniel J Walsh wrote:
> https://bugzilla.redhat.com/show_bug.cgi?id=518569
> 
> The discussion surrounds potentially adding setcon function to vstfpd
> to drop level to a level appropriate the the user when he logs in.
> The discussion is around using MCS for this, but I guess I could see
> some utilization around MLS.
> 
> Not sure MLS would go for it though since there is a potential for
> information leak.

I'm not sure I like it this idea, but I wanted to throw it out anyway:
why not just change to the user's complete login context (or a context
that is a subset of it), rather than just the level?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
