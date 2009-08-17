Subject: Re: [PATCH] Security/sysfs: Enable security xattrs to be set on
 sysfs files, directories, and symlinks.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>, jmorris@namei.org,
        Greg Kroah-Hartman <greg@kroah.com>, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
In-Reply-To: <4A86105C.4070806@schaufler-ca.com>
References: <1247665721-2619-1-git-send-email-dpquigl@tycho.nsa.gov>
	 <4A84EF1D.8060408@schaufler-ca.com>
	 <1250252411.2422.177.camel@moss-pluto.epoch.ncsc.mil>
	 <1250253651.2422.183.camel@moss-pluto.epoch.ncsc.mil>
	 <4A86105C.4070806@schaufler-ca.com>
Content-Type: text/plain
Date: Mon, 17 Aug 2009 08:01:22 -0400
Message-Id: <1250510482.3629.97.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-08-14 at 18:33 -0700, Casey Schaufler wrote:
> Stephen Smalley wrote:
> > On Fri, 2009-08-14 at 08:20 -0400, Stephen Smalley wrote:
> >   
> >> ...
> >>> + */
> >>> +static DEFINE_MUTEX(sysfs_xattr_lock);
> >>> +
> >>> +static struct sysfs_xattr *new_xattr(const char *name, const void *value,
> >>> +					size_t size)
> >>> +{
> >>> +	struct sysfs_xattr *nxattr;
> >>> +	void *nvalue;
> >>> +	char *nname;
> >>> +
> >>> +	nxattr = kzalloc(sizeof(*nxattr), GFP_KERNEL);
> >>> +	if (!nxattr)
> >>> +		return NULL;
> >>> +	nvalue = kzalloc(size, GFP_KERNEL);
> >>> +	if (!nvalue) {
> >>> +		kfree(nxattr);
> >>> +		return NULL;
> >>> +	}
> >>> +	nname = kzalloc(strlen(name) + 1, GFP_KERNEL);
> >>> +	if (!nname) {
> >>> +		kfree(nxattr);
> >>> +		kfree(nvalue);
> >>> +		return NULL;
> >>> +	}
> >>> +	memcpy(nvalue, value, size);
> >>> +	strcpy(nname, name);
> >>> +	nxattr->sx_name = nname;
> >>> +	nxattr->sx_value = nvalue;
> >>> +	nxattr->sx_size = size;
> >>>       
> >> Storing the name/value pairs here is redundant - the security module
> >> already has to store the value in some form (potentially smaller, like a
> >> secid + struct in the SELinux case).  This wastes memory.
> >>     
> >
> > Sorry - to clarify, I understand that we have to store a representation
> > of the security attribute in the backing data structure so that it can
> > be restored later, but that representation should come from the security
> > module rather than being the original (name, value, size) triple.  Which
> > is what David's patch does - he obtains a secid from the security module
> > for storage in the wrapped iattr structure.
> >   
> 
> Sorry, but I disagree with your assertion. An LSM can do what
> it likes with the xattr, but the value sent from userland is
> what should be stored.

Then you will definitely end up using more memory than David's approach,
as in the Smack case you'll duplicate storage of the text string by both
the filesystem and by the security module, and in the SELinux case the
filesystem will store the full text string and SELinux will store the
struct representation (full string representation is generated on
demand).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
