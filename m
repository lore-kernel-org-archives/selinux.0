Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s96KVTHR004682
 for <selinux@tycho.nsa.gov>; Mon, 6 Oct 2014 16:31:30 -0400
Received: by mail-qa0-f53.google.com with SMTP id v10so4019678qac.40
 for <selinux@tycho.nsa.gov>; Mon, 06 Oct 2014 13:31:37 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: fix inode security list corruption
Date: Mon, 06 Oct 2014 16:31:35 -0400
Message-ID: <10815679.kovQJLmdnJ@sifl>
In-Reply-To: <1412269225-3858-1-git-send-email-sds@tycho.nsa.gov>
References: <1412269225-3858-1-git-send-email-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: shivnandan.k@samsung.com, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thursday, October 02, 2014 01:00:25 PM Stephen Smalley wrote:
> sb_finish_set_opts() can race with inode_free_security()
> when initializing inode security structures for inodes
> created prior to initial policy load or by the filesystem
> during ->mount().   This appears to have always been
> a possible race, but commit 3dc91d4 ("SELinux:  Fix possible
> NULL pointer dereference in selinux_inode_permission()")
> made it more evident by immediately reusing the unioned
> list/rcu element  of the inode security structure for call_rcu()
> upon an inode_free_security().  But the underlying issue
> was already present before that commit as a possible use-after-free
> of isec.
> 
> Shivnandan Kumar reported the list corruption and proposed
> a patch to split the list and rcu elements out of the union
> as separate fields of the inode_security_struct so that setting
> the rcu element would not affect the list element.  However,
> this would merely hide the issue and not truly fix the code.
> 
> This patch instead moves up the deletion of the list entry
> prior to dropping the sbsec->isec_lock initially.  Then,
> if the inode is dropped subsequently, there will be no further
> references to the isec.
> 
> Reported-by: Shivnandan Kumar <shivnandan.k@samsung.com>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks for taking the time to track this down and submit a patch.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index b0e9404..e03bad5 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -481,6 +481,7 @@ next_inode:
>  				list_entry(sbsec->isec_head.next,
>  					   struct inode_security_struct, list);
>  		struct inode *inode = isec->inode;
> +		list_del_init(&isec->list);
>  		spin_unlock(&sbsec->isec_lock);
>  		inode = igrab(inode);
>  		if (inode) {
> @@ -489,7 +490,6 @@ next_inode:
>  			iput(inode);
>  		}
>  		spin_lock(&sbsec->isec_lock);
> -		list_del_init(&isec->list);
>  		goto next_inode;
>  	}
>  	spin_unlock(&sbsec->isec_lock);

-- 
paul moore
www.paul-moore.com
