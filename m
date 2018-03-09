Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w29HHPL1028252
 for <selinux@tycho.nsa.gov>; Fri, 9 Mar 2018 12:17:25 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC04.oob.disa.mil (Postfix) with SMTP id 3zyYwK2KH2z14wTm
 for <selinux@tycho.nsa.gov>; Fri,  9 Mar 2018 17:17:21 +0000 (UTC)
Received: from UPDC3CPA07_EEMSG_MP23.eemsg.mil (unknown [192.168.18.18])
 by UPDCF3IC04.oob.disa.mil (Postfix) with ESMTP id 3zyYwK0chsz14wTk
 for <selinux@tycho.nsa.gov>; Fri,  9 Mar 2018 17:17:21 +0000 (UTC)
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 linux-security-module@vger.kernel.org, jmorris@namei.org
Cc: john.johansen@canonical.com, paul@paul-moore.com, keescook@chromium.org,
 sds@tycho.nsa.gov, selinux@tycho.nsa.gov, SMACK-announce@lists.01.org
References: <d2c25c38-e19d-1e08-8c49-4726a34e72bb@schaufler-ca.com>
 <201803092029.JHB78680.HJOVFFSOtMQFLO@I-love.SAKURA.ne.jp>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <bd21dd72-2dba-d8f4-4a84-65ca66cbc778@schaufler-ca.com>
Date: Fri, 9 Mar 2018 09:17:15 -0800
MIME-Version: 1.0
In-Reply-To: <201803092029.JHB78680.HJOVFFSOtMQFLO@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 0/8] LSM: Security module stacking
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 3/9/2018 3:29 AM, Tetsuo Handa wrote:
> Casey Schaufler wrote:
>> 1/8: Add the smack subdirectory to /proc/.../attr
>> 2/8: Move management of cred security blobs to the LSM infrastructure
>> 3/8: Move management of file security blobs to the LSM infrastructure
>> 4/8: Move management of task security blobs to the LSM infrastructure
>> 5/8: Move management of the remaining security blobs to the LSM infrastructure
>> 6/8: Change the configuration controls for security stacking
>> 7/8: Allow multiple modules to provide mount options
>> 8/8: Maintain and use compound secids instead of a single integer
>>
>> Also available git://github.com/cschaufler/lsm_stacking.git#stacking-4.17
> s/lsm_stacking/lsm-stacking/

Thanks for the correction. I mess that up way to often.

> Is there any objection regarding "LSM: Security module stacking" itself?

Paul Moore has taken a strong position that he wants to see the
complete solution, including the networking bits, before he will
consider it seriously. There is merit to this position, which is
why I haven't been pushing to get incremental portions upstream
so far. With this patch set I believe I have provided that
coverage, and expect the real feedback can begin.

> If no objections, can we use step-by-step changes?

I would expect that with the ultimate direction nailed down
it should be possible to move forward in chunks, with the
infrastructure blob management first, the multiple secids
and mount next, and the networking wrapping it up.

> We are so easily
> overlooking error handler paths because this series is trying to change
> all-at-once.

With the new development complete(ish) I should be able to spend
more time on clean-up. If we can get a general approval on the direction
I expect a flurry of helpful suggestions regarding issues like you
point out below.

> For example, security_inode_alloc() will cause an oops if SELinux is not
> the first module linked to the inode_alloc_security list and an error
> occurred inside the first module, for security_inode_alloc() will call
> selinux_inode_free_security() even if selinux_inode_alloc_security() was
> not called while "struct inode_security_struct" is initialized only when
> selinux_inode_alloc_security() is called. And I don't like fixing it in
> this series or next series, for we will likely overlook somewhere else.

You're right. All the free hooks need additional attention.
There are without a doubt other edge cases lurking out there as well.

