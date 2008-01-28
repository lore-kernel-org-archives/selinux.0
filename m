Subject: Re: racoon got dead due to permission lacking
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: Kohei KaiGai <kaigai@ak.jp.nec.com>, dwalsh@redhat.com,
        cpebenito@tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <200801281022.47156.paul.moore@hp.com>
References: <47997296.2010603@ak.jp.nec.com>
	 <1201288630.21288.277.camel@moss-spartans.epoch.ncsc.mil>
	 <1201523550.27244.1.camel@moss-spartans.epoch.ncsc.mil>
	 <200801281022.47156.paul.moore@hp.com>
Content-Type: text/plain
Date: Mon, 28 Jan 2008 10:35:45 -0500
Message-Id: <1201534545.2823.11.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-01-28 at 10:22 -0500, Paul Moore wrote:
> On Monday 28 January 2008 7:32:30 am Stephen Smalley wrote:
> > On Fri, 2008-01-25 at 14:17 -0500, Stephen Smalley wrote:
> > > On Fri, 2008-01-25 at 14:24 +0900, Kohei KaiGai wrote:
> > > > When I tested labeled ipsec, racoon got dead with the following
> > > > messages: (I added some line break for reader's confortable)
> > > >
> > > > | type=AVC msg=audit(1201052881.758:783): avc:  denied  { read }
> > > > |   for  pid=26854 comm="racoon" name="net" dev=proc
> > > > | ino=4026531867 scontext=root:system_r:racoon_t:s0
> > > > |   tcontext=system_u:object_r:proc_t:s0 tclass=dir
> > >
> > > That one is a kernel bug (in 2.6.24).  Should have a fix soon -
> > > patch is being reviewed.
> >
> > Fix upstreamed,
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=co
> >mmit;h=b1aa5301b9f88a4891061650c591fb8fe1c1
> 
> This got pushed to -stable too, right?

James cc'd them on the git pull request.  Haven't seen a reply yet.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
