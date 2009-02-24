Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1OG6xTT010223
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2009 11:06:59 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id n1OG3UkT022229
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2009 16:03:31 GMT
Subject: Re: [refpolicy] [PATCH v2] refpolicy: Add missing network related
 MLSconstraints
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Paul Moore <paul.moore@hp.com>
Cc: chanson@TrustedCS.com, refpolicy@oss.tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <200902241033.36764.paul.moore@hp.com>
References: <20090220220236.085807734@hp.com>
	 <170D6ABBBA770349AA49582A86FCED15C12FC8@HAVOC.tcs-sec.com>
	 <200902241033.36764.paul.moore@hp.com>
Content-Type: text/plain
Date: Tue, 24 Feb 2009 11:06:45 -0500
Message-Id: <1235491608.31606.13.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-02-24 at 10:33 -0500, Paul Moore wrote:
> On Tuesday 24 February 2009 10:11:56 am chanson@trustedcs.com wrote:
> > Hi Paul,
> >
> > Is there any reason we can't utilize the new interfaces to handle the
> > unlabeled_t lines in the constraints? I'm not a real big fan of putting
> > direct types into the constraints.
> 
> Convention and consistency with the other network constraints.  I suppose this 
> is really a judgment call because what is the real difference between using 
> direct types and simply loading up the types with the MLS 
> overrides/attributes?  The "unlabeled_t" type really is special and it seems 
> cleaner to me to use it directly in the constraints rather than adding a bunch 
> of attributes to it.

There would also be a behavior change with the netif:egress and
node:sendto permissions.  Though I'm not sure it would matter in this
case, I don't think doing something similar for the other two
constraints that currently have explicit unlabeled_t references would
work.  I'm fine with the explicit references for now.  If someone can
make a patch that removes all the explicit references in a reasonable
way, then I'd be interested.

