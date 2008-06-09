Date: Tue, 10 Jun 2008 09:51:23 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Joy Latten <latten@austin.ibm.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, paul.moore@hp.com,
        tjaeger@cse.psu.edu, serue@us.ibm.com
Subject: Re: Questions regarding labeled ipsec/MAC networking
In-Reply-To: <1213050632.31723.109.camel@faith.austin.ibm.com>
Message-ID: <Xine.LNX.4.64.0806100940130.25308@us.intercode.com.au>
References: <1213050632.31723.109.camel@faith.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 9 Jun 2008, Joy Latten wrote:

> 2. The whole originating network has a security context associated with
>    it. In this case, packets from machines behind the security gateway
>    are not explicitly labeled. These machines send their packets to
>    security security gateway to be forwarded. This incoming interface of
>    the security gateway is labeled. All packets arriving on it (from
>    machines behind the gateway) would be marked with this label. And
>    that would be the label used to negotiate and create the SAs for the
>    packets originating from behind the gateway.
> 
>    Is this acceptable MAC networking for security gateways?

I don't think we should be specifying that this is the only possible model 
for classifying packets and applying labels.  Any number of attributes can 
be used for packet classification (ports, addresses, protocols etc.), and 
labels applied to SAs does not have to be directly related to local label.

There may also be finer graine external labeling than "whole network", so 
I think that needs to be generalized, too.  e.g.  something like, the 
gateway MAY utilize various attributes of the traffic and existing 
security labels to determine labels for SAs to be applied.

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
