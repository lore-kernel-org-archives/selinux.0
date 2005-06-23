Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5N66lgA024011
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 02:06:47 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5N5v3Na028101
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 05:57:03 GMT
Date: Thu, 23 Jun 2005 01:56:45 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: http://www.securityfocus.com/columnists/334/3
In-Reply-To: <20050622235344.GP14480@lkcl.net>
Message-ID: <Xine.LNX.4.44.0506230147440.11335-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 23 Jun 2005, Luke Kenneth Casson Leighton wrote:

> background [for people who might not know what i'm talking about]:
> 
> 	it is possible to do some of the same job as a
> 	firewall, in selinux policy rules: start by looking
> 	at /etc/selinux/src/net_contexts and search for strings
> 	occuring in there in the rest of your selinux policy
> 	source.
> 
> 	selinux policy rules can do a certain degree of network
> 	access restriction based on the program _and_ the user
> 	that's doing the network access.

Note that these controls are not as expressive or powerful as iptables
rules, and are not able to leverage things like connection tracking (aka
stateful inspection), protocol helpers etc.  One of the longer term ideas
is to replace some of the SELinux network control hooks with SELinux
matches & targets for iptables.

I've done some preliminary work on this here:
http://people.redhat.com/jmorris/selinux/selipt/

One problem is protocol layering violation, in that we need to make access
control decisions at multiple layers simultaneously (IP and Socket
layers), and finding the right way to do this in iptables/netfilter is not
simple.

It also involves moving some configuration outside of centralized policy 
and having access control decisions made outside of the AVC.

So, there are several conceptual impurities, although I once heard someone
say "perfect is the enemy of good".


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
