Date: Tue, 14 Apr 2009 12:26:24 -0500
From: Nicolas Williams <Nicolas.Williams@sun.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Jarrett Lu <Jarrett.Lu@sun.com>,
        dpquigl@tycho.nsa.gov, labeled-nfs@linux-nfs.org,
        nfs-discuss@opensolaris.org, selinux@tycho.nsa.gov, nfsv4@ietf.org
Subject: Re: [nfsv4] my thoughts on how Labeled NFSv4 draft should move forward
Message-ID: <20090414172624.GE1500@Sun.COM>
References: <49DA6EF8.1080704@sun.com> <20090410201718.GB1500@Sun.COM> <1239628757.6129.5.camel@localhost.localdomain> <49E40ACE.2070002@schaufler-ca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49E40ACE.2070002@schaufler-ca.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Apr 13, 2009 at 09:02:22PM -0700, Casey Schaufler wrote:
> Stephen Smalley wrote:
> >>    I.e., for DTE we can only have "dumb" servers.
> >
> > Why?  While it is certainly true that a given client may be authorized
> > to assert numerous discrete domains, that does not mean that a server
> > cannot limit a client to a specific set of domains.  That can be modeled
> > via a permission check on a label pair and security class, just like
> > everything else.
> 
> I think that the point is that for that to be interesting you need
> to have a significant number of subject-label/object-label/class
> triples from the client available on the server. Additionally, it
> assumes that the object label available to the server is in fact
> the label from that client, not the server, and not a different
> client. Unless you can map the object label on the file, wherever
> it originated, to a label that is appropriate to the client's
> policy. And heaven forbid that the client that "owns" the label
> on the file should change it's policy and reboot. Now what you have
> is at best no mapping, and at worst a mapping that reflects the
> old, no longer considered "secure" policy.

My point was different.

With MLS and Smack there's typically a small number of process labels
that a given user on a given client could claim, and these labels could
be listed in a directory or in the client's and user's cryptographic
credentials.  Therefore the server can simply reject any assertions of
process labels outside the allowable set of labels for the given
user@client.

With DTE there may be an enormous number of domains (process labels),
and since these domains relate to domain transition rules that are very
much local affairs to the client, the server can only trust what the
client says.  Now, I do exagerate since DTE can express MLS-type
policies -- it's possible that there is a small set of domains that a
given user@client could assert meaningfully to a server, in which case
DTE would be on par with MLS and Smack.  The problem lies in identifying
that small set of domains relevant to server-enforced MAC, and making
sure that such small sets of domains exist.

Nico
-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
