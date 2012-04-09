Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q39Dgb37007221
	for <selinux@tycho.nsa.gov>; Mon, 9 Apr 2012 09:42:37 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Mon, 09 Apr 2012 09:42:35 -0400
From: David Quigley <selinux@davequigley.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Subodh Nijsure <subodh.nijsure@gmail.com>, <linux-mtd@lists.infradead.org>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-kernel@vger.kernel.org>, Subodh Nijsure <snijsure@grid-net.com>,
        LSM
 <linux-security-module@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] Add security.selinux XATTR support for the UBIFS. Also
 fix couple of bugs in UBIFS extended attribute length calculation.
In-Reply-To: <4F824B4F.8090107@schaufler-ca.com>
References: <1333892851-10758-1-git-send-email-snijsure@grid-net.com>
 <4F824B4F.8090107@schaufler-ca.com>
Message-ID: <e7692a4e693c7250324a647f962b0556@countercultured.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 04/08/2012 22:37, Casey Schaufler wrote:
>> +
>> +size_t
>> +ubifs_security_listxattr(struct dentry *d, char *list, size_t 
>> list_size,
>> +			 const char *name, size_t name_len, int flags)
>> +{
>> +	const int prefix_len = XATTR_SECURITY_PREFIX_LEN;
>> +	const size_t total_len = prefix_len + name_len + 1;
>> +	if (list && total_len <= list_size) {
>> +		memcpy(list, XATTR_SECURITY_PREFIX, prefix_len);
>> +		memcpy(list+prefix_len, name, name_len);
>> +		list[prefix_len + name_len] = '\0';
>> +	}
>> +	return total_len;
>> +}
>> +
>> +
>> +int ubifs_security_getxattr(struct dentry *d, const char *name,
>> +			    void *buffer, size_t size, int flags)
>> +{
>> +	if (strcmp(name, "") == 0)
>> +		return -EINVAL;
>> +	return __ubifs_getxattr(d->d_inode, XATTR_NAME_SELINUX, buffer, 
>> size);
>> +}
>> +
>> +
>> +int ubifs_security_setxattr(struct dentry *d, const char *name,
>> +			    const void *value, size_t size,
>> +			    int flags, int handler_flags)
>> +{
>> +	if (strcmp(name, "") == 0)
>> +		return -EINVAL;
>> +	return __ubifs_setxattr(d->d_inode, XATTR_NAME_SELINUX, value,

More constructively, Casey is right in that you shouldn't be putting 
the SELinux xattr in there. If __ubifs_setxattr is expecting the full 
namespace.name string just pass name down. Otherwise strip off the 
security. and send the remaining porting down to __ubiffs_setxattr.

Dave

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
