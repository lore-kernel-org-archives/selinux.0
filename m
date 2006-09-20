Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8KEk4kg015648
	for <selinux@tycho.nsa.gov>; Wed, 20 Sep 2006 10:46:04 -0400
Received: from mail6.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8KEjWFd019334
	for <selinux@tycho.nsa.gov>; Wed, 20 Sep 2006 14:45:33 GMT
Date: Wed, 20 Sep 2006 10:45:59 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, James Antill <jantill@redhat.com>,
        Joshua Brindle <jbrindle@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: ipsec, netlabels, secmark- How about a little usability?
In-Reply-To: <1158762458.26420.229.camel@sgc.columbia.tresys.com>
Message-ID: <Pine.LNX.4.64.0609201042230.27878@d.namei>
References: <45095092.6080603@redhat.com>  <45095E10.2020205@tresys.com>
 <1158249777.8442.13.camel@code.and.org>  <1158252565.25629.111.camel@moss-spartans.epoch.ncsc.mil>
  <1158698831.15306.27.camel@localhost.localdomain>  <1158759005.26420.198.camel@sgc>
  <Pine.LNX.4.64.0609200938590.27451@d.namei> <1158762458.26420.229.camel@sgc.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 20 Sep 2006, Christopher J. PeBenito wrote:

> netfilter labeling rules enabled too.  I didn't follow your example
> because of that, otherwise we would have about 180 chains.

Not sure why this is a problem.

> Since the cost of going through the labeling chain only happens on the 
> first packet of a connection, it didn't seem like a problem that the 
> remainder of the rules were not bypassed once a match was made.

This will be an issue for things like web servers, where you have high 
connection rates and there will be lots of syn packets needing to be 
matched and traversing each rule.

On such a server, you should have the port 80 match first and jump to a 
chain which applies the secmark and then returns a verdict, so the packet 
does not traverse any more rules in that table.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
