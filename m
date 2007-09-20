Message-ID: <46F28692.70307@tresys.com>
Date: Thu, 20 Sep 2007 10:41:22 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: Martin Orr <martin@martinorr.name>, Chad Sellers <csellers@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov
Subject: Re: concept of a permissive domain
References: <C315C13B.2C502%csellers@tresys.com>	 <46F14FBA.7060406@martinorr.name> <1190220085.3451.65.camel@localhost.localdomain>
In-Reply-To: <1190220085.3451.65.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eric Paris wrote:
> On Wed, 2007-09-19 at 17:35 +0100, Martin Orr wrote:
>> On 18/09/07 22:54, Chad Sellers wrote:
>>> One other note - how does a special debug domain that allows everything
>>> except things that are dontaudit'd solve the use case that's been thrown
>>> around. If I'm the IT guy, and I'm using this permissive domain to try out a
>>> policy for 3 months in a permissive environment, I certainly don't want
>>> certain items to be denied. Even worse, the current idea would have them
>>> denied and not even audit'd. So, instead of causing a problem 3 months from
>>> now when I switch to enforcing, it causes problems the day I install policy.
>>> Millions are still lost, people still say SELinux sucks, and I (the policy
>>> writer) still get fired (with 3 months less pay as well).
>> To pick out one particular point here, tracking down problems caused by
>> denials which have dontaudit rules is difficult, because by definition they
>> are not logged.  (I have what I guess is such a problem now: iff enforcing
>> is on, the mails cron sends me are empty.)  Would it not be useful to have a
>> way of disabling dontaudit rules, perhaps on a global or perhaps on a
>> per-domain basis?  Just as dontaudit rules are orthogonal to allow rules,
>> this setting would be orthogonal to permissive/enforcing.
>>
>> Please forgive me if this is already possible and I have missed it.
> 
> http://readlist.com/lists/tycho.nsa.gov/selinux/1/7187.html
> 
> nope, you didn't miss it, but it should be coming from the userspace
> people sometime.....
> 

Its been in svn since 2007-08-16, versions:
libsemanage 2.0.4
policycoreutils 2.0.23
libsepol 2.0.6



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
