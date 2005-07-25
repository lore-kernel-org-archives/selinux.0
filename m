Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6PJ5TgA026207
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2005 15:05:31 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6PJ04eR006987
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2005 19:00:09 GMT
Message-ID: <42E536FB.10408@tresys.com>
Date: Mon, 25 Jul 2005 15:01:15 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: gyurdiev@redhat.com, "Christopher J. PeBenito" <cpebenito@tresys.com>,
   James Morris <jmorris@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>,
   Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: Iptables discussion
References: <20050724152822.95995.qmail@web34310.mail.mud.yahoo.com> <Lynx.SEL.4.62.0507250019380.21934@thoron.boston.redhat.com> <42E50756.5030302@redhat.com>  <1122315868.13068.200.camel@sgc> <1122316136.2997.69.camel@celtics.boston.redhat.com> <1122317025.2997.74.camel@celtics.boston.redhat.com> <42E535A5.1030406@redhat.com>
In-Reply-To: <42E535A5.1030406@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:

> Ivan Gyurdiev wrote:
>
>> On Mon, 2005-07-25 at 14:28 -0400, Ivan Gyurdiev wrote:
>>  
>>
>>>> So you could have:
>>>>
>>>> can_network(apache_t)
>>>>
>>>> and then to change it to only use eth0,
>>>>
>>>> can_network(apache_t,eth0_netif_t)
>>>>     
>>>
>>> I think automatic policy editing has to occur post-m4 - it doesn't
>>> make sense to me to be generating pre-m4 macros - this is going
>>> to be very hard to validate, and require a long time to compile and
>>> process.
>>>
>>> Your 1-line change expands to several hundred rules in policy.
>>>   
>>
>>
>> Perhaps I misunderstood what you were saying.
>> Dan's saying you want the netif argument to be optional,
>> and we fallback to a default label where everything's allowed if the 
>> argument is missing - so you'd only add a specific label for things 
>> you want managed by iptables.
>> That would make sense, and might be a good idea.
>>
>>
>>  
>>
> Ok so then a tool could add the following rules to only allow apache 
> and named to run on 0.
>
> type netif_eth0_t, netif_type;
> netifcon eth0 system_u:object_r:netif_eth0_t 
> system_u:object_r:unlabeled_t
> allow httpd_t netif_eth0_t:netif { tcp_recv tcp_send rawip_send 
> rawip_recv };
> allow named_t netif_eth0_t:netif { udp_recv udp_send tcp_recv tcp_send 
> rawip_send rawip_recv };
>
IMHO, I think that we _cannot_ add code to iptables to manage policy. 
This is a bad idea for a number of reasons that I've talked about in 
other emails.

This functionality should be put in system-config-security to set up the 
firewall iptables rules and manage a subset of the network related 
policy rules. This should leverage the module system so that 
system-config-security essentially owns a module that it can put it's 
rules in, remove them, etc. We can later use the policy server to limit 
this applications policy actions to just those under the primary network 
type.

I still think there are consistency issues with this, the software will 
have to be careful. All of the network rules will have to be moved to a 
single module (this is odd since apache has it's own rules, etc.. maybe 
those will be removed and all network access is defined centrally). I 
really don't like this but if you want configurable network rules there 
really isn't much choice.

The interfaces to do this work should be exported through libsemanage to 
do it seamlessly regardless of policy backend. The labels will have to 
(unfortunatly) be part of some configutation file, which is policy 
specific. This means that there needs to be some config files that are 
tightly coupled with the policy to tell these management applications 
what types they want to refer to.

Also the other issue with allow-by-default firewalls and deny rules, 
which can't be addresssed in policy at all (and I think it's a very bad 
idea for some network config app to recurse the entire policy looking 
for rules that might violate it's internal settings).



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
