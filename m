Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6PJ0bgA026149
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2005 15:00:37 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6PIsTAP026028
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2005 18:54:29 GMT
Message-ID: <42E535A5.1030406@redhat.com>
Date: Mon, 25 Jul 2005 14:55:33 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: gyurdiev@redhat.com
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
   James Morris <jmorris@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>,
   Joshua Brindle <jbrindle@tresys.com>,
   Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: Iptables discussion
References: <20050724152822.95995.qmail@web34310.mail.mud.yahoo.com>	 <Lynx.SEL.4.62.0507250019380.21934@thoron.boston.redhat.com>	 <42E50756.5030302@redhat.com>  <1122315868.13068.200.camel@sgc>	 <1122316136.2997.69.camel@celtics.boston.redhat.com> <1122317025.2997.74.camel@celtics.boston.redhat.com>
In-Reply-To: <1122317025.2997.74.camel@celtics.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>On Mon, 2005-07-25 at 14:28 -0400, Ivan Gyurdiev wrote:
>  
>
>>>So you could have:
>>>
>>>can_network(apache_t)
>>>
>>>and then to change it to only use eth0,
>>>
>>>can_network(apache_t,eth0_netif_t)
>>>      
>>>
>>I think automatic policy editing has to occur post-m4 - it doesn't
>>make sense to me to be generating pre-m4 macros - this is going
>>to be very hard to validate, and require a long time to compile and
>>process.
>>
>>Your 1-line change expands to several hundred rules in policy.
>>    
>>
>
>Perhaps I misunderstood what you were saying.
>Dan's saying you want the netif argument to be optional,
>and we fallback to a default label where everything's allowed 
>if the argument is missing - so you'd only add a specific 
>label for things you want managed by iptables. 
>
>That would make sense, and might be a good idea.
>
>
>  
>
Ok so then a tool could add the following rules to only allow apache and 
named to run on 0.

type netif_eth0_t, netif_type;
netifcon eth0 system_u:object_r:netif_eth0_t system_u:object_r:unlabeled_t
allow httpd_t netif_eth0_t:netif { tcp_recv tcp_send rawip_send 
rawip_recv };
allow named_t netif_eth0_t:netif { udp_recv udp_send tcp_recv tcp_send 
rawip_send rawip_recv };


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
