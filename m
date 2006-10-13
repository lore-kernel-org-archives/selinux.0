Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9DNO7ck019696
	for <selinux@tycho.nsa.gov>; Fri, 13 Oct 2006 19:24:07 -0400
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9DNMmo6014270
	for <selinux@tycho.nsa.gov>; Fri, 13 Oct 2006 23:22:48 GMT
Message-ID: <45301FFA.3080805@trustedcs.com>
Date: Fri, 13 Oct 2006 18:23:38 -0500
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: redhat-lspp@redhat.com
Subject: Re: DOCUMENTATION OF SECID RECONCILIATION AND FLOW CONTROL FOR POLICY
 WRITERS
References: <452A3F8C.5080401@trustedcs.com> <452AA26C.7050901@trustedcs.com>
In-Reply-To: <452AA26C.7050901@trustedcs.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Fixed a bug in the doc to be in line with the current proposed implementation.

Venkat Yekkirala wrote:
> Venkat Yekkirala wrote:
>> DOCUMENTATION OF SECID RECONCILIATION AND FLOW CONTROL FOR POLICY WRITERS:
>>
>> ON INBOUND:
>>
>> 1. PACKETS ENTERING SYSTEM FROM A NON-LOOPBACK DEVICE:
>>
>>    Can a packet "carrying" external domain label x_t "flow_in" thru the
>>    security point with the peer domain label p_d_t?
>>
>> 	NOTE:
>> 	a. x_t defaults to unlabeled_t, if no external label.
>> 	b. p_d_t defaults to network_t in the absence of any applicable
>> 	   [conn]secmark rules for the packet. If there are multiple
>> 	   secmark rules applicable to a packet, the context on the LAST
>> 	   rule will apply.
>>
>>    NO: Drop packet.
>>    YES: If no external label, let packet "carry" p_d_t.

s/p_d_t/p_d_t if it didn't default to network_t/

>>
>> 2. INPUT ONLY: Can a socket "recv" a packet from domain p_d_t?
>>
>>    NO: Drop packet.
>>    YES: If setting up a tcp connection, set peer context to p_d_t.
>>
>> ON OUTBOUND:
>>
>> 1. Let packet "carry" the originating socket domain label.
>>
>> 2. IPSEC Handling:
>>
>>    LABELED IPSEC: If packet "polmatch"es to an otherwise applicable and
>>    labeled SPD entry, choose a Security Association (SA) with the SAME context
>>    as the domain label being carried by packet.
>> 	NOTE: If no such SA present, call into IKE with context on packet.
>>
>>    NON-LABELED (PLAIN/TRADITIONAL) IPSEC: If there's an applicable SPD entry
>>    that does NOT have an explicit context associated with it, an applicable SA
>>    that does NOT have an explicit context associated with it is chosen.
>> 	NOTE: If no such SA present, call into IKE, but with NO context.
>>
>> 3. PACKETS DESTINED FOR NON-LOOPBACK DEVICE:
>>
>>    a. IPTABLES Processing:
>>       As EACH applicable iptables [CONN]SECMARK rule with domain p_d_t is
>>       encountered, do the following:
>>    
>>       Can a packet carrying domain label a_t "flow_out" of the security point
>>       with the domain label p_d_t?
>>    
>>          NO: Drop packet.
>>          YES: Replace the domain label a_t on the packet with the security point
>>               label p_d_t.
>>
>>    b. Before a packet is let out of the system:
>>
>>       Can a packet with domain label p_d_t "flow_out" into the network domain
>>       network_t?
>>
>>       NO: Drop packet.
>>       YES: Let packet out.
>>
>>       NOTE: Ideally this check should be applicable only to packets that
>>             didn't go thru [conn]secmark checks for outbound, but there's
>>             currently no way to know this due to implementation constrains.
>>             Hence a blanket check for ALL packets leaving the system.
>>
>>
>> FORWARDED TRAFFIC:
>>
>> Forwarded Traffic will undergo the following:
>>
>> 1. Step 1 under ON INBOUND.
>>
>> 2. Steps 2 and 3 under ON OUTBOUND.
>       NOTE: The iptables FORWARD chain is treated as an outbound chain
>             for flow control purposes. That means forwarded traffic would
>             need to be flow-controlled/labeled when it comes into the system
>             using an applicable rule in the PREROUTING chain, and flow-controlled
>             before it leaves the system using rules either in the FORWARD chain
>             or the POSTROUTING chain.
> 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
