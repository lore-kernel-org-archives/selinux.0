Subject: Re: [PATCH 1/1] LSM/SELinux: {get,set}context hooks to access LSM
	security context information.
From: Dave Quigley <dpquigl@tycho.nsa.gov>
To: Chris Wright <chrisw@sous-sol.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>, sds@tycho.nsa.gov,
        jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
In-Reply-To: <1204671113.14520.124.camel@moss-terrapins.epoch.ncsc.mil>
References: <953413.48800.qm@web36611.mail.mud.yahoo.com>
	 <1204670037.14520.121.camel@moss-terrapins.epoch.ncsc.mil>
	 <20080304231450.GC4416@sequoia.sous-sol.org>
	 <1204671113.14520.124.camel@moss-terrapins.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 04 Mar 2008 17:59:48 -0500
Message-Id: <1204671588.14520.127.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-03-04 at 17:51 -0500, Dave Quigley wrote:
> The hook is inode_getsecid though. This hook is used to get a context
> which is the string representation of the security information which is
> different functionality.

The reason why this is needed instead of using inode_getsecurity is
because Casey objected to a hook that allowed you to get the security
suffix for inode_getsecurity. Because of this we added a hook that will
allow a LSM to conglomerate all the security information it wants into
one string and return it. The corresponding hook is used to take this
information and then set it in the inode and on disk.

Dave

> 
> Dave
> 
> On Tue, 2008-03-04 at 15:14 -0800, Chris Wright wrote:
> > * Dave Quigley (dpquigl@tycho.nsa.gov) wrote:
> > > I don't see anything in Ahmed's patch set that has this kind of
> > > functionality.
> > 
> > I suspect Casey's referring to the inode_getsec.  I think you just need
> > to be more clear about the requirements.
> > 
> > thanks,
> > -chris
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
