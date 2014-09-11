Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s8BDNkkn005361
 for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2014 09:23:46 -0400
Message-ID: <5411A246.4040809@tresys.com>
Date: Thu, 11 Sep 2014 09:23:18 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: Userspace Release 2014-08-26-rc2 - semodule(8) query
References: <1410438928.7712.YahooMailNeo@web87903.mail.ir2.yahoo.com>
In-Reply-To: <1410438928.7712.YahooMailNeo@web87903.mail.ir2.yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Cc: selinux list <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Priorities allows multiple modules with the same name to exist in the
policy store, with the higher priority module included in the final
kernel binary, and all lower priority modules of the same name ignored.
So this allows things like:

  # semodule --priority 100 --install distribution/apache.pp
  # semodule --priority 400 --install custom/apache.pp

Both apache modules are installed to the policy store listed as
'apache', but only the custom apache module is included in the final
kernel binary. The distribution apache module is completely ignored.

The main use case for this is the ability to override a distribution
provided policy, while keeping the distribution policy in the store.
This makes it very easy for distributions, 3rd parties, configuration
management tools (e.g. puppet), local administrators, etc. to update
policies without wiping away each others changes. This also means that
even if a distrubtion/3rd party/etc updates a module, if you have one
installed at a higher priority, it will still override the new
distribution policy.

This does require that various policy managers adopt some kind of scheme
for who uses what priority. No strict guidelines for this currently
exist, but we have assumed some numbers. For example, we assume
distributions would use priority 100, and so the semanage_migrate_store
script migrates all modules using that as the default. We also assume
that local policies will be installed at 400, so semodule uses that as a
default priority.

Hopefully that clears things up a bit.

- Steve


On 09/11/2014 08:35 AM, Richard Haines wrote:
> Steve,
> 
> Could you explain/clarify the semodule --priority option please. I've been adding
> modules at different priorities and they are still added to the final binary policy
> in /etc/selinux/<policy_name>/poilcy so trying to figure out what they could be
> used for.
> 
> Thanks
> Richard
> 
