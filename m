From: David Howells <dhowells@redhat.com>
In-Reply-To: <5582FB01.9080602@tycho.nsa.gov>
References: <5582FB01.9080602@tycho.nsa.gov>
 <1509.1434645664@warthog.procyon.org.uk>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] SELinux: Create a common helper to determine an inode
 label [ver #2]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 18 Jun 2015 19:22:30 +0100
Message-ID: <5836.1434651750@warthog.procyon.org.uk>
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
> We want d_inode(dentry->d_parent) here.

Aargh.  I forgot to commit it.

David
