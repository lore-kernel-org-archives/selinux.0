From: David Howells <dhowells@redhat.com>
In-Reply-To: <5582D953.2030209@tycho.nsa.gov>
References: <5582D953.2030209@tycho.nsa.gov>
 <20150618133215.12722.70352.stgit@warthog.procyon.org.uk>
 <20150618133254.12722.33339.stgit@warthog.procyon.org.uk>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH 5/8] SELinux: Stub in copy-up handling
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 18 Jun 2015 17:51:15 +0100
Message-ID: <2213.1434646275@warthog.procyon.org.uk>
Cc: miklos@szeredi.hu, linux-unionfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, dhowells@redhat.com,
 linux-security-module@vger.kernel.org, viro@zeniv.linux.org.uk,
 SELinux <selinux@tycho.nsa.gov>, linux-fsdevel@vger.kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> I'm not sure we never want to copy up the SELinux attribute.  See my
> other email about ecryptfs and supporting per-file labeling and
> consistent access control over the upper and lower inodes.

Yes.  That's why there are two operations. inode_copy_up() should set the
label appropriately and inode_copy_up_xattr() should prevent the label set by
inode_copy_up() from being clobbered.

Note that inode_copy_up() has access to the lower file label and can perform
some sort of incantation to transmute it before applying it.

David
