From: Paul Moore <paul.moore@hp.com>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
Subject: Re: [RFC 1/2] labeled ipsec internet drafts
Date: Wed, 27 Aug 2008 17:56:22 -0400
Cc: Joy Latten <latten@austin.ibm.com>, gcwilson@us.ibm.com,
        selinux@tycho.nsa.gov, serue@us.ibm.com, tjaeger@cse.psu.edu
References: <200808252046.m7PKkdQu019720@faith.austin.ibm.com> <1219862508.2883.146.camel@faith.austin.ibm.com> <1219872077.2627.95.camel@moss-terrapins.epoch.ncsc.mil>
In-Reply-To: <1219872077.2627.95.camel@moss-terrapins.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808271756.22660.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 27 August 2008 5:21:17 pm David P. Quigley wrote:
> I would like Paul to give his opinion on this as well but I think the
> best thing at the moment would be go submit your draft where the DOI
> is a tuple of (mechanism,doi). I personally like the idea of
> representing the 32 bit value as a series of four octets for human
> readable purposes but your idea does have some merit with regards to
> what information should be stored with these numbers by IANA. By
> having your draft out there recommending your method of handling DOIs
> it gives people one more thing to consider for discussion during the
> BOF.

Our emails may have crossed in flight, but just in case it isn't clear 
from the response I sent earlier this afternoon I think we are best 
served with the DOI as a unified 32 bit value (the dotted notation is 
just for display/readability purposes).

I would encourage us to stop thinking about specific DOI values 
as "SELinux", "Smack", or whatever.  There is no reason we can't get 
the different labeled security implementation to work together but if 
we continue to propagate the notion of implementation specific DOIs 
then it becomes that much harder.  I think we need to think of DOIs as 
defining a mapping between an on-the-wire label format to a semantic 
meaning; the actual format of the wire label isn't important, the 
meaning of the label is what really counts.  Once we understand what a 
wire formatted label means we can internalize it however we need to so 
that the implementation can do the necessary access control.

Once again, think of how we handle the MLS-only CIPSO labels today; it 
is a simplified example but it demonstrates the basic concept of 
internalizing implementation agnostic security labels and the 
interoperability benefits that result.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