> > > -----Original Message-----
> > > From: refpolicy-bounces@oss.tresys.com
> > > [mailto:refpolicy-bounces@oss.tresys.com] On Behalf Of Paul Moore
> > > Sent: Friday, February 20, 2009 4:03 PM
> > > To: selinux@tycho.nsa.gov; refpolicy@oss.tresys.com
> > > Subject: [refpolicy] [PATCH v2] refpolicy: Add missing
> > > network related MLSconstraints
> > >
> > > Add MLS constraints for several network related access
> > > controls including the new ingress/egress controls and the
> > > older Secmark controls.  Based on the following post to the
> > > SELinux Reference Policy mailing list:
> > >
> > >  * http://oss.tresys.com/pipermail/refpolicy/2009-February/000579.html
> > >
> > > Signed-off-by: Paul Moore <paul.moore@hp.com>
> > >
> > > ---
> > >  policy/mls                   |   45
> > > +++++++++++++++++++++++++++++++++++++++++++
> > >  policy/modules/kernel/mls.if |   42
> > > ++++++++++++++++++++++++++++++++++++++++
> > >  policy/modules/kernel/mls.te |    2 +
> > >  3 files changed, 89 insertions(+)
> > >
> > > Index: refpolicy_svn_repo/policy/mls
> > > ===================================================================
> > > --- refpolicy_svn_repo.orig/policy/mls
> > > +++ refpolicy_svn_repo/policy/mls
> > > @@ -295,8 +295,53 @@ mlsconstrain { netif node } { tcp_send u
> > >  # these access vectors have no MLS restrictions  # node enforce_dest
> > >
> > > +#
> > > +# MLS policy for the network ingress/egress controls #
> > > +
> > > +# the netif ingress/egress ops, the ingress permission is a "write"
> > > +operation # because the subject in this particular case is
> > > the remote
> > > +domain which is # writing data out the network interface which is
> > > +acting as the object mlsconstrain { netif } { ingress }
> > > +	((( l1 dom l2 ) and ( l1 domby h2 )) or
> > > +	 ( t1 == mlsnetinbound ) or
> > > +	 ( t1 == unlabeled_t ));
> > > +mlsconstrain { netif } { egress }
> > > +	((( l1 dom l2 ) and ( l1 domby h2 )) or
> > > +	 ( t1 == mlsnetoutbound ));
> > >
> > > +# the node recvfrom/sendto ops, the recvfrom permission is a "write"
> > > +operation # because the subject in this particular case is
> > > the remote
> > > +domain which is # writing data out the network node which is
> > > acting as
> > > +the object mlsconstrain { node } { recvfrom }
> > > +	((( l1 dom l2 ) and ( l1 domby h2 )) or
> > > +	 ( t1 == mlsnetinbound ) or
> > > +	 ( t1 == unlabeled_t ));
> > > +mlsconstrain { node } { sendto }
> > > +	((( l1 dom l2 ) and ( l1 domby h2 )) or
> > > +	 ( t1 == mlsnetoutbound ));
> > >
> > > +# the forward ops, the forward_in permission is a "write" operation
> > > +because the # subject in this particular case is the remote domain
> > > +which is writing data # to the network with a secmark label,
> > > the object
> > > +in this case mlsconstrain { packet } { forward_in }
> > > +	((( l1 dom l2 ) and ( l1 domby h2 )) or
> > > +	 ( t1 == mlsnetinbound ) or
> > > +	 ( t1 == unlabeled_t ));
> > > +mlsconstrain { packet } { forward_out }
> > > +	((( l1 dom l2 ) and ( l1 domby h2 )) or
> > > +	 ( t1 == mlsnetoutbound ) or
> > > +	 ( t1 == unlabeled_t ));
> > > +
> > > +#
> > > +# MLS policy for the secmark and peer controls #
> > > +
> > > +# the peer/packet recv op
> > > +mlsconstrain { peer packet } { recv }
> > > +	(( l1 dom l2 ) or
> > > +	 (( t1 == mlsnetreadtoclr ) and ( h1 dom l2 )) or
> > > +	 ( t1 == mlsnetread ));
> > >
> > >  #
> > >  # MLS policy for the process class
> > > Index: refpolicy_svn_repo/policy/modules/kernel/mls.if
> > > ===================================================================
> > > --- refpolicy_svn_repo.orig/policy/modules/kernel/mls.if
> > > +++ refpolicy_svn_repo/policy/modules/kernel/mls.if
> > > @@ -332,6 +332,48 @@ interface(`mls_net_write_within_range',`
> > >
> > >  ########################################
> > >  ## <summary>
> > > +##	Make specified domain trusted to
> > > +##	write inbound packets regardless of the
> > > +##	network's or node's MLS range.
> > > +## </summary>
> > > +## <param name="domain">
> > > +##	<summary>
> > > +##	Domain allowed access.
> > > +##	</summary>
> > > +## </param>
> > > +## <rolecap/>
> > > +#
> > > +interface(`mls_net_inbound_all_levels',`
> > > +	gen_require(`
> > > +		attribute mlsnetinbound;
> > > +	')
> > > +
> > > +	typeattribute $1 mlsnetinbound;
> > > +')
> > > +
> > > +########################################
> > > +## <summary>
> > > +##	Make specified domain trusted to
> > > +##	write outbound packets regardless of the
> > > +##	network's or node's MLS range.
> > > +## </summary>
> > > +## <param name="domain">
> > > +##	<summary>
> > > +##	Domain allowed access.
> > > +##	</summary>
> > > +## </param>
> > > +## <rolecap/>
> > > +#
> > > +interface(`mls_net_outbound_all_levels',`
> > > +	gen_require(`
> > > +		attribute mlsnetoutbound;
> > > +	')
> > > +
> > > +	typeattribute $1 mlsnetoutbound;
> > > +')
> > > +
> > > +########################################
> > > +## <summary>
> > >  ##	Make specified domain MLS trusted
> > >  ##	for reading from System V IPC objects
> > >  ##	up to its clearance.
> > > Index: refpolicy_svn_repo/policy/modules/kernel/mls.te
> > > ===================================================================
> > > --- refpolicy_svn_repo.orig/policy/modules/kernel/mls.te
> > > +++ refpolicy_svn_repo/policy/modules/kernel/mls.te
> > > @@ -22,6 +22,8 @@ attribute mlsnetwriteranged;  attribute
> > > mlsnetupgrade;  attribute mlsnetdowngrade;  attribute mlsnetrecvall;
> > > +attribute mlsnetinbound;
> > > +attribute mlsnetoutbound;
> > >
> > >  attribute mlsipcread;
> > >  attribute mlsipcreadtoclr;
> > >
> > > --
> > > paul moore
> > > linux @ hp
> > >
> > > _______________________________________________
> > > refpolicy mailing list
> > > refpolicy@oss.tresys.com
> > > http://oss.tresys.com/mailman/listinfo/refpolicy
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
