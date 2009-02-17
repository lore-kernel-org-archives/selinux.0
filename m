Date: Tue, 17 Feb 2009 11:00:27 -0600
From: Nicolas Williams <Nicolas.Williams@sun.com>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
Cc: labeled-nfs@linux-nfs.org, selinux@tycho.nsa.gov,
        nfs-discuss@opensolaris.org, nfsv4@ietf.org
Subject: Re: [nfsv4] [Labeled-nfs] New MAC label support Internet Draft posted to IETF website
Message-ID: <20090217170027.GW9992@Sun.COM>
References: <1232651815.24537.15.camel@moss-terrapins.epoch.ncsc.mil> <4990AD20.3030902@redhat.com> <1234396064.2929.121.camel@moss-terrapins.epoch.ncsc.mil> <alpine.LRH.1.10.0902121205410.17299@tundra.namei.org> <20090212153620.GP9992@Sun.COM> <1234468851.2929.157.camel@moss-terrapins.epoch.ncsc.mil> <20090212201152.GB9992@Sun.COM> <1234889450.2929.191.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1234889450.2929.191.camel@moss-terrapins.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Feb 17, 2009 at 11:50:50AM -0500, David P. Quigley wrote:
> So can anyone see of another use for providing a call back that would
> tell a client to flush it's cached changes back to the server and start
> a recovery? It could be a potential solution to large scale relabeling
> on the server but I hesitate to propose it unless it has more than just
> that application. Also aren't callbacks done out of band and if a
> callback channel can't be established the functionality is just dropped?

I don't think that timely revocation, extending to cached data on
clients, is a problem that we need to address for labeling.  It's a
problem in general and one that most users and implementors probably
don't care that much about.  Timely revocation can always be addressed
separately if it becomes sufficiently desirable.  IMO: leave it out of
scope.

Nico
-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
