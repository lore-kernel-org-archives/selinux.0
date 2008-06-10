Subject: Re: Questions regarding labeled ipsec/MAC networking
From: Joy Latten <latten@austin.ibm.com>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, paul.moore@hp.com,
        tjaeger@cse.psu.edu, serue@us.ibm.com
In-Reply-To: <Xine.LNX.4.64.0806100940130.25308@us.intercode.com.au>
References: <1213050632.31723.109.camel@faith.austin.ibm.com>
	 <Xine.LNX.4.64.0806100940130.25308@us.intercode.com.au>
Content-Type: text/plain
Date: Tue, 10 Jun 2008 11:09:06 -0500
Message-Id: <1213114146.31723.132.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-06-10 at 09:51 +1000, James Morris wrote:
> On Mon, 9 Jun 2008, Joy Latten wrote:
> 
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
> I don't think we should be specifying that this is the only possible model 
> for classifying packets and applying labels.  Any number of attributes can 
> be used for packet classification (ports, addresses, protocols etc.), and 
> labels applied to SAs does not have to be directly related to local label.
> 
> There may also be finer graine external labeling than "whole network", so 
> I think that needs to be generalized, too.  e.g.  something like, the 
> gateway MAY utilize various attributes of the traffic and existing 
> security labels to determine labels for SAs to be applied.

Ah, ok, I like your generalization. So, in other words, labeled ipsec
can be applied in security gateway, but leave it up to implementation to
determine how to label the traffic from the machines behind the security
gateway that may not be enforcing MAC and/or how to derive label for
SA. 

Thanks!!

regards,
Joy

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
