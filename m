Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
From: "Yan, Zheng" <zyan@redhat.com>
In-Reply-To: <e5248747-8aa0-8dcf-8c3c-74d02171be2a@tycho.nsa.gov>
Date: Tue, 26 Jun 2018 23:32:33 +0800
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org,
 paul@paul-moore.com, ceph-devel@vger.kernel.org,
 SELinux <selinux@tycho.nsa.gov>
Message-Id: <B3E18856-E7BC-4015-9DEA-0E4B647BE208@redhat.com>
References: <20180626084306.27511-1-zyan@redhat.com>
 <e5248747-8aa0-8dcf-8c3c-74d02171be2a@tycho.nsa.gov>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH 1/3] selinux: make dentry_init_security() return
 security module name
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



> On Jun 26, 2018, at 21:28, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> On 06/26/2018 04:43 AM, Yan, Zheng wrote:
>> This is preparation for CephFS security label. CephFS's implementation uses
>> dentry_init_security() to get security context before inode is created,
>> then sends open/mkdir/mknod request to MDS, together with security xattr
>> "security.<security module name>"
> 
> Can you describe how your approach compares to the NFSv4 labeling support, and why it requires
> exporting this information from this hook when NFSv4 did not?

NFS client only support single security label, it passes unnamed security context to NFSD. NFSD
stores the security context by calling security_inode_setsecctx().  For selinux, the security context
is stored in xattr ‘security.selinux’. 

CephFS does not exports other filesystems. So It's irrelevant to CephFS which security module is
enabled on the host that runs ceph-mds (counterpart of NFSD) 

Regards
Yan, Zheng

>> 
>> Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
>> ---
>> fs/nfs/nfs4proc.c         | 3 ++-
>> include/linux/lsm_hooks.h | 4 ++--
>> include/linux/security.h  | 9 +++++----
>> security/security.c       | 7 ++++---
>> security/selinux/hooks.c  | 8 ++++++--
>> 5 files changed, 19 insertions(+), 12 deletions(-)
>> 
>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>> index 6dd146885da9..d18a5fb7aec3 100644
>> --- a/fs/nfs/nfs4proc.c
>> +++ b/fs/nfs/nfs4proc.c
>> @@ -122,7 +122,8 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
>> 		return NULL;
>> 
>> 	err = security_dentry_init_security(dentry, sattr->ia_mode,
>> -				&dentry->d_name, (void **)&label->label, &label->len);
>> +				&dentry->d_name,  NULL,
>> +				(void **)&label->label, &label->len);
>> 	if (err == 0)
>> 		return label;
>> 
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index 8f1131c8dd54..e176c2032bdc 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
>> @@ -1476,8 +1476,8 @@ union security_list_options {
>> 					unsigned long *set_kern_flags);
>> 	int (*sb_parse_opts_str)(char *options, struct security_mnt_opts *opts);
>> 	int (*dentry_init_security)(struct dentry *dentry, int mode,
>> -					const struct qstr *name, void **ctx,
>> -					u32 *ctxlen);
>> +					const struct qstr *name, const char **label,
> 
> Seems like "label" could be confusing given that it means something else in the NFSv4 code,
> and what is actually being provided here is the xattr name suffix.
> 
>> +					void **ctx, u32 *ctxlen);
>> 	int (*dentry_create_files_as)(struct dentry *dentry, int mode,
>> 					struct qstr *name,
>> 					const struct cred *old,
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index 63030c85ee19..df2d73998c64 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -246,8 +246,9 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
>> 				unsigned long *set_kern_flags);
>> int security_sb_parse_opts_str(char *options, struct security_mnt_opts *opts);
>> int security_dentry_init_security(struct dentry *dentry, int mode,
>> -					const struct qstr *name, void **ctx,
>> -					u32 *ctxlen);
>> +					const struct qstr *name,
>> +					const char **label,
>> +					void **ctx, u32 *ctxlen);
>> int security_dentry_create_files_as(struct dentry *dentry, int mode,
>> 					struct qstr *name,
>> 					const struct cred *old,
>> @@ -609,8 +610,8 @@ static inline void security_inode_free(struct inode *inode)
>> static inline int security_dentry_init_security(struct dentry *dentry,
>> 						 int mode,
>> 						 const struct qstr *name,
>> -						 void **ctx,
>> -						 u32 *ctxlen)
>> +						 const char **label,
>> +						 void **ctx, u32 *ctxlen)
>> {
>> 	return -EOPNOTSUPP;
>> }
>> diff --git a/security/security.c b/security/security.c
>> index 68f46d849abe..69818d46aa28 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -450,11 +450,12 @@ void security_inode_free(struct inode *inode)
>> }
>> 
>> int security_dentry_init_security(struct dentry *dentry, int mode,
>> -					const struct qstr *name, void **ctx,
>> -					u32 *ctxlen)
>> +					const struct qstr *name,
>> +					const char **label,
>> +					void **ctx, u32 *ctxlen)
>> {
>> 	return call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode,
>> -				name, ctx, ctxlen);
>> +				name, label, ctx, ctxlen);
>> }
>> EXPORT_SYMBOL(security_dentry_init_security);
>> 
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 2b5ee5fbd652..eca3879d9357 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -2985,8 +2985,9 @@ static void selinux_inode_free_security(struct inode *inode)
>> }
>> 
>> static int selinux_dentry_init_security(struct dentry *dentry, int mode,
>> -					const struct qstr *name, void **ctx,
>> -					u32 *ctxlen)
>> +					const struct qstr *name,
>> +					const char **label,
>> +					void **ctx, u32 *ctxlen)
>> {
>> 	u32 newsid;
>> 	int rc;
>> @@ -2998,6 +2999,9 @@ static int selinux_dentry_init_security(struct dentry *dentry, int mode,
>> 	if (rc)
>> 		return rc;
>> 
>> +	if (label)
>> +		*label = XATTR_SELINUX_SUFFIX;
>> +
>> 	return security_sid_to_context(&selinux_state, newsid, (char **)ctx,
>> 				       ctxlen);
>> }
>> 
> 
