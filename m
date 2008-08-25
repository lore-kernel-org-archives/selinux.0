Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7PLPatv015219
	for <selinux@tycho.nsa.gov>; Mon, 25 Aug 2008 17:25:46 -0400
Received: from e2.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7PLP71L015546
	for <selinux@tycho.nsa.gov>; Mon, 25 Aug 2008 21:25:07 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7PLPY6T016634
	for <selinux@tycho.nsa.gov>; Mon, 25 Aug 2008 17:25:34 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m7PLPX3p106740
	for <selinux@tycho.nsa.gov>; Mon, 25 Aug 2008 15:25:33 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m7PLPU3D006742
	for <selinux@tycho.nsa.gov>; Mon, 25 Aug 2008 15:25:33 -0600
Date: Mon, 25 Aug 2008 15:54:06 -0500
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200808252054.m7PKs6sV019747@faith.austin.ibm.com>
To: paul.moore@hp.com
Subject: Re: [RFC 2/2] labeled ipsec internet drafts
Cc: gcwilson@us.ibm.com, selinux@tycho.nsa.gov, serue@us.ibm.com,
        tjaeger@cse.psu.edu
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Again, my apologies for the delay in responding.

>>    MAC systems have become more mainstream and is no longer just
>>    associated with MLS. Within a strictly hierarchical system such as
>>    MLS, often there are tasks that need to be exempt from the MLS
>>    policy, thus leaving them exposed. However, methods such as Type
>>    Enforcement (TE) are not hierarchical and allow precise rules to
>
>I would recommend avoiding the "TE" acronym as many in the IETF already 
>associate TE with Traffic Engineering.  If you don't mind calling it 
>Domain Type Enforcement you can probably get away with "DTE".

Ok, Good point. Will change. 

>>    IPsec mechanisms can support labeled networking whether implicit
>> or explicit labels are being used.
>>
>>    Explicit labeling refers to transmitting the security context in
>> the IP datagram, such as in IPSO. When explicit labeling is used the
>> encryption and authentication services provided in IPsec can be used
>> to authenticate the bindings between the security label in the IP
>> header and payload and provide confidentiality [RFC2401].
>>
>>    In an implicit labeling scheme, the security context is not
>>    transmitted as part of the IP datagram. IPsec provides implicit
>>    labeling in that the security context is part of the IPsec
>> Security Association and not transmitted with each packet.
>>
>> 3.1 Relationship Between a Security Association and Security Label
>>
>>    In MAC networking, the traffic between two systems may require
>>    several different security contexts. For example, ftp and a mail
>>    program may each label their data with a different security
>> context. Recall that SAs exist in pairs, one for inbound and one for
>> outbound.
>
>It has been may years since my last in-depth reading the IPsec drafts, 
>and most of them have been outdated anyway, but from what I remember 
>there was no explicit requirement that SAs be created in pairs 
>(inbound/outbound).  While this is certainly the common case for 
>connection based protocols such as TCP, there is no bi-directional 
>requirement for most connectionless protocols such as UDP.

IPsec architecture rfc 4301 is explicit about creating SA pairs.
See section 4.1 in particular.

The IKEv2, rfc 4306 is also explicit in describing that ESP and AH
SAs always exist in pairs.  See Section 1.4 in particular.

>> Each instance of a security label will require an SA pair. 
>
>Question for you ... using the current SELinux implementation as a 
>reference, when firefox makes a request to an apache server over 
>labeled IPsec, what are the resulting SAs?  I would think that a 
>firefox_t SA is created to convey the request from firefox to apache 
>and an apache_t SA is created to convery the response from apache to 
>firefox.  Is that the case?
>
>If so, each instance of a security label only requires a single SA.
>

I have not tried this. (May try later to verify.) But my guess
based on how things work, will be an SA pair for both.
If firefox on local initiates the request, the local kernel will 
send an ACQUIRE for firefox_t. IKE will establish an SA pair with
firefox_t and first packet sent out will be for firefox_t.
When remote's apache prepares response,  IP/IPsec layer
will see apache_t and that it doesn't have an SA for apache_t.
It will request that IKE establish an SA pair
for apache_t. Once the SA pair is established, remote will send
response. 

You could manually install an SA pair with different contexts,
for example, inbound SA has apache_t and outbound has firefox_t.
But that is because you know ahead of time what the security contexts
will be for inbound and outbound on the traffic stream.
IKE would not know that info. And when the kernel sends the ACQUIRE to 
IKE, the kernel does not know that the response will be from 
apache_t either.  

>> Thus traffic between two systems may have several SA pairs with
>> identical selectors except for the security context. If using a
>> combination of

>Considering both connectionless protocols and the above example, always 
>requiring two SAs for each label seems wasteful.

Yes, perhaps. 

>> 3.2 Security Context Selector
>>
>>    [RFC4301] describes the Security Policy Database (SPD), and the
>>    Security Association Database (SAD) and corresponding selectors.
>>
>>    MAC networking introduces an additional selector, the Security
>>    Context selector. This selector is only required when MAC
>>    networking is deployed.
>>
>>         - Security Context: MAC implementation's security context.
>>           The security context can be an IPSO/CIPSO label when
>>           IPsec is used to support explicit labels.
>
>What happens in the case of traffic that is already explicitly labeled?  
>Does the IPsec subsystem also apply an implicit IPsec label?  If so, is 
>it derived from the explicit label?  What happens if the explicit label 
>has a different DOI than what is configured in the SPD/SAD: 
>translation, rejection, something else?
>

