Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6QENbon001401
	for <selinux@tycho.nsa.gov>; Wed, 26 Jul 2006 10:23:37 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k6QENZmc020227
	for <selinux@tycho.nsa.gov>; Wed, 26 Jul 2006 14:23:35 GMT
Subject: Re: [PATCH 0/6] netfilter integration
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: casey@schaufler-ca.com
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <20060725190203.72780.qmail@web36604.mail.mud.yahoo.com>
References: <20060725190203.72780.qmail@web36604.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Wed, 26 Jul 2006 10:23:43 -0400
Message-Id: <1153923824.31522.19.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-07-25 at 12:02 -0700, Casey Schaufler wrote:
> 
> --- "Christopher J. PeBenito" <cpebenito@tresys.com>
> wrote:
> 
> 
> > I don't feel this is sufficient since you may want
> > your module's rule to
> > override a rules in the other modules, so you want a
> > higher priority
> > than what those have.  If, for example, you throw
> > specific port ranges
> > into a big bucket, then there's no way to do this. 
> > In addition, you can
> > create netfilter rules far more complicated than
> > just a specific port or
> > ranges.
> 
> That's the argument for generality and I
> suggest that 9 ain't general. How many rules
> are there in the policy now?

432

> You can go
> with a small fixed number of priorities to
> address the problem you have today, in
> which case names make more sense, or you
> can provide a general scheme in which case
> 9 is way too small.
> 
> Now, as far as inter-module priorities go,
> numbers just don't make sense.

So after further discussion internally, we were thinking that there
likely not going to be intermodule dependencies.  Oracle netfilter
contexts aren't going to conflict with apache's.  Modules are going to
want to override the contexts in the base module.  

So we were thinking that we should do something similar to how other
parts of the policy are manged, with having base rules, module rules,
local rules, pre, and post rules.  The pre and post rules would be
special rules that have to come at the beginning or end of the
netfilter_contexts file (see the 1's and 9's in my original 0/6 email).
Then base would be low priority, module would be middle priority, and
local would be high priority.  Modules that are packaged with an app
should have the module priority.  The local priority would allow users
to use the infrastructure to create packages for their own use, for
example, for applying the rules to a network of machines (manually or
policy server in the future), which would be more convenient then
applying rules to iptables by hand on all the machines.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
