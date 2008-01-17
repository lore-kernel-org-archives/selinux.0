Subject: Re: [PATCH] REFPOL: Add "rogue" Fedora packet class permissions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov
In-Reply-To: <478FA8C3.40600@manicmethod.com>
References: <20080117172246.341834342@hp.com>
	 <478FA8C3.40600@manicmethod.com>
Content-Type: text/plain
Date: Thu, 17 Jan 2008 14:33:41 -0500
Message-Id: <1200598421.7025.73.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-01-17 at 14:13 -0500, Joshua Brindle wrote:
> Paul Moore wrote:
> > At some point in the Fedora 6 timeframe the "flow_in" and "flow_out"
> > permissions were added to the "packet" class, most likely as part of the
> > ill-fated secid-reconciliation effort.  Despite the fact that these permissions
> > are not currently used they should be included in the Reference Policy as they
> > are now a permanent fixture in Fedora and it is crucial that the FLASK
> > defines be kept in sync.
> >
> > This patch needs to be applied before any other patches that affect the
> > "packet" class, otherwise the resulting policy may not load.
> >
> >   
> 
> Hrm, they are last in the class definitions so until new perms are added 
> to that class it is fairly irrelevant. The policy upgrade to remove them 
> would only require a reboot to get rid of them so adding them to 
> upstream refpolicy doesn't seem necessary at all.
> 
> This also points out how much of a bad idea it is to add object 
> class/perm definitions into distro policies before they are in 
> refpolicy, I hope that this will be avoided in the future.
> 
> I'm not sure what Chris feels about this but I'm opposed to adding 
> definitions to the policy like this.

The situation is this:
- policy shipped in Fedora 6 and later had these flow_in/flow_out
permissions defined in their base modules and in their gen_requires.
- Paul Moore is adding new permissions to that class in his labeled
networking tree that is included in -mm and queued for 2.6.25,
- when you try to load those policies into the resulting kernel, the
class validation logic rejects the policies,
- any policy modules built by any third parties also have these perms
defined in their requires and will fail if we remove them from base,
- we can't make any changes to the kernel that break existing userspace
and policy (which is why handle_unknown is largely useless to us until
all legacy distros that predate it are sufficiently dead and gone).

This all came up because akpm reported the failure on his FC6 test box
with latest -mm.

I suggested just using flow_in/flow_out instead of
forward_in/forward_out for Paul's new controls so that we don't have any
unused permissions, but Paul and Eric want the more precise names.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
