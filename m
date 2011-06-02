Subject: Re: Is there way to set some specific domain to have all
 permissions?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Sam Gandhi <samgandhi9@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <BANLkTinrUq+CZSLkghmhu7hbA-tKc5cfzQ@mail.gmail.com>
References: <BANLkTinrUq+CZSLkghmhu7hbA-tKc5cfzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 02 Jun 2011 08:36:36 -0400
Message-ID: <1307018196.19229.16.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-06-01 at 16:43 -0700, Sam Gandhi wrote:
> If I want to set permission for say program in myprog_t to allow all
> the permissions, is there way to do this in SELinux.
> 
> Example I have program myprog and rule to set it domain correctly,
> what I want to do is this domain myprog_t should be able to do
> anything.
> 
> How would one write such a policy rule? I have done search on mailing
> list archive and see there was a long thread in 2007 called 'concept
> of a permissive domain' but I am not able figure out what the
> conclusion of that thread was...

There are two different concepts here:
1) An unconfined domain is a domain that is allowed to do everything by
the policy.  There will be no denials for such a domain and thus no avc
denied messages.  There is no single policy rule/statement for
identifying a domain as unconfined (as SELinux has no inherent notion of
an unconfined domain); instead, you have to define a set of policy rules
that grant all permissions to all types for that domain.  In typical
policies, this is done by defining an unconfined_domain() macro that
either directly expands to the necessary rules or that associates a type
attribute with the domain that is then used in a series of allow rules
granting all permissions to all domains with that type attribute (the
latter is more efficient in memory usage).

2) A permissive domain is a domain that operates in permissive mode
independent of the global enforcing/permissive status.  Such a domain
may be denied permissions by the policy, but such denials will only be
logged and not enforced by the system.  A permissive domain is defined
by the permissive statement, e.g.:
	permissive myprog_t;

Permissive domains are only supported for policy versions >= 23, so if
your kernel's /selinux/policyvers is < 23, your kernel won't support
that feature.

The purpose of permissive domains, like permissive mode, is for policy
development/debugging, not as a means of permanently making a particular
domain unconfined.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
