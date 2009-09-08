Subject: Re: MCS and default labels
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20090908163628.GC24297@myhost.felk.cvut.cz>
References: <20090908055806.GA24297@myhost.felk.cvut.cz>
	 <1252424128.13634.404.camel@moss-pluto.epoch.ncsc.mil>
	 <20090908163628.GC24297@myhost.felk.cvut.cz>
Content-Type: text/plain
Date: Tue, 08 Sep 2009 13:10:05 -0400
Message-Id: <1252429805.13634.423.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-09-08 at 18:36 +0200, Michal Svoboda wrote:
> It is okay that the system is discretionary, and I don't question that
> fact. I question the way labels get assigned *per default*. In
> comparison to DAC, it would mean that all files are created with an 
> umask of 000 and are required to change the resulting permissions
> afterwards. You can not expect that every application out there is
> aware of MCS and/or that every user uses chcat thoroughly on all new
> files (plus there are issues like text editors making a copy of a file
> prior to editing).
> 
> So in other words DAC nature of MCS is okay it is just that there should
> be some more sensible defaults pointing towards preservation of labels
> on objects in their respective containers. The unix setgid bit can do
> that on directories, as do default ACLs, both being mechanisms of DAC.

Unfortunately for you, MCS is using the existing MLS engine, which
doesn't presently support inheritance from parent directory (unlike the
TE engine).  So to support the behavior you want, you'd have to modify
the actual code (and that's kernel code).  Thus, you are more likely to
find success using actual MLS or using TE.

> Secondly I don't see why a user is not able to discretionarily specify
> his range outright when going via ssh just as he can with roles. 

That's another artifact of the MLS model (label preservation /
confinement).

> > Perhaps you ought to use MLS instead.  Or just use TE and define domains
> > and types for these processes and files.
> 
> No. MLS is about strict ordering 0 < 1 < 2 ... I just want a partially
> ordered set. I want compartments, not sensitivities. MCS and MLS are
> orthogonal, at least by their theoretical properties (and SELinux MCS
> strongly resembles the theory in practice).

I think you're confused about MLS; it supports a set of hierarchical
sensitivities and a set of non-hierarchical categories, and MCS is
nothing more than a particular configuration of the MLS engine.  So you
are free to just use a single MLS sensitivity and only use its
categories.  

> And TE? Almost any of these models can be simulated by TE, given types
> are granular enough, but I don't want the number of types be a quadratic
> function of compartments plus the hassle associated with that.
> 
> With regards,
> Michal Svoboda
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
