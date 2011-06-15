Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p5FDmavl016735
	for <selinux@tycho.nsa.gov>; Wed, 15 Jun 2011 09:48:36 -0400
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p5FDmZQK017648
	for <selinux@tycho.nsa.gov>; Wed, 15 Jun 2011 13:48:35 GMT
Message-ID: <4DF8B832.9060307@tresys.com>
Date: Wed, 15 Jun 2011 09:48:34 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Sam Gandhi <samgandhi9@gmail.com>
CC: <selinux@tycho.nsa.gov>
Subject: Re: /etc/selinux/$P/users/local.users and system.users are they deprecated?
References: <BANLkTikdwRevmnuj7Lw6Vtv=d-iFHd45Yg@mail.gmail.com>
In-Reply-To: <BANLkTikdwRevmnuj7Lw6Vtv=d-iFHd45Yg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 06/14/11 13:36, Sam Gandhi wrote:
> First in my environment I am not allowed to ship python, so I can't
> use wonderful tool semanage.
> 
> I admit that I am bit  confused (&intimidated) by so many files to
> manage that constitutes SELinux configuration.
> 
> Are files /etc/selinux/$P/users/local.users & system.users required
> for proper functioning of SELinux user-space libraries? Or user/roles
> defined in policy definitions sufficient?
>
> I looked at the latest libselinux code it still has code to use
> local.users but didn't see code that actually uses system.users,  Aksi
> reference policy make install also installs these files.
> 
> However in the the mailing list I have seen references back in
> 2005/2006 that these files are deprecated? The latest pdf file that
> was mailed out recently also has reference to local.users but not to
> system.users.

These files actually were never required, and they were only useful for
monolithic policies.  Imagine your policy is installed by a distro; you
may not know what seusers are in the policy.  The purpose of
system.users was to tell you this.  local.users could optionally be used
to add additional seusers without having to recompile the policy.

Now that we have a modular policy and a policy management infrastructure
(semodule/semanage), these files are not necessary, as you can do this
all through semanage.  Projects that still use monolithic policy today
usually don't need this support, since monolithic policy is typically
only used in an environment where the policy is static.

If your seusers are static (i.e. you're only using the ones compiled
into the policy) then you don't need local.users.

> If system.users file is still valid which definition then takes the
> precedence and doesn't this expose a security hole that someone can
> change user role after the policy was generated?

No, system.users is only informational, it doesn't alter the policy.
local.users only adds to the policy, it can't remove or override.

> In my policy definitions I am defining a new user diags_u, type
> diags_t and role diags_r, essentially following statements in
> policy.conf (through macros etc)
> 
> type diags_t, domain, userdomain, unpriv_userdomain, nscd_client_domain, privfd;
> role diags_r types diags_t;
> user diags_u roles { diags_r };
> 
> Is that sufficient?  fwiw, I have been able to transition to
> diags_u:diags_r:diags_t context using the newrole command, when using
> policy that contains above statements.

And it works in enforcing?  I would expect it to fail if you don't have
a role allow:

allow system_r diags_r;

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
