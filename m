From: David Howells <dhowells@redhat.com>
In-Reply-To: <5582F307.6030005@tycho.nsa.gov>
References: <5582F307.6030005@tycho.nsa.gov>
 <22037.1434644340@warthog.procyon.org.uk>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] SELinux: Create a common helper to determine an inode
 label
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 18 Jun 2015 17:39:01 +0100
Message-ID: <22821.1434645541@warthog.procyon.org.uk>
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

You're right.  In changing between various sorts of dentry and inode I've lost
one of the subtleties.

David
