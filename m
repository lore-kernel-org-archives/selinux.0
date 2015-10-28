Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9S69LBA028642
 for <selinux@tycho.nsa.gov>; Wed, 28 Oct 2015 02:09:21 -0400
Date: Wed, 28 Oct 2015 17:09:10 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH v3 5/7] security: Add hook to invalidate inode security
 labels
In-Reply-To: <1445894128-6765-6-git-send-email-agruenba@redhat.com>
Message-ID: <alpine.LRH.2.20.1510281708280.23621@namei.org>
References: <1445894128-6765-1-git-send-email-agruenba@redhat.com>
 <1445894128-6765-6-git-send-email-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 26 Oct 2015, Andreas Gruenbacher wrote:

> Add a hook to invalidate an inode's security label when the cached
> information becomes invalid.
> 
> Implement the new hook in selinux: set a flag when a security label becomes
> invalid.  When hitting a security label which has been marked as invalid in
> inode_has_perm, try reloading the label.
> 
> If an inode does not have any dentries attached, we cannot reload its
> security label because we cannot use the getxattr inode operation.  In that
> case, continue using the old, invalid label until a dentry becomes
> available.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>


Reviewed-by: James Morris <james.l.morris@oracle.com>

-- 
James Morris
<jmorris@namei.org>
