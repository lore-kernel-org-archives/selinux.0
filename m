Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9TCAc2C020006
 for <selinux@tycho.nsa.gov>; Thu, 29 Oct 2015 08:10:38 -0400
Date: Thu, 29 Oct 2015 08:10:33 -0400 (EDT)
From: Bob Peterson <rpeterso@redhat.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Steven Whitehouse <swhiteho@redhat.com>, cluster-devel@redhat.com
Message-ID: <1229647109.67349682.1446120633603.JavaMail.zimbra@redhat.com>
In-Reply-To: <1446079635-22462-8-git-send-email-agruenba@redhat.com>
References: <1446079635-22462-1-git-send-email-agruenba@redhat.com>
 <1446079635-22462-8-git-send-email-agruenba@redhat.com>
Subject: Re: [PATCH v4 7/7] gfs2: Invalide security labels of inodes when
 they go invalid
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

----- Original Message -----
> When gfs2 releases the glock of an inode, it must invalidate all
> information cached for that inode, including the page cache and acls.  Use
> the new security_inode_invalidate_secctx hook to also invalidate security
> labels in that case.  These items will be reread from disk when needed
> after reacquiring the glock.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> Cc: Steven Whitehouse <swhiteho@redhat.com>
> Cc: Bob Peterson <rpeterso@redhat.com>
> Cc: cluster-devel@redhat.com
> ---
>  fs/gfs2/glops.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
> index 1f6c9c3..0833076 100644
> --- a/fs/gfs2/glops.c
> +++ b/fs/gfs2/glops.c
> @@ -13,6 +13,7 @@
>  #include <linux/gfs2_ondisk.h>
>  #include <linux/bio.h>
>  #include <linux/posix_acl.h>
> +#include <linux/security.h>
>  
>  #include "gfs2.h"
>  #include "incore.h"
> @@ -262,6 +263,7 @@ static void inode_go_inval(struct gfs2_glock *gl, int
> flags)
>  		if (ip) {
>  			set_bit(GIF_INVALID, &ip->i_flags);
>  			forget_all_cached_acls(&ip->i_inode);
> +			security_inode_invalidate_secctx(&ip->i_inode);
>  			gfs2_dir_hash_inval(ip);
>  		}
>  	}
> --
> 2.5.0
> 
> 
Hi,

Acked-by: Bob Peterson <rpeterso@redhat.com>

Bob Peterson
Red Hat File Systems
