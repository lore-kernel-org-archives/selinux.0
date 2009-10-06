Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n96FwrDQ006841
	for <selinux@tycho.nsa.gov>; Tue, 6 Oct 2009 11:58:53 -0400
Received: from g5t0006.atlanta.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n96Fw3UT029663
	for <selinux@tycho.nsa.gov>; Tue, 6 Oct 2009 15:58:03 GMT
From: Paul Moore <paul.moore@hp.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: [refpolicy] [RFC PATCH v1] refpol: Add netif, node and peer constraints for MCS based policies
Date: Tue, 6 Oct 2009 11:58:49 -0400
Cc: refpolicy@oss1.tresys.com, js44352@gmail.com, selinux@tycho.nsa.gov
References: <20091001213527.16869.87442.stgit@flek.lan> <1254835214.17694.46.camel@gorn>
In-Reply-To: <1254835214.17694.46.camel@gorn>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <200910061158.49987.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 06 October 2009 09:20:11 am Christopher J. PeBenito wrote:
> On Thu, 2009-10-01 at 17:35 -0400, Paul Moore wrote:
> > Adapt the MLS netif, node and peer networking constraints for MCS.  This
> > patch preserves the basic structure of the MLS constraints and converts
> > them to use the MCS model which means the "(( l1 dom l2 ) and ( l1 domby
> > h2 ))" constraints are converted to "( h1 dom h2 )".
> 
> These need to be switched to MCS-specific attributes.

[Ooops, forgot to reply-all ...]

Sorry, I saw other MLS attributes being used in the MCS constraints file so I 
thought it was okay ... I'll resend soon.

> > Signed-of-by: Paul Moore <paul.moore@hp.com>
> > ---
> >
> >  policy/mcs |   36 ++++++++++++++++++++++++++++++++++++
> >  1 files changed, 36 insertions(+), 0 deletions(-)
> >
> > diff --git a/policy/mcs b/policy/mcs
> > index b8dc0d6..0759021 100644
> > --- a/policy/mcs
> > +++ b/policy/mcs
> > @@ -99,6 +99,42 @@ mlsconstrain process { sigkill sigstop }
> >  	(( h1 dom h2 ) or ( t1 == mcskillall ));
> >
> >  #
> > +# MCS policy for the network ingress/egress controls
> > +#
> > +
> > +# the netif ingress/egress ops, the ingress permission is a "write"
> > operation +# because the subject in this particular case is the remote
> > domain which is +# writing data out the network interface which is acting
> > as the object +mlsconstrain { netif } { ingress }
> > +	(( h1 dom h2 ) or ( t1 == mlsnetinbound ) or ( t1 == unlabeled_t ));
> > +mlsconstrain { netif } { egress }
> > +	(( h1 dom h2 ) or ( t1 == mlsnetoutbound ));
> > +
> > +# the node recvfrom/sendto ops, the recvfrom permission is a "write"
> > operation +# because the subject in this particular case is the remote
> > domain which is +# writing data out the network node which is acting as
> > the object +mlsconstrain { node } { recvfrom }
> > +	(( h1 dom h2 ) or ( t1 == mlsnetinbound ) or ( t1 == unlabeled_t ));
> > +mlsconstrain { node } { sendto }
> > +	(( h1 dom h2 ) or ( t1 == mlsnetoutbound ));
> > +
> > +# the forward ops, the forward_in permission is a "write" operation
> > because the +# subject in this particular case is the remote domain which
> > is writing data +# to the network with a secmark label, the object in
> > this case
> > +mlsconstrain { packet } { forward_in }
> > +	(( h1 dom h2 ) or ( t1 == mlsnetinbound ) or ( t1 == unlabeled_t ));
> > +mlsconstrain { packet } { forward_out }
> > +	(( h1 dom h2 ) or ( t1 == mlsnetoutbound ) or ( t1 == unlabeled_t ));
> > +
> > +#
> > +# MCS policy for the secmark and peer controls
> > +#
> > +
> > +# the peer/packet recv op
> > +mlsconstrain { peer packet } { recv }
> > +	(( h1 dom h2 ) or ( t1 == mlsnetread ));
> > +
> > +#
> >  # MCS policy for SELinux-enabled databases
> >  #
> 

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
