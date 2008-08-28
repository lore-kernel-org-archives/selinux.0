From: Paul Moore <paul.moore@hp.com>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
Subject: Re: [RFC 1/2] labeled ipsec internet drafts
Date: Thu, 28 Aug 2008 11:49:05 -0400
Cc: Joy Latten <latten@austin.ibm.com>, gcwilson@us.ibm.com,
        selinux@tycho.nsa.gov, serue@us.ibm.com, tjaeger@cse.psu.edu
References: <200808252046.m7PKkdQu019720@faith.austin.ibm.com> <200808271756.22660.paul.moore@hp.com> <1219874419.2627.116.camel@moss-terrapins.epoch.ncsc.mil>
In-Reply-To: <1219874419.2627.116.camel@moss-terrapins.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808281149.05547.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 27 August 2008 6:00:19 pm David P. Quigley wrote:
> On Wed, 2008-08-27 at 17:56 -0400, Paul Moore wrote:
> > I would encourage us to stop thinking about specific DOI values
> > as "SELinux", "Smack", or whatever.  There is no reason we can't
> > get the different labeled security implementation to work together
> > but if we continue to propagate the notion of implementation
> > specific DOIs then it becomes that much harder.  I think we need to
> > think of DOIs as defining a mapping between an on-the-wire label
> > format to a semantic meaning; the actual format of the wire label
> > isn't important, the meaning of the label is what really counts. 
> > Once we understand what a wire formatted label means we can
> > internalize it however we need to so that the implementation can do
> > the necessary access control.
>
> Once again agreed. The issue with this though is that this
> generalized on the wire label is a very difficult thing to come up
> with. Especially since you really want to express concepts such as
> this webserver can only serve public data. That is the kind of high
> level semantic you would want to specify and then have the endpoints
> decide what that means. For MLS this might translate into a category
> for SELinux this might translate into a specific type. This is by no
> means an easy problem.

I never said it would be easy, I just think it is something we should 
strive for :)

> > Once again, think of how we handle the MLS-only CIPSO labels today;
> > it is a simplified example but it demonstrates the basic concept of
> > internalizing implementation agnostic security labels and the
> > interoperability benefits that result.
>
> You might have to explain this to me. The issue you raise in the
> paragraph above deals with talking in terms of mechanisms not
> necessarily implementations. The issue with CIPSO is that it is only
> one mechanism which allows them to define their labels in an
> implementation agnostic manner since everyone has agreed on the
> mechanism. This is a little harder when you're spanning mechanisms
> unless we use something similar to what I describe above.

The reason I brought up CIPSO was just to highlight how an 
implementation agnostic on-the-wire security label could be 
internalized by a specific security/MAC implementation so that useful 
access control could be done.  It is just one example, and a painfully 
simple one at that, but it demonstrates the basic concept and showcases 
some of the benefits (and pitfalls).

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