>
> ----------------------------------------
> static int inode_alloc_security(struct inode *inode)
> {
> 	struct inode_security_struct *isec = selinux_inode(inode);
> 	u32 sid = current_sid();
>
> 	spin_lock_init(&isec->lock);
> 	INIT_LIST_HEAD(&isec->list);
> 	isec->inode = inode;
> 	isec->sid = SECINITSID_UNLABELED;
> 	isec->sclass = SECCLASS_FILE;
> 	isec->task_sid = sid;
> 	isec->initialized = LABEL_INVALID;
>
> 	return 0;
> }
>
> static int selinux_inode_alloc_security(struct inode *inode)
> {
> 	return inode_alloc_security(inode);
> }
>
> static void inode_free_security(struct inode *inode)
> {
> 	struct inode_security_struct *isec = selinux_inode(inode);
> 	struct superblock_security_struct *sbsec =
> 					selinux_superblock(inode->i_sb);
>
> 	/*
> 	 * As not all inode security structures are in a list, we check for
> 	 * empty list outside of the lock to make sure that we won't waste
> 	 * time taking a lock doing nothing.
> 	 *
> 	 * The list_del_init() function can be safely called more than once.
> 	 * It should not be possible for this function to be called with
> 	 * concurrent list_add(), but for better safety against future changes
> 	 * in the code, we use list_empty_careful() here.
> 	 */
> 	if (!list_empty_careful(&isec->list)) {
> 		spin_lock(&sbsec->isec_lock);
> 		list_del_init(&isec->list);
> 		spin_unlock(&sbsec->isec_lock);
> 	}
> }
>
> static void selinux_inode_free_security(struct inode *inode)
> {
> 	inode_free_security(inode);
> }
>
> int security_inode_alloc(struct inode *inode)
> {
> 	int rc = lsm_inode_alloc(inode);
>
> 	if (unlikely(rc))
> 		return rc;
> 	rc = call_int_hook(inode_alloc_security, 0, inode);
> 	if (unlikely(rc))
> 		security_inode_free(inode);
> 	return rc;
> }
>
> void security_inode_free(struct inode *inode)
> {
> 	integrity_inode_free(inode);
> 	call_void_hook(inode_free_security, inode);
> 	/*
> 	 * The inode may still be referenced in a path walk and
> 	 * a call to security_inode_permission() can be made
> 	 * after inode_free_security() is called. Ideally, the VFS
> 	 * wouldn't do this, but fixing that is a much harder
> 	 * job. For now, simply free the i_security via RCU, and
> 	 * leave the current inode->i_security pointer intact.
> 	 * The inode will be freed after the RCU grace period too.
> 	 */
> 	if (inode->i_security)
> 		call_rcu((struct rcu_head *)inode->i_security,
> 				inode_free_by_rcu);
> }
> ----------------------------------------
>
> What I prefer is to split this series into patches which involve functional
> changes and patches which do not involve functional changes. For example,
> we can apply
>
> -	const struct task_security_struct *tsec = cred->security;
> +	const struct task_security_struct *tsec = selinux_cred(cred);
>
> by using a stub
>
> +#define selinux_cred(cred) ((cred)->security)
>
> and apply
>
>  int security_cred_alloc_blank(struct cred *cred, gfp_t gfp)
>  {
> -	return call_int_hook(cred_alloc_blank, 0, cred, gfp);
> +	int rc = lsm_cred_alloc(cred, gfp);
> +
> +	if (rc)
> +		return rc;
> +
> +	rc = call_int_hook(cred_alloc_blank, 0, cred, gfp);
> +	if (rc)
> +		lsm_cred_free(cred);
> +	return rc;
>  }
>
> by using a stub
>
> +#define lsm_cred_alloc(cred, gfp) 0
> +#define lsm_cred_free(cred, gfp) do { } while(0)
>
> before making other changes. Such stubs will allow each module to asynchronously
> make changes towards the final shape without introducing any runtime overhead
> until a patch which actually enables stacking is applied, reduce overall size of
> subsequent series in order to reduce possibility of overlooking, and make the
> review easier.

That's a lot of overhead. The smaller the patches, the more work
required to make the patch set. You're right that the current patches
are too big. Moving forward I will be providing smaller, easier to
deal with patches. The sheer overhead of rebaseing a large patch set
has slowed down the development considerably. Minions. What I need are
minions.

Oh, and the upcoming SELinux namespace changes are going to be lots
of fun!
