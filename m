From: Paul Moore <paul.moore@hp.com>
To: Joy Latten <latten@austin.ibm.com>
Subject: Re: [RFC 1/2] labeled ipsec internet drafts
Date: Thu, 28 Aug 2008 11:58:06 -0400
Cc: Casey Schaufler <casey@schaufler-ca.com>,
        "David P. Quigley" <dpquigl@tycho.nsa.gov>, gcwilson@us.ibm.com,
        selinux@tycho.nsa.gov, serue@us.ibm.com, tjaeger@cse.psu.edu
References: <200808252046.m7PKkdQu019720@faith.austin.ibm.com> <1219882937.2883.256.camel@faith.austin.ibm.com> <48B5FFD3.4050901@schaufler-ca.com>
In-Reply-To: <48B5FFD3.4050901@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808281158.06718.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 27 August 2008 9:30:59 pm Casey Schaufler wrote:
> Joy Latten wrote:
> > On Wed, 2008-08-27 at 17:56 -0400, Paul Moore wrote:
> >> On Wednesday 27 August 2008 5:21:17 pm David P. Quigley wrote:
> >>> I would like Paul to give his opinion on this as well but I think
> >>> the best thing at the moment would be go submit your draft where
> >>> the DOI is a tuple of (mechanism,doi). I personally like the idea
> >>> of representing the 32 bit value as a series of four octets for
> >>> human readable purposes but your idea does have some merit with
> >>> regards to what information should be stored with these numbers
> >>> by IANA. By having your draft out there recommending your method
> >>> of handling DOIs it gives people one more thing to consider for
> >>> discussion during the BOF.
> >>
> >> Our emails may have crossed in flight, but just in case it isn't
> >> clear from the response I sent earlier this afternoon I think we
> >> are best served with the DOI as a unified 32 bit value (the dotted
> >> notation is just for display/readability purposes).
> >
> > Ok, just for my clarification, the consensus is that I change this
> > to a 32 bit value field and keep it generic for now as in labeled
> > nfs doc?
> >
> >> I would encourage us to stop thinking about specific DOI values
> >> as "SELinux", "Smack", or whatever.  There is no reason we can't
> >> get the different labeled security implementation to work together
> >> but if we continue to propagate the notion of implementation
> >> specific DOIs then it becomes that much harder.  I think we need
> >> to think of DOIs as defining a mapping between an on-the-wire
> >> label format to a semantic meaning; the actual format of the wire
> >> label isn't important, the meaning of the label is what really
> >> counts.  Once we understand what a wire formatted label means we
> >> can internalize it however we need to so that the implementation
> >> can do the necessary access control.
> >
> > Ok, yep. The label should be an "opaque" (I might be over-using
> > that word by now) blob to the IPsec protocol. I guess in my
> > thinking, it just acts as label storage for the packet and the
> > security mechanism.
> >
> > I guess my concern is this, and it may be because I am not
> > understanding something. My concern is defining DOI as a mapping
> > between an on-the-wire label format to a semantic meaning. Could
> > the mapping be NULL or bypassed sometimes? What I mean is that
> > IPsec could sometimes store things just as they are represented by
> > the security mechanism since it doesn't put anything on the wire.
> > So if both endpoints are using SELinux, it would not need a
> > mapping.
>
> Well ...

You can think of SELinux today as having a single, implicit DOI (this is 
a bit of a simplification and doesn't address all of the issues but 
just go with it for now :)) and if two SELinux systems are talking to 
each other the required cross-DOI translation becomes a NULL-op.  If 
you look at a SELinux system talking to a TSOL system the cross-DOI 
translation is not a NULL-op because you need to translate between 
DTE/MLS (SELinux) and just MLS (TSOL).

> > It would need a mapping when
> > the endpoints' security mechanisms are different.
>
> Which it may be if the policies on the two systems don't mesh.
> For example, if one system has no apache it needs no apache_t,
> hence a mapping is required to deal with that. In fact, two
> SELinux systems will obviously require mapping if you're sending
> sids in your opaque label and most likely require mapping even
> if the label is the context unless the machines have identical
> installations and policies.

Bingo, this is the stuff that I ignored in the discussion above, there 
is also the MLS/MCS policy versus strict DTE policy which also needs to 
be addressed.

> > Thus why labeled ipsec
> > was bent on a (securitymechanism,doi) tuple. Would it be possible
> > for the new DOI scheme to also take this into consideration?
>
> For the cases where securitymechanism is sufficient to describe
> the structure to which a DOI is applied its specification is
> useful. A securitymechanism of SELinux would need to discriminate
> between MLS, MCS, and none of the above. This is a problem with
> any flexible scheme, Smack has it worse than SELinux because there
> is no way to even hint at a structure to the label.
>
> Does even a DOI make sense in a case where the two ends have
> irreconcilable policies? Can you get away with anything less
> than label mappings maintained on each host?

You need a DOI just to understand how to define/interpret the label.  
However, a system should be able to decide which DOIs it wants to 
support and further which cross-DOI translations it can perform ... and 
no, I don't think you need to be able to map every supported DOI to 
every other DOI.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
