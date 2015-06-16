From: David Howells <dhowells@redhat.com>
In-Reply-To: <557ECBC5.7000705@tycho.nsa.gov>
References: <557ECBC5.7000705@tycho.nsa.gov>
 <16216.1417109138@warthog.procyon.org.uk> <545A51CB.6070107@tycho.nsa.gov>
 <20141105154217.2555.578.stgit@warthog.procyon.org.uk>
 <20141105154307.2555.9847.stgit@warthog.procyon.org.uk>
 <8813.1434123054@warthog.procyon.org.uk>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH 5/7] SELinux: Handle opening of a unioned file
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 16 Jun 2015 10:41:36 +0100
Message-ID: <32052.1434447696@warthog.procyon.org.uk>
Cc: linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 dhowells@redhat.com, drquigl <drquigl@tycho.nsa.gov>,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 linux-fsdevel@vger.kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> It looks like commit 415103f9932d45f7927f4b17e3a9a13834cdb9a1 changed
> selinux_inode_init_security()'s handling of SECURITY_FS_USE_MNTPOINT,
> and this change was never propagated to selinux_dentry_init_security().
>  However, that commit also did not update
> security/selinux/hooks.c:may_create()'s logic for computing the new file
> label when checking CREATE permission, and therefore introduced a
> potential inconsistency between the label used for the permission check
> and the label assigned to the inode.
> 
> That's why I suggested that we need a common helper for all three to
> ensure consistency there.

Ah, okay.  I didn't realise selinux_dentry_init_security() wasn't supposed to
be so different.

David
