Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7F1ZCFA008561
	for <selinux@tycho.nsa.gov>; Fri, 14 Aug 2009 21:35:12 -0400
Received: from smtp101.prem.mail.sp1.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id n7F1Yfw5007094
	for <selinux@tycho.nsa.gov>; Sat, 15 Aug 2009 01:34:41 GMT
Message-ID: <4A86105C.4070806@schaufler-ca.com>
Date: Fri, 14 Aug 2009 18:33:16 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "David P. Quigley" <dpquigl@tycho.nsa.gov>, jmorris@namei.org,
        Greg Kroah-Hartman <greg@kroah.com>, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH] Security/sysfs: Enable security xattrs to be set on sysfs
 files, directories, and symlinks.
References: <1247665721-2619-1-git-send-email-dpquigl@tycho.nsa.gov>	 <4A84EF1D.8060408@schaufler-ca.com>	 <1250252411.2422.177.camel@moss-pluto.epoch.ncsc.mil> <1250253651.2422.183.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1250253651.2422.183.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2009-08-14 at 08:20 -0400, Stephen Smalley wrote:
>   
>> ...
>>> + */
>>> +static DEFINE_MUTEX(sysfs_xattr_lock);
>>> +
>>> +static struct sysfs_xattr *new_xattr(const char *name, const void *value,
>>> +					size_t size)
>>> +{
>>> +	struct sysfs_xattr *nxattr;
>>> +	void *nvalue;
>>> +	char *nname;
>>> +
>>> +	nxattr = kzalloc(sizeof(*nxattr), GFP_KERNEL);
>>> +	if (!nxattr)
>>> +		return NULL;
>>> +	nvalue = kzalloc(size, GFP_KERNEL);
>>> +	if (!nvalue) {
>>> +		kfree(nxattr);
>>> +		return NULL;
>>> +	}
>>> +	nname = kzalloc(strlen(name) + 1, GFP_KERNEL);
>>> +	if (!nname) {
>>> +		kfree(nxattr);
>>> +		kfree(nvalue);
>>> +		return NULL;
>>> +	}
>>> +	memcpy(nvalue, value, size);
>>> +	strcpy(nname, name);
>>> +	nxattr->sx_name = nname;
>>> +	nxattr->sx_value = nvalue;
>>> +	nxattr->sx_size = size;
>>>       
>> Storing the name/value pairs here is redundant - the security module
>> already has to store the value in some form (potentially smaller, like a
>> secid + struct in the SELinux case).  This wastes memory.
>>     
>
> Sorry - to clarify, I understand that we have to store a representation
> of the security attribute in the backing data structure so that it can
> be restored later, but that representation should come from the security
> module rather than being the original (name, value, size) triple.  Which
> is what David's patch does - he obtains a secid from the security module
> for storage in the wrapped iattr structure.
>   

Sorry, but I disagree with your assertion. An LSM can do what
it likes with the xattr, but the value sent from userland is
what should be stored.

>>> +
>>> +	return nxattr;
>>> +}
>>> +
>>> +int sysfs_setxattr(struct dentry *dentry, const char *name,
>>> +			const void *value, size_t size, int flags)
>>> +{
>>> +	struct sysfs_dirent *sd = dentry->d_fsdata;
>>> +	struct list_head *xlist;
>>> +	struct sysfs_xattr *nxattr;
>>> +	void *nvalue;
>>> +	int rc = 0;
>>> +
>>> +	/*
>>> +	 * Only support the security namespace.
>>> +	 * Only allow privileged processes to set them.
>>> +	 * It has to be OK with the LSM, if any, as well.
>>> +	 */
>>> +	if (strncmp(name, XATTR_SECURITY_PREFIX,
>>> +			sizeof XATTR_SECURITY_PREFIX - 1))
>>> +		return -ENOTSUPP;
>>> +
>>> +	if (!capable(CAP_SYS_ADMIN))
>>> +		return -EPERM;
>>>       
>> SELinux does not require CAP_SYS_ADMIN to set its attributes, so this
>> breaks its security model.
>>     
>
> And you don't need to apply any permission check here, as it gets
> covered by the security_inode_setxattr() hook in vfs_setxattr() prior to
> invoking i_op->setxattr.
>   

David seemed to think it necessary in an earlier review. I will
have another look.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
