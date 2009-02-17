Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1HGs9Gr013120
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2009 11:54:09 -0500
Subject: Re: [nfsv4] [Labeled-nfs] New MAC label support Internet Draft
 posted to IETF website
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: Nicolas Williams <Nicolas.Williams@sun.com>
Cc: labeled-nfs@linux-nfs.org, nfs-discuss@opensolaris.org,
        selinux@tycho.nsa.gov, nfsv4@ietf.org
In-Reply-To: <20090212201152.GB9992@Sun.COM>
References: <1232651815.24537.15.camel@moss-terrapins.epoch.ncsc.mil>
	 <4990AD20.3030902@redhat.com>
	 <1234396064.2929.121.camel@moss-terrapins.epoch.ncsc.mil>
	 <alpine.LRH.1.10.0902121205410.17299@tundra.namei.org>
	 <20090212153620.GP9992@Sun.COM>
	 <1234468851.2929.157.camel@moss-terrapins.epoch.ncsc.mil>
	 <20090212201152.GB9992@Sun.COM>
Content-Type: text/plain
Date: Tue, 17 Feb 2009 11:50:50 -0500
Message-Id: <1234889450.2929.191.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-02-12 at 14:11 -0600, Nicolas Williams wrote:
> On Thu, Feb 12, 2009 at 03:00:51PM -0500, David P. Quigley wrote:
> > We also explored a callback for label change notification. I think we
> > even have the code lying around for the prototype. It worked but Trond
> > expressed some concern with how well it would scale. The issue Trond
> > raised is what happens if you relabel an entire file system from under a
> > set of NFSv4 clients? I'm not sure how much of a concern this will be
> 
> Surely it would scale no better and no worse than open file delegation...
> 
> > since 1) File relabeling is supposed to be rare and 2) clients will
> > probably have a small subset of files open. In the event that you do
> 
> Reclassification of data is supposed to be rare, though that may vary a
> lot by environment.  The number of files that may be kept open provides
> a natural limit to how many relabel callbacks will be needed.  (A client
> could OPEN every file at limit cost to itself hoping to overwhelm a
> server, but that's a separate issue.)
> 
> > need to relabel the entire file system on the server it might be a good
> > idea from an administrative perspective to have your clients remount the
> > NFS shares and flush whatever caches they have.
> 
> Well, there's no callback to tell clients to flush all writes and
> remount (or recover).  You could simulate a server reboot and force
> recovery though.
> 
> Nico

So can anyone see of another use for providing a call back that would
tell a client to flush it's cached changes back to the server and start
a recovery? It could be a potential solution to large scale relabeling
on the server but I hesitate to propose it unless it has more than just
that application. Also aren't callbacks done out of band and if a
callback channel can't be established the functionality is just dropped?

Dave


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
