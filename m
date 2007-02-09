Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l19GeArl028911
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2007 11:40:10 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l19GfJ8v009291
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2007 16:41:20 GMT
Subject: Re: Questions regarding loadable policy modules
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Dave Quigley <dquigley@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <f888952b0702071358p74576f3by6641c1a0df4893e6@mail.gmail.com>
References: <f888952b0702071358p74576f3by6641c1a0df4893e6@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 09 Feb 2007 11:41:24 -0500
Message-Id: <1171039284.21799.30.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-02-07 at 16:58 -0500, Dave Quigley wrote:
> I have a few questions about loadable policy modules in SELinux.  It
> has been mentioned before that certain policy language constructs
> can't be used within a loadable policy module. Is there a list
> somewhere for what these are?

Not that I know of.  I believe the list is:

object class definition (adding a class and perms)
genfscon
portcon
nodecon
netifcon
fs_use_*
constraints (regular and mls)
initial sids
mls component declarations
- sensitivities
- categories
- dominance
- levels

> Also, I am looking through the reference policy and I am trying to
> understand how the build process treats policy marked with module in
> modules.conf.

For a monolithic policy, base and module mean the same thing: the module
will be included in the monolithic policy.  For modular policy, base
means the module will be included in the base module, and module means
it will be built as an individual loadable policy module.

> I have read through the section on the reference policy in SELinux by
> Example and it mainly describes a Monolithic policy build. The main
> question I have about using a modular policy is what in the system is
> responsible for making sure the proper modules are loaded if you use
> this method?

The admin and/or package manager inserts policy modules into the module
store with the semodule program, which does several things:

* links and expands the modules in the module store.  
* If that succeeds, then a binary policy suitable for loading into the
kernel is written out to the standard location
* the policy is loaded with load_policy (unless you use -n).

> My final question is what exactly are the semantics and implementation
> details of the policy_module keyword and what ramifications are there
> for having your policy consist of many policy modules. I know each
> file in the reference policy has a policy_module macro at the
> beginning but I am talking about on a much finer granularity that
> currently exists. Does the policy_module keyword provide some sort of
> isolation for a module?

Its a macro that expands to nothing for monolithic policy and the
modular policy's base module.  For loadable modules, it provides the
module name and version (which are required for loadable modules), plus
adds a require{} block with kernel object classes and their permissions
(and sensitivities and categories for MLS/MCS) for convenience.  You can
see the implementation at the top of the
policy/support/loadable_module.spt.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
