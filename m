Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7RMISh8006076
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2008 18:18:28 -0400
Subject: Re: [RFC 1/2] labeled ipsec internet drafts
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: Joy Latten <latten@austin.ibm.com>, gcwilson@us.ibm.com,
        selinux@tycho.nsa.gov, serue@us.ibm.com, tjaeger@cse.psu.edu
In-Reply-To: <200808271756.22660.paul.moore@hp.com>
References: <200808252046.m7PKkdQu019720@faith.austin.ibm.com>
	 <1219862508.2883.146.camel@faith.austin.ibm.com>
	 <1219872077.2627.95.camel@moss-terrapins.epoch.ncsc.mil>
	 <200808271756.22660.paul.moore@hp.com>
Content-Type: text/plain
Date: Wed, 27 Aug 2008 18:00:19 -0400
Message-Id: <1219874419.2627.116.camel@moss-terrapins.epoch.ncsc.mil>
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

I completely agree.

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

Once again agreed. The issue with this though is that this generalized
on the wire label is a very difficult thing to come up with. Especially
since you really want to express concepts such as this webserver can
only serve public data. That is the kind of high level semantic you
would want to specify and then have the endpoints decide what that
means. For MLS this might translate into a category for SELinux this
might translate into a specific type. This is by no means an easy
problem. 


> 
> Once again, think of how we handle the MLS-only CIPSO labels today; it 
> is a simplified example but it demonstrates the basic concept of 
> internalizing implementation agnostic security labels and the 
> interoperability benefits that result.
> 

You might have to explain this to me. The issue you raise in the
paragraph above deals with talking in terms of mechanisms not
necessarily implementations. The issue with CIPSO is that it is only one
mechanism which allows them to define their labels in an implementation
agnostic manner since everyone has agreed on the mechanism. This is a
little harder when you're spanning mechanisms unless we use something
similar to what I describe above.

Dave


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
