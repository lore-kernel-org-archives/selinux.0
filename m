Date: Thu, 12 Feb 2009 09:36:21 -0600
From: Nicolas Williams <Nicolas.Williams@sun.com>
To: James Morris <jmorris@namei.org>
Cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>, labeled-nfs@linux-nfs.org,
        selinux@tycho.nsa.gov, nfsv4@ietf.org, nfs-discuss@opensolaris.org
Subject: Re: [nfsv4] [Labeled-nfs] New MAC label support Internet Draft posted to IETF website
Message-ID: <20090212153620.GP9992@Sun.COM>
References: <1232651815.24537.15.camel@moss-terrapins.epoch.ncsc.mil> <4990AD20.3030902@redhat.com> <1234396064.2929.121.camel@moss-terrapins.epoch.ncsc.mil> <alpine.LRH.1.10.0902121205410.17299@tundra.namei.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.1.10.0902121205410.17299@tundra.namei.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Feb 12, 2009 at 12:07:31PM +1100, James Morris wrote:
> On Wed, 11 Feb 2009, David P. Quigley wrote:
> 
> > sort of open file handle revocation support. In the past people have
> > suggested building the client's idea of the label into either the
> > stateid or some other form of cookie that can be verified by the server.
> > We explored doing this in the form of an NFSv4 op and while that worked
> > we are trying to shy away from adding new operations if we can help it.

The file handle should suffice.  The server can check if the label has
changed and then return an error.  If need be we could even use volatile
FHs for this (with the FH being somewhat like a capability).

> What's wrong with adding new operations?

In this case a new operation won't help since the server may want to
perform revocation as early as possible, and waiting for a client to use
a specific operation is not a good way to achieve that.  If you meant a
callback operation, sure, but the server needs to know what clients are
caching open file data and metadata, and right now the server only knows
about that when clients get delegations.  It might be possible to add a
callback operation to indicate that access must be re-evaluated but
without recalling a delegation.

Nico
-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
