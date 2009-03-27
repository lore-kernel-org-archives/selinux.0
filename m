Date: Fri, 27 Mar 2009 17:09:23 -0500
From: Nicolas Williams <Nicolas.Williams@sun.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Jarrett Lu <Jarrett.Lu@sun.com>, selinux@tycho.nsa.gov,
        labeled-nfs@linux-nfs.org, nfs-discuss@opensolaris.org, nfsv4@ietf.org
Subject: Re: [Labeled-nfs] [nfsv4] New MAC label support Internet Draft posted to IETF	website
Message-ID: <20090327220923.GC9992@Sun.COM>
References: <1232651815.24537.15.camel@moss-terrapins.epoch.ncsc.mil> <49C9F0E1.1040202@sun.com> <20090325163317.GV9992@Sun.COM> <49CB4A18.3090709@sun.com> <20090326150934.GR9992@Sun.COM> <49CBFB94.6030408@sun.com> <20090327001102.GU9992@Sun.COM> <1238158539.15207.6.camel@localhost.localdomain> <1238160162.15207.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1238160162.15207.19.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Mar 27, 2009 at 09:22:42AM -0400, Stephen Smalley wrote:
> On Fri, 2009-03-27 at 08:55 -0400, Stephen Smalley wrote:
> > You can't represent Type Enforcement via MLS/BLP; TE is strictly more
> > expressive than BLP, not the other way around.  It also has no inherent
> > notion of dominance; the access matrix is explicitly defined and may
> > include intransitive relationships, which are required for integrity
> > goals and guaranteed invocation.

I thought that MLS compartment -> DTE type.  Is that not the case?  I
realize that DTE does not have an inherent notion of dominance, but for
_documents_ (as opposed to operating system- or application-specific
files like /etc/shadow) there surely must be a way to establish
dominance, no?  That seems important to me.

> Also, in the case of SELinux and FMAC, the security context is more than
> just a domain/type; it contains all of the security attributes relevant
> to the security policy model, which in the case of the example security
> server includes a user identity, a role, a domain/type, and a MLS range
> (optionally just a single MLS level in the degenerate case where low ==
> high).  But as far as the protocols are concerned, the entire security
> context is just an opaque string.

My RPCSEC_GSSv3 proposal allows the client to make assertions about the
local process credentials of the process on whose behalf the client is
acting.  Things like identity, group memberships, privileges, audit
context, etcetera.  (Obviously the server has to evaluate what weight to
give those assertions given the client's and the user's authenticated
identities.)

Nico
-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
