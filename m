Subject: Questions regarding labeled ipsec/MAC networking
From: Joy Latten <latten@austin.ibm.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, paul.moore@hp.com, tjaeger@cse.psu.edu,
        jmorris@namei.org, serue@us.ibm.com
Content-Type: text/plain
Date: Mon, 09 Jun 2008 17:30:32 -0500
Message-Id: <1213050632.31723.109.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am finishing up the internet-drafts for labeled ipsec. The ipsec RFCs
have been updated and I have a question about how one of the new
features in one of the updated rfcs should work with labeled ipsec
or MAC networking in general.

1. rfc 4301 - IP Security Architecture introduces and describes a
Populate From Packet (PFP) flag on page 23. 

When creating a new SA, the PFP flag is used to determine whether the
value for the selector of the new SA will come from the packet that
triggered the SA's creation or from the SPD entry. For example, the
source address is a selector. An outbound packet finds an SPD entry, but
no SA, so must create an SA. Currently, we take packet's source address
and use this as source address when negotiating and creating new SA. 

However, according to rfc 4301, PFP flag can be set and then used to
decide whether newly created SA's source address selector might come
from the packet or from the SPD entry.

My concern is that security context is described in draft as a selector,
thus I need to consider PFP flag. Do we want PFP-flag capability for
security context selector? For example, in current selinux policy,
ipsec_spd_t:s0 is default SPD entry label. 
Let's say sshd triggers SA creation with sshd_t:s0. Currently, new SA
will be created with sshd_t:s0. However, with PFP capability, new SA
being created could have sshd_t:s0 or ipsec_spd_t:s0 depending on what
PFP-flag is set to? 

In the example, to create the SA with ipsec_spd_t seems like a relabel
to me. Do we want this to ever happen? At first I thought it could be
used to map data to certain labels, that is the label in the SPD
entry... but I don't know if this is a desired thing in MAC networking?
Do we want to disable using PFP flag for security context and always
take label from socket triggering SA creation as done currently?

I have another question:

2. Security Gateways in MAC networking.

In obsoleted rfc 2401 -IP Security Architecture, section 8.6 described 
an MLS security gateway using IPsec as:
 
  "a security gateway acting as an outbound proxy, creating SAs for MLS
   systems that originate packets forwarded by the gateway. These MLS
   systems may explicitly label the packets to be forwarded, or the
   whole originating network may have sensitivity characteristics
   associated with it. The security gateway MUST create and use
   appropriate SAs for AH, ESP or both, to protect such traffic it
   forwards.

   Similarly such a gateway SHOULD accept and process inbound AH and/or
   ESP packets and forward appropriately, using explicit packet
   labeling, or relying on the sensitivity characteristics of the
   destination network."

All mention of MLS networking as in rfc 2401 was left out in rfc 4301. 
So I want to reintroduce it as MAC networking instead. 

Do we want to consider labeled ipsec for security gateways in MAC
networking? There would be 2 cases that I can think of.
 
1. machines behind the security gateway that explicitly label the
   packets (CIPSO). This is stated above. 
    
   In this case above text is still applicable. 
 
2. The whole originating network has a security context associated with
   it. In this case, packets from machines behind the security gateway
   are not explicitly labeled. These machines send their packets to
   security security gateway to be forwarded. This incoming interface of
   the security gateway is labeled. All packets arriving on it (from
   machines behind the gateway) would be marked with this label. And
   that would be the label used to negotiate and create the SAs for the
   packets originating from behind the gateway.

   Is this acceptable MAC networking for security gateways?


Sorry, for the long email. I hope I have been clear, but if not, please
let me know.

Thanks!!

regards,
Joy




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
