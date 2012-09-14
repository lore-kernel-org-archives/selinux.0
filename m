Message-ID: <1347647563.11029.80.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: dev ion
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Fri, 14 Sep 2012 14:32:43 -0400
In-Reply-To: <CAFftDdpCZGKGMGK9-G69SL1apEBWgfE57FpcMf0AS7tsGJCOeg@mail.gmail.com>
References: 
	<CAFftDdpCZGKGMGK9-G69SL1apEBWgfE57FpcMf0AS7tsGJCOeg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-09-14 at 11:24 -0700, William Roberts wrote:
> Based on this article and "sharing
> buffers", http://lwn.net/Articles/480055/
> 
> 
> We may need to instrument LSM hooks for ION.
> 
> 
> Thoughts?

Possibly, but I don't see any DAC checks or capable calls in the current
ion driver code.  If the only way to share is by passing open fds, then
we already control that via the existing SELinux hooks.


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
