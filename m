From: Paul Moore <paul.moore@hp.com>
To: Joy Latten <latten@austin.ibm.com>
Subject: Re: Questions regarding labeled ipsec/MAC networking
Date: Tue, 10 Jun 2008 11:39:56 -0400
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, tjaeger@cse.psu.edu,
        jmorris@namei.org, serue@us.ibm.com
References: <1213050632.31723.109.camel@faith.austin.ibm.com>
In-Reply-To: <1213050632.31723.109.camel@faith.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806101139.56262.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 09 June 2008 6:30:32 pm Joy Latten wrote:
> I am finishing up the internet-drafts for labeled ipsec. The ipsec
> RFCs have been updated and I have a question about how one of the new
> features in one of the updated rfcs should work with labeled ipsec or
> MAC networking in general.
>
> 1. rfc 4301 - IP Security Architecture introduces and describes a
> Populate From Packet (PFP) flag on page 23.
>
> When creating a new SA, the PFP flag is used to determine whether the
> value for the selector of the new SA will come from the packet that
> triggered the SA's creation or from the SPD entry. For example, the
> source address is a selector. An outbound packet finds an SPD entry,
> but no SA, so must create an SA. Currently, we take packet's source
> address and use this as source address when negotiating and creating
> new SA.
>
> However, according to rfc 4301, PFP flag can be set and then used to
> decide whether newly created SA's source address selector might come
> from the packet or from the SPD entry.
>
> My concern is that security context is described in draft as a
> selector, thus I need to consider PFP flag. Do we want PFP-flag
> capability for security context selector? For example, in current
> selinux policy, ipsec_spd_t:s0 is default SPD entry label.
> Let's say sshd triggers SA creation with sshd_t:s0. Currently, new SA
> will be created with sshd_t:s0. However, with PFP capability, new SA
> being created could have sshd_t:s0 or ipsec_spd_t:s0 depending on
> what PFP-flag is set to?

I agree with Stephen, I don't think we want to ever use a SPD security 
label as the SA's security label.  The security label of a SPD entry is 
used to signify a specific IPsec configuration (endpoints, 
transformations, ciphers, hmacs, etc.) where the security label of a SA 
is used to signify the sending subject's security label (SSH versus 
Firefox, SECRET versus TOP_SECRET, etc.).  This separation is really 
the one nice thing I see about labeled IPsec because it allows you to 
match a sending domain with a very specific IPsec configuration through 
SELinux policy which allows you to make statements like all Firefox 
traffic will be protected with ESP using AES-128 where all SSH traffic 
will be protected with AH using SHA1.

> 2. Security Gateways in MAC networking.
>
> In obsoleted rfc 2401 -IP Security Architecture, section 8.6
> described an MLS security gateway using IPsec as:
>
>   "a security gateway acting as an outbound proxy, creating SAs for
> MLS systems that originate packets forwarded by the gateway. These
> MLS systems may explicitly label the packets to be forwarded, or the
> whole originating network may have sensitivity characteristics
> associated with it. The security gateway MUST create and use
> appropriate SAs for AH, ESP or both, to protect such traffic it
> forwards.
>
>    Similarly such a gateway SHOULD accept and process inbound AH
> and/or ESP packets and forward appropriately, using explicit packet
> labeling, or relying on the sensitivity characteristics of the
> destination network."
>
> All mention of MLS networking as in rfc 2401 was left out in rfc
> 4301. So I want to reintroduce it as MAC networking instead.
>
> Do we want to consider labeled ipsec for security gateways in MAC
> networking?

Most definitely yes.

> 1. machines behind the security gateway that explicitly label the
>    packets (CIPSO). This is stated above.
>
>    In this case above text is still applicable.
>
> 2. The whole originating network has a security context associated
> with it. In this case, packets from machines behind the security
> gateway are not explicitly labeled. These machines send their packets
> to security security gateway to be forwarded. This incoming interface
> of the security gateway is labeled. All packets arriving on it (from
> machines behind the gateway) would be marked with this label. And
> that would be the label used to negotiate and create the SAs for the
> packets originating from behind the gateway.
>
>    Is this acceptable MAC networking for security gateways?

I think so, I know of several users who have multiple single label 
networks connected to a multiple label network via a security 
gateway/guard that handles the labeling/routing/multiplexing.  Just in 
cased you missed the discussion earlier this year, check the SELinux 
archives for the discussions around static/fallback labels (included 
for the first time in 2.6.25).  The static/fallback labels can be used 
to specify per-host, per-network, or per-interface security labels for 
unlabeled traffic.

As far as James' comments about assigning network peer security labels 
with greater granularity than a single host, we discussed this quite a 
bit in the static/fallback label threads; while it makes sense for 
things like SECMARK, it makes less sense when you are talking about 
unlabeled peers.  That said, I don't think a RFC specification needs to 
restrict implementation from assigning network peer labels however they 
see fit; I'm just not sure we would end up doing anything finer grained 
than a single address.

Hopefully you will send your early drafts to this list for review? :)

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
