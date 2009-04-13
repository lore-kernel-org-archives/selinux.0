Date: Mon, 13 Apr 2009 10:31:29 -0500
From: Nicolas Williams <Nicolas.Williams@sun.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: nfs-discuss@opensolaris.org, labeled-nfs@linux-nfs.org, nfsv4@ietf.org,
        selinux@tycho.nsa.gov, Jarrett Lu <Jarrett.Lu@sun.com>
Subject: Re: [nfsv4] my thoughts on how Labeled NFSv4 draft should move forward
Message-ID: <20090413153129.GQ1500@Sun.COM>
References: <49DA6EF8.1080704@sun.com> <20090410201718.GB1500@Sun.COM> <1239628757.6129.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1239628757.6129.5.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Apr 13, 2009 at 09:19:17AM -0400, Stephen Smalley wrote:
> On Fri, 2009-04-10 at 15:17 -0500, Nicolas Williams wrote:
> > After that long thread on SAAG and a subsequent off-list discussion with
> > Casey (plus my reading Smack documentation) I'm almost ready to reach
> > the following conclusions:
> > 
> >  - We don't need policy agreement for MLS.  Servers have all the
> >    necessary information when comparing labels without reference to a
> >    policy.  However, clients have to be sharing a common MLS policy.
> 
> That is too limiting.  Think coalitions.

I wrote that we don't _need_ policy agreement for MLS, not that we
couldn't use it if it were available.  A subtle distinction, I know :)
But you're right of course, that when label equivalencies come in we
then need policy agreement.

> >    I.e., for DTE we can only have "dumb" servers.
> 
> Why?  While it is certainly true that a given client may be authorized
> to assert numerous discrete domains, that does not mean that a server
> cannot limit a client to a specific set of domains.  That can be modeled
> via a permission check on a label pair and security class, just like
> everything else.

If the set of domains that a policy defines is enormous then it may be
difficult to limit the set of domains that a user@client could
reasonably claim when referring to objects on given file server.  IF
(and this is a big 'if' for me) the number of domains that a user@client
could assert cannot be constrained meaningfully then I don't see the
point of the server enforcing MAC: the server wouldn't be meaningfully
limiting what the client can do, therefore we might as well let the
client enforce MAC.

However, I imagine that much of any DTE policy is local-only -- that it
relates to system components like, say, passwd(1), or to user apps that
won't be straying outside a home directory or a sandbox therein.  If
local-only subsets of a DTE policy can be identified as such, and if
it's possible for the remainder to be shared by a DOI, and if it's
possible to ascertain what domains any user and any client can assert,
then we're back to where we can have a smart server.

Nico
-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
