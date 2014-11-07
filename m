Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sA7M8riU025500
 for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2014 17:08:56 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1791526.rYj1Ea3vWT@sifl>
References: <1791526.rYj1Ea3vWT@sifl>
 <20141105154217.2555.578.stgit@warthog.procyon.org.uk>
 <20141105154248.2555.15813.stgit@warthog.procyon.org.uk>
To: Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH 3/7] SELinux: Stub in copy-up handling
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 07 Nov 2014 22:08:48 +0000
Message-ID: <3177.1415398128@warthog.procyon.org.uk>
Cc: linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 dhowells@redhat.com, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov, linux-fsdevel@vger.kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Paul Moore <paul@paul-moore.com> wrote:

> > +static int selinux_inode_copy_up_xattr(struct dentry *src, struct dentry
> > ...*dst,
> > +				       const char *name, void *value, size_t *size)
> > +{
> > +	if (strcmp(name, XATTR_NAME_SELINUX) == 0)
> > +		return 1; /* Discard */
> 
> I understand that this is just a stub, but I we need to discuss this at some 
> point and I figure better in this patch than elsewhere where it might get 
> lost.
> 
> For the docker, context= mount use case (similar to SELinux/sVirt) dropping 
> the SELinux xattr is probably an okay behavior.  However, I would expect that 
> ultimately this is something we would want to control by policy and/or the 
> presence of a context= label.

The problem is that the label you actually want has already been set and you
have to be careful not to overwrite it.

The other hook (->inode_copy_up) is called first to label the destination
inode - and that has access to the source file also so it can label the
destination with consideration of the attributes on the source.  Normally, the
attributes on the source will be in memory attached to the source inode, I
would imagine.

David
