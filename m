Date: Tue, 4 Mar 2008 15:14:51 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Dave Quigley <dpquigl@tycho.nsa.gov>
Cc: Casey Schaufler <casey@schaufler-ca.com>, sds@tycho.nsa.gov,
        jmorris@namei.org, chrisw@sous-sol.org,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/1] LSM/SELinux: {get,set}context hooks to access LSM
	security context information.
Message-ID: <20080304231450.GC4416@sequoia.sous-sol.org>
References: <953413.48800.qm@web36611.mail.mud.yahoo.com> <1204670037.14520.121.camel@moss-terrapins.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1204670037.14520.121.camel@moss-terrapins.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Dave Quigley (dpquigl@tycho.nsa.gov) wrote:
> I don't see anything in Ahmed's patch set that has this kind of
> functionality.

I suspect Casey's referring to the inode_getsec.  I think you just need
to be more clear about the requirements.

thanks,
-chris

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
