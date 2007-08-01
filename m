Subject: RE: mounted file systems
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD01FB7623@blums0008.bluelnk.net>
References: <FB39F4E77226B448BC1388D3BE4E00CD01FB761B@blums0008.bluelnk.net>
	 <1185979048.15215.293.camel@moss-spartans.epoch.ncsc.mil>
	 <FB39F4E77226B448BC1388D3BE4E00CD01FB7623@blums0008.bluelnk.net>
Content-Type: text/plain
Date: Wed, 01 Aug 2007 10:54:31 -0400
Message-Id: <1185980071.15215.312.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-01 at 07:51 -0700, Clarkson, Mike R (US SSA) wrote:
> Labeled NFS

Ok, then see the labeled NFS discussions as per the link in my previous
reply.

At present, there is no labeled NFS support - an effort to provide such
support is just getting underway.  So you are limited to per-mount
labeling granularity client-side.

There was an experimental NFSv3 SELinux implementation, see:
http://www.nsa.gov/selinux/code/download1.cfm
http://www.nsa.gov/selinux/papers/nfsv3-abs.cfm

But that wasn't merged upstream.

> 
> > -----Original Message-----
> > From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> > Sent: Wednesday, August 01, 2007 7:37 AM
> > To: Clarkson, Mike R (US SSA)
> > Cc: selinux@tycho.nsa.gov
> > Subject: Re: mounted file systems
> > 
> > On Wed, 2007-08-01 at 07:30 -0700, Clarkson, Mike R (US SSA) wrote:
> > > Is there any way to maintain a file system's labels, when that file
> > > system is mounted from one SELinux box to another?
> > 
> > Are you talking about labeled NFS?  Or moving a disk from one machine
> to
> > another machine, possibly with different policy?
> > 
> > http://marc.info/?l=selinux&m=118512054912053&w=2
> > 
> > 
> > > My experience is that I can only apply a single label to the entire
> > > mounted file system, so that I lose the diversity of labels that
> existed
> > > on the original file system.
> > >
> > > I'm wondering if there is another approach that would work better or
> if
> > > there are any plans for future support for this.
> > 
> > --
> > Stephen Smalley
> > National Security Agency
> 
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
