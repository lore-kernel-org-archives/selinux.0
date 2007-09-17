Message-ID: <46EEE8BB.9060505@redhat.com>
Date: Mon, 17 Sep 2007 16:51:07 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov, sgrubb@redhat.com,
        jmorris@namei.org
Subject: Re: rfc: kernel: special enforcing on suid and setgid chmod
References: <1190052090.3413.18.camel@localhost.localdomain> <1190057036.4034.76.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1190057036.4034.76.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> On Mon, 2007-09-17 at 14:01 -0400, Eric Paris wrote:
>> It was mentioned today that it might be useful to split the security
>> check for setting DAC permissions such that the setuid and setgid bits
>> could have special enforcement.  This patch adds two new permissions to
>> the file class and should explicitly check those.  It doesn't do
>> anything for the sticky bit, nor does this patch do anything for setuid
>> and setgid on directories.  Thoughts?
> 
> What's the rationale for it?  How would you use it practically?
> Where do we draw the line for distinctions among different flavors of
> setattr?  What are the implications for similar DAC-related extensions
> elsewhere?
>
I setup an account with a webadmr:webadm_t.  Only allow this user to
become root as webadm_t.  User creates a setuid executable.  Uses some
other flaw to execute this new setuid app to get full root access.

webadmin needs chmod in order to set proper permissions on cgi scripts.




> There is the obvious compatibility concern, which might be offset by
> your handle unknown patch but only if it goes into the kernel and
> policies well before this change does.
> 
>> couple questions:
>>
>> Are their other file types where those bits have meaning other than
>> regular files and directories?
>>
>> Do I/policy people care about these bits on directories? (see man 2
>> stat)
>>
>> Am I allowed to add permissions to the set of common permissions without
>> bumping the policy version number?
> 
> No, it would alter the values of the per-class perms for classes that
> inherit from that common definition.  And we don't have a framework
> today for remapping class/perm values upon such incompatible changes,
> even if you bump the version.  Could be a good way to get you to
> implement dynamic lookup of class/perm values and remapping of them at
> runtime within the kernel ;)
> 
>>   I first thought about adding setuid
>> and setgid to the common set for all files but then figured it would
>> break something.
>>
>> This is uncompiled, untested, untrustworthy,  about the only thing it is
>> not un- of is worthy of a bit of discussion.  If discussions goes well,
>> I'll actually make a tested version of this patch when the userspace
>> people who wanted to make use of it get to it.
>>
>> -Eric
>>
>> ---
>>
>>  security/selinux/hooks.c                     |    9 ++++++++-
>>  security/selinux/include/av_perm_to_string.h |    2 ++
>>  security/selinux/include/av_permissions.h    |    2 ++
>>  3 files changed, 12 insertions(+), 1 deletions(-)
>>
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 3694662..6838e91 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -2273,6 +2273,7 @@ static int selinux_inode_permission(struct inode *inode, int mask,
>>  static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
>>  {
>>  	int rc;
>> +	u32 check = FILE__SETATTR;
>>  
>>  	rc = secondary_ops->inode_setattr(dentry, iattr);
>>  	if (rc)
>> @@ -2281,9 +2282,15 @@ static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
>>  	if (iattr->ia_valid & ATTR_FORCE)
>>  		return 0;
>>  
>> +	if ((iattr->ia_valid & ATTR_MODE) & S_ISREG(dentry->d_inode->i_mode)) {
>> +		if (S_ISUID & iattr->ia_mode)
>> +			check |= FILE__SETUID;
>> +		if (S_ISGID & iattr->ia_mode)
>> +			check |= FILE__SETGID;
>> +	}
>>  	if (iattr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID |
>>  			       ATTR_ATIME_SET | ATTR_MTIME_SET))
>> -		return dentry_has_perm(current, NULL, dentry, FILE__SETATTR);
>> +		return dentry_has_perm(current, NULL, dentry, check);
>>  
>>  	return dentry_has_perm(current, NULL, dentry, FILE__WRITE);
>>  }
>> diff --git a/security/selinux/include/av_perm_to_string.h b/security/selinux/include/av_perm_to_string.h
>> index 049bf69..11a40af 100644
>> --- a/security/selinux/include/av_perm_to_string.h
>> +++ b/security/selinux/include/av_perm_to_string.h
>> @@ -17,6 +17,8 @@
>>     S_(SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, "execute_no_trans")
>>     S_(SECCLASS_FILE, FILE__ENTRYPOINT, "entrypoint")
>>     S_(SECCLASS_FILE, FILE__EXECMOD, "execmod")
>> +   S_(SECCLASS_FILE, FILE__SETUID, "setuid")
>> +   S_(SECCLASS_FILE, FILE__SETGID, "setgid")
>>     S_(SECCLASS_CHR_FILE, CHR_FILE__EXECUTE_NO_TRANS, "execute_no_trans")
>>     S_(SECCLASS_CHR_FILE, CHR_FILE__ENTRYPOINT, "entrypoint")
>>     S_(SECCLASS_CHR_FILE, CHR_FILE__EXECMOD, "execmod")
>> diff --git a/security/selinux/include/av_permissions.h b/security/selinux/include/av_permissions.h
>> index eda89a2..2d28e92 100644
>> --- a/security/selinux/include/av_permissions.h
>> +++ b/security/selinux/include/av_permissions.h
>> @@ -99,6 +99,8 @@
>>  #define FILE__EXECUTE_NO_TRANS                    0x00020000UL
>>  #define FILE__ENTRYPOINT                          0x00040000UL
>>  #define FILE__EXECMOD                             0x00080000UL
>> +#define FILE__SETUID                              0x00100000UL
>> +#define FILE__SETGID                              0x00200000UL
>>  #define LNK_FILE__IOCTL                           0x00000001UL
>>  #define LNK_FILE__READ                            0x00000002UL
>>  #define LNK_FILE__WRITE                           0x00000004UL
>>
>>
>>
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFG7ui7rlYvE4MpobMRAgS7AJ9NdCVwHd/Nq3HR6Z0Yi2AyUjzdqACeN/Vv
T1Y7W2Sep6BYni36kQxI2yc=
=ye8C
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
