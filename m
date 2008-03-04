Subject: Re: [PATCH 1/1] LSM/SELinux: {get,set}context hooks to access LSM
	security context information.
From: Dave Quigley <dpquigl@tycho.nsa.gov>
To: Chris Wright <chrisw@sous-sol.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>, sds@tycho.nsa.gov,
        jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
In-Reply-To: <20080304231450.GC4416@sequoia.sous-sol.org>
References: <953413.48800.qm@web36611.mail.mud.yahoo.com>
	 <1204670037.14520.121.camel@moss-terrapins.epoch.ncsc.mil>
	 <20080304231450.GC4416@sequoia.sous-sol.org>
Content-Type: text/plain
Date: Tue, 04 Mar 2008 17:51:53 -0500
Message-Id: <1204671113.14520.124.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The hook is inode_getsecid though. This hook is used to get a context
which is the string representation of the security information which is
different functionality.

Dave

On Tue, 2008-03-04 at 15:14 -0800, Chris Wright wrote:
> * Dave Quigley (dpquigl@tycho.nsa.gov) wrote:
> > I don't see anything in Ahmed's patch set that has this kind of
> > functionality.
> 
> I suspect Casey's referring to the inode_getsec.  I think you just need
> to be more clear about the requirements.
> 
> thanks,
> -chris


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
