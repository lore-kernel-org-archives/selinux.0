Message-ID: <55AFBE85.6010809@tycho.nsa.gov>
Date: Wed, 22 Jul 2015 12:02:13 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Seth Forshee <seth.forshee@canonical.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@parisplace.org>
Subject: Re: [PATCH 6/7] selinux: Ignore security labels on user namespace
 mounts
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
 <1436989569-69582-7-git-send-email-seth.forshee@canonical.com>
 <55A7B055.4050809@tycho.nsa.gov>
In-Reply-To: <55A7B055.4050809@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
Cc: Serge Hallyn <serge.hallyn@canonical.com>,
 James Morris <james.l.morris@oracle.com>, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov, linux-fsdevel@vger.kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/16/2015 09:23 AM, Stephen Smalley wrote:
> On 07/15/2015 03:46 PM, Seth Forshee wrote:
>> Unprivileged users should not be able to supply security labels
>> in filesystems, nor should they be able to supply security
>> contexts in unprivileged mounts. For any mount where s_user_ns is
>> not init_user_ns, force the use of SECURITY_FS_USE_NONE behavior
>> and return EPERM if any contexts are supplied in the mount
>> options.
>>
>> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> 
> I think this is obsoleted by the subsequent discussion, but just for the
> record: this patch would cause the files in the userns mount to be left
> with the "unlabeled" label, and therefore under typical policies,
> completely inaccessible to any process in a confined domain.

The right way to handle this for SELinux would be to automatically use
mountpoint labeling (SECURITY_FS_USE_MNTPOINT, normally set by
specifying a context= mount option), with the sbsec->mntpoint_sid set
from some related object (e.g. the block device file context, as in your
patches for Smack).  That will cause SELinux to use that value instead
of any xattr value from the filesystem and will cause attempts by
userspace to set the security.selinux xattr to fail on that filesystem.
 That is how SELinux normally deals with untrusted filesystems, except
that it is normally specified as a mount option by a trusted mounting
process, whereas in your case you need to automatically set it.

> 
>> ---
>>  security/selinux/hooks.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 459e71ddbc9d..eeb71e45ab82 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -732,6 +732,19 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>>  	    !strcmp(sb->s_type->name, "pstore"))
>>  		sbsec->flags |= SE_SBGENFS;
>>  
>> +	/*
>> +	 * If this is a user namespace mount, no contexts are allowed
>> +	 * on the command line and security labels mus be ignored.
>> +	 */
>> +	if (sb->s_user_ns != &init_user_ns) {
>> +		if (context_sid || fscontext_sid || rootcontext_sid ||
>> +		    defcontext_sid)
>> +			return -EPERM;
>> +		sbsec->behavior = SECURITY_FS_USE_NONE;
>> +		goto out_set_opts;
>> +	}
>> +
>> +
>>  	if (!sbsec->behavior) {
>>  		/*
>>  		 * Determine the labeling behavior to use for this
>> @@ -813,6 +826,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>>  		sbsec->def_sid = defcontext_sid;
>>  	}
>>  
>> +out_set_opts:
>>  	rc = sb_finish_set_opts(sb);
>>  out:
>>  	mutex_unlock(&sbsec->lock);
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
