Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9SDbVs2025867
 for <selinux@tycho.nsa.gov>; Wed, 28 Oct 2015 09:39:10 -0400
Received: by lbbwb3 with SMTP id wb3so5821331lbb.1
 for <selinux@tycho.nsa.gov>; Wed, 28 Oct 2015 06:36:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <562FB274.6080100@tycho.nsa.gov>
References: <1445894128-6765-1-git-send-email-agruenba@redhat.com>
 <1445894128-6765-3-git-send-email-agruenba@redhat.com>
 <562FB274.6080100@tycho.nsa.gov>
Date: Wed, 28 Oct 2015 14:36:51 +0100
Message-ID: <CAHc6FU5n7eh76ryPEVCr6RfBPobytto8o870P-Rara4LJMDCXQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] selinux: Add accessor functions for
 inode->i_security
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: LSM <linux-security-module@vger.kernel.org>, selinux@tycho.nsa.gov,
 ocfs2-devel@oss.oracle.com, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Oct 27, 2015 at 6:20 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 10/26/2015 05:15 PM, Andreas Gruenbacher wrote:
>> @@ -2217,7 +2231,7 @@ static int selinux_bprm_set_creds(struct
>> linux_binprm *bprm)
>>
>>         old_tsec = current_security();
>>         new_tsec = bprm->cred->security;
>> -       isec = inode->i_security;
>> +       isec = dentry_security(bprm->file->f_path.dentry);
>
> IIUC, this could change which inode label gets used when using overlayfs
> (the overlay inode or the underlying inode).  Not sure whether the current
> code is correct for overlayfs (overlayfs + SELinux support still in
> progress).

Okay, let's stick with inode_security, at least for now.

>> @@ -3154,7 +3168,7 @@ out_nofree:
>>   static int selinux_inode_setsecurity(struct inode *inode, const char
>> *name,
>>                                      const void *value, size_t size, int
>> flags)
>>   {
>> -       struct inode_security_struct *isec = inode->i_security;
>> +       struct inode_security_struct *isec = inode_security(inode);
>
> Was it intentional to not do this for selinux_inode_getsecurity() and
> selinux_inode_getsecid()?

These two hooks both pass in a const inode *, so that needs to be
changed first. Then, selinux_inode_getsecurity should obviously use
inode_security.

I'm not really sure about selinux_inode_getsecid though: can it be
call it from a non-sleeping context?

>> @@ -3241,8 +3254,8 @@ int ioctl_has_perm(const struct cred *cred, struct
>> file *file,
>>   {
>>         struct common_audit_data ad;
>>         struct file_security_struct *fsec = file->f_security;
>> -       struct inode *inode = file_inode(file);
>> -       struct inode_security_struct *isec = inode->i_security;
>> +       struct dentry *dentry = file->f_path.dentry;
>> +       struct inode_security_struct *isec = dentry_security(dentry);
>>         struct lsm_ioctlop_audit ioctl;
>>         u32 ssid = cred_sid(cred);
>>         int rc;
>> @@ -3263,7 +3276,7 @@ int ioctl_has_perm(const struct cred *cred, struct
>> file *file,
>>                         goto out;
>>         }
>>
>> -       if (unlikely(IS_PRIVATE(inode)))
>> +       if (unlikely(IS_PRIVATE(dentry->d_inode)))
>>                 return 0;
>>
>>         rc = avc_has_extended_perms(ssid, isec->sid, isec->sclass,
>> @@ -3506,7 +3519,7 @@ static int selinux_file_open(struct file *file,
>> const struct cred *cred)
>>         struct inode_security_struct *isec;
>>
>>         fsec = file->f_security;
>> -       isec = file_inode(file)->i_security;
>> +       isec = dentry_security(file->f_path.dentry);
>
>
> Similarly for these cases, switching from file_inode(file) to
> d_backing_inode(dentry) could affect overlayfs interaction IIUC.

Okay, let's stick with inode_security as well for now.

Thanks,
Andreas
