Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6RFlIUw024757
	for <selinux@tycho.nsa.gov>; Thu, 27 Jul 2006 11:47:18 -0400
Received: from web36606.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k6RFlGaW017123
	for <selinux@tycho.nsa.gov>; Thu, 27 Jul 2006 15:47:16 GMT
Message-ID: <20060727154701.12183.qmail@web36606.mail.mud.yahoo.com>
Date: Thu, 27 Jul 2006 08:47:01 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 0/6] netfilter integration
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1153923824.31522.19.camel@sgc.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- "Christopher J. PeBenito" <cpebenito@tresys.com>
wrote:


> > Now, as far as inter-module priorities go,
> > numbers just don't make sense.
> 
> So after further discussion internally, we were
> thinking that there
> likely not going to be intermodule dependencies.

I don't believe that for a minute.
 
> Oracle netfilter
> contexts aren't going to conflict with apache's. 
> Modules are going to
> want to override the contexts in the base module.

Oracle may not conflict with apache, but what
about MySQL or, heaven forbid, earlier versions
of Oracle? You can bet on independent developers
in the same problem space developing conflicting
protection schemes.
  
> So we were thinking that we should do something
> similar to how other
> parts of the policy are manged, with having base
> rules, module rules,
> local rules, pre, and post rules.  The pre and post
> rules would be
> special rules that have to come at the beginning or
> end of the
> netfilter_contexts file (see the 1's and 9's in my
> original 0/6 email).
> Then base would be low priority, module would be
> middle priority, and
> local would be high priority.  Modules that are
> packaged with an app
> should have the module priority.

There will be conflicts. You need a scheme
for dealing with two modules at the same
"priority" with different rules.

> The local priority
> would allow users
> to use the infrastructure to create packages for
> their own use, for
> example, for applying the rules to a network of
> machines (manually or
> policy server in the future), which would be more
> convenient then
> applying rules to iptables by hand on all the
> machines.



Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
