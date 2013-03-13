Message-ID: <514080E7.8020602@tycho.nsa.gov>
Date: Wed, 13 Mar 2013 09:36:39 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: "Langland, Blake" <blangland@integrity-apps.com>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: SELinux network labeling
References: <DA8D339A60101247B36E202899B1C93A7C9378@CHUNEX01.integrity-apps.com>
In-Reply-To: <DA8D339A60101247B36E202899B1C93A7C9378@CHUNEX01.integrity-apps.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/12/2013 04:55 PM, Langland, Blake wrote:
> Hello,
>
> I am trying to set up a system using SELinux system that needs to have
> certain network traffic blocked based on the MLS label. Basically, there
> are two machines running SELinux (call them A and B). Both machines have
> two processes, say A1 and B1 are at sensitivity s0, and A2 and B2 are at
> s1. I want to let process A1 talk to B1, and A2 talk to B2, but block
> A1->B2, and A2->B1. Without using labeled IPsec, what systems for
> network labeling should I use? With the Netlabel fallback labels I am
> not able to specify the port. I currently am setting the label via
> secmark based on the source, destination, and port, and then running
> each process at the appropriate level, and also have the port labeled at
> the appropriate level. This is not blocking the traffic I want it to.
>
> I have been reading Paul Moore’s blogs about Secmark and network
> labeling and am a little bit confused about packet vs. peer labeling.
> Are both packet and peer labeling required? If both are, am I out of
> luck since Netlabel can not specify a port? If only packet labeling is
> required, what is causing the scheme explained above to not block traffic?

secmark/packet labeling: labels based on packet attributes that are only 
passed around locally within the network stack for local access control, 
similar to iptables rules.

netlabel or labeled ipsec / peer labeling: labels derived from sender 
security context that are propagated across the network with the packet 
and can be used on the remote end for end-to-end access control.

netlabel vs labeled ipsec:  netlabel only supports passing MLS labels 
via CIPSO, no user:role:type preservation.  labeled ipsec supports 
passing the entire security context, including user:role:type.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
