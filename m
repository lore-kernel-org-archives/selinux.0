Date: Mon, 30 Mar 2009 15:05:06 -0500
From: Nicolas Williams <Nicolas.Williams@sun.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Jarrett Lu <Jarrett.Lu@sun.com>, selinux@tycho.nsa.gov,
        labeled-nfs@linux-nfs.org, nfs-discuss@opensolaris.org, nfsv4@ietf.org
Subject: Re: [Labeled-nfs] [nfsv4] New MAC label support Internet Draft posted to IETF	website
Message-ID: <20090330200505.GE9992@Sun.COM>
References: <49C9F0E1.1040202@sun.com> <20090325163317.GV9992@Sun.COM> <49CB4A18.3090709@sun.com> <20090326150934.GR9992@Sun.COM> <49CBFB94.6030408@sun.com> <20090327001102.GU9992@Sun.COM> <1238158539.15207.6.camel@localhost.localdomain> <1238160162.15207.19.camel@localhost.localdomain> <20090327220923.GC9992@Sun.COM> <1238431908.2484.42.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1238431908.2484.42.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Mar 30, 2009 at 12:51:48PM -0400, Stephen Smalley wrote:
> On Fri, 2009-03-27 at 17:09 -0500, Nicolas Williams wrote:
> > On Fri, Mar 27, 2009 at 09:22:42AM -0400, Stephen Smalley wrote:
> > > On Fri, 2009-03-27 at 08:55 -0400, Stephen Smalley wrote:
> > > > You can't represent Type Enforcement via MLS/BLP; TE is strictly more
> > > > expressive than BLP, not the other way around.  It also has no inherent
> > > > notion of dominance; the access matrix is explicitly defined and may
> > > > include intransitive relationships, which are required for integrity
> > > > goals and guaranteed invocation.
> > 
> > I thought that MLS compartment -> DTE type.  Is that not the case?  I
> > realize that DTE does not have an inherent notion of dominance, but for
> > _documents_ (as opposed to operating system- or application-specific
> > files like /etc/shadow) there surely must be a way to establish
> > dominance, no?  That seems important to me.
> 
> No, there just needs to be a way to establish authorization.  The
> internal logic for determining whether data of a given label is allowed
> to transit over a network interface of a given label is policy-specific
> and shouldn't be limited to the dominance relation.  It can just be
> represented as a permission check on a label pair for a given object
> class, and then the security policy logic can internally decide yes/no
> on that permission based on any combination of the dominance relation,
> the TE access matrix, or any other policy constraints.

OK, good -- that's a local-to-end-points consideration, so we can keep
the use of DTE at the end-to-end application layer and CALIPSO at the IP
layer compatible.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
