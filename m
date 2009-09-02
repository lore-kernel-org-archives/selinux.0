MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] libselinux: disable refcounting in the userspace AVC
Date: Wed, 2 Sep 2009 12:35:53 -0400
Message-ID: <06A6610D4F464D4EBEAFBF2C5F86911E01459A64@exchange2.columbia.tresys.com>
In-Reply-To: <1251899679.2785.101.camel@moss-pluto.epoch.ncsc.mil>
References: <4A9DE7FE.9000008@tycho.nsa.gov> <1251892824.2785.83.camel@moss-pluto.epoch.ncsc.mil> <06A6610D4F464D4EBEAFBF2C5F86911E014599D7@exchange2.columbia.tresys.com> <1251899679.2785.101.camel@moss-pluto.epoch.ncsc.mil>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "Eamon Walsh" <ewalsh@tycho.nsa.gov>,
        "SELinux List" <selinux@tycho.nsa.gov>,
        "KaiGai Kohei" <kaigai@kaigai.gr.jp>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> 
> On Wed, 2009-09-02 at 09:35 -0400, Joshua Brindle wrote:
> > > From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> > >
> > > On Tue, 2009-09-01 at 23:35 -0400, Eamon Walsh wrote:
> > > > The userspace AVC currently has refcounted SID's.  This patch
> strips
> > > out
> > > > the refcounting under the following justifications:
> > > >
> > > > 1.  Managing the refcounts by calling sidput() and sidget() as
> > > > appropriate is a difficult and bug-prone task for users of the
> > > library.
> > > >
> > > > 2.  The userspace AVC doesn't currently make use of the
refcounts
> to
> > > > reclaim unused SID's unless avc_cleanup() is explicitly called.
> > > >
> > > > 3.  The kernel itself no longer uses refcounting for it's own
> SID's.
> > >
> > > Just to clarify on this point:  Early on we had discussed
> introducing
> > > refcounting of kernel SIDs to enable reclaiming unused ones, but
> this
> > > became less important once the user/kernel interface was converted
> > from
> > > passing SIDs to passing security contexts.  In that case we were
> > > dealing
> > > with a global (wrt a system) resource and kernel memory, whereas
in
> > the
> > > userspace AVC we are only dealing with a per-object-manager SID
> table
> > > and the application's virtual memory.
> > >
> >
> > So is the purpose of the patch just to remove unnecessary
> complication
> > in the userspace sidtab? Will this affect multithreaded applications
> > that share a sidtab?
> 
> Unnecessary complication for the userspace object managers - they no
> longer have to keep SID refcounts accurate via sidget() and sidput()
> calls when storing SIDs in their data structures.
> 
> No affect on multithreaded apps; they will still work (locking is
> unaffected).
> 
> > IIRC sepostgres reimplemented its sidtab and avc because our current
> one
> > wasn't very friendly to multithread/multiprocess object managers.
> 
> Looking back, I think KaiGai's reasons were:
> - he didn't see benefit to the indirection of the AVC SID table since
> PostgreSQL has to directly manage security contexts for persistent
> labeling,
> - he wanted to enable sharing of the AVC (via shared memory) and the
> netlink thread among all PostgreSQL instances (processes, not just
> threads).
> 
> So I don't think this makes any difference there.
> 

Ok, seems fair.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
