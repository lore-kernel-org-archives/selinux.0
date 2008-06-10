Subject: Re: Questions regarding labeled ipsec/MAC networking
From: Joy Latten <latten@austin.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, paul.moore@hp.com, tjaeger@cse.psu.edu,
        jmorris@namei.org, serue@us.ibm.com,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        Chad Hanson <chanson@TrustedCS.com>
In-Reply-To: <1213100787.30576.92.camel@moss-spartans.epoch.ncsc.mil>
References: <1213050632.31723.109.camel@faith.austin.ibm.com>
	 <1213100787.30576.92.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 10 Jun 2008 12:24:09 -0500
Message-Id: <1213118649.31723.136.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-06-10 at 08:26 -0400, Stephen Smalley wrote:
> 
> I don't think we want to support taking the label from the SPD entry; or
> if we did, I think it would be a separate label from the normal SPD
> label - one specifically dedicated to being applied to SAs.
> 
Ok, yes, makes sense because SPD entry's label is for a different
purpose. 

> > I have another question:
> > 
> > 2. Security Gateways in MAC networking.
> > 
> > In obsoleted rfc 2401 -IP Security Architecture, section 8.6 described 
> > an MLS security gateway using IPsec as:
> >  
> >   "a security gateway acting as an outbound proxy, creating SAs for MLS
> >    systems that originate packets forwarded by the gateway. These MLS
> >    systems may explicitly label the packets to be forwarded, or the
> >    whole originating network may have sensitivity characteristics
> >    associated with it. The security gateway MUST create and use
> >    appropriate SAs for AH, ESP or both, to protect such traffic it
> >    forwards.
> > 
> >    Similarly such a gateway SHOULD accept and process inbound AH and/or
> >    ESP packets and forward appropriately, using explicit packet
> >    labeling, or relying on the sensitivity characteristics of the
> >    destination network."
> > 
> > All mention of MLS networking as in rfc 2401 was left out in rfc 4301. 
> > So I want to reintroduce it as MAC networking instead. 
> > 
> > Do we want to consider labeled ipsec for security gateways in MAC
> > networking? There would be 2 cases that I can think of.
> 
> Yes.
> 
> >  
> > 1. machines behind the security gateway that explicitly label the
> >    packets (CIPSO). This is stated above. 
> >     
> >    In this case above text is still applicable. 
> >  
> > 2. The whole originating network has a security context associated with
> >    it. In this case, packets from machines behind the security gateway
> >    are not explicitly labeled. These machines send their packets to
> >    security security gateway to be forwarded. This incoming interface of
> >    the security gateway is labeled. All packets arriving on it (from
> >    machines behind the gateway) would be marked with this label. And
> >    that would be the label used to negotiate and create the SAs for the
> >    packets originating from behind the gateway.
> > 
> >    Is this acceptable MAC networking for security gateways?
> 
> There are likely other scenarios as well, e.g. using the source IP as a
> selector, etc.
> 
> There is also the issue of outer vs. inner label in the Sun labeled
> IPSEC design, but I'm not certain we want to support that.
> 
I am not familiar with outer vs inner label in the Sun's design. 
I will look it up so I can better understand.

Thanks!!

regards,
Joy 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
