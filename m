Subject: Re: Proposed policy feature: $1_domain attribute
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Thomas Bleher <bleher@informatik.uni-muenchen.de>, selinux@tycho.nsa.gov
In-Reply-To: <1109700467.3682.24.camel@cobra.ivg2.net>
References: <1109685518.764.9.camel@cobra.ivg2.net>
	 <20050301151205.GC5243@thorium.jmh.mhn.de>
	 <1109690087.10589.38.camel@moss-spartans.epoch.ncsc.mil>
	 <1109697404.3682.6.camel@cobra.ivg2.net>
	 <1109697292.10589.62.camel@moss-spartans.epoch.ncsc.mil>
	 <1109698187.3682.15.camel@cobra.ivg2.net>
	 <1109698283.10589.71.camel@moss-spartans.epoch.ncsc.mil>
	 <1109700467.3682.24.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Tue, 01 Mar 2005 17:07:01 -0500
Message-Id: <1109714821.8401.11.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-03-01 at 13:07 -0500, Ivan Gyurdiev wrote:
>On Tue, 2005-03-01 at 12:31 -0500, Stephen Smalley wrote:
>>On Tue, 2005-03-01 at 12:29 -0500, Ivan Gyurdiev wrote:
>>> Well, in that case, how about an attribute to marks all of the programs
>>> that have less permissions than the user. You said Tresys
>>> has done inheritance work that can verify this stuff automatically.
>>
>>Not sure that their notion of inheritance will apply here, as it is:
>>1) name-based, i.e. type A.B.C is bounded by the permissions allowed to
>>type A.B and type A.B is bounded by the permissions allowed to type A,
>>2) strict, i.e. type A.B.C cannot any permissions to type D unless type
>>A has those permissions, whereas program domains have often some
>>additional permissions even if we consider them to be less privileged
>>for their own private objects,
>>3) likely to cut across domains differently than you envision, as it is
>>intended to allow delegation of management of portions of the policy,
>>e.g. the entire apache policy, without being able to alter properties of
>>the base policy (as bounded by the overall "apache" type).

It would be an interesting exercise to try to represent SElinux as
a graph, and use standard graph algorithms to determine domain
interactions... but in the meantime I'll just do this the normal way -
looking at the policy rules by hand :)

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
