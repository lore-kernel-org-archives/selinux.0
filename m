Subject: Re: Proposed policy feature: $1_domain attribute
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Thomas Bleher <bleher@informatik.uni-muenchen.de>, selinux@tycho.nsa.gov
In-Reply-To: <1109697292.10589.62.camel@moss-spartans.epoch.ncsc.mil>
References: <1109685518.764.9.camel@cobra.ivg2.net>
	 <20050301151205.GC5243@thorium.jmh.mhn.de>
	 <1109690087.10589.38.camel@moss-spartans.epoch.ncsc.mil>
	 <1109697404.3682.6.camel@cobra.ivg2.net>
	 <1109697292.10589.62.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 01 Mar 2005 12:29:47 -0500
Message-Id: <1109698187.3682.15.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-03-01 at 12:14 -0500, Stephen Smalley wrote:
>On Tue, 2005-03-01 at 12:16 -0500, Ivan Gyurdiev wrote:
>> > And allowing the caller to kill the program at any
>> >arbitrary point is potentially dangerous, e.g. leading to file
>> >corruption or holding of a lock indefinitely. 
>> 
>> As opposed to not being able to kill misbehaving programs?
>> Shouldn't that be the user's decision? I've been wondering
>> why under strict SElinux I always have so much trouble killing
>> my broken scripts...
>
>Depends on whether the program operates with more or less permissions
>than the user.  Again, think about the parallel for setuid programs.
>Some domain-changing programs should be killable by the user; others
>should not.

Well, in that case, how about an attribute to marks all of the programs
that have less permissions than the user. You said Tresys
has done inheritance work that can verify this stuff automatically.

How about a: $1_constrained attribute.

Then we can do:
can_ps($1, $1_constrained)
can_ptrace($1, $1_constrained)
allow $1 $1_constrained:process signal;
>
-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
