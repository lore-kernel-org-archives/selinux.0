Subject: RE: mounted file systems
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD01FB7627@blums0008.bluelnk.net>
References: <FB39F4E77226B448BC1388D3BE4E00CD01FB761B@blums0008.bluelnk.net>
	 <1185979048.15215.293.camel@moss-spartans.epoch.ncsc.mil>
	 <FB39F4E77226B448BC1388D3BE4E00CD01FB7623@blums0008.bluelnk.net>
	 <1185980071.15215.312.camel@moss-spartans.epoch.ncsc.mil>
	 <FB39F4E77226B448BC1388D3BE4E00CD01FB7627@blums0008.bluelnk.net>
Content-Type: text/plain
Date: Wed, 01 Aug 2007 11:43:42 -0400
Message-Id: <1185983022.15215.355.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-08-01 at 08:22 -0700, Clarkson, Mike R (US SSA) wrote:
> 
> > -----Original Message-----
> > From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> > Sent: Wednesday, August 01, 2007 7:55 AM
> > To: Clarkson, Mike R (US SSA)
> > Cc: selinux@tycho.nsa.gov
> > Subject: RE: mounted file systems
> > 
> > On Wed, 2007-08-01 at 07:51 -0700, Clarkson, Mike R (US SSA) wrote:
> > > Labeled NFS
> > 
> > Ok, then see the labeled NFS discussions as per the link in my
> previous
> > reply.
> > 
> > At present, there is no labeled NFS support - an effort to provide
> such
> > support is just getting underway.  So you are limited to per-mount
> > labeling granularity client-side.
> 
> In my experience, the granularity on the client-side is per file system,
> rather than per-mount. For instance, multiple mount points into
> subdirectories on the same file system does not allow those mount points
> to have separate labels client-side.

True - they would share the same superblock in that case, and the
context mounts are currently per-superblock rather than per-vfsmount.

Looks like newer nfs has a "nosharecache" mount option (as part of the
new string options) that lets you force it to use separate superblocks,
but likely not supported in RHEL5.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
