Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9TJbvXZ011184
	for <selinux@tycho.nsa.gov>; Fri, 29 Oct 2004 15:37:57 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9TJacMb022703
	for <selinux@tycho.nsa.gov>; Fri, 29 Oct 2004 19:36:38 GMT
Subject: Re: policy for fetchmail (new)
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Greg Norris <haphazard@kc.rr.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20040917004708.GA21413@yggdrasil.localdomain>
References: <20040917004708.GA21413@yggdrasil.localdomain>
Content-Type: text/plain
Message-Id: <1099078539.12321.102.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 29 Oct 2004 15:35:39 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Thu, 2004-09-16 at 20:47, Greg Norris wrote:
> I've written a policy for fetchmail (only required for daemon mode),
> which I think is more-or-less ready to be incorporated into CVS.  At
> the moment it only covers handing mail off to a local MTA (postfix in
> my case), and not directly to a MDA such as procmail.  I do intend to
> add procmail support in the future, but it may be some time... this
> policy should be able to handle the majority usage, however.
> 
> As always, comments are most welcome.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
