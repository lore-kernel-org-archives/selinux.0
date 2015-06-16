From: David Howells <dhowells@redhat.com>
In-Reply-To: <55805AEA.3050407@tycho.nsa.gov>
References: <55805AEA.3050407@tycho.nsa.gov> <557ECBC5.7000705@tycho.nsa.gov>
 <16216.1417109138@warthog.procyon.org.uk> <545A51CB.6070107@tycho.nsa.gov>
 <20141105154217.2555.578.stgit@warthog.procyon.org.uk>
 <20141105154307.2555.9847.stgit@warthog.procyon.org.uk>
 <8813.1434123054@warthog.procyon.org.uk>
 <7332.1434473388@warthog.procyon.org.uk>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH 5/7] SELinux: Handle opening of a unioned file
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 16 Jun 2015 22:34:33 +0100
Message-ID: <16652.1434490473@warthog.procyon.org.uk>
Cc: linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 drquigl <drquigl@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> Why are you talking about file_open()?

Because that's the focus of the patch 5/7 that this comment chain is in
response to.  You said that it should have a common helper with the dentry and
inode init functions.

	Also, would be good to create a common helper for use here, by
	selinux_dentry_init_security(), selinux_inode_init_security(), and
	may_create().  Already some seeming potential for inconsistencies
	there.

Okay, I missed that you'd said may_create() too.  I further assumed that you
meant that selinux_file_open_union() should use the common helper too.

> Until a process writes to the file, we just want to use the lower inode
> label, right?

No.

There are two issues:

 (1) Non-fd accesses to an overlayfs file use the security label on the
     overlay inode, not the lower inode, even before copy up because they go
     through the inode ops of the overlayfs file first.

 (2) I'm told that we want the ability to have a different label on the upper
     file to that on the lower file.  This is trivial in overlayfs since you
     always have an overlay inode off which to hang the security label, but
     tricky with unionmount since you may only have a dentry.

David