Sorry, I think I must have been sleeping when I wrote that sentence.
Will remove it.  As stated earlier in the doc in "Section 3. Labeled 
Networking", when explicit labeling is used, IPsec's encryption and 
authentication services can be used to secure the data and bindings.

>>    Recall, in MAC networking, multiple SAs may exist between two
>>    systems differing only in their security labels. The Security
>> Context selector ensures that the appropriate SA pair is used to
>> secure a particular communication.
>
>Just to clarify, this selector is only applied to outbound traffic, yes?  
>The SPI and/or other network attributes still acts as the SA selector 
>for inbound traffic, yes?

Yes. 

>>    The Security Context selector within the SPD allows the system
>>    administrator to specify which traffic streams will be authorized
>>    to communicate within the system's MAC policy. It also specifies
>>    which traffic streams will have labeled communications and which
>>    will not.
>
>This last sentence should be modified to make it clear that the SPD/SAD 
>configuration only controls the use of implicit IPsec based labeling, 
>unless you are talking about a departure from the current SELinux 
>implementation.

Ok, will make it more clear.

>> 3.4 Outbound Processing for MAC Networking
>>
>>    When consulting the SPD for an outbound policy, the data's
>> security label is used to determine if it is authorized to access the
>> particular SPD entry and use its configuration information for
>> sending. This adds the additional check in that the outbound packet
>> will not generate an SA pair that the policy entry does not allow. So
>> for example, in an MLS implementation, a high secrecy process cannot
>> generate an SA allowing it to send data to a low secrecy process.
>
>The recent trend in the IETF, especially around security, is to leave 
>nothing to chance; ambiguity in the specifications tend to be frowned 
>upon.  I think there needs to be a more in-depth discussion of how 
>security enforcement MUST (I use this in the RFC sense of the word) 
>operate.  Of course this will be a bit tricky considering the flexible 
>and arbitrary nature of type enforcement, but I think it is important 
>if you hope to have a consistent labeled IPsec implementation across 
>multiple platforms.
>
>This applies to all of the traffic processing and enforcement sections 
>of this document.

Yes, I agree, this is important. 
However, it also wasn't my intention to define or describe
MAC networking in depth. Just what IPSec needs to use it...

For processing and enforcement, I took from what was in rfc 2401, 
section 8 about MLS networking and what we did for the Linux MAC-xfrm
implementation. Let me know if this is sufficient enough for
interoperability...

>>    Similarly, when consulting the SAD to find an outbound SA, the
>>    the data's security context is used to select the appropriate SA
>> to send on.
>>
>>    In the case that a suitable outbound policy is found, but there
>> isn't an SA, the message sent to the key management system to create
>> an SA MUST contain the security label associated with the data. This
>> allows for the key manager to create an SA pair with the correct
>> security label for the data to be transmitted.
>>
>>    A MAC implementation MAY label it's interface and/or configured IP
>>    address. If so, before forwarding the packet out to its
>> destination, a check should be made that the outbound packet is
>> authorized to send out on the interface and/or configured ip address
>> [RFC2401].
>
>Which IP address are you referring to, the source or destination?  Also, 
>in the case of ESP tunnel mode, should the outer or inner IP header (or 
>both) be checked?

The check I am referring to is the security contexts... is the packet's 
security context allowed by the interface's security context.

I was trying to incorporate some of the MLS checks described in rfc 2401,
section 8.2, but perhaps could do a better job of it. Will provide
a better description here.

>>
>>    the inbound and outbound processing mentioned above as well as
>> some additional processing particular to the intermediate protection
>> of packets in a MAC environment [RFC2401].
>>
>>    A security gateway enforcing MAC MUST create and use appropriate
>>    SAs to protect packets that it forwards for systems behind it.
>>    [RFC2401] The systems behind the security gateway may or may not
>> be using MAC. The gateway SHOULD utilize various attributes of the
>> traffic and/or existing labels to determine the security labels for
>> the SAs to be created and applied.
>>
>>    Similarly, such a gateway SHOULD accept and process inbound AH
>>    and/or ESP packets and forward appropriately, utilizing various
>>    attributes of the traffic and/or existing labels [RFC2401].
>
>More explanation needed around how security policy is applied to traffic 
>flowing through the gateway as well as how labeling is applied or 
>removed based on network configuration.  This is way too vague for 
>consistent implementations.

Will describe better. However, it was my intention to be general 
about how labeling is applied. 
Shouldn't it  be up to the MAC implementation what traffic attributes 
and/or existing labels to use to determine the security label?
I don't think that is in IPsec's scope.

>>
>> 4.1 Attribute Negotiation
>>
>>    The description of attribute negotiation in [RFC4306] is
>> applicable also when using security contexts. In addition, only one
>> security context transform (Type 6) is allowed per protocol. And if
>> the initiator sends multiple proposals when negotiating an SA, each
>> proposal MUST contain the same transform type and security context.
>> In other words, a single SA negotiation should contain only one
>> security context.
>
>More detail about how to handle the negotiation would be an improvement, 
>similar to my enforcement concerns.

There honestly isn't really much to say here. The security contexts
are "communicated" rather than "negotiated". In other words, 
the sender sends over a security context and the responder accepts
the security context. If an SA proposal is not accepted by the 
responder it won't be because of the security context. 
Which is why there is not much to say here.
I will add to above description that security context is
communicated. But otherwise, all processing and negotiating
occurs as described in rfc 4306. Nothing is new or different.


Thanks!

regards,
Joy

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
