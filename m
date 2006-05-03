Subject: Re: [2/4] Labeling only policy for fireflier (fireflier.pp)
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: =?ISO-8859-1?Q?T=F6r=F6k?= Edwin <edwin@gurde.com>
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>,
        fireflier-devel@lists.sourceforge.net
In-Reply-To: <200605011934.00791.edwin@gurde.com>
References: <200604021240.21290.edwin@gurde.com>
	 <1146079604.28745.183.camel@moss-spartans.epoch.ncsc.mil>
	 <200605011917.54954.edwin@gurde.com>  <200605011934.00791.edwin@gurde.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 03 May 2006 10:35:21 -0400
Message-Id: <1146666921.20331.104.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-05-01 at 19:34 +0300, Török Edwin wrote:
> [this policy (together with the base in mail [1/4]) is intended for systems 
> where there is no selinux by default. for selinux enabled systems i'll create 
> modules to be used with reference policy, i'll send that in a separate mail 
> when it will be ready]
> 
> Still I want to provide "some" protection against changing labels (it would be 
> just too easy to escape protection, but only for root, right?)

Even if you can't relabel the file you could just delete it and recreate
it with the new label using setfscreatecon, since it has all the other
file perms.

> So I implemented something similar to what selinuxutil.te does to protect the 
> module store, and also restricted policy loading to only a few domains.
> Also restricted policy loading/setbool/setenforce with booleans. Also 
> restricted module loading, and rawio.
> 
> I didn't use the unconfined interfaces from the reference policy, since they 
> allowed too much rights to programs (IMHO). So I modified them to fit my 
> needs, and put them in unconfined_norelabel.if.
> 
> So nobody besides a domain with policymanager attribute can load policy, and 
> nobody besides them are allowed to change the module store. 
> Any bypasses?

It looks like you have raw disk access, so thats at least one.  It may
not allow you to load the policy, but it allows you to modify the policy
on disk, and next time its loaded (e.g., reboot), you get the modified
policy.

> Of course if somebody replaces load_policy he can load any policy (but that 
> isn't possible with this policy, right?).

You have to have the load_policy permission or transition to a domain
that has the permission.  If you have neither of these, then you should
be ok.  The catch is if you can alter the policy (see above), then you
could get someone else to load the policy (e.g., reboot).  If you can
alter the load_policy binary or its libraries then you could make it do
anything within limits of the domain it runs in.

>  If load_policy & friends aren't 
> statically linked, than someone can bypass it by changing libc, and 
> protecting against that brings me very close to strict policy. So let's 
> assume that load_policy would be statically linked, and it would get a 
> sanitized environment.

See above comment.

> The module store is managed via semodule, so it has to have write access. The 
> problem is whom I allow to execute semodule, because anybody doing that will 
> override my policy. So I restricted transition to semanage_t only for 
> policymanager domains.
> 
> Last I have a program named policymanager, that will generate the policy 
> (doesn't exist yet). Obviously this will be the weakest link in the chain.
> So in the end, I am not sure it is worth all this policy store protection, 
> maybe I could do with a simpler policy.
> 
> Maybe just using auditallow&allow for loading policy protected with a boolean 
> would be enough? (audit: so that the sysadmin thas the chance to know 
> somebody changed the policy, if he uses remote logging, otherwise all is lost 
> if somebody changes policy.) But then somebody could just replace the binary 
> policy, and have it loaded automatically on next reboot?

Right.

> (why i don't want too much protection against root: 
>  - if somebody didn't have selinux, with fireflier 1.1.x somebody could just 
> have deleted the iptables rules to bypass fireflier's protection. You can't 
> get real protection against this, unless you use a strict policy,right?

So off the top of my head, it sounds like the policy should at least
restrict net_admin capability, protect all the files that iptables_t
accesses and its libraries, protect the policy, protect policy loading,
protect load_policy and its libraries.  That affects a lot of files
since it includes some generic types like etc_t, lib_t, and shlib_t.

> Also I don't intend to make fireflier an selinux rule management tool,besides 
> there are some nice tools from tresys that do that ;)
> )

You should try out apol from setools to help analyze your policy.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
