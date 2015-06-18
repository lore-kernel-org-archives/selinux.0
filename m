From: David Howells <dhowells@redhat.com>
In-Reply-To: <5582F307.6030005@tycho.nsa.gov>
References: <5582F307.6030005@tycho.nsa.gov>
 <22037.1434644340@warthog.procyon.org.uk>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] SELinux: Create a common helper to determine an inode
 label
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 18 Jun 2015 17:42:20 +0100
Message-ID: <1605.1434645740@warthog.procyon.org.uk>
Cc: linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 dhowells@redhat.com, linux-security-module@vger.kernel.org,
 SELinux <selinux@tycho.nsa.gov>, linux-fsdevel@vger.kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> > +	rc = selinux_determine_inode_label(d_inode(dentry), name,
> 
> Hmmm...previously we were using d_backing_inode(dentry->d_parent) here.

I also think this should probably be d_inode() not d_backing_inode() since
we're being called by the filesystem that owns the dentry being contemplated.

David
