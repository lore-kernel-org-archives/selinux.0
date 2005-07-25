Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6PK1HgA026759
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2005 16:01:19 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6PJtveR012959
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2005 19:55:58 GMT
Subject: Re: Iptables discussion
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
   "Christopher J. PeBenito" <cpebenito@tresys.com>,
   James Morris <jmorris@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>,
   Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <42E536FB.10408@tresys.com>
References: <20050724152822.95995.qmail@web34310.mail.mud.yahoo.com>
	 <Lynx.SEL.4.62.0507250019380.21934@thoron.boston.redhat.com>
	 <42E50756.5030302@redhat.com>  <1122315868.13068.200.camel@sgc>
	 <1122316136.2997.69.camel@celtics.boston.redhat.com>
	 <1122317025.2997.74.camel@celtics.boston.redhat.com>
	 <42E535A5.1030406@redhat.com>  <42E536FB.10408@tresys.com>
Content-Type: text/plain
Date: Mon, 25 Jul 2005 15:53:15 -0400
Message-Id: <1122321195.2997.126.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> > type netif_eth0_t, netif_type;
> > netifcon eth0 system_u:object_r:netif_eth0_t 
> > system_u:object_r:unlabeled_t
> > allow httpd_t netif_eth0_t:netif { tcp_recv tcp_send rawip_send 
> > rawip_recv };
> > allow named_t netif_eth0_t:netif { udp_recv udp_send tcp_recv tcp_send 
> > rawip_send rawip_recv };

Those seem reasonable.

> IMHO, I think that we _cannot_ add code to iptables to manage policy. 
> This is a bad idea for a number of reasons that I've talked about in 
> other emails.

I haven't seen any of those, can you point me somewhere?

> This functionality should be put in system-config-security to set up the 
> firewall iptables rules and manage a subset of the network related 
> policy rules. 

I don't understand why we have two sets of rules to manage the same
thing.

> This should leverage the module system so that 
> system-config-security essentially owns a module that it can put it's 
> rules in, remove them, etc. We can later use the policy server to limit 
> this applications policy actions to just those under the primary network 
> type.

Good idea...

> The interfaces to do this work should be exported through libsemanage to 
> do it seamlessly regardless of policy backend. The labels will have to 
> (unfortunatly) be part of some configutation file, which is policy 
> specific. 

The labels can be inferred from the card name, if necessary.

> Also the other issue with allow-by-default firewalls and deny rules, 
> which can't be addresssed in policy at all (and I think it's a very bad 
> idea for some network config app to recurse the entire policy looking 
> for rules that might violate it's internal settings).

Deny rules could possibly be ... denied :) on an selinux-enabled system.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
