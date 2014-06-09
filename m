Message-ID: <5395B7E9.90304@tycho.nsa.gov>
Date: Mon, 09 Jun 2014 09:34:33 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: dE <de.techno@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: Default context with context mount option.
References: <539477AF.20408@gmail.com>
In-Reply-To: <539477AF.20408@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/08/2014 10:48 AM, dE wrote:
> When a new file is created on a FS which supports security namespace but
> the FS is mounted using context= option, then what will be the context
> of the newly created file on the FS?
> 
> I did exactly this, and next, umount and then mount the FS readonly to
> get the getfattr dump to realize the security namespace is not empty
> (this came as a surprise).
> 
> So, can someone explain what exactly happens in this case?

The kernel lies to you ;)

If SELinux (or another security module that implements the
inode_getsecurity and inode_listsecurity hooks) is enabled, then the
security module gets to report its view of the security.* attributes to
userspace instead of whatever may or may not be stored by the
filesystem.  That allows SELinux to handle such requests even for
filesystems that do not natively support the security.* namespace as
well as remap attribute values as needed to deal with removed types or
conversion from non-MLS to MLS policies or various other situations.
