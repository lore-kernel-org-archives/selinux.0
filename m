Date: Wed, 1 Apr 2009 12:50:12 -0500
From: Nicolas Williams <Nicolas.Williams@sun.com>
To: Jarrett Lu <Jarrett.Lu@sun.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, labeled-nfs@linux-nfs.org,
        selinux@tycho.nsa.gov, nfs-discuss@opensolaris.org, nfsv4@ietf.org
Subject: Re: [nfsv4] [Labeled-nfs] New MAC label support Internet Draft posted to IETF	website
Message-ID: <20090401175012.GF9992@Sun.COM>
References: <1238160162.15207.19.camel@localhost.localdomain> <49CD06E7.6030802@sun.com> <20090327172632.GA9992@Sun.COM> <49CD2169.3080209@sun.com> <1238434634.2484.90.camel@localhost.localdomain> <49D10FC1.3000103@sun.com> <1238447664.2484.119.camel@localhost.localdomain> <49D1B133.3010907@sun.com> <20090331182851.GG9992@Sun.COM> <49D2E073.3060003@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49D2E073.3060003@sun.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Mar 31, 2009 at 08:33:07PM -0700, Jarrett Lu wrote:
> Nicolas Williams wrote:
> >On Mon, Mar 30, 2009 at 10:59:15PM -0700, Jarrett Lu wrote:
> >  
> >>That's certainly one option. We can say DOI + an opaque field is what we 
> >>will add to NFSv4 protocol. Use the information as you see fit. Going 
> >>    
> >
> >That's what David's I-D and what my RPCSEC_GSSv3 I-D both say now.
> >  
> 
> If we stop here, we don't have much of an interoperability story. I 

I don't agree.  We'd have the same interop story everyone has today
w.r.t. labeling: synchronization of policies is an out-of-band, manual
(automatable) task; no standard protocol nor policy description
language is specified.

Note: I'm not saying that I don't want us to do better.  Rather, I'm
saying that we should consider whether to: a) proceed as now, b) also
separately and independently solve the policy agreement issues, c) make
the labeled NFSv4 work dependent on a solution to the policy agreement
issues.

I'm in favor of (a) and (b), but if we can reach consensus on a sketch
of a policy agreement solution, then I'd be willing to go for (c).

I.e., we should be realistic about what we can accomplish.

> >Signature of security policy is certainly an interesting idea!  But it
> >does require defining a standard security policy description syntax --
> >that's work that I think is well outside what this WG should be working
> >on.  (Also, we'll need hash function agility.)
> >
> >Therefore I think the NFSv4 community should stop at either
> >
> 
> I'm in general agreement with you on this. I am not sure to what extent 
> the extensibility stuff makes sense, e.g. how much may be enough? I 
> guess we need to study more use scenarios. I suspect TE systems may have 
> more challenges in this area, just because security policies on TE 
> systems tend to be more flexible. For example, how many things are 
> critical in order to translate label correctly, OS version, vendor, 
> label parser, security policy file? How likely DTE systems are 
> configured with exact same policy files? Does it make sense that a 
> (harmless) update to security policy file causes label translation 
> failures from that point on?

I've re-thought this a bit.  I think we need the policy agreement parts
to be:

 - provided by authentication mechanisms where possible (PKIX cert
   extensions, Kerberos V authz-data, SAML assertions, ...)

 - exchanged by the client and server via a new operation

The label should remain {DOI #, octet string}.  Clients and servers that
can reach policy agreement via out-of-band mechanisms will need no
authentication mechanism extensions, nor any NFSv4 policy agreement
operations.  Other clients and servers would use whatever policy
agreement mechanism is available to them, preferably authentication
mechanism extensions.

Policy agreement should consist of a sequence of {DOI #, policy encoding
type, hash function algorithm, hash of policy}.  If a client and server
have one common policy for one or more DOIs then they can use those
DOIs.  For all DOIs they don't agree on they'd fail to move bits (or
whatever is the preferred outcome).

> >[comments about where to do what work elided]
> 
> No disagreement here either. At the end of this scoping exercise, we'll 
> hopefully know how big a bite we can chew. I believe the DOI + opaque 
> field may be useful to identical or compatible system under same 
> administrative control. To push David's draft forward, I believe we 
> still need to understand more about how different systems may use the 
> opaque field and decide if it makes sense to propose extensibility 
> fields for future use.

Agreed.

Nico
-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
