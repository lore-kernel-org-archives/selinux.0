Return-Path: <SRS0=dV66=BO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FADC433E0
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 20:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F04A2086A
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 20:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="k9BO0O2C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgHDUvY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:51:24 -0400
Received: from linux.microsoft.com ([13.77.154.182]:35262 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgHDUvY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Aug 2020 16:51:24 -0400
Received: from localhost.localdomain (c-73-172-233-15.hsd1.md.comcast.net [73.172.233.15])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4221420B4908;
        Tue,  4 Aug 2020 13:51:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4221420B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596574282;
        bh=zdPyB5qxmxfR+e2Zx3hMJq0/lyeQO1ZfXJf0pEVQtJw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=k9BO0O2CoVw5cORhvVgXiYAQWHIMHArvpP/hKlI6i+E3qJTHyOVrXKVnl9o6EAXsd
         jzzO7oSwsc0feyo9YAYF9v48ngtWS9YmHey+NYipS9lxOBLI4MI39tK4JChgUpE55K
         CR3TE65ymh4CWXGd+EmQ3+TRorNx/7o86n5/Z650=
Subject: Re: [RFC PATCH] selinux: move policy commit after updating selinuxfs
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        paul@paul-moore.com
Cc:     omosnace@redhat.com, selinux@vger.kernel.org
References: <20200804135352.5650-1-stephen.smalley.work@gmail.com>
From:   Daniel Burgener <dburgener@linux.microsoft.com>
Message-ID: <88c312b3-0abd-96ed-35c3-a80ab57a9fe3@linux.microsoft.com>
Date:   Tue, 4 Aug 2020 16:51:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200804135352.5650-1-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 8/4/20 9:53 AM, Stephen Smalley wrote:
> With the refactoring of the policy load logic in the security
> server from the previous change, it is now possible to split out
> the committing of the new policy from security_load_policy() and
> perform it only after successful updating of selinuxfs.  Change
> security_load_policy() to return the newly populated policy
> data structures to the caller, export selinux_policy_commit()
> for external callers, and introduce selinux_policy_cancel() to
> provide a way to cancel the policy load in the event of an error
> during updating of the selinuxfs directory tree.  Further, rework
> the interfaces used by selinuxfs to get information from the policy
> when creating the new directory tree to take and act upon the
> new policy data structure rather than the current/active policy.
> Update selinuxfs to use these updated and new interfaces.  While
> we are here, stop re-creating the policy_capabilities directory
> on each policy load since it does not depend on the policy, and
> stop trying to create the booleans and classes directories during
> the initial creation of selinuxfs since no information is available
> until first policy load.
>
> After this change, a failure while updating the booleans and class
> directories will cause the entire policy load to be canceled, leaving
> the original policy intact, and policy load notifications to userspace
> will only happen after a successful completion of updating those
> directories.  This does not (yet) provide full atomicity with respect
> to the updating of the directory trees themselves.

I have a patch series to perform the atomic updates very close to done, 
using vfs_rename with RENAME_EXCHANGE to update the directories out of 
tree and then swap them in as discussed earlier.  I've just been doing 
some final style cleanup before sending to the list.  I'll need to 
rebase on top of these changes of course.  I didn't touch any of the 
error recovery portions, so I hope my series will complement this patch 
nicely.

>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> This patch is relative to my previous one,
> https://patchwork.kernel.org/patch/11698505/. Although this does
> not ensure atomicity when updating the selinuxfs directoty tree,
> I suspect it will solve Daniel's original bug because systemd/dbusd
> won't get the policy load notifications until the kernel is done
> updating selinuxfs and therefore won't try to re-read selinuxfs
> in the middle of it (because libselinux caches the class/perm
> mappings and only flushes on a reload).
I agree with your suspicion that this will resolve the bug we've been 
seeing (although only as a result of changing the timing, as you point 
out).  Thanks for your work on this!
>
>   security/selinux/include/conditional.h |  2 +-
>   security/selinux/include/security.h    | 16 ++++-
>   security/selinux/selinuxfs.c           | 69 ++++++++++----------
>   security/selinux/ss/services.c         | 87 +++++++++++++-------------
>   security/selinux/ss/sidtab.c           | 10 +++
>   security/selinux/ss/sidtab.h           |  2 +
>   6 files changed, 106 insertions(+), 80 deletions(-)
>
> diff --git a/security/selinux/include/conditional.h b/security/selinux/include/conditional.h
> index 539ab357707d..b09343346e3f 100644
> --- a/security/selinux/include/conditional.h
> +++ b/security/selinux/include/conditional.h
> @@ -13,7 +13,7 @@
>   
>   #include "security.h"
>   
> -int security_get_bools(struct selinux_state *state,
> +int security_get_bools(struct selinux_policy *policy,
>   		       u32 *len, char ***names, int **values);
>   
>   int security_set_bools(struct selinux_state *state, u32 len, int *values);
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index b0e02cfe3ce1..7fa67bfb2f9f 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -99,6 +99,7 @@ extern const char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX];
>   
>   struct selinux_avc;
>   struct selinux_ss;
> +struct selinux_policy;
>   
>   struct selinux_state {
>   #ifdef CONFIG_SECURITY_SELINUX_DISABLE
> @@ -224,7 +225,12 @@ static inline bool selinux_policycap_genfs_seclabel_symlinks(void)
>   
>   int security_mls_enabled(struct selinux_state *state);
>   int security_load_policy(struct selinux_state *state,
> -			 void *data, size_t len);
> +			void *data, size_t len,
> +			struct selinux_policy **newpolicyp);
> +void selinux_policy_commit(struct selinux_state *state,
> +			struct selinux_policy *newpolicy);
> +void selinux_policy_cancel(struct selinux_state *state,
> +			struct selinux_policy *policy);
>   int security_read_policy(struct selinux_state *state,
>   			 void **data, size_t *len);
>   size_t security_policydb_len(struct selinux_state *state);
> @@ -358,9 +364,9 @@ int security_net_peersid_resolve(struct selinux_state *state,
>   				 u32 xfrm_sid,
>   				 u32 *peer_sid);
>   
> -int security_get_classes(struct selinux_state *state,
> +int security_get_classes(struct selinux_policy *policy,
>   			 char ***classes, int *nclasses);
> -int security_get_permissions(struct selinux_state *state,
> +int security_get_permissions(struct selinux_policy *policy,
>   			     char *class, char ***perms, int *nperms);
>   int security_get_reject_unknown(struct selinux_state *state);
>   int security_get_allow_unknown(struct selinux_state *state);
> @@ -380,6 +386,10 @@ int security_genfs_sid(struct selinux_state *state,
>   		       const char *fstype, char *name, u16 sclass,
>   		       u32 *sid);
>   
> +int selinux_policy_genfs_sid(struct selinux_policy *policy,
> +		       const char *fstype, char *name, u16 sclass,
> +		       u32 *sid);
> +
>   #ifdef CONFIG_NETLABEL
>   int security_netlbl_secattr_to_sid(struct selinux_state *state,
>   				   struct netlbl_lsm_secattr *secattr,
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 4781314c2510..131816878e50 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -346,9 +346,10 @@ static const struct file_operations sel_policyvers_ops = {
>   };
>   
>   /* declaration for sel_write_load */
> -static int sel_make_bools(struct selinux_fs_info *fsi);
> -static int sel_make_classes(struct selinux_fs_info *fsi);
> -static int sel_make_policycap(struct selinux_fs_info *fsi);
> +static int sel_make_bools(struct selinux_fs_info *fsi,
> +			struct selinux_policy *newpolicy);
> +static int sel_make_classes(struct selinux_fs_info *fsi,
> +			struct selinux_policy *newpolicy);
>   
>   /* declaration for sel_make_class_dirs */
>   static struct dentry *sel_make_dir(struct dentry *dir, const char *name,
> @@ -508,28 +509,23 @@ static const struct file_operations sel_policy_ops = {
>   	.llseek		= generic_file_llseek,
>   };
>   
> -static int sel_make_policy_nodes(struct selinux_fs_info *fsi)
> +static int sel_make_policy_nodes(struct selinux_fs_info *fsi,
> +				struct selinux_policy *newpolicy)
>   {
>   	int ret;
>   
> -	ret = sel_make_bools(fsi);
> +	ret = sel_make_bools(fsi, newpolicy);
>   	if (ret) {
>   		pr_err("SELinux: failed to load policy booleans\n");
>   		return ret;
>   	}
>   
> -	ret = sel_make_classes(fsi);
> +	ret = sel_make_classes(fsi, newpolicy);
>   	if (ret) {
>   		pr_err("SELinux: failed to load policy classes\n");
>   		return ret;
>   	}
>   
> -	ret = sel_make_policycap(fsi);
> -	if (ret) {
> -		pr_err("SELinux: failed to load policy capabilities\n");
> -		return ret;
> -	}
> -
>   	return 0;
>   }
>   
> @@ -538,6 +534,7 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
>   
>   {
>   	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
> +	struct selinux_policy *newpolicy;
>   	ssize_t length;
>   	void *data = NULL;
>   
> @@ -563,15 +560,19 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
>   	if (copy_from_user(data, buf, count) != 0)
>   		goto out;
>   
> -	length = security_load_policy(fsi->state, data, count);
> +	length = security_load_policy(fsi->state, data, count, &newpolicy);
>   	if (length) {
>   		pr_warn_ratelimited("SELinux: failed to load policy\n");
>   		goto out;
>   	}
>   
> -	length = sel_make_policy_nodes(fsi);
> -	if (length)
> +	length = sel_make_policy_nodes(fsi, newpolicy);
> +	if (length) {
> +		selinux_policy_cancel(fsi->state, newpolicy);
>   		goto out1;
As things stand as of this patch, I think that this means that in the 
event of a failure in recreating the directories, that directory will be 
left unpopulated or partially populated.  We could even get in a state 
where the booleans directory has already been updated to the new policy 
and the class directory has not.  The full solution is of course atomic 
swapover, which as I mentioned above I hope to submit a series for soon, 
but I wonder if recreating the directories on the old policy would be a 
better interim state?  That probably depends on what sorts of errors are 
possible.  If we've failed because of something about the new policy, 
recreating the old directories should get us back to a good state.  If 
we can't create new directories at all for whatever reason, trying to 
recreate might leave us worse off than before we started.
> +	}
> +
> +	selinux_policy_commit(fsi->state, newpolicy);
>   
>   	length = count;
>   
> @@ -1333,7 +1334,8 @@ static void sel_remove_entries(struct dentry *de)
>   
>   #define BOOL_DIR_NAME "booleans"
>   
> -static int sel_make_bools(struct selinux_fs_info *fsi)
> +static int sel_make_bools(struct selinux_fs_info *fsi,
> +			struct selinux_policy *newpolicy)
>   {
>   	int ret;
>   	ssize_t len;
> @@ -1362,7 +1364,7 @@ static int sel_make_bools(struct selinux_fs_info *fsi)
>   	if (!page)
>   		goto out;
>   
> -	ret = security_get_bools(fsi->state, &num, &names, &values);
> +	ret = security_get_bools(newpolicy, &num, &names, &values);
>   	if (ret)
>   		goto out;
>   
> @@ -1388,7 +1390,7 @@ static int sel_make_bools(struct selinux_fs_info *fsi)
>   		}
>   
>   		isec = selinux_inode(inode);
> -		ret = security_genfs_sid(fsi->state, "selinuxfs", page,
> +		ret = selinux_policy_genfs_sid(newpolicy, "selinuxfs", page,
>   					 SECCLASS_FILE, &sid);
>   		if (ret) {
>   			pr_warn_ratelimited("SELinux: no sid found, defaulting to security isid for %s\n",
> @@ -1791,14 +1793,14 @@ static const struct file_operations sel_policycap_ops = {
>   	.llseek		= generic_file_llseek,
>   };
>   
> -static int sel_make_perm_files(char *objclass, int classvalue,
> -				struct dentry *dir)
> +static int sel_make_perm_files(struct selinux_policy *newpolicy,
> +			char *objclass, int classvalue,
> +			struct dentry *dir)
>   {
> -	struct selinux_fs_info *fsi = dir->d_sb->s_fs_info;
>   	int i, rc, nperms;
>   	char **perms;
>   
> -	rc = security_get_permissions(fsi->state, objclass, &perms, &nperms);
> +	rc = security_get_permissions(newpolicy, objclass, &perms, &nperms);
>   	if (rc)
>   		return rc;
>   
> @@ -1831,8 +1833,9 @@ static int sel_make_perm_files(char *objclass, int classvalue,
>   	return rc;
>   }
>   
> -static int sel_make_class_dir_entries(char *classname, int index,
> -					struct dentry *dir)
> +static int sel_make_class_dir_entries(struct selinux_policy *newpolicy,
> +				char *classname, int index,
> +				struct dentry *dir)
>   {
>   	struct super_block *sb = dir->d_sb;
>   	struct selinux_fs_info *fsi = sb->s_fs_info;
> @@ -1858,12 +1861,13 @@ static int sel_make_class_dir_entries(char *classname, int index,
>   	if (IS_ERR(dentry))
>   		return PTR_ERR(dentry);
>   
> -	rc = sel_make_perm_files(classname, index, dentry);
> +	rc = sel_make_perm_files(newpolicy, classname, index, dentry);
>   
>   	return rc;
>   }
>   
> -static int sel_make_classes(struct selinux_fs_info *fsi)
> +static int sel_make_classes(struct selinux_fs_info *fsi,
> +			struct selinux_policy *newpolicy)
>   {
>   
>   	int rc, nclasses, i;
> @@ -1872,7 +1876,7 @@ static int sel_make_classes(struct selinux_fs_info *fsi)
>   	/* delete any existing entries */
>   	sel_remove_entries(fsi->class_dir);
>   
> -	rc = security_get_classes(fsi->state, &classes, &nclasses);
> +	rc = security_get_classes(newpolicy, &classes, &nclasses);
>   	if (rc)
>   		return rc;
>   
> @@ -1890,7 +1894,7 @@ static int sel_make_classes(struct selinux_fs_info *fsi)
>   		}
>   
>   		/* i+1 since class values are 1-indexed */
> -		rc = sel_make_class_dir_entries(classes[i], i + 1,
> +		rc = sel_make_class_dir_entries(newpolicy, classes[i], i + 1,
>   				class_name_dir);
>   		if (rc)
>   			goto out;
> @@ -1909,8 +1913,6 @@ static int sel_make_policycap(struct selinux_fs_info *fsi)
>   	struct dentry *dentry = NULL;
>   	struct inode *inode = NULL;
>   
> -	sel_remove_entries(fsi->policycap_dir);
> -
>   	for (iter = 0; iter <= POLICYDB_CAPABILITY_MAX; iter++) {
>   		if (iter < ARRAY_SIZE(selinux_policycap_names))
>   			dentry = d_alloc_name(fsi->policycap_dir,
> @@ -2075,9 +2077,12 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
>   		goto err;
>   	}
>   
> -	ret = sel_make_policy_nodes(fsi);
> -	if (ret)
> +	ret = sel_make_policycap(fsi);
> +	if (ret) {
> +		pr_err("SELinux: failed to load policy capabilities\n");
>   		goto err;
> +	}
> +
>   	return 0;
>   err:
>   	pr_err("SELinux: %s:  failed while creating inodes\n",
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index adc11d97b3ae..07a41e8db2d3 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2143,8 +2143,18 @@ static void selinux_policy_free(struct selinux_policy *policy)
>   	kfree(policy);
>   }
>   
> -static void selinux_policy_commit(struct selinux_state *state,
> -				struct selinux_policy *newpolicy)
> +void selinux_policy_cancel(struct selinux_state *state,
> +			struct selinux_policy *policy)
> +{
> +
> +	read_lock(&state->ss->policy_rwlock);
> +	sidtab_cancel_convert(&state->ss->policy->sidtab);
> +	read_unlock(&state->ss->policy_rwlock);
> +	selinux_policy_free(policy);
> +}
> +
> +void selinux_policy_commit(struct selinux_state *state,
> +			struct selinux_policy *newpolicy)
>   {
>   	struct selinux_policy *oldpolicy;
>   	u32 seqno;
> @@ -2200,7 +2210,8 @@ static void selinux_policy_commit(struct selinux_state *state,
>    * This function will flush the access vector cache after
>    * loading the new policy.
>    */
> -int security_load_policy(struct selinux_state *state, void *data, size_t len)
> +int security_load_policy(struct selinux_state *state, void *data, size_t len,
> +			struct selinux_policy **newpolicyp)
>   {
>   	struct selinux_policy *newpolicy;
>   	struct sidtab_convert_params convert_params;
> @@ -2230,7 +2241,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
>   
>   	if (!selinux_initialized(state)) {
>   		/* First policy load, so no need to preserve state from old policy */
> -		selinux_policy_commit(state, newpolicy);
> +		*newpolicyp = newpolicy;
>   		return 0;
>   	}
>   
> @@ -2264,7 +2275,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
>   		goto err;
>   	}
>   
> -	selinux_policy_commit(state, newpolicy);
> +	*newpolicyp = newpolicy;
>   	return 0;
>   
>   err:
> @@ -2691,17 +2702,15 @@ int security_get_user_sids(struct selinux_state *state,
>    * Obtain a SID to use for a file in a filesystem that
>    * cannot support xattr or use a fixed labeling behavior like
>    * transition SIDs or task SIDs.
> - *
> - * The caller must acquire the policy_rwlock before calling this function.
>    */
> -static inline int __security_genfs_sid(struct selinux_state *state,
> +static inline int __security_genfs_sid(struct selinux_policy *policy,
>   				       const char *fstype,
>   				       char *path,
>   				       u16 orig_sclass,
>   				       u32 *sid)
>   {
> -	struct policydb *policydb = &state->ss->policy->policydb;
> -	struct sidtab *sidtab = &state->ss->policy->sidtab;
> +	struct policydb *policydb = &policy->policydb;
> +	struct sidtab *sidtab = &policy->sidtab;
>   	int len;
>   	u16 sclass;
>   	struct genfs *genfs;
> @@ -2711,7 +2720,7 @@ static inline int __security_genfs_sid(struct selinux_state *state,
>   	while (path[0] == '/' && path[1] == '/')
>   		path++;
>   
> -	sclass = unmap_class(&state->ss->policy->map, orig_sclass);
> +	sclass = unmap_class(&policy->map, orig_sclass);
>   	*sid = SECINITSID_UNLABELED;
>   
>   	for (genfs = policydb->genfs; genfs; genfs = genfs->next) {
> @@ -2766,11 +2775,22 @@ int security_genfs_sid(struct selinux_state *state,
>   	int retval;
>   
>   	read_lock(&state->ss->policy_rwlock);
> -	retval = __security_genfs_sid(state, fstype, path, orig_sclass, sid);
> +	retval = __security_genfs_sid(state->ss->policy,
> +				fstype, path, orig_sclass, sid);
>   	read_unlock(&state->ss->policy_rwlock);
>   	return retval;
>   }
>   
> +int selinux_policy_genfs_sid(struct selinux_policy *policy,
> +			const char *fstype,
> +			char *path,
> +			u16 orig_sclass,
> +			u32 *sid)
> +{
> +	/* no lock required, policy is not yet accessible by other threads */
> +	return __security_genfs_sid(policy, fstype, path, orig_sclass, sid);
> +}
> +
>   /**
>    * security_fs_use - Determine how to handle labeling for a filesystem.
>    * @sb: superblock in question
> @@ -2806,8 +2826,8 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
>   		}
>   		sbsec->sid = c->sid[0];
>   	} else {
> -		rc = __security_genfs_sid(state, fstype, "/", SECCLASS_DIR,
> -					  &sbsec->sid);
> +		rc = __security_genfs_sid(state->ss->policy, fstype, "/",
> +					SECCLASS_DIR, &sbsec->sid);
>   		if (rc) {
>   			sbsec->behavior = SECURITY_FS_USE_NONE;
>   			rc = 0;
> @@ -2821,23 +2841,14 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
>   	return rc;
>   }
>   
> -int security_get_bools(struct selinux_state *state,
> +int security_get_bools(struct selinux_policy *policy,
>   		       u32 *len, char ***names, int **values)
>   {
>   	struct policydb *policydb;
>   	u32 i;
>   	int rc;
>   
> -	if (!selinux_initialized(state)) {
> -		*len = 0;
> -		*names = NULL;
> -		*values = NULL;
> -		return 0;
> -	}
> -
> -	read_lock(&state->ss->policy_rwlock);
> -
> -	policydb = &state->ss->policy->policydb;
> +	policydb = &policy->policydb;
>   
>   	*names = NULL;
>   	*values = NULL;
> @@ -2868,7 +2879,6 @@ int security_get_bools(struct selinux_state *state,
>   	}
>   	rc = 0;
>   out:
> -	read_unlock(&state->ss->policy_rwlock);
>   	return rc;
>   err:
>   	if (*names) {
> @@ -2957,7 +2967,9 @@ static int security_preserve_bools(struct selinux_state *state,
>   	struct cond_bool_datum *booldatum;
>   	u32 i, nbools = 0;
>   
> -	rc = security_get_bools(state, &nbools, &bnames, &bvalues);
> +	read_lock(&state->ss->policy_rwlock);
> +	rc = security_get_bools(state->ss->policy, &nbools, &bnames, &bvalues);
> +	read_unlock(&state->ss->policy_rwlock);
>   	if (rc)
>   		goto out;
>   	for (i = 0; i < nbools; i++) {
> @@ -3168,21 +3180,13 @@ static int get_classes_callback(void *k, void *d, void *args)
>   	return 0;
>   }
>   
> -int security_get_classes(struct selinux_state *state,
> +int security_get_classes(struct selinux_policy *policy,
>   			 char ***classes, int *nclasses)
>   {
>   	struct policydb *policydb;
>   	int rc;
>   
> -	if (!selinux_initialized(state)) {
> -		*nclasses = 0;
> -		*classes = NULL;
> -		return 0;
> -	}
> -
> -	read_lock(&state->ss->policy_rwlock);
> -
> -	policydb = &state->ss->policy->policydb;
> +	policydb = &policy->policydb;
>   
>   	rc = -ENOMEM;
>   	*nclasses = policydb->p_classes.nprim;
> @@ -3200,7 +3204,6 @@ int security_get_classes(struct selinux_state *state,
>   	}
>   
>   out:
> -	read_unlock(&state->ss->policy_rwlock);
>   	return rc;
>   }
>   
> @@ -3217,16 +3220,14 @@ static int get_permissions_callback(void *k, void *d, void *args)
>   	return 0;
>   }
>   
> -int security_get_permissions(struct selinux_state *state,
> +int security_get_permissions(struct selinux_policy *policy,
>   			     char *class, char ***perms, int *nperms)
>   {
>   	struct policydb *policydb;
>   	int rc, i;
>   	struct class_datum *match;
>   
> -	read_lock(&state->ss->policy_rwlock);
> -
> -	policydb = &state->ss->policy->policydb;
> +	policydb = &policy->policydb;
>   
>   	rc = -EINVAL;
>   	match = symtab_search(&policydb->p_classes, class);
> @@ -3255,11 +3256,9 @@ int security_get_permissions(struct selinux_state *state,
>   		goto err;
>   
>   out:
> -	read_unlock(&state->ss->policy_rwlock);
>   	return rc;
>   
>   err:
> -	read_unlock(&state->ss->policy_rwlock);
>   	for (i = 0; i < *nperms; i++)
>   		kfree((*perms)[i]);
>   	kfree(*perms);
> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index 47be8bcf6bed..4a24ded670af 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -463,6 +463,16 @@ int sidtab_convert(struct sidtab *s, struct sidtab_convert_params *params)
>   	return 0;
>   }
>   
> +void sidtab_cancel_convert(struct sidtab *s)
> +{
> +	unsigned long flags;
> +
> +	/* cancelling policy load - disable live convert of sidtab */
> +	spin_lock_irqsave(&s->lock, flags);
> +	s->convert = NULL;
> +	spin_unlock_irqrestore(&s->lock, flags);
> +}
> +
>   static void sidtab_destroy_entry(struct sidtab_entry *entry)
>   {
>   	context_destroy(&entry->context);
> diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
> index f2a84560b8b3..80c744d07ad6 100644
> --- a/security/selinux/ss/sidtab.h
> +++ b/security/selinux/ss/sidtab.h
> @@ -123,6 +123,8 @@ static inline struct context *sidtab_search_force(struct sidtab *s, u32 sid)
>   
>   int sidtab_convert(struct sidtab *s, struct sidtab_convert_params *params);
>   
> +void sidtab_cancel_convert(struct sidtab *s);
> +
>   int sidtab_context_to_sid(struct sidtab *s, struct context *context, u32 *sid);
>   
>   void sidtab_destroy(struct sidtab *s);


