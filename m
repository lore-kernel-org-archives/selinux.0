Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l28MVeXE026390
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 17:31:40 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l28MVdfo001968
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 22:31:39 GMT
Subject: Re: I would like to propose dropping the disable_trans boolean.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45F08AD3.6090800@redhat.com>
References: <45F08AD3.6090800@redhat.com>
Content-Type: text/plain
Date: Thu, 08 Mar 2007 22:32:03 +0000
Message-Id: <1173393124.23674.8.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-08 at 17:14 -0500, Daniel J Walsh wrote:
> Several reasons for this.
> 
> 1.  We have gotten the policy to such a state where most stuff just works.
> 2.  Problems are easily worked around using audit2allow and loadable 
> policy modules
> grep badtype /var/log/audit/audit.log | audit2allow -m myfix
> 3.  Disabling trans often causes more problems then it is worth, because 
> of screwed up file context.
> 4.  You can get the same behavior by changing the file context of a file 
> to bin_t.
> 
> Thoughts?

I agree with this.  When we get tunables support, a better way can be
added (make the domain unconfined), and then the #3 problem will go
away.  We can't do the unconfining trick with booleans, since the
unconfining requires attributes, which won't work in conditionals.  I
know some people who will be happy to see the removal of m4 hacks I had
to add to make disable trans to work.  Does anyone have reasons too keep
these booleans?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
