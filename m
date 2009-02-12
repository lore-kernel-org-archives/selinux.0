Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1CK3LOd031801
	for <selinux@tycho.nsa.gov>; Thu, 12 Feb 2009 15:03:21 -0500
Subject: Re: [nfsv4] [Labeled-nfs] New MAC label support Internet Draft
 posted to IETF website
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: Nicolas Williams <Nicolas.Williams@sun.com>
Cc: James Morris <jmorris@namei.org>, labeled-nfs@linux-nfs.org,
        selinux@tycho.nsa.gov, nfsv4@ietf.org, nfs-discuss@opensolaris.org
In-Reply-To: <20090212153620.GP9992@Sun.COM>
References: <1232651815.24537.15.camel@moss-terrapins.epoch.ncsc.mil>
	 <4990AD20.3030902@redhat.com>
	 <1234396064.2929.121.camel@moss-terrapins.epoch.ncsc.mil>
	 <alpine.LRH.1.10.0902121205410.17299@tundra.namei.org>
	 <20090212153620.GP9992@Sun.COM>
Content-Type: text/plain
Date: Thu, 12 Feb 2009 15:00:51 -0500
Message-Id: <1234468851.2929.157.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-02-12 at 09:36 -0600, Nicolas Williams wrote:
> On Thu, Feb 12, 2009 at 12:07:31PM +1100, James Morris wrote:
> > On Wed, 11 Feb 2009, David P. Quigley wrote:
> > 
> > > sort of open file handle revocation support. In the past people have
> > > suggested building the client's idea of the label into either the
> > > stateid or some other form of cookie that can be verified by the server.
> > > We explored doing this in the form of an NFSv4 op and while that worked
> > > we are trying to shy away from adding new operations if we can help it.
> 
> The file handle should suffice.  The server can check if the label has
> changed and then return an error.  If need be we could even use volatile
> FHs for this (with the FH being somewhat like a capability).
> 
> > What's wrong with adding new operations?
> 
> In this case a new operation won't help since the server may want to
> perform revocation as early as possible, and waiting for a client to use
> a specific operation is not a good way to achieve that.  If you meant a
> callback operation, sure, but the server needs to know what clients are
> caching open file data and metadata, and right now the server only knows
> about that when clients get delegations.  It might be possible to add a
> callback operation to indicate that access must be re-evaluated but
> without recalling a delegation.
> 
> Nico

We also explored a callback for label change notification. I think we
even have the code lying around for the prototype. It worked but Trond
expressed some concern with how well it would scale. The issue Trond
raised is what happens if you relabel an entire file system from under a
set of NFSv4 clients? I'm not sure how much of a concern this will be
since 1) File relabeling is supposed to be rare and 2) clients will
probably have a small subset of files open. In the event that you do
need to relabel the entire file system on the server it might be a good
idea from an administrative perspective to have your clients remount the
NFS shares and flush whatever caches they have.

Dave


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
