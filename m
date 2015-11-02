Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tA2Kqqs3004179
 for <selinux@tycho.nsa.gov>; Mon, 2 Nov 2015 15:53:21 -0500
Received: by pasz6 with SMTP id z6so158827041pas.2
 for <selinux@tycho.nsa.gov>; Mon, 02 Nov 2015 12:52:20 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 cluster-devel@redhat.com
Subject: Re: [PATCH v5 0/7] Inode security label invalidation
Date: Mon, 02 Nov 2015 15:52:18 -0500
Message-ID: <14766550.tZlNXTNuDn@sifl>
In-Reply-To: <1446398673-886-1-git-send-email-agruenba@redhat.com>
References: <1446398673-886-1-git-send-email-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sunday, November 01, 2015 06:24:26 PM Andreas Gruenbacher wrote:
> Here is another version of the patch queue to make gfs2 and similar file
> systems work with SELinux.  Previous posting:
> 
>   http://www.spinics.net/lists/selinux/msg17969.html
> 
> Changes since the previous version:
> 
>  * Use inode_security_novalidate instead of inode_security on all the
>    SOCK_INODE(sock) inodes.
> 
> This patch queue is also available here:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/agruen/linux.git selinux-wip
> 
> Thanks,
> Andreas
> 
> Andreas Gruenbacher (7):
>   selinux: Remove unused variable in selinux_inode_init_security
>   security: Make inode argument of inode_getsecurity non-const
>   security: Make inode argument of inode_getsecid non-const
>   selinux: Add accessor functions for inode->i_security
>   security: Add hook to invalidate inode security labels
>   selinux: Revalidate invalid inode security labels
>   gfs2: Invalide security labels of inodes when they go invalid

Thanks for your time and effort on this patchset.

I've accepted all of the patches into my selinux#next queue, these should 
reach linux-next as soon as the merge window closes.

-- 
paul moore
www.paul-moore.com
