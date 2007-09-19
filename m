Subject: Re: concept of a permissive domain
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Martin Orr <martin@martinorr.name>
Cc: Chad Sellers <csellers@tresys.com>, Eric Paris <eparis@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov
In-Reply-To: <46F14FBA.7060406@martinorr.name>
References: <C315C13B.2C502%csellers@tresys.com>
	 <46F14FBA.7060406@martinorr.name>
Content-Type: text/plain
Date: Wed, 19 Sep 2007 12:52:19 -0400
Message-Id: <1190220739.25863.72.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-09-19 at 17:35 +0100, Martin Orr wrote:
> On 18/09/07 22:54, Chad Sellers wrote:
> > One other note - how does a special debug domain that allows everything
> > except things that are dontaudit'd solve the use case that's been thrown
> > around. If I'm the IT guy, and I'm using this permissive domain to try out a
> > policy for 3 months in a permissive environment, I certainly don't want
> > certain items to be denied. Even worse, the current idea would have them
> > denied and not even audit'd. So, instead of causing a problem 3 months from
> > now when I switch to enforcing, it causes problems the day I install policy.
> > Millions are still lost, people still say SELinux sucks, and I (the policy
> > writer) still get fired (with 3 months less pay as well).
> 
> To pick out one particular point here, tracking down problems caused by
> denials which have dontaudit rules is difficult, because by definition they
> are not logged.  (I have what I guess is such a problem now: iff enforcing
> is on, the mails cron sends me are empty.)  Would it not be useful to have a
> way of disabling dontaudit rules, perhaps on a global or perhaps on a
> per-domain basis?  Just as dontaudit rules are orthogonal to allow rules,
> this setting would be orthogonal to permissive/enforcing.
> 
> Please forgive me if this is already possible and I have missed it.

Already possible on a global basis.

Original approach (pre-modular policy, e.g. RHEL 4, Fedora < 5):
	cd /etc/selinux/$SELINUXTYPE/src/policy
	make enableaudit load # rebuild and load policy without dontaudits
	<collect audit messages>
	make clean load # rebuild and load policy with dontaudits

Current modular policy approach (e.g. RHEL 5, Fedora > 5):
	semodule -b /usr/share/selinux/$SELINUXTYPE/enableaudit.pp # replace base module with one that has no dontaudits
	<collect audit messages>
	semodule -b /usr/share/selinux/$SELINUXTYPE/base.pp # restore original base module
	(limited to base module, doesn't help with non-base modules)

In current trunk (policycoreutils >= 2.0.23, libsemanage >= 2.0.4,
libsepol >= 2.0.6):
	semodule -DB # re-generate policy with dontaudit's stripped
	<collect audit messages>
	semodule -B # re-generate policy normally
	(deals with all policy modules)

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
