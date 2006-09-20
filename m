Subject: Re: ipsec, netlabels, secmark- How about a little usability?
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: James Morris <jmorris@namei.org>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, James Antill <jantill@redhat.com>,
        Joshua Brindle <jbrindle@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <Pine.LNX.4.64.0609200938590.27451@d.namei>
References: <45095092.6080603@redhat.com>  <45095E10.2020205@tresys.com>
	 <1158249777.8442.13.camel@code.and.org>
	 <1158252565.25629.111.camel@moss-spartans.epoch.ncsc.mil>
	 <1158698831.15306.27.camel@localhost.localdomain>
	 <1158759005.26420.198.camel@sgc>
	 <Pine.LNX.4.64.0609200938590.27451@d.namei>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 10:27:38 -0400
Message-Id: <1158762458.26420.229.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-09-20 at 09:45 -0400, James Morris wrote:
> On Wed, 20 Sep 2006, Christopher J. PeBenito wrote:
> 
> > I don't agree with the first part of this point.  This isn't really any
> > different than the old networking where you hand to look up the context
> > of the ports, nodes, and netif (the ports being the one with a similar
> > amount entries) on every packet.  Second, the cost of going through the
> > chain with all of the rules is only on new connections.  Established
> > connections will skip that and just get the connection tracking label
> > w/CONNSECMARK --restore.
> 
> Agreed.  The discussion of performance impact when no performance testing 
> has been done seems premature.  People probably don't realize that 
> previously, three fully non-cached policyb lookups were being performed 
> for every single packet flowing through the system.
> 
> From what I can tell, too, the examples I provided in may where each 
> service has its own chain has not been followed.  The point of that was to 
> allow a matching packet to then bypass the rest of the rules because a 
> verdict has been issued.
> 
> There are port ranges and the multiport match which can reduce the 
> number of iptables rule lookups for a packet.
> 
> Also, very importantly, rules should only be loaded for services which are 
> active.  This should be clear from the examples provided, where the 
> rule for each example service was in its own script module.
> 
> It should also be possible to automatically retune the rules on a regular 
> basis by looking at the packet counters and reloading the rules so that 
> the highest hit rules are listed first.

In the past we decided to enable all ports regardless of whether or not
the service was on or its policy was loaded (not just refpolicy, the old
example policy too).  Connections to port 80 are http connections, even
if the local machine doesn't have apache installed.  Since the netfilter
labeling replaces the old networking, refpolicy will have all of the
netfilter labeling rules enabled too.  I didn't follow your example
because of that, otherwise we would have about 180 chains.  Since the
cost of going through the labeling chain only happens on the first
packet of a connection, it didn't seem like a problem that the remainder
of the rules were not bypassed once a match was made.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
