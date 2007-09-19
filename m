Message-ID: <46F14FBA.7060406@martinorr.name>
Date: Wed, 19 Sep 2007 17:35:06 +0100
From: Martin Orr <martin@martinorr.name>
MIME-Version: 1.0
To: Chad Sellers <csellers@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov
Subject: Re: concept of a permissive domain
References: <C315C13B.2C502%csellers@tresys.com>
In-Reply-To: <C315C13B.2C502%csellers@tresys.com>
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 18/09/07 22:54, Chad Sellers wrote:
> One other note - how does a special debug domain that allows everything
> except things that are dontaudit'd solve the use case that's been thrown
> around. If I'm the IT guy, and I'm using this permissive domain to try out a
> policy for 3 months in a permissive environment, I certainly don't want
> certain items to be denied. Even worse, the current idea would have them
> denied and not even audit'd. So, instead of causing a problem 3 months from
> now when I switch to enforcing, it causes problems the day I install policy.
> Millions are still lost, people still say SELinux sucks, and I (the policy
> writer) still get fired (with 3 months less pay as well).

To pick out one particular point here, tracking down problems caused by
denials which have dontaudit rules is difficult, because by definition they
are not logged.  (I have what I guess is such a problem now: iff enforcing
is on, the mails cron sends me are empty.)  Would it not be useful to have a
way of disabling dontaudit rules, perhaps on a global or perhaps on a
per-domain basis?  Just as dontaudit rules are orthogonal to allow rules,
this setting would be orthogonal to permissive/enforcing.

Please forgive me if this is already possible and I have missed it.

-- 
Martin Orr

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
