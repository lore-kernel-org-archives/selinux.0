Subject: Re: [RFC 1/2] labeled ipsec internet drafts
From: Joy Latten <latten@austin.ibm.com>
To: Paul Moore <paul.moore@hp.com>
Cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>, gcwilson@us.ibm.com,
        selinux@tycho.nsa.gov, serue@us.ibm.com, tjaeger@cse.psu.edu
In-Reply-To: <200808271756.22660.paul.moore@hp.com>
References: <200808252046.m7PKkdQu019720@faith.austin.ibm.com>
	 <1219862508.2883.146.camel@faith.austin.ibm.com>
	 <1219872077.2627.95.camel@moss-terrapins.epoch.ncsc.mil>
	 <200808271756.22660.paul.moore@hp.com>
Content-Type: text/plain
Date: Wed, 27 Aug 2008 19:22:17 -0500
Message-Id: <1219882937.2883.256.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-08-27 at 17:56 -0400, Paul Moore wrote:
> On Wednesday 27 August 2008 5:21:17 pm David P. Quigley wrote:
> > I would like Paul to give his opinion on this as well but I think the
> > best thing at the moment would be go submit your draft where the DOI
> > is a tuple of (mechanism,doi). I personally like the idea of
> > representing the 32 bit value as a series of four octets for human
> > readable purposes but your idea does have some merit with regards to
> > what information should be stored with these numbers by IANA. By
> > having your draft out there recommending your method of handling DOIs
> > it gives people one more thing to consider for discussion during the
> > BOF.
> 
> Our emails may have crossed in flight, but just in case it isn't clear 
> from the response I sent earlier this afternoon I think we are best 
> served with the DOI as a unified 32 bit value (the dotted notation is 
> just for display/readability purposes).

Ok, just for my clarification, the consensus is that I change this to a
32 bit value field and keep it generic for now as in labeled nfs doc? 

> 
> I would encourage us to stop thinking about specific DOI values 
> as "SELinux", "Smack", or whatever.  There is no reason we can't get 
> the different labeled security implementation to work together but if 
> we continue to propagate the notion of implementation specific DOIs 
> then it becomes that much harder.  I think we need to think of DOIs as 
> defining a mapping between an on-the-wire label format to a semantic 
> meaning; the actual format of the wire label isn't important, the 
> meaning of the label is what really counts.  Once we understand what a 
> wire formatted label means we can internalize it however we need to so 
> that the implementation can do the necessary access control.
> 
Ok, yep. The label should be an "opaque" (I might be over-using that
word by now) blob to the IPsec protocol. I guess in my thinking, it just
acts as label storage for the packet and the security mechanism.
 
I guess my concern is this, and it may be because I am not understanding
something. My concern is defining DOI as a mapping between an
on-the-wire label format to a semantic meaning. Could the mapping be
NULL or bypassed sometimes? What I mean is that IPsec could sometimes
store things just as they are represented by the security mechanism
since it doesn't put anything on the wire. So if both endpoints are
using SELinux, it would not need a mapping. It would need a mapping when
the endpoints' security mechanisms are different. Thus why labeled ipsec
was bent on a (securitymechanism,doi) tuple. Would it be possible for
the new DOI scheme to also take this into consideration?   
 
regards,
Joy

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
