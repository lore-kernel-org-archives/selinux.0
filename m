Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7PLIN5c014049
	for <selinux@tycho.nsa.gov>; Mon, 25 Aug 2008 17:18:33 -0400
Received: from e1.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7PLHa1L013773
	for <selinux@tycho.nsa.gov>; Mon, 25 Aug 2008 21:17:37 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7PLI4YA022054
	for <selinux@tycho.nsa.gov>; Mon, 25 Aug 2008 17:18:04 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m7PLI410219222
	for <selinux@tycho.nsa.gov>; Mon, 25 Aug 2008 17:18:04 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m7PLI3hu001045
	for <selinux@tycho.nsa.gov>; Mon, 25 Aug 2008 17:18:03 -0400
Date: Mon, 25 Aug 2008 15:46:39 -0500
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200808252046.m7PKkdQu019720@faith.austin.ibm.com>
To: paul.moore@hp.com
Subject: Re: [RFC 1/2] labeled ipsec internet drafts
Cc: gcwilson@us.ibm.com, selinux@tycho.nsa.gov, serue@us.ibm.com,
        tjaeger@cse.psu.edu
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I apologize for the delay in responding. Vacation and then
jury duty kinda got in the way. :-)

>>
>> 1. Introduction
>>
>>    Traditionally, security context referred to the security level and
>
>Should this be "security label" instead of "security context"?

Yes, will change.

>>    category used by Multilevel Security (MLS). This document will
>
> This should probably bet "category set" or something similar.

Ok.

>> refer to the security level and category as the security
>> classification.
>
>Do you mean "MLS security classification"?  That "MLS" qualifier helps
>make it a bit more concrete and appears to match how you actually use
>it in the document.

Yes! That is much better.

>>
>>    Current security mechanisms, such as SELinux, use the security
>>    classification and additional security attributes to form their
>>    security context. For example, a type for type enforcement.
>>
>>    Techniques such as IP Security Options (IPSO) allow IP datagrams
>> to be labeled with an MLS security classification [RFC1108]. This
>> ensured the same security applied to local objects and resources was
>> utilized when communicating over the network with homogenous systems.
>
>I think you should either remove the "homogeneous" qualifier or change 
>it to heterogeneous.  We've seen both different MLS implementations as 
>well as MLS/Type-Enforcement implementations interoperate using IP 
>options; granted it was with CIPSO and not RFC1108 but they are similar 
>enough for this level of discussion.

What I meant was that the systems must be operating within same DOI. 
I will change this sentence to better state this fact.

>> However, these techniques cannot pass along the additional security
>> attributes used in current security mechanisms.
>
>This is an intersting point and the following argument may be a bit 
>contentious, but arguably you could encode random security contexts 
>into a traditional MLS security context; Smack is a shining example of 
>this as it encodes the generic Smack label into a CIPSO permissive 
>bitmap tag.  It may violate the spirit of the CIPSO specification but 
>it is valid and provides a strong counterexample.
>
>Further, the FIPS-188 specification, while not an IETF specification, 
>does provide for a "freeform" IP option which is intended to support 
>arbitrary security attributes.

Yes, I agree, FIPS-188 free form tags would help accomplish this.
What I should state here is that the data, including the label
isn't protected nor or the bindings between the data and the label.

>>
>>        - doi (1 octet) - The first octet contains the security
>> label's domain of interpretation.
>>
>>          The domain of interpretation can be viewed as a group of
>>          systems that agree on the meaning of particular values
>> within the security label of a security mechanism.
>>
>>          The value of 1 is reserved as the default.
>>
>>          Reserved       0
>>          Default        1
>>
>>        - algorithm (1 octet) - The second octet contains the security
>>          label's algorithm.
>>
>>
>>
>>
>> Latten, et al.               Expires ?                          [Page
>> 3] 
>> Internet-Draft               IKEv1SecurityLabel                June
>> 2008
>>
>>
>>          The security label's algorithm specifies the security
>>          mechanism or context in which the label is applicable. For
>>          example, the security label is interpreted within the
>> SELinux context.
>>
>>          Requests for assignment of additional algorithms should be
>>          addressed to the Internet Assigned Numbers Authority (IANA).
>>
>>          Reserved       0
>>          SELinux        1
>>          Smack          2
>>          Private Use    120-128
>
>Is one octet enough here?  I honestly don't have a good idea as to how 
>much is enough, so a little justification of your choice (even if it 
>only lives in email, not in the spec) would be welcome.

I used one octet here because it is defined as one octet in the kernel's
sec_ctx structure. Originally, I think we used one octect for each
to keep within a 64-bit alignment requirement for pfkey. We thought
one octet would be enough...

>I'm also concerned with the implied convention of assigning one value to 
>a particular implementation.  In the SELinux case, how do you deal with 
>a non-MLS/MCS policy such as Gentoo/Ubuntu talking to a MLS/MCS policy 
>such as Fedora/RHEL?  What about policies with different types?  
>Differing numbers of MLS sensitivity levels or categories?
>

Hmm... not sure I understand so I may not answer this correctly...

The algorithm indicates the security mechanism.
In a way, it identifies the syntax/semantics of the 
security context to security mechanism, since security mechanisms 
may use different syntax/semantics for the security contexts. 
i.e. SELinux and SMACK.
The algorithm field in SELinux is used to "authorize" the security
context. In other words, SELinux only wants and understands
SELinux's security context syntax/semantics.
The "doi"  would be used for further differentiation within SELinux
domain. Far example, a sysadm wants to differentiate between SELinux
policy versions in his domain. He could used "doi" field to do this.

I suppose if you wanted two different security mechanisms to 
interoperate, a mapping of some sort would have to be created
between them. The security mechanisms would need
to indicate they accept (via the mapping) the other's
security context syntax/semantics. In other words, they would "authorize" 
the two different security contexts. It would do this via the 
"algorithm" and/or "doi" fields. I am thinking in this case, "doi" could
even indicate the mapping such as CIPSO's DOI does. 

I considered the information contained in the "algorithm" and 
"doi" fields required for interoperability, and the use
implementation specific.

If this doesn't answer your question, let me know. 

>>Also, can you explain the reason for having both a DOI and a algorithm 
>>field?  From an interoperability point of view, the node's security 
>>implementation is irrelevant as long as it agrees to abide by the rules 
>>and labels specified in the DOI.  I understand that currently a SELinux 
>>security label looks different from a traditional MLS/CMW security 
>>label, but there is no reason that a translation mechanism could not be 
>>implemented to provide a common network security label that could be 
>>understood and internalized by both types of systems.  While I'm not 
>>holding this up as a particularly good example in all cases, we do have 
>>something similar to this today in SELinux with how we handle the CIPSO 
>>protocol.

I hope the above explained it. In a way my above explanation
agrees with what you are saying here.

>>        - length (2 octets) - The third and fourth octets contain the
>>          string length of the security context.
>>
>>        - security label (1 or more octets) - The security label. The
>>          actual content will be dependent on the security algorithm
>>          that is specified. Within IKE context, this is regarded as
>>          an opaque bit string.
>
>I'm being picky here, but it might be better to say "opaque bit field" 
>just so we don't get into string encoding issues (is it UTF-8 or 
>something else?).

Ok, will do. 

regards,
Joy

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
