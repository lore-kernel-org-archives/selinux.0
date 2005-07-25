Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6PMljgA028384
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2005 18:47:48 -0400 (EDT)
Received: from sccrmhc12.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6PMfaAP027124
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2005 22:41:36 GMT
Message-ID: <42E56ACA.9080200@tresys.com>
Date: Mon, 25 Jul 2005 18:42:18 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: gyurdiev@redhat.com
CC: Daniel J Walsh <dwalsh@redhat.com>,
   "Christopher J. PeBenito" <cpebenito@tresys.com>,
   James Morris <jmorris@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>,
   Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: Iptables discussion
References: <20050724152822.95995.qmail@web34310.mail.mud.yahoo.com>	<Lynx.SEL.4.62.0507250019380.21934@thoron.boston.redhat.com>	<42E50756.5030302@redhat.com>  <1122315868.13068.200.camel@sgc>	<1122316136.2997.69.camel@celtics.boston.redhat.com>	<1122317025.2997.74.camel@celtics.boston.redhat.com>	<42E535A5.1030406@redhat.com>  <42E536FB.10408@tresys.com> <1122321195.2997.126.camel@celtics.boston.redhat.com>
In-Reply-To: <1122321195.2997.126.camel@celtics.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>>>type netif_eth0_t, netif_type;
>>>netifcon eth0 system_u:object_r:netif_eth0_t 
>>>system_u:object_r:unlabeled_t
>>>allow httpd_t netif_eth0_t:netif { tcp_recv tcp_send rawip_send 
>>>rawip_recv };
>>>allow named_t netif_eth0_t:netif { udp_recv udp_send tcp_recv tcp_send 
>>>rawip_send rawip_recv };
>>>      
>>>
>
>Those seem reasonable.
>
>  
>
rawip_* isn't necessary and should not be added

>>IMHO, I think that we _cannot_ add code to iptables to manage policy. 
>>This is a bad idea for a number of reasons that I've talked about in 
>>other emails.
>>    
>>
>
>I haven't seen any of those, can you point me somewhere?
>
>  
>
earlier in this thread, the consistency arguments (iptables having a 
run-time state vs. a persistant state, contrary to the persistant state 
of the selinux policy)

>>This functionality should be put in system-config-security to set up the 
>>firewall iptables rules and manage a subset of the network related 
>>policy rules. 
>>    
>>
>
>I don't understand why we have two sets of rules to manage the same
>thing.
>
>  
>
there will always be 2 sets, we are trying to keep them consistent. 
Also, iptables can state alot more than the policy currently supports. 
Adding this to iptables means defining certain types of 'supported' 
rules to add to the policy. Rather than do that this should be done from 
the interface that already limits what kind of rules you can do and 
simplifies them for the user (system-config-network{,-tui}

>>This should leverage the module system so that 
>>system-config-security essentially owns a module that it can put it's 
>>rules in, remove them, etc. We can later use the policy server to limit 
>>this applications policy actions to just those under the primary network 
>>type.
>>    
>>
>
>Good idea...
>
>  
>
>>The interfaces to do this work should be exported through libsemanage to 
>>do it seamlessly regardless of policy backend. The labels will have to 
>>(unfortunatly) be part of some configutation file, which is policy 
>>specific. 
>>    
>>
>
>The labels can be inferred from the card name, if necessary.
>
>  
>
no, implicit labeling considered harmful. This destroys the concept of 
equivalence classes (which is what types are). You should be able to 
make 2 interfaces equivalent without having a set of rules for each of them.

>>Also the other issue with allow-by-default firewalls and deny rules, 
>>which can't be addresssed in policy at all (and I think it's a very bad 
>>idea for some network config app to recurse the entire policy looking 
>>for rules that might violate it's internal settings).
>>    
>>
>
>Deny rules could possibly be ... denied :) on an selinux-enabled system.
>
>  
>
that means the app needs to get a full copy of the policy and try to 
find allow rules that could violate the deny state of the iptables rule, 
this is bad

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
