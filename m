Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6Q0IggA028978
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2005 20:18:42 -0400 (EDT)
Received: from sccrmhc13.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6Q0CWAP007742
	for <selinux@tycho.nsa.gov>; Tue, 26 Jul 2005 00:12:32 GMT
Message-ID: <42E5801B.8050902@tresys.com>
Date: Mon, 25 Jul 2005 20:13:15 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: gyurdiev@redhat.com
CC: Daniel J Walsh <dwalsh@redhat.com>,
   "Christopher J. PeBenito" <cpebenito@tresys.com>,
   James Morris <jmorris@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>,
   Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: Iptables discussion
References: <20050724152822.95995.qmail@web34310.mail.mud.yahoo.com>	<Lynx.SEL.4.62.0507250019380.21934@thoron.boston.redhat.com>	<42E50756.5030302@redhat.com>  <1122315868.13068.200.camel@sgc>	<1122316136.2997.69.camel@celtics.boston.redhat.com>	<1122317025.2997.74.camel@celtics.boston.redhat.com>	<42E535A5.1030406@redhat.com>  <42E536FB.10408@tresys.com>	<1122321195.2997.126.camel@celtics.boston.redhat.com>	<42E56ACA.9080200@tresys.com> <1122336429.31227.12.camel@localhost.localdomain>
In-Reply-To: <1122336429.31227.12.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>>earlier in this thread, the consistency arguments (iptables having a 
>>run-time state vs. a persistant state, contrary to the persistant state 
>>of the selinux policy)
>>    
>>
>
>Ah, I see:
>
>"This may cause consistency problems. Adding a iptable rule 
>would add it to the current running firewall config (in memory) 
>and may or may not store it in a state file to be rerun on boot."
>
>Well, actually we can't add anything to iptables, because
>of the performance overhead of a policy rewrite. We need
>to have a concept of a configuration, so that we 
>can begin and end the transaction appropriately and not per rule
>invocation.
>
>In which case, yes, this is a valid argument - something higher level
>than iptables needs to handle this... but system-config-security is
>written in python...perhaps some iptables wrapper.
>
>  
>
sounds like we need some python wrappers for libsemanage :)

Since portage will probably need to manage policy these will emerge (no 
pun intended) at some point regardless. Whoever needs them first gets to 
write them though :)

some already exist for parts of libselinux 
(http://sourceforge.net/projects/python-selinux) which were created to 
handle selinux functions for portage (the gentoo package manager)

>>no, implicit labeling considered harmful. This destroys the concept of 
>>equivalence classes (which is what types are). You should be able to 
>>make 2 interfaces equivalent without having a set of rules for each of them.
>>    
>>
>
>I understand the argument, but realize that most users will not,
>and should not care - they want to configure their ethernet cards,
>not any security labels. Anyway, configuring the network 
>interface labels is a lot easier than dealing with allow rules.
>Then you can look them up via the query function which I submitted.
>
>  
>
most users don't understand type enforcement at all, thats why we are 
abstracting this. Clearly the application configuring the interfaces 
won't need to burden the users with this information, which is why i 
suggested that a policy specific configuration file may be necessary for 
this.

>>>Deny rules could possibly be ... denied :) on an selinux-enabled system.
>>>
>>> 
>>>
>>>      
>>>
>>that means the app needs to get a full copy of the policy and try to 
>>find allow rules that could violate the deny state of the iptables rule, 
>>this is bad
>>    
>>
>
>I don't understand this - I was implying that we completely disallow 
>deny rules. Perhaps you can clarify...
>  
>
ah, I read it wrong, sorry :)

I thought you meant deny rules would somehow reflect a similar denial in 
selinux, which is problematic

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
