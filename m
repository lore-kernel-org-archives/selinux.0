Subject: Re: Proposed policy feature: $1_domain attribute
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Thomas Bleher <bleher@informatik.uni-muenchen.de>, selinux@tycho.nsa.gov
In-Reply-To: <1109698187.3682.15.camel@cobra.ivg2.net>
References: <1109685518.764.9.camel@cobra.ivg2.net>
	 <20050301151205.GC5243@thorium.jmh.mhn.de>
	 <1109690087.10589.38.camel@moss-spartans.epoch.ncsc.mil>
	 <1109697404.3682.6.camel@cobra.ivg2.net>
	 <1109697292.10589.62.camel@moss-spartans.epoch.ncsc.mil>
	 <1109698187.3682.15.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Tue, 01 Mar 2005 12:31:23 -0500
Message-Id: <1109698283.10589.71.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-03-01 at 12:29 -0500, Ivan Gyurdiev wrote:
> Well, in that case, how about an attribute to marks all of the programs
> that have less permissions than the user. You said Tresys
> has done inheritance work that can verify this stuff automatically.

Not sure that their notion of inheritance will apply here, as it is:
1) name-based, i.e. type A.B.C is bounded by the permissions allowed to
type A.B and type A.B is bounded by the permissions allowed to type A,
2) strict, i.e. type A.B.C cannot any permissions to type D unless type
A has those permissions, whereas program domains have often some
additional permissions even if we consider them to be less privileged
for their own private objects,
3) likely to cut across domains differently than you envision, as it is
intended to allow delegation of management of portions of the policy,
e.g. the entire apache policy, without being able to alter properties of
the base policy (as bounded by the overall "apache" type).

> How about a: $1_constrained attribute.
> 
> Then we can do:
> can_ps($1, $1_constrained)
> can_ptrace($1, $1_constrained)
> allow $1 $1_constrained:process signal;

I think I'd prefer a macro that can be selectively included by program
domains that have been identified as being suitable for complete control
by the user (but if you are allowing ptrace, then you might as well
allow all signals, including sigkill and sigstop).

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
