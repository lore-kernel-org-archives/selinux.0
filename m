Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6PJ2K2d029486
	for <selinux@tycho.nsa.gov>; Tue, 25 Jul 2006 15:02:20 -0400
Received: from web36604.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k6PJ2IJ2010626
	for <selinux@tycho.nsa.gov>; Tue, 25 Jul 2006 19:02:19 GMT
Message-ID: <20060725190203.72780.qmail@web36604.mail.mud.yahoo.com>
Date: Tue, 25 Jul 2006 12:02:03 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 0/6] netfilter integration
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Joshua Brindle <jbrindle@tresys.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1153841813.8634.9.camel@sgc.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- "Christopher J. PeBenito" <cpebenito@tresys.com>
wrote:


> I don't feel this is sufficient since you may want
> your module's rule to
> override a rules in the other modules, so you want a
> higher priority
> than what those have.  If, for example, you throw
> specific port ranges
> into a big bucket, then there's no way to do this. 
> In addition, you can
> create netfilter rules far more complicated than
> just a specific port or
> ranges.

That's the argument for generality and I
suggest that 9 ain't general. How many rules
are there in the policy now? You can go
with a small fixed number of priorities to
address the problem you have today, in
which case names make more sense, or you
can provide a general scheme in which case
9 is way too small.

Now, as far as inter-module priorities go,
numbers just don't make sense. What you
want is symbolic names and a way to say that
"HIGH" in module foo has a higher priority
than "HIGH" in module bar. You will never
get a rational numeric priority ranking
with multiple free thinking developers of
otherwise independent policy modules,
regardless of the granularity.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
