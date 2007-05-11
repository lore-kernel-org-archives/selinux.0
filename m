Subject: Re: Ver 4(Re: Ver3(Re: [patch] reducing size of libselinux(ver 2)
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Yuichi Nakamura <ynakam@hitachisoft.jp>, selinux@tycho.nsa.gov,
        busybox@kaigai.gr.jp, Joshua Brindle <method@manicmethod.com>
In-Reply-To: <1178891349.3504.185.camel@moss-spartans.epoch.ncsc.mil>
References: <20070507133423.3bd2463a.ynakam@hitachisoft.jp>
	 <1178738679.3504.25.camel@moss-spartans.epoch.ncsc.mil>
	 <20070510181218.0499cd05.ynakam@hitachisoft.jp>
	 <1178802414.3504.98.camel@moss-spartans.epoch.ncsc.mil>
	 <20070511140530.66290212.ynakam@hitachisoft.jp>
	 <1178891349.3504.185.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 11 May 2007 14:50:48 -0400
Message-Id: <1178909448.11064.29.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-05-11 at 09:49 -0400, Stephen Smalley wrote:

[...]

> 
> Suggestion:  Next time you post a version of the patch, make it a clean
> submission, i.e. drop the prior discussion, provide an updated summary
> of what the patch does, etc.  And you might consider splitting into two
> separate patches, as the part that switches libselinux to dlopen'ing of
> libsepol is independent of the DISABLE* options.
> 

In case any cares - I've been using mercurial patch queues [1] for a
while that facilitate all of this (and quilt provides similar
functionality). It evens stores the description and can email the
patches as a series with diffstat. Can't recommend it enough for making
this process simpler.

Karl

[1] http://www.selenic.com/mercurial/wiki/index.cgi/MqExtension


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
