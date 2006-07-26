Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6QKhkVT021556
	for <selinux@tycho.nsa.gov>; Wed, 26 Jul 2006 16:43:46 -0400
Received: from localhost.localdomain (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6QKhjwu007015
	for <selinux@tycho.nsa.gov>; Wed, 26 Jul 2006 20:43:45 GMT
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: [PATCH 0/6] netfilter integration
Date: Wed, 26 Jul 2006 16:43:39 -0400
Cc: casey@schaufler-ca.com, Joshua Brindle <jbrindle@tresys.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
References: <20060725190203.72780.qmail@web36604.mail.mud.yahoo.com> <1153923824.31522.19.camel@sgc.columbia.tresys.com>
In-Reply-To: <1153923824.31522.19.camel@sgc.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200607261643.39291.kmacmillan@mentalrootkit.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 26 July 2006 10:23, Christopher J. PeBenito wrote:

<snip>

> So after further discussion internally, we were thinking that there
> likely not going to be intermodule dependencies.  Oracle netfilter
> contexts aren't going to conflict with apache's.  Modules are going to
> want to override the contexts in the base module.
>
> So we were thinking that we should do something similar to how other
> parts of the policy are manged, with having base rules, module rules,
> local rules, pre, and post rules.  The pre and post rules would be
> special rules that have to come at the beginning or end of the
> netfilter_contexts file (see the 1's and 9's in my original 0/6 email).
> Then base would be low priority, module would be middle priority, and
> local would be high priority.  Modules that are packaged with an app
> should have the module priority.  The local priority would allow users
> to use the infrastructure to create packages for their own use, for
> example, for applying the rules to a network of machines (manually or
> policy server in the future), which would be more convenient then
> applying rules to iptables by hand on all the machines.

This sounds much better to me.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
