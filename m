Message-ID: <557F36B5.8040607@gmail.com>
Date: Mon, 15 Jun 2015 23:33:57 +0300
From: Yury <yury.norov@gmail.com>
MIME-Version: 1.0
To: Waiman Long <Waiman.Long@hp.com>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH v3] selinux: reduce locking overhead in
 inode_free_security()
References: <1434388419-14850-1-git-send-email-Waiman.Long@hp.com>
In-Reply-To: <1434388419-14850-1-git-send-email-Waiman.Long@hp.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: Scott J Norton <scott.norton@hp.com>, linux-security-module@vger.kernel.org,
 Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, Douglas Hatch <doug.hatch@hp.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 15.06.2015 20:13, Waiman Long wrote:
> The inode_free_security() function just took the superblock's isec_lock
> before checking and trying to remove the inode security struct from the
> linked list. In many cases, the list was empty and so the lock taking
> is wasteful as no useful work is done. On multi-socket systems with
> a large number of CPUs, there can also be a fair amount of spinlock
> contention on the isec_lock if many tasks are exiting at the same time.
>
> This patch changes the code to check the state of the list first before
> taking the lock and attempting to dequeue it. The list_del_init()
> can be called more than once on the same list with no harm as long
> as they are properly serialized. It should not be possible to have
> inode_free_security() called concurrently with list_add(). For better
> safety, however, we use list_empty_careful() here even though it is
> still not completely safe in case that happens.
>
> Signed-off-by: Waiman Long <Waiman.Long@hp.com>
> ---
>   security/selinux/hooks.c |   17 ++++++++++++++---
>   1 files changed, 14 insertions(+), 3 deletions(-)
>
> v1->v2:
>   - Take out the second list_empty() test inside the lock.
>
> v2->v3:
>   - Fix incorrent comment and commit log message.
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 7dade28..2a99804 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -254,10 +254,21 @@ static void inode_free_security(struct inode *inode)
>   	struct inode_security_struct *isec = inode->i_security;
>   	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
>   
> -	spin_lock(&sbsec->isec_lock);
> -	if (!list_empty(&isec->list))
> +	/*
> +	 * As not all inode security structures are in a list, we check for
> +	 * empty list outside of the lock to make sure that we won't waste
> +	 * time taking a lock doing nothing.
> +	 *
> +	 * The list_del_init() function can be safely called more than once.
> +	 * It should not be possible for this function to be called with
> +	 * concurrent list_add(), but for better safety against future changes
> +	 * in the code, we use list_empty_careful() here.
> +	 */
> +	if (!list_empty_careful(&isec->list)) {
> +		spin_lock(&sbsec->isec_lock);
>   		list_del_init(&isec->list);
> -	spin_unlock(&sbsec->isec_lock);
> +		spin_unlock(&sbsec->isec_lock);
> +	}
>   
>   	/*
>   	 * The inode may still be referenced in a path walk and
Hi Waiman,

If you need my Acked-by, you have it.

BR,
Yury
