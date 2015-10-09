From: Paul Moore <pmoore@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-security-module@vger.kernel.org, linux-audit@redhat.com,
 selinux@tycho.nsa.gov, Paul Osmialowski <p.osmialowsk@samsung.com>
Subject: Re: [RFC PATCH v3 5/5] selinux: introduce kdbus access controls
Date: Fri, 09 Oct 2015 11:39:36 -0400
Message-ID: <4505777.oeeaHvkZzq@sifl>
In-Reply-To: <5617D7D6.1090608@tycho.nsa.gov>
References: <20151007230615.7823.74519.stgit@localhost>
 <20151007230848.7823.68726.stgit@localhost> <5617D7D6.1090608@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Friday, October 09, 2015 11:05:58 AM Stephen Smalley wrote:
> On 10/07/2015 07:08 PM, Paul Moore wrote:
> > +static int selinux_kdbus_init_inode(struct inode *inode,
> > +				    const struct cred *creds)
> > +{
> > +	struct inode_security_struct *isec = inode->i_security;
> > +	u32 sid = cred_sid(creds);
> > +
> > +	/* XXX - this is very simple, e.g. no transitions, no special object
> > +	 *       class, etc. since this inode is basically an IPC socket ...
> > +	 *       however, is this too simple?  do we want transitions?  if we
> > +	 *       do, we should do the transition in kdbus_node_init() and not
> > +	 *       here so that endpoint is labeled correctly and not just this
> > +	 *       inode */
> > +
> > +	isec->inode = inode;
> > +	isec->task_sid = sid;
> > +	isec->sid = sid;
> > +	isec->sclass = SECCLASS_FILE;
> > +	isec->initialized = 1;
> 
> These are used for files exposed in the filesystem namespace, unlike
> sockets (sockfs can't be mounted by userspace, and the socket objects
> themselves have their own class, so there is no ambiguity).  Currently
> the only such files that are labeled with the same SID as the associated
> task are /proc files.  So if we label the kdbusfs files with the same
> SID, then you can't allow read/write to kdbusfs nodes owned by another
> task without also exposing its /proc/pid files in the same manner.
> Doubt we want that.  Probably should compute a transition from the task
> SID and the kdbusfs SID.

Okay, that was one of my main concerns; your suggestion makes sense to me.

I'm also thinking that is we do a file transition using the task label and the 
kdbusfs superblock label we should limit it to just the inode label and not 
the kdbus endpoint as I suggested in the comment above (the bit about 
kdbus_node_init()), yes?

-- 
paul moore
security @ redhat
