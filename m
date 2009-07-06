Subject: Re: request for review of, and collaboration on SELinux models
 wiki entry
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Sebastian Pfaff <sebastian.pfaff@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <04BE01E3-B511-4CDF-8FDE-253048E6D94A@gmail.com>
References: <1246542053.26320.15.camel@notebook2.grift.internal>
	 <1246544997.13464.314.camel@moss-pluto.epoch.ncsc.mil>
	 <7DB3E8B4-9FFF-4FE1-873D-1A99C6EEF0AA@gmail.com>
	 <1246549788.26320.42.camel@notebook2.grift.internal>
	 <1246554192.13464.350.camel@moss-pluto.epoch.ncsc.mil>
	 <04BE01E3-B511-4CDF-8FDE-253048E6D94A@gmail.com>
Content-Type: text/plain
Date: Mon, 06 Jul 2009 08:42:00 -0400
Message-Id: <1246884120.27287.23.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-07-02 at 20:12 +0200, Sebastian Pfaff wrote:
> I think this implies that i'm wrong :/
> 
> If MLS and MCS are mutally exclusive, why is it possible to use  
> categories _and_ levels with MLS policy? Isn't this a conflict?
> 
> Is MCS something similar which is generally referred to as  
> Multilateral-Security?
> 
> Look here (excerpt from book Information Security - Priciples and  
> Practice):
> 
> http://books.google.com/books?id=Bh45pU0_E_4C&lpg=PP1&dq=Information%20security%20principles&pg=PA185
> 
> So far i find the term MCS only or mainly in the context with SELinux,  
> so i think it is (maybe) something SELinux specific which does  
> neccessarily has something to do with Multilateral-Security.
> 
> I would be appreciate, if someone could give me some hints on what is  
> wrong with my point of view.

MCS was invented by James Morris,
http://james-morris.livejournal.com/5583.html

It doesn't really correspond to anything in the literature; it just
leverages the MLS label field and policy engine.

MCS and MLS are just different configurations of the MLS policy engine.
The MCS configuration only defines a single sensitivity, while the MLS
configuration defines multiple sensitivities (16 in the Fedora policy).
Both define and use categories (1024 in the Fedora policies).  Under
MCS, the "low level" in the process' range is always s0, and the process
may at its discretion label files with any category from its "high
level" and may access files whose category sets are within the process
"high level".  Under MLS, the "low level" in the process' range
represents its active/current level, any files created by the process
must be labeled at that level, and it may only read-down and write-at
that level unless it has specific type attributes that allow it to
override the usual MLS constraints.  The "high level" under MLS
represents the user's max clearance, with the process able to elevate
its low level up to that max via newrole -l (depending on
configuration).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
