Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i93KR0rT013818
	for <selinux@tycho.nsa.gov>; Sun, 3 Oct 2004 16:27:02 -0400 (EDT)
Received: from mail.gmx.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i93KQxqH023879
	for <selinux@tycho.nsa.gov>; Sun, 3 Oct 2004 20:26:59 GMT
Subject: Re: purpose of the staff_r role?
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Tom Anderson <granite217@yahoo.com>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040930013829.10463.qmail@web14925.mail.yahoo.com>
References: <20040930013829.10463.qmail@web14925.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1096835213.2534.151.camel@debby>
Mime-Version: 1.0
Date: Sun, 03 Oct 2004 22:26:53 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-09-30 at 03:38, Tom Anderson wrote: 
> Can anyone explain the purpose/benefit of having an account under the
> staff_r role?  I thought it was to allow limited administrative
> functions, but I've discovered that it doesn't even allow reading the
> logfiles under /var/log/.  What purpose does it serve, other than to
> limit who can transition to sysadm_r?
> 
> SE Linux appears to be quite powerful, but dear $deity it's confusing. 
> I'd sell my soul for a nice, readable O'Reilly Press title covering
> this stuff!

Some weeks ago when googling about for some docs (that is: Beginner
docs) I stumbled over this site:

http://www.lurking-grue.org/

For me, a beginner with selinux, the most usable I found so far.

[ Thanks, Faye Coker ]

HTH

Wolfgang
-- 
Wolfgang Pfeiffer                           gpg ID: 0AA7E825 
Profile, links: http://profiles.yahoo.com/wolfgangpfeiffer


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
